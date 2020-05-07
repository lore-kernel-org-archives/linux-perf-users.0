From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC PATCH 0/7] Share events between metrics
Date: Thu, 7 May 2020 10:48:35 -0700
Message-ID: <20200507174835.GB3538@tassilo.jf.intel.com>
References: <20200507081436.49071-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200507081436.49071-1-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, Kajol Jain <kjain@linux.ibm.com>, John Garry <john.garry@huawei.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Cong Wang <xiyou.wangcong@gmail.com>Kim
List-Id: linux-perf-users.vger.kernel.org

On Thu, May 07, 2020 at 01:14:29AM -0700, Ian Rogers wrote:
> Metric groups contain metrics. Metrics create groups of events to
> ideally be scheduled together. Often metrics refer to the same events,
> for example, a cache hit and cache miss rate. Using separate event
> groups means these metrics are multiplexed at different times and the
> counts don't sum to 100%. More multiplexing also decreases the
> accuracy of the measurement.
> 
> This change orders metrics from groups or the command line, so that
> the ones with the most events are set up first. Later metrics see if
> groups already provide their events, and reuse them if
> possible. Unnecessary events and groups are eliminated.

Note this actually may make multiplexing errors worse.

For metrics it is often important that all the input values to
the metric run at the same time. 

So e.g. if you have two metrics and they each fit into a group,
but not together, even though you have more multiplexing it
will give more accurate results for each metric.

I think you change can make sense for metrics that don't fit 
into single groups anyways. perf currently doesn't quite know
this but some heuristic could be added. 

But I wouldn't do it for simple metrics that fit into groups.
The result may well be worse.

My toplev tool has some heuristics for this, also some more
sophisticated ones that tracks subexpressions. That would
be far too complicated for perf likely.

-Andi
