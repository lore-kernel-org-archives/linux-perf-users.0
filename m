Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FACC392828;
	Mon, 13 Apr 2026 08:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776068374; cv=none; b=I96FjnrjWTHBM1qYfAQD2po0sG7HMd+dNGRkIO2kqRyh6gG1iCZNYGZUWne/gVmOebsTnAbr2WjTDS15DjTOeI7h6mpCJRAfaIqO0RBkJBbQR5gmYh88rLkl02uZMw8pvUJIbSJY7wUpmJx4xvV/kNe6moTUGKBbp8t2eG2SQ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776068374; c=relaxed/simple;
	bh=71cdEnwfW+V/aTVliYHo8LtMEu/9UNBFEuRRzJd9geE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RBlHqv+Jh49dvvmC74P9xwKIOu1UvazV7aetmhqiTK6Wj8gT4anzspbEsNq4SEtCnzMRCy8wmgfnu5C5kuQaZa45+6OkgEpmARtempgGoBxX0mksVItoP2su+w7r1OaT02DuXgkJ+zghwvdDqKNASQzjtOyXo6okM0Elsze9vXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uO4UN8fK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uO4UN8fK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62AEC2BCB0;
	Mon, 13 Apr 2026 08:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776068374;
	bh=71cdEnwfW+V/aTVliYHo8LtMEu/9UNBFEuRRzJd9geE=;
	h=Date:From:To:Cc:Subject:From;
	b=uO4UN8fKY4XcgzRZnmb1TuLKEI9JnpiUiyqFVC9Pys0Mjv/0lN51Pyt3EPbL5pAau
	 B3c2xHwKO8df9wcr3U5eFIrnV2raEsjrZvMzKTkKQFaCuDqaRx9ReZN71fB2IEH5yl
	 PcKMq/3Gpg5yIyabAqVl4XYnpwOWbj841gUo4uTlRIbYrmMHeFRiz8ZK1oli58V5y6
	 cDnqw0aV1EEagsD1Aqj7OAppDEzMtuyDv2nJuHfvfyiBWQs0S1dRRTeGMC4mBjSeX7
	 pNL5q+iM0+ykY/BcIpGHw90yP+ShyMmOTpnkpmU7KpK+adMvwbXnkNgBdQ6AbclCVL
	 EnjBMwiSk0cKQ==
Date: Mon, 13 Apr 2026 10:19:29 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Subject: [GIT PULL] Performance events changes for v7.1
Message-ID: <adynEfZ0r_GIu06k@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest perf/core Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2026-04-13

for you to fetch changes up to 5a84b600050c5f16b8bba25dd0e7aea845880407:

Performance events changes for v7.1:

Core updates:

 - Try to allocate task_ctx_data quickly, to optimize
   O(N^2) algorithm on large systems with O(100k) threads
   (Namhyung Kim)

AMD PMU driver IBS support updates and fixes, by Ravi Bangoria:

 - Fix interrupt accounting for discarded samples
 - Fix a Zen5-specific quirk
 - Fix PhyAddrVal handling
 - Fix NMI-safety with perf_allow_kernel()
 - Fix a race between event add and NMIs

Intel PMU driver updates:

 - Only check GP counters for PEBS constraints validation (Dapeng Mi)

MSR driver:

 - Turn SMI_COUNT and PPERF on by default, instead of a long
   list of CPU models to enable them on (Kan Liang)

Misc cleanups and fixes by Aldf Conte, Anshuman Khandual, Namhyung Kim,
Ravi Bangoria and Yen-Hsiang Hsu.

 Thanks,

	Ingo

------------------>
Aldo Conte (1):
      perf/x86/intel/p4: Fix unused variable warning in p4_pmu_init()

Anshuman Khandual (1):
      perf/events: Replace READ_ONCE() with standard pgtable accessors

Dapeng Mi (1):
      perf/x86/intel: Only check GP counters for PEBS constraints validation

Kan Liang (1):
      perf/x86/msr: Make SMI and PPERF on by default

Namhyung Kim (3):
      perf/core: Pass GFP flags to attach_task_ctx_data()
      perf/core: Try to allocate task_ctx_data quickly
      perf/core: Simplify __detach_global_ctx_data()

Ravi Bangoria (12):
      perf/amd/ibs: Account interrupt for discarded samples
      perf/amd/ibs: Limit ldlat->l3missonly dependency to Zen5
      perf/amd/ibs: Preserve PhyAddrVal bit when clearing PhyAddr MSR
      perf/amd/ibs: Avoid calling perf_allow_kernel() from the IBS NMI handler
      perf/amd/ibs: Avoid race between event add and NMI
      perf/amd/ibs: Define macro for ldlat mask and shift
      perf/amd/ibs: Add new MSRs and CPUID bits definitions
      perf/amd/ibs: Support IBS_{FETCH|OP}_CTL2[Dis] to eliminate RMW race
      perf/amd/ibs: Enable fetch latency filtering
      perf/amd/ibs: Enable RIP bit63 hardware filtering
      perf/amd/ibs: Enable streaming store filter
      perf/amd/ibs: Advertise remote socket capability

Yen-Hsiang Hsu (1):
      perf/x86/amd/ibs: Fix comment typo in ibs_op_data


 arch/x86/events/amd/ibs.c            | 264 ++++++++++++++++++++++++++++++++---
 arch/x86/events/intel/core.c         |  22 +--
 arch/x86/events/intel/p4.c           |   6 +-
 arch/x86/events/msr.c                |  82 +----------
 arch/x86/events/perf_event_flags.h   |   1 +
 arch/x86/include/asm/amd/ibs.h       |   6 +-
 arch/x86/include/asm/msr-index.h     |   2 +
 arch/x86/include/asm/perf_event.h    |  55 +++++---
 kernel/events/core.c                 |  43 +++---
 tools/arch/x86/include/asm/amd/ibs.h |   2 +-
 10 files changed, 331 insertions(+), 152 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index aca89f23d2e0..eeb607b84dda 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -32,6 +32,13 @@ static u32 ibs_caps;
 /* attr.config2 */
 #define IBS_SW_FILTER_MASK	1
 
