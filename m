Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543B12C21D5;
	Wed, 20 Aug 2025 02:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755657102; cv=none; b=JqRKp0F4vH6j4f9IpBRDHHI4dDnrx3k92PdMv6o23niYZHZwHiuPTUh1I9HnPCOydcNkb3XYebI18gN5Pf1p7M4Go43jRhQddkeJjYl6THuN56cD5vvE3XIoMzSmEHwrLLaMkjhp5L74PEscPAmgjoPZfhpJXk+1FsWT5veWQLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755657102; c=relaxed/simple;
	bh=5m7lzcS6gu+y0Bo5aETzPDutUva1kZsFwLjFSHd0FfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eRddKmvnq2fI0I4ENIJsdH8Osl2PWSvvsr9Ucip5KtECAkMULGwiXL/UgGxrlxZN89RT6PvuF/SGUuAxtOd/z4Jt08Pk1KTkuX5WSqxsFBrZhtjmJfIaV6XJ7qA4ADySlCBrojcGIi+LK3ANJYz3MtVOTJEW5f+o9B5KQusNSDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gdq9b248; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gdq9b248"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755657102; x=1787193102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5m7lzcS6gu+y0Bo5aETzPDutUva1kZsFwLjFSHd0FfQ=;
  b=gdq9b248hIuPDyhidDz9OkC2DHOf2kc/0JR4li1wwDJBQS8h/riAHVC6
   MkBCRX98/QD2rbW7LAjRAm/hms8MmP19mFvEzgN9MyUrv4fV2dYfgC5TL
   IK2ZKB7HQxRlkT1QnLKHyYvv5KIemDVwAojVLgVADlQNhFJ8EksrbBVqf
   t2+xrGNpSKWhQfRrVLxFNSSRSBf2fhYH+sTufhbmrJ/Lhnw8EzYDH0rLl
   uV6jtayGw3+LFD43OAwrwoGtqvym5JDXuUfeUYP8eTgEcfFo28KJFid3n
   Hmw/k4pnz8D0OfR8ZPSAVYANr7kLgSej9+eSPAsx9p/fkWFLScXZnlNWd
   g==;
X-CSE-ConnectionGUID: PbUtkIwOSO2pie7/xmpB5A==
X-CSE-MsgGUID: wKos/Jc5SnO7PZqoajNxEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57625448"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57625448"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 19:31:41 -0700
X-CSE-ConnectionGUID: ULOt2AbzScCndAWH5Bnn/Q==
X-CSE-MsgGUID: dDqQBeLtRcaGdFfFugZn/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="167629016"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 19 Aug 2025 19:31:38 -0700
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	kernel test robot <oliver.sang@intel.com>
Subject: [Patch v3 3/7] perf/x86: Check if cpuc->events[*] pointer exists before accessing it
Date: Wed, 20 Aug 2025 10:30:28 +0800
Message-Id: <20250820023032.17128-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820023032.17128-1-dapeng1.mi@linux.intel.com>
References: <20250820023032.17128-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When intel_pmu_drain_pebs_icl() is called to drain PEBS records, the
perf_event_overflow() could be called to process the last PEBS record.

While perf_event_overflow() could trigger the interrupt throttle and
stop all events of the group, like what the below call-chain shows.

perf_event_overflow()
  -> __perf_event_overflow()
    ->__perf_event_account_interrupt()
      -> perf_event_throttle_group()
        -> perf_event_throttle()
          -> event->pmu->stop()
            -> x86_pmu_stop()

The side effect of stopping the events is that all corresponding event
pointers in cpuc->events[] array are cleared to NULL.

Assume there are two PEBS events (event a and event b) in a group. When
intel_pmu_drain_pebs_icl() calls perf_event_overflow() to process the
last PEBS record of PEBS event a, interrupt throttle is triggered and
all pointers of event a and event b are cleared to NULL. Then
intel_pmu_drain_pebs_icl() tries to process the last PEBS record of
event b and encounters NULL pointer access.

Since the left PEBS records have been processed when stopping the event,
check and skip to process the last PEBS record if cpuc->events[*] is
NULL.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202507042103.a15d2923-lkp@intel.com
Fixes: 9734e25fbf5a ("perf: Fix the throttle logic for a group")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: kernel test robot <oliver.sang@intel.com>
---
 arch/x86/events/intel/ds.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index c0b7ac1c7594..dcf29c099ad2 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2663,6 +2663,16 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 			continue;
 
 		event = cpuc->events[bit];
+		/*
+		 * perf_event_overflow() called by below __intel_pmu_pebs_last_event()
+		 * could trigger interrupt throttle and clear all event pointers of the
+		 * group in cpuc->events[] to NULL. So need to re-check if cpuc->events[*]
+		 * is NULL, if so it indicates the event has been throttled (stopped) and
+		 * the corresponding last PEBS records have been processed in stopping
+		 * event, don't need to process it again.
+		 */
+		if (!event)
+			continue;
 
 		__intel_pmu_pebs_last_event(event, iregs, regs, data, last[bit],
 					    counts[bit], setup_pebs_adaptive_sample_data);
-- 
2.34.1

