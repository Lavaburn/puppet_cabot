require 'spec_helper'

describe 'host1' do
  Puppet::Util::Log.level = :warning
  Puppet::Util::Log.newdestination(:console)
  
  let(:facts) { {
  	:osfamily 				      => 'Debian',
  	:operatingsystem 		    => 'Ubuntu',
  	:lsbdistid				      => 'Ubuntu',
  	:lsbdistcodename 		    => 'precise',
  	:operatingsystemrelease => '12.04',
  	:concat_basedir  		    => '/tmp', # Concat	 
    :puppetversion          => '3.8.5',
    :virtualenv_version     => '12.0', # Should not matter for spec tests (python dependency)
  } }
    
  context "integrated test" do	  
  	it { should compile.with_all_deps }
  	
  	it { should contain_class('cabot') }
  	it { should contain_ini_setting("cabot_development_PORT").with_value('5000') }
  	it { should contain_ini_setting("cabot_development_GRAPHITE_API").with_value('http://localhost:80/') }
  	it { should contain_ini_setting("cabot_development_HIPCHAT_ALERT_ROOM").with_value('myRoom') }
  	  
    it { should contain_cabot_instance("test_instance_1") }
    it { should contain_cabot_service("test_service_1") }
    it { should contain_cabot_graphite_check("test_check_1") }
  end
end