+/* attr.config1 */
+#define IBS_OP_CONFIG1_LDLAT_MASK		(0xFFFULL <<  0)
+#define IBS_OP_CONFIG1_STRMST_MASK		    (1ULL << 12)
+#define IBS_OP_CONFIG1_STRMST_SHIFT			    (12)
+
+#define IBS_FETCH_CONFIG1_FETCHLAT_MASK		(0x7FFULL <<  0)
+
 /*
  * IBS states:
  *
@@ -83,9 +90,11 @@ struct cpu_perf_ibs {
 struct perf_ibs {
 	struct pmu			pmu;
 	unsigned int			msr;
+	unsigned int			msr2;
 	u64				config_mask;
 	u64				cnt_mask;
 	u64				enable_mask;
+	u64				disable_mask;
 	u64				valid_mask;
 	u16				min_period;
 	u64				max_period;
@@ -274,7 +283,23 @@ static bool perf_ibs_ldlat_event(struct perf_ibs *perf_ibs,
 {
 	return perf_ibs == &perf_ibs_op &&
 	       (ibs_caps & IBS_CAPS_OPLDLAT) &&
-	       (event->attr.config1 & 0xFFF);
+	       (event->attr.config1 & IBS_OP_CONFIG1_LDLAT_MASK);
+}
+
+static bool perf_ibs_fetch_lat_event(struct perf_ibs *perf_ibs,
+				     struct perf_event *event)
+{
+	return perf_ibs == &perf_ibs_fetch &&
+	       (ibs_caps & IBS_CAPS_FETCHLAT) &&
+	       (event->attr.config1 & IBS_FETCH_CONFIG1_FETCHLAT_MASK);
+}
+
+static bool perf_ibs_strmst_event(struct perf_ibs *perf_ibs,
+				  struct perf_event *event)
+{
+	return perf_ibs == &perf_ibs_op &&
+	       (ibs_caps & IBS_CAPS_STRMST_RMTSOCKET) &&
+	       (event->attr.config1 & IBS_OP_CONFIG1_STRMST_MASK);
 }
 
 static int perf_ibs_init(struct perf_event *event)
@@ -289,6 +314,8 @@ static int perf_ibs_init(struct perf_event *event)
 		return -ENOENT;
 
 	config = event->attr.config;
+	hwc->extra_reg.config = 0;
+	hwc->extra_reg.reg = 0;
 
 	if (event->pmu != &perf_ibs->pmu)
 		return -ENOENT;
@@ -304,15 +331,44 @@ static int perf_ibs_init(struct perf_event *event)
 	    event->attr.exclude_idle)
 		return -EINVAL;
 
-	if (!(event->attr.config2 & IBS_SW_FILTER_MASK) &&
-	    (event->attr.exclude_kernel || event->attr.exclude_user ||
-	     event->attr.exclude_hv))
-		return -EINVAL;
-
 	ret = validate_group(event);
 	if (ret)
 		return ret;
 
+	if (perf_allow_kernel())
+		hwc->flags |= PERF_X86_EVENT_UNPRIVILEGED;
+
+	if (ibs_caps & IBS_CAPS_DIS) {
+		hwc->extra_reg.config &= ~perf_ibs->disable_mask;
+		hwc->extra_reg.reg = perf_ibs->msr2;
+	}
+
+	if (ibs_caps & IBS_CAPS_BIT63_FILTER) {
+		if (perf_ibs == &perf_ibs_fetch) {
+			if (event->attr.exclude_kernel) {
+				hwc->extra_reg.config |= IBS_FETCH_2_EXCL_RIP_63_EQ_1;
+				hwc->extra_reg.reg = perf_ibs->msr2;
+			}
+			if (event->attr.exclude_user) {
+				hwc->extra_reg.config |= IBS_FETCH_2_EXCL_RIP_63_EQ_0;
+				hwc->extra_reg.reg = perf_ibs->msr2;
+			}
+		} else {
+			if (event->attr.exclude_kernel) {
+				hwc->extra_reg.config |= IBS_OP_2_EXCL_RIP_63_EQ_1;
+				hwc->extra_reg.reg = perf_ibs->msr2;
+			}
+			if (event->attr.exclude_user) {
+				hwc->extra_reg.config |= IBS_OP_2_EXCL_RIP_63_EQ_0;
+				hwc->extra_reg.reg = perf_ibs->msr2;
+			}
+		}
+	} else if (!(event->attr.config2 & IBS_SW_FILTER_MASK) &&
+		   (event->attr.exclude_kernel || event->attr.exclude_user ||
+		    event->attr.exclude_hv)) {
+		return -EINVAL;
+	}
+
 	if (hwc->sample_period) {
 		if (config & perf_ibs->cnt_mask)
 			/* raw max_cnt may not be set */
