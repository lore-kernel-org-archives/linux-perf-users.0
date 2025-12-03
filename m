Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D473B29E0FD;
	Wed,  3 Dec 2025 06:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764745118; cv=none; b=CyQTp7iO6bPqadt9VeLMGsaJVNO7r3cOFv2NFZFI5NQR8YDlz69+dE/39AG14fEoUdrAxBYcXQI6m/TfnTnTYC0iGi/INmUsF5+8tAqkG9RAVwoGxoXJFUMbIoVPFIjd4lPva/qsot6ABaFn1qQcmBnxIXWRtOHDIUUOLtJtAtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764745118; c=relaxed/simple;
	bh=m7GkF9gQg1+jYyArzPbAbuiGQe0I0Wer1Z80CtBeEb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KhsOdAq90cORCk9RtTWJy9KBY7czK/aEu02y9q+7jU6mcFCwKO9jSGjRNl7n8M/iMnU9hGJN7BUFHZiVxILWtZJnMbQEE/cH9ozzJgI9ShqBfk+othBfGhSprc/7pGMEeBeFF6N8FGbI8cHIbCaLjIlkvdQfVDUwkdMVKye46+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gz2VX0/8; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gz2VX0/8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764745117; x=1796281117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m7GkF9gQg1+jYyArzPbAbuiGQe0I0Wer1Z80CtBeEb0=;
  b=gz2VX0/8KoL5TXqEqGaSJq9OjXSUVCr4dhoi1wbu1Chpym4JJEJu06hh
   upBBMIb6zv2C17t1L2F28tlquqmCmpWhKg/Vv+f+/KiPtrgfRWYWfHmns
   PN1jbdsXRgG4iF8sOlfIyPT8c7CA3+Xu/ZQq9txNZmp9cEANXzs9Yj+yJ
   lKadEnGEjSwjcMq2J14GdP5nJbYEWUIgUt2gZXmDGlaI/XKXB1WJk0tt7
   tPiJRYAByfa56MeL6jotlpXary2fbd7SVl6PdTqGT6VeTIwkrqpWF0FUT
   X2P/FQu3alTIetMO/aaLOe+W5MMlBOzpSxcwzKS4fQ+7jnDaaMUSf+xby
   w==;
X-CSE-ConnectionGUID: AvUbf3UeQ4SS+xnuXoSYlw==
X-CSE-MsgGUID: E6Cmqv3KRdyKarAfjaQqWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="84324822"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="84324822"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 22:58:36 -0800
X-CSE-ConnectionGUID: D0lwsIcsRnOTXHxWvu2UyA==
X-CSE-MsgGUID: vK/MIps5TVyQWPpL5avHZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="199003865"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa005.fm.intel.com with ESMTP; 02 Dec 2025 22:58:31 -0800
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
Subject: [Patch v5 07/19] perf: Add sampling support for SIMD registers
Date: Wed,  3 Dec 2025 14:54:48 +0800
Message-Id: <20251203065500.2597594-8-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
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
 include/linux/perf_event.h      |  8 +++
 include/linux/perf_regs.h       |  4 ++
 include/uapi/linux/perf_event.h | 45 ++++++++++++++--
 kernel/events/core.c            | 96 +++++++++++++++++++++++++++++++--
 4 files changed, 146 insertions(+), 7 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 5153b70d09c8..87d3bdbef30e 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -305,6 +305,7 @@ struct perf_event_pmu_context;
 #define PERF_PMU_CAP_EXTENDED_HW_TYPE	0x0100
 #define PERF_PMU_CAP_AUX_PAUSE		0x0200
 #define PERF_PMU_CAP_AUX_PREFER_LARGE	0x0400
+#define PERF_PMU_CAP_SIMD_REGS		0x0800
 
 /**
  * pmu::scope
@@ -1526,6 +1527,13 @@ perf_event__output_id_sample(struct perf_event *event,
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
index d292f96bc06f..f1474da32622 100644
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
@@ -382,6 +383,7 @@ enum perf_event_read_format {
 #define PERF_ATTR_SIZE_VER6			120	/* Add: aux_sample_size */
 #define PERF_ATTR_SIZE_VER7			128	/* Add: sig_data */
 #define PERF_ATTR_SIZE_VER8			136	/* Add: config3 */
+#define PERF_ATTR_SIZE_VER9			168	/* Add: sample_simd_{pred,vec}_reg_* */
 
 /*
  * 'struct perf_event_attr' contains various attributes that define
@@ -545,6 +547,25 @@ struct perf_event_attr {
 	__u64	sig_data;
 
 	__u64	config3; /* extension of config2 */
