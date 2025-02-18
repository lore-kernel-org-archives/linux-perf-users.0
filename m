Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3D823DE85;
	Tue, 18 Feb 2025 08:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866515; cv=none; b=DGFqlYNRfNVMTuR330xIf/huoF8UFv00fvMfRjYIleFD1aH4f1RSD8CQSOd9DzLOBiAMA/RRMiNVbzrI23D7N8ERVuKPBfF3fl1QlzfjfFlNjU4XaFkvH6XT08wnWbyCDmfRqynhxF2KHCQBkb5cMR5Xt8J6D7uTpQIIjUQszto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866515; c=relaxed/simple;
	bh=DuhbR+ynGET7/SbvltgjcHoLV20JGQCoa9eI9Vj6Q6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VkQPjvQBbpBsR4dZG31TjDgibe7KWIEY01oz3VOjB/jSrbam6SmZfh4D2ZhpjURRaCoDhktIhd46qkran7djYLISPVnFmWt1yLzwwBmiGh6Ce6hOZjUu2swCxYFLGFzffN5H48gWiRI/jfxZO+hBoGs5++u3WXbkd0L3+2wraV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QyyeyiLi; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QyyeyiLi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739866515; x=1771402515;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DuhbR+ynGET7/SbvltgjcHoLV20JGQCoa9eI9Vj6Q6E=;
  b=QyyeyiLiSUfkfQQoMP2JLWd2HIgk4DAAE8kR9PU6JihrpP3aazeLRuQc
   h9u0EEwiDSXpM1pYWMUpgm7PYyWqReJGtKI+r5YyUbs88ClcadwHFj5+h
   0ToE8z1nL1zS8IDBED+lowyAt4v5lgR9fSLAwUd43X8fENwaeOyGC+COq
   +p45omWBwot6qqYQgbhaupjS+Oj5pkTZSLza91SyEmyCJEPZAC0t34sg7
   hx1reQofvRN5CpoWs9W6/GDvapE0RjHK4KxlLTjFfGpackUlhX2lippoL
   XCOv2ehJcbEdytKcDDNoreVR+f8igasGlt4cF6MwZvIEJjbUKKgMY+eJt
   g==;
X-CSE-ConnectionGUID: eCCZ5cLFQ9StPa9B+tkO/g==
X-CSE-MsgGUID: Qd/Ai9WkTwSN0Yd/6sFdbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44200897"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="44200897"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 00:15:14 -0800
X-CSE-ConnectionGUID: IuogitN8TKCmzpkAijAotw==
X-CSE-MsgGUID: dDjFNhj6QA2FFCay+fXllg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="145166364"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa002.jf.intel.com with ESMTP; 18 Feb 2025 00:15:09 -0800
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
Subject: [Patch v2 22/24] perf tools: Support to capture more vector registers (x86/Intel)
Date: Tue, 18 Feb 2025 15:28:16 +0000
Message-Id: <20250218152818.158614-23-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
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

Besides, add SSP in perf regs. SSP is stored in general register group
and is selected by sample_regs_intr.

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/arch/x86/include/uapi/asm/perf_regs.h   | 83 +++++++++++++++-
 tools/perf/arch/x86/util/perf_regs.c          | 99 +++++++++++++++++++
 .../perf/util/perf-regs-arch/perf_regs_x86.c  | 88 +++++++++++++++++
 3 files changed, 269 insertions(+), 1 deletion(-)

