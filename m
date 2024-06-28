Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD71A13E403;
	Fri, 28 Jun 2024 06:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719557538; cv=none; b=pxfszOUcQvw4OchAmzTPZQTSSjaLOIkxMFyDzdDyClRKCGTvhNwyrRyyzTGz6JoDfVD3X+IyTeLgQ6uSsBJFyHrdumXgci2TrW1FN2kbY865BsjHZ/sJZQDvBRtKjNipWvO31z3o1ykxxnlvH3MfykiH7Xf7ojTMNWEtcjQ22aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719557538; c=relaxed/simple;
	bh=ziXFzRGwo/+zTeI/4FcZKsEy33cRsKrE2hxLi6BQFH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DQ6LaUm+JiPEx8Gcmov8henmyWDtu9DfDceZMLUYCdX0JzlIv2/WZbuvr6NDNkBJUGOfU1gUsF/NwHq8bcNRJVoZ1gb10JxRbwgzFlqlA5jbn2PjYAtZIkrhD/LdTPVmZjn12m9t6g8SDwlxlKfclHsvC2RUnmMBsjfC1dVrSq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jbKdrcCB; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jbKdrcCB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719557537; x=1751093537;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ziXFzRGwo/+zTeI/4FcZKsEy33cRsKrE2hxLi6BQFH0=;
  b=jbKdrcCBSkuHQ/9xVuBhvw1v4xl/iO0fWIwrWFt/vSKP3x6ilFPH+TbA
   eDVmk3v4djo2JPj8F84EYTFL9VhFTmjA1KtCfA3GSQsdzKVf7Voa4XpTH
   BkcozrB0J4W+c1HRMA8UzFu1Nmu3WaO3ueYEKSdR5BGS7MV+plt9CgIBs
   nTVVQOaHjkWcQbKra+KB1Kd8VAf6U77ta/1ydul/cXllFTQxDE9wSj4ps
   qrM7TxIBQ4trfPcr3M5e/tnH5k85MHGdqSYwz8V6MKvEFVQ4PRaARUfrJ
   Mq+NsDd307gtpU//UKWFK4XG+bDGFwFqgFboUm4g7+04yJY4v0+I+t0bR
   A==;
X-CSE-ConnectionGUID: 43jkkbm8SzWnw0rFgvzJnw==
X-CSE-MsgGUID: qvzzlc9YRdm8OPs30WxbsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16857213"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="16857213"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 23:52:17 -0700
X-CSE-ConnectionGUID: Yq7c8e14TpOiojDaydIrog==
X-CSE-MsgGUID: mMsEsriyS6Kl2/sATxtMtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="75386714"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.246.49.253])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 23:52:10 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V8 07/12] perf tools: Add aux-action config term
Date: Fri, 28 Jun 2024 09:51:06 +0300
Message-Id: <20240628065111.59718-8-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628065111.59718-1-adrian.hunter@intel.com>
References: <20240628065111.59718-1-adrian.hunter@intel.com>
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
index bc603193c477..909a928413a2 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1016,6 +1016,8 @@ static void evsel__apply_config_terms(struct evsel *evsel,
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
index 321586fb5556..790431dfa594 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -799,6 +799,7 @@ static const char *config_term_name(enum parse_events__term_type term_type)
 		[PARSE_EVENTS__TERM_TYPE_DRV_CFG]		= "driver-config",
 		[PARSE_EVENTS__TERM_TYPE_PERCORE]		= "percore",
 		[PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT]		= "aux-output",
+		[PARSE_EVENTS__TERM_TYPE_AUX_ACTION]		= "aux-action",
 		[PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE]	= "aux-sample-size",
 		[PARSE_EVENTS__TERM_TYPE_METRIC_ID]		= "metric-id",
 		[PARSE_EVENTS__TERM_TYPE_RAW]                   = "raw",
@@ -848,6 +849,7 @@ config_term_avail(enum parse_events__term_type term_type, struct parse_events_er
 	case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
 	case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
 	case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
+	case PARSE_EVENTS__TERM_TYPE_AUX_ACTION:
 	case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
 	case PARSE_EVENTS__TERM_TYPE_RAW:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
@@ -967,6 +969,9 @@ do {									   \
 	case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
 		CHECK_TYPE_VAL(NUM);
 		break;
+	case PARSE_EVENTS__TERM_TYPE_AUX_ACTION:
+		CHECK_TYPE_VAL(STR);
+		break;
 	case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
 		CHECK_TYPE_VAL(NUM);
 		if (term->val.num > UINT_MAX) {
@@ -1084,6 +1089,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
 	case PARSE_EVENTS__TERM_TYPE_NOOVERWRITE:
 	case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
+	case PARSE_EVENTS__TERM_TYPE_AUX_ACTION:
 	case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
 		return config_term_common(attr, term, err);
 	case PARSE_EVENTS__TERM_TYPE_USER:
@@ -1219,6 +1225,9 @@ do {								\
 			ADD_CONFIG_TERM_VAL(AUX_OUTPUT, aux_output,
 					    term->val.num ? 1 : 0, term->weak);
 			break;
+		case PARSE_EVENTS__TERM_TYPE_AUX_ACTION:
+			ADD_CONFIG_TERM_STR(AUX_ACTION, term->val.str, term->weak);
+			break;
 		case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
 			ADD_CONFIG_TERM_VAL(AUX_SAMPLE_SIZE, aux_sample_size,
 					    term->val.num, term->weak);
@@ -1281,6 +1290,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
 		case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
 		case PARSE_EVENTS__TERM_TYPE_PERCORE:
 		case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
+		case PARSE_EVENTS__TERM_TYPE_AUX_ACTION:
 		case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
 		case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
 		case PARSE_EVENTS__TERM_TYPE_RAW:
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index e13de2c8b706..d0e253f127a8 100644
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
index 16045c383ada..31b6e028fee3 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -328,6 +328,7 @@ overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_OVERWRITE); }
 no-overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOOVERWRITE); }
 percore			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_PERCORE); }
 aux-output		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
+aux-action		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_ACTION); }
 aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
 metric-id		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_METRIC_ID); }
 cpu-cycles|cycles				{ return hw_term(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 05deea7724eb..1eded63fe9a8 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1712,6 +1712,7 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_call
 		"no-overwrite",
 		"percore",
 		"aux-output",
+		"aux-action=(pause|resume|start-paused)",
 		"aux-sample-size=number",
 	};
 	struct perf_pmu_format *format;
-- 
2.34.1

