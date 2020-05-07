From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC PATCH 0/7] Share events between metrics
Date: Thu, 7 May 2020 14:46:52 -0700
Message-ID: <20200507214652.GC3538@tassilo.jf.intel.com>
References: <20200507081436.49071-1-irogers@google.com>
 <20200507174835.GB3538@tassilo.jf.intel.com>
 <CAP-5=fUdoGJs+yViq3BOcJa7YyF53AD9RGQm8aRW72nMH0sKDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAP-5=fUdoGJs+yViq3BOcJa7YyF53AD9RGQm8aRW72nMH0sKDA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, Kajol Jain <kjain@linux.ibm.com>, John Garry <john.garry@huawei.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Cong Wang <xiyou.wangcong@gmail.com>Kim
List-Id: linux-perf-users.vger.kernel.org

> > - without this change events within a metric may get scheduled
> >   together, after they may appear as part of a larger group and be
> >   multiplexed at different times, lowering accuracy - however, less
> >   multiplexing may compensate for this.
> 
> I agree the heuristic in this patch set is naive and would welcome to
> improve it from your toplev experience. I think this change is
> progress on TopDownL1 - would you agree?

TopdownL1 in non SMT mode should always fit. Inside a group
deduping always makes sense. 

The problem is SMT mode where it doesn't fit. toplev tries
to group each node and each level together.

> 
> I'm wondering if what is needed are flags to control behavior. For
> example, avoiding the use of groups altogether. For TopDownL1 I see.

Yes the current situation isn't great.

For Topdown your patch clearly is an improvement, I'm not sure
it's for everything though.

Probably the advanced heuristics are only useful for a few
formulas, most are very simple. So maybe it's ok. I guess
would need some testing over the existing formulas.


-Andi
