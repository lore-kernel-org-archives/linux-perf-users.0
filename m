From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: System crash with perf_fuzzer (kernel: 5.0.0-rc3)
Date: Fri, 1 Feb 2019 08:43:53 +0100
Message-ID: <20190201074353.GA8778@krava>
References: <7c7ec3d9-9af6-8a1d-515d-64dcf8e89b78@linux.ibm.com>
 <20190130183648.GA24233@krava>
 <20190131082711.GC24233@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190131082711.GC24233@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Andi Kleen <ak@linux.intel.com>, eranian@google.com, vincent.weaver@maine.edu, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

On Thu, Jan 31, 2019 at 09:27:11AM +0100, Jiri Olsa wrote:
> On Wed, Jan 30, 2019 at 07:36:48PM +0100, Jiri Olsa wrote:
> 
> SNIP
> 
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 280a72b3a553..22ec63a0782e 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -4969,6 +4969,26 @@ static void __perf_event_period(struct perf_event *event,
> >  	}
> >  }
> >  
> > +static int check_period(struct perf_event *event, u64 value)
> > +{
> > +	u64 sample_period_attr = event->attr.sample_period;
> > +	u64 sample_period_hw   = event->hw.sample_period;
> > +	int ret;
> > +
> > +	if (event->attr.freq) {
> > +		event->attr.sample_freq = value;
> > +	} else {
> > +		event->attr.sample_period = value;
> > +		event->hw.sample_period = value;
> > +	}
> 
> hm, I think we need to check the period without changing the event,
> because we don't disable pmu, so it might get picked up by bts code
> 
> will check

with attached patch I did not trigger the fuzzer crash
for over a day now, could you guys try?

thanks,
jirka


---
 arch/x86/events/core.c       | 14 ++++++++++++++
 arch/x86/events/intel/core.c |  9 +++++++++
 arch/x86/events/perf_event.h | 16 ++++++++++++++--
 include/linux/perf_event.h   |  5 +++++
 kernel/events/core.c         | 16 ++++++++++++++++
 5 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 374a19712e20..b684f0294f35 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2278,6 +2278,19 @@ void perf_check_microcode(void)
 		x86_pmu.check_microcode();
 }
 
