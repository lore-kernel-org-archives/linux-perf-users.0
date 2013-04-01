From: OSDepend <osdepend@gmail.com>
Subject: Fw: Re: Re: Howto make perf probe work
Date: Mon, 1 Apr 2013 23:24:41 +0800
Message-ID: <201304012324395211298@gmail.com>
References: <201304010130139026692@gmail.com>,
 <CAGJbQddYW4-QZUvGpwCbmVhsvGEan5UkgRbXq+w4i+9Ob9vUrw@mail.gmail.com>,
 <201304012320294652937@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:33080 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758584Ab3DAPYp (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 1 Apr 2013 11:24:45 -0400
Received: by mail-pd0-f180.google.com with SMTP id g10so1274360pdj.11
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Apr 2013 08:24:44 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users <linux-perf-users@vger.kernel.org>
Cc: nelakurthi koteswararao <koteswararao18@gmail.com>

>HI,
>Please enable kprobe_event config option in the kernel and build the same
>and boot the board using it. Then please try to add event using perf probe
>command

Thanks very much for your reply, and I already enable DEBUG_KPROBE_EVENT in kernel.
I did success in "perf probe handle_mm_fault".

But when i want to to "perf probe" other Kernel symbol, such as do_page_fault.
I came across other problems:
    Added new event:
    Failed to write event: Invalid argument
    Error: Failed to add events. (-1)
And when i type perf probe page_fault_entry:
    Kernel symbol 'page_fault_entry' not found.
    Error: Failed to add events. (-2)
Please notice that "do_page_fault" and "page_fault_entry" are all Kernel symbols, which canbe find in  "/proc/kallsyms", but not recorgonized by perf (or even kprobe).
Any idea for that?

Best,
Chen

>>On Sun, Mar 31, 2013 at 11:00 PM, OSDepend <osdepend@gmail.com> wrote:
>>Hi all,
>>        Is there any way to use perf probe to add new tracepoint like pagefault enter/exit?
>>        When I type perf probe fault:10
>>       I always get the error as follow:
>>                Debuginfo-analysis is not supported.
>>                Error: Failed to add events. (-38)
>>        What exactly i miss to get the perf probe work correctly?
>>Best,
>>Chen
