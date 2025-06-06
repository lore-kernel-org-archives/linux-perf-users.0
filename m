Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B54C1E1A3B;
	Fri,  6 Jun 2025 06:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749191195; cv=none; b=Jd3qCeYLVdG9SS91aPyY1QZdFfctNQdFRhQvE+KnGI5t534wUXDi1wx/tMBUCXx7jSsIW/YcPxjQltVbHDQuDDx0xp9vRGZpIzIWWUlya3bT+CvD4CnmE3f+FYng/YS+1n8j9v4OytEPlPjtmKKA2W2CmhkDqKZWSBilXMWltWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749191195; c=relaxed/simple;
	bh=JU0mgop2few5Pt6Dq9+ZtVDzm94WKdjmkUHwV6dtdYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wyt4KHjv2z/x3+fO5F/aojsvC6qVgADsYDmqmxVHYGoPfN3yyh/GmZo75wLZAZj+K6KAyF1QUZoWrTLXG5EG/1s+Gj0AX64Q/QaFYS1S5YVt9z2qEvg5fpW7ubn6ILEjcPuyRLpXEeLB/UyVeXxZJf0tdi4oefDpxaMDV+1OOQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e8sxWCEU; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e8sxWCEU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749191193; x=1780727193;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JU0mgop2few5Pt6Dq9+ZtVDzm94WKdjmkUHwV6dtdYI=;
  b=e8sxWCEUFW5lT5rslrmUtGH7KrVkCmV6KEWiJTBiD1vPA4dJtUoQGdnv
   bQkMx2QMJMhoMaEiq/dO9CRvTrC1V6SjM+U5XeicGRYHUaVd0Q0TuOL7E
   2DXpltiUZtoHU+KsAw5iif+bjP7fPOlw92BbTZxJ+DH0zQtd0CyDZl1yh
   UKWjvLQFNFBBtXmf+Vd/4gH4YcP+3O/jkhPxrTRqViLCh1MJCJXaU30Iu
   hESO9CzXGF/8VWnkWOflGaRTH//kyAh2V/GS154gNTzo4mqo9z6UHNmes
   J4qZ6t75t88FpefCzLaUSuSEGGJrpovb02/exwTXW8i7EBF3fROty3ehx
   A==;
X-CSE-ConnectionGUID: l6WLGGuXQuKqUstgml7oFQ==
X-CSE-MsgGUID: AVvvcZ+fR2ujsKDsHilqyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="73864453"
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; 
   d="scan'208";a="73864453"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 23:26:33 -0700
X-CSE-ConnectionGUID: E8/CkPXtQm+K4/yvZjVXYQ==
X-CSE-MsgGUID: s/578i+CRfmWvgroYersIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; 
   d="scan'208";a="150761251"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa004.jf.intel.com with ESMTP; 05 Jun 2025 23:26:28 -0700
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
	Andrew Zaborowski <andrew.zaborowski@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH] perf/x86/intel: Use early_initcall() to hook bts_init()
Date: Fri,  6 Jun 2025 11:16:06 +0000
Message-ID: <20250606111606.84350-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the commit 'd971342d38bf ("perf/x86/intel: Decouple BTS
 initialization from PEBS initialization")' is introduced, x86_pmu.bts
would initialized in bts_init() which is hooked by arch_initcall().

Whereas init_hw_perf_events() is hooked by early_initcall(). Once the
core PMU is initialized, nmi watchdog initialization is called
immediately before bts_init() is called. It leads to the BTS buffer is
not really initialized since bts_init() is not called and x86_pmu.bts is
still false at that time. Worse, BTS buffer would never be initialized
then unless all core PMU events are freed and reserve_ds_buffers()
is called again.

Thus aligning with init_hw_perf_events(), use early_initcall() to hook
bts_init() to ensure x86_pmu.bts is initialized before nmi watchdog
initialization.

Fixes: d971342d38bf ("perf/x86/intel: Decouple BTS initialization from PEBS initialization")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/bts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 9560f693fac0..f0d9729ed255 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -642,4 +642,4 @@ static __init int bts_init(void)
 
 	return perf_pmu_register(&bts_pmu, "intel_bts", -1);
 }
-arch_initcall(bts_init);
+early_initcall(bts_init);

base-commit: e7d952cc39fca34386ec9f15f68cb2eaac01b5ae
-- 
2.43.0

