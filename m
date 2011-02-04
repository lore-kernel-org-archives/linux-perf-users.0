From: Christoph Bartoschek <bartoschek@gmx.de>
Subject: Profiling a program's runtime
Date: Fri, 04 Feb 2011 15:38:53 +0100
Message-ID: <ukft18-pba.ln1@burns.bruehl.pontohonk.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:49458 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863Ab1BDPFH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 4 Feb 2011 10:05:07 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1PlNDd-0005KS-5m
	for linux-perf-users@vger.kernel.org; Fri, 04 Feb 2011 16:05:05 +0100
Received: from bg-1.or.uni-bonn.de ([131.220.141.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Feb 2011 16:05:05 +0100
Received: from bartoschek by bg-1.or.uni-bonn.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Feb 2011 16:05:05 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I would like to get a callgraph for the whole time a program runs. Is this 
possible with perf?

Most profilers I know only show me where the cputime is spent. But I would 
like to know how the wall time is used and in which functions. It's hard for 
me to explain what I mean, therefore I try it with an example.

I have a program that consists basically of three functions:

func_calc() is a computationally intensive function.
func_netw() is a function that reads requests from the network.
func_disk() is a function that writes data to the filesystem.

One execution of the program might last 10 seconds. 5 seconds of the time 
the programms waits for network requests in a call to read(). 3 seconds are 
spent for calculations in func_calc() and 2 seconds pass while the programm 
blocks on the write() requests in func_disk().

Overall the profiler should tell me that 50% of runtime are used by 
func_netw(), 30% are used by func_calc() and 20% are used by func_disk().

Most of the time I want to ignore the time the program spents to wait for 
the scheduler.

How can such a profile be generated with perf?

Christoph
