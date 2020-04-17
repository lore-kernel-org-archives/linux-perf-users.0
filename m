From: Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf/core: fix parent pid/tid in task exit events
Date: Fri, 17 Apr 2020 14:31:04 -0700
Message-ID: <CAP-5=fU=mBqrZYqMYSXd6_12YV43ZPNSqQ=8GCRj5ZAQRJperg@mail.gmail.com>
References: <20200417182842.12522-1-irogers@google.com> <20200417184536.GK20730@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200417184536.GK20730@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Stephane Eranian <eranian@google.com>, KP Singh <kpsingh@google.com>
List-Id: linux-perf-users.vger.kernel.org

On Fri, Apr 17, 2020 at 11:45 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Apr 17, 2020 at 11:28:42AM -0700, Ian Rogers wrote:
> > Current logic yields the child task as the parent.
> >
> > Before:
> > $ perf record bash -c "perf list > /dev/null"
> > $ perf script -D |grep 'FORK\|EXIT'
> > 4387036190981094 0x5a70 [0x30]: PERF_RECORD_FORK(10472:10472):(10470:10470)
> > 4387036606207580 0xf050 [0x30]: PERF_RECORD_EXIT(10472:10472):(10472:10472)
> > 4387036607103839 0x17150 [0x30]: PERF_RECORD_EXIT(10470:10470):(10470:10470)
> >                                                    ^
> >   Note the repeated values here -------------------/
> >
> > After:
> > 383281514043 0x9d8 [0x30]: PERF_RECORD_FORK(2268:2268):(2266:2266)
> > 383442003996 0x2180 [0x30]: PERF_RECORD_EXIT(2268:2268):(2266:2266)
> > 383451297778 0xb70 [0x30]: PERF_RECORD_EXIT(2266:2266):(2265:2265)
> >
>
> Fixes: .... ?

Fixes:  94d5d1b2d891 ("perf_counter: Report the cloning task as parent
on perf_counter_fork()")

Sorry, re-sending as plain-text was disabled on the message and so it
bounced on lkml. Took some digging to find the original commit :-)

Thanks,
Ian

>
> > Reported-by: KP Singh <kpsingh@google.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
