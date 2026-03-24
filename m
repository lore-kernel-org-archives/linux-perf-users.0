Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F721DDA24;
	Tue, 24 Mar 2026 00:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774313214; cv=none; b=ZwtNLZmNEti6KFIKzJfjquajuelEyaJQl+Ig1j43v9xq/45XQEqOrGH/R0zCH4K9/Z8qoW8VNyvCAJSTKZjaEfV7qFa5anXUff9IG3Si1jnUAMq3CHHZdNdttEaa+/tvRmURA7b+cm1ttWfsAHeEGNss+27JpT5M8f98cdRPhEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774313214; c=relaxed/simple;
	bh=2uh5gTN+vxslqRbGjcoYFR9DDWbPcMZAhwhy7N4FqSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=anIhgRGUH+ZZTDLj1z/1uLa4QOggfHuVnU5YWGtpTKzgmW5HE/Wcs4fJewmOKwuyuGbSAAidHhMyv3HsLgBqSLOxQ23XIxaf5AIAkLjLqiYFoB3WZ1fAOw/XPlUhTcL1hAaa6EhgZ9MC/PTUs7mweCcYarMXVLpFRog2M83X1qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DRBRBwwl; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DRBRBwwl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774313213; x=1805849213;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2uh5gTN+vxslqRbGjcoYFR9DDWbPcMZAhwhy7N4FqSk=;
  b=DRBRBwwlSs/y/YIDW0u79pN6wGjOFARRol0YGaxjYNLX2su4OsNfW+ql
   bakYvESECY1vCAefWCyoKRoU5HNNfPyhLqzeydzCuEf+Gjd0EWGpai8Sh
   qRoBRuIhR31laiOkx4AGqK+VDkd1QpJZq/WYaAsqcCmB6J6090xBqZqdM
   sjfgbpSgUhi/G6EQbdJdIS2s8UtNDsjSV9ryCql1lksEmEKMQkxzxyFV+
   m0yKf4vqdoYYsHaAkBAavCeSdoPMG3nSQdjviMzOPvami0M4VmOba4JHx
   RjorW1K7DL7BFEvR3U8jhm9mEpiaW/bWUUWqycgRsY6G3PhbS8lppB/k4
   Q==;
X-CSE-ConnectionGUID: F8/+wA3cRsa6zUFQbKVodw==
X-CSE-MsgGUID: Z8FiCYRwQm+XRrku0DIDXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86397154"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86397154"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 17:46:52 -0700
X-CSE-ConnectionGUID: OdpZ0cHeRimpClp3AskZlw==
X-CSE-MsgGUID: TwsnQDJJTD6uxylUZl/THA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="221322823"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 23 Mar 2026 17:46:48 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v7 13/24] perf: Add sampling support for SIMD registers
Date: Tue, 24 Mar 2026 08:41:07 +0800
Message-Id: <20260324004118.3772171-14-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324004118.3772171-1-dapeng1.mi@linux.intel.com>
References: <20260324004118.3772171-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Users may be interested in sampling SIMD registers during profiling.
The current sample_regs_* structure does not have sufficient space
for all SIMD registers.

To address this, new attribute fields sample_simd_{pred,vec}_reg_* are
added to struct perf_event_attr to represent the SIMD registers that are
expected to be sampled.

Currently, the perf/x86 code supports XMM registers in sample_regs_*.
To unify the configuration of SIMD registers and ensure a consistent
method for configuring XMM and other SIMD registers, a new event
attribute field, sample_simd_regs_enabled, is introduced. When
sample_simd_regs_enabled is set, it indicates that all SIMD registers,
including XMM, will be represented by the newly introduced
sample_simd_{pred|vec}_reg_* fields. The original XMM space in
sample_regs_* is reserved for future uses.

Since SIMD registers are wider than 64 bits, a new output format is
introduced. The number and width of SIMD registers are dumped first,
followed by the register values. The number and width are based on the
user's configuration. If they differ (e.g., on ARM), an ARCH-specific
perf_output_sample_simd_regs function can be implemented separately.

A new ABI, PERF_SAMPLE_REGS_ABI_SIMD, is added to indicate the new format.
The enum perf_sample_regs_abi is now a bitmap. This change should not
impact existing tools, as the version and bitmap remain the same for
values 1 and 2.

Additionally, two new __weak functions are introduced:
- perf_simd_reg_value(): Retrieves the value of the requested SIMD
  register.
- perf_simd_reg_validate(): Validates the configuration of the SIMD
  registers.

