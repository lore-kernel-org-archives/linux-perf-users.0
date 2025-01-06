Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0C278F2A;
	Mon,  6 Jan 2025 12:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736164979; cv=none; b=cG8euwtZasLTrHaulLZdQnTjWYNsQDEm+7yjgVv+aQWOBkGSXPxzxEQPE5SGRWFFxI+Xq5/xrxB2rX8dn4ViG37XFpBLEfFo1eD8KgCbiNUt/G25hMnM4Nh7jXLW6716/QDZe8W40xYRBEwbhDuQaWm4c44wFhD0DBMTAWIfoZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736164979; c=relaxed/simple;
	bh=spXeVEcnKD4vH2pH6KDXvRcija7d2Gy8rU0R1ifTrro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dG5798nVA/Fz1Eq2T97d6xQGll6ZeQjOxsBXVzA9LHs5whKJHIcGsD636CShqxabrrgF8qIdFEd1SndVCx+zsJddjuIC++Yni1x1KYRGcSfH2Y+ipgP9k+hK/gn2EKNChxWR17vqKODpXumJM3PtzbmLga6GAU3RAMzWjclm1nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC5B322C8;
	Mon,  6 Jan 2025 04:03:24 -0800 (PST)
Received: from e128066.arm.com (unknown [10.57.93.133])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 675443F673;
	Mon,  6 Jan 2025 04:02:52 -0800 (PST)
From: mark.barnett@arm.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com
Cc: ben.gainey@arm.com,
	deepak.surti@arm.com,
	ak@linux.intel.com,
	will@kernel.org,
	james.clark@arm.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mark Barnett <mark.barnett@arm.com>
Subject: [PATCH v2 4/5] tools/perf: Modify event parser to support alt-period-jitter term
Date: Mon,  6 Jan 2025 12:01:55 +0000
Message-Id: <20250106120156.227273-5-mark.barnett@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250106120156.227273-1-mark.barnett@arm.com>
References: <20250106120156.227273-1-mark.barnett@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Gainey <ben.gainey@arm.com>

parse-events is modified, adding the "alt-period-jitter" term which
can be used to enable random jitter of the alternative sample
period.

