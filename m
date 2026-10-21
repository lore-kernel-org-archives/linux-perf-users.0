Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792559685;
	b=JGY5kA5T32ctp8/yZITSUsyOTSIyYNHtmAN7QlPFZTNkGmzSj7UCV7tsFYJvWBSlQXah
	 hC2C4c8IaHyxvRC6lRogG2MAS5urBxuN9ihUSRisn38WaM+k8TX5w6tQHCNxhWfo+Wvxc
	 zSVhp9hhALTBed1NUAPQud+t23r/B2Yv8TfAIrG/nhSLHj/Jx9ZyNOFd3hprpw7elA5as
	 nCZA+T7GRS388NTilSzk72/t/QyKKaetifAFfvjFN3+mPUPeUnMd0slyFInwqWFUhoeSD
	 dBkubPVhhdLPSNDwq/jsAvnBAifOLvl2Ssdi13C/7ZTWWRv4N/ga4LJ3SHUwK7qFJYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792559685;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1766TKlauX4bF8ysI5lKU+IqXJpjlFUadXz0m8sFn+E=;
	b=scxyK0GKCr3R11s3WCUHvpBE6ULfKMUQp8wHmXueAKHHqUjh3GqpU10UJ3kizU9bmQb0
	 PITrpTRLQ064XJL8r8KUA9gPz8NDoqz5p8vRH8zAaEF5jInUx/onQsVQKjs03+mtoRc8p
	 KDra6qyDbn8O9mxA6zoH3TNnTyX1xa2gi0J1/REJb8qGIxlbIPctwEh5R1d3u8i/vrzup
	 EQYBYS4NzWCDH/SS1XI5OY/+h3tZLtTEfTGhO+2mbsC6cxgmdzmE3trUwLPukS6wLkryo
	 +gxd7jegq2KG1euXl54FmjZitfIjD0W2dk0nCz5T2ZfwhjRIrkcnuXqKNY4lgQbpeHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PQ6JLnqw;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E75606A323;
	Wed, 21 Oct 2026 05:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24E75606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PQ6JLnqw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792559686; x=1824095686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E/7p6wL8dqjQjL88p89iDjHq3cBFKWqoR47DBLtHcNA=;
  b=PQ6JLnqwYJ4a4zU2DQHswIt6ggWhCv+0TMv+3uAcm9+M5718C4yFBq2O
   GsthaU+y6XO7KMmCRnYTFC/D633llcXyYDJ5VDK7euv7v5RBTpzUp4kCV
   2158YFk6/cERGpYDAycqbn5G0dy5OoKgwDfKw2KIlFfF3BHzTnNX0UBeY
   G/aVeQg5rfC98L+Ln6PYHI/W3ucw4UV3BlL4ynwTjMw0Sz0t9quZw6Pwk
   9rLvi+l1WFU2LhRY292aqk0gx103qq9Za9ka58Nynuc6vt2PmlRaMYmuT
   U5XD5KwszJ/kX3NZkyHiAvRZm6doeQIVlZZm3SYvnNff0rxo0JhSOg3QV
   g==;
X-CSE-ConnectionGUID: weMAmOnCSvOBYtbPf/gfCw==
X-CSE-MsgGUID: WC6D6a47TkWPBY2xKZxkiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1149195"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1149195"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 22:14:45 -0700
X-CSE-ConnectionGUID: 0xpPAl2kQWaX2yYSK/S98Q==
X-CSE-MsgGUID: IFIsmFS1QdKyZmoVOr7VZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="2947670"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa005.jf.intel.com with ESMTP; 20 Oct 2026 22:14:41 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [Patch v4 4/5] perf/x86/intel/lbr: Limit branch snapshots to valid entries
Date: Wed, 21 Oct 2026 13:07:10 +0800
Message-Id: <20261021050711.4043703-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021050711.4043703-1-dapeng1.mi@linux.intel.com>
References: <20261021050711.4043703-1-dapeng1.mi@linux.intel.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The branch snapshot callback used by bpf_get_branch_snapshot() always
copies x86_pmu.lbr_nr entries from cpuc->lbr_entries[], even when the
last LBR read kept fewer branches. The entries past lbr_stack.nr hold
invalid branches which end up reaching BPF programs.

Limit copying to lbr_stack.nr entries and also reset lbr_stack.nr when
no active LBR events or LBR hardware is owned by guest. So the stale or
guest LBR stack data can't be leaked.

For the case where all LBR events are PEBS events, hardware LBR reads are
currently skipped; that can leave stale LBR stack data from previous PEBS
sampling in place and may be inconsistent with the intended semantics of
bpf_get_branch_snapshot(). This will be addressed in a follow-up patch.

Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-163130@kernel.org/
Co-developed-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 2 +-
 arch/x86/events/intel/lbr.c  | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0a34d674df59..5dfb9e9156e8 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2822,7 +2822,7 @@ __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
 	intel_pmu_lbr_read();
-	cnt = min_t(unsigned int, cnt, x86_pmu.lbr_nr);
+	cnt = min_t(unsigned int, cnt, cpuc->lbr_stack.nr);
 
 	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
 	intel_pmu_enable_all(0);
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index c7e295db9410..ac1759a71288 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1024,14 +1024,19 @@ void intel_pmu_lbr_read(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
+	if (!cpuc->lbr_users || vlbr_exclude_host()) {
+		/* Reset lbr_stack.nr to prevent stale data leakage. */
+		cpuc->lbr_stack.nr = 0;
+		return;
+	}
+
 	/*
 	 * Don't read when all LBRs users are using adaptive PEBS.
 	 *
 	 * This could be smarter and actually check the event,
 	 * but this simple approach seems to work for now.
 	 */
-	if (!cpuc->lbr_users || vlbr_exclude_host() ||
-	    cpuc->lbr_users == cpuc->lbr_pebs_users)
+	if (cpuc->lbr_users == cpuc->lbr_pebs_users)
 		return;
 
 	x86_pmu.lbr_read(cpuc);
-- 
2.34.1

