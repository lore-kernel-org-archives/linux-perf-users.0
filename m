Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAF222FACA;
	Tue, 18 Feb 2025 08:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866442; cv=none; b=X1/PiR2Ma8mvP+IwYixbmza419CmBsJFkiPsJU2WY3PxrzRHrOvf//gRrVbR+pmQvoB3lZFtFAxVHODp5yITnQ/TZNGUVdb5TilyeQi9X+TmM/onCvHKngBXSLerPtXYwTPT7SDkdoGicm4vq6eb1PwkbdSPCeMnfzLMWqT+jes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866442; c=relaxed/simple;
	bh=OsqfMzB6SnzYJb3UaV6ZANkvNLCP9GGHqPTwOfzC0Yo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KZFjp/UcdLZRUJJZKU0xy1ysPf9MoTQTTjwWTSwOSUgIzkSKkLP6xXYYSxxym7Hw1xkRl2kNriJ4Q+pEFegaKDVcvTKXzaN6098EFbm9KxY3zGSJZyeXqN6ozUsnevBg5NcGIFg1M9IwrkKF2VvQ1LRrT0TnOjhSStCvo7c48fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iF6OqvqT; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iF6OqvqT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739866442; x=1771402442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OsqfMzB6SnzYJb3UaV6ZANkvNLCP9GGHqPTwOfzC0Yo=;
  b=iF6OqvqTIXAso7EhUIM1nOEHP4s4FBxMExW6ypT1aQri4f6u9nR3Vv2p
   W9YPlvBFNIZW2B98dAVX3lC2mBn96wo5JQIJL0ikoKZApJ4x3+3iUQPJr
   V6qFjaOb5PRX35YB8rfGoUBXGFzeEat0+pJuM6NpSA8KzujUcVk/+9n6a
   L4IqowHe8+BdgEgVRsi7lIirMFGwIAB2FYT/RlfWtxIIog+37bhmVuBKR
   7MaCaSzlbsVg2Ao0MLiEUhGBoCRJM64prmFipZlPxk2w7MVU/pV7GVScE
   OWObVNwjygOCNX17ywaQud2M/RTEN/tnQ9ZoDD2JUx371nBOli9QklttV
   w==;
X-CSE-ConnectionGUID: N1F5OynGSyu21ZEiSTAF7g==
X-CSE-MsgGUID: +cqI4rnZT4WtiJSC/CNdiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44200752"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="44200752"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 00:14:02 -0800
X-CSE-ConnectionGUID: /+k8ENEdTbCgcCT8NpHR/A==
X-CSE-MsgGUID: ctYy0XUTRvOfltwsNx0Pnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="145166139"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa002.jf.intel.com with ESMTP; 18 Feb 2025 00:13:57 -0800
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
Subject: [Patch v2 05/24] perf/x86/intel: Decouple BTS initialization from PEBS initialization
Date: Tue, 18 Feb 2025 15:27:59 +0000
Message-Id: <20250218152818.158614-6-dapeng1.mi@linux.intel.com>
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
index e1383a905cdc..a977d4d631fe 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6588,7 +6588,7 @@ __init int intel_pmu_init(void)
 	if (boot_cpu_has(X86_FEATURE_ARCH_LBR))
 		intel_pmu_arch_lbr_init();
 
-	intel_ds_init();
+	intel_pebs_init();
 
 	x86_add_quirk(intel_arch_events_quirk); /* Install first, so it runs last */
 
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 46aaaeae0c8d..9c8947d3413f 100644
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
index f4693409e191..0a259c98056a 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1662,7 +1662,7 @@ void intel_pmu_drain_pebs_buffer(void);
 
 void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr);
 
-void intel_ds_init(void);
+void intel_pebs_init(void);
 
 void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
 				struct cpu_hw_events *cpuc,
-- 
2.40.1

