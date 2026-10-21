Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792559676;
	b=rr/9kRwBZ+w7MrI50JeEocuHqEwN4C31MzWDAOAyvHFCtdGzIjcVk9S6GGkep64XPcKU
	 tZ6SE6mhypakXNiUgPHARtSCDQwDHWiaRNpkr394pKsCndM49A6euBkZRxq5/tYgqiZGa
	 9U1vDf4U4IoZR4VTxNEHDtsgYh2FSUPmqYu4lkkNAPyt7wWckTIBDS5eUZTnW/DKqQjbS
	 P3D/T4ZDET854rWhNfqiJyOxQwqo6lHI2dObg00Pi2HAXgha+Gvnx4f6yM0onTIvZKSCW
	 EMF159ac/qb1eECey1ofJN5WK8C5O3z9ZUKl5B9j84+dcActpgCfpaloiFnhVQFU+hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792559676;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SFZI8DMJr6ICKqt/QHsab30TQ8uvnKCHxHfkAhfGgPQ=;
	b=UZMFb13S7eFS/QyV+JhnCH7WCB2hcZvIqX7WbOxcjlM2yC6l7fen0H7ER+6NF+hr3RXy
	 16Lp8kPROrYXLw7bWeCSSrRR3NtV//o0w04pKQrOnFjj3XkxH6Lf41X5x+8hR38HRZIvD
	 J8lnJaDm+XohlOH2jpRfkC6clwhF+Tkomn8+ZK8KtinQ9oJviRWgQn7R2FHp7akUfjM/u
	 DQ2WDh5dCTRqlLMP07fBdMuRP1NsrdkW+HEc5gS0561/GJC5fqKRfuYShmygWKUPFqvdh
	 QUYAkSSyU7ldC/Q8N4W6zemQ9fkKeOjom6ChdqZ5y/gsnxT69+g+su8Eh0xCIVKCFng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B+sekd9N;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDBA606A327;
	Wed, 21 Oct 2026 05:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BDBA606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B+sekd9N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792559676; x=1824095676;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hLC8ZGkwaTfu6ZnXT5i21CGE3UrgbMZUHhQ0ocJXqYo=;
  b=B+sekd9N3vJenKef9MS7fhsL5St4i+W5+tBNDbEeSmAtb+FPHlc6LHuS
   HWL4HGpTgknP2MR4oZzUyIlIEfA1Fa4Vnunq99P2m/Wifcycyb6PL1pTl
   YsOMjWEST6BH2jG6mTOyaTmqhNvaqTc/LIuQ50yEgR2UPnTckWFx6h5bR
   OdGkIFH5+kTiYcHSc630Ev9h5w7MyevO6gZV8Z2zA9B8pOBG6/OqwTlmh
   B82oRsqSbND/WSNSvHeg2D91LrUhp0QkhSAYKnKYA4sAuZREf3PQFvDwa
   07g8uBu7dTUn+71Fweuqc8uc1D9BkBnNDtW6/vZYbtEnp8FMYJ8jKodn5
   w==;
X-CSE-ConnectionGUID: vvkqpNPMQRmSwKrub7C6kg==
X-CSE-MsgGUID: E3pPi1HgQJ60KhCMMA7x5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1149168"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1149168"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 22:14:36 -0700
X-CSE-ConnectionGUID: B1xF1gffQI2RLmFHEzCaMQ==
X-CSE-MsgGUID: X9FG7XQrS5mxhF31QEU+FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="2947643"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa005.jf.intel.com with ESMTP; 20 Oct 2026 22:14:32 -0700
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
Subject: [Patch v4 2/5] perf/x86/amd/lbr: Limit branch snapshots to valid entries
Date: Wed, 21 Oct 2026 13:07:08 +0800
Message-Id: <20261021050711.4043703-3-dapeng1.mi@linux.intel.com>
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

