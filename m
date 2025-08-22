Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4E52EB5D9;
	Fri, 22 Aug 2025 08:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755851022; cv=none; b=CYoBzu4hgFpl2PIWYYHy+k2UAUdcRO7AWmNn/srHH2ilPr9CER62OFx5G7DwTtp6fxF9m/bp82LCdP2DUMAjgOw/J+tjCwNmF/bQLIK8Z/T+pw/jBl4fHAWuVYOa+crGoKpDsHpRPAc6pholL8hbDJ6MapK1U1iLymPamqEQMiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755851022; c=relaxed/simple;
	bh=l271mH/2s7sZVR71jaM1oYJGsIzB3Y8dxH+x8mjAV6s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D2a5mGDLRv3QhDrz8VddLk0vQ11smP2lKeGLN15Ghck/FwPhvAf5ZgUd226EuXodAvcyVNAXHDHk7DZbZe2CJp0ttt2//xecOoXGpEt1tc8tLxOiRZiuLnuOpoPRCeBHKC4Zs6f7nd2ufQdAm64xkqEu4Prd03syN2AuFawRpsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NkW2hxq3; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NkW2hxq3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755851021; x=1787387021;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l271mH/2s7sZVR71jaM1oYJGsIzB3Y8dxH+x8mjAV6s=;
  b=NkW2hxq3tcJyQmxEdCdc8ba+TBRHqjQJaSmjui9YU0LDgnZY1q+c/O/y
   FKO3sn/Gr44Ntc4zee84R4uJbPjUvfLAgciGdDkzHKFp6XI0cz0Ya01nR
   zJAK0g7FsuZLQokP+nhhHSxttYAtU7SV4v5OdtMuRzO++3pQx4P33y3EM
   CG3/q28+cwpWzEh0FtY8ObH2+3RRtf6CXUmcNCDqck3K24FD51Y1hlRFg
   5DnL1RiuAF/EX7ldcEBcojDurgsAQgHQOQGEjTiqq+XT/yOR18uJnsPPZ
   vV8kwzZ7jcsAoX+NjWSIx2zYdJzuxJwpA2mBN5BmlsrpfWS2vEIiEt+Eh
   A==;
X-CSE-ConnectionGUID: YyFvuBazTrO+AMW0a2UQxg==
X-CSE-MsgGUID: g2O47t3SQKWVmIvyEpf3Lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58303326"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="58303326"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 01:23:40 -0700
X-CSE-ConnectionGUID: p6OjpZoKQoufk2J58ZAd1w==
X-CSE-MsgGUID: XSwHC0FrSDOVsCM14AZ4+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168157908"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa007.fm.intel.com with ESMTP; 22 Aug 2025 01:23:37 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH] perf tools topdown: Fix incorrect topdown slots regroup
Date: Fri, 22 Aug 2025 16:22:33 +0800
Message-Id: <20250822082233.1850417-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running the command "perf stat -e "slots,slots" -C0 sleep 1", we
see below error.

perf stat -e "slots,slots" -C0 sleep 1
WARNING: events were regrouped to match PMUs
 Performance counter stats for 'CPU(s) 0':
     <not counted>      slots
   <not supported>      slots

     1.002265769 seconds time elapsed

The topdown slots events are not correctly counted. The root cause is
that perf tools incorrectly regroup these 2 slots events into a group.
If there are only topdown slots events but no topdown metrics events,
the regroup should not be done since topdown slots event can only be
programed on fixed counter 3 and multiple slots events can only be
multiplexed to run on fixed counter 3, but grouping them blocks
multiplexing.

So avoid to regroup topdown slots events if there is no topdown metrics
events.

With this change, above command can be run successfully.

perf stat -e "slots,slots" -C0 sleep 1
 Performance counter stats for 'CPU(s) 0':
       103,973,791      slots
       106,488,170      slots

       1.003517284 seconds time elapsed

Besides, run perf stats/record test on SPR and PTL, both passed.

Reported-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/arch/x86/util/topdown.h |  2 --
 tools/perf/util/evsel.c            | 10 ++++++++++
 tools/perf/util/evsel.h            |  2 ++
 tools/perf/util/parse-events.c     | 11 +++++++++++
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/util/topdown.h b/tools/perf/arch/x86/util/topdown.h
index 69035565e649..6a917b2066f7 100644
--- a/tools/perf/arch/x86/util/topdown.h
+++ b/tools/perf/arch/x86/util/topdown.h
@@ -8,8 +8,6 @@ struct evsel;
 struct list_head;
 
 bool topdown_sys_has_perf_metrics(void);
-bool arch_is_topdown_slots(const struct evsel *evsel);
-bool arch_is_topdown_metrics(const struct evsel *evsel);
 int topdown_insert_slots_event(struct list_head *list, int idx, struct evsel *metric_event);
 
 #endif
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d264c143b592..6aaae1ac026e 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3965,6 +3965,16 @@ int evsel__source_count(const struct evsel *evsel)
 	return count;
 }
 
+bool __weak arch_is_topdown_slots(const struct evsel *evsel __maybe_unused)
+{
+	return false;
+}
+
+bool __weak arch_is_topdown_metrics(const struct evsel *evsel __maybe_unused)
+{
+	return false;
+}
+
 bool __weak arch_evsel__must_be_in_group(const struct evsel *evsel __maybe_unused)
 {
 	return false;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 5797a02e5d6a..33f8aab675a9 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -556,6 +556,8 @@ void evsel__set_leader(struct evsel *evsel, struct evsel *leader);
 int evsel__source_count(const struct evsel *evsel);
 void evsel__remove_from_group(struct evsel *evsel, struct evsel *leader);
 
+bool arch_is_topdown_slots(const struct evsel *evsel);
+bool arch_is_topdown_metrics(const struct evsel *evsel);
 bool arch_evsel__must_be_in_group(const struct evsel *evsel);
 
 bool evsel__set_needs_uniquify(struct evsel *counter, const struct perf_stat_config *config);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 8282ddf68b98..bd09fc47ea90 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2127,6 +2127,8 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
 	int ret;
 	struct evsel *force_grouped_leader = NULL;
 	bool last_event_was_forced_leader = false;
+	bool has_slots = false;
+	bool has_metrics = false;
 
 	/* On x86 topdown metrics events require a slots event. */
 	ret = arch_evlist__add_required_events(list);
@@ -2147,6 +2149,11 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
 		if (pos == pos_leader)
 			orig_num_leaders++;
 
+		if (!has_slots)
+			has_slots = arch_is_topdown_slots(pos);
+		if (!has_metrics)
+			has_metrics = arch_is_topdown_metrics(pos);
+
 		/*
 		 * Ensure indexes are sequential, in particular for multiple
 		 * event lists being merged. The indexes are used to detect when
@@ -2163,6 +2170,10 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
 			force_grouped_idx = pos_leader->core.idx;
 	}
 
+	/* Don't regroup if there are only topdown slots events. */
+	if (force_grouped_idx != -1 && has_slots && !has_metrics)
+		force_grouped_idx = -1;
+
 	/* Sort events. */
 	list_sort(&force_grouped_idx, list, evlist__cmp);
 

base-commit: 6235ce77749f45cac27f630337e2fdf04e8a6c73
-- 
2.34.1

