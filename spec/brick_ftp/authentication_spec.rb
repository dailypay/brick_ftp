require 'spec_helper'

RSpec.describe BrickFTP::Authentication, type: :lib do
  describe '.cookie' do
    subject { described_class.cookie(session) }

    let(:session) { BrickFTP::Authentication::Session.new(id: 'xxxxxxxx') }

    it 'return instance of CGI::Cookie' do
      is_expected.to be_an_instance_of CGI::Cookie
    end

    it 'name is BrickFTP' do
      expect(subject.name).to eq 'BrickFTP'
    end

    it 'value is session id' do
      expect(subject.value).to eq %w(xxxxxxxx)
    end
  end

  describe '.login' do
    subject { described_class.login('koshigoe', 'password') }

    it 'call BrickFTP::Authentication::Session.create' do
      expect(BrickFTP::Authentication::Session).to receive(:create).with('koshigoe', 'password')
      subject
    end
  end

  describe '.logout' do
    subject { described_class.logout }

    let(:session) { BrickFTP::Authentication::Session.new(id: 'xxxxxxxx') }

    before { BrickFTP.config.session = session }

    it 'call BrickFTP.config.session.destroy' do
      expect(session).to receive(:destroy)
      subject
    end
  end
end
