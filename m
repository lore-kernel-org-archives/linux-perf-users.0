Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B321CAA8C;
	Thu, 23 Jan 2025 06:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737613224; cv=none; b=NWu/R6TzbHdpbNpuLvZvMdg9MBHfMu+EuU8M2CXPL17rO2gp38wvNzCV9Gr34qihfwYOxzDuudql3wZ3cllNLBY+CVPh7UMQjZRevQGDuSrIS44qFRkxCQi9Wp+WgvRyIRKb6B4QBr4JUVq4nViPLZgTPyi4qZszY24Sy3xGw4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737613224; c=relaxed/simple;
	bh=l3wSYEAfl5v5b3KMp8mM+Z1KMLhUKde2syJ/vc4aPBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j5XTvjRcWjbummIp1dNCvdD7SlSWwa9VLCvnbBI5PCUNGXsdowouOwsOriBfBKsP0HtuYnJJ9VkK7QebgOj+6/A7hmc1g/Pdi3Qnx7b3S4xqTOdKtgvieUEE8eYk9PWOE7s1B3paxe5FsAuiHI7ojq1CQGt5MXfUQ2acIl/ywVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gZG4I5pL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gZG4I5pL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737613223; x=1769149223;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l3wSYEAfl5v5b3KMp8mM+Z1KMLhUKde2syJ/vc4aPBA=;
  b=gZG4I5pLkJterb3r7YvjG/8S2GAJzNIaRTqyhj2+oQgCP94tn7WZ1IfY
   /f9KmmVqpXxz/CCOowwSmHZW9pVcPxoACMVijFjlXyAomj+Q91tMdTNFV
   dNupdvQ2JCdxo9Gi0wcbEflOLD91yQDknWEDAa/Jq6iR2qmFMyPlCsaGW
   vQAk5322/YPdCuFBdX8A6TlQgdLmT2l9kYKmbI1sDRCoCEIcjZwOsrBUP
   yTLKbYW189vqCYODNeNBe5mdA80MtP9FhG7eCD0NXVr1J9P1dLoCE3FuB
   p+FJT/31VCGOIXA/kgnQw297ZPlU6qfmiRvhnIzdaKcODQiuPEbIvPTfO
   g==;
X-CSE-ConnectionGUID: SZKwARG+SvSpmR0fLsOTqw==
X-CSE-MsgGUID: su0Ni2MLQvSqNfDVTWCM4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="55513059"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="55513059"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 22:20:23 -0800
X-CSE-ConnectionGUID: ZCTNdLOaRAOPKgRIXCftkg==
X-CSE-MsgGUID: /pI8FQQpSlG9KcA7z5YSkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="112334468"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa003.jf.intel.com with ESMTP; 22 Jan 2025 22:20:19 -0800
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
Subject: [PATCH 04/20] perf/x86/intel: Decouple BTS initialization from PEBS initialization
Date: Thu, 23 Jan 2025 14:07:05 +0000
Message-Id: <20250123140721.2496639-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
References: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
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
index 8f78b0c900ef..a205d1fb37b1 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -584,7 +584,11 @@ static void bts_event_read(struct perf_event *event)
 
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
index d29e7ada96aa..91afba51038f 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6593,7 +6593,7 @@ __init int intel_pmu_init(void)
 	if (boot_cpu_has(X86_FEATURE_ARCH_LBR))
 		intel_pmu_arch_lbr_init();
 
-	intel_ds_init();
+	intel_pebs_init();
 
 	x86_add_quirk(intel_arch_events_quirk); /* Install first, so it runs last */
 
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 13a78a8a2780..86fa6d8c45cf 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2650,10 +2650,10 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
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
@@ -2661,7 +2661,6 @@ void __init intel_ds_init(void)
 	if (!boot_cpu_has(X86_FEATURE_DTES64))
 		return;
 
-	x86_pmu.bts  = boot_cpu_has(X86_FEATURE_BTS);
 	x86_pmu.pebs = boot_cpu_has(X86_FEATURE_PEBS);
 	x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
 	if (x86_pmu.version <= 4)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index a698e6484b3b..e15c2d0dbb27 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1661,7 +1661,7 @@ void intel_pmu_drain_pebs_buffer(void);
 
 void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr);
 
-void intel_ds_init(void);
+void intel_pebs_init(void);
 
 void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
 				struct cpu_hw_events *cpuc,
-- 
2.40.1

