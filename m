Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0B02D9EEA
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Nov 2025 23:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763595390; cv=none; b=AavrVwApU4arB8hw4e5WUsuWyYG5C5TzLYlFsqZUOvjQbUUqKWAinq3dGcnCupGgrelDL+9w1rwJc7o0yp4EMORr6SgRtmESe9s8iGYun86vdcPSv5ajXTjhAaNoehE7PH6HKdDcNax/jw0HOl7ZZIrH4oigaMvaGP1SEKKQ1YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763595390; c=relaxed/simple;
	bh=Dg7hWnxuUk43bpILP+XMAlL3QrPodJYxTDN1t26at2M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=AlK1ddNMxFuBlqDnlcrcDc0lkI/ZtMeavkDK4mBKB51s2HxncqdozwXA4Ocp+vtMO/OPWF8QvPeMcrmJ6KyaPh0GjPf2CDUaQs2d4sVgBenRCINtyl6AWM3Yxo0Vv3ijrqcFTkgqg9xGOd41yh5yaFpLYF0p4yY8AWYC4r3pjZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MVFqln0x; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MVFqln0x"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b969f3f5bb1so454014a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Nov 2025 15:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763595387; x=1764200187; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bHW/GaNoFbRZVR3S61Ix+T3OONd1Qc6j2RpAOMNedBA=;
        b=MVFqln0xLRlxBMCKs5kLfZL18/SLGz7zaCBsEYqZ0WrrAdC0YuOcjboB8oXXs8ik2y
         Yj7caVmg200TzNeGmZq+duEWNN8aB8MT0GKBw0ID6yUCgB1mkHfQi+ljXrpy4/MlkmMk
         2BAUSz1KFF/jJ7YZgtNzhLg+amB7Vj3s7jj0H/nwoejgSBRrm4xdWse3s+fEtkfFPvzu
         pAq4irhMjDBtticCPAx5KfqYIvhDAcfYirBdb4eOcoR9pzMz8HKdaVhUS3Mrw2U0vMyU
         enKHxz3uMCUaB9QRW4oXJfp4rGY+mJCG/5ibvvtaIyx5D5yMECMaoDY/+RqH82ez4jAk
         GZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763595387; x=1764200187;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bHW/GaNoFbRZVR3S61Ix+T3OONd1Qc6j2RpAOMNedBA=;
        b=sp3Py+sgnFbznIxABhJQ3bEwykat/0y7FBR9p8xtZzDbl9Hz7toJe3FMp5rPMPmri+
         Jwuq8XDqEFn3vR/5G6DErscvnuRJG82KoULLMRaavKKMIFfwDhouY8LxDTG3696Nsby5
         ORoVrmUlvlQ0eRqTtGL+6BTjlLpGIpzwBx2HLjd8A6jA0iTTwa/bRg34OhSX9Jkj0l0w
         pXIRGOEIdg4UX4945uTq7psfKfCOdUkBYiUiPt47ZVLgo/GsVDK5lWM5SsGe4YnXuHoX
         O2cAa+/keqlpZQjP77IEL4owiQzlgKv6sVtXFsvQS/PIEUVped6WQ28XwH40RPHwY//P
         lwLA==
X-Forwarded-Encrypted: i=1; AJvYcCWR0ju7JFOk99BMM+f16qP+yiEsdOa5eyM90p05rvaOcriIdEXHFATfeYCi7tPPyV8mwKUik3kkiLzAFABrS2fT@vger.kernel.org
X-Gm-Message-State: AOJu0YyXv0oNowh36hAf6/+NFnDB/8yLwEfKLyUcTxNa+WPOa90ScgPP
	TC+ZIjwk7UKBsFA6ujuWqAwOR1lJIVxaKNHbpAnrdQJD7+R2UYveUlOXbydk+zvNGCF89ykSIpw
	qYxo7Oy4Llw==