Signed-off-by: Ben Gainey <ben.gainey@arm.com>
Signed-off-by: Mark Barnett <mark.barnett@arm.com>
---
 tools/include/uapi/linux/perf_event.h             |  7 ++++++-
 tools/perf/tests/shell/attr/base-record           |  1 +
 tools/perf/tests/shell/attr/base-record-spe       |  1 +
 tools/perf/tests/shell/attr/base-stat             |  1 +
 tools/perf/tests/shell/attr/system-wide-dummy     |  1 +
 .../shell/attr/test-record-alt-period-jitter-term | 13 +++++++++++++
 tools/perf/tests/shell/attr/test-record-dummy-C0  |  1 +
 tools/perf/tests/shell/lib/attr.py                |  1 +
 tools/perf/util/evsel.c                           |  1 +
 tools/perf/util/parse-events.c                    | 15 +++++++++++++++
 tools/perf/util/parse-events.h                    |  3 ++-
 tools/perf/util/parse-events.l                    |  1 +
 tools/perf/util/pmu.c                             |  3 ++-
 13 files changed, 46 insertions(+), 3 deletions(-)
 create mode 100644 tools/perf/tests/shell/attr/test-record-alt-period-jitter-term

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 499a8673df8e..c0076ce8f80a 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -461,7 +461,12 @@ struct perf_event_attr {
 				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
 				remove_on_exec :  1, /* event is removed from task on exec */
 				sigtrap        :  1, /* send synchronous SIGTRAP on event */
-				__reserved_1   : 26;
+				/*
+				 * Add a limited amount of jitter on each alternate period, where
+				 * the jitter is between [0, (2<<jitter_alt_period) - 1]
+				 */
+				jitter_alt_period : 3,
+				__reserved_1   : 23;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
diff --git a/tools/perf/tests/shell/attr/base-record b/tools/perf/tests/shell/attr/base-record
index 28a7233f7bc1..1f5ab125c78d 100644
--- a/tools/perf/tests/shell/attr/base-record
+++ b/tools/perf/tests/shell/attr/base-record
@@ -40,3 +40,4 @@ branch_sample_type=0
 sample_regs_user=0
 sample_stack_user=0
 alt_sample_period=0
+jitter_alt_period=0
diff --git a/tools/perf/tests/shell/attr/base-record-spe b/tools/perf/tests/shell/attr/base-record-spe
index ad8eb72e655a..b35ca04b2ce4 100644
--- a/tools/perf/tests/shell/attr/base-record-spe
+++ b/tools/perf/tests/shell/attr/base-record-spe
@@ -39,3 +39,4 @@ branch_sample_type=*
 sample_regs_user=*
 sample_stack_user=*
 alt_sample_period=0
+jitter_alt_period=0
diff --git a/tools/perf/tests/shell/attr/base-stat b/tools/perf/tests/shell/attr/base-stat
index 2de92c5c300d..2d90a055686a 100644
--- a/tools/perf/tests/shell/attr/base-stat
+++ b/tools/perf/tests/shell/attr/base-stat
@@ -40,3 +40,4 @@ branch_sample_type=0
 sample_regs_user=0
 sample_stack_user=0
 alt_sample_period=0
+jitter_alt_period=0
diff --git a/tools/perf/tests/shell/attr/system-wide-dummy b/tools/perf/tests/shell/attr/system-wide-dummy
index c0a17bb3c022..527707b505e0 100644
--- a/tools/perf/tests/shell/attr/system-wide-dummy
+++ b/tools/perf/tests/shell/attr/system-wide-dummy
@@ -51,3 +51,4 @@ branch_sample_type=0
 sample_regs_user=0
 sample_stack_user=0
 alt_sample_period=0
+jitter_alt_period=0
diff --git a/tools/perf/tests/shell/attr/test-record-alt-period-jitter-term b/tools/perf/tests/shell/attr/test-record-alt-period-jitter-term
new file mode 100644
index 000000000000..6b31c898c905
--- /dev/null
+++ b/tools/perf/tests/shell/attr/test-record-alt-period-jitter-term
@@ -0,0 +1,13 @@
+[config]
+command = record
+args    = --no-bpf-event -e cycles/period=3,alt-period=2,alt-period-jitter=7/ -- kill >/dev/null 2>&1
+ret     = 1
+kernel_since = 6.11
+
+[event-10:base-record]
+sample_period=3
+alt_sample_period=2
+jitter_alt_period=7
+
+freq=0
+sample_type=7
diff --git a/tools/perf/tests/shell/attr/test-record-dummy-C0 b/tools/perf/tests/shell/attr/test-record-dummy-C0
index e6315918a95e..436534df0434 100644
--- a/tools/perf/tests/shell/attr/test-record-dummy-C0
+++ b/tools/perf/tests/shell/attr/test-record-dummy-C0
@@ -54,3 +54,4 @@ branch_sample_type=0
 sample_regs_user=0
 sample_stack_user=0
 alt_sample_period=0
+jitter_alt_period=0
diff --git a/tools/perf/tests/shell/lib/attr.py b/tools/perf/tests/shell/lib/attr.py
index 04e95f76005a..d15363e925fe 100644
--- a/tools/perf/tests/shell/lib/attr.py
+++ b/tools/perf/tests/shell/lib/attr.py
@@ -92,6 +92,7 @@ class Event(dict):
         'sample_regs_user',
         'sample_stack_user',
         'alt_sample_period',
+        'jitter_alt_period',
     ]
 
     def add(self, data):
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a796e49ef2f6..420bf0ce55eb 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -181,6 +181,7 @@ static int store_event(struct perf_event_attr *attr, pid_t pid, struct perf_cpu
 	WRITE_ASS(sample_regs_user,   "llu");
 	WRITE_ASS(sample_stack_user,  PRIu32);
 	WRITE_ASS(alt_sample_period,  "llu");
+	WRITE_ASS(jitter_alt_period,  "d");
 
 	fclose(file);
 	return 0;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 41e82347a020..53079053a044 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -800,6 +800,7 @@ const char *parse_events__term_type_str(enum parse_events__term_type term_type)
 		[PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE]          = "legacy-cache",
 		[PARSE_EVENTS__TERM_TYPE_HARDWARE]              = "hardware",
 		[PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD]	= "alt-period",
+		[PARSE_EVENTS__TERM_TYPE_ALT_PERIOD_JITTER]	= "alt-period-jitter",
 	};
 	if ((unsigned int)term_type >= __PARSE_EVENTS__TERM_TYPE_NR)
 		return "unknown term";
