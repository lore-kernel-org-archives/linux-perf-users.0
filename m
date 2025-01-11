Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9AC2063DF
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Jan 2025 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736622143; cv=none; b=RWoctqiSnkspFKU/GyiFUxC1B9ZmX75YDkimQ8QpSqjjhq5CLnnzhyDym1fynJmgonjgT5pyKeNDI4GrvlYXH/l0T/3pVYR4BEBaqVNue9OCCJsGLAPfh4GYos+ZG5CjI6pErud/ywxGe+LCFRoGNG/bMILqzM37RzA5qQwbB4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736622143; c=relaxed/simple;
	bh=/roHgxl4topwQoL1kMWCyPYwO0i7fyXF4yOIiKBypTc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ElTyUkpOwhiN00FePcyguZ3RdeDRpJN4UgxqRPf5uWbBcfe6x+ZNQ43EH7vv+nLQNBZ0ESC3AY2FO+LYCcKaGU5iQ7rqNvR4aKG+kVfMX2KCdSmLuOo9/7XzFuJhbl7UylxfbGVWBt8LJmefwBSSBe8Sc2KFFnuCtjBOzyTEE+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T/BFbG5H; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T/BFbG5H"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e54cb50c3baso7982792276.0
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Jan 2025 11:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736622140; x=1737226940; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qcgF6E7+eiK+NAo9Q4VlEcUnRBx5yQADIcdso2yBf7o=;
        b=T/BFbG5HowNuUhwfb439dWfaxM/rQDHqQ9TGwxMAgGSK19h7+SExkJh/Wz65T/0nFy
         Wug5CzngIjzRgTR+/ifpogRnRo6R2Q/yQ6mHLSEskEJzYJXobCNZOaH90caCYzNXcR0s
         b13sWRxPK1poHpEExESaQ239L9TLug7AfFlVoRNchAckJ1/Sk8YFRpA8Jxn8MxHLG2oh
         rIgrCb4z/0ZvWDYl9Lx55HvvdpFD/g3jqvkpAWy1VGBDZkTv14Kh/Q2JWvgmJqCZz5m0
         Yl5dLCcW8bBfy3z72IN9Vh75MzvLdbdhiIVlwudAPnKvw6Pc/GzHrYWHnyCY4bDtQ5XB
         w1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736622140; x=1737226940;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qcgF6E7+eiK+NAo9Q4VlEcUnRBx5yQADIcdso2yBf7o=;
        b=XaHtxiPsUTQ+gXxXaVkqVDRxU7AC3OMNn41KUUjh0ciTBIVoG0PR0WcL+bhNUejrVi
         LezVt4sP4NPYmh2nQFTmyEDi8w98HEMlEhFea+g97rt4itS4fvb/uDMe6+75ktXeiahj
         X6jMDbppBY/K+OSrIvooG91AivqpgMolUPn9IY59wFkkwdW3/PV/KvdLXdfsPtB24bcn
         IQHmbZcyLIC5KIHzXQ6iIo+OMYDYW/n2QmxMa3TQ0YgNNWccu6TftCKnKq+MFC2SDWyd
         PUlWEWlMM+/vF4ydsHT91NoRU/q/LtCNQ1+MNnyCn7zWKp0Y6nIGywhM27SHN85qbYV1
         q6Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWKFmMRu21C6l1viMMcUSfk+kYdfkiaj54l7e5vQN2lZj1moqNv1SWXgPi14Cb5Ngan3/FrvWdHGp/H3gHVYM2E@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdsrt9aXRu5xpAEe87qPZ+A4Kn5+qatdtXWDW0+VwOsZyNZt62
	YZU3mHAYD2PlWlNWueXL9D0qbtTUjl7KwDqhOTgWL7SEBur0GG6ZxiLY4i0Sesw7BfVCm3IlsCT
	G+a/EIg==
