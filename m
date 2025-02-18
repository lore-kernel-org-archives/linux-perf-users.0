Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9760D236A74;
	Tue, 18 Feb 2025 08:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866482; cv=none; b=KIgpNMkF/m9DZBm2vQoKiBmdL88YhJPMLP4C9F58c3UCUe6gYsx54wbvyFkpODh7e5hA0F/vXHcsTi6uP4lZQN3rMOeRCRUrfLHSQzZ9RTjHVZ1BeK4Zd3eSgSzUqomZwP92ucI6eKtcNiAk//efIS6QzZvPFy/8ot/u9WEWvNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866482; c=relaxed/simple;
	bh=knkwEi6lhR6wiS2tX4hOQ9Oy79ANfK+P+XHo5lYHric=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cUvGPDXbgxEwfN9WxuhvIQhIZDV/v9jlp1jLPabkbmo1Gw8/E1v1q2QhgO67K0jK5M0c4ZlL9Pw7t8nAnQpGrI88g/qgiXwIfEhKXs7xU1ud5GSe1qpdvp6kZGK31r9G82lHWwELI3F8uj4ccEcHtaStN9XUjDmJFjNWyKmuT48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YYwRjTgw; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YYwRjTgw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739866482; x=1771402482;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=knkwEi6lhR6wiS2tX4hOQ9Oy79ANfK+P+XHo5lYHric=;
  b=YYwRjTgwAn91Rlw7Tat0pU792v8MUewaSfFC1tSEF3y358Ihz4A7DvE9
   z/RAwDBjVrWtKM7mrlNgTByPKEWrNTQNf55u3qvalgCBkuRLHV6YewDC5
   XURTMDRx4mZrvpiExiEyfnVRi2MPCIVfhB2FvUdATVN/aacWq4NFAp3d9
   YZttiCQJOCZxUctyNSeww/EZK9HJrA3KSLGn2Hi9a3xKtoa5aZcb1od3g
   H/hWacVRtjr5vwlZdnYlv+dzDZxbhDgKSQ8+CuVrQQxl8TixZHkzt8PkY
   acKxjxWfSxdHIoof9B9JDDX+gheI/782eX/B0z/DMAdUPFfS7CPgR2nGg
   A==;
X-CSE-ConnectionGUID: n81tjPwbRpygGB94r/0C5Q==
X-CSE-MsgGUID: 7AqAOcUxQnePx9Ay/awuAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44200828"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="44200828"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 00:14:41 -0800
X-CSE-ConnectionGUID: ZTIZeKFnQ3SCaFztJASp4w==
X-CSE-MsgGUID: Aofk2OV6REuGsv1f0lTyng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="145166280"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa002.jf.intel.com with ESMTP; 18 Feb 2025 00:14:37 -0800
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
Subject: [Patch v2 15/24] perf/x86/intel: Add SSP register support for arch-PEBS
Date: Tue, 18 Feb 2025 15:28:09 +0000
Message-Id: <20250218152818.158614-16-dapeng1.mi@linux.intel.com>
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

Arch-PEBS supports to capture SSP register in GPR group. This patch
supports to read and output this register. SSP is for shadow stacks.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c                | 10 ++++++++++
 arch/x86/events/intel/ds.c            |  3 +++
 arch/x86/include/asm/perf_event.h     |  1 +
 arch/x86/include/uapi/asm/perf_regs.h |  4 +++-
 arch/x86/kernel/perf_regs.c           |  5 +++++
 5 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 4eaafabf033e..d5609c0756c2 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -651,6 +651,16 @@ int x86_pmu_hw_config(struct perf_event *event)
 			return -EINVAL;
 	}
 
+	/* sample_regs_user never support SSP register. */
+	if (unlikely(event->attr.sample_regs_user & BIT_ULL(PERF_REG_X86_SSP)))
+		return -EINVAL;
+
+	if (unlikely(event->attr.sample_regs_intr & BIT_ULL(PERF_REG_X86_SSP))) {
+		/* Only arch-PEBS supports to capture SSP register. */
+		if (!x86_pmu.arch_pebs || !event->attr.precise_ip)
+			return -EINVAL;
+	}
+
 	/* sample_regs_user never support XMM registers */
 	if (unlikely(event->attr.sample_regs_user & PERF_REG_EXTENDED_MASK))
 		return -EINVAL;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 712f7dd05c1d..cad653706431 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2216,6 +2216,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 
 	perf_regs = container_of(regs, struct x86_perf_regs, regs);
 	perf_regs->xmm_regs = NULL;
+	perf_regs->ssp = 0;
 
 	format_group = basic->format_group;
 
@@ -2332,6 +2333,7 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 
 	perf_regs = container_of(regs, struct x86_perf_regs, regs);
 	perf_regs->xmm_regs = NULL;
+	perf_regs->ssp = 0;
 
 	__setup_perf_sample_data(event, iregs, data);
 
@@ -2368,6 +2370,7 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 
 		__setup_pebs_gpr_group(event, regs, (struct pebs_gprs *)gprs,
 				       sample_type);
+		perf_regs->ssp = gprs->ssp;
 	}
 
 	if (header->aux) {
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 4103cc745e86..d5285bb4b333 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -692,6 +692,7 @@ extern void perf_events_lapic_init(void);
 struct pt_regs;
 struct x86_perf_regs {
 	struct pt_regs	regs;
+	u64		ssp;
 	u64		*xmm_regs;
 };
 
diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
index 7c9d2bb3833b..9ee9e55aed09 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -27,9 +27,11 @@ enum perf_event_x86_regs {
 	PERF_REG_X86_R13,
 	PERF_REG_X86_R14,
 	PERF_REG_X86_R15,
+	/* Shadow stack pointer (SSP) present on Clearwater Forest and newer models. */
+	PERF_REG_X86_SSP,
 	/* These are the limits for the GPRs. */
 	PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
-	PERF_REG_X86_64_MAX = PERF_REG_X86_R15 + 1,
+	PERF_REG_X86_64_MAX = PERF_REG_X86_SSP + 1,
 
 	/* These all need two bits set because they are 128bit */
 	PERF_REG_X86_XMM0  = 32,
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index 624703af80a1..4b15c7488ec1 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -54,6 +54,8 @@ static unsigned int pt_regs_offset[PERF_REG_X86_MAX] = {
 	PT_REGS_OFFSET(PERF_REG_X86_R13, r13),
 	PT_REGS_OFFSET(PERF_REG_X86_R14, r14),
 	PT_REGS_OFFSET(PERF_REG_X86_R15, r15),
+	/* The pt_regs struct does not store Shadow stack pointer. */
+	(unsigned int) -1,
 #endif
 };
 
@@ -68,6 +70,9 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 		return perf_regs->xmm_regs[idx - PERF_REG_X86_XMM0];
 	}
 
+	if (idx == PERF_REG_X86_SSP)
+		return perf_regs->ssp;
+
 	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(pt_regs_offset)))
 		return 0;
 
-- 
2.40.1

