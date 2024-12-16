Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CCD1CF2B7;
	Mon, 16 Dec 2024 07:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734332584; cv=none; b=ajqrdfC2WM9MG6fojGv40Y87U3ppON/5yNkf6hrJ+RX15/XuNI+IRZIt1DnekfVjnP60f1J3Ns8OnuVl9eAckCyiOw0ZWApPUbkdOItmBNEKyBrphFilpdeRUuLl76b9dnBdHdCB0MSuknkVh/ScuehcqPoy/QIq0kZC7jYO9oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734332584; c=relaxed/simple;
	bh=hGXtbC2kXLju90jhkx+dUZyJS3igeALnzz5njbMIUBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAPYED/GS6C2yPOvGAXpZFbODosY4FfYypz4FF6aX1BoKq+NW/BxdgpgBD4Wr3lx3V1/S15C6FtBqjg9TjS2UyWJA7p5PcCvPvBszTNyKcvqbsUFtP69EVGGeXAy5kHeFRuo5uq6SqsmYRu6UwfphofZ9X0xjfMTTN04yPLmkCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XR4AprXh; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XR4AprXh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734332583; x=1765868583;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hGXtbC2kXLju90jhkx+dUZyJS3igeALnzz5njbMIUBA=;
  b=XR4AprXhPlZBNmGxLM3ZkE9sXjBbA48nbJaHoR8dTlTv2aU9us85oZj6
   aTddCdLjrZq/D2XrsIsrQvIfqCkiyEnE5lRczABmaGtZw+S6k1Y8U4oa1
   wHdx/r9PcTIayA7CSBsYUkSiU5+/wvKEZLNCYpkdKcmyvtlQNIFiMs/4G
   Q+hkP/jQluZVR+fbuomxkJcdDVRf9XnGYnIBdw0Pb3ZW1E2eSV+FUyg3p
   oMT81Om1k48v0D4KJB7lBqLXAteAFNM35awlotiOnbfG9bd/f8ec/j58m
   cFfcF80dDU+ug4gmJg7txAVbp5HntyxsfqQQb6xOv8ydfxWa/UhHIGw+u
   w==;
X-CSE-ConnectionGUID: /dOXQOZkQLu+tQQLOpekfg==
X-CSE-MsgGUID: /qg9xU3JQvuIqijRRbvCDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34584259"
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="34584259"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 23:03:03 -0800
X-CSE-ConnectionGUID: gasiNmCbTO+zPQgqmBW0EQ==
X-CSE-MsgGUID: VMlvR/boTz6sd/BmBqKz/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101258680"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.ger.corp.intel.com) ([10.245.115.59])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 23:03:00 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Leo Yan <leo.yan@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V16 2/7] perf tools: Add aux-action config term
Date: Mon, 16 Dec 2024 09:02:38 +0200
Message-ID: <20241216070244.14450-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216070244.14450-1-adrian.hunter@intel.com>
References: <20241216070244.14450-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Add a new common config term "aux-action" to use for configuring AUX area
trace pause / resume. The value is a string that will be parsed in a
subsequent patch.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Ian Rogers <irogers@google.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---


