From: Ian Rogers <irogers@google.com>
Subject: Re: [RFC PATCH 0/7] Share events between metrics
Date: Thu, 7 May 2020 22:43:43 -0700
Message-ID: <CAP-5=fV2eNAt0LLHYXeLMR6GZi_oGZyzz8psErNkbahLQs-VLQ@mail.gmail.com>
References: <20200507081436.49071-1-irogers@google.com> <20200507174835.GB3538@tassilo.jf.intel.com>
 <CAP-5=fUdoGJs+yViq3BOcJa7YyF53AD9RGQm8aRW72nMH0sKDA@mail.gmail.com> <20200507214652.GC3538@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200507214652.GC3538@tassilo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, Kajol Jain <kjain@linux.ibm.com>, John Garry <john.garry@huawei.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Cong Wang <xiyou.wangcong@gmail.com>Kim
List-Id: linux-perf-users.vger.kernel.org

On Thu, May 7, 2020 at 2:47 PM Andi Kleen <ak@linux.intel.com> wrote:
>
> > > - without this change events within a metric may get scheduled
> > >   together, after they may appear as part of a larger group and be
> > >   multiplexed at different times, lowering accuracy - however, less
> > >   multiplexing may compensate for this.
> >
> > I agree the heuristic in this patch set is naive and would welcome to
> > improve it from your toplev experience. I think this change is
> > progress on TopDownL1 - would you agree?
>
> TopdownL1 in non SMT mode should always fit. Inside a group
> deduping always makes sense.
>
> The problem is SMT mode where it doesn't fit. toplev tries
> to group each node and each level together.

Thanks Andi, I've provided some examples of TopDownL3_SMT in the cover
letter of the v3 patch set:
https://lore.kernel.org/lkml/20200508053629.210324-1-irogers@google.com/
I tested sandybridge and cascadelake and the results look similar to
the non-SMT version. Let me know if there's a different variant to
test.

> >
> > I'm wondering if what is needed are flags to control behavior. For
> > example, avoiding the use of groups altogether. For TopDownL1 I see.
>
> Yes the current situation isn't great.
>
> For Topdown your patch clearly is an improvement, I'm not sure
> it's for everything though.
>
> Probably the advanced heuristics are only useful for a few
> formulas, most are very simple. So maybe it's ok. I guess
> would need some testing over the existing formulas.

Agreed, do you have a pointer on a metric group where things would
obviously be worse? I started off with a cache miss and hit rate
metric and similar to topdown this approach is a benefit.

In v3 I've added a --metric-no-merge option to retain existing
grouping behavior, I've also added a --metric-no-group that avoids
groups for all metrics. This may be useful if the NMI watchdog can't
be disabled.

Thanks for the input!
Ian

> -Andi
