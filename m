Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65822918F5;
	Tue, 15 Apr 2025 08:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705467; cv=none; b=DyVVOGc3vauVHr3X9LgRlWccaXyQuRpkPa2Vbjz5C1uvAqedgXwOgM//o+CQTddFraOHZFDPKKQklqgFV0UJWldwGsQiVvGScH9sTsN/5SdPKPIE+YAetHIblgEJaI6iruwR5/9C4YeaA8WkKLBRlEKDkSNO8y7ABGEIW17Sq6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705467; c=relaxed/simple;
	bh=jTM45kRcQkxlXEdM7lEjqCGUqnBloRB7ou6TbwBoblk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R0cMlzE08Awcsm1I7YMEYrNFHIlftIsS8YkeMQi1fzvB5HvYh3vH2aNcqQNufktRhgTgudGldEXA0DsnxmU9E42vAb1OsMu2+Czr5aG8BHwFMnhtTnTSYC8NkugnmM9SRh/IIMRiip2TB5ZEEd2K2bszAKqrJzu2nsdHuT2DehI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kT4rAb/4; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kT4rAb/4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744705466; x=1776241466;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jTM45kRcQkxlXEdM7lEjqCGUqnBloRB7ou6TbwBoblk=;
  b=kT4rAb/4BTYwXksa/8YPmSvq57hM6+YVAt02bBn1o2WB2d2cmJsg/6H3
   Wd/E0mnUGPdx619WAXqXNqazZgE3hP+FDrkios01h9ekHRBW04OrGjxpe
   frHF9aCfofDcwunXpWy5dl86qeDcWwJvYbJJoQKlLxvEY05tkDA7LW0SV
   p9mYh9PBSW0JcyPkTmxNbzZdnFRluzMMVa/X5VxDIjUNdIr8AfuP+uLA0
   LtTz90qBbboR4Mvm40Gpcqcu+jfYjC2uVrDKITC6GHCa5gZJuSRJmtmLW
   2vOUHW9SWZc+ZPmKkLhE1ceDSPgRmfkHncOW/16gx3KNCrL2FX6f+MWlc
   g==;
X-CSE-ConnectionGUID: AbZat4XZSJqbRkwp61+NNA==
X-CSE-MsgGUID: N3kNQcgiTXKJk06a2LxErw==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="46116222"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="46116222"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 01:24:26 -0700
X-CSE-ConnectionGUID: DLI/c93/TdKTRf3jJ5Wv/Q==
X-CSE-MsgGUID: Ss4TJN44Q6eO+a2oufe+KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130055714"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa007.fm.intel.com with ESMTP; 15 Apr 2025 01:24:22 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v3 21/22] perf tools: Support to capture more vector registers (x86/Intel)
Date: Tue, 15 Apr 2025 11:44:27 +0000
Message-Id: <20250415114428.341182-22-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
References: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel architectural PEBS supports to capture more vector registers like
OPMASK/YMM/ZMM registers besides already supported XMM registers.

This patch adds Intel specific support to capture these new vector
registers for perf tools.

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/arch/x86/include/uapi/asm/perf_regs.h   |  79 ++++++++++-
 tools/perf/arch/x86/util/perf_regs.c          | 129 +++++++++++++++++-
 .../perf/util/perf-regs-arch/perf_regs_x86.c  |  82 +++++++++++
 3 files changed, 285 insertions(+), 5 deletions(-)

