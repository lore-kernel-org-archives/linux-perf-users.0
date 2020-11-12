From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC PATCH 00/12] Topdown parser
Date: Wed, 11 Nov 2020 19:10:49 -0800
Message-ID: <20201112031049.GC894261@tassilo.jf.intel.com>
References: <20201110100346.2527031-1-irogers@google.com>
 <20201111214635.GA894261@tassilo.jf.intel.com>
 <CAP-5=fXedJEZcYhxmPAzRVx5kdW2YA71Ks3BycqurAHydtXh8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAP-5=fXedJEZcYhxmPAzRVx5kdW2YA71Ks3BycqurAHydtXh8A@mail.gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jin Yao <yao.jin@linux.intel.com>, John Garry <john.garry@huawei.com>, Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>, Stephane Eranian <eranian@google.com>, Sandeep Dasgupta <sdasgup@google.com>, linux-perf-users <linux-perf-users@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Hi Ian,

On Wed, Nov 11, 2020 at 03:49:10PM -0800, Ian Rogers wrote:
>      FWIW I did something similar in python (that's how the current metrics
>      json files were generated from the spreadsheet) and it was a lot
>      simpler and shorter in a higher level language.
> 
>    The use of C++ here was intended to be a high-level language usage :-)

FWIW this is our script for the metrics.

https://github.com/intel/event-converter-for-linux-perf/blob/master/extract-tmam-metrics.py

It has a few hacks, but overall isn't too bad.

>     
> 
>      One problem I see with putting the full TopDown model into perf is
>      that to do a full job it requires a lot more infrastructure that is
>      currently not implemented in metrics: like an event scheduler,
>      hierarchical thresholding over different nodes, SMT mode support etc.
> 
>      I implemented it all in toplev, but it was a lot of work to get it all
>      right.
>      I'm not saying it's not doable, but it will be a lot of additional work
>      to work out all the quirks using the metrics infrastructure.
> 
>      I think adding one or two more levels is probably ok, but doing all
>      levels
>      without these mechanisms might be difficult to use in the end.
> 
>    Thanks Andi, I'm working from the optimization manual and trying to
>    understand this. With this contribution we have both metrics and
>    groups that correspond to the levels in the tree. Following a similar flow
>    to the optimization manual the group Topdown_Group_TopDownL1 provides the
>    metrics Topdown_Metric_Frontend_Bound, Topdown_Metric_Backend_Bound, Topdown_Metric_Bad_Speculation
>    and Topdown_Metric_Retiring. The hope is the events here will all be
>    scheduled without multiplexing.

That's not necessarily true. Some of the newer expressions are quite
complex (e.g .due to workarounds or because the events are complex, like
the FLOPS events) There's also some problems with the
scheduling of the fixed metrics on Icelake+, that need special handling.

> Let's say Topdown_Metric_Backend_Bound is
>    an outlier and so then you re-run perf to drill into the group
>    Topdown_Group_Backend which will provide the
>    metrics Topdown_Metric_Memory_Bound and Topdown_Metric_Core_Bound. If the
>    metric Topdown_Metric_Memory_Bound is the outlier then you can use the
>    group Topdown_Group_Memory_Bound to drill into DRAM, L1, L2, L3, PMM and

I think at a minimum you would need a threshold concept for this, otherwise
the users don't know what passed or what didn't, and where to drill
down.

Also in modern TMAM some events thresholds are not only based on their
parents but based on triggers cross true (e.g. $issue). Doing this
by hand is somewhat tricky.

BTW toplev has an auto drilldown mode now to automate this (--drilldown)

Also in other cases it's probably better to not drilldown, but collect
everything upfront, e.g. when someone else is doing the collection
for you. In this case the thresholding has to be figured out from
existing data.

The other biggie which is currently not in metrics is per core mode,
which is needed for many metrics on CPUs older than Icelake. This really
has to be supported in some way, otherwise the results on pre Icelake SMT 
are not good (Icelake fixes this problem)

>    like SMT_on that may appear in the spreadsheet in expressions like:
>    ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else CLKS
>    These are passed through and then the perf expression parser will at
>    runtime compute the SMT_ON value using smt_on() that reads
>    from devices/system/cpu/cpu%d/topology/thread_siblings. Here is a
>    generated example for Skylakex:

Yes I implemented that. But that's not enough for the full TMAM, you also need per core
mode for these (but not for others).

At the level 1 we get away by either being in per core mode or not, but 
that doesn't work deeper in the hierarchy.

>    SMT_ON needs evaluating early. This is a latent perf metric issue that
>    would benefit everyone if fixed, so I'll try to address it in a separate
>    change.
>    Event scheduling is missing and as discussed there are some naive
>    heuristics currently in perf. It seems we can improve this, for example a
>    group with events {A,B,C} and another with {B,C,D} could be merged to
>    create {A,B,C,D} but we'd need to know the number of counters. We could

It's more complicated with OCR and similar special events, which
can fit only a limited number into a group.

Also on Icelake you need to know about the 4 vs 8 counter constraints,
so it requires some knowledge of the event list.

With the fixed metrics there are also special rules, like slots needs
to be first and be followed by the metrics.

Also if you don't do some deduping you end up with a lot of redundant
events being scheduled. Also when there are multiple levels of expressions
usually there is a need for sub grouping by levels etc.

It's not a simple algorithm.

>    provide this information to the tool here and it could create phony
>    metrics for the relevant architecture just to achieve the better grouping
>    - currently {A,B,C} and {B,C,D} will likely multiplex with each other,
>    which is functional but suboptimal.
>    Hierarchical thresholding I'm unclear upon, but maybe this is part of what
>    the user is expected to manually perform.

The spreadsheet has a threshold for each node.  Often it includes & P which means
parent crossed threshold. But in some cases it also includes a cross tree node
(this actually requires some simple dependency based computation of the metric, 
kind of a spreadsheet)

In general if the parent didn't cross then you don't need to display the node
because it's not contributing to the performance bottleneck.

That's a very important property in TopDown (as the name implies) and one of the
basic ways how the whole thing helps automatically determining the bottleneck.

Again I think it's probably not that bad if you stay in the higher levels.
For example in the upcoming Sapphire Rapids support which has Level 2 fixed
metrics we just added more fixed metrics. A thresholding concept would
probably be still a good idea though.

But it's a bit scary to think what naive users will do when presented with
level 4 or deeper without any hiding of irrelevant results.

-Andi