X-Google-Smtp-Source: AGHT+IG0eeSM8eKc9weufh+63MdsNuxVtahs3rd6PaPQgfa6CC6A98w23ZwyCJiql7L/46bOn5LX+T4B7n+y
X-Received: from dybb16.prod.google.com ([2002:a05:693c:6090:b0:2a4:766f:831a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:cd45:b0:2a4:3593:c7dd
 with SMTP id 5a478bee46e88-2a6fd153096mr517483eec.29.1763595386834; Wed, 19
 Nov 2025 15:36:26 -0800 (PST)
Date: Wed, 19 Nov 2025 15:36:21 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251119233621.2343909-1-irogers@google.com>
Subject: [PATCH v1] perf: Switch printf("...%s", strerror(errno)) to printf("...%m")
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Blake Jones <blakejones@google.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Chun-Tse Shao <ctshao@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Howard Chu <howardchu95@gmail.com>, Yunseong Kim <ysk@kzalloc.com>, Leo Yan <leo.yan@arm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

strerror has thread safety issues, strerror_r requires stack allocated
buffers. Code in perf has already been using the "%m" formatting flag
that is a widely support glibc extension to print the current errno's
description. Expand the usage of this formatting flag and remove usage
of strerror/strerror_r.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/tests/bp-modify.c | 30 +++++++++++---------------
 tools/perf/bench/uprobe.c             |  2 +-
 tools/perf/builtin-daemon.c           |  8 +++----
 tools/perf/builtin-probe.c            |  3 +--
 tools/perf/builtin-record.c           | 24 +++++++++------------
 tools/perf/builtin-stat.c             |  9 ++++----
 tools/perf/builtin-trace.c            | 15 ++++++-------
 tools/perf/perf.c                     | 18 ++++++----------
 tools/perf/util/bpf-event.c           | 11 ++++------
 tools/perf/util/bpf-utils.c           |  4 ++--
 tools/perf/util/bpf_lock_contention.c |  2 +-
 tools/perf/util/cap.c                 |  3 +--
 tools/perf/util/data.c                | 29 +++++++++----------------
 tools/perf/util/dso.c                 | 19 ++++++----------
 tools/perf/util/evlist.c              | 31 +++++++++++++++------------
 tools/perf/util/evsel.c               | 17 ++++++++-------
 tools/perf/util/jitdump.c             |  3 ++-
 tools/perf/util/lzma.c                |  6 +++---
 tools/perf/util/session.c             |  5 +++--
 tools/perf/util/symbol-elf.c          |  4 ++--
 20 files changed, 104 insertions(+), 139 deletions(-)

diff --git a/tools/perf/arch/x86/tests/bp-modify.c b/tools/perf/arch/x86/tests/bp-modify.c
index 0924ccd9e36d..589b43273948 100644
--- a/tools/perf/arch/x86/tests/bp-modify.c
+++ b/tools/perf/arch/x86/tests/bp-modify.c
@@ -80,26 +80,24 @@ static int bp_modify1(void)
 	 */
 	if (ptrace(PTRACE_POKEUSER, child,
 		   offsetof(struct user, u_debugreg[0]), bp_2)) {
-		pr_debug("failed to set breakpoint, 1st time: %s\n",
-			 strerror(errno));
+		pr_debug("failed to set breakpoint, 1st time: %m\n");
 		goto out;
 	}
 
 	if (ptrace(PTRACE_POKEUSER, child,
 		   offsetof(struct user, u_debugreg[0]), bp_1)) {
-		pr_debug("failed to set breakpoint, 2nd time: %s\n",
-			 strerror(errno));
+		pr_debug("failed to set breakpoint, 2nd time: %m\n");
 		goto out;
 	}
 
 	if (ptrace(PTRACE_POKEUSER, child,
 		   offsetof(struct user, u_debugreg[7]), dr7)) {
-		pr_debug("failed to set dr7: %s\n", strerror(errno));
+		pr_debug("failed to set dr7: %m\n");
 		goto out;
 	}
 
 	if (ptrace(PTRACE_CONT, child, NULL, NULL)) {
-		pr_debug("failed to PTRACE_CONT: %s\n", strerror(errno));
+		pr_debug("failed to PTRACE_CONT: %m\n");
 		goto out;
 	}
 
@@ -112,19 +110,17 @@ static int bp_modify1(void)
 	rip = ptrace(PTRACE_PEEKUSER, child,
 		     offsetof(struct user_regs_struct, rip), NULL);
 	if (rip == (unsigned long) -1) {
-		pr_debug("failed to PTRACE_PEEKUSER: %s\n",
-			 strerror(errno));
+		pr_debug("failed to PTRACE_PEEKUSER: %m\n");
 		goto out;
 	}
 
 	pr_debug("rip %lx, bp_1 %p\n", rip, bp_1);
-
 out:
 	if (ptrace(PTRACE_DETACH, child, NULL, NULL)) {
-		pr_debug("failed to PTRACE_DETACH: %s", strerror(errno));
+		pr_debug("failed to PTRACE_DETACH: %m\n");
 		return TEST_FAIL;
-	}
 
+	}
 	return rip == (unsigned long) bp_1 ? TEST_OK : TEST_FAIL;
 }
 
@@ -157,14 +153,13 @@ static int bp_modify2(void)
 	 */
 	if (ptrace(PTRACE_POKEUSER, child,
 		   offsetof(struct user, u_debugreg[0]), bp_1)) {
-		pr_debug("failed to set breakpoint: %s\n",
-			 strerror(errno));
+		pr_debug("failed to set breakpoint: %m\n");
 		goto out;
 	}
 
 	if (ptrace(PTRACE_POKEUSER, child,
 		   offsetof(struct user, u_debugreg[7]), dr7)) {
-		pr_debug("failed to set dr7: %s\n", strerror(errno));
+		pr_debug("failed to set dr7: %m\n");
 		goto out;
 	}
 
@@ -175,7 +170,7 @@ static int bp_modify2(void)
 	}
 
 	if (ptrace(PTRACE_CONT, child, NULL, NULL)) {
-		pr_debug("failed to PTRACE_CONT: %s\n", strerror(errno));
+		pr_debug("failed to PTRACE_CONT: %m\n");
 		goto out;
 	}
 
