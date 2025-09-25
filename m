Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5465C2EB5AB;
	Thu, 25 Sep 2025 06:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780912; cv=none; b=sJ8rowCF63gamhh0xxCWOCFSaM/k9oNQa1VpSTemVzJF/zN4iB59laMjemRMI7Mm6VGfBXWtq858Oa88/LBswUJoEl8qRYGfRDQeV+Ix2rwrOYTLW1jkDViUpHOVYyjBJ3Ey7p+a7edTbSw6ZWoGFSSt58IhVTe+OnNBJgY2NQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780912; c=relaxed/simple;
	bh=/DZjLiHbROEAt2tRBxmRsH7PXnmgdC90HNQoXpmGdjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pfawOQh2truREEmYgFGlFZQneITc7tjV0EdYEUb15+moYa+ZEZw6ybz5jkWCDfHDOx4au1e90823J7UAZRXUFwKf3wwOQcM1oAOSp8DUvWz97oylpnfqzMjwJEYWzSdZPWDAKpjdZe7Cdh3etEu+7qDlGA97Ua5/iWAwjsTTvmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cYrAyKjw; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cYrAyKjw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758780910; x=1790316910;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/DZjLiHbROEAt2tRBxmRsH7PXnmgdC90HNQoXpmGdjg=;
  b=cYrAyKjwE+FCtptxNDneal8LSXXKo+2hNWiun+w2G45J4XbUnyfeN8b3
   NjMOl7xmC6S3jZoTHZQtatATvbroc8FbyXMf6c9vFy9OKRYgQhlWtCCN+
   QqdXfTx1aUbBXpHvU3nyL/4xWzqUla//y4YUGOojS3+SiT+uZOs3qeb6O
   644fKkaci3ORUF3FjVHdWGEFRMplTmtMdfvXw3Ks9Rbpn9yYGyCrkx+gn
   f7k7EKhQFqMIeLgAbH3dN+V36o7mM9JopN0qKfKcHGNpnuMkJywQ1EVgF
   y9od9qjJCf2WPlv2QjFQwFom71rn4EEAi61ZNqQJqB2M00Yf/+RkS9rcN
   A==;
X-CSE-ConnectionGUID: PEiw1dJ4TEmKerq+781X0g==
X-CSE-MsgGUID: ZHpzIbYQRpaIHmUfNXjIHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="61139600"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="61139600"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 23:15:10 -0700
X-CSE-ConnectionGUID: KQm0LKrFRma4VYk/R+i+ng==
X-CSE-MsgGUID: RaVU90jHT1mPD4s6XGJRfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="181528503"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa004.jf.intel.com with ESMTP; 24 Sep 2025 23:15:04 -0700
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
Subject: [Patch v4 11/17] perf/x86: Add eGPRs into sample_regs
Date: Thu, 25 Sep 2025 14:12:07 +0800
Message-Id: <20250925061213.178796-12-dapeng1.mi@linux.intel.com>
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

The eGPRs is only supported when the new SIMD registers configuration
method is used, which moves the XMM to sample_simd_vec_regs. So the
space can be reclaimed for the eGPRs.

The eGPRs is retrieved by XSAVE. Only support the eGPRs for X86_64.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c                | 41 ++++++++++++++++++---------
 arch/x86/events/perf_event.h          | 10 +++++++
 arch/x86/include/asm/perf_event.h     |  4 +++
 arch/x86/include/uapi/asm/perf_regs.h | 26 ++++++++++++++++-
 arch/x86/kernel/perf_regs.c           | 31 ++++++++++----------
 5 files changed, 83 insertions(+), 29 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index c942c6f808ca..a435610f4d4a 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -432,6 +432,8 @@ static void x86_pmu_get_ext_regs(struct x86_perf_regs *perf_regs, u64 mask)
 		perf_regs->h16zmm = get_xsave_addr(xsave, XFEATURE_Hi16_ZMM);
 	if (valid_mask & XFEATURE_MASK_OPMASK)
 		perf_regs->opmask = get_xsave_addr(xsave, XFEATURE_OPMASK);
+	if (valid_mask & XFEATURE_MASK_APX)
+		perf_regs->egpr = get_xsave_addr(xsave, XFEATURE_APX);
 }
 
 static void release_ext_regs_buffers(void)
@@ -709,22 +711,21 @@ int x86_pmu_hw_config(struct perf_event *event)
 	}
 
 	if (event->attr.sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)) {
-		/*
-		 * Besides the general purpose registers, XMM registers may
-		 * be collected as well.
-		 */
-		if (event_has_extended_regs(event)) {
-			if (!(event->pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS))
-				return -EINVAL;
-			if (!event->attr.precise_ip)
-				return -EINVAL;
-			if (event->attr.sample_simd_regs_enabled)
-				return -EINVAL;
-		}
-
 		if (event_has_simd_regs(event)) {
+			u64 reserved = ~GENMASK_ULL(PERF_REG_X86_64_MAX - 1, 0);
+
 			if (!(event->pmu->capabilities & PERF_PMU_CAP_SIMD_REGS))
 				return -EINVAL;
+			/*
+			 * The XMM space in the perf_event_x86_regs is reclaimed
+			 * for eGPRs and other general registers.
+			 */
+			if (event->attr.sample_regs_user & reserved ||
+			    event->attr.sample_regs_intr & reserved)
+				return -EINVAL;
+			if (event_needs_egprs(event) &&
+			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_APX))
+				return -EINVAL;
 			/* Not require any vector registers but set width */
 			if (event->attr.sample_simd_vec_reg_qwords &&
 			    !event->attr.sample_simd_vec_reg_intr &&
@@ -746,6 +747,17 @@ int x86_pmu_hw_config(struct perf_event *event)
 			if (event_needs_opmask(event) &&
 			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_OPMASK))
 				return -EINVAL;
+		} else {
+			/*
+			 * Besides the general purpose registers, XMM registers may
+			 * be collected as well.
+			 */
+			if (event_has_extended_regs(event)) {
+				if (!(event->pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS))
+					return -EINVAL;
+				if (!event->attr.precise_ip)
+					return -EINVAL;
+			}
 		}
 	}
 
