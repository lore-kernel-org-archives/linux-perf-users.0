From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: Sp! Re: Perf Script Erroneous User Stack Trace
Date: Tue, 16 Jun 2020 18:20:59 +0200
Message-ID: <5121466.Fqp1Q3JDDc@agathebauer>
References: <816cb5f558cd0e528812dff2168ef4ca@ut.ac.ir>
 <7e31757ab3c4ccea654c0921b8a50303@ut.ac.ir>
 <2eef8c33a31ae627010d985ac2ffae96@ut.ac.ir>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <2eef8c33a31ae627010d985ac2ffae96@ut.ac.ir>
Sender: linux-trace-users-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>, ahmadkhorrami <ahmadkhorrami@ut.ac.ir>
Cc: Steven Rostedt <rostedt@goodmis.org>, Linux-trace Users <linux-trace-users@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, linux-perf-users <linux-perf-users@vger.kernel.org>, linux-trace-users-owner@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Dienstag, 16. Juni 2020 16:37:08 CEST ahmadkhorrami wrote:
> Hi,
> The problem doesn't seems to be caused by the assembly code. I checked
> the execution in GDB, and put breakpoint at
> "x264_pixel_avg_w16_avx2+0x4" and ignored with 10, 100, 1000, 10000 and
> 100000 occurrences. But, in all cases, GDB, successfully, displayed the
> whole backtrace. One of them is as follows:

<snip>

> It seems that, there should be something wrong with the kernel-side
> implementation. Could anybody point me to the kernel implementation? I
> think it is dumped, here:
> https://github.com/torvalds/linux/blob/master/kernel/events/core.c#L6786
> 
> But, I do not know where in the kernel, the user call-stack is
> generated.
> Any guesses?

The kernel does not unwind the user call-stack when you use `perf record --
call-graph dwarf`. This is all done in user space at `perf report` time. The 
kernel only copies parts of the stack, in your case 64KB.

There are tons of ways that can lead to broken unwinding. To figure out more, 
you'll have to dive into `perf report` and try to come with some ideas 
yourself:

a) try to figure out how unwinding should work for that library, does it have 
.eh_frame or does it need debug information for unwinding? If the latter - run 
`strace -e file -f perf script` and check if the separate debug information 
files are found and loaded by perf.
b) run `perf script -v` and inspect the log for your first broken sample - is 
there anything in it that may indicate the reason for the issue?
c) try elfutils instead of libunwind for unwinding, does that make a 
difference?
d) dive even deeper into the code to see where and why it fails, potentially 
even within libunwind

Note that GDB uses a completely different unwinder than perf. Libunwind is 
pretty good, but GDB has even better fallbacks to figure out backtraces. I 
mean it often even works after (partial) stack corruption there ;-) So just 
saying "it works in GDB" doesn't help us too much...

Good luck!

-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt, C++ and OpenGL Experts
