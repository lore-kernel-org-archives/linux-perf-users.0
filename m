Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DA331B131;
	Tue,  2 Sep 2025 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756831293; cv=none; b=NNl8KLvyRhjY0YGuHVb+rnRQXf0P+AsToXfyeH4kUxp8zdW5y9V3bnb4i4Not784qRpB/ShTnGs5MG2F9OwBp7CrTTbwg3+P4be6CLVK/uiaaFze3Nkx5E++q11xrQYx8RthNq5VWpnYrx2t2Zf3hi0WCPObppDLL5dAm1ly4co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756831293; c=relaxed/simple;
	bh=WskN2oOK6aFY4zvPiSz8zULkpYxhixIw1aAr8ljYeWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5SRnR9e1DrSg4K2XjFCCWIOLzUEEiS4pP5NusCIGjISu1ISsYwDDXoYHcTv7WGz29STLHEoehagc5e6dEeRGzuetn/8dPh8XY5dTjjv+cFyumR3MWieCM9jSjadj8D6zwIa5nKUBLvItRXn/tx2XJCawo6Unjj3DLRp7UuyNsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N9qaI3Oo; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N9qaI3Oo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756831292; x=1788367292;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WskN2oOK6aFY4zvPiSz8zULkpYxhixIw1aAr8ljYeWI=;
  b=N9qaI3Oo/FmCsFqiQSlgTpjgQEk1HBe22m7fCYk7GsH3kW6qD8dGw5X0
   CjfXGxdJVpIFbCB4CiOXSoz2Pi+P/Wy7Rc5d3VIrdfE18m2oSCvUKXIX9
   JLKeJQEDIFdSZAS7ADZKqrOMOFxppWN23P/DgNmFneVABZBJm6vXkOoUj
   kulTbMe6tjUJbDTZ0654TDlPkzuKnWrCw/emj/q32WgeZR8xn1leZO8oK
   phZbe/4THXFofPcRh9LQcHijhaiwhd8qyMZIYFZm7qadiSWGrmAM6LbOB
   QVsyyPho3X50eDq2T5r6JkPeBlvoDNvLmPNH0IR5+TjYH4LsybKlL3iHy
   Q==;
X-CSE-ConnectionGUID: Lbs9rYNMQwey+mv3U0+hyw==
X-CSE-MsgGUID: 3HHrO8XaQNOJvjbGazR4XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="81701749"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="81701749"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 09:41:31 -0700
X-CSE-ConnectionGUID: JUdCrF4nQq62HS242YnGWw==
X-CSE-MsgGUID: v+Df63QqSKq1An1l3bRWow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="208527200"
Received: from tfalcon-desk.amr.corp.intel.com (HELO tfalcon-desk.intel.com) ([10.125.109.212])
  by orviesa001.jf.intel.com with ESMTP; 02 Sep 2025 09:41:30 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>
Subject: [RESEND][PATCH v2 1/2] perf record: Add ratio-to-prev term
Date: Tue,  2 Sep 2025 11:40:45 -0500
Message-ID: <20250902164047.64261-2-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250902164047.64261-1-thomas.falcon@intel.com>
References: <20250902164047.64261-1-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide ratio-to-prev term which allows the user to
set the event sample period of two events corresponding
to a desired ratio. If using on an Intel x86 platform with
Auto Counter Reload support, also set corresponding event's
config2 attribute with a bitmask which counters to reset and
which counters to sample if the desired ratio is met or exceeded.
On other platforms, only the sample period is affected by the
ratio-to-prev term.

Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/Documentation/intel-acr.txt | 53 ++++++++++++++++++
 tools/perf/Documentation/perf-list.txt |  2 +
 tools/perf/arch/x86/util/evsel.c       | 53 ++++++++++++++++++
 tools/perf/util/evsel.c                | 76 ++++++++++++++++++++++++++
 tools/perf/util/evsel.h                |  1 +
 tools/perf/util/evsel_config.h         |  1 +
 tools/perf/util/parse-events.c         | 22 ++++++++
 tools/perf/util/parse-events.h         |  3 +-
 tools/perf/util/parse-events.l         |  1 +
 tools/perf/util/pmu.c                  |  3 +-
 10 files changed, 213 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/Documentation/intel-acr.txt