A new flag, PERF_PMU_CAP_SIMD_REGS, is added to indicate that the PMU
supports SIMD register dumping. An error is generated if
sample_simd_{pred|vec}_reg_* is mistakenly set for a PMU that does not
support this capability.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---

V7: Add macro word_for_each_set_bit() to simplify u64 set-bit iteration.

 include/linux/perf_event.h      |   8 +++
 include/linux/perf_regs.h       |   4 ++
 include/uapi/linux/perf_event.h |  50 ++++++++++++++--
 kernel/events/core.c            | 102 +++++++++++++++++++++++++++++---
 tools/perf/util/header.c        |   3 +-
 5 files changed, 153 insertions(+), 14 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e8b0d8e2d2af..137d6e4a3403 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -306,6 +306,7 @@ struct perf_event_pmu_context;
 #define PERF_PMU_CAP_AUX_PAUSE		0x0200
 #define PERF_PMU_CAP_AUX_PREFER_LARGE	0x0400
 #define PERF_PMU_CAP_MEDIATED_VPMU	0x0800
+#define PERF_PMU_CAP_SIMD_REGS		0x1000
 
 /**
  * pmu::scope
@@ -1534,6 +1535,13 @@ perf_event__output_id_sample(struct perf_event *event,
 extern void
 perf_log_lost_samples(struct perf_event *event, u64 lost);
 
+static inline bool event_has_simd_regs(struct perf_event *event)
+{
+	struct perf_event_attr *attr = &event->attr;
+
+	return attr->sample_simd_regs_enabled != 0;
+}
+
 static inline bool event_has_extended_regs(struct perf_event *event)
 {
 	struct perf_event_attr *attr = &event->attr;
diff --git a/include/linux/perf_regs.h b/include/linux/perf_regs.h
index 144bcc3ff19f..518f28c6a7d4 100644
--- a/include/linux/perf_regs.h
+++ b/include/linux/perf_regs.h
@@ -14,6 +14,10 @@ int perf_reg_validate(u64 mask);
 u64 perf_reg_abi(struct task_struct *task);
 void perf_get_regs_user(struct perf_regs *regs_user,
 			struct pt_regs *regs);
+int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
+			   u16 pred_qwords, u32 pred_mask);
+u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
+			u16 qwords_idx, bool pred);
 
 #ifdef CONFIG_HAVE_PERF_REGS
 #include <asm/perf_regs.h>
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index fd10aa8d697f..b8c8953928f8 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -314,8 +314,9 @@ enum {
  */
 enum perf_sample_regs_abi {
 	PERF_SAMPLE_REGS_ABI_NONE		= 0,
-	PERF_SAMPLE_REGS_ABI_32			= 1,
-	PERF_SAMPLE_REGS_ABI_64			= 2,
+	PERF_SAMPLE_REGS_ABI_32			= (1 << 0),
+	PERF_SAMPLE_REGS_ABI_64			= (1 << 1),
+	PERF_SAMPLE_REGS_ABI_SIMD		= (1 << 2),
 };
 
 /*
@@ -383,6 +384,7 @@ enum perf_event_read_format {
 #define PERF_ATTR_SIZE_VER7			128	/* Add: sig_data */
 #define PERF_ATTR_SIZE_VER8			136	/* Add: config3 */
 #define PERF_ATTR_SIZE_VER9			144	/* add: config4 */
+#define PERF_ATTR_SIZE_VER10			176	/* Add: sample_simd_{pred,vec}_reg_* */
 
 /*
  * 'struct perf_event_attr' contains various attributes that define
@@ -547,6 +549,30 @@ struct perf_event_attr {
 
 	__u64	config3; /* extension of config2 */
 	__u64	config4; /* extension of config3 */
