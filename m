Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04D13BBD2;
	Wed, 15 May 2024 05:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715751896; cv=none; b=GJVZeaIShk3iCr1WQ92MzEEmSwS0pxBcHMN9KTpXixwigLsER0YLKqfTNJStWpQrhHEJCR6jXI/2vLP83AuGo3SjMDF0SPLO3aC2dvPRg1xz+FeqNveGGPHdLyWJcJafrOeoNfTOjRNrL3TGSOG87jtXjoKejgnEXxVFDNCF5iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715751896; c=relaxed/simple;
	bh=J3EPEai9JG51kmaSvvkxK+v6koUxBtqhC0FlZhp4o2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SluMnYYr108MoYwLXT01naQL4ITL8IxrodmLw1K0mehyoXGX+GqkAeJkPWQyYL1OB5eHCcpIVFEgOpJJNZRHtBhmhE3cWsh/8oamA70rj02J2lSZ8EWlPizEuHIkkh1Ri/8t6+QpoFnUH686zsPvpwg687q4JDFFeGlq32mibTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MdAc2Qbn; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MdAc2Qbn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715751894; x=1747287894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J3EPEai9JG51kmaSvvkxK+v6koUxBtqhC0FlZhp4o2Y=;
  b=MdAc2QbnHU6UAYxOYk0rPTpbLAp1HkSe/iGGaut+egcSnP8lJ8y6rCql
   fulXYw+8M6P+yLb6NGU30+kJu6w3nCMfsmJUyW5oO+nxnQT5cyFukMQGV
   bp7J//V8lPn6BGH3Wrr1azBo8KdEUVySR8/pZCKKLwkmuwS8dSowZxvno
   Hqsf789Hei8ZZ+LtVSt5oWV2/KAmT17WijAdEEmlSJngYKLa4MGRUHqrS
   rfmblTdtkU++bmoELrpysZ+5LeHs+eb8kIIHRGqXb2fjglkawKpzUVFbv
   FRMMl0zGDgYVJdJ7bdsrsXYx9qI2Lk5rbWKuiAMF30EKuOjY2zvB0GQCn
   A==;
X-CSE-ConnectionGUID: WtN77l9XQy6IIfHfsV+1HA==
X-CSE-MsgGUID: HDGfK/eMTUiz4iOAtoZsyA==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="29298040"
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="29298040"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 22:44:52 -0700
X-CSE-ConnectionGUID: w3IXnKMOSYuAZUxMFX5EKw==
X-CSE-MsgGUID: v58UMcY3SNCuOjp9p06ZUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="35469212"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa003.fm.intel.com with ESMTP; 14 May 2024 22:44:51 -0700
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
Subject: [RFC PATCH v8 5/7] perf stat: Add retire latency print functions to print out at the very end of print out
Date: Wed, 15 May 2024 01:44:27 -0400
Message-ID: <20240515054443.2824147-6-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240515054443.2824147-1-weilin.wang@intel.com>
References: <20240515054443.2824147-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

Add print out functions so that users could read retire latency values.

Example output:

 Performance counter stats for 'system wide':

            25,717      MEM_INST_RETIRED.SPLIT_STORES    #      2.2 %  tma_split_stores
        28,365,080      CPU_CLK_UNHALTED.THREAD
             24.00      MEM_INST_RETIRED.SPLIT_STORES:R  #       96        4

       2.054365083 seconds time elapsed

This output of retire latency data is in format:
 <val> <event-name:R> # <sum> <count>.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 69 ++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index bfc1d705f437..b9c3978cc99c 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -21,6 +21,7 @@
 #include "iostat.h"
 #include "pmu.h"
 #include "pmus.h"
+#include "intel-tpebs.h"
 
 #define CNTR_NOT_SUPPORTED	"<not supported>"
 #define CNTR_NOT_COUNTED	"<not counted>"
@@ -34,6 +35,7 @@
 #define COMM_LEN     16
 #define PID_LEN       7
 #define CPUS_LEN      4
+#define RETIRE_LEN    8
 
 static int aggr_header_lens[] = {
 	[AGGR_CORE] 	= 18,
@@ -426,6 +428,71 @@ static void print_metric_std(struct perf_stat_config *config,
 	fprintf(out, " %-*s", METRIC_LEN - n - 1, unit);
 }
 
+static void print_retire_lat_std(struct perf_stat_config *config,
+				 struct outstate *os)
+{
+	FILE *out = os->fh;
+	bool newline = os->newline;
+	struct tpebs_retire_lat *t;
+	struct list_head *retire_lats = &config->tpebs_results;
+
+	list_for_each_entry(t, retire_lats, nd) {
+		if (newline)
+			do_new_line_std(config, os);
+		fprintf(out, "%'*.2f ", COUNTS_LEN, t->val);
+		/* For print alignment */
+		fprintf(out, "%-*s ", config->unit_width, "");
+		fprintf(out, "%-*s", EVNAME_LEN, t->tpebs_name);
+		fprintf(out, " # ");
+		fprintf(out, "%*d %*ld\n", RETIRE_LEN, t->sum,
+			 RETIRE_LEN, t->count);
+	}
+}
+
+static void print_retire_lat_csv(struct perf_stat_config *config,
+				 struct outstate *os)
+{
+	FILE *out = os->fh;
+	struct tpebs_retire_lat *t;
+	struct list_head *retire_lats = &config->tpebs_results;
+	const char *sep = config->csv_sep;
+
+	list_for_each_entry(t, retire_lats, nd) {
+		fprintf(out, "%f%s%s%s%s%ld%s%d\n", t->val, sep, sep, t->tpebs_name, sep,
+			t->count, sep, t->sum);
+	}
+}
+
+static void print_retire_lat_json(struct perf_stat_config *config,
+				  struct outstate *os)
+{
+	FILE *out = os->fh;
+	struct tpebs_retire_lat *t;
+	struct list_head *retire_lats = &config->tpebs_results;
+
+	fprintf(out, "{");
+	list_for_each_entry(t, retire_lats, nd) {
+		fprintf(out, "\"retire_latency-value\" : \"%f\", ", t->val);
+		fprintf(out, "\"name\" : \"%s\"", t->tpebs_name);
+		fprintf(out, "\"sample-counts\" : \"%ld\"", t->count);
+		fprintf(out, "\"retire_latency-sum\" : \"%d\"", t->sum);
+	}
+	fprintf(out, "}");
+}
+
+static void print_retire_lat(struct perf_stat_config *config,
+			     struct outstate *os)
+{
+	if (!&config->tpebs_results)
+		return;
+	if (config->json_output)
+		print_retire_lat_json(config, os);
+	else if (config->csv_output)
+		print_retire_lat_csv(config, os);
+	else
+		print_retire_lat_std(config, os);
+}
+
 static void new_line_csv(struct perf_stat_config *config, void *ctx)
 {
 	struct outstate *os = ctx;
@@ -1609,6 +1676,8 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 		break;
 	}
 
+	print_retire_lat(config, &os);
+
 	print_footer(config);
 
 	fflush(config->output);
-- 
2.43.0