diff --git a/tools/arch/x86/include/uapi/asm/perf_regs.h b/tools/arch/x86/include/uapi/asm/perf_regs.h
index 9c45b07bfcf7..9d19eef7d7a2 100644
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
@@ -56,6 +56,87 @@ enum perf_event_x86_regs {
 
 	/* These include both GPRs and XMMX registers */
 	PERF_REG_X86_XMM_MAX = PERF_REG_X86_XMM15 + 2,
+
+	/*
+	 * YMM upper bits need two bits set because they are 128 bits.
+	 * PERF_REG_X86_YMMH0 = 64
+	 */
+	PERF_REG_X86_YMMH0	= PERF_REG_X86_XMM_MAX,
+	PERF_REG_X86_YMMH1	= PERF_REG_X86_YMMH0 + 2,
+	PERF_REG_X86_YMMH2	= PERF_REG_X86_YMMH1 + 2,
+	PERF_REG_X86_YMMH3	= PERF_REG_X86_YMMH2 + 2,
+	PERF_REG_X86_YMMH4	= PERF_REG_X86_YMMH3 + 2,
+	PERF_REG_X86_YMMH5	= PERF_REG_X86_YMMH4 + 2,
+	PERF_REG_X86_YMMH6	= PERF_REG_X86_YMMH5 + 2,
+	PERF_REG_X86_YMMH7	= PERF_REG_X86_YMMH6 + 2,
+	PERF_REG_X86_YMMH8	= PERF_REG_X86_YMMH7 + 2,
+	PERF_REG_X86_YMMH9	= PERF_REG_X86_YMMH8 + 2,
+	PERF_REG_X86_YMMH10	= PERF_REG_X86_YMMH9 + 2,
+	PERF_REG_X86_YMMH11	= PERF_REG_X86_YMMH10 + 2,
+	PERF_REG_X86_YMMH12	= PERF_REG_X86_YMMH11 + 2,
+	PERF_REG_X86_YMMH13	= PERF_REG_X86_YMMH12 + 2,
+	PERF_REG_X86_YMMH14	= PERF_REG_X86_YMMH13 + 2,
+	PERF_REG_X86_YMMH15	= PERF_REG_X86_YMMH14 + 2,
+	PERF_REG_X86_YMMH_MAX	= PERF_REG_X86_YMMH15 + 2,
+
+	/*
+	 * ZMM0-15 upper bits need four bits set because they are 256 bits
+	 * PERF_REG_X86_ZMMH0 = 96
+	 */
+	PERF_REG_X86_ZMMH0	= PERF_REG_X86_YMMH_MAX,
+	PERF_REG_X86_ZMMH1	= PERF_REG_X86_ZMMH0 + 4,
+	PERF_REG_X86_ZMMH2	= PERF_REG_X86_ZMMH1 + 4,
+	PERF_REG_X86_ZMMH3	= PERF_REG_X86_ZMMH2 + 4,
+	PERF_REG_X86_ZMMH4	= PERF_REG_X86_ZMMH3 + 4,
+	PERF_REG_X86_ZMMH5	= PERF_REG_X86_ZMMH4 + 4,
+	PERF_REG_X86_ZMMH6	= PERF_REG_X86_ZMMH5 + 4,
+	PERF_REG_X86_ZMMH7	= PERF_REG_X86_ZMMH6 + 4,
+	PERF_REG_X86_ZMMH8	= PERF_REG_X86_ZMMH7 + 4,
+	PERF_REG_X86_ZMMH9	= PERF_REG_X86_ZMMH8 + 4,
+	PERF_REG_X86_ZMMH10	= PERF_REG_X86_ZMMH9 + 4,
+	PERF_REG_X86_ZMMH11	= PERF_REG_X86_ZMMH10 + 4,
+	PERF_REG_X86_ZMMH12	= PERF_REG_X86_ZMMH11 + 4,
+	PERF_REG_X86_ZMMH13	= PERF_REG_X86_ZMMH12 + 4,
+	PERF_REG_X86_ZMMH14	= PERF_REG_X86_ZMMH13 + 4,
+	PERF_REG_X86_ZMMH15	= PERF_REG_X86_ZMMH14 + 4,
+	PERF_REG_X86_ZMMH_MAX	= PERF_REG_X86_ZMMH15 + 4,
+
+	/*
+	 * ZMM16-31 need eight bits set because they are 512 bits
+	 * PERF_REG_X86_ZMM16 = 160
+	 */
+	PERF_REG_X86_ZMM16	= PERF_REG_X86_ZMMH_MAX,
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
+	 * PERF_REG_X86_OPMASK0 = 288
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
index 5b163f0a651a..1902a715efa6 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -54,6 +54,67 @@ static const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG2(XMM13, PERF_REG_X86_XMM13),
 	SMPL_REG2(XMM14, PERF_REG_X86_XMM14),
 	SMPL_REG2(XMM15, PERF_REG_X86_XMM15),
+
+	SMPL_REG2_EXT(YMMH0, PERF_REG_X86_YMMH0),
+	SMPL_REG2_EXT(YMMH1, PERF_REG_X86_YMMH1),
+	SMPL_REG2_EXT(YMMH2, PERF_REG_X86_YMMH2),
+	SMPL_REG2_EXT(YMMH3, PERF_REG_X86_YMMH3),
+	SMPL_REG2_EXT(YMMH4, PERF_REG_X86_YMMH4),
+	SMPL_REG2_EXT(YMMH5, PERF_REG_X86_YMMH5),
+	SMPL_REG2_EXT(YMMH6, PERF_REG_X86_YMMH6),
+	SMPL_REG2_EXT(YMMH7, PERF_REG_X86_YMMH7),
+	SMPL_REG2_EXT(YMMH8, PERF_REG_X86_YMMH8),
+	SMPL_REG2_EXT(YMMH9, PERF_REG_X86_YMMH9),
+	SMPL_REG2_EXT(YMMH10, PERF_REG_X86_YMMH10),
+	SMPL_REG2_EXT(YMMH11, PERF_REG_X86_YMMH11),
+	SMPL_REG2_EXT(YMMH12, PERF_REG_X86_YMMH12),
+	SMPL_REG2_EXT(YMMH13, PERF_REG_X86_YMMH13),
+	SMPL_REG2_EXT(YMMH14, PERF_REG_X86_YMMH14),
+	SMPL_REG2_EXT(YMMH15, PERF_REG_X86_YMMH15),
+
+	SMPL_REG4_EXT(ZMMH0, PERF_REG_X86_ZMMH0),
+	SMPL_REG4_EXT(ZMMH1, PERF_REG_X86_ZMMH1),
+	SMPL_REG4_EXT(ZMMH2, PERF_REG_X86_ZMMH2),
+	SMPL_REG4_EXT(ZMMH3, PERF_REG_X86_ZMMH3),
+	SMPL_REG4_EXT(ZMMH4, PERF_REG_X86_ZMMH4),
+	SMPL_REG4_EXT(ZMMH5, PERF_REG_X86_ZMMH5),
+	SMPL_REG4_EXT(ZMMH6, PERF_REG_X86_ZMMH6),
+	SMPL_REG4_EXT(ZMMH7, PERF_REG_X86_ZMMH7),
+	SMPL_REG4_EXT(ZMMH8, PERF_REG_X86_ZMMH8),
+	SMPL_REG4_EXT(ZMMH9, PERF_REG_X86_ZMMH9),
+	SMPL_REG4_EXT(ZMMH10, PERF_REG_X86_ZMMH10),
+	SMPL_REG4_EXT(ZMMH11, PERF_REG_X86_ZMMH11),
+	SMPL_REG4_EXT(ZMMH12, PERF_REG_X86_ZMMH12),
+	SMPL_REG4_EXT(ZMMH13, PERF_REG_X86_ZMMH13),
+	SMPL_REG4_EXT(ZMMH14, PERF_REG_X86_ZMMH14),
+	SMPL_REG4_EXT(ZMMH15, PERF_REG_X86_ZMMH15),
+
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
 
@@ -283,6 +344,32 @@ const struct sample_reg *arch__sample_reg_masks(void)
 	return sample_reg_masks;
 }
 
