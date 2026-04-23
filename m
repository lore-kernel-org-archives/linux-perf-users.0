Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012FF373C1D
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960633; cv=none; b=BzDvlGEoqavZcIO0H8Me481qgy5xib6TlWozdTimrq28bYpDkbjpkrXe0Dkaye+FuRuN3umgPD2OKEL1iC2oXTKV2znrTBsZJqfnU724BVrytcUP6REoaTqkWxP8/2SSuvBoTav8UMGlMniX2HiM/IUDS7a62LgUQO29pzfDhdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960633; c=relaxed/simple;
	bh=dPqmmYZWI2WdU6AXaYHgA7vsjTJeVEmbmKeEQ+P3Y7k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LvISb7tPovfE5ydTSwP02OBjAG9+DKGxAgrp5erh6KjPTGZokenKN6acV97o//ol9OW1vXT942sqG4cMJ/omwdtd19kU2tVwGtnmpGZqDe3Dq9a5RNRRcZrjuV141loCJ9VWx6rlt8jfCCaBM1KrTwkRiAgf5poNJbTANyCT2EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FCCUiFo0; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FCCUiFo0"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso8652932eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776960628; x=1777565428; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6eOvLpfBEpWT8ZtqiLDNuMKVTo8DMlX0wBaVfQSBX3I=;
        b=FCCUiFo0h55A1zZN22/t9m82rXRu9cimmCbcIRoruQU1RCbViwXzAsRLurrObepM9/
         xnlpl2iBhVgt16N8BYYA5X9kYZ2XCSF4OUX7Mrv4LXPd4H2cNfoTl5qTdhXAbpMgYO0v
         YRDd7tTUrDRJ/jz5rwwrdbuYexi99bgPuRAI/PyN5VNlSchUTVjUfClH+CFUH5MwU7yl
         kAbchKNK4uvSg8KZ3LG9TI5J9+L7VS2YSSGyIchixGGLbGrzbRmIQtn3ouXRb1sMoJ+C
         cb7O7L0ooLUdn8CAJMCJrO0ofMeSdhCyHYR7j8A5QAEwpYNDiDlxyDSQoZmAAz1+FY3i
         PjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960628; x=1777565428;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6eOvLpfBEpWT8ZtqiLDNuMKVTo8DMlX0wBaVfQSBX3I=;
        b=mdPHy2lBJkjxBLtQnYskVmjawV6N6PFbZQ2dJB6n9SqIkO5LMjK5Xhho1ENK7w20mI
         yhu9o97tFjHwCCrKgfWu7ueRbu7dcyyXRLUO+6gmJpdStWUamV8RoPRLaH/HlshFL73Z
         IPipBKU1tYFCGQEHdObJX4+HK0hcYFf84hKRcOhCvKi0wI3OczOOGci/PdJANpMwPpxc
         OQUv5VMnfdkLUjs7jvZ9hR8g1cF8UAUR+zly6nT6XalCUVCSaIxzqGDUHD623xLafdRO
         KJQA5062JE7c15Q+ZUfeUC0tPYRqSZEsuboazbeupK2QpPYD1zuQRy04r/DlR0FY91Zq
         aoGQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Nmr6ZOJhUGr8uvjg0jElQktyfZcvC+NvHBNYgVpUnbXv5Vpd/X7lNq1TGhDdsoCQLgfTU4v5YycSOak2OSGxX@vger.kernel.org
X-Gm-Message-State: AOJu0YwO+7iX2Hw0u3bQ043RdTI95JE9SHgc7ndmNdwcaMI3/6nTJA4/
	0SI+1dUDVPeR5HkKjocE4WfBnXiu60F1ieQj41YEj1qghUswbbMFuHIhyawW3XOTPNWeHIlr0bK
	X6TKHYdiqUw==
X-Received: from dyclw17.prod.google.com ([2002:a05:693c:2111:b0:2d9:472c:9184])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:748f:b0:2e0:909a:b9c
 with SMTP id 5a478bee46e88-2e478839eaamr14611821eec.15.1776960627502; Thu, 23
 Apr 2026 09:10:27 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:09:16 -0700
In-Reply-To: <20260423161006.1762700-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423035526.1537178-1-irogers@google.com> <20260423161006.1762700-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423161006.1762700-10-irogers@google.com>
Subject: [PATCH v3 09/58] perf evlist: Add reference count
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: 9erthalion6@gmail.com, adityab1@linux.ibm.com, 
	alexandre.chartre@oracle.com, alice.mei.rogers@gmail.com, 
	ankur.a.arora@oracle.com, ashelat@redhat.com, atrajeev@linux.ibm.com, 
	blakejones@google.com, changbin.du@huawei.com, chuck.lever@oracle.com, 
	collin.funk1@gmail.com, coresight@lists.linaro.org, ctshao@google.com, 
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, dsterba@suse.com, 
	gautam@linux.ibm.com, howardchu95@gmail.com, john.g.garry@oracle.com, 
	jolsa@kernel.org, jonathan.cameron@huawei.com, justinstitt@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mike.leach@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nichen@iscas.ac.cn, 
	nick.desaulniers+lkml@gmail.com, pan.deng@intel.com, peterz@infradead.org, 
	ravi.bangoria@amd.com, ricky.ringler@proton.me, stephen.s.brennan@oracle.com, 
	sun.jian.kdev@gmail.com, suzuki.poulose@arm.com, swapnil.sapkal@amd.com, 
	tanze@kylinos.cn, terrelln@fb.com, thomas.falcon@intel.com, 
	tianyou.li@intel.com, tycho@kernel.org, wangyang.guo@intel.com, 
	xiaqinxin@huawei.com, yang.lee@linux.alibaba.com, yuzhuo@google.com, 
	zhiguo.zhou@intel.com, zli94@ncsu.edu
Content-Type: text/plain; charset="UTF-8"

This a no-op for most of the perf tool. The reference count is set to
1 at allocation, the put will see the 1, decrement it and perform the
delete. The purpose for adding the reference count is for the python
code. Prior to this change the python code would clone evlists, but
this has issues if events are opened, etc. This change adds a
reference count for the evlists and a later change will add it to
evsels. The combination is needed for the python code to operate
correctly (not hit asserts in the evsel clone), but the changes are
broken apart for the sake of smaller patches.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---

v2: Added evlist__put to pyrf_evlist__init in case init is called more
    than once.

    I double-checked trace__replay() and confirmed that trace->evlist
    is not assigned to session->evlist in that function.
    trace__replay creates a new session and uses its own evlist for
    processing file events, leaving trace->evlist pointing to the
    empty list created at startup. Therefore, the
    evlist__put(trace->evlist) call in trace__exit() is safe and
    correct to avoid leaking that empty list.
---
 tools/perf/arch/x86/tests/hybrid.c          |   2 +-
 tools/perf/arch/x86/tests/topdown.c         |   2 +-
 tools/perf/arch/x86/util/iostat.c           |   2 +-
 tools/perf/bench/evlist-open-close.c        |  18 +-
 tools/perf/builtin-ftrace.c                 |   8 +-
 tools/perf/builtin-kvm.c                    |   4 +-
 tools/perf/builtin-lock.c                   |   2 +-
 tools/perf/builtin-record.c                 |   4 +-
 tools/perf/builtin-sched.c                  |   6 +-
 tools/perf/builtin-script.c                 |   2 +-
 tools/perf/builtin-stat.c                   |  10 +-
 tools/perf/builtin-top.c                    |  52 ++---
 tools/perf/builtin-trace.c                  |  26 +--
 tools/perf/tests/backward-ring-buffer.c     |  18 +-
 tools/perf/tests/code-reading.c             |   4 +-
 tools/perf/tests/event-times.c              |   4 +-
 tools/perf/tests/event_update.c             |   2 +-
 tools/perf/tests/evsel-roundtrip-name.c     |   8 +-
 tools/perf/tests/expand-cgroup.c            |   8 +-
 tools/perf/tests/hists_cumulate.c           |   2 +-
 tools/perf/tests/hists_filter.c             |   2 +-
 tools/perf/tests/hists_link.c               |   2 +-
 tools/perf/tests/hists_output.c             |   2 +-
 tools/perf/tests/hwmon_pmu.c                |   2 +-
 tools/perf/tests/keep-tracking.c            |   2 +-
 tools/perf/tests/mmap-basic.c               |  18 +-
 tools/perf/tests/openat-syscall-tp-fields.c |  18 +-
 tools/perf/tests/parse-events.c             |   4 +-
 tools/perf/tests/parse-metric.c             |   4 +-
 tools/perf/tests/parse-no-sample-id-all.c   |   2 +-
 tools/perf/tests/perf-record.c              |  18 +-
 tools/perf/tests/perf-time-to-tsc.c         |   2 +-
 tools/perf/tests/pfm.c                      |   4 +-
 tools/perf/tests/pmu-events.c               |   6 +-
 tools/perf/tests/pmu.c                      |   4 +-
 tools/perf/tests/sw-clock.c                 |  14 +-
 tools/perf/tests/switch-tracking.c          |   2 +-
 tools/perf/tests/task-exit.c                |  14 +-
 tools/perf/tests/tool_pmu.c                 |   2 +-
 tools/perf/tests/topology.c                 |   2 +-
 tools/perf/util/cgroup.c                    |   4 +-
 tools/perf/util/data-convert-bt.c           |   2 +-
 tools/perf/util/evlist.c                    |  20 +-
 tools/perf/util/evlist.h                    |   7 +-
 tools/perf/util/expr.c                      |   2 +-
 tools/perf/util/header.c                    |  12 +-
 tools/perf/util/metricgroup.c               |   6 +-
 tools/perf/util/parse-events.c              |   4 +-
 tools/perf/util/perf_api_probe.c            |   2 +-
 tools/perf/util/python.c                    | 200 +++++++-------------
 tools/perf/util/record.c                    |   2 +-
 tools/perf/util/session.c                   |   2 +-
 tools/perf/util/sideband_evlist.c           |  16 +-
 53 files changed, 268 insertions(+), 319 deletions(-)

diff --git a/tools/perf/arch/x86/tests/hybrid.c b/tools/perf/arch/x86/tests/hybrid.c
index e221ea104174..dfb0ffc0d030 100644
--- a/tools/perf/arch/x86/tests/hybrid.c
+++ b/tools/perf/arch/x86/tests/hybrid.c
@@ -268,7 +268,7 @@ static int test_event(const struct evlist_test *e)
 		ret = e->check(evlist);
 	}
 	parse_events_error__exit(&err);
-	evlist__delete(evlist);
+	evlist__put(evlist);
 
 	return ret;
 }