diff --git a/tools/perf/Documentation/intel-acr.txt b/tools/perf/Documentation/intel-acr.txt
new file mode 100644
index 000000000000..72654fdd9a52
--- /dev/null
+++ b/tools/perf/Documentation/intel-acr.txt
@@ -0,0 +1,53 @@
+Intel Auto Counter Reload Support
+---------------------------------
+Support for Intel Auto Counter Reload in perf tools
+
+Auto counter reload provides a means for software to specify to hardware
+that certain counters, if supported, should be automatically reloaded
+upon overflow of chosen counters. By taking a sample only if the rate of
+one event exceeds some threshold relative to the rate of another event,
+this feature enables software to sample based on the relative rate of
+two or more events. To enable this, the user must provide a sample period
+term and a bitmask ("acr_mask") for each relevant event specifying the
+counters in an event group to reload if the event's specified sample
+period is exceeded.
+
+For example, if the user desires to measure a scenario when IPC > 2,
+the event group might look like the one below:
+
+	perf record -e {cpu_atom/instructions,period=200000,acr_mask=0x2/, \
+	cpu_atom/cycles,period=100000,acr_mask=0x3/} -- true
+
+In this case, if the "instructions" counter exceeds the sample period of
+200000, the second counter, "cycles", will be reset and a sample will be
+taken. If "cycles" is exceeded first, both counters in the group will be
+reset. In this way, samples will only be taken for cases where IPC > 2.
+
+The acr_mask term is a hexadecimal value representing a bitmask of the
+events in the group to be reset when the period is exceeded. In the
+example above, "instructions" is assigned an acr_mask of 0x2, meaning
+only the second event in the group is reloaded and a sample is taken
+for the first event. "cycles" is assigned an acr_mask of 0x3, meaning
+that both event counters will be reset if the sample period is exceeded
+first.
+
+ratio-to-prev Event Term
+------------------------
+To simplify this, an event term "ratio-to-prev" is provided which is used
+alongside the sample period term n or the -c/--count option. This would
+allow users to specify the desired relative rate between events as a
+ratio. Note: Both events compared must belong to the same PMU.
+
+The command above would then become
+
+	perf record -e {cpu_atom/instructions/, \
+	cpu_atom/cycles,period=100000,ratio-to-prev=0.5/} -- true
+
+ratio-to-prev is the ratio of the event using the term relative
+to the previous event in the group, which will always be 1,
+for a 1:0.5 or 2:1 ratio.
+
+To sample for IPC < 2 for example, the events need to be reordered:
+
+	perf record -e {cpu_atom/cycles/, \
+	cpu_atom/instructions,period=200000,ratio-to-prev=2.0/} -- true
diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 28215306a78a..10bc66d39202 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -392,6 +392,8 @@ Support raw format:
 . '--raw-dump [hw|sw|cache|tracepoint|pmu|event_glob]', shows the raw-dump of
   a certain kind of events.
 
+include::intel-acr.txt[]
+
 SEE ALSO
 --------
 linkperf:perf-stat[1], linkperf:perf-top[1],
diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index 9bc80fff3aa0..84858e4c397d 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
+#include "util/evlist.h"
 #include "util/evsel.h"
+#include "util/evsel_config.h"
 #include "util/env.h"
 #include "util/pmu.h"
 #include "util/pmus.h"
@@ -67,6 +69,57 @@ int arch_evsel__hw_name(struct evsel *evsel, char *bf, size_t size)
 			 event_name);
 }
 
