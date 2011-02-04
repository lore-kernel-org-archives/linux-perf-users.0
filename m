From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: Profiling a program's runtime
Date: Fri, 4 Feb 2011 18:47:52 +0100
Message-ID: <20110204174750.GD1808@nowhere>
References: <ukft18-pba.ln1@burns.bruehl.pontohonk.de>
 <20110204171604.GB1808@nowhere>
 <6cqt18-1lh.ln1@burns.bruehl.pontohonk.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60196 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578Ab1BDRwP (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 4 Feb 2011 12:52:15 -0500
Received: by fxm20 with SMTP id 20so2672890fxm.19
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Feb 2011 09:52:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <6cqt18-1lh.ln1@burns.bruehl.pontohonk.de>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Christoph Bartoschek <bartoschek@gmx.de>
Cc: linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>

On Fri, Feb 04, 2011 at 06:41:57PM +0100, Christoph Bartoschek wrote:
> Frederic Weisbecker wrote:
> 
> > 
> > If I understood you well, you make a difference between:
> > 
> > - profiling only the code executed by your task
> > - profiling any code executed while your task was existing,
> > which includes what happens on other CPUs and other tasks that
> > may share the same CPU? Everything in fact?
> > 
> > So for the case, you just launch:
> > 
> > perf record -g my_task
> > 
> > For the second case, use -a for system wide profiling while
> > your task exists:
> > 
> > ./perf record -a -g my_task
> 
> I am not interessted in code that is executed in other processes while my 
> task exists. 
> 
> I want that not only the CPU time is counted that my task uses, but also the 
> time my task waits.

The time your task waits, other tasks executes :-/  (including idle in the scheme)
 
> For example, if my task waits for network packets in a read() then the time  
> should be added to the read() function. Other profilers I know would not 
> count the time when the process is blocked.

What do you mean by adding time to read?

I'm very confused with what you want.
