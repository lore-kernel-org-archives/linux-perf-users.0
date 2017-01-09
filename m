From: Christian Convey <christian.convey@gmail.com>
Subject: Re: newbie question: tracing userspace call/return sequences
Date: Mon, 9 Jan 2017 10:19:36 -0500
Message-ID: <CAPfS4ZzKPTPrBJY+yhMBte_wyVgTnt-kuDUGF39BxV0NZs+TDQ@mail.gmail.com>
References: <CAPfS4ZwrYePYFoNtf7GOvMpJKABY8ZdCf+MB+xc+Ksa7ubRATQ@mail.gmail.com>
 <3722511.TPbTubHR2j@milian-kdab2> <CAPfS4ZyBOz_E5k3DKf8qqMbrKacCpijBM4-aUsgeL5LJTnxNyw@mail.gmail.com>
 <20170108084403.39baa3d793af5fed3ed4aeac@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33271 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755035AbdAIPTi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Jan 2017 10:19:38 -0500
Received: by mail-qk0-f175.google.com with SMTP id s140so120540623qke.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Jan 2017 07:19:38 -0800 (PST)
In-Reply-To: <20170108084403.39baa3d793af5fed3ed4aeac@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>, linux-perf-users <linux-perf-users@vger.kernel.org>

Hi Masami,

On Sat, Jan 7, 2017 at 6:44 PM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> No, you can use $params for tracing all function parameters :)
> So, please try "* $params" instead of "*".

Thanks for the tip!  I tried it out, and got some strange results: The
correct set of function parameter names is present in
"trace_unhandled" 's "event_fields_dict" dictionary.  However, the
actual runtime values of those parameters is sometimes inaccurate.

I'm using a simple Fibonacci program with just two functions: "main"
and "fibfunc".

Here are my steps:

gcc -g -fno-omit-frame-pointer -O0 fib.c -o fib

export PERF_EXEC_PATH=/home/cconvey/src/linux-4.8.0/tools/perf

sudo -E ${PERF_EXEC_PATH}/perf probe --exec=./fib --del='*'

sudo -E ${PERF_EXEC_PATH}/perf probe --exec=./fib --add='* $params'

sudo -E ${PERF_EXEC_PATH}/perf record -e 'probe_fib:*' -aR ./fib 3

# My script which currently just prints the parameters passed to
'trace_unhandled'.
sudo -E ${PERF_EXEC_PATH}/perf script -s ./perf-script-2.py


Here's an example of the output from my script:

> in trace_begin
> event_name = "probe_fib__main"
> event_fields_dict: {'common_callchain': [], 'common_pid': 18631, 'common_s': 98414, 'common_comm': 'fib', 'common_ns': 209748661, 'argv': 94718640125824, 'common_cpu': 6, 'argc': 22053, '__probe_ip': 94718640125737}
>
> event_name = "probe_fib__fibfunc"
> event_fields_dict: {'common_callchain': [], 'common_pid': 18631, 'common_s': 98414, 'common_comm': 'fib', 'common_ns': 209756797, 'n': 0, 'common_cpu': 6, '__probe_ip': 94718640125664}
>
> event_name = "probe_fib__fibfunc"
> event_fields_dict: {'common_callchain': [], 'common_pid': 18631, 'common_s': 98414, 'common_comm': 'fib', 'common_ns': 209757849, 'n': 32764, 'common_cpu': 6, '__probe_ip': 94718640125664}
>
> event_name = "probe_fib__fibfunc"
> event_fields_dict: {'common_callchain': [], 'common_pid': 18631, 'common_s': 98414, 'common_comm': 'fib', 'common_ns': 209758915, 'n': 2, 'common_cpu': 6, '__probe_ip': 94718640125664}
>
> in trace_end

Notice, for example, that the reported value for "argc" is 22053, rather than 2.

Any idea why that might be happening?


>
> > (2) I want the tracing to be robust even if the target program
> > dynamically links to `.so` files that I didn't anticipate when
> > creating the probes.  I haven't found any documentation regarding how
> > gracefully perf, SystemTap, etc. handle that situation.  I'm not sure
> > how I'd solve this problem.  Perhaps hooking `dlopen` is an option.
>
> Hm, would you know which libraries(so) can be loaded?

Yes, this is the problem I'm trying to solve.  One solution which
might solve my *current* needs is to simply perform two runs of the
target program.

In the first run, I use "strace" to discover which shared objects the
program opens at runtime.

And then, before running the target program a second time, I add
function-call probe events for those shared objects' functions.

Cheers,
Christian