+
+	/*
+	 * Defines the sampling SIMD/PRED registers bitmap and qwords
+	 * (8 bytes) length.
+	 *
+	 * sample_simd_regs_enabled != 0 indicates there are SIMD/PRED registers
+	 * to be sampled, the SIMD/PRED registers bitmap and qwords length are
+	 * represented in sample_{simd|pred}_pred_reg_{intr|user} and
+	 * sample_simd_{vec|pred}_reg_qwords fields.
+	 *
+	 * sample_simd_regs_enabled == 0 indicates no SIMD/PRED registers are
+	 * sampled.
+	 */
+	union {
+		__u16 sample_simd_regs_enabled;
+		__u16 sample_simd_pred_reg_qwords;
+	};
+	__u16	sample_simd_vec_reg_qwords;
+	__u32	__reserved_4;
+
+	__u32	sample_simd_pred_reg_intr;
+	__u32	sample_simd_pred_reg_user;
+	__u64	sample_simd_vec_reg_intr;
+	__u64	sample_simd_vec_reg_user;
 };
 
 /*
@@ -1020,7 +1046,15 @@ enum perf_event_type {
 	 *      } && PERF_SAMPLE_BRANCH_STACK
 	 *
 	 *	{ u64			abi; # enum perf_sample_regs_abi
-	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_USER
+	 *	  u64			regs[weight(mask)];
+	 *	  struct {
+	 *		u16 nr_vectors;		# 0 ... weight(sample_simd_vec_reg_user)
+	 *		u16 vector_qwords;	# 0 ... sample_simd_vec_reg_qwords
+	 *		u16 nr_pred;		# 0 ... weight(sample_simd_pred_reg_user)
+	 *		u16 pred_qwords;	# 0 ... sample_simd_pred_reg_qwords
+	 *		u64 data[nr_vectors * vector_qwords + nr_pred * pred_qwords];
+	 *	  } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
+	 *	} && PERF_SAMPLE_REGS_USER
 	 *
 	 *	{ u64			size;
 	 *	  char			data[size];
@@ -1047,7 +1081,15 @@ enum perf_event_type {
 	 *	{ u64			data_src; } && PERF_SAMPLE_DATA_SRC
 	 *	{ u64			transaction; } && PERF_SAMPLE_TRANSACTION
 	 *	{ u64			abi; # enum perf_sample_regs_abi
-	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
+	 *	  u64			regs[weight(mask)];
+	 *	  struct {
+	 *		u16 nr_vectors;		# 0 ... weight(sample_simd_vec_reg_intr)
+	 *		u16 vector_qwords;	# 0 ... sample_simd_vec_reg_qwords
+	 *		u16 nr_pred;		# 0 ... weight(sample_simd_pred_reg_intr)
+	 *		u16 pred_qwords;	# 0 ... sample_simd_pred_reg_qwords
+	 *		u64 data[nr_vectors * vector_qwords + nr_pred * pred_qwords];
+	 *	  } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
+	 *	} && PERF_SAMPLE_REGS_INTR
 	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
 	 *	{ u64			cgroup;} && PERF_SAMPLE_CGROUP
 	 *	{ u64			data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7558bc5b1e73..de42575f517b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7753,22 +7753,60 @@ void __weak perf_get_regs_user(struct perf_regs *regs_user,
 	regs_user->abi = perf_reg_abi(current);
 }
 
+#define word_for_each_set_bit(bit, val)			\
+	for (unsigned long long __v = (val);		\
+	     __v && ((bit = __builtin_ctzll(__v)), 1);	\
+	     __v &= __v - 1)
+
 static void
 perf_output_sample_regs(struct perf_output_handle *handle,
 			struct pt_regs *regs, u64 mask)
 {
 	int bit;
-	DECLARE_BITMAP(_mask, 64);
-
-	bitmap_from_u64(_mask, mask);
-	for_each_set_bit(bit, _mask, sizeof(mask) * BITS_PER_BYTE) {
-		u64 val;
 
-		val = perf_reg_value(regs, bit);
+	word_for_each_set_bit(bit, mask) {
+		u64 val = perf_reg_value(regs, bit);
 		perf_output_put(handle, val);
 	}
 }
 
+static void
+perf_output_sample_simd_regs(struct perf_output_handle *handle,
+			     struct perf_event *event,
+			     struct pt_regs *regs,
+			     u64 mask, u32 pred_mask)
+{
+	u16 pred_qwords = event->attr.sample_simd_pred_reg_qwords;
+	u16 vec_qwords = event->attr.sample_simd_vec_reg_qwords;
+	u16 nr_vectors = hweight64(mask);
+	u16 nr_pred = hweight32(pred_mask);
+	int bit;
+
+	perf_output_put(handle, nr_vectors);
+	perf_output_put(handle, vec_qwords);
+	perf_output_put(handle, nr_pred);
+	perf_output_put(handle, pred_qwords);
+
+	if (nr_vectors) {
+		word_for_each_set_bit(bit, mask) {
+			for (int i = 0; i < vec_qwords; i++) {
+				u64 val = perf_simd_reg_value(regs, bit,
+							      i, false);
+				perf_output_put(handle, val);
+			}
+		}
+	}
+	if (nr_pred) {
+		word_for_each_set_bit(bit, pred_mask) {
+			for (int i = 0; i < pred_qwords; i++) {
+				u64 val = perf_simd_reg_value(regs, bit,
+							      i, true);
+				perf_output_put(handle, val);
+			}
+		}
+	}
+}
+
 static void perf_sample_regs_user(struct perf_regs *regs_user,
 				  struct pt_regs *regs)
 {
@@ -7790,6 +7828,17 @@ static void perf_sample_regs_intr(struct perf_regs *regs_intr,
 	regs_intr->abi  = perf_reg_abi(current);
 }
 
+int __weak perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
+				  u16 pred_qwords, u32 pred_mask)
+{
+	return vec_qwords || vec_mask || pred_qwords || pred_mask ? -ENOSYS : 0;
+}
+
+u64 __weak perf_simd_reg_value(struct pt_regs *regs, int idx,
+			       u16 qwords_idx, bool pred)
+{
+	return 0;
+}
 
 /*
  * Get remaining task size from user stack pointer.
@@ -8320,10 +8369,17 @@ void perf_output_sample(struct perf_output_handle *handle,
 		perf_output_put(handle, abi);
 
 		if (abi) {
-			u64 mask = event->attr.sample_regs_user;
+			struct perf_event_attr *attr = &event->attr;
+			u64 mask = attr->sample_regs_user;
 			perf_output_sample_regs(handle,
 						data->regs_user.regs,
 						mask);
+			if (abi & PERF_SAMPLE_REGS_ABI_SIMD) {
+				perf_output_sample_simd_regs(handle, event,
+							     data->regs_user.regs,
+							     attr->sample_simd_vec_reg_user,
+							     attr->sample_simd_pred_reg_user);
+			}
 		}
 	}
 
@@ -8351,11 +8407,18 @@ void perf_output_sample(struct perf_output_handle *handle,
 		perf_output_put(handle, abi);
 
 		if (abi) {
-			u64 mask = event->attr.sample_regs_intr;
+			struct perf_event_attr *attr = &event->attr;
+			u64 mask = attr->sample_regs_intr;
 
 			perf_output_sample_regs(handle,
 						data->regs_intr.regs,
 						mask);
+			if (abi & PERF_SAMPLE_REGS_ABI_SIMD) {
+				perf_output_sample_simd_regs(handle, event,
+							     data->regs_intr.regs,
+							     attr->sample_simd_vec_reg_intr,
+							     attr->sample_simd_pred_reg_intr);
+			}
 		}
 	}
 
@@ -13011,6 +13074,12 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 	if (ret)
 		goto err_pmu;
 
+	if (!(pmu->capabilities & PERF_PMU_CAP_SIMD_REGS) &&
+	    event_has_simd_regs(event)) {
+		ret = -EOPNOTSUPP;
+		goto err_destroy;
+	}
+
 	if (!(pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS) &&
 	    event_has_extended_regs(event)) {
 		ret = -EOPNOTSUPP;
@@ -13556,6 +13625,12 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 		ret = perf_reg_validate(attr->sample_regs_user);
 		if (ret)
 			return ret;
+		ret = perf_simd_reg_validate(attr->sample_simd_vec_reg_qwords,
+					     attr->sample_simd_vec_reg_user,
+					     attr->sample_simd_pred_reg_qwords,
+					     attr->sample_simd_pred_reg_user);
+		if (ret)
+			return ret;
 	}
 
 	if (attr->sample_type & PERF_SAMPLE_STACK_USER) {
@@ -13576,8 +13651,17 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 	if (!attr->sample_max_stack)
 		attr->sample_max_stack = sysctl_perf_event_max_stack;
 
-	if (attr->sample_type & PERF_SAMPLE_REGS_INTR)
+	if (attr->sample_type & PERF_SAMPLE_REGS_INTR) {
 		ret = perf_reg_validate(attr->sample_regs_intr);
+		if (ret)
+			return ret;
+		ret = perf_simd_reg_validate(attr->sample_simd_vec_reg_qwords,
+					     attr->sample_simd_vec_reg_intr,
+					     attr->sample_simd_pred_reg_qwords,
+					     attr->sample_simd_pred_reg_intr);
+		if (ret)
+			return ret;
+	}
 
 #ifndef CONFIG_CGROUP_PERF
 	if (attr->sample_type & PERF_SAMPLE_CGROUP)
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 9142a8ba4019..f84200b9dd57 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2051,7 +2051,8 @@ static void free_event_desc(struct evsel *events)
 
 static bool perf_attr_check(struct perf_event_attr *attr)
 {
-	if (attr->__reserved_1 || attr->__reserved_2 || attr->__reserved_3) {
+	if (attr->__reserved_1 || attr->__reserved_2 ||
+	    attr->__reserved_3 || attr->__reserved_4) {
 		pr_warning("Reserved bits are set unexpectedly. "
 			   "Please update perf tool.\n");
 		return false;
-- 
2.34.1

