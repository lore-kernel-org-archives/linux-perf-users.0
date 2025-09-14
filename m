Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DE42E1754
	for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 18:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757873506; cv=none; b=Rb1mQt9VrFJSL3e0HSMyz6LHJlvjxLkCR9djhZR8AmunGZ8XS9YmYQAUhDcNHSZ1Iu7ksixQB7ENBCzzq4sRr6SSmVWcGQSlfvR4pSlJbGlaOK0DCwSCFPR3pSnFb821ILAwy4q7XaQ6Jr0VwlQNsEtrtXUJ9phEL9sXvq4QXPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757873506; c=relaxed/simple;
	bh=ZHzdkkNJRj2L1n70dwrPlxvTFp0OF0POufp6EdGmBzM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s3na3aYQ0pBFwv+hi8O59Tmkv2LNkJX4UCjCzdnCQf+aGmapLZxNR255dhb04hmk1BSOdkZew5Icy0bBfqUTOLnF3YV80+bMhQlMONrlP7bUD683oJx8ht1Z5xcuqPved4UxFwXrdAIjiNYtNQK5fVvdLcnRWhGcGBvzicbubLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vD2HIGIj; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vD2HIGIj"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-26076dd11d1so14209405ad.0
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 11:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757873504; x=1758478304; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fRrDl1l101NMRllwDZen1k89p2rCs76WMhh8RSl6Ckg=;
        b=vD2HIGIjy+iZImSVgNRiMoLL5x4R/ATmra1ww0sPmoKL+yfBTZZu995doQ73+rbFD+
         OAKxrl0ML5jKCBJuAx/FYQmhxIh7unqXOKlaxpWc1oNveV/HQheECD99MVdjH6HE4UIB
         egEGMvg2zvVs5knr0yrFThP0NJHSoECHfn2CI/Yb0MvjtBKUTgm3WLUIFTg2Ez0VQHEt
         GgM7zycm0EgqkokXTu+j8iC+cio48xKGoEoga38xBtFTgiQfuSOaGx9URQ3FzXLwxKcp
         FqERhqGVHMqWpxjCtjq7qUKhp2T5aBt9cC6Eclhvj5Bp1rF3P1L9w66n2WnuOFPxxcut
         YklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757873504; x=1758478304;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fRrDl1l101NMRllwDZen1k89p2rCs76WMhh8RSl6Ckg=;
        b=DOdnG28BKKeQqf11RNND91KJaLuvwe+d5h7Y9qItTWa+QgHoOE4st2ZFZDXTCrO+xn
         vfilQTuTDUxp58JgGB7I1biyAlMQlC9ii45U2HD95j9p5/Z1VhfUm54NNpyGFoBG3eN6
         MRnMAO3Ja/Ek8pF2r8bhDycMVEzzzQ4hA/KfJxtR3Z1vvjl+Mk/9EJSUsXGjD6bl3A0P
         3YqiHLtqyHTDtx6i/Y4cLe59O/N1XuiuazveU9MGWRj8f3ekZBFnTjG4KnahMDHrbZ/1
         CiN7mGiczMNNGE2thBABSnTqeJRD9oCL6j53/Ts8XtvdgYuCktAN2Wzn3837B+xSGATH
         MGjw==
X-Forwarded-Encrypted: i=1; AJvYcCW9/ONYF/7k0oBbb/f662s+sHmtwRkusgZkZtrphSsiHgEyAqQWFdaXxaze1Fdl+1mZMaMqtIe/C1jDyskrNhS0@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ca10nny9Hfr6hXMTOWQ+cQVOV2gmS4Tk9nZphU5RSPFMY9JC
	tWFhfCKSLbUmAWrs8wYD0NFsoegJe2hnEc9gpWScj/cCew4luUO/C/NHU/tbjnVHkfpNhgvrqLp
	UvOTxHGVGwzemqJ+4o9NEYgOjn3P8BAbA3h7odsBCZme6/qitw0GUA4+tTyvSjepfXpz7Tou/+R
	E7YjG1