@@ -188,8 +183,7 @@ static int bp_modify2(void)
 	rip = ptrace(PTRACE_PEEKUSER, child,
 		     offsetof(struct user_regs_struct, rip), NULL);
 	if (rip == (unsigned long) -1) {
-		pr_debug("failed to PTRACE_PEEKUSER: %s\n",
-			 strerror(errno));
+		pr_debug("failed to PTRACE_PEEKUSER: %m\n");
 		goto out;
 	}
 
@@ -197,7 +191,7 @@ static int bp_modify2(void)
 
 out:
 	if (ptrace(PTRACE_DETACH, child, NULL, NULL)) {
-		pr_debug("failed to PTRACE_DETACH: %s", strerror(errno));
+		pr_debug("failed to PTRACE_DETACH: %m\n");
 		return TEST_FAIL;
 	}
 
diff --git a/tools/perf/bench/uprobe.c b/tools/perf/bench/uprobe.c
index 0b90275862e1..c4dac868f1ee 100644
--- a/tools/perf/bench/uprobe.c
+++ b/tools/perf/bench/uprobe.c
@@ -54,7 +54,7 @@ static const char * const bench_uprobe_usage[] = {
 							   /*opts=*/&uprobe_opts); \
 	if (!skel->links.prog) { \
 		err = -errno; \
-		fprintf(stderr, "Failed to attach bench uprobe \"%s\": %s\n", #prog, strerror(errno)); \
+		fprintf(stderr, "Failed to attach bench uprobe \"%s\": %m\n", #prog); \
 		goto cleanup; \
 	}
 
diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index f0568431fbd5..33473e071392 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -265,8 +265,7 @@ static int check_base(struct daemon *daemon)
 			       daemon->base);
 			return -EACCES;
 		default:
-			pr_err("failed: can't access base '%s': %s\n",
-			       daemon->base, strerror(errno));
+			pr_err("failed: can't access base '%s': %m\n", daemon->base);
 			return -errno;
 		}
 	}