@@ -829,6 +830,7 @@ config_term_avail(enum parse_events__term_type term_type, struct parse_events_er
 	case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
 	case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
 	case PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD:
+	case PARSE_EVENTS__TERM_TYPE_ALT_PERIOD_JITTER:
 	case PARSE_EVENTS__TERM_TYPE_PERCORE:
 		return true;
 	case PARSE_EVENTS__TERM_TYPE_USER:
@@ -987,6 +989,16 @@ do {									   \
 		}
 		attr->alt_sample_period = term->val.num;
 		break;
+	case PARSE_EVENTS__TERM_TYPE_ALT_PERIOD_JITTER:
+		CHECK_TYPE_VAL(NUM);
+		if ((unsigned int)term->val.num > 7) {
+			parse_events_error__handle(err, term->err_val,
+						strdup("expected a value between 0-7"),
+						NULL);
+			return -EINVAL;
+		}
+		attr->jitter_alt_period = (unsigned int)term->val.num;
+		break;
 	case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
 	case PARSE_EVENTS__TERM_TYPE_USER:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
@@ -1115,6 +1127,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
 	case PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD:
+	case PARSE_EVENTS__TERM_TYPE_ALT_PERIOD_JITTER:
 	default:
 		if (err) {
 			parse_events_error__handle(err, term->err_term,
@@ -1250,6 +1263,7 @@ do {								\
 		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
 		case PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD:
+		case PARSE_EVENTS__TERM_TYPE_ALT_PERIOD_JITTER:
 		default:
 			break;
 		}
@@ -1305,6 +1319,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
 		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
 		case PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD:
+		case PARSE_EVENTS__TERM_TYPE_ALT_PERIOD_JITTER:
 		default:
 			break;
 		}
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index d00bb6c5d9ab..dafd4b4d0f0e 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -81,7 +81,8 @@ enum parse_events__term_type {
 	PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE,
 	PARSE_EVENTS__TERM_TYPE_HARDWARE,
 	PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD,
-#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD + 1)
+	PARSE_EVENTS__TERM_TYPE_ALT_PERIOD_JITTER,
+#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_ALT_PERIOD_JITTER + 1)
 };
 
 struct parse_events_term {
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 3538f5bca5df..ceb19d41766a 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -325,6 +325,7 @@ aux-action		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_ACTION); }
 aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
 metric-id		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_METRIC_ID); }
 alt-period		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD); }
+alt-period-jitter	{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_ALT_PERIOD_JITTER); }
 cpu-cycles|cycles				{ return hw_term(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
 stalled-cycles-frontend|idle-cycles-frontend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
 stalled-cycles-backend|idle-cycles-backend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 376cdec933c2..d8e145d6abff 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1400,7 +1400,7 @@ static int pmu_config_term(const struct perf_pmu *pmu,
 			break;
 		case PARSE_EVENTS__TERM_TYPE_USER: /* Not hardcoded. */
 			return -EINVAL;
-		case PARSE_EVENTS__TERM_TYPE_NAME ... PARSE_EVENTS__TERM_TYPE_HARDWARE:
+		case PARSE_EVENTS__TERM_TYPE_NAME ... PARSE_EVENTS__TERM_TYPE_ALT_PERIOD_JITTER:
 			/* Skip non-config terms. */
 			break;
 		default:
@@ -1776,6 +1776,7 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_call
 		"aux-action=(pause|resume|start-paused)",
 		"aux-sample-size=number",
 		"alt-period=number",
+		"alt-period-jitter=number",
 	};
 	struct perf_pmu_format *format;
 	int ret;
-- 
2.43.0

