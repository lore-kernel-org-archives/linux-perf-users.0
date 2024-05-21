Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C9F148FF2;
	Tue, 21 May 2024 17:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716313203; cv=none; b=G3jYrdtL0Y+Zw64CDbPfl2sTaYImYdKVFcOLY/yKTRSy1196Zz8QZ8XbpM3FT0vSHMy4xh6S0dNxFSJKRTMdz74hvg0C3X/vILqVMMHNyNdpz+qnP1mlJ+g1qEak8+PCv/67zpX/jtmbthTHYnvj5OgmMJxB8SumjsnNbN23l4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716313203; c=relaxed/simple;
	bh=X+44rHPb66Uil+OsN4KxGva1uIUaHr+af/WBvfmZkO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3OB5qhYm/8riIqaCTSF4a7HEkKktDquHPMOFHDcuCsztDYhMmqICM+0lf0tOmNXcrpZF4AV5XM7zH7fOUyVLHojvJ8n27NGIiMN4rNUkgk5OxXHyBDESNkC4JZz2oP3wJ02bT2SUMq+VJL+f8pIES1RrFU0kvzpQ3LKDxNDBPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cSVRICcZ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cSVRICcZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716313202; x=1747849202;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X+44rHPb66Uil+OsN4KxGva1uIUaHr+af/WBvfmZkO0=;
  b=cSVRICcZmMfZdYS4iWXS2EZQa2cUWo4hXyfs+FRuUypZ7WMOXw2iMn1V
   3SBGXzn8SYaRgBOHLYK/buafOBASQlzn3W8dtfTYywXRzvRlCztk2vkh0
   r5CmIqr7n1NxeczGmRUONThWYcMVat2mxQOhNWYrpw/Iev5ykLffgmls4
   bS4/nreEOcDVcIDdjdnMd/ScXuyoiGOz7YVPJqw7kXgjwpX3v2YtATLBF
   rTI6RukdKMyKMv+udjDmxBn1I7OBDUg581B5B866zTCHJ9MF4oecyBvfP
   lx7KeFehj4bgcXXHEZMXUa6qY/ALNXQrmjrxQTBzLz6LS4ZIja9UW9M20
   Q==;
X-CSE-ConnectionGUID: 8RijWiA0Tly4GC/Atx1BMA==
X-CSE-MsgGUID: GjJ409yhQqSH7mGNfXHmkA==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="12317676"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="12317676"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 10:39:59 -0700
X-CSE-ConnectionGUID: I97usBPeRVCGDKXYf5NX6A==
X-CSE-MsgGUID: 5pdY7ttZQWykDuM7ZRElZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="32924971"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa007.fm.intel.com with ESMTP; 21 May 2024 10:39:58 -0700
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: [RFC PATCH v9 5/7] perf stat: Add command line option for enabling tpebs recording
Date: Tue, 21 May 2024 13:39:33 -0400
Message-ID: <20240521173952.3397644-6-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240521173952.3397644-1-weilin.wang@intel.com>
References: <20240521173952.3397644-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

With this command line option, tpebs recording is turned off in perf stat on
default. It will only be turned on when this option is given in perf stat
command.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/builtin-stat.c | 19 +++++++++++++------
 tools/perf/util/evsel.c   | 19 ++++++++++++++-----
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index c0e9dfa3b3c2..c27521fb1aee 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -117,6 +117,7 @@ static volatile sig_atomic_t	child_pid			= -1;
 static int			detailed_run			=  0;
 static bool			transaction_run;
 static bool			topdown_run			= false;
+static bool			tpebs_recording			= false;
 static bool			smi_cost			= false;
 static bool			smi_reset			= false;
 static int			big_num_opt			=  -1;
@@ -677,9 +678,11 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	int err;
 	bool second_pass = false;
 
-	err = start_tpebs(&stat_config, evsel_list);
-	if (err < 0)
-		return err;
+	if (tpebs_recording) {
+		err = start_tpebs(&stat_config, evsel_list);
+		if (err < 0)
+			return err;
+	}
 
 	if (forks) {
 		if (evlist__prepare_workload(evsel_list, &target, argv, is_pipe, workload_exec_failed_signal) < 0) {
@@ -886,9 +889,11 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 
 	t1 = rdclock();
 
-	err = stop_tpebs();
-	if (err < 0)
-		return err;
+	if (tpebs_recording) {
+		err = stop_tpebs();
+		if (err < 0)
+			return err;
+	}
 
 	if (stat_config.walltime_run_table)
 		stat_config.walltime_run[run_idx] = t1 - t0;
@@ -1246,6 +1251,8 @@ static struct option stat_options[] = {
 		       "disable adding events for the metric threshold calculation"),
 	OPT_BOOLEAN(0, "topdown", &topdown_run,
 			"measure top-down statistics"),
+	OPT_BOOLEAN(0, "enable-tpebs-recording", &tpebs_recording,
+			"enable recording for tpebs when retire_latency required"),
 	OPT_UINTEGER(0, "td-level", &stat_config.topdown_level,
 			"Set the metrics level for the top-down statistics (0: max level)"),
 	OPT_BOOLEAN(0, "smi-cost", &smi_cost,
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4d700338fc99..e1f3f63dfb54 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1540,21 +1540,30 @@ static int evsel__set_retire_lat(struct evsel *evsel, int cpu_map_idx, int threa
 		}
 	}
 
-	if (!found)
-		return -1;
+	/* Set ena and run to non-zero */
+	count->ena = count->run = 1;
+	count->lost = 0;
+
+	if (!found) {
+		/*
+		 * Set default value or 0 when retire_latency for this event is
+		 * not found from sampling data (enable_tpebs_recording not set
+		 * or 0 sample recorded).
+		 */
+		val = 0;
+		return 0;
+	}
 
 	/*
 	 * Only set retire_latency value to the first CPU and thread.
 	 */
 	if (cpu_map_idx == 0 && thread == 0)
+	/* Lost precision when casting from double to __u64. Any improvement? */
 		val = t->val;
 	else
 		val = 0;
 
 	count->val = val;
-	/* Set ena and run to non-zero */
-	count->ena = count->run = 1;
-	count->lost = 0;
 	return 0;
 }
 
-- 
2.43.0

