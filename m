Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940054;
	b=3z5LTi6L1am4jlukWTM6QafqPv1Jn7zHzXFkyJJew17ip+yQ7pt2/DgfTw1tc62rJXlW
	 m1s7igpwtkjk13TLiVyGdHyTbnkhCIvYdjcdzmc3XyGV1yYL509XO26iFM8KfIW2TgWBk
	 mHGgmS3vyYevlBABSqNs0myf+KFfk3L23LUs4X0n1w4o3YrBpj9QgusIUkz3kKRh8ytpJ
	 TUCCCWG6PYJb6gXjYGQttgnPDl3d1XHyy/J86qiGHZUebG3ZHzXz1vLTuqUsI3XUFUNrs
	 j0vmPZxl5g1xWbYUdM56uoiKKIzX0+tW1N7uyqWMfLFntUD9I7aY2FDiBOP7rz+20fA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940054;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SFZI8DMJr6ICKqt/QHsab30TQ8uvnKCHxHfkAhfGgPQ=;
	b=YnkYAy3k/wIfwy/9yS86RU+6/IQOIZWPj4pLaybe0V49jNXWvQyZsQATRFEk61VILCSH
	 wLm7BZxEjwZMFqfHT6bqNJQIIuCVc4a8hc8zqV/owB9iXoF/Bkd8xmeUwNPlEba0LK1Nz
	 pcu7AJqtPz/Pn2tKpvTBtTYdNZmLFTZpBle8ms1YohASWJc6EZvwOfxA6RyL9fGVbNqup
	 f2WaOvpS3PTTJDRNjKz8Qsv6ymrjKKv6Qp4Ox/dlWfCCQuZr29rD61a1D7jaQuhyb5h8Q
	 /pCFzrv9cFVER1cHIvMJxMu+tK5Q3k6kcEe5jSYnL5tRwSOGUbKQQd1Lvwyt1AKB4kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k0Qf9msA;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B135606A32F;
	Fri,  6 Nov 2026 04:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B135606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k0Qf9msA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793940054; x=1825476054;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hLC8ZGkwaTfu6ZnXT5i21CGE3UrgbMZUHhQ0ocJXqYo=;
  b=k0Qf9msALzMFbX3X78qfLM8TCuq8Q3gGUIimA14q30SE+YE2PJ9NghcG
   2/v8LuBLP7d9vCAL+224UCrjFyhJkWC/Wt7G/pwRJOAWkGrkaQVepLI1v
   UCp4zL7wIIUPfDzwuccimraDKmD9EwEO3DRR8xdSkqSrvGc/LvkaYgjRH
   WIAcpnzEeJU2NazF71TXvaGWHyVZXLxRUURVBHA6X9k9IIgQXTKP4G1LK
   8DdV1ey5MhrR/5TxPClNrda01GxOWnx/yJVAbBg+orTeX1CeBqAxBLQji
   QcPY1HY7iHMif+y2yzlJFTw1dSMf93GeXkoZmzTLI/mkRwghkoz79iaXd
   g==;
X-CSE-ConnectionGUID: 939V3ooMQAOj69sHK8bMQQ==
X-CSE-MsgGUID: YjCtfu8bRzefXX7KnAa/Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2780770"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2780770"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 20:40:53 -0800
X-CSE-ConnectionGUID: XIJqZiyWQ4u/fnKB7zoIyA==
X-CSE-MsgGUID: w5pp+V5DRlaQFQCW1DTzBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7222825"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa001.jf.intel.com with ESMTP; 05 Nov 2026 20:40:49 -0800
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
	Sashiko <sashiko-bot@kernel.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v6 03/20] perf/x86/amd/lbr: Limit branch snapshots to valid entries
Date: Fri,  6 Nov 2026 12:32:40 +0800
Message-Id: <20261106043257.842864-4-dapeng1.mi@linux.intel.com>
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

From: Sandipan Das <sandipan.das@amd.com>

The branch snapshot callback used by bpf_get_branch_snapshot() copies
up to x86_pmu.lbr_nr entries from cpuc->lbr_entries[], even when the
last LBR read kept fewer branches. The entries past lbr_stack.nr are
invalid, but they end up reaching BPF programs.

Limit copying to lbr_stack.nr entries and also reset lbr_stack.nr when
amd_pmu_lbr_read() skips reading the registers, so that a stale count
is never reused.

Fixes: a4d18112e531 ("perf/x86/amd: Support capturing LBR from software events")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-163130@kernel.org/
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/amd/core.c | 2 +-
 arch/x86/events/amd/lbr.c  | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 49b6b8fce566..bf631f60757c 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -944,7 +944,7 @@ static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, u
 	cpuc = this_cpu_ptr(&cpu_hw_events);
 
 	amd_pmu_lbr_read();
-	cnt = min(cnt, x86_pmu.lbr_nr);
+	cnt = min(cnt, cpuc->lbr_stack.nr);
 	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
 
 	amd_pmu_v2_enable_all(0);
diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index a55646fcb846..6c93b8042c73 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -168,8 +168,10 @@ void amd_pmu_lbr_read(void)
 	struct branch_entry entry;
 	int out = 0, idx, i;
 
-	if (!cpuc->lbr_users)
+	if (!cpuc->lbr_users) {
+		cpuc->lbr_stack.nr = 0;
 		return;
+	}
 
 	for (i = 0; i < x86_pmu.lbr_nr; i++) {
 		entry.from.full	= amd_pmu_lbr_get_from(i);
-- 
2.34.1

