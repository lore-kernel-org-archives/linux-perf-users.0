Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14822E92D1;
	Thu, 25 Sep 2025 06:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780885; cv=none; b=eYb4xwazz3kxSdeLF9FZYtOD7r2aE+Z7iSdQlH5m9yV2tkMomWzAwoq5F78IUwMVRJte8S/Okv+1cZ+eaylRZXZ4yXaoL1EmL5Oq9y019c/2Mylt2RiEAe4hX5j7ZhvG8TYaGGqzSEtneh+eHFDWyJvalHSavLqvZolomLzQLoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780885; c=relaxed/simple;
	bh=kctHCG8cLRsgBgM27zMJGscchfWd6VfkviSNTyUxJvg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N/wM0+LpfebWN8P7cix/YJ2GXf0LGAyJHT2BQyJxVALiBWBheEmUiRr+nYwq0ANdyfc42W5Y3xZK6dRcsEZLslz3l13T2FBnANR96dQjmSLYQ8w+jny/tIixiZQYGtXPpbH0MLKC4GTssZ9I/+l4NNZquJWgOaqKpZCWE661bAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jrrv8tb+; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jrrv8tb+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758780884; x=1790316884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kctHCG8cLRsgBgM27zMJGscchfWd6VfkviSNTyUxJvg=;
  b=jrrv8tb+nI4OxFwhvtiwXNimBtc2AJNshG19RVf4pjH/2okmbRJ6dVDQ
   QhcpdfwxNWuYCUNoLcdRUfvziW8MNPq2yChkLCnmbavv75Ht/MOn1Taxf
   knj/70ktNj+luRgtB9ESA3pOqDbXbuH1wP3o/lTOnit7nqX+BegjpM2d4
   e247cUUmfFtAKovwIAlIiiiuXAv9Wfm9XLkQGXfaYt1G8re2QqLhllPoH
   1EXFKNQ2ZI3JeO/BKoc2uic6zz7xbUatYGLPLZ4D3wi6ccVMr8KR8EZv/
   Zaw1mPcwHVJ2WKRhG/qxoriQCJ84BXmT3DFj17ni0YFYTuFL8kad5YLio
   w==;
X-CSE-ConnectionGUID: p8rd5eqUQZmNw2QAOC+AQg==
X-CSE-MsgGUID: Faac0gnxTiyrmYYPCEaWLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="61139545"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="61139545"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 23:14:43 -0700
X-CSE-ConnectionGUID: N4fpa7avQdua7RUHJ9D2Zg==
X-CSE-MsgGUID: p+szTZk2T/eTGQBD8koDAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="181528367"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa004.jf.intel.com with ESMTP; 24 Sep 2025 23:14:38 -0700
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
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v4 06/17] perf: Support SIMD registers
Date: Thu, 25 Sep 2025 14:12:02 +0800
Message-Id: <20250925061213.178796-7-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925061213.178796-1-dapeng1.mi@linux.intel.com>
References: <20250925061213.178796-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The users may be interested in the SIMD registers in a sample while
profiling. The current sample_regs_XXX doesn't have enough space for all
SIMD registers.

Add sets of the sample_simd_{pred,vec}_reg_* in the
struct perf_event_attr to define a set of SIMD registers to dump on
samples.
The current X86 supports the XMM registers in sample_regs_XXX. To
utilize the new SIMD registers configuration method, the
sample_simd_regs_enabled should always be set. If so, the XMM space in
the sample_regs_XXX is reserved for other usage.

The SIMD registers are wider than 64. A new output format is introduced.
The number and width of SIMD registers will be dumped first, following
the register values. The number and width are the same as the user's
configuration now. If, for some reason (e.g., ARM) they are different,
an ARCH-specific perf_output_sample_simd_regs can be implemented later
separately.
Add a new ABI, PERF_SAMPLE_REGS_ABI_SIMD, to indicate the new format.
The enum perf_sample_regs_abi becomes a bitmap now. There should be no
impact on the existing tool, since the version and bitmap are the same
for 1 and 2.

Add three new __weak functions:
perf_simd_reg_value: Retrieve the value of the request SIMD register.
perf_simd_reg_validate: Validate the configuration of the SIMD
registers.
perf_simd_reg_check: Check and update the configuration of the requested
SIMD registers.

