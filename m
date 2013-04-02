From: OSDepend <osdepend@gmail.com>
Subject: Re: Re: Fw: Re: Re: Howto make perf probe work
Date: Tue, 2 Apr 2013 17:11:01 +0800
Message-ID: <201304021710591525728@gmail.com>
References: <201304010130139026692@gmail.com>,
 <CAGJbQddYW4-QZUvGpwCbmVhsvGEan5UkgRbXq+w4i+9Ob9vUrw@mail.gmail.com>,
 <201304012320294652937@gmail.com>,
 <201304012324395211298@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:45759 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760247Ab3DBJLG (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 2 Apr 2013 05:11:06 -0400
Received: by mail-da0-f46.google.com with SMTP id y19so106006dan.33
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Apr 2013 02:11:06 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>, nelakurthi koteswararao <koteswararao18@gmail.com>

Hi Kim,

> > >HI,
> > >Please enable kprobe_event config option in the kernel and build the same
> > >and boot the board using it. Then please try to add event using perf probe
> > >command
> > 
> > Thanks very much for your reply, and I already enable DEBUG_KPROBE_EVENT in kernel.
> > I did success in "perf probe handle_mm_fault".
> > 
> > But when i want to to "perf probe" other Kernel symbol, such as do_page_fault.
> > I came across other problems:
> >     Added new event:
> >     Failed to write event: Invalid argument
> >     Error: Failed to add events. (-1)
> > And when i type perf probe page_fault_entry:
> >     Kernel symbol 'page_fault_entry' not found.
> >     Error: Failed to add events. (-2)
> > Please notice that "do_page_fault" and "page_fault_entry" are all Kernel symbols, which canbe find in  "/proc/kallsyms", but not recorgonized by perf (or even kprobe).
> > Any idea for that?
> For some reason, do_page_fault() is marked as __kprobe on some arch
> which means it cannot be probed.
> Thanks,
> Namhyung

My kernel is runing on X86_64 arch, is there any chance for me to get the do_page_fault() entry/exit work?
Or How can i add a exit tracepoint for handle_mm_fault()? so I can calculate the latency of that fault handle function?

Best,
Chen
