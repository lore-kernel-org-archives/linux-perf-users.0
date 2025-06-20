Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EC2233145;
	Fri, 20 Jun 2025 07:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750404592; cv=none; b=III9K3g/H9E19rmfCu+N883F9zL6peP6BQdCtSF5E9LE0c1mBL6A/7UKOdzpEqrIRALqUSfiL0HEu8hsGZMknX7yb24KJwE/BPxtqgFlhe5jsTW6VwHe3eWRgx8p/TCDM+7Kchp+ki7b+J7hUMnRgaRhrspW+OwmvwfqCr1V7m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750404592; c=relaxed/simple;
	bh=OxQb5cqVBGmoOgOx4NgdvWTB16JH2MCnPNbtL5ULKzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b3v8ZH7bzMCU6Yek2E08tHtNII0VlYfZSA4UIRdTKAfHRVlA2d6rnvFrM2wb5/l1/QRcrYQRpPsj5jJn6NcNM2rYjDI9Bj9tpwIV3aoVhTxTghPh2/BFVsrj4XXfDVOWvk7kaotz/OphSdqcHQU2J3E5FQtxWo560SZEO6khBRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YyyWQ3Xd; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YyyWQ3Xd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750404591; x=1781940591;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OxQb5cqVBGmoOgOx4NgdvWTB16JH2MCnPNbtL5ULKzY=;
  b=YyyWQ3XdU00u5AB3lKhd58z0qPMNu0lxah8c4gyc8LsLBqq4tf6yvOf+
   i/5kE7D40l0ERxF4G3zYn3g86oAL09L4Ft7dX7QDVJoncsAUZn6Pkgyma
   XDFRW5RkAcwsCan1QR/sUbuCrKG5lYmlX+Oo9n6vH+pJM0VSSIgvc9PPl
   ZybpNl8mMq/aAU9NGJ2W5OLPF9BkhHaXSGgKM2/t7u7Qka7u8wTY8Lg8t
   vGKPefWhkEOC4nCZndgM+armj1nvUKZ8c8Go+SuKkALigQrilb6Xd8hT+
   Y1SoWEwX5lRvnN7AZP8lRc5GR5kF8XG0SEjbiA+8Lt2961DVMGN4cFtWf
   g==;
X-CSE-ConnectionGUID: m94W+FBPR2Kx7mRUK0JHKg==
X-CSE-MsgGUID: DfKrQ78nREaZvaq56tpPsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="51887838"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="51887838"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 00:29:51 -0700
X-CSE-ConnectionGUID: /m1GCKcPT6GgPwuZ2Pd+sA==
X-CSE-MsgGUID: wICYpzmWQvqw90NXjdE1cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="156651084"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa005.jf.intel.com with ESMTP; 20 Jun 2025 00:29:47 -0700
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
Subject: [Patch v4 12/13] perf/x86/intel: Support to sample SSP register for arch-PEBS
Date: Fri, 20 Jun 2025 10:39:08 +0000
Message-ID: <20250620103909.1586595-13-dapeng1.mi@linux.intel.com>
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

Arch-PEBS supports to sample shadow stack pointer (SSP) register in GPR
group. This patch supports to sample SSP register for arch-PEBS. Please
notice this patch only enables PEBS based SSP sampling, the PMI based
SSP sampling would be supported in a separated patch.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c       | 16 ++++++++++++++++
 arch/x86/events/intel/core.c |  5 +++--
 arch/x86/events/intel/ds.c   |  7 +++++--
 arch/x86/events/perf_event.h |  2 ++
 4 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index f30c423e4bd2..6435f6686c04 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -666,6 +666,22 @@ int x86_pmu_hw_config(struct perf_event *event)
 			return -EINVAL;
 	}
 
+	/*
+	 * sample_regs_user doesn't support SSP register now, it would be
+	 * supported later.
+	 */
+	if (event->attr.sample_regs_user & BIT_ULL(PERF_REG_X86_SSP))
+		return -EINVAL;
+
+	if (event->attr.sample_regs_intr & BIT_ULL(PERF_REG_X86_SSP)) {
+		/*
+		 * sample_regs_intr doesn't support SSP register for
+		 * non-PEBS events now. it would be supported later.
+		 */
+		if (!event->attr.precise_ip || !x86_pmu.arch_pebs)
+			return -EINVAL;
+	}
+
 	return x86_setup_perfctr(event);
 }
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index b37e09ce3f0c..3013e9bce330 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4152,14 +4152,15 @@ static void intel_pebs_aliases_skl(struct perf_event *event)
 static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
 {
 	unsigned long flags = x86_pmu.large_pebs_flags;
+	u64 gprs_mask = x86_pmu.arch_pebs ? PEBS_GP_EXT_REGS : PEBS_GP_REGS;
 
 	if (event->attr.use_clockid)
 		flags &= ~PERF_SAMPLE_TIME;
 	if (!event->attr.exclude_kernel)
 		flags &= ~PERF_SAMPLE_REGS_USER;
-	if (event->attr.sample_regs_user & ~PEBS_GP_REGS)
+	if (event->attr.sample_regs_user & ~gprs_mask)
 		flags &= ~PERF_SAMPLE_REGS_USER;
-	if (event->attr.sample_regs_intr & ~PEBS_GP_REGS)
+	if (event->attr.sample_regs_intr & ~gprs_mask)
 		flags &= ~PERF_SAMPLE_REGS_INTR;
 	return flags;
 }
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index d3a614ed7d60..7f790602f554 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1436,6 +1436,7 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 	u64 sample_type = attr->sample_type;
 	u64 pebs_data_cfg = 0;
 	bool gprs, tsx_weight;
+	u64 gprs_mask;
 
 	if (!(sample_type & ~(PERF_SAMPLE_IP|PERF_SAMPLE_TIME)) &&
 	    attr->precise_ip > 1)
@@ -1450,10 +1451,11 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 	 * + precise_ip < 2 for the non event IP
 	 * + For RTM TSX weight we need GPRs for the abort code.
 	 */
+	gprs_mask = x86_pmu.arch_pebs ? PEBS_GP_EXT_REGS : PEBS_GP_REGS;
 	gprs = ((sample_type & PERF_SAMPLE_REGS_INTR) &&
-		(attr->sample_regs_intr & PEBS_GP_REGS)) ||
+		(attr->sample_regs_intr & gprs_mask)) ||
 	       ((sample_type & PERF_SAMPLE_REGS_USER) &&
-		(attr->sample_regs_user & PEBS_GP_REGS));
+		(attr->sample_regs_user & gprs_mask));
 
 	tsx_weight = (sample_type & PERF_SAMPLE_WEIGHT_TYPE) &&
 		     ((attr->config & INTEL_ARCH_EVENT_MASK) ==
@@ -2399,6 +2401,7 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 
 		__setup_pebs_gpr_group(event, regs, (struct pebs_gprs *)gprs,
 				       sample_type);
+		perf_regs->ssp = gprs->ssp;
 	}
 
 	if (header->aux) {
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index db4ec2975de4..bede9dd2720c 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -183,6 +183,8 @@ struct amd_nb {
 	 (1ULL << PERF_REG_X86_R14)   | \
 	 (1ULL << PERF_REG_X86_R15))
 
+#define PEBS_GP_EXT_REGS	(PEBS_GP_REGS | BIT_ULL(PERF_REG_X86_SSP))
+
 /*
  * Per register state.
  */
-- 
2.43.0

