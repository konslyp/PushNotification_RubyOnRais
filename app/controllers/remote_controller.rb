class RemoteController < ApplicationController
  protect_from_forgery prepend: true
  def index
  end

  def serviceConnect
    #@devices = Devices.all()
    if Devices.exists?(:device_id => params['device_id'],:meeting => params['meeting'])
       device = Devices.find_by(device_id: params['device_id'],meeting:params['meeting'])
       device.update(
         meeting: params['meeting'],
         device_token: params['device'],
         connect_status: 1,
         sound_volume: params['volume'],
         device_id: params['device_id'],
       )    
    else
       Devices.create(
         meeting: params['meeting'],
         device_token: params['device'],
         connect_status: 1,
         sound_volume: params['volume'],
         device_id: params['device_id'],
       )
    end
    result = {:code => 200,:message => 'Success'};
    render :json => result
  end

  def serviceDisconnect
    if Devices.exists?(:device_id => params['device_id'],:meeting => params['meeting'])
       device = Devices.find_by(device_id: params['device_id'],meeting:params['meeting'])
       device.update(
         meeting: params['meeting'],
         device_token: params['device'],
         connect_status: 0
       )
    end
    result = {:code => 200,:message => 'Success'};
    render :json => result

  end

  def getDeviceInfo
    if Devices.exists?(:device_id => params['device'],:meeting => params['meeting'])
       device = Devices.find_by(device_id: params['device'],meeting:params['meeting'])
       result = {:code => 200,:message => 'Success',:info=> device};
       render :json => result
       return 
    end
    result = {:code => 400,:message => 'Fail'};
    render :json => result

  end

  def sendPushNotification
    if Devices.exists?(:device_id => params['device'],:meeting => params['meeting'])
       device = Devices.find_by(device_id: params['device'],meeting:params['meeting'])
       fcm = FCM.new("AAAAd2ENcho:APA91bEuDg6Zhid6Y_lbHWCttsYp-EGEIH0pyepVV94ZwQiytes6vo_8-zj7GYUCCTh2_YdR0cTirZkz9G4hXdkZEw3pn9GUwHWjGi8pdqKTLbdzN8MRoL2cK6ZI3mr39yO5hpQrydeu")
       registration_ids= [device['device_token']]
       options = { "notification": {
              "title": "Portugal vs. Denmark",
              "text": "5 to 1"
          },
          data:{volume:params['volume']}
       }
       response = fcm.send(registration_ids, options)
       result = {:code => 200,:message => 'Success',:info=> response};
       render :json => result
       return 
    end
    result = {:code => 400,:message => 'Fail'};
    render :json => result
  end
end
