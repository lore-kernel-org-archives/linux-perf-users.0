From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH] perf tools: Fix bug when recording SPE and non SPE events
Date: Thu, 2 Jan 2020 19:44:33 +0800
Message-ID: <20200102114433.GA18709@leoy-ThinkPad-X240s>
References: <20191220110525.30131-1-james.clark@arm.com>
 <20191223034852.GB3981@leoy-ThinkPad-X240s>
 <591d2827-55f7-130d-ab43-2a6bd715fe5e@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <591d2827-55f7-130d-ab43-2a6bd715fe5e@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: James Clark <James.Clark@arm.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, nd <nd@arm.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Suzuki Poulose <Suzuki.Poulose@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Igor Lubashev <ilubashe@akamai.com>
List-Id: linux-perf-users.vger.kernel.org

Hi James,

On Thu, Jan 02, 2020 at 11:05:53AM +0000, James Clark wrote:
> Hi Leo,
> 
> Do you mean that you would never expect there to be more than one SPE file like /sys/bus/event_source/devices/arm_spe_0?

Yeah.

To be more accurate, I'd suggest to be only one SPE file if CPUs have
the same SPE version.  If there have multiple SPE files under
'/sys/bus/event_source/devices/', this means the CPUs have different
SPE versions

Let's see an example for SMP platform with 4xCA53 CPUs:
/sys/bus/event_source/devices/armv8_cortex_a53

For big.LITTLE system, we can see below nodes:
/sys/bus/event_source/devices/armv8_cortex_a53
/sys/bus/event_source/devices/armv8_cortex_a72

If SPE has the same IP for all CPUs, this would be simple to only
create on file under /sys/bus/event_source/devices/.

> If that is the case then do you know why there is still a number appended to the file?

This is caused by the code [1].  But I don't know what's the reason
for adding index to PMU event name.

Thanks,
Leo Yan

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/perf/arm_spe_pmu.c?h=v5.5-rc4#n911

> On 23/12/2019 03:48, Leo Yan wrote:
> > Hi James,
> > 
> > On Fri, Dec 20, 2019 at 11:05:25AM +0000, James Clark wrote:
> >> This patch fixes an issue when non Arm SPE events are specified after an
> >> Arm SPE event. In that case, perf will exit with an error code and not
> >> produce a record file. This is because a loop index is used to store the
> >> location of the relevant Arm SPE PMU, but if non SPE PMUs follow, that
> >> index will be overwritten. Fix this issue by saving the PMU into a
> >> variable instead of using the index, and also add an error message.
> >>
> >> Before the fix:
> >>     ./perf record -e arm_spe/ts_enable=1/ -e branch-misses ls; echo $?
> >>     237
> >>
> >> After the fix:
> >>     ./perf record -e arm_spe/ts_enable=1/ -e branch-misses ls; echo $?
> >>     ...
> >>     0
> > 
> > Just bring up a question related with PMU event registration.  Let's
> > see the DT binding in arch/arm64/boot/dts/arm/fvp-base-revc.dts:
> > 
> >          spe-pmu {
> >                  compatible = "arm,statistical-profiling-extension-v1";
> >                  interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH>;
> >          };
> > 
> > 
> > Now SPE registers PMU event for every CPU; seem to me, though SPE is an
> > IP binding per CPU, it should register into perf framework with single
> > pmu event, ARM's PMU/ETM/IntelPT all use this way to regsiter PMU event;
> > this can allow perf tool logic to be more neat.
> > 
> > After the driver changes to use single PMU registration, the perf tool
> > code can be changed to use simple way to find perf_pmu and this data
> > structure can be not bound to a specific CPU.  Finally, this bug can
> > be smoothly dismissed.
> > 
> > Thanks,
> > Leo
> > 
> >> Signed-off-by: James Clark <james.clark@arm.com>
> >> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> >> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: Ingo Molnar <mingo@redhat.com>
> >> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> >> Cc: Jiri Olsa <jolsa@redhat.com>
> >> Cc: Namhyung Kim <namhyung@kernel.org>
> >> Cc: Igor Lubashev <ilubashe@akamai.com>
> >> ---
> >>  tools/perf/arch/arm/util/auxtrace.c  | 10 +++++-----
> >>  tools/perf/arch/arm64/util/arm-spe.c |  1 +
> >>  2 files changed, 6 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
> >> index 0a6e75b8777a..230f03b622e1 100644
> >> --- a/tools/perf/arch/arm/util/auxtrace.c
> >> +++ b/tools/perf/arch/arm/util/auxtrace.c
> >> @@ -54,9 +54,9 @@ struct auxtrace_record
> >>  *auxtrace_record__init(struct evlist *evlist, int *err)
> >>  {
> >>  	struct perf_pmu	*cs_etm_pmu;
> >> +	struct perf_pmu *arm_spe_pmu = NULL;
> >>  	struct evsel *evsel;
> >>  	bool found_etm = false;
> >> -	bool found_spe = false;
> >>  	static struct perf_pmu **arm_spe_pmus = NULL;
> >>  	static int nr_spes = 0;
> >>  	int i = 0;
> >> @@ -79,13 +79,13 @@ struct auxtrace_record
> >>  
> >>  		for (i = 0; i < nr_spes; i++) {
> >>  			if (evsel->core.attr.type == arm_spe_pmus[i]->type) {
> >> -				found_spe = true;
> >> +				arm_spe_pmu = arm_spe_pmus[i];
> >>  				break;
> >>  			}
> >>  		}
> >>  	}
> >>  
> >> -	if (found_etm && found_spe) {
> >> +	if (found_etm && arm_spe_pmu) {
> >>  		pr_err("Concurrent ARM Coresight ETM and SPE operation not currently supported\n");
> >>  		*err = -EOPNOTSUPP;
> >>  		return NULL;
> >> @@ -95,8 +95,8 @@ struct auxtrace_record
> >>  		return cs_etm_record_init(err);
> >>  
> >>  #if defined(__aarch64__)
> >> -	if (found_spe)
> >> -		return arm_spe_recording_init(err, arm_spe_pmus[i]);
> >> +	if (arm_spe_pmu)
> >> +		return arm_spe_recording_init(err, arm_spe_pmu);
> >>  #endif
> >>  
> >>  	/*
> >> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> >> index eba6541ec0f1..b7d17d8724df 100644
> >> --- a/tools/perf/arch/arm64/util/arm-spe.c
> >> +++ b/tools/perf/arch/arm64/util/arm-spe.c
> >> @@ -178,6 +178,7 @@ struct auxtrace_record *arm_spe_recording_init(int *err,
> >>  	struct arm_spe_recording *sper;
> >>  
> >>  	if (!arm_spe_pmu) {
> >> +		pr_err("Attempted to initialise null SPE PMU\n");
> >>  		*err = -ENODEV;
> >>  		return NULL;
> >>  	}
> >> -- 
> >> 2.24.0
> >>
