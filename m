Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1AC2918FF;
	Tue, 15 Apr 2025 08:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705468; cv=none; b=BPw/W2zONP9gVGDJlfvEhkNnumV8tHZ2ldzzIoVlneDuwCkNgoc+eh0HKr6OdQZ4qEudkTFGU0QCc2g7uX7I2GOZapTHiz47oVr9G8hfBcuwsLE6Tvrp1wZtdkrQT/f/8pY5wRUXxkz8irZViFIinVGLJLgY9AgVPGgW2rOnrWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705468; c=relaxed/simple;
	bh=bPDc33zIJ9fQccDYYs4KtadWDnQKLZnBRafs/XcOk78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cN48o2KrmOlXNFZ4qpRUl6M/o+/jwPfgnax/hbDJAH9s8ooqyTKwN6Yx8WySdmrSCzruum4UagvSOM/n4FypuAN7VnvxkhARqSXxmPmamOKW0GBQXgBCdAgFLmHjQW/tDLFe8xwJ5JWQFz6pk7w8PypqcNgI7A0pe4n5F60Zs84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EIhmrbF+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EIhmrbF+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744705467; x=1776241467;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bPDc33zIJ9fQccDYYs4KtadWDnQKLZnBRafs/XcOk78=;
  b=EIhmrbF+4knuoJqIllxf6B6p/GdeokPoX+bnwUZtYZidMWjPBZBukix0
   wQe1/X+qmmXDaEVYvPbmkP3DreZpN/uxavc15TG3XPQwgPS4rxBpjy6/D
   mjhe1pUPBwze55463FEFnerG7rwDvAn8drgp22xaapOgHyidERlyr96ZP
   ngHHujImolY+vdYLsqaARZ6mypAPsr2ZEGvsop4IqBuxYC4bU+E2Lx6dt
   DsN2bZd8gtnFfK5ogGdiU+02b8iZPiZyIzJdV3c+JNbELWX86wz2SmZZF
   UCAt+U5FAaDlqClgam5vXVBnJo7DaSddQuoHL9ydjxJ3JpMYrrzehkPf3
   Q==;
X-CSE-ConnectionGUID: LVhKzDyaQNyFL1imNFdGVw==
X-CSE-MsgGUID: lYCrvcOsT5qgW8ZwL+ke5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="46115872"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="46115872"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 01:23:24 -0700
X-CSE-ConnectionGUID: V1IvFp3vRTCfTZjujdaLPw==
X-CSE-MsgGUID: ml/YpkG2S7Ki/u5jzT6oLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130055479"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa007.fm.intel.com with ESMTP; 15 Apr 2025 01:23:20 -0700
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
Subject: [Patch v3 04/22] perf/x86/intel: Decouple BTS initialization from PEBS initialization
Date: Tue, 15 Apr 2025 11:44:10 +0000
Message-Id: <20250415114428.341182-5-dapeng1.mi@linux.intel.com>
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

Move x86_pmu.bts flag initialization into bts_init() from
intel_ds_init() and rename intel_ds_init() to intel_pebs_init() since it
fully initializes PEBS now after removing the x86_pmu.bts
initialization.

It's safe to move x86_pmu.bts into bts_init() since all x86_pmu.bts flag
are called after bts_init() execution.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/bts.c  | 6 +++++-
 arch/x86/events/intel/core.c | 2 +-
 arch/x86/events/intel/ds.c   | 5 ++---
 arch/x86/events/perf_event.h | 2 +-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 16bc89c8023b..9560f693fac0 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -599,7 +599,11 @@ static void bts_event_read(struct perf_event *event)
 
 static __init int bts_init(void)
 {
-	if (!boot_cpu_has(X86_FEATURE_DTES64) || !x86_pmu.bts)
+	if (!boot_cpu_has(X86_FEATURE_DTES64))
+		return -ENODEV;
+
+	x86_pmu.bts = boot_cpu_has(X86_FEATURE_BTS);
+	if (!x86_pmu.bts)
 		return -ENODEV;
 
 	if (boot_cpu_has(X86_FEATURE_PTI)) {
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c7937b872348..16049ba63135 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6928,7 +6928,7 @@ __init int intel_pmu_init(void)
 	if (boot_cpu_has(X86_FEATURE_ARCH_LBR))
 		intel_pmu_arch_lbr_init();
 
-	intel_ds_init();
+	intel_pebs_init();
 
 	x86_add_quirk(intel_arch_events_quirk); /* Install first, so it runs last */
 
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index fcf9c5b26cab..d894cf3f631e 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2651,10 +2651,10 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 }
 
 /*
- * BTS, PEBS probe and setup
+ * PEBS probe and setup
  */
 
-void __init intel_ds_init(void)
+void __init intel_pebs_init(void)
 {
 	/*
 	 * No support for 32bit formats
@@ -2662,7 +2662,6 @@ void __init intel_ds_init(void)
 	if (!boot_cpu_has(X86_FEATURE_DTES64))
 		return;
 
-	x86_pmu.bts  = boot_cpu_has(X86_FEATURE_BTS);
 	x86_pmu.pebs = boot_cpu_has(X86_FEATURE_PEBS);
 	x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
 	if (x86_pmu.version <= 4)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 46bbb503aca1..ac6743e392ad 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1673,7 +1673,7 @@ void intel_pmu_drain_pebs_buffer(void);
 
 void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr);
 
-void intel_ds_init(void);
+void intel_pebs_init(void);
 
 void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
 				struct cpu_hw_events *cpuc,
-- 
2.40.1

