From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: Fwd: Logging PMU counters during context switch
Date: Fri, 10 Jan 2014 09:10:22 -0500 (EST)
Message-ID: <alpine.DEB.2.10.1401100907150.32591@vincent-weaver-1.um.maine.edu>
References: <CAMefCkD0QsYAcTtXr8UfBgJ4JfunmVmHEem2nMknK_5_Ddx6tg@mail.gmail.com> <CAMefCkAJ9UgVNe5HHmKfTT9QsMOJ9o52XRqQo4+1C1ATSYrJ-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:35181 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608AbaAJOJS (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 10 Jan 2014 09:09:18 -0500
Received: by mail-qa0-f47.google.com with SMTP id f11so3975382qae.20
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Jan 2014 06:09:17 -0800 (PST)
In-Reply-To: <CAMefCkAJ9UgVNe5HHmKfTT9QsMOJ9o52XRqQo4+1C1ATSYrJ-g@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Guru Prasad <gurupras@buffalo.edu>
Cc: linux-perf-users@vger.kernel.org

On Fri, 10 Jan 2014, Guru Prasad wrote:

> Architecture: ARM
> CPU: Cortex-A9
> 
> Hi,
> My goal is to log PMU counters during context switches.
> 
> Is there any documentation available in kernel on how to use perf
> functions within the kernel itself?
> I'm having a lot of difficulty setting up struct perf_event from
> within the kernel.

someone's probably going to chime in and say you can do this from 
userspace using the right combination of ftrace events (or could you
even do it setting overflow on the software context switch event with
a frequency of 1?)

In any case I wouldn't reccommend poking the PMU registers directly in a 
kernel that has perf_event running.  Reading them is probably OK but 
writing them is just going to confuse things.  Can you not set up and 
start the counters from userspace and then just have your printing code in 
the kernel print things (without touching the registers?)

Vince Weaver
vincent.weaver@maine.edu
http://www.eece.maine.edu/~vweaver/