@@ -544,8 +543,7 @@ static int daemon_session__control(struct daemon_session *session,
 
 	err = writen(control, msg, len);
 	if (err != len) {
-		pr_err("failed: write to control pipe: %d (%s)\n",
-		       errno, control_path);
+		pr_err("failed: write to control pipe: %m (%s)\n", control_path);
 		goto out;
 	}
 
@@ -586,7 +584,7 @@ static int setup_server_socket(struct daemon *daemon)
 	int fd = socket(AF_UNIX, SOCK_STREAM, 0);
 
 	if (fd < 0) {
-		fprintf(stderr, "socket: %s\n", strerror(errno));
+		fprintf(stderr, "socket: %m\n");
 		return -1;
 	}
 
diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 69800e4d9530..1b4ba85ee019 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -211,8 +211,7 @@ static int opt_set_target_ns(const struct option *opt __maybe_unused,
 		ns_pid = (pid_t)strtol(str, NULL, 10);
 		if (errno != 0) {
 			ret = -errno;
-			pr_warning("Failed to parse %s as a pid: %s\n", str,
-				   strerror(errno));
+			pr_warning("Failed to parse %s as a pid: %m\n", str);
 			return ret;
 		}
 		nsip = nsinfo__new(ns_pid);
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 2584d0d8bc82..b41236c0dc8b 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1286,7 +1286,6 @@ static int record__mmap_evlist(struct record *rec,
 	struct record_opts *opts = &rec->opts;
 	bool auxtrace_overwrite = opts->auxtrace_snapshot_mode ||
 				  opts->auxtrace_sample_mode;
-	char msg[512];
 
 	if (opts->affinity != PERF_AFFINITY_SYS)
 		cpu__setup_cpunode_map();
@@ -1305,8 +1304,7 @@ static int record__mmap_evlist(struct record *rec,
 			       opts->mmap_pages, opts->auxtrace_mmap_pages);
 			return -errno;
 		} else {
-			pr_err("failed to mmap with %d (%s)\n", errno,
-				str_error_r(errno, msg, sizeof(msg)));
+			pr_err("failed to mmap: %m\n");
 			if (errno)
 				return -errno;
 			else
@@ -1324,7 +1322,8 @@ static int record__mmap_evlist(struct record *rec,
 	if (record__threads_enabled(rec)) {
 		ret = perf_data__create_dir(&rec->data, evlist->core.nr_mmaps);
 		if (ret) {
-			pr_err("Failed to create data directory: %s\n", strerror(-ret));
+			errno = -ret;
+			pr_err("Failed to create data directory: %m\n");
 			return ret;
 		}
 		for (i = 0; i < evlist->core.nr_mmaps; i++) {
@@ -1461,9 +1460,8 @@ static int record__open(struct record *rec)
 	}
 
 	if (evlist__apply_filters(evlist, &pos, &opts->target)) {
-		pr_err("failed to set filter \"%s\" on event %s with %d (%s)\n",
-			pos->filter ?: "BPF", evsel__name(pos), errno,
-			str_error_r(errno, msg, sizeof(msg)));
+		pr_err("failed to set filter \"%s\" on event %s: %m\n",
+			pos->filter ?: "BPF", evsel__name(pos));
 		rc = -1;
 		goto out;
 	}
@@ -1748,8 +1746,7 @@ static void *record__thread(void *arg)
 
 	err = write(thread->pipes.ack[1], &msg, sizeof(msg));
 	if (err == -1)
-		pr_warning("threads[%d]: failed to notify on start: %s\n",
-			   thread->tid, strerror(errno));
+		pr_warning("threads[%d]: failed to notify on start: %m\n", thread->tid);
 
 	pr_debug("threads[%d]: started on cpu%d\n", thread->tid, sched_getcpu());
 
@@ -1792,8 +1789,7 @@ static void *record__thread(void *arg)
 
 	err = write(thread->pipes.ack[1], &msg, sizeof(msg));
 	if (err == -1)
-		pr_warning("threads[%d]: failed to notify on termination: %s\n",
-			   thread->tid, strerror(errno));
+		pr_warning("threads[%d]: failed to notify on termination: %m\n", thread->tid);
 
 	return NULL;
 }
@@ -2338,7 +2334,7 @@ static int record__start_threads(struct record *rec)
 
 	sigfillset(&full);
 	if (sigprocmask(SIG_SETMASK, &full, &mask)) {
-		pr_err("Failed to block signals on threads start: %s\n", strerror(errno));
+		pr_err("Failed to block signals on threads start: %m\n");
 		return -1;
 	}
 
@@ -2356,7 +2352,7 @@ static int record__start_threads(struct record *rec)
 		if (pthread_create(&handle, &attrs, record__thread, &thread_data[t])) {
 			for (tt = 1; tt < t; tt++)
 				record__terminate_thread(&thread_data[t]);
-			pr_err("Failed to start threads: %s\n", strerror(errno));
+			pr_err("Failed to start threads: %m\n");
 			ret = -1;
 			goto out_err;
 		}
@@ -2379,7 +2375,7 @@ static int record__start_threads(struct record *rec)
 	pthread_attr_destroy(&attrs);
 
 	if (sigprocmask(SIG_SETMASK, &mask, NULL)) {
-		pr_err("Failed to unblock signals on threads start: %s\n", strerror(errno));
+		pr_err("Failed to unblock signals on threads start: %m\n");
 		ret = -1;
 	}
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 5c06e9b61821..670dc7949718 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -935,9 +935,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	}
 
 	if (evlist__apply_filters(evsel_list, &counter, &target)) {
-		pr_err("failed to set filter \"%s\" on event %s with %d (%s)\n",
-			counter->filter, evsel__name(counter), errno,
-			str_error_r(errno, msg, sizeof(msg)));
+		pr_err("failed to set filter \"%s\" on event %s: %m\n",
+			counter->filter, evsel__name(counter));
 		return -1;
 	}
 
@@ -999,8 +998,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		}
 
 		if (workload_exec_errno) {
-			const char *emsg = str_error_r(workload_exec_errno, msg, sizeof(msg));
-			pr_err("Workload failed: %s\n", emsg);
+			errno = workload_exec_errno;
+			pr_err("Workload failed: %m\n");
 			err = -1;
 			goto err_out;
 		}
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a743bda294bd..279b55eb3989 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2595,12 +2595,10 @@ static struct syscall *trace__syscall_info(struct trace *trace, struct evsel *ev
 		err = syscall__read_info(sc, trace);
 
 	if (err && verbose > 0) {
-		char sbuf[STRERR_BUFSIZE];
-
-		fprintf(trace->output, "Problems reading syscall %d: %d (%s)", id, -err,
-			str_error_r(-err, sbuf, sizeof(sbuf)));
+		errno = -err;
+		fprintf(trace->output, "Problems reading syscall %d: %m", id);
 		if (sc && sc->name)
-			fprintf(trace->output, "(%s)", sc->name);
+			fprintf(trace->output, " (%s)", sc->name);
 		fputs(" information\n", trace->output);
 	}
 	return err ? NULL : sc;
@@ -4652,9 +4650,8 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 
 out_error_apply_filters:
 	fprintf(trace->output,
-		"Failed to set filter \"%s\" on event %s with %d (%s)\n",
-		evsel->filter, evsel__name(evsel), errno,
-		str_error_r(errno, errbuf, sizeof(errbuf)));
+		"Failed to set filter \"%s\" on event %s: %m\n",
+		evsel->filter, evsel__name(evsel));
 	goto out_delete_evlist;
 }
 out_error_mem:
@@ -4662,7 +4659,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	goto out_delete_evlist;
 
 out_errno:
-	fprintf(trace->output, "errno=%d,%s\n", errno, strerror(errno));
+	fprintf(trace->output, "%m\n");
 	goto out_delete_evlist;
 }
 
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 88c60ecf3395..f475a8664ffc 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -169,8 +169,8 @@ static int set_debug_file(const char *path)
 {
 	debug_fp = fopen(path, "w");
 	if (!debug_fp) {
-		fprintf(stderr, "Open debug file '%s' failed: %s\n",
-			path, strerror(errno));
+		fprintf(stderr, "Open debug file '%s' failed: %m\n",
+			path);
 		return -1;
 	}
 
@@ -335,7 +335,6 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 {
 	int status;
 	struct stat st;
-	char sbuf[STRERR_BUFSIZE];
 
 	if (use_browser == -1)
 		use_browser = check_browser_config(p->cmd);
@@ -363,17 +362,15 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 	status = 1;
 	/* Check for ENOSPC and EIO errors.. */
 	if (fflush(stdout)) {
-		fprintf(stderr, "write failure on standard output: %s",
-			str_error_r(errno, sbuf, sizeof(sbuf)));
+		fprintf(stderr, "write failure on standard output: %m\n");
 		goto out;
 	}
 	if (ferror(stdout)) {
-		fprintf(stderr, "unknown write failure on standard output");
+		fprintf(stderr, "unknown write failure on standard output\n");
 		goto out;
 	}
 	if (fclose(stdout)) {
-		fprintf(stderr, "close failed on standard output: %s",
-			str_error_r(errno, sbuf, sizeof(sbuf)));
+		fprintf(stderr, "close failed on standard output: %m\n");
 		goto out;
 	}
 	status = 0;
@@ -459,7 +456,6 @@ int main(int argc, const char **argv)
 {
 	int err, done_help = 0;
 	const char *cmd;
-	char sbuf[STRERR_BUFSIZE];
 
 	perf_debug_setup();
 
@@ -573,8 +569,8 @@ int main(int argc, const char **argv)
 	}
 
 	if (cmd) {
-		fprintf(stderr, "Failed to run command '%s': %s\n",
-			cmd, str_error_r(errno, sbuf, sizeof(sbuf)));
+		fprintf(stderr, "Failed to run command '%s': %m\n",
+			cmd);
 	}
 out:
 	if (debug_fp)
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 2298cd396c42..2e6da3ad0a4f 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -787,11 +787,10 @@ int perf_event__synthesize_bpf_events(struct perf_session *session,
 				err = 0;
 				break;
 			}
-			pr_debug("%s: can't get next program: %s%s\n",
-				 __func__, strerror(errno),
-				 errno == EINVAL ? " -- kernel too old?" : "");
 			/* don't report error on old kernel or EPERM  */
 			err = (errno == EINVAL || errno == EPERM) ? 0 : -1;
+			pr_debug("%s: can\'t get next program: %m%s\n",
+				__func__, errno == EINVAL ? " -- kernel too old?" : "");
 			break;
 		}
 		fd = bpf_prog_get_fd_by_id(id);
@@ -824,10 +823,8 @@ int perf_event__synthesize_bpf_events(struct perf_session *session,
 		.tool    = session->tool,
 	};
 
-	if (kallsyms__parse(kallsyms_filename, &arg, kallsyms_process_symbol)) {
-		pr_err("%s: failed to synthesize bpf images: %s\n",
-		       __func__, strerror(errno));
-	}
+	if (kallsyms__parse(kallsyms_filename, &arg, kallsyms_process_symbol))
+		pr_err("%s: failed to synthesize bpf images: %m\n", __func__);
 
 	free(event);
 	return err;
diff --git a/tools/perf/util/bpf-utils.c b/tools/perf/util/bpf-utils.c
index 5a66dc8594aa..d6d2c9c190f7 100644
--- a/tools/perf/util/bpf-utils.c
+++ b/tools/perf/util/bpf-utils.c
@@ -123,7 +123,7 @@ get_bpf_prog_info_linear(int fd, __u64 arrays)
 	/* step 1: get array dimensions */
 	err = bpf_obj_get_info_by_fd(fd, &info, &info_len);
 	if (err) {
-		pr_debug("can't get prog info: %s", strerror(errno));
+		pr_debug("can't get prog info: %m\n");
 		return ERR_PTR(-EFAULT);
 	}
 	if (info.type >= __MAX_BPF_PROG_TYPE)
@@ -186,7 +186,7 @@ get_bpf_prog_info_linear(int fd, __u64 arrays)
 	/* step 5: call syscall again to get required arrays */
 	err = bpf_obj_get_info_by_fd(fd, &info_linear->info, &info_len);
 	if (err) {
-		pr_debug("can't get prog info: %s", strerror(errno));
+		pr_debug("can't get prog info: %m\n");
 		free(info_linear);
 		return ERR_PTR(-EFAULT);
 	}
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 7b5671f13c53..788d30be2058 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -42,7 +42,7 @@ static void check_slab_cache_iter(struct lock_contention *con)
 
 	con->btf = btf__load_vmlinux_btf();
 	if (con->btf == NULL) {
-		pr_debug("BTF loading failed: %s\n", strerror(errno));
+		pr_debug("BTF loading failed: %m\n");
 		return;
 	}
 
diff --git a/tools/perf/util/cap.c b/tools/perf/util/cap.c
index 24a0ea7e6d97..ac6d1d9a523d 100644
--- a/tools/perf/util/cap.c
+++ b/tools/perf/util/cap.c
@@ -28,8 +28,7 @@ bool perf_cap__capable(int cap, bool *used_root)
 		    header.version == _LINUX_CAPABILITY_VERSION_1)
 			continue;
 
