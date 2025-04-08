Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A8323C8C1;
	Tue,  8 Apr 2025 17:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744132602; cv=none; b=MjWjBjmH2ql3bu+BzmVisft1TbhBtcbW4ZR66g6T0AkVRK19CCiUj9dd6RNMBWr4kt5x4+m5EOkmVzeNjMsj0fXWxYIN0W0yEd/RXammT47tBWEXykSZ72ejeyuh9qtvOwkmDHMUVAIw5IcuQM2SbzXJbMrqZBhOCZrF1di9v0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744132602; c=relaxed/simple;
	bh=JmMelrEjPWF3FZuZVbwJYwcQY5UYZuRHJy+E+JTBJ1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c0R+5rG2cHGtNYnF219mNgYWjV9qopUzr05kQgiduxrheVZBgUMzHPs2Wt4GAwT7KGDUlVSEY/LN4evvsA2q+HvTSIHeOsO+c5HjQ273Skn1LsfSwkbMA16tM1uOsV7GCZzgkmuVJF6T3wjcXledUvqbs2DoC3wAnYlnck5q+dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 960591688;
	Tue,  8 Apr 2025 10:16:40 -0700 (PDT)
Received: from e128066.cambridge.arm.com (e128066.cambridge.arm.com [10.1.26.81])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E23EA3F59E;
	Tue,  8 Apr 2025 10:16:35 -0700 (PDT)
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
Subject: [PATCH v4 5/5] tools/perf: Modify event parser to support hf-rand term
Date: Tue,  8 Apr 2025 18:15:30 +0100
Message-Id: <20250408171530.140858-6-mark.barnett@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250408171530.140858-1-mark.barnett@arm.com>
References: <20250408171530.140858-1-mark.barnett@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Gainey <ben.gainey@arm.com>

parse-events is modified, adding the "hf-rand" term which can be used to
enable enable random jitter of the sample period.

Signed-off-by: Ben Gainey <ben.gainey@arm.com>
Signed-off-by: Mark Barnett <mark.barnett@arm.com>
---
 tools/perf/tests/shell/attr/base-record           |  1 +
 tools/perf/tests/shell/attr/base-record-spe       |  1 +
 tools/perf/tests/shell/attr/base-stat             |  1 +
 tools/perf/tests/shell/attr/system-wide-dummy     |  1 +
 tools/perf/tests/shell/attr/test-record-dummy-C0  |  1 +
 .../tests/shell/attr/test-record-hf-period-rand   | 13 +++++++++++++
 tools/perf/tests/shell/lib/attr.py                |  1 +
 tools/perf/util/evsel.c                           |  1 +
 tools/perf/util/parse-events.c                    | 15 +++++++++++++++
 tools/perf/util/parse-events.h                    |  3 ++-
 tools/perf/util/parse-events.l                    |  1 +
 tools/perf/util/perf_event_attr_fprintf.c         |  1 +
 tools/perf/util/pmu.c                             |  3 ++-
 13 files changed, 41 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/tests/shell/attr/test-record-hf-period-rand

diff --git a/tools/perf/tests/shell/attr/base-record b/tools/perf/tests/shell/attr/base-record
index 8369f505dfb2..f51a20abde2e 100644
--- a/tools/perf/tests/shell/attr/base-record
+++ b/tools/perf/tests/shell/attr/base-record
@@ -40,3 +40,4 @@ branch_sample_type=0
 sample_regs_user=0
 sample_stack_user=0
 hf_sample_period=0
+hf_sample_rand=0
diff --git a/tools/perf/tests/shell/attr/base-record-spe b/tools/perf/tests/shell/attr/base-record-spe
index 2b4f051b6717..d8695abeb2b2 100644
--- a/tools/perf/tests/shell/attr/base-record-spe
+++ b/tools/perf/tests/shell/attr/base-record-spe
@@ -39,3 +39,4 @@ branch_sample_type=*
 sample_regs_user=*
 sample_stack_user=*
 hf_sample_period=0