Add a new flag PERF_PMU_CAP_SIMD_REGS to indicate that the PMU has the
capability to support SIMD registers dumping. Error out if the
sample_simd_{pred,vec}_reg_* mistakenly set for a PMU that doesn't have
the capability.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 include/linux/perf_event.h      |   8 +++
 include/linux/perf_regs.h       |  26 ++++++++
 include/uapi/linux/perf_event.h |  45 ++++++++++++--
 kernel/events/core.c            | 103 +++++++++++++++++++++++++++++++-
 4 files changed, 175 insertions(+), 7 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1a647a1e6d08..8e995e6a4319 100644
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
index f632c5725f16..11d198cbb33a 100644
--- a/include/linux/perf_regs.h
+++ b/include/linux/perf_regs.h
@@ -9,6 +9,32 @@ struct perf_regs {
 	struct pt_regs	*regs;
 };
 
+int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
+			   u16 pred_qwords, u32 pred_mask);
+u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
+			u16 qwords_idx, bool pred);
+/*
+ * Check and update the configuration of the requested SIMD registers
+ *
+ * regs: Used to locate the SIMD registers
+ * ignore: A mask to ignore the check of some configuration
+ * mask: The requested vector mask
+ * nr_vectors: Number of the vector registers
+ * vec_qwords: The QWORD of the vector registers
+ * pred_mask: The requested predicate mask
+ * nr_pred: Number of the predicate registers
+ * pred_qwords: The QWORD of the predicate registers
+ *
+ * It's possible (e.g., ARM) that the number and width of the dumped
+ * SIMD registers are a little different from the request.
+ * The function is to calculate the real number and width before dumping
+ * the data.
+ */
+void perf_simd_reg_check(struct pt_regs *regs, u64 ignore,
+			 u64 mask, u16 *nr_vectors, u16 *vec_qwords,
+			 u16 pred_mask, u16 *nr_pred, u16 *pred_qwords);
+
+
 #ifdef CONFIG_HAVE_PERF_REGS
 #include <asm/perf_regs.h>
 
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 78a362b80027..e69bc3b7a815 100644
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
@@ -543,6 +545,25 @@ struct perf_event_attr {
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
@@ -1016,7 +1037,15 @@ enum perf_event_type {
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
@@ -1043,7 +1072,15 @@ enum perf_event_type {
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
index fe3a01cc4d92..e87d0429474d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7440,6 +7440,49 @@ perf_output_sample_regs(struct perf_output_handle *handle,
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
+	u16 nr_pred = hweight16(pred_mask);
+	u16 nr_vectors = hweight64(mask);
+	int bit;
+	u64 val;
+	u16 i;
+
+	/* Get the number of available regs */
+	perf_simd_reg_check(regs, 0, mask, &nr_vectors, &vec_qwords,
+			    pred_mask, &nr_pred, &pred_qwords);
+
+	perf_output_put(handle, nr_vectors);
+	perf_output_put(handle, vec_qwords);
+	perf_output_put(handle, nr_pred);
+	perf_output_put(handle, pred_qwords);
+
+	if (nr_vectors) {
+		for_each_set_bit(bit, (unsigned long *)&mask,
+				 sizeof(mask) * BITS_PER_BYTE) {
+			for (i = 0; i < vec_qwords; i++) {
+				val = perf_simd_reg_value(regs, bit, i, false);
+				perf_output_put(handle, val);
+			}
+		}
+	}
+	if (nr_pred) {
+		for_each_set_bit(bit, (unsigned long *)&pred_mask,
+				 sizeof(pred_mask) * BITS_PER_BYTE) {
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
@@ -7461,6 +7504,25 @@ static void perf_sample_regs_intr(struct perf_regs *regs_intr,
 	regs_intr->abi  = perf_reg_abi(current);
 }
 
+int __weak perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
+				  u16 pred_qwords, u32 pred_mask)
+{
+	return vec_qwords || vec_mask || pred_qwords || pred_mask ? -EINVAL : 0;
+}
+
+u64 __weak perf_simd_reg_value(struct pt_regs *regs, int idx,
+			       u16 qwords_idx, bool pred)
+{
+	return 0;
+}
+
+void __weak perf_simd_reg_check(struct pt_regs *regs, u64 ignore,
+				u64 mask, u16 *nr_vectors, u16 *vec_qwords,
+				u16 pred_mask, u16 *nr_pred, u16 *pred_qwords)
+{
+	*nr_vectors = 0;
+	*nr_pred = 0;
+}
 
 /*
  * Get remaining task size from user stack pointer.
@@ -7993,10 +8055,17 @@ void perf_output_sample(struct perf_output_handle *handle,
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
 
@@ -8024,11 +8093,18 @@ void perf_output_sample(struct perf_output_handle *handle,
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
 
@@ -12593,6 +12669,12 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
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
@@ -13134,6 +13216,12 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
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
@@ -13154,8 +13242,17 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
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

