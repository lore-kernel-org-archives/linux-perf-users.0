From: Rick Jones <rick.jones2@hp.com>
Subject: Memory leak in 3.17.rc6.g09bba1?
Date: Thu, 13 Nov 2014 17:28:15 -0800
Message-ID: <54655AAF.90604@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54]:42853 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933754AbaKNB2Q (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 13 Nov 2014 20:28:16 -0500
Received: from g4t3433.houston.hp.com (g4t3433.houston.hp.com [16.210.25.219])
	by g4t3426.houston.hp.com (Postfix) with ESMTP id 03C6862
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2014 01:28:15 +0000 (UTC)
Received: from [16.103.148.51] (tardy.usa.hp.com [16.103.148.51])
	by g4t3433.houston.hp.com (Postfix) with ESMTP id C16FD81
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2014 01:28:15 +0000 (UTC)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

I am running a command:

perf top -a -g -e skb:kfree_skb

on a laptop running a 3.18.0-rc2+ kernel from davem's net-next tree. 
While that is running I hit the system as the target of a netperf TCP_CC 
test (ie netserver is running on the system where perf is running, and 
netperf is run on another system, pointing at the first).  I then expand 
the kfree_skb() line and the sk_stream_kill_queues  and 
tcp_rcv_state_process lines "within" that expansion.

If I watch with plain "top" in another window I can see the RES value 
for the perf process steadily increasing and also its CPU utlization. 
The latter finally peaks at 100% (this is a core 2 duo laptop).

After about 1800 seconds of being the target of a netperf TCP_CC test 
the RES value for the perf utility is over 1G.

If I wait long enough, perf will finally segfault.

Is this a known issue?  If I should file a more formal bug report 
somewhere let me know.

happy benchmarking,

rick jones

raj@raj-8510w:~$ net-next/tools/perf/perf --version
perf version 3.17.rc6.g09bba1

netperf -t tcp_cc -H <perfsystem> -l 3600

might need to repeat it a few times to get the segfault?
