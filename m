Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F81F171CD;
	Mon, 12 May 2025 21:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747084161; cv=none; b=Wo4mBbidnql8q4aCSIff0Md3BjvCGJY/ndC4J03CHoV1+3GWE/zsqR6y/Y3vVIU891zoaqHRJI7uCVUGkuuHZP2zNt5VhCvrHTacaFd2l9HwGETAJBWtYnyajSbjjI5xZSpDjleB9Txaadgs7XZpwX3xGl1Lc76NJ/vxkG4ytok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747084161; c=relaxed/simple;
	bh=eW5ouQcVqDrzKDCyCQaA1j2hjd9kBlaVYa448StBU/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UPdTBXK25xOoGICWBsswQKZ2kbVpHY0Q3Tt7CzvVypVymNsDyJbUrSCf3l94if1YvierI3NSujTjRftVKaxxPulxf7VjUjdH75pij+/WtmiahtlSsQVh04Gng9M8d8oTUvAhL1ghQQ9+nlNzIwmIDNp7mitqqb1a9Z56E0Eq4kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JbBJlVqe; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JbBJlVqe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747084158; x=1778620158;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eW5ouQcVqDrzKDCyCQaA1j2hjd9kBlaVYa448StBU/4=;
  b=JbBJlVqejrQMc592cSE1WE3t7rpmxjzBX1dzJWdtw+G9+SPjnX1I6eZ7
   OxP4yylBQp0xfPZ/9L6MHZUkFC8IGLhac8hA4mSXKDTqo9wcCS1RqjZMO
   2i6jkAOSC6LV5asfdBBswIV2ms6yP2PO6sfpm8FmjpoOeWhQEfUqbGB+3
   r5gXx6YM5JRNHTsL/Ax6QxD6n1Hx/JjkOc3qREOKDYkOyLxEIUV591ajs
   BAILCTTM1FIk2OCa7TbhneLNTzmReE6pCAOUjR1caZc6BmSoPcOmsmKgG
   LaItdRgD8Fy/lkUS611Z7smGrHXObHZECARzN5BbieEE4G/2M0J3W8dGG
   Q==;
X-CSE-ConnectionGUID: 1DAKRi/cSdKB543vhbpPkA==
X-CSE-MsgGUID: MFGO2YLVQ0ihXyegYE/vPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="74303287"
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="74303287"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 14:09:14 -0700
X-CSE-ConnectionGUID: sNt/InYQSs2xtHMEAR0htg==
X-CSE-MsgGUID: ubqwNoNZT3m0Z5P2kn2x+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="142677103"
Received: from tfalcon-desk.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.220.190])
  by fmviesa004.fm.intel.com with ESMTP; 12 May 2025 14:09:13 -0700
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
	Thomas Falcon <thomas.falcon@intel.com>
Subject: [PATCH] perf record: Usability enhancement for Auto Counter Reload
Date: Mon, 12 May 2025 16:09:12 -0500
Message-ID: <20250512210912.274362-1-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Auto Counter Reload (ACR)[1] feature is used to track the
relative rates of two or more perf events, only sampling
when a given threshold is exceeded. This helps reduce overhead
and unnecessary samples. However, enabling this feature
currently requires setting two parameters:

 -- Event sampling period ("period")
 -- acr_mask, which determines which events get reloaded
    when the sample period is reached.

For example, in the following command:

perf record -e "{cpu_atom/branch-misses,period=200000,\
acr_mask=0x2/ppu,cpu_atom/branch-instructions,period=1000000,\
acr_mask=0x3/u}" -- ./mispredict

The goal is to limit event sampling to cases when the
branch miss rate exceeds 20%. If the branch instructions
sample period is exceeded first, both events are reloaded.
If branch misses exceed their threshold first, only the
second counter is reloaded, and a sample is taken.

To simplify this, provide a new “ratio-to-prev” event term
that works alongside the period event option or -c option.
This would allow users to specify the desired relative rate
between events as a ratio, making configuration more intuitive.

With this enhancement, the equivalent command would be:

perf record -e "{cpu_atom/branch-misses/ppu,\
cpu_atom/branch-instructions,period=1000000,ratio_to_prev=5/u}" \
-- ./mispredict

or

perf record -e "{cpu_atom/branch-misses/ppu,\
cpu_atom/branch-instructions,ratio-to-prev=5/u}" -c 1000000 \
-- ./mispredict