diff --git a/tools/perf/arch/x86/tests/topdown.c b/tools/perf/arch/x86/tests/topdown.c
index 3ee4e5e71be3..2d0ae5b0d76c 100644
--- a/tools/perf/arch/x86/tests/topdown.c
+++ b/tools/perf/arch/x86/tests/topdown.c
@@ -56,7 +56,7 @@ static int event_cb(void *state, struct pmu_event_info *info)
 			*ret = TEST_FAIL;
 		}
 	}
-	evlist__delete(evlist);
+	evlist__put(evlist);
 	return 0;
 }
 
diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/util/iostat.c
index 7442a2cd87ed..e0417552b0cb 100644
--- a/tools/perf/arch/x86/util/iostat.c
+++ b/tools/perf/arch/x86/util/iostat.c
@@ -337,7 +337,7 @@ int iostat_prepare(struct evlist *evlist, struct perf_stat_config *config)
 	if (evlist->core.nr_entries > 0) {
 		pr_warning("The -e and -M options are not supported."
 			   "All chosen events/metrics will be dropped\n");
-		evlist__delete(evlist);
+		evlist__put(evlist);
 		evlist = evlist__new();
 		if (!evlist)
 			return -ENOMEM;
diff --git a/tools/perf/bench/evlist-open-close.c b/tools/perf/bench/evlist-open-close.c
index faf9c34b4a5d..304929d1f67f 100644
--- a/tools/perf/bench/evlist-open-close.c
+++ b/tools/perf/bench/evlist-open-close.c
@@ -76,7 +76,7 @@ static struct evlist *bench__create_evlist(char *evstr, const char *uid_str)
 		parse_events_error__exit(&err);
 		pr_err("Run 'perf list' for a list of valid events\n");
 		ret = 1;
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	}
 	parse_events_error__exit(&err);
 	if (uid_str) {
@@ -85,24 +85,24 @@ static struct evlist *bench__create_evlist(char *evstr, const char *uid_str)
 		if (uid == UINT_MAX) {
 			pr_err("Invalid User: %s", uid_str);
 			ret = -EINVAL;
-			goto out_delete_evlist;
+			goto out_put_evlist;
 		}
 		ret = parse_uid_filter(evlist, uid);
 		if (ret)
-			goto out_delete_evlist;
+			goto out_put_evlist;
 	}
 	ret = evlist__create_maps(evlist, &opts.target);
 	if (ret < 0) {
 		pr_err("Not enough memory to create thread/cpu maps\n");
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	}
 
 	evlist__config(evlist, &opts, NULL);
 
 	return evlist;
 
-out_delete_evlist:
-	evlist__delete(evlist);
+out_put_evlist:
+	evlist__put(evlist);
 	return NULL;
 }
 
@@ -151,7 +151,7 @@ static int bench_evlist_open_close__run(char *evstr, const char *uid_str)
 		evlist->core.nr_entries, evlist__count_evsel_fds(evlist));
 	printf("  Number of iterations:\t%d\n", iterations);
 
-	evlist__delete(evlist);
+	evlist__put(evlist);
 
 	for (i = 0; i < iterations; i++) {
 		pr_debug("Started iteration %d\n", i);
@@ -162,7 +162,7 @@ static int bench_evlist_open_close__run(char *evstr, const char *uid_str)
 		gettimeofday(&start, NULL);
 		err = bench__do_evlist_open_close(evlist);
 		if (err) {
-			evlist__delete(evlist);
+			evlist__put(evlist);
 			return err;
 		}
 
@@ -171,7 +171,7 @@ static int bench_evlist_open_close__run(char *evstr, const char *uid_str)
 		runtime_us = timeval2usec(&diff);
 		update_stats(&time_stats, runtime_us);
 
-		evlist__delete(evlist);
+		evlist__put(evlist);
 		pr_debug("Iteration %d took:\t%" PRIu64 "us\n", i, runtime_us);
 	}
 
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 8a7dbfb14535..676239148b87 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -1999,20 +1999,20 @@ int cmd_ftrace(int argc, const char **argv)
 
 	ret = evlist__create_maps(ftrace.evlist, &ftrace.target);
 	if (ret < 0)
-		goto out_delete_evlist;
+		goto out_put_evlist;
 
 	if (argc) {
 		ret = evlist__prepare_workload(ftrace.evlist, &ftrace.target,
 					       argv, false,
 					       ftrace__workload_exec_failed_signal);
 		if (ret < 0)
-			goto out_delete_evlist;
+			goto out_put_evlist;
 	}
 
 	ret = cmd_func(&ftrace);
 
-out_delete_evlist:
-	evlist__delete(ftrace.evlist);
+out_put_evlist:
+	evlist__put(ftrace.evlist);
 
 out_delete_filters:
 	delete_filter_func(&ftrace.filters);
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 0c5e6b3aac74..d88855e3c7b4 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1811,7 +1811,7 @@ static struct evlist *kvm_live_event_list(void)
 
 out:
 	if (err) {
-		evlist__delete(evlist);
+		evlist__put(evlist);
 		evlist = NULL;
 	}
 
@@ -1942,7 +1942,7 @@ static int kvm_events_live(struct perf_kvm_stat *kvm,
 out:
 	perf_session__delete(kvm->session);
 	kvm->session = NULL;
-	evlist__delete(kvm->evlist);
+	evlist__put(kvm->evlist);
 
 	return err;
 }
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 5585aeb97684..c40d070f6c36 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -2145,7 +2145,7 @@ static int __cmd_contention(int argc, const char **argv)
 
 out_delete:
 	lock_filter_finish();
-	evlist__delete(con.evlist);
+	evlist__put(con.evlist);
 	lock_contention_finish(&con);
 	perf_session__delete(session);
 	perf_env__exit(&host_env);
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4a5eba498c02..b4fffa936e01 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -4289,7 +4289,7 @@ int cmd_record(int argc, const char **argv)
 			goto out;
 
 		evlist__splice_list_tail(rec->evlist, &def_evlist->core.entries);
-		evlist__delete(def_evlist);
+		evlist__put(def_evlist);
 	}
 
 	if (rec->opts.target.tid && !rec->opts.no_inherit_set)
@@ -4397,7 +4397,7 @@ int cmd_record(int argc, const char **argv)
 	auxtrace_record__free(rec->itr);
 out_opts:
 	evlist__close_control(rec->opts.ctl_fd, rec->opts.ctl_fd_ack, &rec->opts.ctl_fd_close);
-	evlist__delete(rec->evlist);
+	evlist__put(rec->evlist);
 	return err;
 }
 
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 555247568e7a..d683642ab4e0 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3829,7 +3829,7 @@ static int perf_sched__schedstat_record(struct perf_sched *sched,
 	session = perf_session__new(&data, &sched->tool);
 	if (IS_ERR(session)) {
 		pr_err("Perf session creation failed.\n");
-		evlist__delete(evlist);
+		evlist__put(evlist);
 		return PTR_ERR(session);
 	}
 
@@ -3925,7 +3925,7 @@ static int perf_sched__schedstat_record(struct perf_sched *sched,
 	else
 		fprintf(stderr, "[ perf sched stats: Failed !! ]\n");
 
-	evlist__delete(evlist);
+	evlist__put(evlist);
 	close(fd);
 	return err;
 }
@@ -4724,7 +4724,7 @@ static int perf_sched__schedstat_live(struct perf_sched *sched,
 	free_cpu_domain_info(cd_map, sv, nr);
 out:
 	free_schedstat(&cpu_head);
-	evlist__delete(evlist);
+	evlist__put(evlist);
 	return err;
 }
 
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 853b141a0d50..0ead134940d5 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2269,7 +2269,7 @@ static int script_find_metrics(const struct pmu_metric *pm,
 	}
 	pr_debug("Found metric '%s' whose evsels match those of in the perf data\n",
 		 pm->metric_name);
-	evlist__delete(metric_evlist);
+	evlist__put(metric_evlist);
 out:
 	return 0;
 }
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 99d7db372b48..bfa3512e1686 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2113,7 +2113,7 @@ static int add_default_events(void)
 							stat_config.user_requested_cpu_list,
 							stat_config.system_wide,
 							stat_config.hardware_aware_grouping) < 0) {
-				evlist__delete(metric_evlist);
+				evlist__put(metric_evlist);
 				ret = -1;
 				break;
 			}
@@ -2125,7 +2125,7 @@ static int add_default_events(void)
 			metricgroup__copy_metric_events(evlist, /*cgrp=*/NULL,
 							&evlist->metric_events,
 							&metric_evlist->metric_events);
-			evlist__delete(metric_evlist);
+			evlist__put(metric_evlist);
 		}
 		list_sort(/*priv=*/NULL, &evlist->core.entries, default_evlist_evsel_cmp);
 
@@ -2146,7 +2146,7 @@ static int add_default_events(void)
 	metricgroup__copy_metric_events(evsel_list, /*cgrp=*/NULL,
 					&evsel_list->metric_events,
 					&evlist->metric_events);
-	evlist__delete(evlist);
+	evlist__put(evlist);
 	return ret;
 }
 
@@ -2381,7 +2381,7 @@ static int __cmd_report(int argc, const char **argv)
 
 	perf_stat.session  = session;
 	stat_config.output = stderr;
-	evlist__delete(evsel_list);
+	evlist__put(evsel_list);
 	evsel_list         = session->evlist;
 
 	ret = perf_session__process_events(session);
@@ -3060,7 +3060,7 @@ int cmd_stat(int argc, const char **argv)
 	if (smi_cost && smi_reset)
 		sysfs__write_int(FREEZE_ON_SMI_PATH, 0);
 
-	evlist__delete(evsel_list);
+	evlist__put(evsel_list);
 
 	evlist__close_control(stat_config.ctl_fd, stat_config.ctl_fd_ack, &stat_config.ctl_fd_close);
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index f6eb543de537..c509cfef8285 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1652,14 +1652,14 @@ int cmd_top(int argc, const char **argv)
 	perf_env__init(&host_env);
 	status = perf_config(perf_top_config, &top);
 	if (status)
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	/*
 	 * Since the per arch annotation init routine may need the cpuid, read
 	 * it here, since we are not getting this from the perf.data header.
 	 */
 	status = perf_env__set_cmdline(&host_env, argc, argv);
 	if (status)
