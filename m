Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0B93A9627;
	Fri, 29 May 2026 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043430; cv=none; b=uzacGPvFEEVx1vdvyWDRNNjyTLeMNq1005d6wCr1fXHsDR8WH/YxrOXBfBucm+fLENIwmj5l36LQU5G2/ecbZkcj9CCte93arPYb5ndHh/6DFzjH5YKK2mZxJiNUdCiIa++gAYakJMRJn9RPj7iqb4ZHB3DLos6mR85SUlALWb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043430; c=relaxed/simple;
	bh=FIOb3Hfv+EalZ1nxHis5y9pZIwqMazRY5iZnsKSnzbo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UpbZ21Uer+mvgVFkjETkjVFabe6VzVFt1uz3Rlg2kKrp8NeoGuZdvrgENrRvkgvxQO5qaCUC1jvsVYYl1LR2krYTtUmbQH/arV2WkbOtG6BZ4aJGgMQkUw+J+ap2iZFzlJCOHMoPq/8txefbYITzF6PmPJnFGSZYxQfdEVHc2pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QGZtukYY; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QGZtukYY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780043429; x=1811579429;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FIOb3Hfv+EalZ1nxHis5y9pZIwqMazRY5iZnsKSnzbo=;
  b=QGZtukYYkfs5AaYQbtmzi1CIHUaH9Bc5YLln52bCF5bDcauNI7lXoLXf
   0baTReuGWJOsiJUGuOk0H+1jLERLdihZRcoZRNTfZJQQl12+I+fNU5vw4
   3OAayk0hHlnL44H/Cwq+ZQICJLdk304fprCceTBuZahOakhpZjo5iNehy
   xeKwQSPEB9Wspd7xMlFm/6tI67N/zDs8BAh4JgMEQiD8rCSYYhCPDZuO1
   HohlnPyGuhiGha58C47e4DZqKtdJX/s/0UVrKyv0/OCoy2PDbrmXqxk92
   q4do/lMqxcC7qvrr7gTOeuH5o5+fwNnmKLKxO2vth2s0F++yTRRRsxgnG
   g==;
X-CSE-ConnectionGUID: QwFpXPxZQoKcgWumS8Va0Q==
X-CSE-MsgGUID: ojI70WA/Q+SJd87hVFHjZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="81076332"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="81076332"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 01:30:19 -0700
X-CSE-ConnectionGUID: AqlT6aeESX+lzsTTtroUNQ==
X-CSE-MsgGUID: UxN2cunNQu699dj5oR/kRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="247734805"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa005.jf.intel.com with ESMTP; 29 May 2026 01:30:14 -0700
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [Patch v8 1/5] perf headers: Sync perf_event.h/perf_regs.h with the kernel headers
Date: Fri, 29 May 2026 16:24:47 +0800
Message-Id: <20260529082451.591783-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529082451.591783-1-dapeng1.mi@linux.intel.com>
References: <20260529082451.591783-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sync the UAPI header changes of supporting SIMD/eGPRs/SSP sampling into
corresponding tools UAPI headers.

Additionally, add sanity check if the new introduced __reserved_4 field
in perf_attr_check().

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/arch/x86/include/uapi/asm/perf_regs.h | 51 +++++++++++++++++++++
 tools/include/uapi/linux/perf_event.h       | 49 ++++++++++++++++++--
 tools/perf/util/header.c                    |  3 +-
 3 files changed, 98 insertions(+), 5 deletions(-)