diff --git a/tools/arch/x86/include/uapi/asm/perf_regs.h b/tools/arch/x86/include/uapi/asm/perf_regs.h
index 1c7ab5af5cc1..c05c6ec127c8 100644
--- a/tools/arch/x86/include/uapi/asm/perf_regs.h
+++ b/tools/arch/x86/include/uapi/asm/perf_regs.h
@@ -36,7 +36,7 @@ enum perf_event_x86_regs {
 	/* PERF_REG_INTEL_PT_MAX ignores the SSP register. */
 	PERF_REG_INTEL_PT_MAX = PERF_REG_X86_R15 + 1,
 
-	/* These all need two bits set because they are 128bit */
+	/* These all need two bits set because they are 128 bits */
 	PERF_REG_X86_XMM0  = 32,
 	PERF_REG_X86_XMM1  = 34,
 	PERF_REG_X86_XMM2  = 36,
@@ -56,6 +56,83 @@ enum perf_event_x86_regs {
 
 	/* These include both GPRs and XMMX registers */
 	PERF_REG_X86_XMM_MAX = PERF_REG_X86_XMM15 + 2,
+
+	/* Leave bits[127:64] for other GP registers, like R16 ~ R31.*/
+
+	/*
+	 * Each YMM register need 4 bits to represent because they are 256 bits.
+	 * PERF_REG_X86_YMMH0 = 128
+	 */
+	PERF_REG_X86_YMM0	= 128,
+	PERF_REG_X86_YMM1	= PERF_REG_X86_YMM0 + 4,
+	PERF_REG_X86_YMM2	= PERF_REG_X86_YMM1 + 4,
+	PERF_REG_X86_YMM3	= PERF_REG_X86_YMM2 + 4,
+	PERF_REG_X86_YMM4	= PERF_REG_X86_YMM3 + 4,
+	PERF_REG_X86_YMM5	= PERF_REG_X86_YMM4 + 4,
+	PERF_REG_X86_YMM6	= PERF_REG_X86_YMM5 + 4,
+	PERF_REG_X86_YMM7	= PERF_REG_X86_YMM6 + 4,
+	PERF_REG_X86_YMM8	= PERF_REG_X86_YMM7 + 4,
+	PERF_REG_X86_YMM9	= PERF_REG_X86_YMM8 + 4,
+	PERF_REG_X86_YMM10	= PERF_REG_X86_YMM9 + 4,
+	PERF_REG_X86_YMM11	= PERF_REG_X86_YMM10 + 4,
+	PERF_REG_X86_YMM12	= PERF_REG_X86_YMM11 + 4,
+	PERF_REG_X86_YMM13	= PERF_REG_X86_YMM12 + 4,
+	PERF_REG_X86_YMM14	= PERF_REG_X86_YMM13 + 4,
+	PERF_REG_X86_YMM15	= PERF_REG_X86_YMM14 + 4,
+	PERF_REG_X86_YMM_MAX	= PERF_REG_X86_YMM15 + 4,
+
+	/*
+	 * Each ZMM register needs 8 bits to represent because they are 512 bits
+	 * PERF_REG_X86_ZMMH0 = 192
+	 */
+	PERF_REG_X86_ZMM0	= PERF_REG_X86_YMM_MAX,
+	PERF_REG_X86_ZMM1	= PERF_REG_X86_ZMM0 + 8,
+	PERF_REG_X86_ZMM2	= PERF_REG_X86_ZMM1 + 8,
+	PERF_REG_X86_ZMM3	= PERF_REG_X86_ZMM2 + 8,
+	PERF_REG_X86_ZMM4	= PERF_REG_X86_ZMM3 + 8,
+	PERF_REG_X86_ZMM5	= PERF_REG_X86_ZMM4 + 8,
+	PERF_REG_X86_ZMM6	= PERF_REG_X86_ZMM5 + 8,
+	PERF_REG_X86_ZMM7	= PERF_REG_X86_ZMM6 + 8,
+	PERF_REG_X86_ZMM8	= PERF_REG_X86_ZMM7 + 8,
+	PERF_REG_X86_ZMM9	= PERF_REG_X86_ZMM8 + 8,
+	PERF_REG_X86_ZMM10	= PERF_REG_X86_ZMM9 + 8,
+	PERF_REG_X86_ZMM11	= PERF_REG_X86_ZMM10 + 8,
+	PERF_REG_X86_ZMM12	= PERF_REG_X86_ZMM11 + 8,
+	PERF_REG_X86_ZMM13	= PERF_REG_X86_ZMM12 + 8,
+	PERF_REG_X86_ZMM14	= PERF_REG_X86_ZMM13 + 8,
+	PERF_REG_X86_ZMM15	= PERF_REG_X86_ZMM14 + 8,
+	PERF_REG_X86_ZMM16	= PERF_REG_X86_ZMM15 + 8,
+	PERF_REG_X86_ZMM17	= PERF_REG_X86_ZMM16 + 8,
+	PERF_REG_X86_ZMM18	= PERF_REG_X86_ZMM17 + 8,
+	PERF_REG_X86_ZMM19	= PERF_REG_X86_ZMM18 + 8,
+	PERF_REG_X86_ZMM20	= PERF_REG_X86_ZMM19 + 8,
+	PERF_REG_X86_ZMM21	= PERF_REG_X86_ZMM20 + 8,
+	PERF_REG_X86_ZMM22	= PERF_REG_X86_ZMM21 + 8,
+	PERF_REG_X86_ZMM23	= PERF_REG_X86_ZMM22 + 8,
+	PERF_REG_X86_ZMM24	= PERF_REG_X86_ZMM23 + 8,
+	PERF_REG_X86_ZMM25	= PERF_REG_X86_ZMM24 + 8,
+	PERF_REG_X86_ZMM26	= PERF_REG_X86_ZMM25 + 8,
+	PERF_REG_X86_ZMM27	= PERF_REG_X86_ZMM26 + 8,
+	PERF_REG_X86_ZMM28	= PERF_REG_X86_ZMM27 + 8,
+	PERF_REG_X86_ZMM29	= PERF_REG_X86_ZMM28 + 8,
+	PERF_REG_X86_ZMM30	= PERF_REG_X86_ZMM29 + 8,
+	PERF_REG_X86_ZMM31	= PERF_REG_X86_ZMM30 + 8,
+	PERF_REG_X86_ZMM_MAX	= PERF_REG_X86_ZMM31 + 8,
+
+	/*
+	 * OPMASK Registers
+	 * PERF_REG_X86_OPMASK0 = 448
+	 */
+	PERF_REG_X86_OPMASK0	= PERF_REG_X86_ZMM_MAX,
+	PERF_REG_X86_OPMASK1	= PERF_REG_X86_OPMASK0 + 1,
+	PERF_REG_X86_OPMASK2	= PERF_REG_X86_OPMASK1 + 1,
+	PERF_REG_X86_OPMASK3	= PERF_REG_X86_OPMASK2 + 1,
+	PERF_REG_X86_OPMASK4	= PERF_REG_X86_OPMASK3 + 1,
+	PERF_REG_X86_OPMASK5	= PERF_REG_X86_OPMASK4 + 1,
+	PERF_REG_X86_OPMASK6	= PERF_REG_X86_OPMASK5 + 1,
+	PERF_REG_X86_OPMASK7	= PERF_REG_X86_OPMASK6 + 1,
+
+	PERF_REG_X86_VEC_MAX	= PERF_REG_X86_OPMASK7 + 1,
 };
 
 #define PERF_REG_EXTENDED_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index 5b163f0a651a..bade6c64770c 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -54,6 +54,66 @@ static const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG2(XMM13, PERF_REG_X86_XMM13),
 	SMPL_REG2(XMM14, PERF_REG_X86_XMM14),
 	SMPL_REG2(XMM15, PERF_REG_X86_XMM15),
+
+	SMPL_REG4_EXT(YMM0, PERF_REG_X86_YMM0),
+	SMPL_REG4_EXT(YMM1, PERF_REG_X86_YMM1),
+	SMPL_REG4_EXT(YMM2, PERF_REG_X86_YMM2),
+	SMPL_REG4_EXT(YMM3, PERF_REG_X86_YMM3),
+	SMPL_REG4_EXT(YMM4, PERF_REG_X86_YMM4),
+	SMPL_REG4_EXT(YMM5, PERF_REG_X86_YMM5),
+	SMPL_REG4_EXT(YMM6, PERF_REG_X86_YMM6),
+	SMPL_REG4_EXT(YMM7, PERF_REG_X86_YMM7),
+	SMPL_REG4_EXT(YMM8, PERF_REG_X86_YMM8),
+	SMPL_REG4_EXT(YMM9, PERF_REG_X86_YMM9),
+	SMPL_REG4_EXT(YMM10, PERF_REG_X86_YMM10),
+	SMPL_REG4_EXT(YMM11, PERF_REG_X86_YMM11),
+	SMPL_REG4_EXT(YMM12, PERF_REG_X86_YMM12),
+	SMPL_REG4_EXT(YMM13, PERF_REG_X86_YMM13),
+	SMPL_REG4_EXT(YMM14, PERF_REG_X86_YMM14),
+	SMPL_REG4_EXT(YMM15, PERF_REG_X86_YMM15),
+
+	SMPL_REG8_EXT(ZMM0, PERF_REG_X86_ZMM0),
+	SMPL_REG8_EXT(ZMM1, PERF_REG_X86_ZMM1),
+	SMPL_REG8_EXT(ZMM2, PERF_REG_X86_ZMM2),
+	SMPL_REG8_EXT(ZMM3, PERF_REG_X86_ZMM3),
+	SMPL_REG8_EXT(ZMM4, PERF_REG_X86_ZMM4),
+	SMPL_REG8_EXT(ZMM5, PERF_REG_X86_ZMM5),
+	SMPL_REG8_EXT(ZMM6, PERF_REG_X86_ZMM6),
+	SMPL_REG8_EXT(ZMM7, PERF_REG_X86_ZMM7),
+	SMPL_REG8_EXT(ZMM8, PERF_REG_X86_ZMM8),
+	SMPL_REG8_EXT(ZMM9, PERF_REG_X86_ZMM9),
+	SMPL_REG8_EXT(ZMM10, PERF_REG_X86_ZMM10),
+	SMPL_REG8_EXT(ZMM11, PERF_REG_X86_ZMM11),
+	SMPL_REG8_EXT(ZMM12, PERF_REG_X86_ZMM12),
+	SMPL_REG8_EXT(ZMM13, PERF_REG_X86_ZMM13),
+	SMPL_REG8_EXT(ZMM14, PERF_REG_X86_ZMM14),
+	SMPL_REG8_EXT(ZMM15, PERF_REG_X86_ZMM15),
+	SMPL_REG8_EXT(ZMM16, PERF_REG_X86_ZMM16),
+	SMPL_REG8_EXT(ZMM17, PERF_REG_X86_ZMM17),
+	SMPL_REG8_EXT(ZMM18, PERF_REG_X86_ZMM18),
+	SMPL_REG8_EXT(ZMM19, PERF_REG_X86_ZMM19),
+	SMPL_REG8_EXT(ZMM20, PERF_REG_X86_ZMM20),
+	SMPL_REG8_EXT(ZMM21, PERF_REG_X86_ZMM21),
+	SMPL_REG8_EXT(ZMM22, PERF_REG_X86_ZMM22),
+	SMPL_REG8_EXT(ZMM23, PERF_REG_X86_ZMM23),
+	SMPL_REG8_EXT(ZMM24, PERF_REG_X86_ZMM24),
+	SMPL_REG8_EXT(ZMM25, PERF_REG_X86_ZMM25),
+	SMPL_REG8_EXT(ZMM26, PERF_REG_X86_ZMM26),
+	SMPL_REG8_EXT(ZMM27, PERF_REG_X86_ZMM27),
+	SMPL_REG8_EXT(ZMM28, PERF_REG_X86_ZMM28),
+	SMPL_REG8_EXT(ZMM29, PERF_REG_X86_ZMM29),
+	SMPL_REG8_EXT(ZMM30, PERF_REG_X86_ZMM30),
+	SMPL_REG8_EXT(ZMM31, PERF_REG_X86_ZMM31),
+
+	SMPL_REG_EXT(OPMASK0, PERF_REG_X86_OPMASK0),
+	SMPL_REG_EXT(OPMASK1, PERF_REG_X86_OPMASK1),
+	SMPL_REG_EXT(OPMASK2, PERF_REG_X86_OPMASK2),
+	SMPL_REG_EXT(OPMASK3, PERF_REG_X86_OPMASK3),
+	SMPL_REG_EXT(OPMASK4, PERF_REG_X86_OPMASK4),
+	SMPL_REG_EXT(OPMASK5, PERF_REG_X86_OPMASK5),
+	SMPL_REG_EXT(OPMASK6, PERF_REG_X86_OPMASK6),
+	SMPL_REG_EXT(OPMASK7, PERF_REG_X86_OPMASK7),
+
 	SMPL_REG_END
 };
 