-		goto out_delete_evlist;
+		goto out_put_evlist;
 
 	status = perf_env__read_cpuid(&host_env);
 	if (status) {
@@ -1680,30 +1680,30 @@ int cmd_top(int argc, const char **argv)
 		annotate_opts.disassembler_style = strdup(disassembler_style);
 		if (!annotate_opts.disassembler_style) {
 			status = -ENOMEM;
-			goto out_delete_evlist;
+			goto out_put_evlist;
 		}
 	}
 	if (objdump_path) {
 		annotate_opts.objdump_path = strdup(objdump_path);
 		if (!annotate_opts.objdump_path) {
 			status = -ENOMEM;
-			goto out_delete_evlist;
+			goto out_put_evlist;
 		}
 	}
 	if (addr2line_path) {
 		symbol_conf.addr2line_path = strdup(addr2line_path);
 		if (!symbol_conf.addr2line_path) {
 			status = -ENOMEM;
-			goto out_delete_evlist;
+			goto out_put_evlist;
 		}
 	}
 
 	status = symbol__validate_sym_arguments();
 	if (status)
-		goto out_delete_evlist;
+		goto out_put_evlist;
 
 	if (annotate_check_args() < 0)
-		goto out_delete_evlist;
+		goto out_put_evlist;
 
 	status = target__validate(target);
 	if (status) {
@@ -1718,15 +1718,15 @@ int cmd_top(int argc, const char **argv)
 		struct evlist *def_evlist = evlist__new_default(target, callchain_param.enabled);
 
 		if (!def_evlist)
-			goto out_delete_evlist;
+			goto out_put_evlist;
 
 		evlist__splice_list_tail(top.evlist, &def_evlist->core.entries);
-		evlist__delete(def_evlist);
+		evlist__put(def_evlist);
 	}
 
 	status = evswitch__init(&top.evswitch, top.evlist, stderr);
 	if (status)
-		goto out_delete_evlist;
+		goto out_put_evlist;
 
 	if (symbol_conf.report_hierarchy) {
 		/* disable incompatible options */
@@ -1737,18 +1737,18 @@ int cmd_top(int argc, const char **argv)
 			pr_err("Error: --hierarchy and --fields options cannot be used together\n");
 			parse_options_usage(top_usage, options, "fields", 0);
 			parse_options_usage(NULL, options, "hierarchy", 0);
-			goto out_delete_evlist;
+			goto out_put_evlist;
 		}
 	}
 
 	if (top.stitch_lbr && !(callchain_param.record_mode == CALLCHAIN_LBR)) {
 		pr_err("Error: --stitch-lbr must be used with --call-graph lbr\n");
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	}
 
 	if (nr_cgroups > 0 && opts->record_cgroup) {
 		pr_err("--cgroup and --all-cgroups cannot be used together\n");
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	}
 
 	if (branch_call_mode) {
@@ -1772,7 +1772,7 @@ int cmd_top(int argc, const char **argv)
 		status = perf_env__read_core_pmu_caps(&host_env);
 		if (status) {
 			pr_err("PMU capability data is not available\n");
-			goto out_delete_evlist;
+			goto out_put_evlist;
 		}
 	}
 
@@ -1795,7 +1795,7 @@ int cmd_top(int argc, const char **argv)
 	if (IS_ERR(top.session)) {
 		status = PTR_ERR(top.session);
 		top.session = NULL;
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	}
 	top.evlist->session = top.session;
 
@@ -1805,7 +1805,7 @@ int cmd_top(int argc, const char **argv)
 		if (field_order)
 			parse_options_usage(sort_order ? NULL : top_usage,
 					    options, "fields", 0);
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	}
 
 	if (top.uid_str) {
@@ -1814,18 +1814,18 @@ int cmd_top(int argc, const char **argv)
 		if (uid == UINT_MAX) {
 			ui__error("Invalid User: %s", top.uid_str);
 			status = -EINVAL;
-			goto out_delete_evlist;
+			goto out_put_evlist;
 		}
 		status = parse_uid_filter(top.evlist, uid);
 		if (status)
-			goto out_delete_evlist;
+			goto out_put_evlist;
 	}
 
 	if (evlist__create_maps(top.evlist, target) < 0) {
 		ui__error("Couldn't create thread/CPU maps: %s\n",
 			  errno == ENOENT ? "No such process" : str_error_r(errno, errbuf, sizeof(errbuf)));
 		status = -errno;
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	}
 
 	if (top.delay_secs < 1)
@@ -1833,7 +1833,7 @@ int cmd_top(int argc, const char **argv)
 
 	if (record_opts__config(opts)) {
 		status = -EINVAL;
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	}
 
 	top.sym_evsel = evlist__first(top.evlist);
@@ -1848,14 +1848,14 @@ int cmd_top(int argc, const char **argv)
 
 	status = symbol__annotation_init();
 	if (status < 0)
-		goto out_delete_evlist;
+		goto out_put_evlist;
 
 	annotation_config__init();
 
 	symbol_conf.try_vmlinux_path = (symbol_conf.vmlinux_name == NULL);
 	status = symbol__init(NULL);
 	if (status < 0)
-		goto out_delete_evlist;
+		goto out_put_evlist;
 
 	sort__setup_elide(stdout);
 
@@ -1875,13 +1875,13 @@ int cmd_top(int argc, const char **argv)
 		if (top.sb_evlist == NULL) {
 			pr_err("Couldn't create side band evlist.\n.");
 			status = -EINVAL;
-			goto out_delete_evlist;
+			goto out_put_evlist;
 		}
 
 		if (evlist__add_bpf_sb_event(top.sb_evlist, &host_env)) {
 			pr_err("Couldn't ask for PERF_RECORD_BPF_EVENT side band events.\n.");
 			status = -EINVAL;
-			goto out_delete_evlist;
+			goto out_put_evlist;
 		}
 	}
 #endif
@@ -1896,8 +1896,8 @@ int cmd_top(int argc, const char **argv)
 	if (!opts->no_bpf_event)
 		evlist__stop_sb_thread(top.sb_evlist);
 
-out_delete_evlist:
-	evlist__delete(top.evlist);
+out_put_evlist:
+	evlist__put(top.evlist);
 	perf_session__delete(top.session);
 	annotation_options__exit();
 	perf_env__exit(&host_env);
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e58c49d047a2..da703d762433 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4388,7 +4388,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 
 	if (trace->summary_bpf) {
 		if (trace_prepare_bpf_summary(trace->summary_mode) < 0)
-			goto out_delete_evlist;
+			goto out_put_evlist;
 
 		if (trace->summary_only)
 			goto create_maps;
@@ -4456,19 +4456,19 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	err = evlist__create_maps(evlist, &trace->opts.target);
 	if (err < 0) {
 		fprintf(trace->output, "Problems parsing the target to trace, check your options!\n");
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	}
 
 	err = trace__symbols_init(trace, argc, argv, evlist);
 	if (err < 0) {
 		fprintf(trace->output, "Problems initializing symbol libraries!\n");
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	}
 
 	if (trace->summary_mode == SUMMARY__BY_TOTAL && !trace->summary_bpf) {
 		trace->syscall_stats = alloc_syscall_stats();
 		if (!trace->syscall_stats)
-			goto out_delete_evlist;
+			goto out_put_evlist;
 	}
 
 	evlist__config(evlist, &trace->opts, &callchain_param);
@@ -4477,7 +4477,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		err = evlist__prepare_workload(evlist, &trace->opts.target, argv, false, NULL);
 		if (err < 0) {
 			fprintf(trace->output, "Couldn't run the workload!\n");
-			goto out_delete_evlist;
+			goto out_put_evlist;
 		}
 		workload_pid = evlist->workload.pid;
 	}
@@ -4525,7 +4525,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 
 	err = trace__expand_filters(trace, &evsel);
 	if (err)
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	err = evlist__apply_filters(evlist, &evsel, &trace->opts.target);
 	if (err < 0)
 		goto out_error_apply_filters;
@@ -4642,12 +4642,12 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		}
 	}
 
-out_delete_evlist:
+out_put_evlist:
 	trace_cleanup_bpf_summary();
 	delete_syscall_stats(trace->syscall_stats);
 	trace__symbols__exit(trace);
 	evlist__free_syscall_tp_fields(evlist);
-	evlist__delete(evlist);
+	evlist__put(evlist);
 	cgroup__put(trace->cgroup);
 	trace->evlist = NULL;
 	trace->live = false;
@@ -4672,21 +4672,21 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 
 out_error:
 	fprintf(trace->output, "%s\n", errbuf);
-	goto out_delete_evlist;
+	goto out_put_evlist;
 
 out_error_apply_filters:
 	fprintf(trace->output,
 		"Failed to set filter \"%s\" on event %s: %m\n",
 		evsel->filter, evsel__name(evsel));
-	goto out_delete_evlist;
+	goto out_put_evlist;
 }
 out_error_mem:
 	fprintf(trace->output, "Not enough memory to run!\n");
-	goto out_delete_evlist;
+	goto out_put_evlist;
 
 out_errno:
 	fprintf(trace->output, "%m\n");
-	goto out_delete_evlist;
+	goto out_put_evlist;
 }
 
 static int trace__replay(struct trace *trace)
@@ -5364,7 +5364,7 @@ static void trace__exit(struct trace *trace)
 		zfree(&trace->syscalls.table);
 	}
 	zfree(&trace->perfconfig_events);
