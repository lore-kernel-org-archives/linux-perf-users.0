Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794972211;
	b=hKXfOlkXNviPWsh+kMK56D2exHOGIqMmpUueJwh6uYedsdfmXxjDzlTHCipIyXnP43KE
	 r0KH5b8AJnLbZIbqxwPBd0E7f3U1fQJcc72UFJu4XXDk5B++KPoCg80Nu/GcuXR7UZ6K9
	 CmelkkAssT72s+xSMkzNkgzLxUiACUcqVpYxUwRX/oUo9WBmQZc76S/EX9jEHULTlgUdE
	 NsztCceUJS7UufTfExs/aZ+qRuIHjuELV+uHhfTZ8dGEHOMcoKIBYQ7hO0vVpkmVCCsq3
	 LC1jmfnO6e5/wWvF35o6haRTLhe0hcZMJuS4aftaO5AEuaXgVEMZToVe3/iMeOjRAtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972211;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yRIEext0PRRy2hK2R1Cd1fgknY4PGcAOxsOvNwEIpqU=;
	b=b1zP98m+Epd3Ji8PPyWF4RhxgQ0l1LeWzwku0Mvko5kKgmxdc/7phsaw3LV9iwkbvPOE
	 Dc0cwzVQW911nk2+i6/Bm+c78MLU1FNs+y4TNArD0XD9SzTQVr4amZ/pFHboypJ5IF64Q
	 GT0w/CyaDCB2GcrOlJJAn4YOi7l08VSQBsLA6f3/Ko/71JwNlh9bnnF2jJwmIJ7FtOvk5
	 RDEKRn4R7PXgwUWaDfTOgk/QH9j1zVKPQaZiuuOl3lAfuZiXvgOvdi+lInRZWfzgJWGy0
	 nnWHiaku/pcCfQ8gJIkoyLKG0yMrFAfVWIrkU588WlXXAQu8DHS0hiFvwH/irN9bMdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GrPsffBv;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4454E606A890;
	Wed, 18 Nov 2026 03:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4454E606A890
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GrPsffBv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794972212; x=1826508212;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bqKUpuucKsUckl7cdgR9Ty2PKcFnN4GAZg/adv0NJAs=;
  b=GrPsffBvKtOxgC0DoRtzl4yAW+3FB/QnDf80GGJDmNDn5ezbiPzVthEa
   f2DYsAkC8OVgHENmOcgRQZeWwn9IOIkSeD6fSTBKqJPZT3AY4oKa/T3zL
   doq4idpW3G5fpx3kLFUBfkz4H9S5jp8hMA+1vGmPfri63O5/Zt6xWIjJK
   +zxoZvKvI20Fl0ZRsu97zBL3/b61L1ePpYhjLh2VOeZrQ+e4EpSGe3M/g
   vgeUUYNu5JqDznNhTcMwJpmHqpqmgZwGTEwj7x4qFJJn8hHRNDR2dkVt8
   KPEY1ZMV2CzoRP2RYvnbX4bYkOySdwKH2UhaBqpPYG3H5/ScmnwzAyNuF
   g==;
X-CSE-ConnectionGUID: Xnep1AxARviDlcx4uvjz+Q==
X-CSE-MsgGUID: 6baZDg7QRkWy2M40yAijuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3629851"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3629851"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 19:23:09 -0800
X-CSE-ConnectionGUID: 2ezOThqhSaKFVBprSKZOKw==
X-CSE-MsgGUID: k8LG1rULRPmvbQFiYjnaAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9894150"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa004.jf.intel.com with ESMTP; 17 Nov 2026 19:23:04 -0800
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
Subject: [Patch v7 04/24] perf/x86/intel: Limit branch snapshots to valid entries
Date: Wed, 18 Nov 2026 11:14:33 +0800
Message-Id: <20261118031453.1353625-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
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

Limit copying to lbr_stack.nr entries, and reset lbr_stack.nr when there
are no active LBR events or the guest owns the LBR hardware, so that
stale or guest LBR data can't leak.

For the case where all LBR events are PEBS events, hardware LBR reads are
currently skipped; that can leave stale LBR stack data from previous PEBS
sampling in place and may be inconsistent with the intended semantics of
bpf_get_branch_snapshot(). This will be addressed by making the BPF
snapshot always read the live hardware LBR state.

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
index 3d41385c4924..79303fb9b046 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1026,14 +1026,19 @@ void intel_pmu_lbr_read(void)
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