@@ -1908,6 +1920,9 @@ static void x86_pmu_setup_extended_regs_data(struct perf_event *event,
 	perf_regs->opmask_regs = NULL;
 	if (event_needs_opmask(event))
 		mask |= XFEATURE_MASK_OPMASK;
+	perf_regs->egpr_regs = NULL;
+	if (event_needs_egprs(event))
+		mask |= XFEATURE_MASK_APX;
 
 	mask &= ~ignore_mask;
 	if (mask)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 4584de1c79a3..3dd0e669ddd4 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -182,6 +182,16 @@ static inline bool event_needs_opmask(struct perf_event *event)
 	return false;
 }
 
+static inline bool event_needs_egprs(struct perf_event *event)
+{
+	if (event->attr.sample_simd_regs_enabled &&
+	    (event->attr.sample_regs_user & PERF_X86_EGPRS_MASK ||
+	     event->attr.sample_regs_intr & PERF_X86_EGPRS_MASK))
+		return true;
+
+	return false;
+}
+
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
 	int refcnt; /* reference count */
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index d8cac3f9f8df..73c2064c13f9 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -617,6 +617,10 @@ struct x86_perf_regs {
 		u64	*opmask_regs;
 		struct avx_512_opmask_state *opmask;
 	};
+	union {
+		u64	*egpr_regs;
+		struct apx_state *egpr;
+	};
 };
 
 extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
index 6f29fd9495a2..38644de89815 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -27,9 +27,32 @@ enum perf_event_x86_regs {
 	PERF_REG_X86_R13,
 	PERF_REG_X86_R14,
 	PERF_REG_X86_R15,
+	/*
+	 * The EGPRs and XMM have overlaps. Only one can be used
+	 * at a time. For the ABI type PERF_SAMPLE_REGS_ABI_SIMD,
+	 * utilize EGPRs. For the other ABI type, XMM is used.
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
 	/* These are the limits for the GPRs. */
 	PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
-	PERF_REG_X86_64_MAX = PERF_REG_X86_R15 + 1,
+	PERF_REG_X86_64_MAX = PERF_REG_X86_R31 + 1,
 
 	/* These all need two bits set because they are 128bit */
 	PERF_REG_X86_XMM0  = 32,
@@ -54,6 +77,7 @@ enum perf_event_x86_regs {
 };
 
 #define PERF_REG_EXTENDED_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
+#define PERF_X86_EGPRS_MASK	GENMASK_ULL(PERF_REG_X86_R31, PERF_REG_X86_R16)
 
 enum {
 	PERF_REG_X86_XMM,
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index f6e9cde11ba1..b98b47a79d02 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -92,14 +92,22 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 {
 	struct x86_perf_regs *perf_regs;
 
-	if (idx >= PERF_REG_X86_XMM0 && idx < PERF_REG_X86_XMM_MAX) {
+	if (idx > PERF_REG_X86_R15) {
 		perf_regs = container_of(regs, struct x86_perf_regs, regs);
-		/* SIMD registers are moved to dedicated sample_simd_vec_reg */
-		if (perf_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD)
-			return 0;
-		if (!perf_regs->xmm_regs)
-			return 0;
-		return perf_regs->xmm_regs[idx - PERF_REG_X86_XMM0];
+
+		if (perf_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
+			if (idx <= PERF_REG_X86_R31) {
+				if (!perf_regs->egpr_regs)
+					return 0;
+				return perf_regs->egpr_regs[idx - PERF_REG_X86_R16];
+			}
+		} else {
+			if (idx >= PERF_REG_X86_XMM0 && idx < PERF_REG_X86_XMM_MAX) {
+				if (!perf_regs->xmm_regs)
+					return 0;
+				return perf_regs->xmm_regs[idx - PERF_REG_X86_XMM0];
+			}
+		}
 	}
 
 	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(pt_regs_offset)))
@@ -183,14 +191,7 @@ int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
 				 ~((1ULL << PERF_REG_X86_MAX) - 1))
 
 #ifdef CONFIG_X86_32
-#define REG_NOSUPPORT ((1ULL << PERF_REG_X86_R8) | \
-		       (1ULL << PERF_REG_X86_R9) | \
-		       (1ULL << PERF_REG_X86_R10) | \
-		       (1ULL << PERF_REG_X86_R11) | \
-		       (1ULL << PERF_REG_X86_R12) | \
-		       (1ULL << PERF_REG_X86_R13) | \
-		       (1ULL << PERF_REG_X86_R14) | \
-		       (1ULL << PERF_REG_X86_R15))
+#define REG_NOSUPPORT GENMASK_ULL(PERF_REG_X86_R31, PERF_REG_X86_R8)
 
 int perf_reg_validate(u64 mask)
 {
-- 
2.34.1

