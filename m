Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793249215;
	b=Oh9YAYGKdLkYC2JG25dWF7+d/6CLhSgRR9dd/keEJbexxoanvaLcVbYw8ki9XLksaOlb
	 NRta0WUX4EY9WVPR8N9+LMT/GAeXKwG9gwMWBZuZ9VIh0F0y8EZjdXEZdHkC+hta/Y1nE
	 hUdYldv7WCBBdT//qwNd/vclvGG9D6sWgAqLPiy9RLH6KdDzyPGF1F8BqGZo//BJ+IoW0
	 /mIq1IzZA0+9J7Td4kknOsXQDY/mrUVh3OO+81zPAA0TW7c3l17JALyw36TucSWOtKeCz
	 hPNFpAFyi+Mvn+C3fufrJQoK+qcT0ZzOedU6YS9RVHH/qWTQt9PD6L/Yk/dijGUNoZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249215;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=o+4lHgpp/N1Q3vu0XAsGefMhVv1bS4yL6ebufutsmbg=;
	b=UrItrqK7MMHCwkSq/dO9ro9S43TWZgXvlRkW6XBYUKLAqpqmRiFROudIMebI7Vw0BeR3
	 qfUpv6NR+XsnAUnKQyFtPBCELpoZxBB1IYSHhI+Y++nAzZX/ZqGQWaWyT/+JLe9daFDTP
	 CiyUWNiNPexyqXQ/U9qLngqtJxFic4dao7sDJjtmplVa7gIDigWur1jNWaBivlV0RBl5y
	 zW5PqRAA/cye/TUE5p/a8YStDzw/XEq7vUKVbTB6O24/fWi2/+3cKPdHbho0O0MqTRROT
	 g2ye7KRQ0RggORmSpLdee7Y2YyU/GlZ2IjYrLsmeORATYNCvcNaCVLfHiqbokmNJThg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lDjUSmo5;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5E9606A32F;
	Thu, 29 Oct 2026 04:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD5E9606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lDjUSmo5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793249215; x=1824785215;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dz0/1/McRIK4NRZodZSNifKLpm4yxDyMgoRA5InOoiQ=;
  b=lDjUSmo5vkNe7HmtQF/lkt0AoDllg/X/iGqx8yj9wzXTrTzSyZqEYcrq
   b7gr1EAlFLTnACM1dD82q1NvHg6k82ntEEOb/uhiuLyUiQxEBUDMJLkGA
   scR7Sa5zLub4pYzntrVzJeAyC4wU5VC72I44M9ebPeg8L0I9OKNGiskrX
   GTQ6TD1ZXJJXl/D/p2SMdIyyWxHMkBB/7a27S7i2dhivrz+yYnGvvxfTB
   cBj/4OvspVkvzQQNvgEryOiwkqMTzIJJZoU2TNUFaRPykEM6iOVPLCD60
   LuOQu+NjcxuZjX13vsSJjQKNGQU3nhpPeY0jrptgTOMI3Lsanwq5vyp71
   w==;
X-CSE-ConnectionGUID: /8xJZ8VwQDOsX+fN51doHg==
X-CSE-MsgGUID: tIanjEThS2eKoLTMAfMfkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1986255"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1986255"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 21:46:55 -0700
X-CSE-ConnectionGUID: 9yjAoe/fT4OccqUsl0YojA==
X-CSE-MsgGUID: zhup2gvNT+aQeJIxRuSsGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="5420310"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa007.fm.intel.com with ESMTP; 28 Oct 2026 21:46:50 -0700
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
Subject: [Patch v5 03/18] perf/x86/amd/lbr: Limit branch snapshots to valid entries
Date: Thu, 29 Oct 2026 12:38:59 +0800
Message-Id: <20261029043914.1395147-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
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
index 96c5b5e56053..46bd3ce1d614 100644
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

