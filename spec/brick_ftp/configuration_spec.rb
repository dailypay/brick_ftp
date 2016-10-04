require 'spec_helper'

RSpec.describe BrickFTP::Configuration, type: :lib do
  before do
    allow(ENV).to receive(:[]).with('BRICK_FTP_SUBDOMAIN').and_return('koshigoe')
    allow(ENV).to receive(:[]).with('BRICK_FTP_API_KEY').and_return('APIKEY')
  end

  describe '#initialize' do
    subject { described_class.new }

    it 'set subdomain' do
      expect(subject.subdomain).to eq 'koshigoe'
    end

    it 'set api_key' do
      expect(subject.api_key).to eq 'APIKEY'
    end

    it 'initialize session' do
      expect(subject.session).to be_nil
    end

    it 'set logger' do
      expect(subject.logger).to be_an_instance_of(Logger)
    end

    it 'log level is warn' do
      expect(subject.logger.level).to eq Logger::WARN
    end
  end

  describe '#api_host' do
    subject { described_class.new.api_host }
    it { is_expected.to eq 'koshigoe.brickftp.com' }
  end

  describe '#log_level=' do
    let(:configuration) { described_class.new }
    subject { configuration.log_level = Logger::DEBUG }

    it 'store log_level' do
      expect { subject }.to change(configuration, :log_level).from(Logger::WARN).to(Logger::DEBUG)
    end

    it 'change log level of logger' do
      expect { subject }.to change(configuration.logger, :level).from(Logger::WARN).to(Logger::DEBUG)
    end
  end

  describe '#log_formatter=' do
    let(:configuration) { described_class.new }
    let(:formatter) { Logger::Formatter.new }
    subject { configuration.log_formatter = formatter }

    it 'store log_formatter' do
      expect { subject }.to change(configuration, :log_formatter).to(formatter)
    end

    it 'change log formatter of logger' do
      expect { subject }.to change(configuration.logger, :formatter).to(formatter)
    end
  end
end