+static void check_intr_reg_ext_mask(struct perf_event_attr *attr, int idx,
+				    u64 fmask, unsigned long *mask)
+{
+	u64 src_mask[PERF_SAMPLE_ARRAY_SIZE] = { 0 };
+	int fd;
+
+	attr->sample_regs_intr = 0;
+	attr->sample_regs_intr_ext[idx] = fmask;
+	src_mask[idx + 1] = fmask;
+
+	fd = sys_perf_event_open(attr, 0, -1, -1, 0);
+	if (fd != -1) {
+		close(fd);
+		bitmap_or(mask, mask, (unsigned long *)src_mask,
+			  PERF_SAMPLE_REGS_NUM);
+	}
+}
+
+#define PERF_REG_EXTENDED_YMMH_MASK	GENMASK_ULL(31, 0)
+#define PERF_REG_EXTENDED_ZMMH_1ST_MASK	GENMASK_ULL(63, 32)
+#define PERF_REG_EXTENDED_ZMMH_2ND_MASK	GENMASK_ULL(31, 0)
+#define PERF_REG_EXTENDED_ZMM_1ST_MASK	GENMASK_ULL(63, 32)
+#define PERF_REG_EXTENDED_ZMM_2ND_MASK	GENMASK_ULL(63, 0)
+#define PERF_REG_EXTENDED_ZMM_3RD_MASK	GENMASK_ULL(31, 0)
+#define PERF_REG_EXTENDED_OPMASK_MASK	GENMASK_ULL(39, 32)
+
 void arch__intr_reg_mask(unsigned long *mask)
 {
 	struct perf_event_attr attr = {
@@ -325,6 +412,18 @@ void arch__intr_reg_mask(unsigned long *mask)
 		close(fd);
 		*(u64 *)mask = PERF_REG_EXTENDED_MASK | PERF_REGS_MASK;
 	}
+
+	/* Check YMMH regs */
+	check_intr_reg_ext_mask(&attr, 0, PERF_REG_EXTENDED_YMMH_MASK, mask);
+	/* Check ZMMLH0-15 regs */
+	check_intr_reg_ext_mask(&attr, 0, PERF_REG_EXTENDED_ZMMH_1ST_MASK, mask);
+	check_intr_reg_ext_mask(&attr, 1, PERF_REG_EXTENDED_ZMMH_2ND_MASK, mask);
+	/* Check ZMM16-31 regs */
+	check_intr_reg_ext_mask(&attr, 1, PERF_REG_EXTENDED_ZMM_1ST_MASK, mask);
+	check_intr_reg_ext_mask(&attr, 2, PERF_REG_EXTENDED_ZMM_2ND_MASK, mask);
+	check_intr_reg_ext_mask(&attr, 3, PERF_REG_EXTENDED_ZMM_3RD_MASK, mask);
+	/* Check OPMASK regs */
+	check_intr_reg_ext_mask(&attr, 3, PERF_REG_EXTENDED_OPMASK_MASK, mask);
 }
 
 void arch__user_reg_mask(unsigned long *mask)
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_x86.c b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
index 9a909f02bc04..c926046ebddc 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_x86.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
@@ -78,6 +78,94 @@ const char *__perf_reg_name_x86(int id)
 	XMM(14)
 	XMM(15)
 #undef XMM
