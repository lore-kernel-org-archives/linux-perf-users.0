Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D421A0AFB;
	Thu,  5 Sep 2024 17:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725556030; cv=none; b=azIRZeTFs3vU3h6DNVX19rVlvQ8tAVoPSq/sU/2+C5lMZ8FT7sXTrnAB8bDGHRdmClMzrshWxhJLGZETt6H9Cyi0DX9Rbqe5qI6LR6n3LRNAR7odZ5GsKz/PreQPAggeTerYTKYqugNZ/eHodj/WPvH5DjFbcepDQqcB7zhL79g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725556030; c=relaxed/simple;
	bh=1j/+H8/5sp8uJ/Xp1+ef8nFzgv0F7zvI4ejgGqivC0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AKngMfz2rN1giJ+3rq88xkxIdKubMGP+Qouk+kZyBcxocaBT9XNEsaa7jRYpDLLLRCwmWWmWcpgPvEkSr2uL+kw9sa5yBdmTEYEQfq9JQ5ep9rVx+Vh7QPoHZkIgGSayRfXoEpXZ06Zh/Mycl1DpUqNwSzzjj8Z6zVRKXw1ZSrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dEsHZe9b; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dEsHZe9b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725556029; x=1757092029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1j/+H8/5sp8uJ/Xp1+ef8nFzgv0F7zvI4ejgGqivC0M=;
  b=dEsHZe9bBCaHSzbPTa22k9AI13957F/BVD+dQz9xumO1g3FlLfBP6d5j
   cFflENcACPO4jTTDacJLpW7Zk/5mvumuruMKcB+obH/OUrlhrwN8tdPnD
   wHUZ9yNgTbWt4f+PtVA4mN1kIbN/hgL1p0Ce2S8S8RjTJcFE9rxdcHBIM
   EVQ2dzjF3DauCtwHEVd8rY7jPuinBlFyhi4lAW20YqvDUq+EB4qVmR9X2
   huHJFSDas9bajWKk1pPjfdFa9rZAae5iX/lvrs1rAiGOLaRKruJDT70We
   fE6osCT4GNBoojfdS1W0eGkmFOH52wSVwbpjC5VE7Da9pBatlGekdxb1+
   w==;
X-CSE-ConnectionGUID: g631MWCfQfmQz9acwNUmxA==
X-CSE-MsgGUID: XvmYPygqS0a0wtsE+3L4gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="41769171"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="41769171"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 10:07:07 -0700
X-CSE-ConnectionGUID: 1PSF+o00S9WWAyhdB9UnYw==
X-CSE-MsgGUID: IEG3QKtlSxi161R63p2fSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="70480525"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 05 Sep 2024 10:07:07 -0700
From: kan.liang@linux.intel.com
To: acme@kernel.org,
	namhyung@kernel.org
Cc: irogers@google.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/3] perf mem: Fix missed p-core mem events on ADL and RPL
Date: Thu,  5 Sep 2024 10:07:36 -0700
Message-Id: <20240905170737.4070743-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240905170737.4070743-1-kan.liang@linux.intel.com>
References: <20240905170737.4070743-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The p-core mem events are missed when launching perf mem record on ADL
and RPL.

root@number:~# perf mem record sleep 1
Memory events are enabled on a subset of CPUs: 16-27
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.032 MB perf.data ]
root@number:~# perf evlist
cpu_atom/mem-loads,ldlat=30/P
cpu_atom/mem-stores/P
dummy:u

A variable 'record' in the struct perf_mem_event is to indicate whether
a mem event in a mem_events[] should be recorded. The current code only
configure the variable for the first eligible PMU. It's good enough for
a non-hybrid machine or a hybrid machine which has the same
mem_events[]. However, if a different mem_events[] is used for different
PMUs on a hybrid machine, e.g., ADL or RPL, the 'record' for the second
PMU never get a chance to be set. The mem_events[] of the second PMU
are always ignored.

Perf mem doesn't support the per-PMU configuration now. A
per-PMU mem_events[] 'record' variable doesn't make sense. Make it
global. That could also avoid searching for the per-PMU mem_events[]
via perf_pmu__mem_events_ptr every time.

