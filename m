From: Christoph Bartoschek <bartoschek@gmx.de>
Subject: Re: Profiling a program's runtime
Date: Fri, 04 Feb 2011 18:41:57 +0100
Message-ID: <6cqt18-1lh.ln1@burns.bruehl.pontohonk.de>
References: <ukft18-pba.ln1@burns.bruehl.pontohonk.de> <20110204171604.GB1808@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:46430 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751842Ab1BDRmR (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 4 Feb 2011 12:42:17 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1PlPfi-0004xW-H2
	for linux-perf-users@vger.kernel.org; Fri, 04 Feb 2011 18:42:14 +0100
Received: from bg-1.or.uni-bonn.de ([131.220.141.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Feb 2011 18:42:14 +0100
Received: from bartoschek by bg-1.or.uni-bonn.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Feb 2011 18:42:14 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Frederic Weisbecker wrote:

> 
> If I understood you well, you make a difference between:
> 
> - profiling only the code executed by your task
> - profiling any code executed while your task was existing,
> which includes what happens on other CPUs and other tasks that
> may share the same CPU? Everything in fact?
> 
> So for the case, you just launch:
> 
> perf record -g my_task
> 
> For the second case, use -a for system wide profiling while
> your task exists:
> 
> ./perf record -a -g my_task

I am not interessted in code that is executed in other processes while my 
task exists. 

I want that not only the CPU time is counted that my task uses, but also the 
time my task waits.

For example, if my task waits for network packets in a read() then the time  
should be added to the read() function. Other profilers I know would not 
count the time when the process is blocked.

Christoph
