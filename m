From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: Fw: Re: Re: Howto make perf probe work
Date: Tue, 02 Apr 2013 13:36:15 +0900
Message-ID: <87ip45ft1c.fsf@sejong.aot.lge.com>
References: <201304010130139026692@gmail.com>
	<CAGJbQddYW4-QZUvGpwCbmVhsvGEan5UkgRbXq+w4i+9Ob9vUrw@mail.gmail.com>
	<201304012320294652937@gmail.com> <201304012324395211298@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE6Q.lge.com ([156.147.1.121]:55137 "EHLO
	LGEMRELSE6Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755136Ab3DBEgR (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 2 Apr 2013 00:36:17 -0400
In-Reply-To: <201304012324395211298@gmail.com> (osdepend@gmail.com's message
	of "Mon, 1 Apr 2013 23:24:41 +0800")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: OSDepend <osdepend@gmail.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>, nelakurthi koteswararao <koteswararao18@gmail.com>

> >HI,
> >Please enable kprobe_event config option in the kernel and build the same
> >and boot the board using it. Then please try to add event using perf probe
> >command
> 
> Thanks very much for your reply, and I already enable DEBUG_KPROBE_EVENT in kernel.
> I did success in "perf probe handle_mm_fault".
> 
> But when i want to to "perf probe" other Kernel symbol, such as do_page_fault.
> I came across other problems:
>     Added new event:
>     Failed to write event: Invalid argument
>     Error: Failed to add events. (-1)
> And when i type perf probe page_fault_entry:
>     Kernel symbol 'page_fault_entry' not found.
>     Error: Failed to add events. (-2)
> Please notice that "do_page_fault" and "page_fault_entry" are all Kernel symbols, which canbe find in  "/proc/kallsyms", but not recorgonized by perf (or even kprobe).
> Any idea for that?

For some reason, do_page_fault() is marked as __kprobe on some arch
which means it cannot be probed.

Thanks,
Namhyung
