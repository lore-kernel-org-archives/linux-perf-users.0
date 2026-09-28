Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4422D46D09E;
	Mon, 28 Sep 2026 07:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581856; cv=none; b=ZOPY4iw643Pf0Md/zWtTcNeFXwVrexPJiGIHWXMuuoT3p5ndoskRiFxfW3jiaGW8XecASRdoMX1hBAXNpe2qS8qvC8eMyUpSHSWa8G0iZL5D3gV0w9TI0r15BGNPg0M3juTLq8vQFnW40+tJ/bFPvRCMdvyIxCl+sbJNIigK+xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581856; c=relaxed/simple;
	bh=JJEmZOY4cRZXsX7TJixlhQSO3URfRA7iftw8zATk5hM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WlAivmo23EWO4bR/+MYqtnBMwdMjgTmQoqhGn3DfZ8eyghjPgWoO7a17/kOwcpLzzeHjWFtk7FQdQzzZ8D6bSUHuLvVMPzxRo0lEFjPcvJN5+Gsx58/fe9cQcDdLYrNejuleqsAHcB/TJeUZ+r0ETti8nTRlMdEm2se/JFaMmSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C+BJyhDr; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C+BJyhDr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790581855; x=1822117855;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JJEmZOY4cRZXsX7TJixlhQSO3URfRA7iftw8zATk5hM=;
  b=C+BJyhDr8oKBJGELaevCH70NPhRnlUX5cTDh4zt4mngni4ogplyj6aN8
   hM4jryeSl2zedwD9dnkNP4j/Mpt4uN9W4PtqOlY/Q7H+D2xz7vCLaVas0
   YsRuoEPc/5W8FxfNybAG6z0Ju88qAbrvggeC/cfjajFASGae4vTHgPW2o
   /Kod87ktsoXIYWRuHvzkcki6Nl63RLJD/sgpLYE1Odl2E3JTRJCC0NGpA
   q5PweG7C7C87euNDxwtaSDxRxeene6mL857eGyu1BdljNEKZA3opbIDlv
   k0ORU859gcMrM2fq3d9nyIQbTBEQXresZPBWCYUQ6mWnbZ2YPayyevvHG
   g==;
X-CSE-ConnectionGUID: iutgoKMMROSAMQihjGckyQ==
X-CSE-MsgGUID: f5vvYUEGQ/Sokv0n9clzLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90141415"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90141415"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 00:50:55 -0700
X-CSE-ConnectionGUID: Gzj9N2W2Rc2ZtYwu+VIq9A==
X-CSE-MsgGUID: RdKUXGX9QpSFTZHNAUQmnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="275024918"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 28 Sep 2026 00:50:51 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 06/15] perf/x86/intel: Limit PEBS counter iteration to valid array bounds
Date: Mon, 28 Sep 2026 15:43:00 +0800
Message-Id: <20260928074309.898043-7-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
References: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__intel_pmu_handle_{,last_}pebs_record() iterate counter indexes up to
X86_PMC_IDX_MAX (64), while counts[] and *last[] are sized only for
INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS (48) entries.

If pebs_status were ever to contain bits above the highest valid PEBS
counter index, the loop could access those arrays out of bounds.
Although that should not happen in practice, limit the iteration bound
to INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS to match the array
sizes and keep the code consistent.

Fixes: 8807d922705f ("perf/x86/intel/ds: Factor out PEBS record processing code to functions")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 0f24098587bf..f68391d60b2d 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -3239,7 +3239,8 @@ __intel_pmu_handle_pebs_record(struct pt_regs *iregs,
 	struct perf_event *event;
 	int bit;
 
-	for_each_set_bit(bit, (unsigned long *)&pebs_status, X86_PMC_IDX_MAX) {
+	for_each_set_bit(bit, (unsigned long *)&pebs_status,
+			 INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS) {
 		event = cpuc->events[bit];
 
 		if (WARN_ON_ONCE(!event) ||
@@ -3268,7 +3269,8 @@ __intel_pmu_handle_last_pebs_record(struct pt_regs *iregs,
 	bool handled = false;
 	int bit;
 
-	for_each_set_bit(bit, (unsigned long *)&mask, X86_PMC_IDX_MAX) {
+	for_each_set_bit(bit, (unsigned long *)&mask,
+			 INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS) {
 		if (!counts[bit])
 			continue;
 
-- 
2.34.1