@@ -283,13 +343,59 @@ const struct sample_reg *arch__sample_reg_masks(void)
 	return sample_reg_masks;
 }
 
-void arch__intr_reg_mask(unsigned long *mask)
+static void check_ext2_regs_mask(struct perf_event_attr *attr, bool user,
+				 int idx, u64 fmask, unsigned long *mask)
+{
+	u64 reg_mask[PERF_SAMPLE_ARRAY_SIZE] = { 0 };
+	int fd;
+
+	if (user) {
+		attr->sample_regs_user = 0;
+		attr->sample_regs_user_ext[idx] = fmask;
+	} else {
+		attr->sample_regs_intr = 0;
+		attr->sample_regs_intr_ext[idx] = fmask;
+	}
+
+	/* reg_mask[] includes sample_regs_intr regs, so index need add 1. */
+	reg_mask[idx + 1] = fmask;
+
+	fd = sys_perf_event_open(attr, 0, -1, -1, 0);
+	if (fd != -1) {
+		close(fd);
+		bitmap_or(mask, mask, (unsigned long *)reg_mask,
+			  PERF_SAMPLE_REGS_NUM);
+	}
+}
+
+#define PERF_REG_EXTENDED_YMM_MASK	GENMASK_ULL(63, 0)
+#define PERF_REG_EXTENDED_ZMM_MASK	GENMASK_ULL(63, 0)
+#define PERF_REG_EXTENDED_OPMASK_MASK	GENMASK_ULL(7, 0)
+
+static void get_ext2_regs_mask(struct perf_event_attr *attr, bool user,
+			       unsigned long *mask)
+{
+	event_attr_init(attr);
+
+	/* Check YMM regs, bits 128 ~ 191. */
+	check_ext2_regs_mask(attr, user, 1, PERF_REG_EXTENDED_YMM_MASK, mask);
+	/* Check ZMM 0-7 regs, bits 192 ~ 255. */
+	check_ext2_regs_mask(attr, user, 2, PERF_REG_EXTENDED_ZMM_MASK, mask);
+	/* Check ZMM 8-15 regs, bits 256 ~ 319. */
+	check_ext2_regs_mask(attr, user, 3, PERF_REG_EXTENDED_ZMM_MASK, mask);
+	/* Check ZMM 16-23 regs, bits 320 ~ 383. */
+	check_ext2_regs_mask(attr, user, 4, PERF_REG_EXTENDED_ZMM_MASK, mask);
+	/* Check ZMM 16-23 regs, bits 384 ~ 447. */
+	check_ext2_regs_mask(attr, user, 5, PERF_REG_EXTENDED_ZMM_MASK, mask);
+	/* Check OPMASK regs, bits 448 ~ 455. */
+	check_ext2_regs_mask(attr, user, 6, PERF_REG_EXTENDED_OPMASK_MASK, mask);
+}
+
+static void arch__get_reg_mask(unsigned long *mask, bool user)
 {
 	struct perf_event_attr attr = {
 		.type			= PERF_TYPE_HARDWARE,
 		.config			= PERF_COUNT_HW_CPU_CYCLES,
-		.sample_type		= PERF_SAMPLE_REGS_INTR,
-		.sample_regs_intr	= PERF_REG_EXTENDED_MASK,
 		.precise_ip		= 1,
 		.disabled 		= 1,
 		.exclude_kernel		= 1,
@@ -298,6 +404,14 @@ void arch__intr_reg_mask(unsigned long *mask)
 
 	*(u64 *)mask = PERF_REGS_MASK;
 
+	if (user) {
+		attr.sample_type = PERF_SAMPLE_REGS_USER;
+		attr.sample_regs_user = PERF_REG_EXTENDED_MASK;
+	} else {
+		attr.sample_type = PERF_SAMPLE_REGS_INTR;
+		attr.sample_regs_intr = PERF_REG_EXTENDED_MASK;
+	}
+
 	/*
 	 * In an unnamed union, init it here to build on older gcc versions
 	 */
@@ -325,9 +439,16 @@ void arch__intr_reg_mask(unsigned long *mask)
 		close(fd);
 		*(u64 *)mask = PERF_REG_EXTENDED_MASK | PERF_REGS_MASK;
 	}
+
+	get_ext2_regs_mask(&attr, user, mask);
+}
+
+void arch__intr_reg_mask(unsigned long *mask)
+{
+	arch__get_reg_mask(mask, false);
 }
 
 void arch__user_reg_mask(unsigned long *mask)
 {
-	*(uint64_t *)mask = PERF_REGS_MASK;
+	arch__get_reg_mask(mask, true);
 }
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_x86.c b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
index c0e95215b577..eb1e3d716f27 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_x86.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
@@ -78,6 +78,88 @@ const char *__perf_reg_name_x86(int id)
 	XMM(14)
 	XMM(15)
 #undef XMM