@@ -349,14 +405,37 @@ static int perf_ibs_init(struct perf_event *event)
 	}
 
 	if (perf_ibs_ldlat_event(perf_ibs, event)) {
-		u64 ldlat = event->attr.config1 & 0xFFF;
+		u64 ldlat = event->attr.config1 & IBS_OP_CONFIG1_LDLAT_MASK;
 
 		if (ldlat < 128 || ldlat > 2048)
 			return -EINVAL;
 		ldlat >>= 7;
 
-		config |= (ldlat - 1) << 59;
-		config |= IBS_OP_L3MISSONLY | IBS_OP_LDLAT_EN;
+		config |= (ldlat - 1) << IBS_OP_LDLAT_THRSH_SHIFT;
+
+		config |= IBS_OP_LDLAT_EN;
+		if (cpu_feature_enabled(X86_FEATURE_ZEN5))
+			config |= IBS_OP_L3MISSONLY;
+	}
+
+	if (perf_ibs_fetch_lat_event(perf_ibs, event)) {
+		u64 fetchlat = event->attr.config1 & IBS_FETCH_CONFIG1_FETCHLAT_MASK;
+
+		if (fetchlat < 128 || fetchlat > 1920)
+			return -EINVAL;
+		fetchlat >>= 7;
+
+		hwc->extra_reg.reg = perf_ibs->msr2;
+		hwc->extra_reg.config |= fetchlat << IBS_FETCH_2_FETCHLAT_FILTER_SHIFT;
+	}
+
+	if (perf_ibs_strmst_event(perf_ibs, event)) {
+		u64 strmst = event->attr.config1 & IBS_OP_CONFIG1_STRMST_MASK;
+
+		strmst >>= IBS_OP_CONFIG1_STRMST_SHIFT;
+
+		hwc->extra_reg.reg = perf_ibs->msr2;
+		hwc->extra_reg.config |= strmst << IBS_OP_2_STRM_ST_FILTER_SHIFT;
 	}
 
 	/*
@@ -439,6 +518,9 @@ static inline void perf_ibs_enable_event(struct perf_ibs *perf_ibs,
 		wrmsrq(hwc->config_base, tmp & ~perf_ibs->enable_mask);
 
 	wrmsrq(hwc->config_base, tmp | perf_ibs->enable_mask);
+
+	if (hwc->extra_reg.reg)
+		wrmsrq(hwc->extra_reg.reg, hwc->extra_reg.config);
 }
 
 /*
@@ -451,6 +533,11 @@ static inline void perf_ibs_enable_event(struct perf_ibs *perf_ibs,
 static inline void perf_ibs_disable_event(struct perf_ibs *perf_ibs,
 					  struct hw_perf_event *hwc, u64 config)
 {
+	if (ibs_caps & IBS_CAPS_DIS) {
+		wrmsrq(hwc->extra_reg.reg, perf_ibs->disable_mask);
+		return;
+	}
+
 	config &= ~perf_ibs->cnt_mask;
 	if (boot_cpu_data.x86 == 0x10)
 		wrmsrq(hwc->config_base, config);
@@ -487,6 +574,14 @@ static void perf_ibs_start(struct perf_event *event, int flags)
 	}
 	config |= period >> 4;
 
+	/*
+	 * Reset the IBS_{FETCH|OP}_CTL MSR before updating pcpu->state.
+	 * Doing so prevents a race condition in which an NMI due to other
+	 * source might accidentally activate the event before we enable
+	 * it ourselves.
+	 */
+	perf_ibs_disable_event(perf_ibs, hwc, 0);
+
 	/*
 	 * Set STARTED before enabling the hardware, such that a subsequent NMI
 	 * must observe it.
@@ -631,6 +726,11 @@ PMU_EVENT_ATTR_STRING(ldlat, ibs_op_ldlat_format, "config1:0-11");
 PMU_EVENT_ATTR_STRING(zen4_ibs_extensions, zen4_ibs_extensions, "1");
 PMU_EVENT_ATTR_STRING(ldlat, ibs_op_ldlat_cap, "1");
 PMU_EVENT_ATTR_STRING(dtlb_pgsize, ibs_op_dtlb_pgsize_cap, "1");
+PMU_EVENT_ATTR_STRING(fetchlat, ibs_fetch_lat_format, "config1:0-10");
+PMU_EVENT_ATTR_STRING(fetchlat, ibs_fetch_lat_cap, "1");
+PMU_EVENT_ATTR_STRING(strmst, ibs_op_strmst_format, "config1:12");
+PMU_EVENT_ATTR_STRING(strmst, ibs_op_strmst_cap, "1");
+PMU_EVENT_ATTR_STRING(rmtsocket, ibs_op_rmtsocket_cap, "1");
 
 static umode_t
 zen4_ibs_extensions_is_visible(struct kobject *kobj, struct attribute *attr, int i)
@@ -638,6 +738,24 @@ zen4_ibs_extensions_is_visible(struct kobject *kobj, struct attribute *attr, int
 	return ibs_caps & IBS_CAPS_ZEN4 ? attr->mode : 0;
 }
 
+static umode_t
+ibs_fetch_lat_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	return ibs_caps & IBS_CAPS_FETCHLAT ? attr->mode : 0;
+}
+
+static umode_t
+ibs_op_strmst_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	return ibs_caps & IBS_CAPS_STRMST_RMTSOCKET ? attr->mode : 0;
+}
+
+static umode_t
+ibs_op_rmtsocket_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	return ibs_caps & IBS_CAPS_STRMST_RMTSOCKET ? attr->mode : 0;
+}
+
 static umode_t
 ibs_op_ldlat_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 {
@@ -666,6 +784,16 @@ static struct attribute *zen4_ibs_extensions_attrs[] = {
 	NULL,
 };
 
+static struct attribute *ibs_fetch_lat_format_attrs[] = {
+	&ibs_fetch_lat_format.attr.attr,
+	NULL,
+};
+
+static struct attribute *ibs_fetch_lat_cap_attrs[] = {
+	&ibs_fetch_lat_cap.attr.attr,
+	NULL,
+};
+
 static struct attribute *ibs_op_ldlat_cap_attrs[] = {
 	&ibs_op_ldlat_cap.attr.attr,
 	NULL,
@@ -676,6 +804,16 @@ static struct attribute *ibs_op_dtlb_pgsize_cap_attrs[] = {
 	NULL,
 };
 
+static struct attribute *ibs_op_strmst_cap_attrs[] = {
+	&ibs_op_strmst_cap.attr.attr,
+	NULL,
+};
+
+static struct attribute *ibs_op_rmtsocket_cap_attrs[] = {
+	&ibs_op_rmtsocket_cap.attr.attr,
+	NULL,
+};
+
 static struct attribute_group group_fetch_formats = {
 	.name = "format",
 	.attrs = fetch_attrs,
@@ -693,6 +831,18 @@ static struct attribute_group group_zen4_ibs_extensions = {
 	.is_visible = zen4_ibs_extensions_is_visible,
 };
 
+static struct attribute_group group_ibs_fetch_lat_cap = {
+	.name = "caps",
+	.attrs = ibs_fetch_lat_cap_attrs,
+	.is_visible = ibs_fetch_lat_is_visible,
+};
+
+static struct attribute_group group_ibs_fetch_lat_format = {
+	.name = "format",
+	.attrs = ibs_fetch_lat_format_attrs,
+	.is_visible = ibs_fetch_lat_is_visible,
+};
+
 static struct attribute_group group_ibs_op_ldlat_cap = {
 	.name = "caps",
 	.attrs = ibs_op_ldlat_cap_attrs,
@@ -705,6 +855,18 @@ static struct attribute_group group_ibs_op_dtlb_pgsize_cap = {
 	.is_visible = ibs_op_dtlb_pgsize_is_visible,
 };
 
+static struct attribute_group group_ibs_op_strmst_cap = {
+	.name = "caps",
+	.attrs = ibs_op_strmst_cap_attrs,
+	.is_visible = ibs_op_strmst_is_visible,
+};
+
+static struct attribute_group group_ibs_op_rmtsocket_cap = {
+	.name = "caps",
+	.attrs = ibs_op_rmtsocket_cap_attrs,
+	.is_visible = ibs_op_rmtsocket_is_visible,
+};
+
 static const struct attribute_group *fetch_attr_groups[] = {
 	&group_fetch_formats,
 	&empty_caps_group,
@@ -714,6 +876,8 @@ static const struct attribute_group *fetch_attr_groups[] = {
 static const struct attribute_group *fetch_attr_update[] = {
 	&group_fetch_l3missonly,
 	&group_zen4_ibs_extensions,
+	&group_ibs_fetch_lat_cap,
+	&group_ibs_fetch_lat_format,
 	NULL,
 };
 
@@ -748,6 +912,11 @@ static struct attribute *ibs_op_ldlat_format_attrs[] = {
 	NULL,
 };
 
+static struct attribute *ibs_op_strmst_format_attrs[] = {
+	&ibs_op_strmst_format.attr.attr,
+	NULL,
+};
+
 static struct attribute_group group_cnt_ctl = {
 	.name = "format",
 	.attrs = cnt_ctl_attrs,
@@ -772,6 +941,12 @@ static struct attribute_group group_ibs_op_ldlat_format = {
 	.is_visible = ibs_op_ldlat_is_visible,
 };
 
+static struct attribute_group group_ibs_op_strmst_format = {
+	.name = "format",
+	.attrs = ibs_op_strmst_format_attrs,
+	.is_visible = ibs_op_strmst_is_visible,
+};
+
 static const struct attribute_group *op_attr_update[] = {
 	&group_cnt_ctl,
 	&group_op_l3missonly,
@@ -779,6 +954,9 @@ static const struct attribute_group *op_attr_update[] = {
 	&group_ibs_op_ldlat_cap,
 	&group_ibs_op_ldlat_format,
 	&group_ibs_op_dtlb_pgsize_cap,
+	&group_ibs_op_strmst_cap,
+	&group_ibs_op_strmst_format,
+	&group_ibs_op_rmtsocket_cap,
 	NULL,
 };
 
@@ -795,6 +973,7 @@ static struct perf_ibs perf_ibs_fetch = {
 		.check_period	= perf_ibs_check_period,
 	},
 	.msr			= MSR_AMD64_IBSFETCHCTL,
+	.msr2			= MSR_AMD64_IBSFETCHCTL2,
 	.config_mask		= IBS_FETCH_MAX_CNT | IBS_FETCH_RAND_EN,
 	.cnt_mask		= IBS_FETCH_MAX_CNT,
 	.enable_mask		= IBS_FETCH_ENABLE,
@@ -820,6 +999,7 @@ static struct perf_ibs perf_ibs_op = {
 		.check_period	= perf_ibs_check_period,
 	},
 	.msr			= MSR_AMD64_IBSOPCTL,
+	.msr2			= MSR_AMD64_IBSOPCTL2,
 	.config_mask		= IBS_OP_MAX_CNT,
 	.cnt_mask		= IBS_OP_MAX_CNT | IBS_OP_CUR_CNT |
 				  IBS_OP_CUR_CNT_RAND,
@@ -1155,7 +1335,8 @@ static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs,
 {
 	if (event->attr.sample_type & PERF_SAMPLE_RAW ||
 	    perf_ibs_is_mem_sample_type(perf_ibs, event) ||
-	    perf_ibs_ldlat_event(perf_ibs, event))
+	    perf_ibs_ldlat_event(perf_ibs, event) ||
+	    perf_ibs_fetch_lat_event(perf_ibs, event))
 		return perf_ibs->offset_max;
 	else if (check_rip)
 		return 3;
@@ -1190,7 +1371,7 @@ static bool perf_ibs_is_kernel_br_target(struct perf_event *event,
 			op_data.op_brn_ret && kernel_ip(br_target));
 }
 
-static bool perf_ibs_swfilt_discard(struct perf_ibs *perf_ibs, struct perf_event *event,
+static bool perf_ibs_discard_sample(struct perf_ibs *perf_ibs, struct perf_event *event,
 				    struct pt_regs *regs, struct perf_ibs_data *ibs_data,
 				    int br_target_idx)
 {
@@ -1214,12 +1395,10 @@ static void perf_ibs_phyaddr_clear(struct perf_ibs *perf_ibs,
 				   struct perf_ibs_data *ibs_data)
 {
 	if (perf_ibs == &perf_ibs_op) {
-		ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA3)] &= ~(1ULL << 18);
 		ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCPHYSAD)] = 0;
 		return;
 	}
 
-	ibs_data->regs[ibs_fetch_msr_idx(MSR_AMD64_IBSFETCHCTL)] &= ~(1ULL << 52);
 	ibs_data->regs[ibs_fetch_msr_idx(MSR_AMD64_IBSFETCHPHYSAD)] = 0;
 }
 
@@ -1293,8 +1472,20 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		 * within [128, 2048] range.
 		 */
 		if (!op_data3.ld_op || !op_data3.dc_miss ||
-		    op_data3.dc_miss_lat <= (event->attr.config1 & 0xFFF))
+		    op_data3.dc_miss_lat <= (event->attr.config1 & IBS_OP_CONFIG1_LDLAT_MASK)) {
+			throttle = perf_event_account_interrupt(event);
 			goto out;
+		}
+	}
+
+	if (perf_ibs_fetch_lat_event(perf_ibs, event)) {
+		union ibs_fetch_ctl fetch_ctl;
+
+		fetch_ctl.val = ibs_data.regs[ibs_fetch_msr_idx(MSR_AMD64_IBSFETCHCTL)];
+		if (fetch_ctl.fetch_lat < (event->attr.config1 & IBS_FETCH_CONFIG1_FETCHLAT_MASK)) {
+			throttle = perf_event_account_interrupt(event);
+			goto out;
+		}
 	}
 
 	/*
@@ -1326,15 +1517,18 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		regs.flags &= ~PERF_EFLAGS_EXACT;
 	} else {
 		/* Workaround for erratum #1197 */
