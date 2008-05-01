# Backgroundrb
# FIXME: check if data that we are writing to the socket should end with newline
require "pathname"
require "packet" 
require "backgroundrb_merb/bdrb_conn_error"
require "backgroundrb_merb/bdrb_config"
require "backgroundrb_merb/worker_proxy"
require "backgroundrb_merb/merb_worker_proxy" 

BACKGROUNDRB_ROOT = Pathname.new(Merb.root).realpath.to_s

if defined?(Merb::Plugins)

  Merb::BootLoader.before_app_loads do
    MiddleMan = BackgrounDRbMerb::WorkerProxy.init
  end
    
  Merb::Plugins.add_rakefiles "backgroundrb_merb/merbtasks"
end