Fixes: abbdd79b786e ("perf mem: Clean up perf_mem_events__name()")
Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Closes: https://lore.kernel.org/lkml/Zthu81fA3kLC2CS2@x1/
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-c2c.c     | 12 ++++--------
 tools/perf/builtin-mem.c     | 17 ++++++-----------
 tools/perf/util/mem-events.c |  6 ++++--
 tools/perf/util/mem-events.h |  2 +-
 4 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index cef95b2781c0..15e1fce71c72 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -3285,19 +3285,15 @@ static int perf_c2c__record(int argc, const char **argv)
 		 * PERF_MEM_EVENTS__LOAD_STORE if it is supported.
 		 */
 		if (e->tag) {
-			e->record = true;
+			perf_mem_record[PERF_MEM_EVENTS__LOAD_STORE] = true;
 			rec_argv[i++] = "-W";
 		} else {
-			e = perf_pmu__mem_events_ptr(pmu, PERF_MEM_EVENTS__LOAD);
-			e->record = true;
-
-			e = perf_pmu__mem_events_ptr(pmu, PERF_MEM_EVENTS__STORE);
-			e->record = true;
+			perf_mem_record[PERF_MEM_EVENTS__LOAD] = true;
+			perf_mem_record[PERF_MEM_EVENTS__STORE] = true;
 		}
 	}
 
-	e = perf_pmu__mem_events_ptr(pmu, PERF_MEM_EVENTS__LOAD);
-	if (e->record)
+	if (perf_mem_record[PERF_MEM_EVENTS__LOAD])
 		rec_argv[i++] = "-W";
 
 	rec_argv[i++] = "-d";
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index f6be7ffc9e45..ba1d37bfb916 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -117,22 +117,17 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem,
 	if (e->tag &&
 	    (mem->operation & MEM_OPERATION_LOAD) &&
 	    (mem->operation & MEM_OPERATION_STORE)) {
-		e->record = true;
+		perf_mem_record[PERF_MEM_EVENTS__LOAD_STORE] = true;
 		rec_argv[i++] = "-W";
 	} else {
-		if (mem->operation & MEM_OPERATION_LOAD) {
-			e = perf_pmu__mem_events_ptr(pmu, PERF_MEM_EVENTS__LOAD);
-			e->record = true;
-		}
+		if (mem->operation & MEM_OPERATION_LOAD)
+			perf_mem_record[PERF_MEM_EVENTS__LOAD] = true;
 
-		if (mem->operation & MEM_OPERATION_STORE) {
-			e = perf_pmu__mem_events_ptr(pmu, PERF_MEM_EVENTS__STORE);
-			e->record = true;
-		}
+		if (mem->operation & MEM_OPERATION_STORE)
+			perf_mem_record[PERF_MEM_EVENTS__STORE] = true;
 	}
 
-	e = perf_pmu__mem_events_ptr(pmu, PERF_MEM_EVENTS__LOAD);
-	if (e->record)
+	if (perf_mem_record[PERF_MEM_EVENTS__LOAD])
 		rec_argv[i++] = "-W";
 
 	rec_argv[i++] = "-d";
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 17f80013e574..051feb93ed8d 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -29,6 +29,8 @@ struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
 };
 #undef E
 
+bool perf_mem_record[PERF_MEM_EVENTS__MAX] = { 0 };
+
 static char mem_loads_name[100];
 static char mem_stores_name[100];
 
@@ -163,7 +165,7 @@ int perf_pmu__mem_events_parse(struct perf_pmu *pmu, const char *str)
 				continue;
 
 			if (strstr(e->tag, tok))
-				e->record = found = true;
+				perf_mem_record[j] = found = true;
 		}
 
 		tok = strtok_r(NULL, ",", &saveptr);
@@ -261,7 +263,7 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr)
 		for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
 			e = perf_pmu__mem_events_ptr(pmu, j);
 
-			if (!e->record)
+			if (!perf_mem_record[j])
 				continue;
 
 			if (!e->supported) {
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index a6fc2a593938..8dc27db9fd52 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -6,7 +6,6 @@
 #include <linux/types.h>
 
 struct perf_mem_event {
-	bool		record;
 	bool		supported;
 	bool		ldlat;
 	u32		aux_event;
@@ -28,6 +27,7 @@ struct perf_pmu;
 
 extern unsigned int perf_mem_events__loads_ldlat;
 extern struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX];
+extern bool perf_mem_record[PERF_MEM_EVENTS__MAX];
 
 int perf_pmu__mem_events_parse(struct perf_pmu *pmu, const char *str);
 int perf_pmu__mem_events_init(void);
-- 
2.38.1