-	evlist__delete(trace->evlist);
+	evlist__put(trace->evlist);
 	trace->evlist = NULL;
 	ordered_events__free(&trace->oe.data);
 #ifdef HAVE_LIBBPF_SUPPORT
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index c5e7999f2817..2b49b002d749 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -111,7 +111,7 @@ static int test__backward_ring_buffer(struct test_suite *test __maybe_unused, in
 	err = evlist__create_maps(evlist, &opts.target);
 	if (err < 0) {
 		pr_debug("Not enough memory to create thread/cpu maps\n");
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	}
 
 	parse_events_error__init(&parse_error);
@@ -124,7 +124,7 @@ static int test__backward_ring_buffer(struct test_suite *test __maybe_unused, in
 	if (err) {
 		pr_debug("Failed to parse tracepoint event, try use root\n");
 		ret = TEST_SKIP;
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	}
 
 	evlist__config(evlist, &opts, NULL);
@@ -133,19 +133,19 @@ static int test__backward_ring_buffer(struct test_suite *test __maybe_unused, in
 	if (err < 0) {
 		pr_debug("perf_evlist__open: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	}
 
 	ret = TEST_FAIL;
 	err = do_test(evlist, opts.mmap_pages, &sample_count,
 		      &comm_count);
 	if (err != TEST_OK)
-		goto out_delete_evlist;
+		goto out_put_evlist;
 
 	if ((sample_count != NR_ITERS) || (comm_count != NR_ITERS)) {
 		pr_err("Unexpected counter: sample_count=%d, comm_count=%d\n",
 		       sample_count, comm_count);
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	}
 
 	evlist__close(evlist);
@@ -154,16 +154,16 @@ static int test__backward_ring_buffer(struct test_suite *test __maybe_unused, in
 	if (err < 0) {
 		pr_debug("perf_evlist__open: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	}
 
 	err = do_test(evlist, 1, &sample_count, &comm_count);
 	if (err != TEST_OK)
-		goto out_delete_evlist;
+		goto out_put_evlist;
 
 	ret = TEST_OK;
-out_delete_evlist:
-	evlist__delete(evlist);
+out_put_evlist:
+	evlist__put(evlist);
 	return ret;
 }
 
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 47043a3a2fb4..fc65a17f67f7 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -807,7 +807,7 @@ static int do_test_code_reading(bool try_kcore)
 			}
 
 			perf_evlist__set_maps(&evlist->core, NULL, NULL);
-			evlist__delete(evlist);
+			evlist__put(evlist);
 			evlist = NULL;
 			continue;
 		}
@@ -844,7 +844,7 @@ static int do_test_code_reading(bool try_kcore)
 out_put:
 	thread__put(thread);
 out_err:
-	evlist__delete(evlist);
+	evlist__put(evlist);
 	perf_cpu_map__put(cpus);
 	perf_thread_map__put(threads);
 	machine__delete(machine);
diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index ae3b98bb42cf..94ab54ecd3f9 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -186,7 +186,7 @@ static int test_times(int (attach)(struct evlist *),
 	err = attach(evlist);
 	if (err == TEST_SKIP) {
 		pr_debug("  SKIP  : not enough rights\n");
-		evlist__delete(evlist);
+		evlist__put(evlist);
 		return err;
 	}
 
@@ -205,7 +205,7 @@ static int test_times(int (attach)(struct evlist *),
 		 count.ena, count.run);
 
 out_err:
-	evlist__delete(evlist);
+	evlist__put(evlist);
 	return !err ? TEST_OK : TEST_FAIL;
 }
 
diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index facc65e29f20..73141b122d2f 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -117,7 +117,7 @@ static int test__event_update(struct test_suite *test __maybe_unused, int subtes
 	TEST_ASSERT_VAL("failed to synthesize attr update cpus",
 			!perf_event__synthesize_event_update_cpus(&tmp.tool, evsel, process_event_cpus));
 
-	evlist__delete(evlist);
+	evlist__put(evlist);
 	return 0;
 }
 
diff --git a/tools/perf/tests/evsel-roundtrip-name.c b/tools/perf/tests/evsel-roundtrip-name.c
index 1922cac13a24..6a220634c52f 100644
--- a/tools/perf/tests/evsel-roundtrip-name.c
+++ b/tools/perf/tests/evsel-roundtrip-name.c
@@ -33,7 +33,7 @@ static int perf_evsel__roundtrip_cache_name_test(void)
 				if (err) {
 					pr_debug("Failure to parse cache event '%s' possibly as PMUs don't support it",
 						name);
-					evlist__delete(evlist);
+					evlist__put(evlist);
 					continue;
 				}
 				evlist__for_each_entry(evlist, evsel) {
@@ -42,7 +42,7 @@ static int perf_evsel__roundtrip_cache_name_test(void)
 						ret = TEST_FAIL;
 					}
 				}
-				evlist__delete(evlist);
+				evlist__put(evlist);
 			}
 		}
 	}
@@ -66,7 +66,7 @@ static int perf_evsel__name_array_test(const char *const names[], int nr_names)
 		if (err) {
 			pr_debug("failed to parse event '%s', err %d\n",
 				 names[i], err);
-			evlist__delete(evlist);
+			evlist__put(evlist);
 			ret = TEST_FAIL;
 			continue;
 		}
@@ -76,7 +76,7 @@ static int perf_evsel__name_array_test(const char *const names[], int nr_names)
 				ret = TEST_FAIL;
 			}
 		}
-		evlist__delete(evlist);
+		evlist__put(evlist);
 	}
 	return ret;
 }
diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
index dd547f2f77cc..a7a445f12693 100644
--- a/tools/perf/tests/expand-cgroup.c
+++ b/tools/perf/tests/expand-cgroup.c
@@ -106,7 +106,7 @@ static int expand_default_events(void)
 	TEST_ASSERT_VAL("failed to get evlist", evlist);
 
 	ret = test_expand_events(evlist);
-	evlist__delete(evlist);
+	evlist__put(evlist);
 	return ret;
 }
 
@@ -133,7 +133,7 @@ static int expand_group_events(void)
 	ret = test_expand_events(evlist);
 out:
 	parse_events_error__exit(&err);
-	evlist__delete(evlist);
+	evlist__put(evlist);
 	return ret;
 }
 
@@ -164,7 +164,7 @@ static int expand_libpfm_events(void)
 
 	ret = test_expand_events(evlist);
 out:
-	evlist__delete(evlist);
+	evlist__put(evlist);
 	return ret;
 }
 
@@ -188,7 +188,7 @@ static int expand_metric_events(void)
 	ret = test_expand_events(evlist);
 
 out:
-	evlist__delete(evlist);
+	evlist__put(evlist);
 	return ret;
 }
 
diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists_cumulate.c
index 606aa926a8fc..eca4ecb63ca8 100644
--- a/tools/perf/tests/hists_cumulate.c
+++ b/tools/perf/tests/hists_cumulate.c
@@ -744,7 +744,7 @@ static int test__hists_cumulate(struct test_suite *test __maybe_unused, int subt
 
 out:
 	/* tear down everything */
-	evlist__delete(evlist);
+	evlist__put(evlist);
 	machines__exit(&machines);
 	put_fake_samples();
 
diff --git a/tools/perf/tests/hists_filter.c b/tools/perf/tests/hists_filter.c
index cc6b26e373d1..0d09dc306019 100644
--- a/tools/perf/tests/hists_filter.c
+++ b/tools/perf/tests/hists_filter.c
@@ -332,7 +332,7 @@ static int test__hists_filter(struct test_suite *test __maybe_unused, int subtes
 
 out:
 	/* tear down everything */
-	evlist__delete(evlist);
+	evlist__put(evlist);
 	reset_output_field();
 	machines__exit(&machines);
 	put_fake_samples();
diff --git a/tools/perf/tests/hists_link.c b/tools/perf/tests/hists_link.c
index 996f5f0b3bd1..9646c3b7b4de 100644
--- a/tools/perf/tests/hists_link.c
+++ b/tools/perf/tests/hists_link.c
@@ -352,7 +352,7 @@ static int test__hists_link(struct test_suite *test __maybe_unused, int subtest
 
 out:
 	/* tear down everything */
-	evlist__delete(evlist);
+	evlist__put(evlist);
 	reset_output_field();
 	machines__exit(&machines);
 	put_fake_samples();
diff --git a/tools/perf/tests/hists_output.c b/tools/perf/tests/hists_output.c
index 7818950d786e..3f3bc978553e 100644
--- a/tools/perf/tests/hists_output.c
+++ b/tools/perf/tests/hists_output.c
@@ -631,7 +631,7 @@ static int test__hists_output(struct test_suite *test __maybe_unused, int subtes
 
 out:
 	/* tear down everything */
-	evlist__delete(evlist);
+	evlist__put(evlist);
 	machines__exit(&machines);
 	put_fake_samples();
 
diff --git a/tools/perf/tests/hwmon_pmu.c b/tools/perf/tests/hwmon_pmu.c
index ada6e445c4c4..1b60c3a900f1 100644
--- a/tools/perf/tests/hwmon_pmu.c
+++ b/tools/perf/tests/hwmon_pmu.c
@@ -214,7 +214,7 @@ static int do_test(size_t i, bool with_pmu, bool with_alias)
 
 out:
 	parse_events_error__exit(&err);
-	evlist__delete(evlist);
+	evlist__put(evlist);
 	return ret;
 }
 
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index 729cc9cc1cb7..51cfd6522867 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -153,7 +153,7 @@ static int test__keep_tracking(struct test_suite *test __maybe_unused, int subte
 out_err:
 	if (evlist) {
 		evlist__disable(evlist);
-		evlist__delete(evlist);
+		evlist__put(evlist);
 	}
 	perf_cpu_map__put(cpus);
 	perf_thread_map__put(threads);
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 8d04f6edb004..e6501791c505 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -94,7 +94,7 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
 				/* Permissions failure, flag the failure as a skip. */
 				err = TEST_SKIP;
 			}
-			goto out_delete_evlist;
+			goto out_put_evlist;
 		}
 
 		evsels[i]->core.attr.wakeup_events = 1;
@@ -106,7 +106,7 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
 			pr_debug("failed to open counter: %s, "
 				 "tweak /proc/sys/kernel/perf_event_paranoid?\n",
 				 str_error_r(errno, sbuf, sizeof(sbuf)));
-			goto out_delete_evlist;
+			goto out_put_evlist;
 		}
 
 		nr_events[i] = 0;
@@ -116,7 +116,7 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
 	if (evlist__mmap(evlist, 128) < 0) {
 		pr_debug("failed to mmap events: %d (%s)\n", errno,
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	}
 
 	for (i = 0; i < nsyscalls; ++i)
@@ -134,7 +134,7 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
 		if (event->header.type != PERF_RECORD_SAMPLE) {
 			pr_debug("unexpected %s event\n",
 				 perf_event__name(event->header.type));
-			goto out_delete_evlist;
+			goto out_put_evlist;
 		}
 
 		perf_sample__init(&sample, /*all=*/false);
@@ -142,7 +142,7 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
 		if (err) {
 			pr_err("Can't parse sample, err = %d\n", err);
 			perf_sample__exit(&sample);
-			goto out_delete_evlist;
+			goto out_put_evlist;
 		}
 
 		err = -1;
@@ -151,7 +151,7 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
 		if (evsel == NULL) {
 			pr_debug("event with id %" PRIu64
 				 " doesn't map to an evsel\n", sample.id);
-			goto out_delete_evlist;
+			goto out_put_evlist;
 		}
 		nr_events[evsel->core.idx]++;
 		perf_mmap__consume(&md->core);
@@ -166,12 +166,12 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
 				 expected_nr_events[evsel->core.idx],
 				 evsel__name(evsel), nr_events[evsel->core.idx]);
 			err = -1;
-			goto out_delete_evlist;
+			goto out_put_evlist;
 		}
 	}
 
