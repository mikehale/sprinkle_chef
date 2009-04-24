require 'rake'
require 'rake/tasklib'

class VirtualMachineTask < ::Rake::TaskLib
  def initialize(vm_path, vm_name, snapshot_name)
    @vm_path = vm_path
    @vm_name = vm_name
    @snapshot_name = snapshot_name
    
    define
  end
  
  def vmrun(cmd, *args)
    system("#{VMWare::VMRUN} #{cmd.to_s} #{@vm_path} #{args.join(' ')}")
  end
  
  def define
    namespace :vmware do
      namespace @vm_name.to_sym do
        desc "start the vm"
        task :start do
          vmrun(:start)
        end
        namespace :start do
          desc "start the vm with no gui"
          task :nogui do
            vmrun(:start, :nogui)
          end
        end
        
        [:stop, :reset, :suspend].each do |action|
          desc "soft #{action.to_s} the vm"
          task action do
            vmrun(action, :soft)
          end
          namespace action do
            desc "hard #{action.to_s} the vm"
            task :hard do
              vmrun(action, :hard)
            end
          end
        end
        
        [:pause, :unpause].each do |action|
          desc "#{action.to_s} the vm"
          task action do
            vmrun(action)
          end
        end
        
        namespace :snapshot do
          desc "list snapshots"
          task :list do
            vmrun(:listSnapshots)
          end
          
          desc "create snapshot"
          task :create do
            vmrun(:snapshot, @snapshot_name)
          end

          desc "delete snapshot"
          task :delete do
            vmrun(:deleteSnapshot, @snapshot_name)
          end

          desc "revert snapshot"
          task :revert do
            vmrun(:revertToSnapshot, @snapshot_name)
          end
        end

      end
    end
  end
end

class VMWare
  VMRUN = '/Library/Application\ Support/VMware\ Fusion/vmrun'
  
  def initialize(base_dir)
    base_dir = Dir.new(File.expand_path(base_dir))
    available_vms = base_dir.find_all {|e| e =~ /vmwarevm$/}
    available_vms.each do |vm|
      name = vm.gsub('.vmwarevm', '').gsub(/\s+/, '_').downcase
      vm_path = File.join(base_dir.path, vm).gsub(/ /, '\ ')
      VirtualMachineTask.new(vm_path, name, ENV['snapshot_name'])
    end
  end
end

VMWare.new('~/Documents/Virtual Machines.localized')