-		if (perf_ibs->fetch_ignore_if_zero_rip && !(ibs_data.regs[1]))
+		if (perf_ibs->fetch_ignore_if_zero_rip && !(ibs_data.regs[1])) {
+			throttle = perf_event_account_interrupt(event);
 			goto out;
+		}
 
 		set_linear_ip(&regs, ibs_data.regs[1]);
 		regs.flags |= PERF_EFLAGS_EXACT;
 	}
 
-	if ((event->attr.config2 & IBS_SW_FILTER_MASK) &&
-	    perf_ibs_swfilt_discard(perf_ibs, event, &regs, &ibs_data, br_target_idx)) {
+	if (((ibs_caps & IBS_CAPS_BIT63_FILTER) ||
+	     (event->attr.config2 & IBS_SW_FILTER_MASK)) &&
+	    perf_ibs_discard_sample(perf_ibs, event, &regs, &ibs_data, br_target_idx)) {
 		throttle = perf_event_account_interrupt(event);
 		goto out;
 	}
@@ -1344,7 +1538,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	 * unprivileged users.
 	 */
 	if ((event->attr.sample_type & PERF_SAMPLE_RAW) &&
-	    perf_allow_kernel()) {
+	    (hwc->flags & PERF_X86_EVENT_UNPRIVILEGED)) {
 		perf_ibs_phyaddr_clear(perf_ibs, &ibs_data);
 	}
 
@@ -1375,6 +1569,9 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 
 out:
 	if (!throttle) {
+		if (ibs_caps & IBS_CAPS_DIS)
+			wrmsrq(hwc->extra_reg.reg, perf_ibs->disable_mask);
+
 		if (perf_ibs == &perf_ibs_op) {
 			if (ibs_caps & IBS_CAPS_OPCNTEXT) {
 				new_config = period & IBS_OP_MAX_CNT_EXT_MASK;
@@ -1446,6 +1643,9 @@ static __init int perf_ibs_fetch_init(void)
 	if (ibs_caps & IBS_CAPS_ZEN4)
 		perf_ibs_fetch.config_mask |= IBS_FETCH_L3MISSONLY;
 
+	if (ibs_caps & IBS_CAPS_DIS)
+		perf_ibs_fetch.disable_mask = IBS_FETCH_2_DIS;
+
 	perf_ibs_fetch.pmu.attr_groups = fetch_attr_groups;
 	perf_ibs_fetch.pmu.attr_update = fetch_attr_update;
 
@@ -1467,6 +1667,9 @@ static __init int perf_ibs_op_init(void)
 	if (ibs_caps & IBS_CAPS_ZEN4)
 		perf_ibs_op.config_mask |= IBS_OP_L3MISSONLY;
 
+	if (ibs_caps & IBS_CAPS_DIS)
+		perf_ibs_op.disable_mask = IBS_OP_2_DIS;
+
 	perf_ibs_op.pmu.attr_groups = op_attr_groups;
 	perf_ibs_op.pmu.attr_update = op_attr_update;
 
@@ -1713,6 +1916,23 @@ static void clear_APIC_ibs(void)
 static int x86_pmu_amd_ibs_starting_cpu(unsigned int cpu)
 {
 	setup_APIC_ibs();
+
+	if (ibs_caps & IBS_CAPS_DIS) {
+		/*
+		 * IBS enable sequence:
+		 *   CTL[En] = 1;
+		 *   CTL2[Dis] = 0;
+		 *
+		 * IBS disable sequence:
+		 *   CTL2[Dis] = 1;
+		 *
+		 * Set CTL2[Dis] when CPU comes up. This is needed to make
+		 * enable sequence effective.
+		 */
+		wrmsrq(MSR_AMD64_IBSFETCHCTL2, IBS_FETCH_2_DIS);
+		wrmsrq(MSR_AMD64_IBSOPCTL2, IBS_OP_2_DIS);
+	}
+
 	return 0;
 }
 
@@ -1771,6 +1991,14 @@ static __init int amd_ibs_init(void)
 
 	perf_ibs_pm_init();
 
+#ifdef CONFIG_X86_32
+	/*
+	 * IBS_CAPS_BIT63_FILTER is used for exclude_kernel/user filtering,
+	 * which obviously won't work for 32 bit kernel.
+	 */
+	caps &= ~IBS_CAPS_BIT63_FILTER;
+#endif
+
 	ibs_caps = caps;
 	/* make ibs_caps visible to other cpus: */
 	smp_mb();
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index cf3a4fe06ff2..4768236c054b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5770,7 +5770,7 @@ static void __intel_pmu_check_dyn_constr(struct event_constraint *constr,
 			}
 
 			if (check_fail) {
-				pr_info("The two events 0x%llx and 0x%llx may not be "
+				pr_warn("The two events 0x%llx and 0x%llx may not be "
 					"fully scheduled under some circumstances as "
 					"%s.\n",
 					c1->code, c2->code, dyn_constr_type_name[type]);
@@ -5783,6 +5783,7 @@ static void intel_pmu_check_dyn_constr(struct pmu *pmu,
 				       struct event_constraint *constr,
 				       u64 cntr_mask)
 {
+	u64 gp_mask = GENMASK_ULL(INTEL_PMC_MAX_GENERIC - 1, 0);
 	enum dyn_constr_type i;
 	u64 mask;
 
@@ -5797,20 +5798,25 @@ static void intel_pmu_check_dyn_constr(struct pmu *pmu,
 				mask = x86_pmu.lbr_counters;
 			break;
 		case DYN_CONSTR_ACR_CNTR:
-			mask = hybrid(pmu, acr_cntr_mask64) & GENMASK_ULL(INTEL_PMC_MAX_GENERIC - 1, 0);
+			mask = hybrid(pmu, acr_cntr_mask64) & gp_mask;
 			break;
 		case DYN_CONSTR_ACR_CAUSE:
-			if (hybrid(pmu, acr_cntr_mask64) == hybrid(pmu, acr_cause_mask64))
+			if (hybrid(pmu, acr_cntr_mask64) ==
+					hybrid(pmu, acr_cause_mask64))
 				continue;
-			mask = hybrid(pmu, acr_cause_mask64) & GENMASK_ULL(INTEL_PMC_MAX_GENERIC - 1, 0);
+			mask = hybrid(pmu, acr_cause_mask64) & gp_mask;
 			break;
 		case DYN_CONSTR_PEBS:
-			if (x86_pmu.arch_pebs)
-				mask = hybrid(pmu, arch_pebs_cap).counters;
+			if (x86_pmu.arch_pebs) {
+				mask = hybrid(pmu, arch_pebs_cap).counters &
+				       gp_mask;
+			}
 			break;
 		case DYN_CONSTR_PDIST:
-			if (x86_pmu.arch_pebs)
-				mask = hybrid(pmu, arch_pebs_cap).pdists;
+			if (x86_pmu.arch_pebs) {
+				mask = hybrid(pmu, arch_pebs_cap).pdists &
+				       gp_mask;
+			}
 			break;
 		default:
 			pr_warn("Unsupported dynamic constraint type %d\n", i);
diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
index e5fd7367e45d..02bfdb77158b 100644
--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -1367,14 +1367,14 @@ static __initconst const struct x86_pmu p4_pmu = {
 
 __init int p4_pmu_init(void)
 {
-	unsigned int low, high;
+	unsigned int misc;
 	int i, reg;
 
 	/* If we get stripped -- indexing fails */
 	BUILD_BUG_ON(ARCH_P4_MAX_CCCR > INTEL_PMC_MAX_GENERIC);
 
-	rdmsr(MSR_IA32_MISC_ENABLE, low, high);
-	if (!(low & (1 << 7))) {
+	rdmsrq(MSR_IA32_MISC_ENABLE, misc);
+	if (!(misc & MSR_IA32_MISC_ENABLE_EMON)) {
 		pr_cont("unsupported Netburst CPU model %d ",
 			boot_cpu_data.x86_model);
 		return -ENODEV;
diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 8052596b8503..76d6418c5055 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -2,7 +2,6 @@
 #include <linux/perf_event.h>
 #include <linux/sysfs.h>
 #include <linux/nospec.h>
-#include <asm/cpu_device_id.h>
 #include <asm/msr.h>
 
 #include "probe.h"
@@ -41,86 +40,11 @@ static bool test_therm_status(int idx, void *data)
 
 static bool test_intel(int idx, void *data)
 {
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL ||
-	    boot_cpu_data.x86 != 6)
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return false;
 
-	switch (boot_cpu_data.x86_vfm) {
-	case INTEL_NEHALEM:
-	case INTEL_NEHALEM_G:
-	case INTEL_NEHALEM_EP:
-	case INTEL_NEHALEM_EX:
-
-	case INTEL_WESTMERE:
-	case INTEL_WESTMERE_EP:
-	case INTEL_WESTMERE_EX:
-
-	case INTEL_SANDYBRIDGE:
-	case INTEL_SANDYBRIDGE_X:
-
-	case INTEL_IVYBRIDGE:
-	case INTEL_IVYBRIDGE_X:
-
-	case INTEL_HASWELL:
-	case INTEL_HASWELL_X:
-	case INTEL_HASWELL_L:
-	case INTEL_HASWELL_G:
-
-	case INTEL_BROADWELL:
-	case INTEL_BROADWELL_D:
-	case INTEL_BROADWELL_G:
-	case INTEL_BROADWELL_X:
-	case INTEL_SAPPHIRERAPIDS_X:
-	case INTEL_EMERALDRAPIDS_X:
-	case INTEL_GRANITERAPIDS_X:
-	case INTEL_GRANITERAPIDS_D:
-
-	case INTEL_ATOM_SILVERMONT:
-	case INTEL_ATOM_SILVERMONT_D:
-	case INTEL_ATOM_AIRMONT:
-	case INTEL_ATOM_AIRMONT_NP:
-
-	case INTEL_ATOM_GOLDMONT:
-	case INTEL_ATOM_GOLDMONT_D:
-	case INTEL_ATOM_GOLDMONT_PLUS:
-	case INTEL_ATOM_TREMONT_D:
-	case INTEL_ATOM_TREMONT:
-	case INTEL_ATOM_TREMONT_L:
-
-	case INTEL_XEON_PHI_KNL:
-	case INTEL_XEON_PHI_KNM:
-		if (idx == PERF_MSR_SMI)
-			return true;
-		break;
-
-	case INTEL_SKYLAKE_L:
-	case INTEL_SKYLAKE:
-	case INTEL_SKYLAKE_X:
-	case INTEL_KABYLAKE_L:
-	case INTEL_KABYLAKE:
-	case INTEL_COMETLAKE_L:
-	case INTEL_COMETLAKE:
-	case INTEL_ICELAKE_L:
-	case INTEL_ICELAKE:
-	case INTEL_ICELAKE_X:
-	case INTEL_ICELAKE_D:
-	case INTEL_TIGERLAKE_L:
-	case INTEL_TIGERLAKE:
-	case INTEL_ROCKETLAKE:
-	case INTEL_ALDERLAKE:
-	case INTEL_ALDERLAKE_L:
-	case INTEL_ATOM_GRACEMONT:
-	case INTEL_RAPTORLAKE:
-	case INTEL_RAPTORLAKE_P:
-	case INTEL_RAPTORLAKE_S:
-	case INTEL_METEORLAKE:
-	case INTEL_METEORLAKE_L:
-		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
-			return true;
-		break;
-	}
-
-	return false;
+	/* Rely on perf_msr_probe() to check the availability */
+	return true;
 }
 
 PMU_EVENT_ATTR_STRING(tsc,				attr_tsc,		"event=0x00"	);
diff --git a/arch/x86/events/perf_event_flags.h b/arch/x86/events/perf_event_flags.h
index 70078334e4a3..47f84ee8f540 100644
--- a/arch/x86/events/perf_event_flags.h
+++ b/arch/x86/events/perf_event_flags.h
@@ -23,3 +23,4 @@ PERF_ARCH(PEBS_LAT_HYBRID,	0x0020000) /* ld and st lat for hybrid */
 PERF_ARCH(NEEDS_BRANCH_STACK,	0x0040000) /* require branch stack setup */
 PERF_ARCH(BRANCH_COUNTERS,	0x0080000) /* logs the counters in the extra space of each branch */
 PERF_ARCH(ACR,			0x0100000) /* Auto counter reload */
+PERF_ARCH(UNPRIVILEGED,		0x0200000) /* Unprivileged event (wrt perf_allow_kernel()) */
diff --git a/arch/x86/include/asm/amd/ibs.h b/arch/x86/include/asm/amd/ibs.h
index fcc8a5abe54e..68e24a1736d0 100644
--- a/arch/x86/include/asm/amd/ibs.h
+++ b/arch/x86/include/asm/amd/ibs.h
@@ -77,7 +77,7 @@ union ibs_op_data {
 	__u64 val;
 	struct {
 		__u64	comp_to_ret_ctr:16,	/* 0-15: op completion to retire count */
-			tag_to_ret_ctr:16,	/* 15-31: op tag to retire count */
+			tag_to_ret_ctr:16,	/* 16-31: op tag to retire count */
 			reserved1:2,		/* 32-33: reserved */
 			op_return:1,		/* 34: return op */
 			op_brn_taken:1,		/* 35: taken branch op */
@@ -99,7 +99,9 @@ union ibs_op_data2 {
 			rmt_node:1,	/* 4: destination node */
 			cache_hit_st:1,	/* 5: cache hit state */
 			data_src_hi:2,	/* 6-7: data source high */
-			reserved1:56;	/* 8-63: reserved */
+			strm_st:1,	/* 8: streaming store */
+			rmt_socket:1,   /* 9: remote socket */
+			reserved1:54;   /* 10-63: reserved */
 	};
 };
 
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index da5275d8eda6..e25434d21159 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -698,6 +698,8 @@
 #define MSR_AMD64_IBSBRTARGET		0xc001103b
 #define MSR_AMD64_ICIBSEXTDCTL		0xc001103c
 #define MSR_AMD64_IBSOPDATA4		0xc001103d
+#define MSR_AMD64_IBSOPCTL2		0xc001103e
+#define MSR_AMD64_IBSFETCHCTL2		0xc001103f
 #define MSR_AMD64_IBS_REG_COUNT_MAX	8 /* includes MSR_AMD64_IBSBRTARGET */
 #define MSR_AMD64_SVM_AVIC_DOORBELL	0xc001011b
 #define MSR_AMD64_VM_PAGE_FLUSH		0xc001011e
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index ff5acb8b199b..752cb319d5ea 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -643,6 +643,10 @@ struct arch_pebs_cntr_header {
 #define IBS_CAPS_OPDATA4		(1U<<10)
 #define IBS_CAPS_ZEN4			(1U<<11)
 #define IBS_CAPS_OPLDLAT		(1U<<12)
+#define IBS_CAPS_DIS			(1U<<13)
+#define IBS_CAPS_FETCHLAT		(1U<<14)
+#define IBS_CAPS_BIT63_FILTER		(1U<<15)
+#define IBS_CAPS_STRMST_RMTSOCKET	(1U<<16)
 #define IBS_CAPS_OPDTLBPGSIZE		(1U<<19)
 
 #define IBS_CAPS_DEFAULT		(IBS_CAPS_AVAIL		\
@@ -657,31 +661,44 @@ struct arch_pebs_cntr_header {
 #define IBSCTL_LVT_OFFSET_MASK		0x0F
 
 /* IBS fetch bits/masks */
-#define IBS_FETCH_L3MISSONLY	(1ULL<<59)
-#define IBS_FETCH_RAND_EN	(1ULL<<57)
-#define IBS_FETCH_VAL		(1ULL<<49)
-#define IBS_FETCH_ENABLE	(1ULL<<48)
-#define IBS_FETCH_CNT		0xFFFF0000ULL
-#define IBS_FETCH_MAX_CNT	0x0000FFFFULL
+#define IBS_FETCH_L3MISSONLY		      (1ULL << 59)
+#define IBS_FETCH_RAND_EN		      (1ULL << 57)
+#define IBS_FETCH_VAL			      (1ULL << 49)
+#define IBS_FETCH_ENABLE		      (1ULL << 48)
+#define IBS_FETCH_CNT			     0xFFFF0000ULL
+#define IBS_FETCH_MAX_CNT		     0x0000FFFFULL
+
+#define IBS_FETCH_2_DIS			      (1ULL <<  0)
+#define IBS_FETCH_2_FETCHLAT_FILTER	    (0xFULL <<  1)
+#define IBS_FETCH_2_FETCHLAT_FILTER_SHIFT	       (1)
+#define IBS_FETCH_2_EXCL_RIP_63_EQ_1	      (1ULL <<  5)
+#define IBS_FETCH_2_EXCL_RIP_63_EQ_0	      (1ULL <<  6)
 
 /*
  * IBS op bits/masks
  * The lower 7 bits of the current count are random bits
  * preloaded by hardware and ignored in software
  */
-#define IBS_OP_LDLAT_EN		(1ULL<<63)
-#define IBS_OP_LDLAT_THRSH	(0xFULL<<59)
-#define IBS_OP_CUR_CNT		(0xFFF80ULL<<32)
-#define IBS_OP_CUR_CNT_RAND	(0x0007FULL<<32)
-#define IBS_OP_CUR_CNT_EXT_MASK	(0x7FULL<<52)
-#define IBS_OP_CNT_CTL		(1ULL<<19)
-#define IBS_OP_VAL		(1ULL<<18)
-#define IBS_OP_ENABLE		(1ULL<<17)
-#define IBS_OP_L3MISSONLY	(1ULL<<16)
-#define IBS_OP_MAX_CNT		0x0000FFFFULL
-#define IBS_OP_MAX_CNT_EXT	0x007FFFFFULL	/* not a register bit mask */
-#define IBS_OP_MAX_CNT_EXT_MASK	(0x7FULL<<20)	/* separate upper 7 bits */
-#define IBS_RIP_INVALID		(1ULL<<38)
+#define IBS_OP_LDLAT_EN			      (1ULL << 63)
+#define IBS_OP_LDLAT_THRSH		    (0xFULL << 59)
+#define IBS_OP_LDLAT_THRSH_SHIFT		      (59)
+#define IBS_OP_CUR_CNT			(0xFFF80ULL << 32)
+#define IBS_OP_CUR_CNT_RAND		(0x0007FULL << 32)
+#define IBS_OP_CUR_CNT_EXT_MASK		   (0x7FULL << 52)
+#define IBS_OP_CNT_CTL			      (1ULL << 19)
+#define IBS_OP_VAL			      (1ULL << 18)
+#define IBS_OP_ENABLE			      (1ULL << 17)
+#define IBS_OP_L3MISSONLY		      (1ULL << 16)
+#define IBS_OP_MAX_CNT			     0x0000FFFFULL
+#define IBS_OP_MAX_CNT_EXT		     0x007FFFFFULL	/* not a register bit mask */
+#define IBS_OP_MAX_CNT_EXT_MASK		   (0x7FULL << 20)	/* separate upper 7 bits */
+#define IBS_RIP_INVALID			      (1ULL << 38)
+
+#define IBS_OP_2_DIS			      (1ULL <<  0)
+#define IBS_OP_2_EXCL_RIP_63_EQ_0	      (1ULL <<  1)
+#define IBS_OP_2_EXCL_RIP_63_EQ_1	      (1ULL <<  2)
+#define IBS_OP_2_STRM_ST_FILTER		      (1ULL <<  3)
+#define IBS_OP_2_STRM_ST_FILTER_SHIFT		       (3)
 
 #ifdef CONFIG_X86_LOCAL_APIC
 extern u32 get_ibs_caps(void);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index ac70d68217b6..95d7a3e57268 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5370,15 +5370,15 @@ static void unaccount_freq_event(void)
 
 
 static struct perf_ctx_data *
-alloc_perf_ctx_data(struct kmem_cache *ctx_cache, bool global)
+alloc_perf_ctx_data(struct kmem_cache *ctx_cache, bool global, gfp_t gfp_flags)
 {
 	struct perf_ctx_data *cd;
 
-	cd = kzalloc_obj(*cd);
+	cd = kzalloc_obj(*cd, gfp_flags);
 	if (!cd)
 		return NULL;
 
-	cd->data = kmem_cache_zalloc(ctx_cache, GFP_KERNEL);
+	cd->data = kmem_cache_zalloc(ctx_cache, gfp_flags);
 	if (!cd->data) {
 		kfree(cd);
 		return NULL;
@@ -5412,11 +5412,11 @@ static inline void perf_free_ctx_data_rcu(struct perf_ctx_data *cd)
 
 static int
 attach_task_ctx_data(struct task_struct *task, struct kmem_cache *ctx_cache,
-		     bool global)
+		     bool global, gfp_t gfp_flags)
 {
 	struct perf_ctx_data *cd, *old = NULL;
 
-	cd = alloc_perf_ctx_data(ctx_cache, global);
+	cd = alloc_perf_ctx_data(ctx_cache, global, gfp_flags);
 	if (!cd)
 		return -ENOMEM;
 
@@ -5489,6 +5489,12 @@ attach_global_ctx_data(struct kmem_cache *ctx_cache)
 					cd = NULL;
 			}
 			if (!cd) {
+				/*
+				 * Try to allocate context quickly before
+				 * traversing the whole thread list again.
+				 */
+				if (!attach_task_ctx_data(p, ctx_cache, true, GFP_NOWAIT))
+					continue;
 				get_task_struct(p);
 				goto alloc;
 			}
@@ -5499,7 +5505,7 @@ attach_global_ctx_data(struct kmem_cache *ctx_cache)
 
 	return 0;
 alloc:
-	ret = attach_task_ctx_data(p, ctx_cache, true);
+	ret = attach_task_ctx_data(p, ctx_cache, true, GFP_KERNEL);
 	put_task_struct(p);
 	if (ret) {
 		__detach_global_ctx_data();
@@ -5519,7 +5525,7 @@ attach_perf_ctx_data(struct perf_event *event)
 		return -ENOMEM;
 
 	if (task)
-		return attach_task_ctx_data(task, ctx_cache, false);
+		return attach_task_ctx_data(task, ctx_cache, false, GFP_KERNEL);
 
 	ret = attach_global_ctx_data(ctx_cache);
 	if (ret)
@@ -5554,22 +5560,15 @@ static void __detach_global_ctx_data(void)
 	struct task_struct *g, *p;
 	struct perf_ctx_data *cd;
 
-again:
 	scoped_guard (rcu) {
 		for_each_process_thread(g, p) {
 			cd = rcu_dereference(p->perf_ctx_data);
-			if (!cd || !cd->global)
-				continue;
-			cd->global = 0;
-			get_task_struct(p);
-			goto detach;
+			if (cd && cd->global) {
+				cd->global = 0;
+				detach_task_ctx_data(p);
+			}
 		}
 	}
-	return;
-detach:
-	detach_task_ctx_data(p);
-	put_task_struct(p);
-	goto again;
 }
 
 static void detach_global_ctx_data(void)
@@ -8422,7 +8421,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 	pte_t *ptep, pte;
 
 	pgdp = pgd_offset(mm, addr);
-	pgd = READ_ONCE(*pgdp);
+	pgd = pgdp_get(pgdp);
 	if (pgd_none(pgd))
 		return 0;
 
@@ -8430,7 +8429,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 		return pgd_leaf_size(pgd);
 
 	p4dp = p4d_offset_lockless(pgdp, pgd, addr);
-	p4d = READ_ONCE(*p4dp);
+	p4d = p4dp_get(p4dp);
 	if (!p4d_present(p4d))
 		return 0;
 
@@ -8438,7 +8437,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 		return p4d_leaf_size(p4d);
 
 	pudp = pud_offset_lockless(p4dp, p4d, addr);
-	pud = READ_ONCE(*pudp);
+	pud = pudp_get(pudp);
 	if (!pud_present(pud))
 		return 0;
 
@@ -9240,7 +9239,7 @@ perf_event_alloc_task_data(struct task_struct *child,
 
 	return;
 attach:
-	attach_task_ctx_data(child, ctx_cache, true);
+	attach_task_ctx_data(child, ctx_cache, true, GFP_KERNEL);
 }
 
 void perf_event_fork(struct task_struct *task)
diff --git a/tools/arch/x86/include/asm/amd/ibs.h b/tools/arch/x86/include/asm/amd/ibs.h
index cbce54fec7b9..25c00000f698 100644
--- a/tools/arch/x86/include/asm/amd/ibs.h
+++ b/tools/arch/x86/include/asm/amd/ibs.h
@@ -77,7 +77,7 @@ union ibs_op_data {
 	__u64 val;
 	struct {
 		__u64	comp_to_ret_ctr:16,	/* 0-15: op completion to retire count */
-			tag_to_ret_ctr:16,	/* 15-31: op tag to retire count */
+			tag_to_ret_ctr:16,	/* 16-31: op tag to retire count */
 			reserved1:2,		/* 32-33: reserved */
 			op_return:1,		/* 34: return op */
 			op_brn_taken:1,		/* 35: taken branch op */
