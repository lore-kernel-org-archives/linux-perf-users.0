Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591FC318130;
	Mon,  9 Feb 2026 08:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770626350; cv=none; b=jkc10YjWmR/L2OpCjR/ZaKzxW3nKb4XDp7ll6UV7mJZAyHqivWTMP7eG5zPOumI/K+V0Co6fTB9LTD4qKDPOq09DqUz9gceK6o3aXFbEURLW9pFQKj4tKzQVGvnriNPmqqcEMVdzqPmQT33CUJiVjnjN97Om/sGLDaj+qhviajI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770626350; c=relaxed/simple;
	bh=UO7iDro7nU6prcLVjmuZL0sBtTIs5+FPR9o9e+oSo4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y78qXJ1nuIhi3p6AN+UykGt2q9X7DPwhVll7mEzipAQKGeSRuPm7v36pysfR1KAW5qMD/fy8N1MpTIdaAwT54ThjysmHmI16TDZaAWuIEOQ7LN8lXbew0QMqcUhWMbStR0rmbAfFMV8WL0hH03VN7KfOzTUiYGiUbiEpSvwAjhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=St6d3ZLs; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="St6d3ZLs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770626351; x=1802162351;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UO7iDro7nU6prcLVjmuZL0sBtTIs5+FPR9o9e+oSo4Q=;
  b=St6d3ZLsI2cwSUk2ltM/lJ1+krfq6cssSDxF8FFAAT32bmKSOekAVHNm
   5HqRmeJf/PH1piHE/WBJ1LHNcCd0l2oTyYbVk/4xfvGyq7Zux0PQ98bwy
   5O8C5iKRk4HUfw2Oxo5bvE+e5L2F7BUcd7N0JKr1wfwaJY8Wc5Usvep/o
   FSM+Ve9SiozdOHynlDc/P6wKyxh+i0SirrwRdN0+h0lAxp9xBfsvhZJ//
   2E77LeRavcGITR/m0y6U1tB4fMID/0bQXEnP7ir9w3UhNvJ/WXULB2lKw
   wqdbzJOTncnqw183Tp7ACGManc7DdpjDHdqp67W63JdFbVitOVfIbn1Tw
   g==;
X-CSE-ConnectionGUID: BOaxZq5vQnOEFB/edSNfIg==
X-CSE-MsgGUID: Y/BA+0RbSvC+ACLLLysF4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="75580705"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="75580705"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 00:39:10 -0800
X-CSE-ConnectionGUID: jNN6pRrDTUKzw9EiFdfxEQ==
X-CSE-MsgGUID: bv6PXaGTR8aNAItvWsnNqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="211582225"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa007.jf.intel.com with ESMTP; 09 Feb 2026 00:39:07 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v6 1/4] perf headers: Sync with the kernel headers
Date: Mon,  9 Feb 2026 16:35:11 +0800
Message-Id: <20260209083514.2225115-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260209083514.2225115-1-dapeng1.mi@linux.intel.com>
References: <20260209083514.2225115-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Update include/uapi/linux/perf_event.h and
arch/x86/include/uapi/asm/perf_regs.h to support extended regs.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/arch/x86/include/uapi/asm/perf_regs.h | 49 +++++++++++++++++++++
 tools/include/uapi/linux/perf_event.h       | 45 +++++++++++++++++--
 2 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/tools/arch/x86/include/uapi/asm/perf_regs.h b/tools/arch/x86/include/uapi/asm/perf_regs.h
index 7c9d2bb3833b..6da63e1dbb40 100644
--- a/tools/arch/x86/include/uapi/asm/perf_regs.h
+++ b/tools/arch/x86/include/uapi/asm/perf_regs.h
@@ -27,9 +27,34 @@ enum perf_event_x86_regs {
 	PERF_REG_X86_R13,
 	PERF_REG_X86_R14,
 	PERF_REG_X86_R15,
+	/*
+	 * The EGPRs/SSP and XMM have overlaps. Only one can be used
+	 * at a time. For the ABI type PERF_SAMPLE_REGS_ABI_SIMD,
+	 * utilize EGPRs/SSP. For the other ABI type, XMM is used.
+	 *
+	 * Extended GPRs (EGPRs)
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
@@ -54,5 +79,29 @@ enum perf_event_x86_regs {
 };
 
 #define PERF_REG_EXTENDED_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
+#define PERF_X86_EGPRS_MASK	GENMASK_ULL(PERF_REG_X86_R31, PERF_REG_X86_R16)
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
+#define PERF_X86_SIMD_PRED_MASK	GENMASK(PERF_X86_SIMD_PRED_REGS_MAX - 1, 0)
+#define PERF_X86_SIMD_VEC_MASK	GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - 1, 0)
+
+#define PERF_X86_H16ZMM_BASE		16
+
+enum {
+	PERF_X86_OPMASK_QWORDS   = 1,
+	PERF_X86_XMM_QWORDS      = 2,
+	PERF_X86_YMM_QWORDS      = 4,
+	PERF_X86_ZMM_QWORDS      = 8,
+	PERF_X86_SIMD_QWORDS_MAX = PERF_X86_ZMM_QWORDS,
+};
 
 #endif /* _ASM_X86_PERF_REGS_H */
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 72f03153dd32..ce3a14d35390 100644
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
-- 
2.34.1