+hf_sample_rand=0
diff --git a/tools/perf/tests/shell/attr/base-stat b/tools/perf/tests/shell/attr/base-stat
index 499c44c6216c..11df6cb36b9a 100644
--- a/tools/perf/tests/shell/attr/base-stat
+++ b/tools/perf/tests/shell/attr/base-stat
@@ -40,3 +40,4 @@ branch_sample_type=0
 sample_regs_user=0
 sample_stack_user=0
 hf_sample_period=0
+hf_sample_rand=0
diff --git a/tools/perf/tests/shell/attr/system-wide-dummy b/tools/perf/tests/shell/attr/system-wide-dummy
index 1dad060d304a..0439c81c5895 100644
--- a/tools/perf/tests/shell/attr/system-wide-dummy
+++ b/tools/perf/tests/shell/attr/system-wide-dummy
@@ -51,3 +51,4 @@ branch_sample_type=0
 sample_regs_user=0
 sample_stack_user=0
 hf_sample_period=0
+hf_sample_rand=0
diff --git a/tools/perf/tests/shell/attr/test-record-dummy-C0 b/tools/perf/tests/shell/attr/test-record-dummy-C0
index 18f0e3766389..d9eecbd5d246 100644
--- a/tools/perf/tests/shell/attr/test-record-dummy-C0
+++ b/tools/perf/tests/shell/attr/test-record-dummy-C0
@@ -54,3 +54,4 @@ branch_sample_type=0
 sample_regs_user=0
 sample_stack_user=0
 hf_sample_period=0
+hf_sample_rand=0
diff --git a/tools/perf/tests/shell/attr/test-record-hf-period-rand b/tools/perf/tests/shell/attr/test-record-hf-period-rand
new file mode 100644
index 000000000000..517ff6cbc0e9
--- /dev/null
+++ b/tools/perf/tests/shell/attr/test-record-hf-period-rand
@@ -0,0 +1,13 @@
+[config]
+command = record
+args    = --no-bpf-event -e cycles/period=3,hf-period=2,hf-rand=7/ -- kill >/dev/null 2>&1
+ret     = 1
+kernel_since = 6.15
+
+[event-10:base-record]
+sample_period=3
+hf_sample_period=2
+hf_sample_rand=7
+
+freq=0
+sample_type=7
diff --git a/tools/perf/tests/shell/lib/attr.py b/tools/perf/tests/shell/lib/attr.py
index 80c99758bd86..a9600997a9ea 100644
--- a/tools/perf/tests/shell/lib/attr.py
+++ b/tools/perf/tests/shell/lib/attr.py
@@ -86,6 +86,7 @@ class Event(dict):
         'sample_regs_user',
         'sample_stack_user',
         'hf_sample_period',
+        'hf_sample_rand',
     ]
 
     def add(self, data):
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 6e8eb34ef957..b0a54d64f616 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -181,6 +181,7 @@ static int store_event(struct perf_event_attr *attr, pid_t pid, struct perf_cpu
 	WRITE_ASS(sample_regs_user,   "llu");
 	WRITE_ASS(sample_stack_user,  PRIu32);
 	WRITE_ASS(hf_sample_period,  PRIu32);
+	WRITE_ASS(hf_sample_rand,	"d");
 
 	fclose(file);
 	return 0;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index c0943eb7f171..91e5a0d07d58 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -806,6 +806,7 @@ const char *parse_events__term_type_str(enum parse_events__term_type term_type)
 		[PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE]          = "legacy-cache",
 		[PARSE_EVENTS__TERM_TYPE_HARDWARE]              = "hardware",
 		[PARSE_EVENTS__TERM_TYPE_HF_PERIOD]		= "hf-period",
+		[PARSE_EVENTS__TERM_TYPE_HF_RAND]		= "hf-rand",
 	};
 	if ((unsigned int)term_type >= __PARSE_EVENTS__TERM_TYPE_NR)
 		return "unknown term";
