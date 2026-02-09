Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B2631A80E;
	Mon,  9 Feb 2026 07:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770621950; cv=none; b=MzYFwHMfPRQqu6H0+QsGHvUHdvWz9LF2gOeBJBfZrDH2mniku+s1b9S/gXE9w/kpK1vilZPiFOW4YI2PhvuJw/+3GTSSc4cwEBhRBxbzj/CNPw5N3vH5GyzWFb/6FNzAYF3tFsIuQQVt8hmTxHkfj8D43v4kYXz5cQCMdtQUjGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770621950; c=relaxed/simple;
	bh=+P4ZsSbB+IFK+1oK/Y6cz0GVIHwrajlcrQm6zrh/Ffk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jViX4OfWLKFug7+kPWgmMhTNsFPHshUjiC+5mRU5HAidYFRddr0vjcEiFXtn5Rinc0MmtXqqxirDcBWJ/Fr28GxGOpSygU9tEAsPTija8Hyg1IZhhf+5ecIsMPFidXZqldmP8DR62YlNA/dZGkPRBtMP2iD1W94BMtf1jqxtWIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mlz5EzlR; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mlz5EzlR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770621950; x=1802157950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+P4ZsSbB+IFK+1oK/Y6cz0GVIHwrajlcrQm6zrh/Ffk=;
  b=mlz5EzlRt7TIb1Np+t5096+uDuIHljhxINqX1mfZmGni42TK7jgvNcsZ
   DCt9m7HSGkjI6jjA40Mao+sYtvGhDPUEtEMWZNJR2VB0pw25/Fiti07iI
   F+spz0vSvEBTuZdPsD9ttT99Yl2A4V9P5Ngo4t5HSwyNmxuoE2BiIyghh
   lIZ5RSq2MtuvaWMX7SdvVuhI1qFqTbLnb9ZiaKrJ4ctR7XDGVGL+Lggii
   0TBV5JDxhH2va8jeiKloG4iGQiYaxFW87un2BkBCbKlULGJI0YC0jkQN5
   ob6YtSo2AOUGFfRCqRWhWHWmry9eiImJRaMKodRDcLlQDIATieu688C2c
   Q==;
X-CSE-ConnectionGUID: ML7JR1s7QH2wsf0kvla8Ww==
X-CSE-MsgGUID: pVslYzqMSf6pJ7UWunO7Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="83098440"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="83098440"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 23:25:50 -0800
X-CSE-ConnectionGUID: rkWmTEdXRy6VbpaJyneAuQ==
X-CSE-MsgGUID: lUR0Xp6CRb+WNOnSqdwd3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="241694713"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa001.fm.intel.com with ESMTP; 08 Feb 2026 23:25:45 -0800
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
Subject: [Patch v6 12/22] perf: Add sampling support for SIMD registers
Date: Mon,  9 Feb 2026 15:20:37 +0800
Message-Id: <20260209072047.2180332-13-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
References: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
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

V6: Adjust newly added fields in perf_event_attr to avoid memory holes

 include/linux/perf_event.h      |  8 +++
 include/linux/perf_regs.h       |  4 ++
 include/uapi/linux/perf_event.h | 45 ++++++++++++++--
 kernel/events/core.c            | 96 +++++++++++++++++++++++++++++++--
 4 files changed, 146 insertions(+), 7 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index b8a0f77412b3..172ba199d4ff 100644
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
index 533393ec94d0..b41ae1b82344 100644
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
@@ -547,6 +549,25 @@ struct perf_event_attr {
 
 	__u64	config3; /* extension of config2 */
 	__u64	config4; /* extension of config3 */
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
+	__u16	sample_simd_vec_reg_qwords;
+	__u32	__reserved_4;
+
+	__u32	sample_simd_pred_reg_intr;
+	__u32	sample_simd_pred_reg_user;
+	__u64	sample_simd_vec_reg_intr;
+	__u64	sample_simd_vec_reg_user;
 };
 
 /*
@@ -1020,7 +1041,15 @@ enum perf_event_type {
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
@@ -1047,7 +1076,15 @@ enum perf_event_type {
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
index d487c55a4f3e..5742126f50cc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7761,6 +7761,50 @@ perf_output_sample_regs(struct perf_output_handle *handle,
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
+	u16 nr_vectors;
+	u16 nr_pred;
+	int bit;
+	u64 val;
+	u16 i;
+
+	nr_vectors = hweight64(mask);
+	nr_pred = hweight32(pred_mask);
+
+	perf_output_put(handle, nr_vectors);
+	perf_output_put(handle, vec_qwords);
+	perf_output_put(handle, nr_pred);
+	perf_output_put(handle, pred_qwords);
+
+	if (nr_vectors) {
+		for (bit = 0; bit < sizeof(mask) * BITS_PER_BYTE; bit++) {
+			if (!(BIT_ULL(bit) & mask))
+				continue;
+			for (i = 0; i < vec_qwords; i++) {
+				val = perf_simd_reg_value(regs, bit, i, false);
+				perf_output_put(handle, val);
+			}
+		}
+	}
+	if (nr_pred) {
+		for (bit = 0; bit < sizeof(pred_mask) * BITS_PER_BYTE; bit++) {
+			if (!(BIT(bit) & pred_mask))
+				continue;
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
@@ -7782,6 +7826,17 @@ static void perf_sample_regs_intr(struct perf_regs *regs_intr,
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
@@ -8312,10 +8367,17 @@ void perf_output_sample(struct perf_output_handle *handle,
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
 
@@ -8343,11 +8405,18 @@ void perf_output_sample(struct perf_output_handle *handle,
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
 
@@ -12997,6 +13066,12 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
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
@@ -13542,6 +13617,12 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
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
@@ -13562,8 +13643,17 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
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