+static int x86_pmu_check_period(struct perf_event *event, u64 value)
+{
+	if (x86_pmu.check_period && x86_pmu.check_period(event, value))
+		return -EINVAL;
+
+	if (value && x86_pmu.limit_period) {
+		if (x86_pmu.limit_period(event, value) > value)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 static struct pmu pmu = {
 	.pmu_enable		= x86_pmu_enable,
 	.pmu_disable		= x86_pmu_disable,
@@ -2302,6 +2315,7 @@ static struct pmu pmu = {
 	.event_idx		= x86_pmu_event_idx,
 	.sched_task		= x86_pmu_sched_task,
 	.task_ctx_size          = sizeof(struct x86_perf_task_context),
+	.check_period		= x86_pmu_check_period,
 };
 
 void arch_perf_update_userpage(struct perf_event *event,
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 8b4e3020aba2..a3fbbd33beef 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3586,6 +3586,11 @@ static void intel_pmu_sched_task(struct perf_event_context *ctx,
 	intel_pmu_lbr_sched_task(ctx, sched_in);
 }
 
+static int intel_pmu_check_period(struct perf_event *event, u64 value)
+{
+	return intel_pmu_has_bts_period(event, value) ? -EINVAL : 0;
+}
+
 PMU_FORMAT_ATTR(offcore_rsp, "config1:0-63");
 
 PMU_FORMAT_ATTR(ldlat, "config1:0-15");
@@ -3665,6 +3670,8 @@ static __initconst const struct x86_pmu core_pmu = {
 	.cpu_prepare		= intel_pmu_cpu_prepare,
 	.cpu_starting		= intel_pmu_cpu_starting,
 	.cpu_dying		= intel_pmu_cpu_dying,
+
+	.check_period		= intel_pmu_check_period,
 };
 
 static struct attribute *intel_pmu_attrs[];
@@ -3707,6 +3714,8 @@ static __initconst const struct x86_pmu intel_pmu = {
 	.cpu_dying		= intel_pmu_cpu_dying,
 	.guest_get_msrs		= intel_guest_get_msrs,
 	.sched_task		= intel_pmu_sched_task,
+
+	.check_period		= intel_pmu_check_period,
 };
 
 static __init void intel_clovertown_quirk(void)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 78d7b7031bfc..d46fd6754d92 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -646,6 +646,11 @@ struct x86_pmu {
 	 * Intel host/guest support (KVM)
 	 */
 	struct perf_guest_switch_msr *(*guest_get_msrs)(int *nr);
+
+	/*
+	 * Check period value for PERF_EVENT_IOC_PERIOD ioctl.
+	 */
+	int (*check_period) (struct perf_event *event, u64 period);
 };
 
 struct x86_perf_task_context {
@@ -857,7 +862,7 @@ static inline int amd_pmu_init(void)
 
 #ifdef CONFIG_CPU_SUP_INTEL
 
-static inline bool intel_pmu_has_bts(struct perf_event *event)
+static inline bool intel_pmu_has_bts_period(struct perf_event *event, u64 period)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	unsigned int hw_event, bts_event;
@@ -868,7 +873,14 @@ static inline bool intel_pmu_has_bts(struct perf_event *event)
 	hw_event = hwc->config & INTEL_ARCH_EVENT_MASK;
 	bts_event = x86_pmu.event_map(PERF_COUNT_HW_BRANCH_INSTRUCTIONS);
 
-	return hw_event == bts_event && hwc->sample_period == 1;
+	return hw_event == bts_event && period == 1;
+}
+
+static inline bool intel_pmu_has_bts(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	return intel_pmu_has_bts_period(event, hwc->sample_period);
 }
 
 int intel_pmu_save_and_restart(struct perf_event *event);
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index f2f9f8592d42..0a7d4d6a3660 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -447,6 +447,11 @@ struct pmu {
 	 * Filter events for PMU-specific reasons.
 	 */
 	int (*filter_match)		(struct perf_event *event); /* optional */
+
+	/*
+	 * Check period value for PERF_EVENT_IOC_PERIOD ioctl.
+	 */
+	int (*check_period)		(struct perf_event *event, u64 value); /* optional */
 };
 
 enum perf_addr_filter_action_t {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 214c434ddc1b..edd92dc556fb 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4969,6 +4969,11 @@ static void __perf_event_period(struct perf_event *event,
 	}
 }
 
+static int perf_event_check_period(struct perf_event *event, u64 value)
+{
+	return event->pmu->check_period(event, value);
+}
+
 static int perf_event_period(struct perf_event *event, u64 __user *arg)
 {
 	u64 value;
@@ -4985,6 +4990,9 @@ static int perf_event_period(struct perf_event *event, u64 __user *arg)
 	if (event->attr.freq && value > sysctl_perf_event_sample_rate)
 		return -EINVAL;
 
+	if (perf_event_check_period(event, value))
+		return -EINVAL;
+
 	event_function_call(event, __perf_event_period, &value);
 
 	return 0;
@@ -9601,6 +9609,11 @@ static int perf_pmu_nop_int(struct pmu *pmu)
 	return 0;
 }
 
+static int perf_event_nop_int(struct perf_event *event, u64 value)
+{
+	return 0;
+}
+
 static DEFINE_PER_CPU(unsigned int, nop_txn_flags);
 
 static void perf_pmu_start_txn(struct pmu *pmu, unsigned int flags)
@@ -9901,6 +9914,9 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 		pmu->pmu_disable = perf_pmu_nop_void;
 	}
 
+	if (!pmu->check_period)
+		pmu->check_period = perf_event_nop_int;
+
 	if (!pmu->event_idx)
 		pmu->event_idx = perf_event_idx_default;
 
-- 
2.17.2
