From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: Profiling a program's runtime
Date: Fri, 4 Feb 2011 18:16:06 +0100
Message-ID: <20110204171604.GB1808@nowhere>
References: <ukft18-pba.ln1@burns.bruehl.pontohonk.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33803 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195Ab1BDRQK (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 4 Feb 2011 12:16:10 -0500
Received: by fxm20 with SMTP id 20so2639335fxm.19
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Feb 2011 09:16:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <ukft18-pba.ln1@burns.bruehl.pontohonk.de>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Christoph Bartoschek <bartoschek@gmx.de>
Cc: linux-perf-users@vger.kernel.org

On Fri, Feb 04, 2011 at 03:38:53PM +0100, Christoph Bartoschek wrote:
> Hi,
> 
> I would like to get a callgraph for the whole time a program runs. Is this 
> possible with perf?
> 
> Most profilers I know only show me where the cputime is spent. But I would 
> like to know how the wall time is used and in which functions. It's hard for 
> me to explain what I mean, therefore I try it with an example.
> 
> I have a program that consists basically of three functions:
> 
> func_calc() is a computationally intensive function.
> func_netw() is a function that reads requests from the network.
> func_disk() is a function that writes data to the filesystem.
> 
> One execution of the program might last 10 seconds. 5 seconds of the time 
> the programms waits for network requests in a call to read(). 3 seconds are 
> spent for calculations in func_calc() and 2 seconds pass while the programm 
> blocks on the write() requests in func_disk().
> 
> Overall the profiler should tell me that 50% of runtime are used by 
> func_netw(), 30% are used by func_calc() and 20% are used by func_disk().
> 
> Most of the time I want to ignore the time the program spents to wait for 
> the scheduler.
> 
> How can such a profile be generated with perf?

If I understood you well, you make a difference between:

- profiling only the code executed by your task
- profiling any code executed while your task was existing,
which includes what happens on other CPUs and other tasks that
may share the same CPU? Everything in fact?

So for the case, you just launch:

	perf record -g my_task

For the second case, use -a for system wide profiling while
your task exists:

	./perf record -a -g my_task

Hope that helps.
