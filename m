Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z1eDBONb"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA21123;
	Tue, 12 Dec 2023 15:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702422256; x=1733958256;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aE77fMweebFjQP55AyGmMphhXJmvS2gbmOLgQJ472SQ=;
  b=Z1eDBONbI+gXuHrsPi1hvr8Lw2xmH6qfO5CQi3UGAnOReeQLezY5wLc7
   TJDowqd3T3Oi1nyDELzCRy4VROM/uBmPyQ/PwwrbLQcuk6EJ7aEpSwR6h
   xzbGmHzllITYcJxeFyGoI0ePtKyaSaogBi7Tk2EvwAKqPeiPOmn50BSbD
   ivF+TI5Y/jHTKP0xMY1pudtqVwIOm1OGcvRurE2zk+ixD5M4SfIwAVm0U
   98Lyjg8flch9Sse/+iuHEM01jM/kLB3R8sT6nXMV2ngPca7F2yqyjBKro
   wvSFMifyd7xyAivzykcrjaIhOxgXEctHpw1Pjs+VzTMbqXCmoKCUwAZKJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="392056068"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="392056068"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 15:03:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="864392058"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="864392058"
Received: from node-10329.jf.intel.com ([10.54.34.22])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Dec 2023 15:03:01 -0800
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Yang Jihong <yangjihong1@huawei.com>
Subject: [RFC PATCH v3 18/18] perf stat: Add hardware-grouping cmd option to perf stat
Date: Tue, 12 Dec 2023 15:02:24 -0800
Message-Id: <20231212230224.1473300-20-weilin.wang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231212230224.1473300-1-weilin.wang@intel.com>
References: <20231212230224.1473300-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

Add a cmd option to allow user to choose this new metric grouping method.

$ perf stat -M TopdownL1 -a --hardware-grouping

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/builtin-stat.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a7a8018c3511..2f9fe54248a3 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1256,6 +1256,8 @@ static struct option stat_options[] = {
 		       "don't try to share events between metrics in a group"),
 	OPT_BOOLEAN(0, "metric-no-threshold", &stat_config.metric_no_threshold,
 		       "don't try to share events between metrics in a group  "),
+	OPT_BOOLEAN(0, "hardware-grouping", &stat_config.hardware_aware_grouping,
+				"Use hardware aware metric grouping method"),
 	OPT_BOOLEAN(0, "topdown", &topdown_run,
 			"measure top-down statistics"),
 	OPT_UINTEGER(0, "td-level", &stat_config.topdown_level,
@@ -2506,9 +2508,6 @@ int cmd_stat(int argc, const char **argv)
 					(const char **) stat_usage,
 					PARSE_OPT_STOP_AT_NON_OPTION);
 
-	/* Set hardware_aware_grouping to false on default before completely enable it.*/
-	stat_config.hardware_aware_grouping = false;
-
 	if (stat_config.csv_sep) {
 		stat_config.csv_output = true;
 		if (!strcmp(stat_config.csv_sep, "\\t"))
-- 
2.39.3

