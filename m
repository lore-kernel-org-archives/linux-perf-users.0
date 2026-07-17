Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB97C3DEADB;
	Fri, 17 Jul 2026 08:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275799; cv=none; b=TunE9KVAOImrfh6HuzC31WY/gXCyfqlEtOnEXgeByFG0j1btfUuk2ivKNpQ4HTMX3tx37Tb/BIZt2cvgPm3xN4qKOLqL21PZjsXo4lQbGVHKIhMpxNn69vZLe5WCdgPwiUx09C5SlYWYWIyVBMk4+8zUOGGbyvUBlNFDPQcltTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275799; c=relaxed/simple;
	bh=/eBA8mwA2KLwqa88QvafSzXhfeQ8OkdeIpQfhytMD3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G6LaRO9LmIajhvjs5LGXPTvgmz+16m3Y/VBjupMCSQjoRHpvoeOr690jwwsiX+N2304ivpl9vQkxT56ECVFlT3CEivHA8WJZG8pbGwCE1iwFYTXgpAHj8QrVuQ13e7teZePle6isUuaH+F5gtNyji4TVt6LPjQC38SUGnlviuHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RLCd9Mgq; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RLCd9Mgq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784275798; x=1815811798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/eBA8mwA2KLwqa88QvafSzXhfeQ8OkdeIpQfhytMD3o=;
  b=RLCd9MgqB5DvL30wEmy6qeP3RkkwBjUCreOmdfyOLVWSky2jjkNYR+GH
   3JOO0LWe6qVEaAhKOxQKYzdsKilq30CGbWo/3sKXOEpxSUqRosdqWips5
   gcDWaKuetvBBKGz25DVIeBsRzAJoVDYNumqSjBd8eS147fRenQhPXFAtC
   QRPufOFZJkY9ejFeq6Fs9W6IgPpJNfeCBoJJqP3OTmlZJSWmLC0sCKjGH
   bDjVmGHMQFJHlpBNAN5/fveqPpTt+0fgytrmSZ+FmQ6WaTCwIkoBC0Yce
   vQPsAw+RJhSGvx5b/zLrA/O4bsbqCJyGPxKMyuwXSLEdeeodHQgoQbJMI
   Q==;
X-CSE-ConnectionGUID: NV/7VwL4Re+hL3HjdxzNbQ==
X-CSE-MsgGUID: hN1R8gcUT2mGUaSt+sz3pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="84065492"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="84065492"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:09:58 -0700
X-CSE-ConnectionGUID: /hcbJVIkRY6pHyd9iSondw==
X-CSE-MsgGUID: 25BuCvKGQU+Mxu10bL/xSg==
X-Ironport-Invalid-End-Of-Message: True
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="253315453"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa007.fm.intel.com with ESMTP; 17 Jul 2026 01:09:54 -0700
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
Subject: [Patch v3 1/8] perf/x86: Unregister PMI handler on PMU init failure
Date: Fri, 17 Jul 2026 16:03:35 +0800
Message-Id: <20260717080342.1879573-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717080342.1879573-1-dapeng1.mi@linux.intel.com>
References: <20260717080342.1879573-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix an NMI handler leak in init_hw_perf_events(). When PMU
initialization fails after register_nmi_handler(), the error path
exits without calling unregister_nmi_handler(), leaving a stale
NMI_LOCAL "PMI" handler registered. Add the missing call before
clearing x86_pmu state.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
---
 arch/x86/events/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index af0b67ffb43d..872d07a5fa80 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2219,7 +2219,7 @@ static int __init init_hw_perf_events(void)
 	err = cpuhp_setup_state(CPUHP_PERF_X86_PREPARE, "perf/x86:prepare",
 				x86_pmu_prepare_cpu, x86_pmu_dead_cpu);
 	if (err)
-		return err;
+		goto pmi_unregister;
 
 	err = cpuhp_setup_state(CPUHP_AP_PERF_X86_STARTING,
 				"perf/x86:starting", x86_pmu_starting_cpu,
@@ -2273,6 +2273,8 @@ static int __init init_hw_perf_events(void)
 	cpuhp_remove_state(CPUHP_AP_PERF_X86_STARTING);
 out:
 	cpuhp_remove_state(CPUHP_PERF_X86_PREPARE);
+pmi_unregister:
+	unregister_nmi_handler(NMI_LOCAL, "PMI");
 out_bad_pmu:
 	memset(&x86_pmu, 0, sizeof(x86_pmu));
 	return err;
-- 
2.34.1

