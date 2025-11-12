Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B452405E7;
	Wed, 12 Nov 2025 08:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762934874; cv=none; b=F6eGH7jV2iZF8YcbYt7DVQ5x2ZYf8JwO1ypEOqwWz12j38pMZNUhUyNJI8Ig67N8HhYsjoN/FsjN6nHKG/TuDwxqaAAcPxfEHv8BNtLCU3caGRuAMnR/0gGxnX3VsAC15eLqb4MEGI2F5ooeed2sm9N/sScA1FLN/KMAwEYU2LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762934874; c=relaxed/simple;
	bh=lj+/IkVPrg7NuG/0HeZYwgpbjcPITe74BCRaYFOk6Ss=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RFrCdlXGQIehB/gFlk5y8GyR3jBLGrw5XlwW4BjurBored6cZWqDqJAD8GmpLZuwKpENoc1NgzfHA0HY9K4O02dfs277Tv6/v27eOoEWjLumnhRUepqwdJoC/xbewwPYVCvFKfh4u2mTr+1bnKTbDAThyM1n8pADhM5L2e2CLt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mKJeU+gb; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mKJeU+gb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762934872; x=1794470872;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lj+/IkVPrg7NuG/0HeZYwgpbjcPITe74BCRaYFOk6Ss=;
  b=mKJeU+gbcpqDb2a4xTDSbo2ocL0ehcdfE5XQCsKF/HrdZIcO/8VBwenT
   wGL95kR3XIV/GuzGfGd3oQnlc9EhMDT6gNIhsB27R61QEs8rqpNF69IVL
   WYBM0o5zGEK03B7KVQFgZ03x7EikFCKRkmJVELy3RXkzW7du2RJsp+l8r
   Jfyy173E7QbOI/CfdIulnfmFFDPdn6MIAexAC66coOJ2B3cyhIQM4YF69
   PwOxtrzdRd3jHbXvnE5kbNxQNF7KQD7dlIKSLvMHATJxo/zw5drENf0BD
   wbh9NZ8LgUmZLWfDnXdw4EgKTncSb5bnDp0pIJbkm/P+mVoD1bTDhjxTI
   A==;
X-CSE-ConnectionGUID: fp8KAIcXQ2GRNlXKClHPJQ==
X-CSE-MsgGUID: XlcGBBFuSTm9+aGjCEl92w==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="76452320"
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="76452320"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 00:07:50 -0800
X-CSE-ConnectionGUID: PlpY92azT8Sj8+cTphu8JQ==
X-CSE-MsgGUID: Yl0XE7nLSXW2g+lV9s1exA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="188926087"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 12 Nov 2025 00:07:47 -0800
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
Subject: [PATCH] perf: Fix 0 count issue of cpu-clock
Date: Wed, 12 Nov 2025 16:05:26 +0800
Message-Id: <20251112080526.3971392-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently cpu-clock event always returns 0 count, e.g.,

perf stat -e cpu-clock -- sleep 1

 Performance counter stats for 'sleep 1':
                 0      cpu-clock                        #    0.000 CPUs utilized
       1.002308394 seconds time elapsed

The root cause is the commit 'bc4394e5e79c ("perf: Fix the throttle
 error of some clock events")' adds PERF_EF_UPDATE flag check before
calling cpu_clock_event_update() to update the count, however the
PERF_EF_UPDATE flag is never set when the cpu-clock event is stopped in
counting mode (pmu->dev() -> cpu_clock_event_del() ->
cpu_clock_event_stop()). This leads to the cpu-clock event count is
never updated.

To fix this issue, force to set PERF_EF_UPDATE flag for cpu-clock event
just like what task-clock does. Besides, or flags with PERF_EF_UPDATE
for task-clock although currently the flags argument would always be 0.

Fixes: bc4394e5e79c ("perf: Fix the throttle error of some clock events")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---

With this change, both cpu-clock and task-clock can do counting and
samping correctly.

1. perf stat -e cpu-clock,task-clock -- true

 Performance counter stats for 'true':
           240,636      cpu-clock                        #    0.358 CPUs utilized
           243,319      task-clock                       #    0.362 CPUs utilized

2. perf record -e cpu-clock -c 10000 -Iax,bx -- sleep 1
[ perf record: Woken up 2 times to write data ]
[ perf record: Captured and wrote 0.028 MB perf.data (36 samples) ]

3. perf record -e task-clock -c 10000 -Iax,bx -- sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.029 MB perf.data (41 samples) ]

 kernel/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f6a08c73f783..77d3af5959c1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11964,7 +11964,7 @@ static int cpu_clock_event_add(struct perf_event *event, int flags)
 
 static void cpu_clock_event_del(struct perf_event *event, int flags)
 {
-	cpu_clock_event_stop(event, flags);
+	cpu_clock_event_stop(event, flags | PERF_EF_UPDATE);
 }
 
 static void cpu_clock_event_read(struct perf_event *event)
@@ -12043,7 +12043,7 @@ static int task_clock_event_add(struct perf_event *event, int flags)
 
 static void task_clock_event_del(struct perf_event *event, int flags)
 {
-	task_clock_event_stop(event, PERF_EF_UPDATE);
+	task_clock_event_stop(event, flags | PERF_EF_UPDATE);
 }
 
 static void task_clock_event_read(struct perf_event *event)

base-commit: 2093d8cf80fa5552d1025a78a8f3a10bf3b6466e
prerequisite-patch-id: a15bcd62a8dcd219d17489eef88b66ea5488a2a0
prerequisite-patch-id: 2a0eefce67b21d1f30c272fd8115b0dc1aca3897
-- 
2.34.1

