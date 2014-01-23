From: Sujith Manoharan <sujith@msujith.org>
Subject: perf lock usage
Date: Thu, 23 Jan 2014 12:19:56 +0530
Message-ID: <21216.48020.60857.22056@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from s72.web-hosting.com ([198.187.29.21]:55940 "EHLO
	s72.web-hosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbaAWGzR (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 23 Jan 2014 01:55:17 -0500
Received: from [117.216.48.16] (port=56798 helo=nako)
	by server72.web-hosting.com with esmtpsa (UNKNOWN:AES128-GCM-SHA256:128)
	(Exim 4.80.1)
	(envelope-from <sujith@msujith.org>)
	id 1W6EBz-0038pu-Qf
	for linux-perf-users@vger.kernel.org; Thu, 23 Jan 2014 01:55:12 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I am trying to use perf lock and am not sure if
the results are correct (the bad rate is 98 %).

Is this expected behavior ?

root@linux-test ~# perf --version
perf version 3.12.0

root@linux-test ~# perf lock record cat /etc/issue
Arch Linux \r (\l)

[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.356 MB perf.data (~15533 samples) ]
root@linux-test ~# perf lock report
                Name   acquired  contended total wait (ns)   max wait (ns)   min wait (ns)

        &cpuctx_lock          0          0               0               0               0
 &sig->cred_guard...          0          0               0               0               0

=== output for debug===

bad: 153, total: 155
bad rate: 98.709677 %
histogram of events caused bad sequence
    acquire: 1
   acquired: 0
  contended: 0
    release: 152

I am using the wireless-testing kernel:
root@linux-test ~# uname -a
Linux linux-test 3.13.0-wl-debug #197 SMP PREEMPT Tue Jan 21 03:19:43 IST 2014 x86_64 GNU/Linux

lockdep is enabled:
root@linux-test ~# zgrep -i lockdep /proc/config.gz
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set


Sujith
