From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH] perf tools: Fix bug when recording SPE and non SPE events
Date: Mon, 13 Jan 2020 22:58:03 +0800
Message-ID: <20200113145803.GB10620@leoy-ThinkPad-X240s>
References: <20191220110525.30131-1-james.clark@arm.com>
 <20191223034852.GB3981@leoy-ThinkPad-X240s>
 <fd4f4278-fa43-86dc-1f2f-3439f19fea9e@arm.com>
 <20200113141751.GA10620@leoy-ThinkPad-X240s>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200113141751.GA10620@leoy-ThinkPad-X240s>
Sender: linux-kernel-owner@vger.kernel.org
To: Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
Cc: James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, nd@arm.com, Mathieu Poirier <mathieu.poirier@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Igor Lubashev <ilubashe@akamai.com>
List-Id: linux-perf-users.vger.kernel.org

On Mon, Jan 13, 2020 at 10:17:51PM +0800, Leo Yan wrote:

[...]

> > > On Fri, Dec 20, 2019 at 11:05:25AM +0000, James Clark wrote:
> > > > This patch fixes an issue when non Arm SPE events are specified after an
> > > > Arm SPE event. In that case, perf will exit with an error code and not
> > > > produce a record file. This is because a loop index is used to store the
> > > > location of the relevant Arm SPE PMU, but if non SPE PMUs follow, that
> > > > index will be overwritten. Fix this issue by saving the PMU into a
> > > > variable instead of using the index, and also add an error message.
> > > > 
> > > > Before the fix:
> > > >      ./perf record -e arm_spe/ts_enable=1/ -e branch-misses ls; echo $?
> > > >      237
> > > > 
> > > > After the fix:
> > > >      ./perf record -e arm_spe/ts_enable=1/ -e branch-misses ls; echo $?
> > > >      ...
> > > >      0
> > > 
> > > Just bring up a question related with PMU event registration.  Let's
> > > see the DT binding in arch/arm64/boot/dts/arm/fvp-base-revc.dts:
> > > 
> > >           spe-pmu {
> > >                   compatible = "arm,statistical-profiling-extension-v1";
> > >                   interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH>;
> > >           };
> > > 
> > > 
> > > Now SPE registers PMU event for every CPU; seem to me, though SPE is an
> > 
> > Do you mean "SPE PMU" here ? SPE is different from ETM, where the trace
> > data is micro-architecture dependent. And thus you cannot mix the trace
> > on different CPUs with different micro-archs.
> 
> Understood that SPE is micro-architecture dependent.

Maybe SPE is more general than we think :)

Since SPE is defined in ARMv8 architecture reference manual (ARM DDI
0487D.a); should SPE trace data format is unified and defined in Chapter
D9 "Statistical Profiling Extension Sample Record Specification"?

Thanks,
Leo