[1] https://lore.kernel.org/lkml/20250327195217.2683619-1-kan.liang@linux.intel.com/

Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>

---
 tools/perf/Documentation/intel-acr.txt |  45 +++++++++++
 tools/perf/Documentation/perf-list.txt |   2 +
 tools/perf/arch/x86/util/evsel.c       | 100 ++++++++++++++++++++++++-
 tools/perf/util/evsel.c                |   2 +
 tools/perf/util/evsel_config.h         |   1 +
 tools/perf/util/parse-events.c         |  10 +++
 tools/perf/util/parse-events.h         |   3 +-
 tools/perf/util/parse-events.l         |   1 +
 tools/perf/util/pmu.c                  |   3 +-
 9 files changed, 164 insertions(+), 3 deletions(-)
 create mode 100644 tools/perf/Documentation/intel-acr.txt

diff --git a/tools/perf/Documentation/intel-acr.txt b/tools/perf/Documentation/intel-acr.txt
new file mode 100644
index 000000000000..db835c769e1c
--- /dev/null
+++ b/tools/perf/Documentation/intel-acr.txt
@@ -0,0 +1,45 @@
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
+ratio-to-prev Event Term
+------------------------
+To simplify this, an event term "ratio-to-prev" is provided which is used
+alongside the sample period term n or the -c/--count option. This would
+allow users to specify the desired relative rate between events as a
+ratio.
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
index 8914f12d2b85..ba809fa1e8c6 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -376,6 +376,8 @@ Support raw format:
 . '--raw-dump [hw|sw|cache|tracepoint|pmu|event_glob]', shows the raw-dump of
   a certain kind of events.
 
+include::intel-acr.txt[]
+
 SEE ALSO
 --------
 linkperf:perf-stat[1], linkperf:perf-top[1],
diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index 3dd29ba2c23b..b93dbbed2c8e 100644
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
@@ -89,6 +91,97 @@ int arch_evsel__hw_name(struct evsel *evsel, char *bf, size_t size)
 			 event_name);
 }
 
