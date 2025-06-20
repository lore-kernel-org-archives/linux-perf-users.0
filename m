Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E83229B29;
	Fri, 20 Jun 2025 07:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750404589; cv=none; b=JHrhLemvRRlvyZghItN2aXkO0xnGRD2VRwgJLW3Lygettq6Yt3CzXnc1jiUZCIFxDjL+Xv+5SeN+7uIGr4YbL+AMVITocunKsT2OsThH9XZCK4SsvX6C207Lf2rQTC3SA1OJ2Yjh7zUJz0F96+qNnrtgt/ofeRG/RAgEAGCjJy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750404589; c=relaxed/simple;
	bh=mjbDHhK9PNHQzi179LUtROpOFo4bclzxUwddR9soylc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lOeTsw2jPMX9+QrXzDDTNM8XQzJOKTJXFH73m7K6TupuW4pNduG1kD5jztJ+XSD5NVcrkYV/nwRzF8KMVdXU+HCucbAhttOBVFGwqhbs8uhIes2hcCGOhX6ZcATRYQgM1fGR95/fb0tCFtO44iGxix+PWm7AzgtoJ6jc67K40g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S+V98E0O; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S+V98E0O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750404587; x=1781940587;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mjbDHhK9PNHQzi179LUtROpOFo4bclzxUwddR9soylc=;
  b=S+V98E0OhDu/5ckB/vgWNSHMaQ6BQa0rhwvMe6iEVRfNWQgsspzpuAha
   yvgO1ur4vnDepp6VBaOsdINvJsc1l6XnxWAq0C3wL920NcV9Vr8GnwFzF
   zInL7klZBGwxQNSUOVhnJ3ZAXsZXkwVBe0baTpNNlzUJFsPR46Xss0Jfk
   zjtl2woAjIf30B6pleBS7gDlbdZflwTruJt6vsQcQl3eOcedBZxnRDIcM
   xanNBGu0WhT9b0FOjqCNrDAHRBVlol7VENuMORkfMjckOHxCSowtKSfJp
   IkT+8SV+WhJbDvBFtRXcG6HhHqCTcJLyJWcls/lJh6k2DoA/qGQh0C/6F
   g==;
X-CSE-ConnectionGUID: pQILsC8HS4Gt/0sl7zymfQ==
X-CSE-MsgGUID: FtTjSZcyT1CPIe+krWN83Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="51887824"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="51887824"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 00:29:47 -0700
X-CSE-ConnectionGUID: OVnO1fogQQKxc8e30uoEAA==
X-CSE-MsgGUID: nHuOcBSoRNSc0PxL4hPIpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="156651074"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa005.jf.intel.com with ESMTP; 20 Jun 2025 00:29:44 -0700
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
Subject: [Patch v4 11/13] perf/x86: Support to sample SSP register
Date: Fri, 20 Jun 2025 10:39:07 +0000
Message-ID: <20250620103909.1586595-12-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250620103909.1586595-1-dapeng1.mi@linux.intel.com>
References: <20250620103909.1586595-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds basic support for sampling SSP register in perf/x86
common code. The x86/intel specific support would be added in next
patch.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/ds.c            | 2 ++
 arch/x86/include/asm/perf_event.h     | 1 +
 arch/x86/include/uapi/asm/perf_regs.h | 4 +++-
 arch/x86/kernel/perf_regs.c           | 7 +++++++
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index e378f33206ed..d3a614ed7d60 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2244,6 +2244,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 		return;
 
 	perf_regs = container_of(regs, struct x86_perf_regs, regs);
+	perf_regs->ssp = 0;
 	perf_regs->xmm_regs = NULL;
 
 	format_group = basic->format_group;
@@ -2360,6 +2361,7 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 		return;
 
 	perf_regs = container_of(regs, struct x86_perf_regs, regs);
+	perf_regs->ssp = 0;
 	perf_regs->xmm_regs = NULL;
 
 	__setup_perf_sample_data(event, iregs, data);
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 380f89fd5dac..fcfb8fb6a7a5 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -700,6 +700,7 @@ extern void perf_events_lapic_init(void);
 struct pt_regs;
 struct x86_perf_regs {
 	struct pt_regs	regs;
+	u64		ssp;
 	u64		*xmm_regs;
 };
 
diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
index 7c9d2bb3833b..bf4cec52f808 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -27,9 +27,11 @@ enum perf_event_x86_regs {
 	PERF_REG_X86_R13,
 	PERF_REG_X86_R14,
 	PERF_REG_X86_R15,
+	/* shadow stack pointer (SSP) */
+	PERF_REG_X86_SSP,
 	/* These are the limits for the GPRs. */
 	PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
-	PERF_REG_X86_64_MAX = PERF_REG_X86_R15 + 1,
+	PERF_REG_X86_64_MAX = PERF_REG_X86_SSP + 1,
 
 	/* These all need two bits set because they are 128bit */
 	PERF_REG_X86_XMM0  = 32,
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index 624703af80a1..1cbb9c901a08 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -54,6 +54,8 @@ static unsigned int pt_regs_offset[PERF_REG_X86_MAX] = {
 	PT_REGS_OFFSET(PERF_REG_X86_R13, r13),
 	PT_REGS_OFFSET(PERF_REG_X86_R14, r14),
 	PT_REGS_OFFSET(PERF_REG_X86_R15, r15),
+	/* The pt_regs struct does not store shadow stack pointer. */
+	(unsigned int) -1,
 #endif
 };
 
@@ -68,6 +70,11 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 		return perf_regs->xmm_regs[idx - PERF_REG_X86_XMM0];
 	}
 
+	if (idx == PERF_REG_X86_SSP) {
+		perf_regs = container_of(regs, struct x86_perf_regs, regs);
+		return perf_regs->ssp;
+	}
+
 	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(pt_regs_offset)))
 		return 0;
 
-- 
2.43.0

