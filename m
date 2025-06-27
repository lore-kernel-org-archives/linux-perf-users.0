Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61A91FE455
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 20:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751055509; cv=none; b=tqkFngWyj9z+sXNjfFuvXMdnMGOT0A8vtN6dp3TPZam8DVZ8QMDtsomBYSo47rEiO1KULF2KRsejbNh1yDHqq7UHTx7ISUS+17jYraUTT5ZDY0wHWZR7DP8J2vvgkZtSKFlRSs+b31A3zlFjox/WZddf+b9baaudsCKc2jVQ+HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751055509; c=relaxed/simple;
	bh=G7F0DcmwVh/tviwW6A2dHXA6/b277Jcy2hQjOKJ+Rzc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eGllE1uIktSR/TI3Spexh6CZsS72yC9sPKm6i6Is7k4X0qjoY9RS/X690AeonAg8evAQanA3ggBkZV5SGCLPCjUHO+L9oxctJA810UV+O9le6e2n2HSUp8TXy7chlTYff0e0ywIy/K8tQ5rEPUMnLBpWl9uPRca/zhxXAKVb1x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w3ZyDFzw; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w3ZyDFzw"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-740270e168aso2379137b3a.1
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 13:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751055507; x=1751660307; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NahqSEdHMNEK/vjgQjUji3mOM+Y9TAZbBy8PoHtafsY=;
        b=w3ZyDFzwaUnoJIY94UHVDzc+v755N0XiMqRMVcfmfPn5E38WkTQ4SgA4KyVeuhEfKV
         T4rHLzxSkb/JqJrRlNs7TpPo0QgC5HEwdiFjnkBgRzp5OCMR6obRrUBzkWfXLqYz2Pvb
         PfGNi8yuYcAuec54RaODsEese+I/4foECq6DwUGwYhnarcUYckDdzUn445MMo7w7vzpB
         1dFp3aR8EaM4B+9f3UhHIj0l4xSuOQ1XGDhJ+9uHwlDiEYyzCQG8KdXE7HSf7EP5oPvX
         rh6V88/3VkkwmPpDGV5wA+14cZsSLx0uMaVMMNImVtXtykolZS8jJ9j09JU2mJxt6MZb
         tjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751055507; x=1751660307;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NahqSEdHMNEK/vjgQjUji3mOM+Y9TAZbBy8PoHtafsY=;
        b=IOxm7PskNzKh6HJAv18pd60UwuHUlxCTk0Y3UDCVInD7Gpv4xk4naswhplQNinIgDP
         Lk+gkYruXV3H6Ke23u4SfAfUvOn42HFrPr2ScqxpQU15bS5Z5wy+eY8SqTaK7dsJ8PSE
         jax/r4PKqR1ObDDARFoGVWQeMovfNbhwbH1rdV2YwcW6fYvaS8wjJ8TbcDwU6/DVUxSx
         +2pz5PhBsjl0cjQf5tuvEpz2QALBT/hbpsBEK15RN7xgiGpKaNlm9crIFbfVafwFvIey
         G4UKlu6W7/vyP0HIK3W5Cl8AagtUyfG0Pba7b+xlbrBSRGCdYJ9lW8QiHZ4hJbXho6SF
         oMhg==
X-Forwarded-Encrypted: i=1; AJvYcCWw+8AIfw81XM1odxD6t3JGFm2n8i/wogyqTNiTHZwxIWjKtmQLWG13vCd76Vtg30BRpKehnZvjEaxErl3VUirB@vger.kernel.org
X-Gm-Message-State: AOJu0YyCEP6CcHjoxnVba81zWk+j1lM0xNJQrsSrm4wGzsYAgo7C9d08
	R11S3CbnKDPpTVSNvy37mFFAiEivuSmSWamvruc5EjnK92035pCyH3Tx1k1JjNqCH6GgeguRdc7
	zJBW6Sg==
X-Google-Smtp-Source: AGHT+IERa3xyQGzXWP8szN7hcZv+eUzRuURmnj9SiLw0CJhbkivmmmcbEQpuNU9TWU7ulwjAeXoBO2hKsaU=
X-Received: from pgcj26.prod.google.com ([2002:a05:6a02:501a:b0:b2c:4548:13d0])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:2d4c:b0:220:5c12:efa3
 with SMTP id adf61e73a8af0-220a17fa94fmr6287859637.38.1751055506931; Fri, 27
 Jun 2025 13:18:26 -0700 (PDT)
Date: Fri, 27 Jun 2025 13:16:41 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627201818.479421-1-ctshao@google.com>
Subject: [PATCH v4] perf stat: Fix uncore aggregation number
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, Ian Rogers <irogers@google.com>, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, weilin.wang@intel.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Follow up:
lore.kernel.org/CAP-5=fVDF4-qYL1Lm7efgiHk7X=_nw_nEFMBZFMcsnOOJgX4Kg@mail.gmail.com/