+static void evsel__apply_ratio_to_prev(struct evsel *evsel,
+				struct perf_event_attr *attr,
+				const char *buf)
+{
+	struct perf_event_attr *prev_attr = NULL;
+	struct evsel *evsel_prev = NULL;
+	struct evsel *leader = evsel__leader(evsel);
+	struct evsel *pos;
+	const char *name = "acr_mask";
+	int evsel_idx = 0;
+	__u64 ev_mask, pr_ev_mask;
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
+	if (!perf_pmu__has_format(evsel->pmu, name)) {
+		pr_err("'%s' does not have acr_mask format support\n", evsel->pmu->name);
+		return;
+	}
+	if (perf_pmu__format_type(evsel->pmu, name) !=
+			PERF_PMU_FORMAT_VALUE_CONFIG2) {
+		pr_err("'%s' does not have acr_mask format support\n", evsel->pmu->name);
+		return;
+	}
+	if (attr->freq) {
+		pr_err("Event period term or count (-c) must be set when using ratio-to-prev term.\n");
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
+	prev_attr->sample_period = (__u64)(attr->sample_period / rtp);
+	prev_attr->freq = 0;
+	evsel__reset_sample_bit(evsel_prev, PERIOD);
+
+	for_each_group_evsel(pos, leader) {
+		if (pos == evsel)
+			break;
+		evsel_idx++;
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
+	ev_mask = 1ull << evsel_idx;
+	pr_ev_mask = 1ull << (evsel_idx - 1);
+
+	prev_attr->config2 = ev_mask;
+	attr->config2 = ev_mask | pr_ev_mask;
+}
+
+static void intel__post_evsel_config(struct evsel *evsel,
+			      struct perf_event_attr *attr)
+{
+	struct evsel_config_term *term;
+	struct list_head *config_terms = &evsel->config_terms;
+	const char *rtp_buf = NULL;
+
+	list_for_each_entry(term, config_terms, list) {
+		if (term->type == EVSEL__CONFIG_TERM_RATIO_TO_PREV) {
+			rtp_buf = term->val.str;
+			evsel__apply_ratio_to_prev(evsel, attr, rtp_buf);
+		}
+	}
+}
+
 static void ibs_l3miss_warn(void)
 {
 	pr_warning(
@@ -101,7 +194,12 @@ void arch__post_evsel_config(struct evsel *evsel, struct perf_event_attr *attr)
 	struct perf_pmu *evsel_pmu, *ibs_fetch_pmu, *ibs_op_pmu;
 	static int warned_once;
 
-	if (warned_once || !x86__is_amd_cpu())
+	if (!x86__is_amd_cpu()) {
+		intel__post_evsel_config(evsel, attr);
+		return;
+	}
+
+	if (warned_once)
 		return;
 
 	evsel_pmu = evsel__find_pmu(evsel);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index b60461e16804..5028232afeb7 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1189,6 +1189,8 @@ static void evsel__apply_config_terms(struct evsel *evsel,
 			break;
 		case EVSEL__CONFIG_TERM_CFG_CHG:
 			break;
+		case EVSEL__CONFIG_TERM_RATIO_TO_PREV:
+			break;
 		default:
 			break;
 		}
diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_config.h
index af52a1516d0b..26c69d9ce788 100644
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
index 7297ca3a4eec..4ea8d4ffabdb 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -806,6 +806,7 @@ const char *parse_events__term_type_str(enum parse_events__term_type term_type)
 		[PARSE_EVENTS__TERM_TYPE_RAW]                   = "raw",
 		[PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE]          = "legacy-cache",
 		[PARSE_EVENTS__TERM_TYPE_HARDWARE]              = "hardware",
+		[PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV]         = "ratio-to-prev",
 	};
 	if ((unsigned int)term_type >= __PARSE_EVENTS__TERM_TYPE_NR)
 		return "unknown term";
@@ -855,6 +856,7 @@ config_term_avail(enum parse_events__term_type term_type, struct parse_events_er
 	case PARSE_EVENTS__TERM_TYPE_RAW:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+	case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
 	default:
 		if (!err)
 			return false;
@@ -982,6 +984,9 @@ do {									   \
 			return -EINVAL;
 		}
 		break;
+	case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
+		CHECK_TYPE_VAL(STR);
+		break;
 	case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
 	case PARSE_EVENTS__TERM_TYPE_USER:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
@@ -1109,6 +1114,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_RAW:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+	case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
 	default:
 		if (err) {
 			parse_events_error__handle(err, term->err_term,
@@ -1233,6 +1239,9 @@ do {								\
 			ADD_CONFIG_TERM_VAL(AUX_SAMPLE_SIZE, aux_sample_size,
 					    term->val.num, term->weak);
 			break;
+		case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
+			ADD_CONFIG_TERM_STR(RATIO_TO_PREV, term->val.str, term->weak);
+			break;
 		case PARSE_EVENTS__TERM_TYPE_USER:
 		case PARSE_EVENTS__TERM_TYPE_CONFIG:
 		case PARSE_EVENTS__TERM_TYPE_CONFIG1:
@@ -1297,6 +1306,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
 		case PARSE_EVENTS__TERM_TYPE_RAW:
 		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+		case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
 		default:
 			break;
 		}
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index e176a34ab088..a9de95dd337a 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -80,7 +80,8 @@ enum parse_events__term_type {
 	PARSE_EVENTS__TERM_TYPE_RAW,
 	PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE,
 	PARSE_EVENTS__TERM_TYPE_HARDWARE,
-#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_HARDWARE + 1)
+	PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV,
+#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV + 1)
 };
 
 struct parse_events_term {
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 7ed86e3e34e3..49fe1811fe68 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -335,6 +335,7 @@ aux-output		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
 aux-action		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_ACTION); }
 aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
 metric-id		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_METRIC_ID); }
+ratio-to-prev		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV); }
 cpu-cycles|cycles				{ return hw_term(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
 stalled-cycles-frontend|idle-cycles-frontend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
 stalled-cycles-backend|idle-cycles-backend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index d08972aa461c..8b5b5a6adb29 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1470,7 +1470,7 @@ static int pmu_config_term(const struct perf_pmu *pmu,
 			break;
 		case PARSE_EVENTS__TERM_TYPE_USER: /* Not hardcoded. */
 			return -EINVAL;
-		case PARSE_EVENTS__TERM_TYPE_NAME ... PARSE_EVENTS__TERM_TYPE_HARDWARE:
+		case PARSE_EVENTS__TERM_TYPE_NAME ... PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
 			/* Skip non-config terms. */
 			break;
 		default:
@@ -1852,6 +1852,7 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_call
 		"aux-output",
 		"aux-action=(pause|resume|start-paused)",
 		"aux-sample-size=number",
+		"ratio-to-prev=string",
 	};
 	struct perf_pmu_format *format;
 	int ret;
-- 
2.48.1