-		pr_debug2("capget syscall failed (%s - %d) fall back on root check\n",
-			  strerror(errno), errno);
+		pr_debug2("capget syscall failed (%m) fall back on root check\n");
 		*used_root = true;
 		return geteuid() == 0;
 	}
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 164eb45a0b36..90df41da1a32 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -213,17 +213,15 @@ static int check_backup(struct perf_data *data)
 
 		ret = rm_rf_perf_data(oldname);
 		if (ret) {
-			pr_err("Can't remove old data: %s (%s)\n",
-			       ret == -2 ?
-			       "Unknown file found" : strerror(errno),
-			       oldname);
+			if (ret == -2)
+				pr_err("Can't remove old data: Unknown file found (%s)\n", oldname);
+			else
+				pr_err("Can't remove old data: %m (%s)\n", oldname);
 			return -1;
 		}
 
 		if (rename(data->path, oldname)) {
-			pr_err("Can't move data: %s (%s to %s)\n",
-			       strerror(errno),
-			       data->path, oldname);
+			pr_err("Can't move data: %m (%s to %s)\n", data->path, oldname);
 			return -1;
 		}
 	}
@@ -246,14 +244,12 @@ static int open_file_read(struct perf_data *data)
 	int flags = data->in_place_update ? O_RDWR : O_RDONLY;
 	struct stat st;
 	int fd;