The patch adds unit aggregation during evsel merge the aggregated uncore
counters. Change the name of the column to `ctrs` and `counters` for
json mode.

Tested on a 2-socket machine with SNC3, uncore_imc_[0-11] and
cpumask="0,120"
Before:
  perf stat -e clockticks -I 1000 --per-socket
  #           time socket cpus             counts unit events
       1.001085024 S0        1         9615386315      clockticks
       1.001085024 S1        1         9614287448      clockticks
  perf stat -e clockticks -I 1000 --per-node
  #           time node   cpus             counts unit events
       1.001029867 N0        1         3205726984      clockticks
       1.001029867 N1        1         3205444421      clockticks
       1.001029867 N2        1         3205234018      clockticks
       1.001029867 N3        1         3205224660      clockticks
       1.001029867 N4        1         3205207213      clockticks
       1.001029867 N5        1         3205528246      clockticks
After:
  perf stat -e clockticks -I 1000 --per-socket
  #           time socket ctrs             counts unit events
       1.001026071 S0       12         9619677996      clockticks
       1.001026071 S1       12         9618612614      clockticks
  perf stat -e clockticks -I 1000 --per-node
  #           time node   ctrs             counts unit events
       1.001027449 N0        4         3207251859      clockticks
       1.001027449 N1        4         3207315930      clockticks
       1.001027449 N2        4         3206981828      clockticks
       1.001027449 N3        4         3206566126      clockticks
       1.001027449 N4        4         3206032609      clockticks
       1.001027449 N5        4         3205651355      clockticks

Tested with JSON output linter:
  perf test "perf stat JSON output linter"
   94: perf stat JSON output linter                                    : Ok

Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
v4:
  Modify perf-stat.txt and json output lint test

v3: https://lore.kernel.org/20250624221545.1711008-1-ctshao@google.com/
  Rename the column to `ctrs` and `counters` in json mode.

v2: https://lore.kernel.org/20250612225324.3315450-1-ctshao@google.com/
  Rename the column to `aggr_nr`.
  Remove unnecessary comment.

v1: https://lore.kernel.org/20250611233239.3098064-1-ctshao@google.com/


 tools/perf/Documentation/perf-stat.txt        |  6 ++--
 .../tests/shell/lib/perf_json_output_lint.py  |  4 +--
 tools/perf/util/stat-display.c                | 34 +++++++++----------
 tools/perf/util/stat.c                        |  2 +-
 4 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 61d091670dee..1a766d4a2233 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -640,18 +640,20 @@ JSON FORMAT
 With -j, perf stat is able to print out a JSON format output
 that can be used for parsing.

-- timestamp : optional usec time stamp in fractions of second (with -I)
+- interval : optional timestamp in fractions of second (with -I)
 - optional aggregate options:
 		- core : core identifier (with --per-core)
 		- die : die identifier (with --per-die)
 		- socket : socket identifier (with --per-socket)
 		- node : node identifier (with --per-node)
 		- thread : thread identifier (with --per-thread)
+- counters : number of aggregated PMU counters
 - counter-value : counter value
 - unit : unit of the counter value or empty
 - event : event name
 - variance : optional variance if multiple values are collected (with -r)
-- runtime : run time of counter
+- event-runtime : run time of the event
+- pcnt-running : percentage of time the event was running
 - metric-value : optional metric value
 - metric-unit : optional unit of metric

diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
index 9e772a89ce38..c6750ef06c0f 100644
--- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
+++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
@@ -45,7 +45,7 @@ def is_counter_value(num):

 def check_json_output(expected_items):
   checks = {
-      'aggregate-number': lambda x: isfloat(x),
+      'counters': lambda x: isfloat(x),
       'core': lambda x: True,
       'counter-value': lambda x: is_counter_value(x),
       'cgroup': lambda x: True,
@@ -75,7 +75,7 @@ def check_json_output(expected_items):
       if count not in expected_items and count >= 1 and count <= 7 and 'metric-value' in item:
         # Events that generate >1 metric may have isolated metric
         # values and possibly other prefixes like interval, core,
-        # aggregate-number, or event-runtime/pcnt-running from multiplexing.
+        # counters, or event-runtime/pcnt-running from multiplexing.
         pass
       elif count not in expected_items and count >= 1 and count <= 5 and 'metricgroup' in item:
         pass
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 729ad5cd52cb..9cb5245a92aa 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -50,15 +50,15 @@ static int aggr_header_lens[] = {
 };

 static const char *aggr_header_csv[] = {
-	[AGGR_CORE] 	= 	"core,cpus,",
-	[AGGR_CACHE]	= 	"cache,cpus,",
-	[AGGR_CLUSTER]	= 	"cluster,cpus,",
-	[AGGR_DIE] 	= 	"die,cpus,",
-	[AGGR_SOCKET] 	= 	"socket,cpus,",
-	[AGGR_NONE] 	= 	"cpu,",
-	[AGGR_THREAD] 	= 	"comm-pid,",
-	[AGGR_NODE] 	= 	"node,",
-	[AGGR_GLOBAL] 	=	""
+	[AGGR_CORE]	=	"core,ctrs,",
+	[AGGR_CACHE]	=	"cache,ctrs,",
+	[AGGR_CLUSTER]	=	"cluster,ctrs,",
+	[AGGR_DIE]	=	"die,ctrs,",
+	[AGGR_SOCKET]	=	"socket,ctrs,",
+	[AGGR_NONE]	=	"cpu,",
+	[AGGR_THREAD]	=	"comm-pid,",
+	[AGGR_NODE]	=	"node,",
+	[AGGR_GLOBAL]	=	""
 };

 static const char *aggr_header_std[] = {
@@ -304,7 +304,7 @@ static void print_aggr_id_std(struct perf_stat_config *config,
 		return;
 	}

-	fprintf(output, "%-*s %*d ", aggr_header_lens[idx], buf, 4, aggr_nr);
+	fprintf(output, "%-*s %*d ", aggr_header_lens[idx], buf, /*strlen("ctrs")*/ 4, aggr_nr);
 }

 static void print_aggr_id_csv(struct perf_stat_config *config,
@@ -366,27 +366,27 @@ static void print_aggr_id_json(struct perf_stat_config *config, struct outstate
 {
 	switch (config->aggr_mode) {
 	case AGGR_CORE:
-		json_out(os, "\"core\" : \"S%d-D%d-C%d\", \"aggregate-number\" : %d",
+		json_out(os, "\"core\" : \"S%d-D%d-C%d\", \"counters\" : %d",
 			id.socket, id.die, id.core, aggr_nr);
 		break;
 	case AGGR_CACHE:
-		json_out(os, "\"cache\" : \"S%d-D%d-L%d-ID%d\", \"aggregate-number\" : %d",
+		json_out(os, "\"cache\" : \"S%d-D%d-L%d-ID%d\", \"counters\" : %d",
 			id.socket, id.die, id.cache_lvl, id.cache, aggr_nr);
 		break;
 	case AGGR_CLUSTER:
-		json_out(os, "\"cluster\" : \"S%d-D%d-CLS%d\", \"aggregate-number\" : %d",
+		json_out(os, "\"cluster\" : \"S%d-D%d-CLS%d\", \"counters\" : %d",
 			id.socket, id.die, id.cluster, aggr_nr);
 		break;
 	case AGGR_DIE:
-		json_out(os, "\"die\" : \"S%d-D%d\", \"aggregate-number\" : %d",
+		json_out(os, "\"die\" : \"S%d-D%d\", \"counters\" : %d",
 			id.socket, id.die, aggr_nr);
 		break;
 	case AGGR_SOCKET:
-		json_out(os, "\"socket\" : \"S%d\", \"aggregate-number\" : %d",
+		json_out(os, "\"socket\" : \"S%d\", \"counters\" : %d",
 			id.socket, aggr_nr);
 		break;
 	case AGGR_NODE:
-		json_out(os, "\"node\" : \"N%d\", \"aggregate-number\" : %d",
+		json_out(os, "\"node\" : \"N%d\", \"counters\" : %d",
 			id.node, aggr_nr);
 		break;
 	case AGGR_NONE:
@@ -1317,7 +1317,7 @@ static void print_header_interval_std(struct perf_stat_config *config,
 	case AGGR_CLUSTER:
 	case AGGR_CACHE:
 	case AGGR_CORE:
-		fprintf(output, "#%*s %-*s cpus",
+		fprintf(output, "#%*s %-*s ctrs",
 			INTERVAL_LEN - 1, "time",
 			aggr_header_lens[config->aggr_mode],
 			aggr_header_std[config->aggr_mode]);
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 355a7d5c8ab8..b0205e99a4c9 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -526,7 +526,7 @@ static int evsel__merge_aggr_counters(struct evsel *evsel, struct evsel *alias)
 		struct perf_counts_values *aggr_counts_a = &ps_a->aggr[i].counts;
 		struct perf_counts_values *aggr_counts_b = &ps_b->aggr[i].counts;

-		/* NB: don't increase aggr.nr for aliases */
+		ps_a->aggr[i].nr += ps_b->aggr[i].nr;

 		aggr_counts_a->val += aggr_counts_b->val;
 		aggr_counts_a->ena += aggr_counts_b->ena;
--
2.50.0.727.gbf7dc18ff4-goog

