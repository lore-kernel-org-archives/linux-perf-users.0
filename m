From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf probe dwarf on shared libraries
Date: Thu, 11 Sep 2014 11:51:19 -0300
Message-ID: <20140911145119.GG10158@kernel.org>
References: <CANq2XvGNtBO2zVoGTZJkfUofRbZ94-NJ5hZrSz5BT3En4dEHJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:58875 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751762AbaIKOv1 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 11 Sep 2014 10:51:27 -0400
Content-Disposition: inline
In-Reply-To: <CANq2XvGNtBO2zVoGTZJkfUofRbZ94-NJ5hZrSz5BT3En4dEHJA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: david lerner <dlernerdroid@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

Em Thu, Sep 04, 2014 at 03:11:31PM -0500, david lerner escreveu:
> Has perf probe for userspace shared libraries been modified to use dwarf info?
> The first commit to provide this useful functionality...
>    fb7345bbf7fad9  perf probe: Support basic dwarf-based operations on
> uprobe events,
> shows examples only with the executable perf, but not with a shared library.
 
> With version 3.14 I'm able to set probes in application executable,
> for example for the test application 'libunwind-test.out' I see the
> usual args to main():
>    root@qemu0:~# perf probe -x ./libunwind-test.out --vars main
>    Available variables at main
>         @<main+0>
>                 char**  a
>                 int     c
> But I can't access the variables in a library that has embedded (not
> split out) dwarf debug info...
>    root@qemu0:~# perf probe -x /usr/lib64/libunwind.so --vars unw_backtrace
>    Failed to find symbol at 0x33c38039cd
>    Failed to find variables at unw_backtrace (-2)
>    Error: Failed to show vars. (-2)
> I've used gdb to confirm that perf found the correct function address
> for unw_backtrace(), and that gdb knows the symbolic names of the
> arguments.
 
> Is using dwarf debuginfo with shared libraries for perf uprobes on the
> to-do list?
> Or is this capability incomplete in version 3.14 and I need to pick up
> other patches?

Have to check this, but perhaps Masami has this working already?

- Arnaldo