+
+#define YMM(x)					\
+	case PERF_REG_X86_YMM ## x:		\
+	case PERF_REG_X86_YMM ## x + 1:		\
+	case PERF_REG_X86_YMM ## x + 2:		\
+	case PERF_REG_X86_YMM ## x + 3:		\
+		return "YMM" #x;
+	YMM(0)
+	YMM(1)
+	YMM(2)
+	YMM(3)
+	YMM(4)
+	YMM(5)
+	YMM(6)
+	YMM(7)
+	YMM(8)
+	YMM(9)
+	YMM(10)
+	YMM(11)
+	YMM(12)
+	YMM(13)
+	YMM(14)
+	YMM(15)
+#undef YMM
+
+#define ZMM(x)				\
+	case PERF_REG_X86_ZMM ## x:		\
+	case PERF_REG_X86_ZMM ## x + 1:	\
+	case PERF_REG_X86_ZMM ## x + 2:	\
+	case PERF_REG_X86_ZMM ## x + 3:	\
+	case PERF_REG_X86_ZMM ## x + 4:	\
+	case PERF_REG_X86_ZMM ## x + 5:	\
+	case PERF_REG_X86_ZMM ## x + 6:	\
+	case PERF_REG_X86_ZMM ## x + 7:	\
+		return "ZMM" #x;
+	ZMM(0)
+	ZMM(1)
+	ZMM(2)
+	ZMM(3)
+	ZMM(4)
+	ZMM(5)
+	ZMM(6)
+	ZMM(7)
+	ZMM(8)
+	ZMM(9)
+	ZMM(10)
+	ZMM(11)
+	ZMM(12)
+	ZMM(13)
+	ZMM(14)
+	ZMM(15)
+	ZMM(16)
+	ZMM(17)
+	ZMM(18)
+	ZMM(19)
+	ZMM(20)
+	ZMM(21)
+	ZMM(22)
+	ZMM(23)
+	ZMM(24)
+	ZMM(25)
+	ZMM(26)
+	ZMM(27)
+	ZMM(28)
+	ZMM(29)
+	ZMM(30)
+	ZMM(31)
+#undef ZMM
+
+#define OPMASK(x)				\
+	case PERF_REG_X86_OPMASK ## x:		\
+		return "opmask" #x;
+
+	OPMASK(0)
+	OPMASK(1)
+	OPMASK(2)
+	OPMASK(3)
+	OPMASK(4)
+	OPMASK(5)
+	OPMASK(6)
+	OPMASK(7)
+#undef OPMASK
 	default:
 		return NULL;
 	}
-- 
2.40.1