@@ -835,6 +836,7 @@ config_term_avail(enum parse_events__term_type term_type, struct parse_events_er
 	case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
 	case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
 	case PARSE_EVENTS__TERM_TYPE_HF_PERIOD:
+	case PARSE_EVENTS__TERM_TYPE_HF_RAND:
 	case PARSE_EVENTS__TERM_TYPE_PERCORE:
 		return true;
 	case PARSE_EVENTS__TERM_TYPE_USER:
@@ -993,6 +995,16 @@ do {									   \
 		}
 		attr->hf_sample_period = term->val.num;
 		break;
+	case PARSE_EVENTS__TERM_TYPE_HF_RAND:
+		CHECK_TYPE_VAL(NUM);
+		if ((unsigned int)term->val.num > 15) {
+			parse_events_error__handle(err, term->err_val,
+						strdup("expected a value between 0-15"),
+						NULL);
+			return -EINVAL;
+		}
+		attr->hf_sample_rand = (unsigned int)term->val.num;
+		break;
 	case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
 	case PARSE_EVENTS__TERM_TYPE_USER:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
@@ -1121,6 +1133,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
 	case PARSE_EVENTS__TERM_TYPE_HF_PERIOD:
+	case PARSE_EVENTS__TERM_TYPE_HF_RAND:
 	default:
 		if (err) {
 			parse_events_error__handle(err, term->err_term,
@@ -1256,6 +1269,7 @@ do {								\
 		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
 		case PARSE_EVENTS__TERM_TYPE_HF_PERIOD:
+		case PARSE_EVENTS__TERM_TYPE_HF_RAND:
 		default:
 			break;
 		}
@@ -1311,6 +1325,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
 		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
 		case PARSE_EVENTS__TERM_TYPE_HF_PERIOD:
+		case PARSE_EVENTS__TERM_TYPE_HF_RAND:
 		default:
 			break;
 		}
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index a6c4f81d5989..4c2e950dcf81 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -81,7 +81,8 @@ enum parse_events__term_type {
 	PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE,
 	PARSE_EVENTS__TERM_TYPE_HARDWARE,
 	PARSE_EVENTS__TERM_TYPE_HF_PERIOD,
-#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_HF_PERIOD + 1)
+	PARSE_EVENTS__TERM_TYPE_HF_RAND,
+#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_HF_RAND + 1)
 };
 
 struct parse_events_term {
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 482321ace228..b60b5e796d3a 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -336,6 +336,7 @@ aux-action		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_ACTION); }
 aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
 metric-id		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_METRIC_ID); }
 hf-period		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_HF_PERIOD); }
+hf-rand			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_HF_RAND); }
 cpu-cycles|cycles				{ return hw_term(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
 stalled-cycles-frontend|idle-cycles-frontend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
 stalled-cycles-backend|idle-cycles-backend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index c93904a299af..3d769a10304b 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -361,6 +361,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(aux_pause, p_unsigned);
 	PRINT_ATTRf(aux_resume, p_unsigned);
 	PRINT_ATTRf(hf_sample_period, p_unsigned);
+	PRINT_ATTRf(hf_sample_rand, p_unsigned);
 
 	return ret;
 }
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index f90c59e29371..f735216e88c1 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1429,7 +1429,7 @@ static int pmu_config_term(const struct perf_pmu *pmu,
 			break;
 		case PARSE_EVENTS__TERM_TYPE_USER: /* Not hardcoded. */
 			return -EINVAL;
-		case PARSE_EVENTS__TERM_TYPE_NAME ... PARSE_EVENTS__TERM_TYPE_HF_PERIOD:
+		case PARSE_EVENTS__TERM_TYPE_NAME ... PARSE_EVENTS__TERM_TYPE_HF_RAND:
 			/* Skip non-config terms. */
 			break;
 		default:
@@ -1805,6 +1805,7 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_call
 		"aux-action=(pause|resume|start-paused)",
 		"aux-sample-size=number",
 		"hf-period=number",
+		"hf-period-rand=number",
 	};
 	struct perf_pmu_format *format;
 	int ret;
-- 
2.43.0

