cmd = "HOME=/home/vagrant delivery job verify default"
cmd <<  ' --server localhost --ent test --org kitchen'
execute cmd do
  cwd '/tmp/repo-data'
  user 'root'
end

execute 'fix perms' do
  command 'chown -R vagrant /home/vagrant/.berkshelf'
end

%w(unit lint syntax publish).each do |phase|
  # TODO: This works on Linux/Unix. Not Windows.
  execute "HOME=/home/vagrant delivery job verify #{phase} --server localhost --ent test --org kitchen" do
    cwd '/tmp/repo-data'
    user 'vagrant'
  end
end
