From: Saumil Merchant <msaumil@gmail.com>
Subject: perf trace timestamps
Date: Fri, 16 Nov 2012 13:07:20 +0000 (UTC)
Message-ID: <loom.20121116T140608-755@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:37542 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751474Ab2KPNJ4 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 16 Nov 2012 08:09:56 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1TZLgK-0004Nv-IZ
	for linux-perf-users@vger.kernel.org; Fri, 16 Nov 2012 14:10:04 +0100
Received: from 122.248.161.59 ([122.248.161.59])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Nov 2012 14:10:04 +0100
Received: from msaumil by 122.248.161.59 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Nov 2012 14:10:04 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,
I am trying to understand the origin of the timestamps in the trace output. 
Here is an example trace of a sample C code.

/> perf sched record -a ./a.out
/> perf script

[ ... ]
a.out 29311 [000] 1746678.549886: sched_stat_runtime: comm=a.out pid=29311
runtime=310028 [ns] vruntime=159246710291986646 [ns]
a.out 29311 [000] 1746678.550885: sched_stat_runtime: comm=a.out pid=29311
runtime=998470 [ns] vruntime=159246710292985116 [ns]
a.out 29311 [000] 1746678.550895: sched_stat_runtime: comm=a.out pid=29311
runtime=11039 [ns] vruntime=159246710292996155 [ns]
[ ... ]

My original impression was that this timestamp (eg, 1746678.550895) would align
with time reported clk_gettime(MONOTONIC,...) function, but it does not. My C
function above prints out timestamps from clk_gettime(MONOTONIC,..)  function
and there is a delta of >15 mins.

Here is the printout on console:
CLKTIME (MONOTONIC):  1748132.102228068

This delta has been varying from 5 mins to 15+ mins.  My objective is to
correlate events in a kernel trace with the execution of our user program.  My
understanding is that both perf and clk_gettime functions on newer x86 systems
use TSC as the clock source and hence I was confused why they do not align.

Can someone please help?

Regards,
Saumil