+
+
+	/*
+	 * Defines set of SIMD registers to dump on samples.
+	 * The sample_simd_regs_enabled !=0 implies the
+	 * set of SIMD registers is used to config all SIMD registers.
+	 * If !sample_simd_regs_enabled, sample_regs_XXX may be used to
+	 * config some SIMD registers on X86.
+	 */
+	union {
+		__u16 sample_simd_regs_enabled;
+		__u16 sample_simd_pred_reg_qwords;
+	};
+	__u32 sample_simd_pred_reg_intr;
+	__u32 sample_simd_pred_reg_user;
+	__u16 sample_simd_vec_reg_qwords;
+	__u64 sample_simd_vec_reg_intr;
+	__u64 sample_simd_vec_reg_user;
+	__u32 __reserved_4;
 };
 
 /*
@@ -1018,7 +1039,15 @@ enum perf_event_type {
 	 *      } && PERF_SAMPLE_BRANCH_STACK
 	 *
 	 *	{ u64			abi; # enum perf_sample_regs_abi
-	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_USER
+	 *	  u64			regs[weight(mask)];
+	 *	  struct {
+	 *		u16 nr_vectors;
+	 *		u16 vector_qwords;
+	 *		u16 nr_pred;
+	 *		u16 pred_qwords;
+	 *		u64 data[nr_vectors * vector_qwords + nr_pred * pred_qwords];
+	 *	  } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
+	 *	} && PERF_SAMPLE_REGS_USER
 	 *
 	 *	{ u64			size;
 	 *	  char			data[size];
@@ -1045,7 +1074,15 @@ enum perf_event_type {
 	 *	{ u64			data_src; } && PERF_SAMPLE_DATA_SRC
 	 *	{ u64			transaction; } && PERF_SAMPLE_TRANSACTION
 	 *	{ u64			abi; # enum perf_sample_regs_abi
-	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
+	 *	  u64			regs[weight(mask)];
+	 *	  struct {
+	 *		u16 nr_vectors;
+	 *		u16 vector_qwords;
+	 *		u16 nr_pred;
+	 *		u16 pred_qwords;
+	 *		u64 data[nr_vectors * vector_qwords + nr_pred * pred_qwords];
+	 *	  } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
+	 *	} && PERF_SAMPLE_REGS_INTR
 	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
 	 *	{ u64			cgroup;} && PERF_SAMPLE_CGROUP
 	 *	{ u64			data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3e9c48fa2202..b19de038979e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7469,6 +7469,50 @@ perf_output_sample_regs(struct perf_output_handle *handle,
 	}
 }
 
+static void
+perf_output_sample_simd_regs(struct perf_output_handle *handle,
+			     struct perf_event *event,
+			     struct pt_regs *regs,
+			     u64 mask, u16 pred_mask)
+{
+	u16 pred_qwords = event->attr.sample_simd_pred_reg_qwords;
+	u16 vec_qwords = event->attr.sample_simd_vec_reg_qwords;
+	u64 pred_bitmap = pred_mask;
+	u64 bitmap = mask;
+	u16 nr_vectors;
+	u16 nr_pred;
+	int bit;
+	u64 val;
+	u16 i;
+
+	nr_vectors = hweight64(bitmap);
+	nr_pred = hweight64(pred_bitmap);
+
+	perf_output_put(handle, nr_vectors);
+	perf_output_put(handle, vec_qwords);
+	perf_output_put(handle, nr_pred);
+	perf_output_put(handle, pred_qwords);
+
+	if (nr_vectors) {
+		for_each_set_bit(bit, (unsigned long *)&bitmap,
+				 sizeof(bitmap) * BITS_PER_BYTE) {
+			for (i = 0; i < vec_qwords; i++) {
+				val = perf_simd_reg_value(regs, bit, i, false);
+				perf_output_put(handle, val);
+			}
+		}
+	}
+	if (nr_pred) {
+		for_each_set_bit(bit, (unsigned long *)&pred_bitmap,
+				 sizeof(pred_bitmap) * BITS_PER_BYTE) {
+			for (i = 0; i < pred_qwords; i++) {
+				val = perf_simd_reg_value(regs, bit, i, true);
+				perf_output_put(handle, val);
+			}
+		}
+	}
+}
+
 static void perf_sample_regs_user(struct perf_regs *regs_user,
 				  struct pt_regs *regs)
 {
@@ -7490,6 +7534,17 @@ static void perf_sample_regs_intr(struct perf_regs *regs_intr,
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
@@ -8022,10 +8077,17 @@ void perf_output_sample(struct perf_output_handle *handle,
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
 
@@ -8053,11 +8115,18 @@ void perf_output_sample(struct perf_output_handle *handle,
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
 
@@ -12697,6 +12766,12 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
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
@@ -13238,6 +13313,12 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
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
@@ -13258,8 +13339,17 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
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
-- 
2.34.1