X-Google-Smtp-Source: AGHT+IGIhTXWqsOqk8ruGfjEpwdwwEfgkY95/AzCjPoQVWnB/vg48EgROjep4eZFPDP5/Fga3pG9W5TBbT02
X-Received: from plbmc12.prod.google.com ([2002:a17:903:2b0c:b0:25d:5de9:629c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f710:b0:248:79d4:93c0
 with SMTP id d9443c01a7336-25d2772a576mr129493455ad.56.1757873503863; Sun, 14
 Sep 2025 11:11:43 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:11:09 -0700
In-Reply-To: <20250914181121.1952748-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250914181121.1952748-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914181121.1952748-10-irogers@google.com>
Subject: [PATCH v4 09/21] perf parse-events: Add terms for legacy hardware and
 cache config values
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-ccpol: medium

Add the PMU terms legacy-hardware-config and
legacy-cache-config. These terms are similar to the config term in
that their values are assigned to the perf_event_attr config
value. They differ in that the PMU type is switched to be either
PERF_TYPE_HARDWARE or PERF_TYPE_HW_CACHE, and the PMU type is moved
into the extended type information of the config value. This will
allow later patches to add legacy events to json.

An example use of the terms is in the following:
```
$ perf stat -vv -e 'cpu/legacy-hardware-config=1/,cpu/legacy-cache-config=0x10001/' true
Using CPUID GenuineIntel-6-8D-1
Attempt to add: cpu/legacy-hardware-config=0x1/
..after resolving event: cpu/legacy-hardware-config=0x1/
Attempt to add: cpu/legacy-cache-config=0x10001/
..after resolving event: cpu/legacy-cache-config=0x10001/
Control descriptor is not initialized
------------------------------------------------------------
perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  size                             136
  config                           0x1 (PERF_COUNT_HW_INSTRUCTIONS)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
------------------------------------------------------------
sys_perf_event_open: pid 994937  cpu -1  group_fd -1  flags 0x8 = 3
------------------------------------------------------------
perf_event_attr:
  type                             3 (PERF_TYPE_HW_CACHE)
  size                             136
  config                           0x10001 (PERF_COUNT_HW_CACHE_RESULT_MISS | PERF_COUNT_HW_CACHE_OP_READ | PERF_COUNT_HW_CACHE_L1I)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
------------------------------------------------------------
sys_perf_event_open: pid 994937  cpu -1  group_fd -1  flags 0x8 = 4
cpu/legacy-hardware-config=1/: -1: 1364046 414756 414756
cpu/legacy-cache-config=0x10001/: -1: 57453 414756 414756
cpu/legacy-hardware-config=1/: 1364046 414756 414756
cpu/legacy-cache-config=0x10001/: 57453 414756 414756

 Performance counter stats for 'true':

         1,364,046      cpu/legacy-hardware-config=1/
            57,453      cpu/legacy-cache-config=0x10001/

       0.001988593 seconds time elapsed

       0.002194000 seconds user
       0.000000000 seconds sys
```

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/util/parse-events.c | 70 ++++++++++++++++++++++++++++++++++
 tools/perf/util/parse-events.h |  4 +-
 tools/perf/util/parse-events.l |  2 +
 tools/perf/util/pmu.c          | 30 +++++++++++++++
 4 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 37aa392ddaf2..be3e86e7b157 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -860,6 +860,8 @@ const char *parse_events__term_type_str(enum parse_events__term_type term_type)
 		[PARSE_EVENTS__TERM_TYPE_RAW]                   = "raw",
 		[PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE]          = "legacy-cache",
 		[PARSE_EVENTS__TERM_TYPE_HARDWARE]              = "hardware",
+		[PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG]	= "legacy-hardware-config",
+		[PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG]	= "legacy-cache-config",
 		[PARSE_EVENTS__TERM_TYPE_CPU]			= "cpu",
 	};
 	if ((unsigned int)term_type >= __PARSE_EVENTS__TERM_TYPE_NR)
@@ -911,6 +913,8 @@ config_term_avail(enum parse_events__term_type term_type, struct parse_events_er
 	case PARSE_EVENTS__TERM_TYPE_RAW:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+	case PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG:
+	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG:
 	default:
 		if (!err)
 			return false;
@@ -1068,6 +1072,8 @@ do {									   \
 	case PARSE_EVENTS__TERM_TYPE_USER:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+	case PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG:
+	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG:
 	default:
 		parse_events_error__handle(err, term->err_term,
 					strdup(parse_events__term_type_str(term->type_term)),
@@ -1090,10 +1096,68 @@ do {									   \
 #undef CHECK_TYPE_VAL
 }
 
+static bool check_pmu_is_core(__u32 type, const struct parse_events_term *term,
+			      struct parse_events_error *err)
+{
+	struct perf_pmu *pmu = NULL;
+
+	/* Avoid loading all PMUs with perf_pmus__find_by_type, just scan the core ones. */
+	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+		if (pmu->type == type)
+			return true;
+	}
+	parse_events_error__handle(err, term->err_val,
+				strdup("needs a core PMU"),
+				NULL);
+	return false;
+}
+
 static int config_term_pmu(struct perf_event_attr *attr,
 			   struct parse_events_term *term,
 			   struct parse_events_error *err)
 {
+	if (term->type_term == PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG) {
+		if (check_type_val(term, err, PARSE_EVENTS__TERM_TYPE_NUM))
+			return -EINVAL;
+		if (term->val.num >= PERF_COUNT_HW_MAX) {
+			parse_events_error__handle(err, term->err_val,
+						   strdup("too big"),
+						   NULL);
+			return -EINVAL;
+		}
+		if (!check_pmu_is_core(attr->type, term, err))
+			return -EINVAL;
+		attr->config = term->val.num;
+		if (perf_pmus__supports_extended_type())
+			attr->config |= (__u64)attr->type << PERF_PMU_TYPE_SHIFT;
+		attr->type = PERF_TYPE_HARDWARE;
+		return 0;
+	}
+	if (term->type_term == PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG) {
+		int cache_type, cache_op, cache_result;
+
+		if (check_type_val(term, err, PARSE_EVENTS__TERM_TYPE_NUM))
+			return -EINVAL;
+		cache_type = term->val.num & 0xFF;
+		cache_op = (term->val.num >> 8) & 0xFF;
+		cache_result = (term->val.num >> 16) & 0xFF;
+		if ((term->val.num & ~0xFFFFFF) ||
+		     cache_type >= PERF_COUNT_HW_CACHE_MAX ||
+		     cache_op >= PERF_COUNT_HW_CACHE_OP_MAX ||
+		     cache_result >= PERF_COUNT_HW_CACHE_RESULT_MAX) {
+			parse_events_error__handle(err, term->err_val,
+						   strdup("too big"),
+						   NULL);
+			return -EINVAL;
+		}
+		if (!check_pmu_is_core(attr->type, term, err))
+			return -EINVAL;
+		attr->config = term->val.num;
+		if (perf_pmus__supports_extended_type())
+			attr->config |= (__u64)attr->type << PERF_PMU_TYPE_SHIFT;
+		attr->type = PERF_TYPE_HW_CACHE;
+		return 0;
+	}
 	if (term->type_term == PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE) {
 		struct perf_pmu *pmu = perf_pmus__find_by_type(attr->type);
 
@@ -1180,6 +1244,8 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_CONFIG1:
 	case PARSE_EVENTS__TERM_TYPE_CONFIG2:
 	case PARSE_EVENTS__TERM_TYPE_CONFIG3:
+	case PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG:
+	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG:
 	case PARSE_EVENTS__TERM_TYPE_NAME:
 	case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
 	case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
@@ -1321,6 +1387,8 @@ do {								\
 		case PARSE_EVENTS__TERM_TYPE_CONFIG1:
 		case PARSE_EVENTS__TERM_TYPE_CONFIG2:
 		case PARSE_EVENTS__TERM_TYPE_CONFIG3:
+		case PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG:
+		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG:
 		case PARSE_EVENTS__TERM_TYPE_NAME:
 		case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
 		case PARSE_EVENTS__TERM_TYPE_RAW:
@@ -1359,6 +1427,8 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
 		case PARSE_EVENTS__TERM_TYPE_CONFIG1:
 		case PARSE_EVENTS__TERM_TYPE_CONFIG2:
 		case PARSE_EVENTS__TERM_TYPE_CONFIG3:
+		case PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG:
+		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG:
 		case PARSE_EVENTS__TERM_TYPE_NAME:
 		case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
 		case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 660303e591ad..a64f0741cb4b 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -82,7 +82,9 @@ enum parse_events__term_type {
 	PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE,
 	PARSE_EVENTS__TERM_TYPE_HARDWARE,
 	PARSE_EVENTS__TERM_TYPE_CPU,
-#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_CPU + 1)
+	PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG,
+	PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG,
+#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG + 1)
 };
 
 struct parse_events_term {
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 2034590eb789..b5058b6b49d3 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -336,6 +336,8 @@ aux-action		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_ACTION); }
 aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
 metric-id		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_METRIC_ID); }
 cpu			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_CPU); }
+legacy-hardware-config 	{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG); }
+legacy-cache-config	{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG); }
 cpu-cycles|cycles				{ return hw_term(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
 stalled-cycles-frontend|idle-cycles-frontend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
 stalled-cycles-backend|idle-cycles-backend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 36b880bf6bbf..f718eb41af88 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1532,6 +1532,34 @@ static int pmu_config_term(const struct perf_pmu *pmu,
 			assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
 			pmu_format_value(bits, term->val.num, &attr->config3, zero);
 			break;
+		case PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG:
+			assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
+			assert(term->val.num < PERF_COUNT_HW_MAX);
+			assert(pmu->is_core);
+			attr->config = term->val.num;
+			if (perf_pmus__supports_extended_type())
+				attr->config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
+			attr->type = PERF_TYPE_HARDWARE;
+			break;
+		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG: {
+#ifndef NDEBUG
+			int cache_type = term->val.num & 0xFF;
+			int cache_op = (term->val.num >> 8) & 0xFF;
+			int cache_result = (term->val.num >> 16) & 0xFF;
+
+			assert(cache_type < PERF_COUNT_HW_CACHE_MAX);
+			assert(cache_op < PERF_COUNT_HW_CACHE_OP_MAX);
+			assert(cache_result < PERF_COUNT_HW_CACHE_RESULT_MAX);
+#endif
+			assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
+			assert((term->val.num & ~0xFFFFFF) == 0);
+			assert(pmu->is_core);
+			attr->config = term->val.num;
+			if (perf_pmus__supports_extended_type())
+				attr->config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
+			attr->type = PERF_TYPE_HW_CACHE;
+			break;
+		}
 		case PARSE_EVENTS__TERM_TYPE_USER: /* Not hardcoded. */
 			return -EINVAL;
 		case PARSE_EVENTS__TERM_TYPE_NAME ... PARSE_EVENTS__TERM_TYPE_CPU:
@@ -1923,6 +1951,8 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_call
 		"config1=0..0xffffffffffffffff",
 		"config2=0..0xffffffffffffffff",
 		"config3=0..0xffffffffffffffff",
+		"legacy-hardware-config=0..9,",
+		"legacy-cache-config=0..0xffffff,",
 		"name=string",
 		"period=number",
 		"freq=number",
-- 
2.51.0.384.g4c02a37b29-goog