+
+#define YMMH(x)					\
+	case PERF_REG_X86_YMMH ## x:		\
+	case PERF_REG_X86_YMMH ## x + 1:	\
+		return "YMMH" #x;
+	YMMH(0)
+	YMMH(1)
+	YMMH(2)
+	YMMH(3)
+	YMMH(4)
+	YMMH(5)
+	YMMH(6)
+	YMMH(7)
+	YMMH(8)
+	YMMH(9)
+	YMMH(10)
+	YMMH(11)
+	YMMH(12)
+	YMMH(13)
+	YMMH(14)
+	YMMH(15)
+#undef YMMH
+
+#define ZMMH(x)					\
+	case PERF_REG_X86_ZMMH ## x:		\
+	case PERF_REG_X86_ZMMH ## x + 1:	\
+	case PERF_REG_X86_ZMMH ## x + 2:	\
+	case PERF_REG_X86_ZMMH ## x + 3:	\
+		return "ZMMLH" #x;
+	ZMMH(0)
+	ZMMH(1)
+	ZMMH(2)
+	ZMMH(3)
+	ZMMH(4)
+	ZMMH(5)
+	ZMMH(6)
+	ZMMH(7)
+	ZMMH(8)
+	ZMMH(9)
+	ZMMH(10)
+	ZMMH(11)
+	ZMMH(12)
+	ZMMH(13)
+	ZMMH(14)
+	ZMMH(15)
+#undef ZMMH
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