-out_delete_evlist:
-	evlist__delete(evlist);
+out_put_evlist:
+	evlist__put(evlist);
 out_free_cpus:
 	perf_cpu_map__put(cpus);
 out_free_threads:
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 2a139d2781a8..3ff595c7a86a 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -51,7 +51,7 @@ static int test__syscall_openat_tp_fields(struct test_suite *test __maybe_unused
 	if (IS_ERR(evsel)) {
 		pr_debug("%s: evsel__newtp\n", __func__);
 		ret = PTR_ERR(evsel) == -EACCES ? TEST_SKIP : TEST_FAIL;
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	}
 
 	evlist__add(evlist, evsel);
@@ -59,7 +59,7 @@ static int test__syscall_openat_tp_fields(struct test_suite *test __maybe_unused
 	err = evlist__create_maps(evlist, &opts.target);
 	if (err < 0) {
 		pr_debug("%s: evlist__create_maps\n", __func__);
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	}
 
 	evsel__config(evsel, &opts, NULL);
@@ -70,14 +70,14 @@ static int test__syscall_openat_tp_fields(struct test_suite *test __maybe_unused
 	if (err < 0) {
 		pr_debug("perf_evlist__open: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	}
 
 	err = evlist__mmap(evlist, UINT_MAX);
 	if (err < 0) {
 		pr_debug("evlist__mmap: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	}
 
 	evlist__enable(evlist);
@@ -115,7 +115,7 @@ static int test__syscall_openat_tp_fields(struct test_suite *test __maybe_unused
 				if (err) {
 					pr_debug("Can't parse sample, err = %d\n", err);
 					perf_sample__exit(&sample);
-					goto out_delete_evlist;
+					goto out_put_evlist;
 				}
 
 				tp_flags = evsel__intval(evsel, &sample, "flags");
@@ -123,7 +123,7 @@ static int test__syscall_openat_tp_fields(struct test_suite *test __maybe_unused
 				if (flags != tp_flags) {
 					pr_debug("%s: Expected flags=%#x, got %#x\n",
 						 __func__, flags, tp_flags);
-					goto out_delete_evlist;
+					goto out_put_evlist;
 				}
 
 				goto out_ok;
@@ -136,13 +136,13 @@ static int test__syscall_openat_tp_fields(struct test_suite *test __maybe_unused
 
 		if (++nr_polls > 5) {
 			pr_debug("%s: no events!\n", __func__);
-			goto out_delete_evlist;
+			goto out_put_evlist;
 		}
 	}
 out_ok:
 	ret = TEST_OK;
-out_delete_evlist:
-	evlist__delete(evlist);
+out_put_evlist:
+	evlist__put(evlist);
 out:
 	return ret;
 }
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 05c3e899b425..19dc7b7475d2 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -2568,7 +2568,7 @@ static int test_event(const struct evlist_test *e)
 		ret = e->check(evlist);
 	}
 	parse_events_error__exit(&err);
-	evlist__delete(evlist);
+	evlist__put(evlist);
 
 	return ret;
 }
@@ -2594,7 +2594,7 @@ static int test_event_fake_pmu(const char *str)
 	}
 
 	parse_events_error__exit(&err);
-	evlist__delete(evlist);
+	evlist__put(evlist);
 
 	return ret;
 }
diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 7c7f489a5eb0..3f0ec839c056 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -84,7 +84,7 @@ static int __compute_metric(const char *name, struct value *vals,
 
 	cpus = perf_cpu_map__new("0");
 	if (!cpus) {
-		evlist__delete(evlist);
+		evlist__put(evlist);
 		return -ENOMEM;
 	}
 
@@ -113,7 +113,7 @@ static int __compute_metric(const char *name, struct value *vals,
 	/* ... cleanup. */
 	evlist__free_stats(evlist);
 	perf_cpu_map__put(cpus);
-	evlist__delete(evlist);
+	evlist__put(evlist);
 	return err;
 }
 
diff --git a/tools/perf/tests/parse-no-sample-id-all.c b/tools/perf/tests/parse-no-sample-id-all.c
index 50e68b7d43aa..d5a8d065809e 100644
--- a/tools/perf/tests/parse-no-sample-id-all.c
+++ b/tools/perf/tests/parse-no-sample-id-all.c
@@ -49,7 +49,7 @@ static int process_events(union perf_event **events, size_t count)
 	for (i = 0; i < count && !err; i++)
 		err = process_event(&evlist, events[i]);
 
-	evlist__delete(evlist);
+	evlist__put(evlist);
 
 	return err;
 }
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index ad44cc68820b..f95752b2ed1c 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -105,7 +105,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 	err = evlist__create_maps(evlist, &opts.target);
 	if (err < 0) {
 		pr_debug("Not enough memory to create thread/cpu maps\n");
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	}
 
 	/*
@@ -117,7 +117,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 	err = evlist__prepare_workload(evlist, &opts.target, argv, false, NULL);
 	if (err < 0) {
 		pr_debug("Couldn't run the workload!\n");
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	}
 
 	/*
@@ -134,7 +134,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 		pr_debug("sched__get_first_possible_cpu: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
 		evlist__cancel_workload(evlist);
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	}
 
 	cpu = err;
@@ -146,7 +146,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 		pr_debug("sched_setaffinity: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
 		evlist__cancel_workload(evlist);
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	}
 
 	/*
@@ -158,7 +158,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 		pr_debug("perf_evlist__open: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
 		evlist__cancel_workload(evlist);
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	}
 
 	/*
@@ -171,7 +171,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 		pr_debug("evlist__mmap: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
 		evlist__cancel_workload(evlist);
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	}
 
 	/*
@@ -209,7 +209,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 					if (verbose > 0)
 						perf_event__fprintf(event, NULL, stderr);
 					pr_debug("Couldn't parse sample\n");
-					goto out_delete_evlist;
+					goto out_put_evlist;
 				}
 
 				if (verbose > 0) {
@@ -350,9 +350,9 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 		pr_debug("PERF_RECORD_MMAP for %s missing!\n", "[vdso]");
 		++errs;
 	}
-out_delete_evlist:
+out_put_evlist:
 	CPU_FREE(cpu_mask);
-	evlist__delete(evlist);
+	evlist__put(evlist);
 out:
 	perf_sample__exit(&sample);
 	if (err == -EACCES)
diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
index cca41bd37ae3..d3538fa20af3 100644
--- a/tools/perf/tests/perf-time-to-tsc.c
+++ b/tools/perf/tests/perf-time-to-tsc.c
@@ -201,7 +201,7 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
 	err = TEST_OK;
 
 out_err:
-	evlist__delete(evlist);
+	evlist__put(evlist);
 	perf_cpu_map__put(cpus);
 	perf_thread_map__put(threads);
 	return err;
diff --git a/tools/perf/tests/pfm.c b/tools/perf/tests/pfm.c
index fca4a86452df..8d19b1bfecbc 100644
--- a/tools/perf/tests/pfm.c
+++ b/tools/perf/tests/pfm.c
@@ -80,7 +80,7 @@ static int test__pfm_events(struct test_suite *test __maybe_unused,
 				evlist__nr_groups(evlist),
 				0);
 
-		evlist__delete(evlist);
+		evlist__put(evlist);
 	}
 	return 0;
 }
@@ -165,7 +165,7 @@ static int test__pfm_group(struct test_suite *test __maybe_unused,
 				evlist__nr_groups(evlist),
 				table[i].nr_groups);
 
-		evlist__delete(evlist);
+		evlist__put(evlist);
 	}
 	return 0;
 }
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index a99716862168..236bbbad5773 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -797,7 +797,7 @@ static int check_parse_id(const char *id, struct parse_events_error *error)
 			     /*warn_if_reordered=*/true, /*fake_tp=*/false);
 	free(dup);
 
-	evlist__delete(evlist);
+	evlist__put(evlist);
 	return ret;
 }
 
@@ -844,7 +844,7 @@ static int test__parsing_callback(const struct pmu_metric *pm,
 
 	cpus = perf_cpu_map__new("0");
 	if (!cpus) {
-		evlist__delete(evlist);
+		evlist__put(evlist);
 		return -ENOMEM;
 	}
 
@@ -899,7 +899,7 @@ static int test__parsing_callback(const struct pmu_metric *pm,
 	/* ... cleanup. */
 	evlist__free_stats(evlist);
 	perf_cpu_map__put(cpus);
-	evlist__delete(evlist);
+	evlist__put(evlist);
 	return err;
 }
 
diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 0ebf2d7b2cb4..3d931c1f99dd 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -287,7 +287,7 @@ static int test__pmu_usr_chgs(struct test_suite *test __maybe_unused, int subtes
 	ret = TEST_OK;
 err_out:
 	parse_events_terms__exit(&terms);
-	evlist__delete(evlist);
+	evlist__put(evlist);
 	test_pmu_put(dir, pmu);
 	return ret;
 }
@@ -339,7 +339,7 @@ static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest
 	ret = TEST_OK;
 err_out:
 	parse_events_error__exit(&err);
-	evlist__delete(evlist);
+	evlist__put(evlist);
 	test_pmu_put(dir, pmu);
 	return ret;
 }
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index b6e46975379c..bb6b62cf51d1 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -59,7 +59,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 	evsel = evsel__new(&attr);
 	if (evsel == NULL) {
 		pr_debug("evsel__new\n");
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	}
 	evlist__add(evlist, evsel);
 
@@ -68,7 +68,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 	if (!cpus || !threads) {
 		err = -ENOMEM;
 		pr_debug("Not enough memory to create thread/cpu maps\n");
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	}
 
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
@@ -80,14 +80,14 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 		pr_debug("Couldn't open evlist: %s\nHint: check %s, using %" PRIu64 " in this test.\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)),
 			 knob, (u64)attr.sample_freq);
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	}
 
 	err = evlist__mmap(evlist, 128);
 	if (err < 0) {
 		pr_debug("failed to mmap event: %d (%s)\n", errno,
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	}
 
 	evlist__enable(evlist);
@@ -113,7 +113,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 		if (err < 0) {
 			pr_debug("Error during parse sample\n");
 			perf_sample__exit(&sample);
-			goto out_delete_evlist;
+			goto out_put_evlist;
 		}
 
 		total_periods += sample.period;
@@ -131,10 +131,10 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 		err = -1;
 	}
 
-out_delete_evlist:
+out_put_evlist:
 	perf_cpu_map__put(cpus);
 	perf_thread_map__put(threads);
-	evlist__delete(evlist);
+	evlist__put(evlist);
 	return err;
 }
 
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 72a8289e846d..306151c83af8 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -579,7 +579,7 @@ static int test__switch_tracking(struct test_suite *test __maybe_unused, int sub
 out:
 	if (evlist) {
 		evlist__disable(evlist);
-		evlist__delete(evlist);
+		evlist__put(evlist);
 	}
 	perf_cpu_map__put(cpus);
 	perf_thread_map__put(threads);
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 4053ff2813bb..a46650b10689 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -74,7 +74,7 @@ static int test__task_exit(struct test_suite *test __maybe_unused, int subtest _
 	if (!cpus || !threads) {
 		err = -ENOMEM;
 		pr_debug("Not enough memory to create thread/cpu maps\n");
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	}
 
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
@@ -82,7 +82,7 @@ static int test__task_exit(struct test_suite *test __maybe_unused, int subtest _
 	err = evlist__prepare_workload(evlist, &target, argv, false, workload_exec_failed_signal);
 	if (err < 0) {
 		pr_debug("Couldn't run the workload!\n");
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	}
 
 	evsel = evlist__first(evlist);
@@ -101,14 +101,14 @@ static int test__task_exit(struct test_suite *test __maybe_unused, int subtest _
 	if (err < 0) {
 		pr_debug("Couldn't open the evlist: %s\n",
 			 str_error_r(-err, sbuf, sizeof(sbuf)));
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	}
 
 	if (evlist__mmap(evlist, 128) < 0) {
 		pr_debug("failed to mmap events: %d (%s)\n", errno,
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
 		err = -1;
-		goto out_delete_evlist;
+		goto out_put_evlist;
 	}
 
 	evlist__start_workload(evlist);
@@ -133,7 +133,7 @@ static int test__task_exit(struct test_suite *test __maybe_unused, int subtest _
 		if (retry_count++ > 1000) {
 			pr_debug("Failed after retrying 1000 times\n");
 			err = -1;
-			goto out_delete_evlist;
+			goto out_put_evlist;
 		}
 
 		goto retry;
@@ -144,10 +144,10 @@ static int test__task_exit(struct test_suite *test __maybe_unused, int subtest _
 		err = -1;
 	}
 
-out_delete_evlist:
+out_put_evlist:
 	perf_cpu_map__put(cpus);
 	perf_thread_map__put(threads);
-	evlist__delete(evlist);
+	evlist__put(evlist);
 	return err;
 }
 
diff --git a/tools/perf/tests/tool_pmu.c b/tools/perf/tests/tool_pmu.c
index 1e900ef92e37..e78ff9dcea97 100644
--- a/tools/perf/tests/tool_pmu.c
+++ b/tools/perf/tests/tool_pmu.c
@@ -67,7 +67,7 @@ static int do_test(enum tool_pmu_event ev, bool with_pmu)
 
 out:
 	parse_events_error__exit(&err);
-	evlist__delete(evlist);
+	evlist__put(evlist);
 	return ret;
 }
 
diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index f54502ebef4b..4ecf5d750313 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -57,7 +57,7 @@ static int session_write_header(char *path)
 			!perf_session__write_header(session, session->evlist,
 						    perf_data__fd(&data), true));
 
-	evlist__delete(session->evlist);
+	evlist__put(session->evlist);
 	perf_session__delete(session);
 
 	return 0;
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 1b5664d1481f..652a45aac828 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -520,8 +520,8 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str, bool open_cgro
 	cgrp_event_expanded = true;
 
 out_err:
-	evlist__delete(orig_list);
-	evlist__delete(tmp_list);
+	evlist__put(orig_list);
+	evlist__put(tmp_list);
 	metricgroup__rblist_exit(&orig_metric_events);
 	release_cgroup_list();
 
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 3b8f2df823a9..a85ae53db7c5 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -1363,7 +1363,7 @@ static void cleanup_events(struct perf_session *session)
 		zfree(&evsel->priv);
 	}
 
-	evlist__delete(evlist);
+	evlist__put(evlist);
 	session->evlist = NULL;
 }
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 35d65fe50e06..b5a7895debf5 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -75,7 +75,7 @@ int sigqueue(pid_t pid, int sig, const union sigval value);
 #define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
 #define SID(e, x, y) xyarray__entry(e->core.sample_id, x, y)
 
-void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
+static void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 		  struct perf_thread_map *threads)
 {
 	perf_evlist__init(&evlist->core);
@@ -88,6 +88,7 @@ void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 	evlist->nr_br_cntr = -1;
 	metricgroup__rblist_init(&evlist->metric_events);
 	INIT_LIST_HEAD(&evlist->deferred_samples);
+	refcount_set(&evlist->refcnt, 1);
 }
 
 struct evlist *evlist__new(void)
