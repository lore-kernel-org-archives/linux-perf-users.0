From: john smith <whalajam@yahoo.com>
Subject: unresoved function addresses for loadable module
Date: Wed, 23 Mar 2011 11:11:09 -0700 (PDT)
Message-ID: <859170.98017.qm@web161917.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from nm12-vm1.bullet.mail.bf1.yahoo.com ([98.139.213.38]:40494 "HELO
	nm12-vm1.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754946Ab1CWSRr (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 23 Mar 2011 14:17:47 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Please help, I'm trying to get the counters/events for a loadable module but I'm not getting my functions (names) profiled in the output (addresses instead).
I've tried:

perf report --verbose --dso='[module-name]'
perf report -k /usr/src/vmlinux --dso='[module-name]'
(same result as above: perf report -d /usr/src/module-path/module-name.ko)
perf report --sort comm,dso,symbol
perf report -d /usr/src/module-path/module-name.ko --sort comm,dso,symbol

This 'annotate' command produce no output (as symbol is not found):
perf annotate -l -d /usr/src/module-path/module-name.ko -m -s module-function

What are the correct options for 'report' and 'annotate' commands that reports the module's functions? 

Also, there must be an option (not showing in the --help but mentioned in design doc) to selectively record the counters for user or kernel space only,

thanks,
John




      