Changes in V7:

	Add aux-action to perf_pmu__for_each_format


 tools/perf/util/evsel.c        |  2 ++
 tools/perf/util/evsel_config.h |  1 +
 tools/perf/util/parse-events.c | 10 ++++++++++
 tools/perf/util/parse-events.h |  1 +
 tools/perf/util/parse-events.l |  1 +
 tools/perf/util/pmu.c          |  1 +
 6 files changed, 16 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index c93311e502cf..a17404b8d0c8 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1151,6 +1151,8 @@ static void evsel__apply_config_terms(struct evsel *evsel,
 		case EVSEL__CONFIG_TERM_AUX_OUTPUT:
 			attr->aux_output = term->val.aux_output ? 1 : 0;
 			break;
+		case EVSEL__CONFIG_TERM_AUX_ACTION:
+			break;
 		case EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE:
 			/* Already applied by auxtrace */
 			break;
diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_config.h
index aee6f808b512..af52a1516d0b 100644
--- a/tools/perf/util/evsel_config.h
+++ b/tools/perf/util/evsel_config.h
@@ -25,6 +25,7 @@ enum evsel_term_type {
 	EVSEL__CONFIG_TERM_BRANCH,
 	EVSEL__CONFIG_TERM_PERCORE,
 	EVSEL__CONFIG_TERM_AUX_OUTPUT,
+	EVSEL__CONFIG_TERM_AUX_ACTION,
 	EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE,
 	EVSEL__CONFIG_TERM_CFG_CHG,
 };
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 7fc1c36ef2a4..1e23faa364b1 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -793,6 +793,7 @@ const char *parse_events__term_type_str(enum parse_events__term_type term_type)
 		[PARSE_EVENTS__TERM_TYPE_DRV_CFG]		= "driver-config",
 		[PARSE_EVENTS__TERM_TYPE_PERCORE]		= "percore",
 		[PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT]		= "aux-output",
+		[PARSE_EVENTS__TERM_TYPE_AUX_ACTION]		= "aux-action",
 		[PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE]	= "aux-sample-size",
 		[PARSE_EVENTS__TERM_TYPE_METRIC_ID]		= "metric-id",
 		[PARSE_EVENTS__TERM_TYPE_RAW]                   = "raw",
@@ -842,6 +843,7 @@ config_term_avail(enum parse_events__term_type term_type, struct parse_events_er
 	case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
 	case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
 	case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
+	case PARSE_EVENTS__TERM_TYPE_AUX_ACTION:
 	case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
 	case PARSE_EVENTS__TERM_TYPE_RAW:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
@@ -961,6 +963,9 @@ do {									   \
 	case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
 		CHECK_TYPE_VAL(NUM);
 		break;
+	case PARSE_EVENTS__TERM_TYPE_AUX_ACTION:
+		CHECK_TYPE_VAL(STR);
+		break;
 	case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
 		CHECK_TYPE_VAL(NUM);
 		if (term->val.num > UINT_MAX) {
@@ -1078,6 +1083,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
 	case PARSE_EVENTS__TERM_TYPE_NOOVERWRITE:
 	case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
+	case PARSE_EVENTS__TERM_TYPE_AUX_ACTION:
 	case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
 		return config_term_common(attr, term, err);
 	case PARSE_EVENTS__TERM_TYPE_USER:
@@ -1213,6 +1219,9 @@ do {								\
 			ADD_CONFIG_TERM_VAL(AUX_OUTPUT, aux_output,
 					    term->val.num ? 1 : 0, term->weak);
 			break;
+		case PARSE_EVENTS__TERM_TYPE_AUX_ACTION:
+			ADD_CONFIG_TERM_STR(AUX_ACTION, term->val.str, term->weak);
+			break;
 		case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
 			ADD_CONFIG_TERM_VAL(AUX_SAMPLE_SIZE, aux_sample_size,
 					    term->val.num, term->weak);
@@ -1275,6 +1284,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
 		case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
 		case PARSE_EVENTS__TERM_TYPE_PERCORE:
 		case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
+		case PARSE_EVENTS__TERM_TYPE_AUX_ACTION:
 		case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
 		case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
 		case PARSE_EVENTS__TERM_TYPE_RAW:
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 3f4334ec6231..e176a34ab088 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -74,6 +74,7 @@ enum parse_events__term_type {
 	PARSE_EVENTS__TERM_TYPE_DRV_CFG,
 	PARSE_EVENTS__TERM_TYPE_PERCORE,
 	PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT,
+	PARSE_EVENTS__TERM_TYPE_AUX_ACTION,
 	PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE,
 	PARSE_EVENTS__TERM_TYPE_METRIC_ID,
 	PARSE_EVENTS__TERM_TYPE_RAW,
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 14e5bd856a18..bf7f73548605 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -321,6 +321,7 @@ overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_OVERWRITE); }
 no-overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOOVERWRITE); }
 percore			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_PERCORE); }
 aux-output		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
+aux-action		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_ACTION); }
 aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
 metric-id		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_METRIC_ID); }
 cpu-cycles|cycles				{ return hw_term(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 891c905d08a1..6206c8fe2bf9 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1773,6 +1773,7 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_call
 		"no-overwrite",
 		"percore",
 		"aux-output",
+		"aux-action=(pause|resume|start-paused)",
 		"aux-sample-size=number",
 	};
 	struct perf_pmu_format *format;
-- 
2.43.0

