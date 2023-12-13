Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P/qX9FKS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767ABCF;
	Wed, 13 Dec 2023 13:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702503409; x=1734039409;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yNDl1AIWfRrLV+Gwxh9D4+zILF9whC0/B0msILdny9c=;
  b=P/qX9FKSHydigFvmMc9fC/02HTUcmj8NPwylgjv5d6yfCvLjDOWlWSL5
   QTtr/W2140XGB3t/vspItEgyCDKpS5kpMc40C5D39a15pa8jmV7aDX984
   skPhaL3bfgxucF+fGLzgxG9nlNhAwcDy2lTbQQ96WYTxHTo9EUdW4gBmp
   5xRTJkdSmrdodB+jaxfQsk7KQ0gbvM9gWeIh6eWaXYYENOp6KgUDkhBdi
   p9ib0n9jlFmiMU0Se1Y4ksUo5tBm3GLk3O+tS/uafxrGR05z+AIdGffBo
   ikk3PMSPJU87Sd9GvH6lSDNB8Lu6XNeQzRfe2qFG0mVu427w/PSQYvDHv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="8426580"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="8426580"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 13:36:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="723811714"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="723811714"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga003.jf.intel.com with ESMTP; 13 Dec 2023 13:36:48 -0800
From: kan.liang@linux.intel.com
To: acme@kernel.org,
	irogers@google.com
Cc: namhyung@kernel.org,
	mark.rutland@arm.com,
	maz@kernel.org,
	marcan@marcan.st,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 1/2] perf top: Use evsel's cpus to replace user_requested_cpus
Date: Wed, 13 Dec 2023 13:36:32 -0800
Message-Id: <20231213213633.1088026-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

perf top errors out on a hybrid machine
 $perf top

 Error:
 The cycles:P event is not supported.

The perf top expects that the "cycles" is collected on all CPUs in the
system. But for hybrid there is no single "cycles" event which can cover
all CPUs. Perf has to split it into two cycles events, e.g.,
cpu_core/cycles/ and cpu_atom/cycles/. Each event has its own CPU mask.
If a event is opened on the unsupported CPU. The open fails. That's the
reason of the above error out.

Perf should only open the cycles event on the corresponding CPU. The
commit ef91871c960e ("perf evlist: Propagate user CPU maps intersecting
core PMU maps") intersect the requested CPU map with the CPU map of the
PMU. Use the evsel's cpus to replace user_requested_cpus.

The evlist's threads are also propagated to the evsel's threads in
__perf_evlist__propagate_maps(). For a system-wide event, perf appends
a dummy event and assign it to the evsel's threads. For a per-thread
event, the evlist's thread_map is assigned to the evsel's threads. The
same as the other tools, e.g., perf record, using the evsel's threads
when opening an event.

Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Closes: https://lore.kernel.org/linux-perf-users/ZXNnDrGKXbEELMXV@kernel.org/
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V2

 tools/perf/builtin-top.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index ea8c7eca5eee..cce9350177e2 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1027,8 +1027,8 @@ static int perf_top__start_counters(struct perf_top *top)
 
 	evlist__for_each_entry(evlist, counter) {
 try_again:
-		if (evsel__open(counter, top->evlist->core.user_requested_cpus,
-				     top->evlist->core.threads) < 0) {
+		if (evsel__open(counter, counter->core.cpus,
+				counter->core.threads) < 0) {
 
 			/*
 			 * Specially handle overwrite fall back.
-- 
2.35.1

