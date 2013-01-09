From: Mehul Choube <Mehul_Choube@symantec.com>
Subject: perf report: no output
Date: Wed, 9 Jan 2013 06:24:36 -0800
Message-ID: <E884EC9CD547324B8976A5D37317AC566D1A40D14A@APJ1XCHEVSPIN30.SYMC.SYMANTEC.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from tus1smtoutpex02.symantec.com ([216.10.195.242]:65043 "EHLO
	tus1smtoutpex02.symantec.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757858Ab3AIOYj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 9 Jan 2013 09:24:39 -0500
Received: from [155.64.220.137] (helo=TUS1XCHHUBPIN01.SYMC.SYMANTEC.COM)
	by ecl1mtahubpin01.ges.symantec.com with esmtp (Exim 4.76)
	(envelope-from <Mehul_Choube@symantec.com>)
	id 1Tswa6-0000pS-63
	for linux-perf-users@vger.kernel.org; Wed, 09 Jan 2013 14:24:38 +0000
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Hi,

I am trying perf on SLES 11 SP1 box (virtual machine).

======= terminal output - start =======

sles11sp1:/tmp/pkgs # uname -a
Linux sles11sp1 2.6.32.59-0.3-default-fsl #1 SMP Wed Aug 15 02:00:57 EDT 2012 x86_64 x86_64 x86_64 GNU/Linux

sles11sp1:/tmp/pkgs # rpm -qa | grep 'perf'
perf-2.6.32.12-2.3.9

sles11sp1:/tmp/pkgs # zgrep "_PERF[_= ]" /proc/config.gz 
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_EVENTS=y
CONFIG_PERF_COUNTERS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_CLS_U32_PERF=y

sles11sp1:/tmp/pkgs # cat /proc/sys/kernel/perf_event_paranoid 
-1

sles11sp1:/tmp/pkgs # id
uid=0(root) gid=0(root) groups=0(root)

sles11sp1:/tmp/pkgs # perf record -af -e cycles -- sleep 10
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.242 MB perf.data (~10557 samples) ]

sles11sp1:/tmp/pkgs # du -csh perf.data 
252K    perf.data
252K    total

sles11sp1:/tmp/pkgs # perf report --sort comm,dso
# Samples: 0
#
# Overhead          Command  Shared Object
# ........  ...............  .............
#

======= terminal output - end =======

Please let me know what wrong am doing here?



TIA,
Mehul