-	char sbuf[STRERR_BUFSIZE];
 
 	fd = open(data->file.path, flags);
 	if (fd < 0) {
 		int err = errno;
 
-		pr_err("failed to open %s: %s", data->file.path,
-			str_error_r(err, sbuf, sizeof(sbuf)));
+		pr_err("failed to open %s: %m", data->file.path);
 		if (err == ENOENT && !strcmp(data->file.path, "perf.data"))
 			pr_err("  (try 'perf record' first)");
 		pr_err("\n");
@@ -285,15 +281,10 @@ static int open_file_read(struct perf_data *data)
 
 static int open_file_write(struct perf_data *data)
 {
-	int fd;
-	char sbuf[STRERR_BUFSIZE];
-
-	fd = open(data->file.path, O_CREAT|O_RDWR|O_TRUNC|O_CLOEXEC,
-		  S_IRUSR|S_IWUSR);
+	int fd = open(data->file.path, O_CREAT|O_RDWR|O_TRUNC|O_CLOEXEC, S_IRUSR|S_IWUSR);
 
 	if (fd < 0)
-		pr_err("failed to open %s : %s\n", data->file.path,
-			str_error_r(errno, sbuf, sizeof(sbuf)));
+		pr_err("failed to open %s : %m\n", data->file.path);
 
 	return fd;
 }
@@ -436,8 +427,8 @@ int perf_data__switch(struct perf_data *data,
 
 		if (lseek(data->file.fd, pos, SEEK_SET) == (off_t)-1) {
 			ret = -errno;
-			pr_debug("Failed to lseek to %zu: %s",
-				 pos, strerror(errno));
+			pr_debug("Failed to lseek to %zu: %m\n",
+				 pos);
 			goto out;
 		}
 	}
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 344e689567ee..eb7011374324 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -539,16 +539,13 @@ static void close_first_dso(void);
 
 static int do_open(char *name) EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
 {
-	int fd;
-	char sbuf[STRERR_BUFSIZE];
-
 	do {
-		fd = open(name, O_RDONLY|O_CLOEXEC);
+		int fd = open(name, O_RDONLY|O_CLOEXEC);
+
 		if (fd >= 0)
 			return fd;
 
-		pr_debug("dso open failed: %s\n",
-			 str_error_r(errno, sbuf, sizeof(sbuf)));
+		pr_debug("dso open failed: %m\n");
 		if (!dso__data_open_cnt || errno != EMFILE)
 			break;
 
@@ -1097,7 +1094,6 @@ static int file_size(struct dso *dso, struct machine *machine)
 {
 	int ret = 0;
 	struct stat st;
-	char sbuf[STRERR_BUFSIZE];
 
 	mutex_lock(dso__data_open_lock());
 
@@ -1115,8 +1111,7 @@ static int file_size(struct dso *dso, struct machine *machine)
 
 	if (fstat(dso__data(dso)->fd, &st) < 0) {
 		ret = -errno;
-		pr_err("dso cache fstat failed: %s\n",
-		       str_error_r(errno, sbuf, sizeof(sbuf)));
+		pr_err("dso cache fstat failed: %m\n");
 		dso__data(dso)->status = DSO_DATA_STATUS_ERROR;
 		goto out;
 	}
@@ -1771,10 +1766,8 @@ int dso__strerror_load(struct dso *dso, char *buf, size_t buflen)
 	BUG_ON(buflen == 0);
 
 	if (errnum >= 0) {
-		const char *err = str_error_r(errnum, buf, buflen);
-
-		if (err != buf)
-			scnprintf(buf, buflen, "%s", err);
+		errno = errnum;
+		scnprintf(buf, buflen, "%m");
 
 		return 0;
 	}
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e8217efdda53..1f552cb1733a 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1613,14 +1613,14 @@ int evlist__parse_sample_timestamp(struct evlist *evlist, union perf_event *even
 int evlist__strerror_open(struct evlist *evlist, int err, char *buf, size_t size)
 {
 	int printed, value;
-	char sbuf[STRERR_BUFSIZE], *emsg = str_error_r(err, sbuf, sizeof(sbuf));
 
 	switch (err) {
 	case EACCES:
 	case EPERM:
+		errno = err;
 		printed = scnprintf(buf, size,
-				    "Error:\t%s.\n"
-				    "Hint:\tCheck /proc/sys/kernel/perf_event_paranoid setting.", emsg);
+				    "Error:\t%m.\n"
+				    "Hint:\tCheck /proc/sys/kernel/perf_event_paranoid setting.");
 
 		value = perf_event_paranoid();
 
@@ -1647,16 +1647,18 @@ int evlist__strerror_open(struct evlist *evlist, int err, char *buf, size_t size
 		if (first->core.attr.sample_freq < (u64)max_freq)
 			goto out_default;
 
+		errno = err;
 		printed = scnprintf(buf, size,
-				    "Error:\t%s.\n"
+				    "Error:\t%m.\n"
 				    "Hint:\tCheck /proc/sys/kernel/perf_event_max_sample_rate.\n"
 				    "Hint:\tThe current value is %d and %" PRIu64 " is being requested.",
-				    emsg, max_freq, first->core.attr.sample_freq);
+				    max_freq, first->core.attr.sample_freq);
 		break;
 	}
 	default:
 out_default:
-		scnprintf(buf, size, "%s", emsg);
+		errno = err;
+		scnprintf(buf, size, "%m");
 		break;
 	}
 
@@ -1665,17 +1667,17 @@ int evlist__strerror_open(struct evlist *evlist, int err, char *buf, size_t size
 
 int evlist__strerror_mmap(struct evlist *evlist, int err, char *buf, size_t size)
 {
-	char sbuf[STRERR_BUFSIZE], *emsg = str_error_r(err, sbuf, sizeof(sbuf));
 	int pages_attempted = evlist->core.mmap_len / 1024, pages_max_per_user, printed = 0;
 
 	switch (err) {
 	case EPERM:
 		sysctl__read_int("kernel/perf_event_mlock_kb", &pages_max_per_user);
+		errno = err;
 		printed += scnprintf(buf + printed, size - printed,
-				     "Error:\t%s.\n"
+				     "Error:\t%m.\n"
 				     "Hint:\tCheck /proc/sys/kernel/perf_event_mlock_kb (%d kB) setting.\n"
 				     "Hint:\tTried using %zd kB.\n",
-				     emsg, pages_max_per_user, pages_attempted);
+				     pages_max_per_user, pages_attempted);
 
 		if (pages_attempted >= pages_max_per_user) {
 			printed += scnprintf(buf + printed, size - printed,
@@ -1687,7 +1689,8 @@ int evlist__strerror_mmap(struct evlist *evlist, int err, char *buf, size_t size
 				     "Hint:\tTry using a smaller -m/--mmap-pages value.");
 		break;
 	default:
-		scnprintf(buf, size, "%s", emsg);
+		errno = err;
+		scnprintf(buf, size, "%m");
 		break;
 	}
 
@@ -1919,8 +1922,8 @@ static int evlist__parse_control_fifo(const char *str, int *ctl_fd, int *ctl_fd_
 	 */
 	fd = open(s, O_RDWR | O_NONBLOCK | O_CLOEXEC);
 	if (fd < 0) {
-		pr_err("Failed to open '%s'\n", s);
 		ret = -errno;
+		pr_err("Failed to open '%s': %m\n", s);
 		goto out_free;
 	}
 	*ctl_fd = fd;
@@ -1930,7 +1933,7 @@ static int evlist__parse_control_fifo(const char *str, int *ctl_fd, int *ctl_fd_
 		/* O_RDWR | O_NONBLOCK means the other end need not be open */
 		fd = open(p, O_RDWR | O_NONBLOCK | O_CLOEXEC);
 		if (fd < 0) {
-			pr_err("Failed to open '%s'\n", p);
+			pr_err("Failed to open '%s': %m\n", p);
 			ret = -errno;
 			goto out_free;
 		}
@@ -2362,7 +2365,7 @@ int evlist__parse_event_enable_time(struct evlist *evlist, struct record_opts *o
 	eet->timerfd = timerfd_create(CLOCK_MONOTONIC, TFD_CLOEXEC);
 	if (eet->timerfd == -1) {
 		err = -errno;
-		pr_err("timerfd_create failed: %s\n", strerror(errno));
+		pr_err("timerfd_create failed: %m\n");
 		goto free_eet_times;
 	}
 
@@ -2397,7 +2400,7 @@ static int event_enable_timer__set_timer(struct event_enable_timer *eet, int ms)
 
 	if (timerfd_settime(eet->timerfd, 0, &its, NULL) < 0) {
 		err = -errno;
-		pr_err("timerfd_settime failed: %s\n", strerror(errno));
+		pr_err("timerfd_settime failed: %m\n");
 	}
 	return err;
 }
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 989c56d4a23f..6e94d12e82e0 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -647,8 +647,9 @@ struct tep_event *evsel__tp_format(struct evsel *evsel)
 	if (IS_ERR(tp_format)) {
 		int err = -PTR_ERR(evsel->tp_format);
 
-		pr_err("Error getting tracepoint format '%s' '%s'(%d)\n",
-			evsel__name(evsel), strerror(err), err);
+		errno = err;
+		pr_err("Error getting tracepoint format '%s': %m\n",
+			evsel__name(evsel));
 		return NULL;
 	}
 	evsel->tp_format = tp_format;
@@ -2751,8 +2752,8 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 					    PERF_EVENT_IOC_SET_BPF,
 					    bpf_fd);
 				if (err && errno != EEXIST) {
-					pr_err("failed to attach bpf fd %d: %s\n",
-					       bpf_fd, strerror(errno));
+					pr_err("failed to attach bpf fd %d: %m\n",
+					       bpf_fd);
 					err = -EINVAL;
 					goto out_close;
 				}
@@ -3816,7 +3817,6 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			 int err, char *msg, size_t size)
 {
 	struct perf_pmu *pmu;
-	char sbuf[STRERR_BUFSIZE];
 	int printed = 0, enforced = 0;
 	int ret;
 
@@ -3949,10 +3949,11 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 	if (ret)
 		return ret;
 
+	errno = err;
 	return scnprintf(msg, size,
-	"The sys_perf_event_open() syscall returned with %d (%s) for event (%s).\n"
-	"\"dmesg | grep -i perf\" may provide additional information.\n",
-			 err, str_error_r(err, sbuf, sizeof(sbuf)), evsel__name(evsel));
+			 "The sys_perf_event_open() syscall failed for event (%s): %m\n"
+			 "\"dmesg | grep -i perf\" may provide additional information.\n",
+			 evsel__name(evsel));
 }
 
 struct perf_session *evsel__session(struct evsel *evsel)
diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index b062b1f234b6..124c5ad64f46 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -90,7 +90,8 @@ jit_emit_elf(struct jit_buf_desc *jd,
 	saved_errno = errno;
 	nsinfo__mountns_exit(&nsc);
 	if (fd == -1) {
-		pr_warning("cannot create jit ELF %s: %s\n", filename, strerror(saved_errno));
+		errno = saved_errno;
+		pr_warning("cannot create jit ELF %s: %m\n", filename);
 		return -1;
 	}
 
diff --git a/tools/perf/util/lzma.c b/tools/perf/util/lzma.c
index c355757ed391..91b9b5171d1f 100644
--- a/tools/perf/util/lzma.c
+++ b/tools/perf/util/lzma.c
@@ -59,7 +59,7 @@ int lzma_decompress_stream_to_file(FILE *infile, int output_fd)
 			strm.avail_in = fread(buf_in, 1, sizeof(buf_in), infile);
 
 			if (ferror(infile)) {
-				pr_debug("lzma: read error: %s\n", strerror(errno));
+				pr_debug("lzma: read error: %m\n");
 				goto err_lzma_end;
 			}
 
@@ -73,7 +73,7 @@ int lzma_decompress_stream_to_file(FILE *infile, int output_fd)
 			ssize_t write_size = sizeof(buf_out) - strm.avail_out;
 
 			if (writen(output_fd, buf_out, write_size) != write_size) {
-				pr_debug("lzma: write error: %s\n", strerror(errno));
+				pr_debug("lzma: write error: %m\n");
 				goto err_lzma_end;
 			}
 
@@ -103,7 +103,7 @@ int lzma_decompress_to_file(const char *input, int output_fd)
 
 	infile = fopen(input, "rb");
 	if (!infile) {
-		pr_debug("lzma: fopen failed on %s: '%s'\n", input, strerror(errno));
+		pr_debug("lzma: fopen failed on %s: '%m'\n", input);
 		return -1;
 	}
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 4b0236b2df29..1ae3e5d579a1 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2186,9 +2186,10 @@ reader__read_event(struct reader *rd, struct perf_session *session,
 
 	if (size < sizeof(struct perf_event_header) ||
 	    (skip = rd->process(session, event, rd->file_pos, rd->path)) < 0) {
-		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d [%s]\n",
+		errno = -skip;
+		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d [%m]\n",
 		       rd->file_offset + rd->head, event->header.size,
-		       event->header.type, strerror(-skip));
+		       event->header.type);
 		err = skip;
 		goto out;
 	}
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 9e820599bab3..d0625837596b 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1102,14 +1102,14 @@ static Elf *read_gnu_debugdata(struct dso *dso, Elf *elf, const char *name, int
 
 	wrapped = fmemopen(scn_data->d_buf, scn_data->d_size, "r");
 	if (!wrapped) {
-		pr_debug("%s: fmemopen: %s\n", __func__, strerror(errno));
+		pr_debug("%s: fmemopen: %m\n", __func__);
 		*dso__load_errno(dso) = -errno;
 		return NULL;
 	}
 
 	temp_fd = mkstemp(temp_filename);
 	if (temp_fd < 0) {
-		pr_debug("%s: mkstemp: %s\n", __func__, strerror(errno));
+		pr_debug("%s: mkstemp: %m\n", __func__);
 		*dso__load_errno(dso) = -errno;
 		fclose(wrapped);
 		return NULL;
-- 
2.52.0.rc1.455.g30608eb744-goog

