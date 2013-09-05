# This Source Code Form is subject to the terms of the Mozilla Public
# # License, v. 2.0. If a copy of the MPL was not distributed with this
# # file, You can obtain one at http://mozilla.org/MPL/2.0/.

#This creates the rlocalpath variable for Windows root home directory. This is needed becuase
#on Windows root is a renamed built in account and may not always recieve the typical home directory.
include Facter::Util::WMI

rootsidquery = "select sid from Win32_UserAccount where name = 'root'"
sidsq = Facter::Util::WMI.execquery(rootsidquery)

        for sidobj in sidsq do
            sidresult = "#{sidobj.sid}"
        end
        $rsid = sidresult

Facter.add("rsid") do
    setcode do
        sidsq = Facter::Util::WMI.execquery(rootsidquery)
        $rsid
    end
end

rootlpquery = "select localpath from Win32_UserProfile where sid = '#{$rsid}'"
Facter.add("rlocalpath") do
    setcode do
        lpq = Facter::Util::WMI.execquery(rootlpquery)
        for lpobj in lpq do
            result = "#{lpobj.LocalPath}"
        end
        result
    end
end
