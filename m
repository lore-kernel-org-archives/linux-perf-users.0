Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7EF293B51
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Apr 2025 17:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306627; cv=none; b=IhQX6F9SyelcNLl+UZkhAz4CDBBFfVj886dC8g2aIxghMfsiSKc5DON5/lwRKUz2Q5p0aOjyMFIAvJNLyoXoX3L328tCSavf5EWn7h5U2FtQaWUgrsQJq0AUXjLLSFECZy/Azd+UxGhKpQps4o5iijuqHlFck4cf3Z1/9tOUMWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306627; c=relaxed/simple;
	bh=Bej04MyJsrdcV+Qp3WUuLZDsRwPz0V7gB+75yBJO4Po=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=uQIrZmc6ewLaZGY45DnASzg+1FkwUhTRFIQ5cG6Uon/OKuZmFu10FURveLo4PSc3KHATt8QicSNoBkj9tB0YPmXrBNjBU2+bZWIO2AfzbbRYJ9SHHpiwDhvGz3CtoEr2tB622VEjoy8MrSjsL1i+FFGUCLVr7GJl8CqrtHJXnug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ca7UbY30; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ca7UbY30"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff798e8c3bso1114183a91.2
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Apr 2025 10:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744306625; x=1744911425; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8wRgy6qZn0MUN5UByz3xQmmdwU9nj6FopesVn3TNXNM=;
        b=Ca7UbY30Xgclo8rkRVOimv7711/FVIkGLNwNZEQScmQkxImuyZ6PgsT/FiB8puoWCy
         FSfbhsreAtKp4O0B9HXXcbLbrZBn4T7Jz2F97XtOzYXYQnHOe2KlzTZd3jpajh3kc6B5
         ykdYldr/+umWg7TVIAgUcIcDX97J2PfPMJcSyLFpMZka7zgrxZqXllMfAoRo05wWNkLD
         zKWBQHWlHBV0yEgwFuvcMI4rbtSSjFyRaizhQvnh3hiSsSlixt1HJ5HzZBwY9E8cm79R
         dXZdwM13TOrWyXbxu46o7yZxYfR54nDpSAg7yUvVqafW3yvxiSY8XTgFGrSHxB80XKWy
         u9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744306625; x=1744911425;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8wRgy6qZn0MUN5UByz3xQmmdwU9nj6FopesVn3TNXNM=;
        b=jc/DrdWygZkmDQ/RfVXiYuEhDl4hsoAZksUgpMpkY7lgHHxYTm6Z+kEHj3P9DP8vjx
         KiY4rcsdHWb2uqA4NdCdRtNvzN5BQqpXBggGvf/8NNtRRjEgHb4rl6Pt33YkMaIolIjm
         sQi8evw8NH6bZPYtjzZIAlPY7WiH5b9Tv8az6OnGozcdjbHPQuEhiILCVh0FOW9QeAi0
         G9HlYXtXjXfvDIzA9l1CHPNV355rL0FrvpPokjSL3hCBgb47rkL3I3vXRvL5yjSot3M2
         OFrmo2FnTrhGn3HIwzJYA+M1SVdqxTZvnS9FXlntxoSUrmLrEz18arK0jt6zkKCpnVYQ
         ODNw==
X-Forwarded-Encrypted: i=1; AJvYcCXIQE6dIbrlyLoSpqdkIb6+wXKLQsiAIoigSIaffi2cKxQFDmDKHWN1+sdKATPaIOlxfOmmFHrcgCmYNb4OyVsK@vger.kernel.org
X-Gm-Message-State: AOJu0YzwyBDkf9fJ/e5xj38HfS85h/fnWs1II6v9A8XhK5hgV83d+lXC
	SfuBrY88hmU7kwa1r09h3za72CUH8fEeaSU0CMsURQGn+o6subU5GtYr+RFB+uidCbZq0+aEAPd
	x9c5mMA==
X-Google-Smtp-Source: AGHT+IGwzdSEoZrbjGfvRdfYeF1YnLx54YlVys0YEVqHBYv0YviwgXIHn/5uA7xwE2RZKnmyH8fOzMvVcfs5
X-Received: from pjbsw3.prod.google.com ([2002:a17:90b:2c83:b0:301:a339:b558])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2804:b0:2fe:d766:ad8e
 with SMTP id 98e67ed59e1d1-307e590a8b3mr5281918a91.4.1744306625275; Thu, 10
 Apr 2025 10:37:05 -0700 (PDT)
Date: Thu, 10 Apr 2025 10:36:30 -0700
In-Reply-To: <20250410173631.1713627-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250410173631.1713627-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250410173631.1713627-12-irogers@google.com>
Subject: [PATCH v2 11/12] perf target: Remove uid from target
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Levi Yun <yeoreum.yun@arm.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
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
index 7caa18d5ffc3..ae901f2a18ef 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -1590,7 +1590,6 @@ int cmd_ftrace(int argc, const char **argv)
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
index 68ea7589c143..22ec1d0702e7 100644
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
index 1f7d2b3d8b3d..aa0a27dd7d21 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -5374,7 +5374,6 @@ int cmd_trace(int argc, const char **argv)
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
index 0ef4ba7c1571..2a139d2781a8 100644
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
index 0958c7c8995f..0b3c37e66871 100644
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
index c1a04141aed0..2e1f14bc8461 100644
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
2.49.0.604.gff1f9ca942-goog

