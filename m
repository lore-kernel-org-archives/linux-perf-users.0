From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] arc: perf: Enable generic "cache-references" and
 "cache-misses" events
Date: Thu, 1 Sep 2016 10:33:24 +0200
Message-ID: <20160901083324.GM10153@twins.programming.kicks-ass.net>
References: <1472125647-518-1-git-send-email-abrodkin@synopsys.com>
 <6074e252-6e18-bb01-4de1-023bd7e82f03@synopsys.com>
 <5f65fa04-8d33-e525-115d-4e6991a7668e@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <5f65fa04-8d33-e525-115d-4e6991a7668e@synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Aug 31, 2016 at 12:05:14PM -0700, Vineet Gupta wrote:
> On 08/26/2016 10:31 AM, Vineet Gupta wrote:
> > On 08/25/2016 04:49 AM, Alexey Brodkin wrote:
> >> ...
> >>  	[PERF_COUNT_ARC_EDTLB] = "edtlb",	/* D-TLB Miss */
> >>  	[PERF_COUNT_ARC_EITLB] = "eitlb",	/* I-TLB Miss */
> >> +
> >> +	[PERF_COUNT_HW_CACHE_REFERENCES] = "imemrdc",	/* Instr: mem read cached */
> >> +	[PERF_COUNT_HW_CACHE_MISSES] = "dclm",		/* D-cache Load Miss */
> > I think this is duplicating a mistake we already have. I vaguely remember when
> > doing some hackbench profiling last year with range based profiling confined to
> > memset routine and saw that L1-dcache-misses was counting zero. This is because it
> > only counts LD misses while memset only does ST.
> >
> > Performance counter stats for '/sbin/hackbench':
> >
> >      0 L1-dcache-misses
> >      0 L1-dcache-load-misses
> >      1846082 L1-dcache-store-misses
> >
> >
> > @PeterZ do you concur that is wrong and we ought to setup 2 counters to do this
> > correctly ?
> 
> Hi Peter / Will,
> 
> Can you provide some guidance here. So I looked at what others do -
> ARMV7_PERFCTR_L1_DCACHE_REFILL counts both load and store misses, while ARC has 2
> separate conditions for load or stores. Is there an existing mechanism to "group"
> / "add" them to give a cumulative PERF_COUNT_HW_CACHE_MISSES 

Nope. So I would not try and use these generic events. In other news, it
seems like there's finally some progress on the JSON patches:

  https://lkml.kernel.org/r/20160831114254.GA9001@krava

Which would make using non-standard events easier.

> - is that what perf event grouping is ?

Again, nope. Perf event groups are single counter (so no implicit
addition) that are co-scheduled on the PMU.

> Quoting from perf wiki @ https://perf.wiki.kernel.org/index.php/Tutorial
> 
> "It can be interesting to try and pack events in a way that guarantees that event
> A and B are always measured together. Although the perf_events kernel interface
> provides support for event grouping, the current perf tool does *not*."

That seems out-dated, Jiri added grouping support to perf-tool quite a
while back.

You can do it like:

	perf stat -e '{cycles,instructions}'

Which will place the cycles event and the instructions event in a group
and thereby guarantee they're co-scheduled.