@@ -139,7 +140,7 @@ struct evlist *evlist__new_default(const struct target *target, bool sample_call
 
 	return evlist;
 out_err:
-	evlist__delete(evlist);
+	evlist__put(evlist);
 	return NULL;
 }
 
@@ -148,13 +149,19 @@ struct evlist *evlist__new_dummy(void)
 	struct evlist *evlist = evlist__new();
 
 	if (evlist && evlist__add_dummy(evlist)) {
-		evlist__delete(evlist);
+		evlist__put(evlist);
 		evlist = NULL;
 	}
 
 	return evlist;
 }
 
+struct evlist *evlist__get(struct evlist *evlist)
+{
+	refcount_inc(&evlist->refcnt);
+	return evlist;
+}
+
 /**
  * evlist__set_id_pos - set the positions of event ids.
  * @evlist: selected event list
@@ -193,7 +200,7 @@ static void evlist__purge(struct evlist *evlist)
 	evlist->core.nr_entries = 0;
 }
 
-void evlist__exit(struct evlist *evlist)
+static void evlist__exit(struct evlist *evlist)
 {
 	metricgroup__rblist_exit(&evlist->metric_events);
 	event_enable_timer__exit(&evlist->eet);
@@ -202,11 +209,14 @@ void evlist__exit(struct evlist *evlist)
 	perf_evlist__exit(&evlist->core);
 }
 
-void evlist__delete(struct evlist *evlist)
+void evlist__put(struct evlist *evlist)
 {
 	if (evlist == NULL)
 		return;
 
+	if (!refcount_dec_and_test(&evlist->refcnt))
+		return;
+
 	evlist__free_stats(evlist);
 	evlist__munmap(evlist);
 	evlist__close(evlist);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index e54761c670b6..a9820a6aad5b 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -61,6 +61,7 @@ struct event_enable_timer;
 
 struct evlist {
 	struct perf_evlist core;
+	refcount_t	 refcnt;
 	bool		 enabled;
 	bool		 no_affinity;
 	int		 id_pos;
@@ -109,10 +110,8 @@ struct evsel_str_handler {
 struct evlist *evlist__new(void);
 struct evlist *evlist__new_default(const struct target *target, bool sample_callchains);
 struct evlist *evlist__new_dummy(void);
-void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
-		  struct perf_thread_map *threads);
-void evlist__exit(struct evlist *evlist);
-void evlist__delete(struct evlist *evlist);
+struct evlist *evlist__get(struct evlist *evlist);
+void evlist__put(struct evlist *evlist);
 
 void evlist__add(struct evlist *evlist, struct evsel *entry);
 void evlist__remove(struct evlist *evlist, struct evsel *evsel);
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 644769e92708..cf54bbbc8ddc 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -450,7 +450,7 @@ double expr__has_event(const struct expr_parse_ctx *ctx, bool compute_ids, const
 		ret = parse_event(tmp, id) ? 0 : 1;
 	}
 out:
-	evlist__delete(tmp);
+	evlist__put(tmp);
 	return ret;
 }
 
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index f30e48eb3fc3..f9887d2fc8ed 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -4909,12 +4909,12 @@ int perf_session__read_header(struct perf_session *session)
 		evsel = evsel__new(&f_attr.attr);
 
 		if (evsel == NULL)
-			goto out_delete_evlist;
+			goto out_put_evlist;
 
 		evsel->needs_swap = header->needs_swap;
 		/*
 		 * Do it before so that if perf_evsel__alloc_id fails, this
-		 * entry gets purged too at evlist__delete().
+		 * entry gets purged too at evlist__put().
 		 */
 		evlist__add(session->evlist, evsel);
 
@@ -4925,7 +4925,7 @@ int perf_session__read_header(struct perf_session *session)
 		 * hattr->ids threads.
 		 */
 		if (perf_evsel__alloc_id(&evsel->core, 1, nr_ids))
-			goto out_delete_evlist;
+			goto out_put_evlist;
 
 		lseek(fd, f_attr.ids.offset, SEEK_SET);
 
@@ -4944,7 +4944,7 @@ int perf_session__read_header(struct perf_session *session)
 				      perf_file_section__process);
 
 	if (evlist__prepare_tracepoint_events(session->evlist, session->tevent.pevent))
-		goto out_delete_evlist;
+		goto out_put_evlist;
 #else
 	perf_header__process_sections(header, fd, NULL, perf_file_section__process);
 #endif
@@ -4953,8 +4953,8 @@ int perf_session__read_header(struct perf_session *session)
 out_errno:
 	return -errno;
 
-out_delete_evlist:
-	evlist__delete(session->evlist);
+out_put_evlist:
+	evlist__put(session->evlist);
 	session->evlist = NULL;
 	return -ENOMEM;
 }
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 4db9578efd81..191ec2d8a250 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -214,7 +214,7 @@ static void metric__free(struct metric *m)
 	zfree(&m->metric_refs);
 	expr__ctx_free(m->pctx);
 	zfree(&m->modifier);
-	evlist__delete(m->evlist);
+	evlist__put(m->evlist);
 	free(m);
 }
 
@@ -1335,7 +1335,7 @@ static int parse_ids(bool metric_no_merge, bool fake_pmu,
 	parsed_evlist = NULL;
 err_out:
 	parse_events_error__exit(&parse_error);
-	evlist__delete(parsed_evlist);
+	evlist__put(parsed_evlist);
 	strbuf_release(&events);
 	return ret;
 }
