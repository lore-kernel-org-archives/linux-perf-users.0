Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E202E7165;
	Mon, 14 Sep 2026 01:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789350472; cv=none; b=kCruJEMjBnHkbGhNzJU/FL2RizfnfROtQS4vUyZ44wI1awG4kKsMnO/v+R25OjGz86AFTutzStCYji0qBKNnea/CRlAahkR36EyuQlb+ZSvcUBcwdxe7oaytMhIeFCEBr2YKfNFtQn1Tg+HuTj+IeZKYsRfXqC4KhSkkknbWjF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789350472; c=relaxed/simple;
	bh=JG2Ey0DrEQayiqAXqRA60RZMoTa6uzAtzRyQQST9Eo4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P1JT6eiNNJXTTLF3DBVjzNAI21LCBpcDbE6yJn4u/cuXdwSRBR1eNT58AStGUN+AkPhxM9lJoNwxBPjHcn9lRD3fgsInst0o5pDQVuAzjJjannDf5LpUfhAn+Iq6EmTDD08CB21yskVQSDeWI4jjMVryfxX+k0/jyb480dFFPyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IlyTr/J3; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IlyTr/J3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789350469; x=1820886469;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JG2Ey0DrEQayiqAXqRA60RZMoTa6uzAtzRyQQST9Eo4=;
  b=IlyTr/J3RfdaeLJ419s3xDQxNYrNaHrs5mHFt+4D+mw3f5ov0q1iUhwQ
   eQSPL2zvWJuvGUER0AIU4cK4umuXuBnlIGyN1Ee21DB8xvRv0PA9Ugi2f
   euy76jIAhTvZaojPwy1TaCHaVLxDgN9BBoLWYehQL6UYfslDpB/6ozv8J
   pezQz5jKddYZ01GSsgCaTqWX7ztqXz3WavdjBGlm4x4vZIP3kr75guCg8
   +hRrAgBKEqhaOOToXX0VWWDyCSUQYUheX3CNVtp1JWT4k5SPsPWKGPQ0U
   8l2b2ZX10v2egK5MyrJ50wrKq8y5Zc91xfA7EOX8+X/OSXKar33Mroins
   Q==;
X-CSE-ConnectionGUID: KGbgzq5DQu2FiWo/bM9+sQ==
X-CSE-MsgGUID: y6lwT2VOR1mzEVtO3ICtMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="93530630"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="93530630"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 18:47:49 -0700
X-CSE-ConnectionGUID: 2T52nNYJQVCtAFuJp3pZmw==
X-CSE-MsgGUID: cqG/7XTISQWpQOis4eJ3zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="276664169"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa005.jf.intel.com with ESMTP; 13 Sep 2026 18:47:46 -0700
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [Patch v11 04/10] perf headers: Sync perf_event.h/perf_regs.h with the kernel headers
Date: Mon, 14 Sep 2026 09:40:43 +0800
Message-Id: <20260914014049.2061519-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914014049.2061519-1-dapeng1.mi@linux.intel.com>
References: <20260914014049.2061519-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sync the UAPI header changes of supporting SIMD/eGPRs/SSP sampling into
corresponding tools UAPI headers.

Additionally, support the new introduced perf_event_attr fields in the
perf_event_attr__fprintf and perf_event__attr_swap() helpers, and add
sanity check for the new introduced __reserved_4 field in
perf_attr_check().

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/arch/x86/include/uapi/asm/perf_regs.h | 53 +++++++++++++++++++++
 tools/include/uapi/linux/perf_event.h       | 49 +++++++++++++++++--
 tools/perf/util/header.c                    |  3 +-
 tools/perf/util/perf_event_attr_fprintf.c   | 11 ++++-
 tools/perf/util/session.c                   |  7 +++
 5 files changed, 117 insertions(+), 6 deletions(-)

diff --git a/tools/arch/x86/include/uapi/asm/perf_regs.h b/tools/arch/x86/include/uapi/asm/perf_regs.h
index 7c9d2bb3833b..faaa82df688d 100644
--- a/tools/arch/x86/include/uapi/asm/perf_regs.h
+++ b/tools/arch/x86/include/uapi/asm/perf_regs.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_PERF_REGS_H
 #define _ASM_X86_PERF_REGS_H
 
+#include <linux/bits.h>
+
 enum perf_event_x86_regs {
 	PERF_REG_X86_AX,
 	PERF_REG_X86_BX,
@@ -27,9 +29,35 @@ enum perf_event_x86_regs {
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
@@ -54,5 +82,30 @@ enum perf_event_x86_regs {
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
index 7db7da090a1e..97665c1b892b 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2163,7 +2163,8 @@ static void free_event_desc(struct evsel *events)
 
 static bool perf_attr_check(struct perf_event_attr *attr)
 {
-	if (attr->__reserved_1 || attr->__reserved_2 || attr->__reserved_3) {
+	if (attr->__reserved_1 || attr->__reserved_2 ||
+	    attr->__reserved_3 || attr->__reserved_4) {
 		pr_warning("Reserved bits are set unexpectedly. "
 			   "Please update perf tool.\n");
 		return false;
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index cc817294ad3d..2e8be9a357dc 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -407,8 +407,17 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	}
 	if (attr_size >= offsetof(struct perf_event_attr, config4))
 		PRINT_ATTRf(config3, p_hex);
-	if (attr_size > offsetof(struct perf_event_attr, config4))
+	if (attr_size >= offsetof(struct perf_event_attr, sample_simd_regs_enabled))
 		PRINT_ATTRf(config4, p_hex);
+	if (attr_size > offsetof(struct perf_event_attr, sample_simd_vec_reg_user)) {
+		PRINT_ATTRf(sample_simd_regs_enabled, p_unsigned);
+		PRINT_ATTRf(sample_simd_pred_reg_qwords, p_unsigned);
+		PRINT_ATTRf(sample_simd_pred_reg_intr, p_hex);
+		PRINT_ATTRf(sample_simd_pred_reg_user, p_hex);
+		PRINT_ATTRf(sample_simd_vec_reg_qwords, p_unsigned);
+		PRINT_ATTRf(sample_simd_vec_reg_intr, p_hex);
+		PRINT_ATTRf(sample_simd_vec_reg_user, p_hex);
+	}
 
 	return ret;
 }
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 212506aa8baa..c7ac0e7c5c04 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -639,6 +639,13 @@ do { 						\
 	bswap_field_64(sig_data);
 	bswap_field_64(config3);
 	bswap_field_64(config4);
+	bswap_field_16(sample_simd_regs_enabled);
+	bswap_field_16(sample_simd_pred_reg_qwords);
+	bswap_field_16(sample_simd_vec_reg_qwords);
+	bswap_field_32(sample_simd_pred_reg_intr);
+	bswap_field_32(sample_simd_pred_reg_user);
+	bswap_field_64(sample_simd_vec_reg_intr);
+	bswap_field_64(sample_simd_vec_reg_user);
 
 	/*
 	 * After read_format are bitfields. Check read_format because
-- 
2.34.1

