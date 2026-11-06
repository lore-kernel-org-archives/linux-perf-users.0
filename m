Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940058;
	b=1VL6O5mzJNYWA+z/vM7JkTJNVnzp4rIbuhB9vxqwIVgG4STGhx7pBf3TuoW/JiydjtoR
	 yg3tpVfzUCN+UyOObyMltswIh3CyIDgW8Ici7KU0j8JiPfLllvY/wb/bUJGdvZDozmLpn
	 nAXTHUhLZ9ztv5KQZhKHvQ2KjoZ8canZ/hRDudRNpzR0dYbkGOq78JxCqXZEoZoTnUFM3
	 rHtAuzzCzOLdkTHktZBu2vBppFxY3mrDVJ9JnAVXLrZcqar4suBey6C1cNQIdCDv/At7u
	 E4cjhfy6/axRqFGgKLgkRNaVuLWILvSioOrseq5BhXdtEJARum6cdA9wEkd/lckaKUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940058;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0ZrG9uf6TyVs+aMs6zsVXKesUyMbRu/VsgAhmtU9Tkk=;
	b=WSpE44GOv90RsJYUu5JwfVJZYwt+08gDJHtdvao18GNGWoYP9Fit/aFzgz10j8Ixnnqt
	 yqXUyVajRIhM1hWmKXv+umLs9uEZinqB8KdtmunwJ00NLS+iqV6mwxA4EUHLqjq3rsISW
	 bSqBVx4+1BN6Gb45JGFA6MiNuIgT+aLL/ki9MJINPrurwU+r5c7hKVsMkS3CcRELAP7ca
	 FnW7pKeB/MQnCdw75gL7BBa49X6X0GJY1ZFTX9iIsphBEJVinNc2WySh7SXrwdl8BV/cu
	 C6FmOLas6aAaAdIpoAMGmBg0QTZamBwoJE+3zZSqD7ufgSBx9m1ZZK2A/klKddSCUng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kZurHHzp;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8E1606A339;
	Fri,  6 Nov 2026 04:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC8E1606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kZurHHzp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793940058; x=1825476058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l84Qo+DPy/rAi4yxd2ccbFDNPSXLNSDQyje+72caT8E=;
  b=kZurHHzpVyHh3Z0Dl4yTmxQbzUaOLt5zWmMfcuG8CaITt562Mqd+KALN
   IGO6gooCfvvIiZgv3sOoXVOTamluczuhhT0ny5YroT2/tv9BuJInw9EjF
   sdk239P4xYJTo6So2P0VNvu1RDt0s1Y1Qw+e6EN9r83etS/aIJRD2c2Kc
   anEtFOaH0jnBbFFkk/eXIWB3VAaaF5vY9+3CDEtHoV1UuiaX82c9x94fS
   oukt9rQ2c7xNgTrL0+kb7+v38kHr3mVHVTpkIsyAed2DUJLtXnjILXzi7
   kIvrEQlSBVKHYhSEyNjQAo2ILoQMt/BSjFM2HEzo5aQ5Y0U3FYiVoQO67
   g==;
X-CSE-ConnectionGUID: pVD3imwOTn2hMqKlfLRiOw==
X-CSE-MsgGUID: OMacotVIRtSWg7GDg02HxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2780780"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2780780"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 20:40:58 -0800
X-CSE-ConnectionGUID: 3d7qtDE8R++bldGlwwSQvw==
X-CSE-MsgGUID: TmOgKbHMT6KgHQVa82xpBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7222851"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa001.jf.intel.com with ESMTP; 05 Nov 2026 20:40:53 -0800
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
Subject: [Patch v6 04/20] perf/x86/intel/lbr: Limit branch snapshots to valid entries
Date: Fri,  6 Nov 2026 12:32:41 +0800
Message-Id: <20261106043257.842864-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
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
index a2e4ba7e1a4f..1ae853f7ac1a 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1027,14 +1027,19 @@ void intel_pmu_lbr_read(void)
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