@@ -1546,7 +1546,7 @@ static int parse_groups(struct evlist *perf_evlist,
 
 	if (combined_evlist) {
 		evlist__splice_list_tail(perf_evlist, &combined_evlist->core.entries);
-		evlist__delete(combined_evlist);
+		evlist__put(combined_evlist);
 	}
 
 	list_for_each_entry(m, &metric_list, nd) {
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 1497e1f2a08c..f0809be63ad8 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2316,7 +2316,7 @@ int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filte
 
 	/*
 	 * There are 2 users - builtin-record and builtin-test objects.
-	 * Both call evlist__delete in case of error, so we dont
+	 * Both call evlist__put in case of error, so we dont
 	 * need to bother.
 	 */
 	return ret;
@@ -2519,7 +2519,7 @@ int parse_events_option_new_evlist(const struct option *opt, const char *str, in
 	}
 	ret = parse_events_option(opt, str, unset);
 	if (ret) {
-		evlist__delete(*args->evlistp);
+		evlist__put(*args->evlistp);
 		*args->evlistp = NULL;
 	}
 
diff --git a/tools/perf/util/perf_api_probe.c b/tools/perf/util/perf_api_probe.c
index e1904a330b28..f61c4ec52827 100644
--- a/tools/perf/util/perf_api_probe.c
+++ b/tools/perf/util/perf_api_probe.c
@@ -57,7 +57,7 @@ static int perf_do_probe_api(setup_probe_fn_t fn, struct perf_cpu cpu, const cha
 	err = 0;
 
 out_delete:
-	evlist__delete(evlist);
+	evlist__put(evlist);
 	return err;
 }
 
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 1e6c99efff90..3f0758d5bd90 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1272,7 +1272,7 @@ static int pyrf_evsel__setup_types(void)
 struct pyrf_evlist {
 	PyObject_HEAD
 
-	struct evlist evlist;
+	struct evlist *evlist;
 };
 
 static int pyrf_evlist__init(struct pyrf_evlist *pevlist,
@@ -1285,15 +1285,22 @@ static int pyrf_evlist__init(struct pyrf_evlist *pevlist,
 	if (!PyArg_ParseTuple(args, "OO", &pcpus, &pthreads))
 		return -1;
 
+	evlist__put(pevlist->evlist);
+	pevlist->evlist = evlist__new();
+	if (!pevlist->evlist) {
+		PyErr_NoMemory();
+		return -1;
+	}
 	threads = ((struct pyrf_thread_map *)pthreads)->threads;
 	cpus = ((struct pyrf_cpu_map *)pcpus)->cpus;
-	evlist__init(&pevlist->evlist, cpus, threads);
+	perf_evlist__set_maps(&pevlist->evlist->core, cpus, threads);
+
 	return 0;
 }
 
 static void pyrf_evlist__delete(struct pyrf_evlist *pevlist)
 {
-	evlist__exit(&pevlist->evlist);
+	evlist__put(pevlist->evlist);
 	Py_TYPE(pevlist)->tp_free((PyObject*)pevlist);
 }
 
@@ -1302,7 +1309,7 @@ static PyObject *pyrf_evlist__all_cpus(struct pyrf_evlist *pevlist)
 	struct pyrf_cpu_map *pcpu_map = PyObject_New(struct pyrf_cpu_map, &pyrf_cpu_map__type);
 
 	if (pcpu_map)
-		pcpu_map->cpus = perf_cpu_map__get(pevlist->evlist.core.all_cpus);
+		pcpu_map->cpus = perf_cpu_map__get(pevlist->evlist->core.all_cpus);
 
 	return (PyObject *)pcpu_map;
 }
@@ -1315,7 +1322,7 @@ static PyObject *pyrf_evlist__metrics(struct pyrf_evlist *pevlist)
 	if (!list)
 		return NULL;
 
-	for (node = rb_first_cached(&pevlist->evlist.metric_events.entries); node;
+	for (node = rb_first_cached(&pevlist->evlist->metric_events.entries); node;
 	     node = rb_next(node)) {
 		struct metric_event *me = container_of(node, struct metric_event, nd);
 		struct list_head *pos;
@@ -1421,7 +1428,7 @@ static PyObject *pyrf_evlist__compute_metric(struct pyrf_evlist *pevlist,
 	if (!PyArg_ParseTuple(args, "sii", &metric, &cpu, &thread))
 		return NULL;
 
-	for (node = rb_first_cached(&pevlist->evlist.metric_events.entries);
+	for (node = rb_first_cached(&pevlist->evlist->metric_events.entries);
 	     mexp == NULL && node;
 	     node = rb_next(node)) {
 		struct metric_event *me = container_of(node, struct metric_event, nd);
@@ -1437,7 +1444,7 @@ static PyObject *pyrf_evlist__compute_metric(struct pyrf_evlist *pevlist,
 			if (e->metric_events[0] == NULL)
 				continue;
 
-			evlist__for_each_entry(&pevlist->evlist, pos2) {
+			evlist__for_each_entry(pevlist->evlist, pos2) {
 				if (pos2->metric_leader != e->metric_events[0])
 					continue;
 				cpu_idx = perf_cpu_map__idx(pos2->core.cpus,
@@ -1482,7 +1489,7 @@ static PyObject *pyrf_evlist__compute_metric(struct pyrf_evlist *pevlist,
 static PyObject *pyrf_evlist__mmap(struct pyrf_evlist *pevlist,
 				   PyObject *args, PyObject *kwargs)
 {
-	struct evlist *evlist = &pevlist->evlist;
+	struct evlist *evlist = pevlist->evlist;
 	static char *kwlist[] = { "pages", "overwrite", NULL };
 	int pages = 128, overwrite = false;
 
@@ -1502,7 +1509,7 @@ static PyObject *pyrf_evlist__mmap(struct pyrf_evlist *pevlist,
 static PyObject *pyrf_evlist__poll(struct pyrf_evlist *pevlist,
 				   PyObject *args, PyObject *kwargs)
 {
-	struct evlist *evlist = &pevlist->evlist;
+	struct evlist *evlist = pevlist->evlist;
 	static char *kwlist[] = { "timeout", NULL };
 	int timeout = -1, n;
 
@@ -1522,7 +1529,7 @@ static PyObject *pyrf_evlist__get_pollfd(struct pyrf_evlist *pevlist,
 					 PyObject *args __maybe_unused,
 					 PyObject *kwargs __maybe_unused)
 {
-	struct evlist *evlist = &pevlist->evlist;
+	struct evlist *evlist = pevlist->evlist;
         PyObject *list = PyList_New(0);
 	int i;
 
@@ -1551,7 +1558,7 @@ static PyObject *pyrf_evlist__add(struct pyrf_evlist *pevlist,
 				  PyObject *args,
 				  PyObject *kwargs __maybe_unused)
 {
-	struct evlist *evlist = &pevlist->evlist;
+	struct evlist *evlist = pevlist->evlist;
 	PyObject *pevsel;
 	struct evsel *evsel;
 
@@ -1583,7 +1590,7 @@ static struct mmap *get_md(struct evlist *evlist, int cpu)
 static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 					  PyObject *args, PyObject *kwargs)
 {
-	struct evlist *evlist = &pevlist->evlist;
+	struct evlist *evlist = pevlist->evlist;
 	union perf_event *event;
 	int sample_id_all = 1, cpu;
 	static char *kwlist[] = { "cpu", "sample_id_all", NULL };
@@ -1640,7 +1647,7 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 static PyObject *pyrf_evlist__open(struct pyrf_evlist *pevlist,
 				   PyObject *args, PyObject *kwargs)
 {
-	struct evlist *evlist = &pevlist->evlist;
+	struct evlist *evlist = pevlist->evlist;
 
 	if (evlist__open(evlist) < 0) {
 		PyErr_SetFromErrno(PyExc_OSError);
@@ -1653,7 +1660,7 @@ static PyObject *pyrf_evlist__open(struct pyrf_evlist *pevlist,
 
 static PyObject *pyrf_evlist__close(struct pyrf_evlist *pevlist)
 {
-	struct evlist *evlist = &pevlist->evlist;
+	struct evlist *evlist = pevlist->evlist;
 
 	evlist__close(evlist);
 
@@ -1679,7 +1686,7 @@ static PyObject *pyrf_evlist__config(struct pyrf_evlist *pevlist)
 		.no_buffering        = true,
 		.no_inherit          = true,
 	};
-	struct evlist *evlist = &pevlist->evlist;
+	struct evlist *evlist = pevlist->evlist;
 
 	evlist__config(evlist, &opts, &callchain_param);
 	Py_INCREF(Py_None);
@@ -1688,14 +1695,14 @@ static PyObject *pyrf_evlist__config(struct pyrf_evlist *pevlist)
 
 static PyObject *pyrf_evlist__disable(struct pyrf_evlist *pevlist)
 {
-	evlist__disable(&pevlist->evlist);
+	evlist__disable(pevlist->evlist);
 	Py_INCREF(Py_None);
 	return Py_None;
 }
 
 static PyObject *pyrf_evlist__enable(struct pyrf_evlist *pevlist)
 {
-	evlist__enable(&pevlist->evlist);
+	evlist__enable(pevlist->evlist);
 	Py_INCREF(Py_None);
 	return Py_None;
 }
@@ -1786,7 +1793,23 @@ static Py_ssize_t pyrf_evlist__length(PyObject *obj)
 {
 	struct pyrf_evlist *pevlist = (void *)obj;
 
-	return pevlist->evlist.core.nr_entries;
+	return pevlist->evlist->core.nr_entries;
+}
+
+static PyObject *pyrf_evsel__from_evsel(struct evsel *evsel)
+{
+	struct pyrf_evsel *pevsel = PyObject_New(struct pyrf_evsel, &pyrf_evsel__type);
+
+	if (!pevsel)
+		return NULL;
+
+	memset(&pevsel->evsel, 0, sizeof(pevsel->evsel));
+	evsel__init(&pevsel->evsel, &evsel->core.attr, evsel->core.idx);
+
+	evsel__clone(&pevsel->evsel, evsel);
+	if (evsel__is_group_leader(evsel))
+		evsel__set_leader(&pevsel->evsel, &pevsel->evsel);
+	return (PyObject *)pevsel;
 }
 
 static PyObject *pyrf_evlist__item(PyObject *obj, Py_ssize_t i)
@@ -1794,17 +1817,16 @@ static PyObject *pyrf_evlist__item(PyObject *obj, Py_ssize_t i)
 	struct pyrf_evlist *pevlist = (void *)obj;
 	struct evsel *pos;
 
-	if (i >= pevlist->evlist.core.nr_entries) {
+	if (i >= pevlist->evlist->core.nr_entries) {
 		PyErr_SetString(PyExc_IndexError, "Index out of range");
 		return NULL;
 	}
 
-	evlist__for_each_entry(&pevlist->evlist, pos) {
+	evlist__for_each_entry(pevlist->evlist, pos) {
 		if (i-- == 0)
 			break;
 	}
-
-	return Py_BuildValue("O", container_of(pos, struct pyrf_evsel, evsel));
+	return pyrf_evsel__from_evsel(pos);
 }
 
 static PyObject *pyrf_evlist__str(PyObject *self)
@@ -1816,7 +1838,7 @@ static PyObject *pyrf_evlist__str(PyObject *self)
 	PyObject *result;
 
 	strbuf_addstr(&sb, "evlist([");
-	evlist__for_each_entry(&pevlist->evlist, pos) {
+	evlist__for_each_entry(pevlist->evlist, pos) {
 		if (!first)
 			strbuf_addch(&sb, ',');
 		if (!pos->pmu)
@@ -1957,157 +1979,74 @@ static PyObject *pyrf__tracepoint(struct pyrf_evsel *pevsel,
 	return PyLong_FromLong(tp_pmu__id(sys, name));
 }
 
-static PyObject *pyrf_evsel__from_evsel(struct evsel *evsel)
-{
-	struct pyrf_evsel *pevsel = PyObject_New(struct pyrf_evsel, &pyrf_evsel__type);
-
-	if (!pevsel)
-		return NULL;
-
-	memset(&pevsel->evsel, 0, sizeof(pevsel->evsel));
-	evsel__init(&pevsel->evsel, &evsel->core.attr, evsel->core.idx);
-
-	evsel__clone(&pevsel->evsel, evsel);
-	if (evsel__is_group_leader(evsel))
-		evsel__set_leader(&pevsel->evsel, &pevsel->evsel);
-	return (PyObject *)pevsel;
-}
-
-static int evlist__pos(struct evlist *evlist, struct evsel *evsel)
-{
-	struct evsel *pos;
-	int idx = 0;
-
-	evlist__for_each_entry(evlist, pos) {
-		if (evsel == pos)
-			return idx;
-		idx++;
-	}
-	return -1;
-}
-
-static struct evsel *evlist__at(struct evlist *evlist, int idx)
-{
-	struct evsel *pos;
-	int idx2 = 0;
-
-	evlist__for_each_entry(evlist, pos) {
-		if (idx == idx2)
-			return pos;
-		idx2++;
-	}
-	return NULL;
-}
-
 static PyObject *pyrf_evlist__from_evlist(struct evlist *evlist)
 {
 	struct pyrf_evlist *pevlist = PyObject_New(struct pyrf_evlist, &pyrf_evlist__type);
-	struct evsel *pos;
-	struct rb_node *node;
 
 	if (!pevlist)
 		return NULL;
 
-	memset(&pevlist->evlist, 0, sizeof(pevlist->evlist));
-	evlist__init(&pevlist->evlist, evlist->core.all_cpus, evlist->core.threads);
-	evlist__for_each_entry(evlist, pos) {
-		struct pyrf_evsel *pevsel = (void *)pyrf_evsel__from_evsel(pos);
-
-		evlist__add(&pevlist->evlist, &pevsel->evsel);
-	}
-	evlist__for_each_entry(&pevlist->evlist, pos) {
-		struct evsel *leader = evsel__leader(pos);
-
-		if (pos != leader) {
-			int idx = evlist__pos(evlist, leader);
-
-			if (idx >= 0)
-				evsel__set_leader(pos, evlist__at(&pevlist->evlist, idx));
-			else if (leader == NULL)
-				evsel__set_leader(pos, pos);
-		}
-
-		leader = pos->metric_leader;
-
-		if (pos != leader) {
-			int idx = evlist__pos(evlist, leader);
-
-			if (idx >= 0)
-				pos->metric_leader = evlist__at(&pevlist->evlist, idx);
-			else if (leader == NULL)
-				pos->metric_leader = pos;
-		}
-	}
-	metricgroup__copy_metric_events(&pevlist->evlist, /*cgrp=*/NULL,
-					&pevlist->evlist.metric_events,
-					&evlist->metric_events);
-	for (node = rb_first_cached(&pevlist->evlist.metric_events.entries); node;
-	     node = rb_next(node)) {
-		struct metric_event *me = container_of(node, struct metric_event, nd);
-		struct list_head *mpos;
-		int idx = evlist__pos(evlist, me->evsel);
-
-		if (idx >= 0)
-			me->evsel = evlist__at(&pevlist->evlist, idx);
-		list_for_each(mpos, &me->head) {
-			struct metric_expr *e = container_of(mpos, struct metric_expr, nd);
-
-			for (int j = 0; e->metric_events[j]; j++) {
-				idx = evlist__pos(evlist, e->metric_events[j]);
-				if (idx >= 0)
-					e->metric_events[j] = evlist__at(&pevlist->evlist, idx);
-			}
-		}
-	}
+	pevlist->evlist = evlist__get(evlist);
 	return (PyObject *)pevlist;
 }
 
 static PyObject *pyrf__parse_events(PyObject *self, PyObject *args)
 {
 	const char *input;
-	struct evlist evlist = {};
+	struct evlist *evlist = evlist__new();
 	struct parse_events_error err;
 	PyObject *result;
 	PyObject *pcpus = NULL, *pthreads = NULL;
 	struct perf_cpu_map *cpus;
 	struct perf_thread_map *threads;
 
-	if (!PyArg_ParseTuple(args, "s|OO", &input, &pcpus, &pthreads))
+	if (!evlist)
+		return PyErr_NoMemory();
+
+	if (!PyArg_ParseTuple(args, "s|OO", &input, &pcpus, &pthreads)) {
+		evlist__put(evlist);
 		return NULL;
+	}
 
 	threads = pthreads ? ((struct pyrf_thread_map *)pthreads)->threads : NULL;
 	cpus = pcpus ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
 
 	parse_events_error__init(&err);
-	evlist__init(&evlist, cpus, threads);
-	if (parse_events(&evlist, input, &err)) {
+	perf_evlist__set_maps(&evlist->core, cpus, threads);
+	if (parse_events(evlist, input, &err)) {
 		parse_events_error__print(&err, input);
 		PyErr_SetFromErrno(PyExc_OSError);
+		evlist__put(evlist);
 		return NULL;
 	}
-	result = pyrf_evlist__from_evlist(&evlist);
-	evlist__exit(&evlist);
+	result = pyrf_evlist__from_evlist(evlist);
+	evlist__put(evlist);
 	return result;
 }
 
 static PyObject *pyrf__parse_metrics(PyObject *self, PyObject *args)
 {
 	const char *input, *pmu = NULL;
-	struct evlist evlist = {};
+	struct evlist *evlist = evlist__new();
 	PyObject *result;
 	PyObject *pcpus = NULL, *pthreads = NULL;
 	struct perf_cpu_map *cpus;
 	struct perf_thread_map *threads;
 	int ret;
 
-	if (!PyArg_ParseTuple(args, "s|sOO", &input, &pmu, &pcpus, &pthreads))
+	if (!evlist)
+		return PyErr_NoMemory();
+
+	if (!PyArg_ParseTuple(args, "s|sOO", &input, &pmu, &pcpus, &pthreads)) {
+		evlist__put(evlist);
 		return NULL;
+	}
 
 	threads = pthreads ? ((struct pyrf_thread_map *)pthreads)->threads : NULL;
 	cpus = pcpus ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
 
-	evlist__init(&evlist, cpus, threads);
-	ret = metricgroup__parse_groups(&evlist, pmu ?: "all", input,
+	perf_evlist__set_maps(&evlist->core, cpus, threads);
+	ret = metricgroup__parse_groups(evlist, pmu ?: "all", input,
 					/*metric_no_group=*/ false,
 					/*metric_no_merge=*/ false,
 					/*metric_no_threshold=*/ true,
@@ -2115,12 +2054,13 @@ static PyObject *pyrf__parse_metrics(PyObject *self, PyObject *args)
 					/*system_wide=*/true,
 					/*hardware_aware_grouping=*/ false);
 	if (ret) {
+		evlist__put(evlist);
 		errno = -ret;
 		PyErr_SetFromErrno(PyExc_OSError);
 		return NULL;
 	}
-	result = pyrf_evlist__from_evlist(&evlist);
-	evlist__exit(&evlist);
+	result = pyrf_evlist__from_evlist(evlist);
+	evlist__put(evlist);
 	return result;
 }
 
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index e867de8ddaaa..8a5fc7d5e43c 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -264,7 +264,7 @@ bool evlist__can_select_event(struct evlist *evlist, const char *str)
 	ret = true;
 
 out_delete:
-	evlist__delete(temp_evlist);
+	evlist__put(temp_evlist);
 	return ret;
 }
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index fe0de2a0277f..1ac6cd43c38b 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -264,7 +264,7 @@ void perf_session__delete(struct perf_session *session)
 	machines__exit(&session->machines);
 	if (session->data) {
 		if (perf_data__is_read(session->data))
-			evlist__delete(session->evlist);
+			evlist__put(session->evlist);
 		perf_data__close(session->data);
 	}
 #ifdef HAVE_LIBTRACEEVENT
diff --git a/tools/perf/util/sideband_evlist.c b/tools/perf/util/sideband_evlist.c
index 388846f17bc1..b84a5463e039 100644
--- a/tools/perf/util/sideband_evlist.c
+++ b/tools/perf/util/sideband_evlist.c
@@ -102,7 +102,7 @@ int evlist__start_sb_thread(struct evlist *evlist, struct target *target)
 		return 0;
 
 	if (evlist__create_maps(evlist, target))
-		goto out_delete_evlist;
+		goto out_put_evlist;
 
 	if (evlist->core.nr_entries > 1) {
 		bool can_sample_identifier = perf_can_sample_identifier();
@@ -116,25 +116,25 @@ int evlist__start_sb_thread(struct evlist *evlist, struct target *target)
 	evlist__for_each_entry(evlist, counter) {
 		if (evsel__open(counter, evlist->core.user_requested_cpus,
 				evlist->core.threads) < 0)
-			goto out_delete_evlist;
+			goto out_put_evlist;
 	}
 
 	if (evlist__mmap(evlist, UINT_MAX))
-		goto out_delete_evlist;
+		goto out_put_evlist;
 
 	evlist__for_each_entry(evlist, counter) {
 		if (evsel__enable(counter))
-			goto out_delete_evlist;
+			goto out_put_evlist;
 	}
 
 	evlist->thread.done = 0;
 	if (pthread_create(&evlist->thread.th, NULL, perf_evlist__poll_thread, evlist))
-		goto out_delete_evlist;
+		goto out_put_evlist;
 
 	return 0;
 
-out_delete_evlist:
-	evlist__delete(evlist);
+out_put_evlist:
+	evlist__put(evlist);
 	evlist = NULL;
 	return -1;
 }
@@ -145,5 +145,5 @@ void evlist__stop_sb_thread(struct evlist *evlist)
 		return;
 	evlist->thread.done = 1;
 	pthread_join(evlist->thread.th, NULL);
-	evlist__delete(evlist);
+	evlist__put(evlist);
 }
-- 
2.54.0.rc2.533.g4f5dca5207-goog