+void arch_evsel__apply_ratio_to_prev(struct evsel *evsel,
+				struct perf_event_attr *attr)
+{
+	struct perf_event_attr *prev_attr = NULL;
+	struct evsel *evsel_prev = NULL;
+	const char *name = "acr_mask";
+	int evsel_idx = 0;
+	__u64 ev_mask, pr_ev_mask;
+
+	if (!perf_pmu__has_format(evsel->pmu, name)) {
+		pr_err("'%s' does not have acr_mask format support\n", evsel->pmu->name);
+		return;
+	}
+	if (perf_pmu__format_type(evsel->pmu, name) !=
+			PERF_PMU_FORMAT_VALUE_CONFIG2) {
+		pr_err("'%s' does not have config2 format support\n", evsel->pmu->name);
+		return;
+	}
+
+	evsel_prev = evsel__prev(evsel);
+	if (!evsel_prev) {
+		pr_err("Previous event does not exist.\n");
+		return;
+	}
+
+	prev_attr = &evsel_prev->core.attr;
+
+	if (prev_attr->config2) {
+		pr_err("'%s' has set config2 (acr_mask?) already, configuration not supported\n", evsel_prev->name);
+		return;
+	}
+
+	/*
+	 * acr_mask (config2) is calculated using the event's index in
+	 * the event group. The first event will use the index of the
+	 * second event as its mask (e.g., 0x2), indicating that the
+	 * second event counter will be reset and a sample taken for
+	 * the first event if its counter overflows. The second event
+	 * will use the mask consisting of the first and second bits
+	 * (e.g., 0x3), meaning both counters will be reset if the
+	 * second event counter overflows.
+	 */
+
+	evsel_idx = evsel__group_idx(evsel);
+	ev_mask = 1ull << evsel_idx;
+	pr_ev_mask = 1ull << (evsel_idx - 1);
+
+	prev_attr->config2 = ev_mask;
+	attr->config2 = ev_mask | pr_ev_mask;
+}
+
 static void ibs_l3miss_warn(void)
 {
 	pr_warning(
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d264c143b592..f6f93920c0aa 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1091,6 +1091,71 @@ static void evsel__reset_callgraph(struct evsel *evsel, struct callchain_param *
 	}
 }
 
+static void evsel__apply_ratio_to_prev(struct evsel *evsel,
+				       struct perf_event_attr *attr,
+				       struct record_opts *opts,
+				       const char *buf)
+{
+	struct perf_event_attr *prev_attr = NULL;
+	struct evsel *evsel_prev = NULL;
+	u64 type = evsel->core.attr.sample_type;
+	u64 prev_type = 0;
+	double rtp;
+
+	rtp = strtod(buf, NULL);
+	if (rtp <= 0) {
+		pr_err("Invalid ratio-to-prev value %lf\n", rtp);
+		return;
+	}
+	if (evsel == evsel__leader(evsel)) {
+		pr_err("Invalid use of ratio-to-prev term without preceding element in group\n");
+		return;
+	}
+	if (!evsel->pmu->is_core) {
+		pr_err("Event using ratio-to-prev term must have a core PMU\n");
+		return;
+	}
+
+	evsel_prev = evsel__prev(evsel);
+	if (!evsel_prev) {
+		pr_err("Previous event does not exist.\n");
+		return;
+	}
+
+	if (evsel_prev->pmu->type != evsel->pmu->type) {
+		pr_err("Compared events (\"%s\", \"%s\") must have same PMU\n",
+			evsel->name, evsel_prev->name);
+		return;
+	}
+
+	prev_attr = &evsel_prev->core.attr;
+	prev_type = evsel_prev->core.attr.sample_type;
+
+	if (!(prev_type & PERF_SAMPLE_PERIOD)) {
+		attr->sample_period = prev_attr->sample_period * rtp;
+		attr->freq = 0;
+		evsel__reset_sample_bit(evsel, PERIOD);
+	} else if (!(type & PERF_SAMPLE_PERIOD)) {
+		prev_attr->sample_period = attr->sample_period / rtp;
+		prev_attr->freq = 0;
+		evsel__reset_sample_bit(evsel_prev, PERIOD);
+	} else {
+		if (opts->user_interval != ULLONG_MAX) {
+			prev_attr->sample_period = opts->user_interval;
+			attr->sample_period = prev_attr->sample_period * rtp;
+			prev_attr->freq = 0;
+			attr->freq = 0;
+			evsel__reset_sample_bit(evsel_prev, PERIOD);
+			evsel__reset_sample_bit(evsel, PERIOD);
+		} else {
+			pr_err("Event period term or count (-c) must be set when using ratio-to-prev term.\n");
+			return;
+		}
+	}
+
+	arch_evsel__apply_ratio_to_prev(evsel, attr);
+}
+
 static void evsel__apply_config_terms(struct evsel *evsel,
 				      struct record_opts *opts, bool track)
 {
@@ -1104,6 +1169,7 @@ static void evsel__apply_config_terms(struct evsel *evsel,
 	u32 dump_size = 0;
 	int max_stack = 0;
 	const char *callgraph_buf = NULL;
+	const char *rtp_buf = NULL;
 
 	list_for_each_entry(term, config_terms, list) {
 		switch (term->type) {
@@ -1174,6 +1240,9 @@ static void evsel__apply_config_terms(struct evsel *evsel,
 			break;
 		case EVSEL__CONFIG_TERM_CFG_CHG:
 			break;
+		case EVSEL__CONFIG_TERM_RATIO_TO_PREV:
+			rtp_buf = term->val.str;
+			break;
 		default:
 			break;
 		}
@@ -1225,6 +1294,8 @@ static void evsel__apply_config_terms(struct evsel *evsel,
 			evsel__config_callchain(evsel, opts, &param);
 		}
 	}
+	if (rtp_buf)
+		evsel__apply_ratio_to_prev(evsel, attr, opts, rtp_buf);
 }
 
 struct evsel_config_term *__evsel__get_config_term(struct evsel *evsel, enum evsel_term_type type)
@@ -1249,6 +1320,11 @@ void __weak arch__post_evsel_config(struct evsel *evsel __maybe_unused,
 {
 }
 
+void __weak arch_evsel__apply_ratio_to_prev(struct evsel *evsel __maybe_unused,
+					    struct perf_event_attr *attr __maybe_unused)
+{
+}
+
 static void evsel__set_default_freq_period(struct record_opts *opts,
 					   struct perf_event_attr *attr)
 {
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 5797a02e5d6a..5002c795e818 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -342,6 +342,7 @@ void evsel__set_sample_id(struct evsel *evsel, bool use_sample_identifier);
 void arch_evsel__set_sample_weight(struct evsel *evsel);
 void arch__post_evsel_config(struct evsel *evsel, struct perf_event_attr *attr);
 int arch_evsel__open_strerror(struct evsel *evsel, char *msg, size_t size);
+void arch_evsel__apply_ratio_to_prev(struct evsel *evsel, struct perf_event_attr *attr);
 
 int evsel__set_filter(struct evsel *evsel, const char *filter);
 int evsel__append_tp_filter(struct evsel *evsel, const char *filter);
diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_config.h
index 94a1e9cf73d6..bcd3a978f0c4 100644
--- a/tools/perf/util/evsel_config.h
+++ b/tools/perf/util/evsel_config.h
@@ -28,6 +28,7 @@ enum evsel_term_type {
 	EVSEL__CONFIG_TERM_AUX_ACTION,
 	EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE,
 	EVSEL__CONFIG_TERM_CFG_CHG,
+	EVSEL__CONFIG_TERM_RATIO_TO_PREV,
 };
 
 struct evsel_config_term {
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 8282ddf68b98..850de3a51f47 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -834,6 +834,7 @@ const char *parse_events__term_type_str(enum parse_events__term_type term_type)
 		[PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE]          = "legacy-cache",
 		[PARSE_EVENTS__TERM_TYPE_HARDWARE]              = "hardware",
 		[PARSE_EVENTS__TERM_TYPE_CPU]			= "cpu",
+		[PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV]         = "ratio-to-prev",
 	};
 	if ((unsigned int)term_type >= __PARSE_EVENTS__TERM_TYPE_NR)
 		return "unknown term";
@@ -884,6 +885,7 @@ config_term_avail(enum parse_events__term_type term_type, struct parse_events_er
 	case PARSE_EVENTS__TERM_TYPE_RAW:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+	case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
 	default:
 		if (!err)
 			return false;
@@ -1037,6 +1039,21 @@ do {									   \
 		perf_cpu_map__put(map);
 		break;
 	}
+	case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
+		CHECK_TYPE_VAL(STR);
+		if (strtod(term->val.str, NULL) <= 0) {
+			parse_events_error__handle(err, term->err_val,
+						   strdup("zero or negative"),
+						   NULL);
+			return -EINVAL;
+		}
+		if (errno == ERANGE) {
+			parse_events_error__handle(err, term->err_val,
+						   strdup("too big"),
+						   NULL);
+			return -EINVAL;
+		}
+		break;
 	case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
 	case PARSE_EVENTS__TERM_TYPE_USER:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
@@ -1165,6 +1182,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
 	case PARSE_EVENTS__TERM_TYPE_CPU:
+	case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
 	default:
 		if (err) {
 			parse_events_error__handle(err, term->err_term,
@@ -1289,6 +1307,9 @@ do {								\
 			ADD_CONFIG_TERM_VAL(AUX_SAMPLE_SIZE, aux_sample_size,
 					    term->val.num, term->weak);
 			break;
+		case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
+			ADD_CONFIG_TERM_STR(RATIO_TO_PREV, term->val.str, term->weak);
+			break;
 		case PARSE_EVENTS__TERM_TYPE_USER:
 		case PARSE_EVENTS__TERM_TYPE_CONFIG:
 		case PARSE_EVENTS__TERM_TYPE_CONFIG1:
@@ -1355,6 +1376,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
 		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
 		case PARSE_EVENTS__TERM_TYPE_CPU:
+		case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
 		default:
 			break;
 		}
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 62dc7202e3ba..b2dcc52e3814 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -83,7 +83,8 @@ enum parse_events__term_type {
 	PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE,
 	PARSE_EVENTS__TERM_TYPE_HARDWARE,
 	PARSE_EVENTS__TERM_TYPE_CPU,
-#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_CPU + 1)
+	PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV,
+#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV + 1)
 };
 
 struct parse_events_term {
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 2034590eb789..25206de68007 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -336,6 +336,7 @@ aux-action		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_ACTION); }
 aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
 metric-id		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_METRIC_ID); }
 cpu			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_CPU); }
+ratio-to-prev		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV); }
 cpu-cycles|cycles				{ return hw_term(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
 stalled-cycles-frontend|idle-cycles-frontend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
 stalled-cycles-backend|idle-cycles-backend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 5a291f1380ed..3d1f975e8db9 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1541,7 +1541,7 @@ static int pmu_config_term(const struct perf_pmu *pmu,
 			break;
 		case PARSE_EVENTS__TERM_TYPE_USER: /* Not hardcoded. */
 			return -EINVAL;
-		case PARSE_EVENTS__TERM_TYPE_NAME ... PARSE_EVENTS__TERM_TYPE_CPU:
+		case PARSE_EVENTS__TERM_TYPE_NAME ... PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
 			/* Skip non-config terms. */
 			break;
 		default:
@@ -1930,6 +1930,7 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_call
 		"aux-action=(pause|resume|start-paused)",
 		"aux-sample-size=number",
 		"cpu=number",
+		"ratio-to-prev=string",
 	};
 	struct perf_pmu_format *format;
 	int ret;
-- 
2.50.1

