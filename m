From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2]: perf/x86: store user space frame-pointer value on a sample
Date: Thu, 24 May 2018 07:52:33 -0700
Message-ID: <CALCETrVpMECGntOcADCwZrXn9YihHxVskXMa2Df8bKPP2dNQdg@mail.gmail.com>
References: <31205dc8-b756-e12b-0249-2ed06c2db9c9@linux.intel.com>
 <20180509145436.GV12217@hirez.programming.kicks-ass.net> <3ecedd91-1c01-6fc5-4648-89eaf5ff0930@linux.intel.com>
 <20180510101406.GA12217@hirez.programming.kicks-ass.net> <7051f72e-2570-68c8-1488-33ad1b024031@linux.intel.com>
 <20180523130950.GB12217@hirez.programming.kicks-ass.net> <137eab54-86df-cc7d-4618-bce49dfbc2d2@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <137eab54-86df-cc7d-4618-bce49dfbc2d2@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Andrew Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Thu, May 24, 2018 at 7:37 AM Alexey Budankov <
alexey.budankov@linux.intel.com> wrote:

> Hi,

> On 23.05.2018 16:09, Peter Zijlstra wrote:
> > On Wed, May 23, 2018 at 01:06:58PM +0300, Alexey Budankov wrote:
> >
> >> Is the patch ready to be up streamed now?
> >
> > Please post a new one where you modify the comment about the syscalls
> > not saving registers and ideally find the commit that made it so.

> Sent v3 with adjusted comment.
> As far comments become outdated quickly tried to be terse.

> >
> > Also; I think Andy would appreciate a comment near the syscall code that
> > refers back to this code and states what registers we rely upon being
> > there (+BP for this patch).

> Not sure if I can find all proper places to put comments there.
> However there is PUSH_AND_CLEAR_REGS macro that is employed at system
> call implementation so it is possible to put something like this there:

> .macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax save_ret=0
>          /*
>           ...
>           * perf/core subsystem relies on bp register value stored
>           * at pt_regs->bp; see arch/x86/kernel/perf_regs.c:
perf_get_regs_user()
>           * for more details;
>           ...
>           */


Near the top of entry_SYSCALL_64 would be reasonable, as would no comment
at all, I think.

> Thanks,
> Alexey
> >
> >