X-Google-Smtp-Source: AGHT+IGqi1ieIy6ibB+gmdy1+0OS1MzIUCz+Zygrb0C2lnKOtAF2Kkq1kb0ZyP5886FXD+PjtR1wTi3samI7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8807:d7c5:bb27:35fc])
 (user=irogers job=sendgmr) by 2002:a25:20c2:0:b0:e4d:c8d5:81ef with SMTP id
 3f1490d57ef6-e550136cda0mr43300276.0.1736622140578; Sat, 11 Jan 2025 11:02:20
 -0800 (PST)
Date: Sat, 11 Jan 2025 11:01:42 -0800
In-Reply-To: <20250111190143.1029906-1-irogers@google.com>
Message-Id: <20250111190143.1029906-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250111190143.1029906-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 09/10] perf target: Remove uid from target
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Hao Ge <gehao@kylinos.cn>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Levi Yun <yeoreum.yun@arm.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Tengda Wu <wutengda@huaweicloud.com>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Gathering threads with a uid by scanning /proc is inherently racy
leading to perf_event_open failures that quit perf. All users of the
functionality now use BPF filters, so remove uid and uid_str from
target.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-ftrace.c                 |  1 -
 tools/perf/builtin-kvm.c                    |  2 -
 tools/perf/builtin-stat.c                   |  4 +-
 tools/perf/builtin-trace.c                  |  1 -
 tools/perf/tests/backward-ring-buffer.c     |  1 -
 tools/perf/tests/event-times.c              |  4 +-
 tools/perf/tests/openat-syscall-tp-fields.c |  1 -
 tools/perf/tests/perf-record.c              |  1 -
 tools/perf/tests/task-exit.c                |  1 -
 tools/perf/util/bpf-filter.c                |  2 +-
 tools/perf/util/evlist.c                    |  3 +-
 tools/perf/util/target.c                    | 46 +--------------------
 tools/perf/util/target.h                    | 12 +-----
 13 files changed, 6 insertions(+), 73 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 08c1cc429b27..e7947cfa3497 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -1572,7 +1572,6 @@ int cmd_ftrace(int argc, const char **argv)
 	int (*cmd_func)(struct perf_ftrace *) = NULL;
 	struct perf_ftrace ftrace = {
 		.tracer = DEFAULT_TRACER,
-		.target = { .uid = UINT_MAX, },
 	};
 	const struct option common_options[] = {
 	OPT_STRING('p', "pid", &ftrace.target.pid, "pid",
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 67fd2b006b0b..d75bd3684980 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1871,8 +1871,6 @@ static int kvm_events_live(struct perf_kvm_stat *kvm,
 	kvm->opts.user_interval = 1;
 	kvm->opts.mmap_pages = 512;
 	kvm->opts.target.uses_mmap = false;
-	kvm->opts.target.uid_str = NULL;
-	kvm->opts.target.uid = UINT_MAX;
 
 	symbol__init(NULL);
 	disable_buildid_cache();
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 77e327d4a9a7..dec47552a294 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -108,9 +108,7 @@ static struct parse_events_option_args parse_events_option_args = {
 
 static bool all_counters_use_bpf = true;
 
-static struct target target = {
-	.uid	= UINT_MAX,
-};
+static struct target target;
 
 static volatile sig_atomic_t	child_pid			= -1;
 static int			detailed_run			=  0;
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 4b9a34c9179f..3c4d696da12e 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -5092,7 +5092,6 @@ int cmd_trace(int argc, const char **argv)
 	struct trace trace = {
 		.opts = {
 			.target = {
-				.uid	   = UINT_MAX,
 				.uses_mmap = true,
 			},
 			.user_freq     = UINT_MAX,
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index 79a980b1e786..c5e7999f2817 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -91,7 +91,6 @@ static int test__backward_ring_buffer(struct test_suite *test __maybe_unused, in
 	struct parse_events_error parse_error;
 	struct record_opts opts = {
 		.target = {
-			.uid = UINT_MAX,
 			.uses_mmap = true,
 		},
 		.freq	      = 0,
diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index deefe5003bfc..2148024b4f4a 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -17,9 +17,7 @@
 static int attach__enable_on_exec(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__last(evlist);
-	struct target target = {
-		.uid = UINT_MAX,
-	};
+	struct target target = {};
 	const char *argv[] = { "true", NULL, };
 	char sbuf[STRERR_BUFSIZE];
 	int err;
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 3943da441979..30bd521e65b4 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -28,7 +28,6 @@ static int test__syscall_openat_tp_fields(struct test_suite *test __maybe_unused
 {
 	struct record_opts opts = {
 		.target = {
-			.uid = UINT_MAX,
 			.uses_mmap = true,
 		},
 		.no_buffering = true,
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 1c4feec1adff..ed1dabd9e87b 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -45,7 +45,6 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 {
 	struct record_opts opts = {
 		.target = {
-			.uid = UINT_MAX,
 			.uses_mmap = true,
 		},
 		.no_buffering = true,
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 8e328bbd509d..4053ff2813bb 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -46,7 +46,6 @@ static int test__task_exit(struct test_suite *test __maybe_unused, int subtest _
 	struct evsel *evsel;
 	struct evlist *evlist;
 	struct target target = {
-		.uid		= UINT_MAX,
 		.uses_mmap	= true,
 	};
 	const char *argv[] = { "true", NULL };
diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index a4fdf6911ec1..ed4845ff4a10 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -449,7 +449,7 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 	struct bpf_program *prog;
 	struct bpf_link *link;
 	struct perf_bpf_filter_entry *entry;
-	bool needs_idx_hash = !target__has_cpu(target) && !target->uid_str;
+	bool needs_idx_hash = !target__has_cpu(target);
 
 	entry = calloc(MAX_FILTERS, sizeof(*entry));
 	if (entry == NULL)
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index f0dd174e2deb..1fd91b5e8777 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1006,8 +1006,7 @@ int evlist__create_maps(struct evlist *evlist, struct target *target)
 	 * per-thread data. thread_map__new_str will call
 	 * thread_map__new_all_cpus to enumerate all threads.
 	 */
-	threads = thread_map__new_str(target->pid, target->tid, target->uid,
-				      all_threads);
+	threads = thread_map__new_str(target->pid, target->tid, UINT_MAX, all_threads);
 
 	if (!threads)
 		return -1;
diff --git a/tools/perf/util/target.c b/tools/perf/util/target.c
index f3ad59ccfa99..8cf71bea295a 100644
--- a/tools/perf/util/target.c
+++ b/tools/perf/util/target.c
@@ -28,20 +28,6 @@ enum target_errno target__validate(struct target *target)
 			ret = TARGET_ERRNO__PID_OVERRIDE_CPU;
 	}
 
-	/* UID and PID are mutually exclusive */
-	if (target->tid && target->uid_str) {
-		target->uid_str = NULL;
-		if (ret == TARGET_ERRNO__SUCCESS)
-			ret = TARGET_ERRNO__PID_OVERRIDE_UID;
-	}
-
-	/* UID and CPU are mutually exclusive */
-	if (target->uid_str && target->cpu_list) {
-		target->cpu_list = NULL;
-		if (ret == TARGET_ERRNO__SUCCESS)
-			ret = TARGET_ERRNO__UID_OVERRIDE_CPU;
-	}
-
 	/* PID and SYSTEM are mutually exclusive */
 	if (target->tid && target->system_wide) {
 		target->system_wide = false;
@@ -49,13 +35,6 @@ enum target_errno target__validate(struct target *target)
 			ret = TARGET_ERRNO__PID_OVERRIDE_SYSTEM;
 	}
 
-	/* UID and SYSTEM are mutually exclusive */
-	if (target->uid_str && target->system_wide) {
-		target->system_wide = false;
-		if (ret == TARGET_ERRNO__SUCCESS)
-			ret = TARGET_ERRNO__UID_OVERRIDE_SYSTEM;
-	}
-
 	/* BPF and CPU are mutually exclusive */
 	if (target->bpf_str && target->cpu_list) {
 		target->cpu_list = NULL;
@@ -70,13 +49,6 @@ enum target_errno target__validate(struct target *target)
 			ret = TARGET_ERRNO__BPF_OVERRIDE_PID;
 	}
 
-	/* BPF and UID are mutually exclusive */
-	if (target->bpf_str && target->uid_str) {
-		target->uid_str = NULL;
-		if (ret == TARGET_ERRNO__SUCCESS)
-			ret = TARGET_ERRNO__BPF_OVERRIDE_UID;
-	}
-
 	/* BPF and THREADS are mutually exclusive */
 	if (target->bpf_str && target->per_thread) {
 		target->per_thread = false;
@@ -124,31 +96,19 @@ uid_t parse_uid(const char *str)
 	return result->pw_uid;
 }
 
-enum target_errno target__parse_uid(struct target *target)
-{
-	target->uid = parse_uid(target->uid_str);
-
-	return target->uid != UINT_MAX ? TARGET_ERRNO__SUCCESS : TARGET_ERRNO__INVALID_UID;
-}
-
 /*
  * This must have a same ordering as the enum target_errno.
  */
 static const char *target__error_str[] = {
 	"PID/TID switch overriding CPU",
-	"PID/TID switch overriding UID",
-	"UID switch overriding CPU",
 	"PID/TID switch overriding SYSTEM",
-	"UID switch overriding SYSTEM",
 	"SYSTEM/CPU switch overriding PER-THREAD",
 	"BPF switch overriding CPU",
 	"BPF switch overriding PID/TID",
-	"BPF switch overriding UID",
 	"BPF switch overriding THREAD",
-	"Invalid User: %s",
 };
 
-int target__strerror(struct target *target, int errnum,
+int target__strerror(struct target *target __maybe_unused, int errnum,
 			  char *buf, size_t buflen)
 {
 	int idx;
@@ -173,10 +133,6 @@ int target__strerror(struct target *target, int errnum,
 		snprintf(buf, buflen, "%s", msg);
 		break;
 
-	case TARGET_ERRNO__INVALID_UID:
-		snprintf(buf, buflen, msg, target->uid_str);
-		break;
-
 	default:
 		/* cannot reach here */
 		break;
diff --git a/tools/perf/util/target.h b/tools/perf/util/target.h
index e082bda990fb..84ebb9c940c6 100644
--- a/tools/perf/util/target.h
+++ b/tools/perf/util/target.h
@@ -9,9 +9,7 @@ struct target {
 	const char   *pid;
 	const char   *tid;
 	const char   *cpu_list;
-	const char   *uid_str;
 	const char   *bpf_str;
-	uid_t	     uid;
 	bool	     system_wide;
 	bool	     uses_mmap;
 	bool	     default_per_cpu;
@@ -36,32 +34,24 @@ enum target_errno {
 
 	/* for target__validate() */
 	TARGET_ERRNO__PID_OVERRIDE_CPU	= __TARGET_ERRNO__START,
-	TARGET_ERRNO__PID_OVERRIDE_UID,
-	TARGET_ERRNO__UID_OVERRIDE_CPU,
 	TARGET_ERRNO__PID_OVERRIDE_SYSTEM,
-	TARGET_ERRNO__UID_OVERRIDE_SYSTEM,
 	TARGET_ERRNO__SYSTEM_OVERRIDE_THREAD,
 	TARGET_ERRNO__BPF_OVERRIDE_CPU,
 	TARGET_ERRNO__BPF_OVERRIDE_PID,
-	TARGET_ERRNO__BPF_OVERRIDE_UID,
 	TARGET_ERRNO__BPF_OVERRIDE_THREAD,
 
-	/* for target__parse_uid() */
-	TARGET_ERRNO__INVALID_UID,
-
 	__TARGET_ERRNO__END,
 };
 
 enum target_errno target__validate(struct target *target);
 
 uid_t parse_uid(const char *str);
-enum target_errno target__parse_uid(struct target *target);
 
 int target__strerror(struct target *target, int errnum, char *buf, size_t buflen);
 
 static inline bool target__has_task(struct target *target)
 {
-	return target->tid || target->pid || target->uid_str;
+	return target->tid || target->pid;
 }
 
 static inline bool target__has_cpu(struct target *target)
-- 
2.47.1.613.gc27f4b7a9f-goog

