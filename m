From: Tianwei Zhang <artdream07@gmail.com>
Subject: Uncore event for one process
Date: Tue, 7 Apr 2015 01:57:20 -0400
Message-ID: <78FDB3A8-3F50-43F8-A69D-D7C6A37A2859@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34483 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568AbbDGF5Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 7 Apr 2015 01:57:24 -0400
Received: by qkgx75 with SMTP id x75so42105994qkg.1
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Apr 2015 22:57:23 -0700 (PDT)
Received: from nat-oitwireless-inside-vapornet100-d-15872.princeton.edu (nat-oitwireless-outside-vapornet3-j-245.Princeton.EDU. [140.180.250.1])
        by mx.google.com with ESMTPSA id s36sm4841084qge.1.2015.04.06.22.57.22
        for <linux-perf-users@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 06 Apr 2015 22:57:22 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I want to count the uncore events on a specified process id (Intel Xeon E5-2667
machine). I tried the following perf command to count the CAS_COUNT.RD for process 3460, but it gets stuck with the following output:

#perf stat -e uncore_imc_0/event=0x4,umask=0x3/,uncore_imc_1/event=0x4,umask=0x3/,uncore_imc_2/event=0x4,umask=0x3/,uncore_imc_3/event=0x4,umask=0x3/ -p 3460 sleep 1

Performance counter stats for process id '3460':

                 0 uncore_imc_0/event=0x4,umask=0x3/
                 0 uncore_imc_1/event=0x4,umask=0x3/
                 0 uncore_imc_2/event=0x4,umask=0x3/
                 0 uncore_imc_3/event=0x4,umask=0x3/

       1.000750918 seconds time elapsed

*** glibc detected *** /usr/lib/linux-tools/3.13.0-32-generic/perf: free(): invalid next size (fast): 0x0000000000aaee20 ***
*** glibc detected *** /usr/lib/linux-tools/3.13.0-32-generic/perf: malloc(): memory corruption: 0x0000000000aaf3d0 ***

However, if I switched the perf to the system-wide counting mode, it works:

#perf stat -e uncore_imc_0/event=0x4,umask=0x3/,uncore_imc_1/event=0x4,umask=0x3/,uncore_imc_2/event=0x4,umask=0x3/,uncore_imc_3/event=0x4,umask=0x3/ -a sleep 1

 Performance counter stats for 'system wide':

             4,487 uncore_imc_0/event=0x4,umask=0x3/
             3,721 uncore_imc_1/event=0x4,umask=0x3/
             4,885 uncore_imc_2/event=0x4,umask=0x3/
           212,513 uncore_imc_3/event=0x4,umask=0x3/

       1.000788447 seconds time elapsed

Can anyone help me with this problem?

Thank you very much.

--Tianwei