diff --git a/tools/arch/x86/include/uapi/asm/perf_regs.h b/tools/arch/x86/include/uapi/asm/perf_regs.h
index 7c9d2bb3833b..31a025cb9dba 100644
--- a/tools/arch/x86/include/uapi/asm/perf_regs.h
+++ b/tools/arch/x86/include/uapi/asm/perf_regs.h
@@ -27,9 +27,35 @@ enum perf_event_x86_regs {
 	PERF_REG_X86_R13,
 	PERF_REG_X86_R14,
 	PERF_REG_X86_R15,
+	/*
+	 * The eGPRs/SSP and XMM have overlaps. Only one can be used
+	 * at a time. The ABI PERF_SAMPLE_REGS_ABI_SIMD is used to
+	 * distinguish which one is used. If PERF_SAMPLE_REGS_ABI_SIMD
+	 * is set, then eGPRs/SSP is used, otherwise, XMM is used.
+	 *
+	 * Extended GPRs (eGPRs)
+	 */
+	PERF_REG_X86_R16,
+	PERF_REG_X86_R17,
+	PERF_REG_X86_R18,
+	PERF_REG_X86_R19,
+	PERF_REG_X86_R20,
+	PERF_REG_X86_R21,
+	PERF_REG_X86_R22,
+	PERF_REG_X86_R23,
+	PERF_REG_X86_R24,
+	PERF_REG_X86_R25,
+	PERF_REG_X86_R26,
+	PERF_REG_X86_R27,
+	PERF_REG_X86_R28,
+	PERF_REG_X86_R29,
+	PERF_REG_X86_R30,
+	PERF_REG_X86_R31,
+	PERF_REG_X86_SSP,
 	/* These are the limits for the GPRs. */
 	PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
 	PERF_REG_X86_64_MAX = PERF_REG_X86_R15 + 1,
+	PERF_REG_MISC_MAX = PERF_REG_X86_SSP + 1,
 
 	/* These all need two bits set because they are 128bit */
 	PERF_REG_X86_XMM0  = 32,
@@ -54,5 +80,30 @@ enum perf_event_x86_regs {
 };
 
 #define PERF_REG_EXTENDED_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
+#define PERF_X86_EGPRS_MASK	__GENMASK_ULL(PERF_REG_X86_R31, PERF_REG_X86_R16)
+
+enum {
+	PERF_X86_SIMD_XMM_REGS      = 16,
+	PERF_X86_SIMD_YMM_REGS      = 16,
+	PERF_X86_SIMD_ZMM_REGS      = 32,
+	PERF_X86_SIMD_VEC_REGS_MAX  = PERF_X86_SIMD_ZMM_REGS,
+
+	PERF_X86_SIMD_OPMASK_REGS   = 8,
+	PERF_X86_SIMD_PRED_REGS_MAX = PERF_X86_SIMD_OPMASK_REGS,
+};
+
+#define PERF_X86_SIMD_PRED_MASK	__GENMASK(PERF_X86_SIMD_PRED_REGS_MAX - 1, 0)
+#define PERF_X86_SIMD_VEC_MASK	__GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - 1, 0)
+
+#define PERF_X86_H16ZMM_BASE		16
+
+enum {
+	/* 1 qword = 8 bytes */
+	PERF_X86_OPMASK_QWORDS   = 1,
+	PERF_X86_XMM_QWORDS      = 2,
+	PERF_X86_YMM_QWORDS      = 4,
+	PERF_X86_ZMM_QWORDS      = 8,
+	PERF_X86_SIMD_QWORDS_MAX = PERF_X86_ZMM_QWORDS,
+};
 
 #endif /* _ASM_X86_PERF_REGS_H */
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index fd10aa8d697f..c49fc76292f7 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
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
+#define PERF_ATTR_SIZE_VER10			176	/* Add: sample_simd_{vec|pred}_reg_* */
 
 /*
  * 'struct perf_event_attr' contains various attributes that define
@@ -547,6 +549,29 @@ struct perf_event_attr {
 
 	__u64	config3; /* extension of config2 */
 	__u64	config4; /* extension of config3 */
+
+	/*
+	 * Defines the sampling SIMD/PRED(predicate) registers bitmap and
+	 * qwords (8 bytes) length.
+	 *
+	 * sample_simd_regs_enabled != 0 indicates there are SIMD/PRED
+	 * registers to be sampled, the SIMD/PRED registers bitmap and
+	 * qwords length are represented in
+	 * sample_simd_{vec|pred}_reg_{intr|user} and
+	 * sample_simd_{vec|pred}_reg_qwords fields separately.
+	 *
+	 * sample_simd_regs_enabled == 0 indicates no SIMD/PRED registers
+	 * are sampled.
+	 */
+	__u16	sample_simd_regs_enabled;
+	__u16	sample_simd_pred_reg_qwords;
+	__u16	sample_simd_vec_reg_qwords;
+	__u16	__reserved_4;
+
+	__u32	sample_simd_pred_reg_intr;
+	__u32	sample_simd_pred_reg_user;
+	__u64	sample_simd_vec_reg_intr;
+	__u64	sample_simd_vec_reg_user;
 };
 
 /*
@@ -1020,7 +1045,15 @@ enum perf_event_type {
 	 *      } && PERF_SAMPLE_BRANCH_STACK
 	 *
 	 *	{ u64			abi; # enum perf_sample_regs_abi
-	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_USER
+	 *	  u64			regs[weight(mask)];
+	 *	  struct {
+	 *		u64 nr_vectors;		# 0 ... weight(sample_simd_vec_reg_user)
+	 *		u64 vector_qwords;	# 0 ... sample_simd_vec_reg_qwords
+	 *		u64 nr_pred;		# 0 ... weight(sample_simd_pred_reg_user)
+	 *		u64 pred_qwords;	# 0 ... sample_simd_pred_reg_qwords
+	 *		u64 data[nr_vectors * vector_qwords + nr_pred * pred_qwords];
+	 *	  } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
+	 *	} && PERF_SAMPLE_REGS_USER
 	 *
 	 *	{ u64			size;
 	 *	  char			data[size];
@@ -1047,7 +1080,15 @@ enum perf_event_type {
 	 *	{ u64			data_src; } && PERF_SAMPLE_DATA_SRC
 	 *	{ u64			transaction; } && PERF_SAMPLE_TRANSACTION
 	 *	{ u64			abi; # enum perf_sample_regs_abi
-	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
+	 *	  u64			regs[weight(mask)];
+	 *	  struct {
+	 *		u64 nr_vectors;		# 0 ... weight(sample_simd_vec_reg_intr)
+	 *		u64 vector_qwords;	# 0 ... sample_simd_vec_reg_qwords
+	 *		u64 nr_pred;		# 0 ... weight(sample_simd_pred_reg_intr)
+	 *		u64 pred_qwords;	# 0 ... sample_simd_pred_reg_qwords
+	 *		u64 data[nr_vectors * vector_qwords + nr_pred * pred_qwords];
+	 *	  } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
+	 *	} && PERF_SAMPLE_REGS_INTR
 	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
 	 *	{ u64			cgroup;} && PERF_SAMPLE_CGROUP
 	 *	{ u64			data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index f30e48eb3fc3..e8e4e00d6b4d 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2091,7 +2091,8 @@ static void free_event_desc(struct evsel *events)
 
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

