Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DD62FBDEF
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 05:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761716085; cv=none; b=bYi1FvGVfxAaj+o+bK/RF8LONc2MQh0FzkWbPcYcoTzuOlk8LkDgn3738PUAG00bl58oIEdpjAkG54xRIZDxIjaB7aHoussdaUqNoI0fNeJu0LlIEi12z4iLPhlf3YLLH4uDXaThPaXjrgJc4hv9hrD0KBi3qYMqQCMQS9AgJhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761716085; c=relaxed/simple;
	bh=cjJrqP3PhFWrUnpJAFSlrQGyKHEhV6VPoRZSaSLf/r0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=m8zNT8Ee+Z11WR4A72AlGgRrcfppWixaM/u/YCCL38JuW2RcA9WHeEEeH7gJxN8izVmmA9L4rPtwYhBJQEwzK16G5F5gLLShyp1LwedbSCTZZ55Q7Dos6KRWe3YogUe41Q3o1Bq4M2tRTemMw8ERZVuFKy4x/N0AAxjzXEqaHZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=veK+REv+; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="veK+REv+"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32eb18b5659so5388217a91.2
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Oct 2025 22:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761716082; x=1762320882; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w4FHRoIXwozyDq2OI6JitQ6frsI8lP29+tytphMUEl8=;
        b=veK+REv+YXSs1Dxj4eRTPCmCML28ZOe7aBdDWTpBGrehvnsaBKqKfkeQYlJoiVEPnn
         N3vdbAfiU73lbS4RAx78zXbggM87K+Y8IK122faxOPVJflqtS6j34fzpLhDzOwLhv1XE
         RJOsP8nZ6Pw968fRBbtQXB+DB3kiuOhO2O8RFFqqkhT8/+8PIEvyPuFPz7KhG0QVXVQ6
         3iP33R562+GAOhV5OAQZqG/9JzP9+BgrfDybhQkTwtWSe7X+9fiqK+Jhnp2yMABhGAMS
         M7FO5q/ohONyuuL7e8DxzBOZbri2CKioOjOsb5WLbKPd7hDzKa55WPWeYZZXRLp9vzht
         mbwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761716082; x=1762320882;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w4FHRoIXwozyDq2OI6JitQ6frsI8lP29+tytphMUEl8=;
        b=AfkYJvwnx2FL80sN+4YpTfrvA2k82eEKATdpNi7HOOnBrQ+/g3aY4hlTqP8FNnDTbp
         Sui6YaVPucbO95o1pOu/QXGk4hqlt2Va25K65D7wtnzoL2KkHoid9DIfbTSNu+dHtPSZ
         Jmz5130wVoIoD+okxBc2tVfALWe4cq665qsyR7vz3qoU0GyIaeL1cByCT7zfPBbYgdwP
         tgBgMYrh+AVduSBWsbDJnmQrckBJzp3HJPZ4C4YWog0t5zIl7mMZ7lG+Y4JhBtbpyL8U
         6+gXH21i3w5tTs/tMmvnY27gGRa4LQMKNcYTaZi9F/j8ap4S5fwfTs9aLLFJDL+2QOLN
         GJEg==
X-Forwarded-Encrypted: i=1; AJvYcCX8CXJ8d6qc7ZPlG1vO89FfNPiBaNip+vpWn0WkIBR8qQyGLqw4E79hGSvybsDM/0pur6C7r98yuJxL08cXYtwV@vger.kernel.org
X-Gm-Message-State: AOJu0YyqKOFSmrmEQ4rSRAQGNHVZ1MQCl3wVHZKc0fDLAFTyRkkkO7Hb
	cHypOFbfV0cI5MbIoEs4flPlbE3avfFOm/Ebi11FxnSX6cN7GkIhrPPNMT1DjiQU5XnzOdS9Yh6
	vt3bc6WL3xQ==
X-Google-Smtp-Source: AGHT+IHhAzAfaPEyv5F0rXMF6LDk184VOiayS7SJisbf7OlvmKS/qKtb9pSc3NI1+FzqJwTb7GHvmrBLwK7+
X-Received: from pjbgq17.prod.google.com ([2002:a17:90b:1051:b0:33d:acf4:5aac])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b43:b0:33b:8b1c:5e85
 with SMTP id 98e67ed59e1d1-3403a25a668mr1625016a91.3.1761716081965; Tue, 28
 Oct 2025 22:34:41 -0700 (PDT)
Date: Tue, 28 Oct 2025 22:34:11 -0700
In-Reply-To: <20251029053413.355154-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029053413.355154-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029053413.355154-14-irogers@google.com>
Subject: [RFC PATCH v1 13/15] perf evsel: Add reference count
From: Ian Rogers <irogers@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Song Liu <song@kernel.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Blake Jones <blakejones@google.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Chun-Tse Shao <ctshao@google.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Gautam Menghani <gautam@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

As with evlist this a no-op for most of the perf tool. The reference
count is set to 1 at allocation, the put will see the 1, decrement it
and perform the delete. The purpose for adding the reference count is
for the python code. Prior to this change the python code would clone
evsels, but this has issues if events are opened, etc. leading to
assertion failures. With a reference count the same evsel can be used
and the reference count incremented for the python usage.  To not
change the python evsel API getset functions are added for the evsel
members, no set function is provided for size as it doesn't make sense
to alter this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c                 |  12 +-
 tools/perf/tests/evsel-tp-sched.c          |   4 +-
 tools/perf/tests/openat-syscall-all-cpus.c |   6 +-
 tools/perf/tests/openat-syscall.c          |   6 +-
 tools/perf/util/bpf_counter_cgroup.c       |   2 +-
 tools/perf/util/cgroup.c                   |   2 +-
 tools/perf/util/evlist.c                   |   2 +-
 tools/perf/util/evsel.c                    |  26 ++-
 tools/perf/util/evsel.h                    |  11 +-
 tools/perf/util/parse-events.y             |   2 +-
 tools/perf/util/pfm.c                      |   2 +-
 tools/perf/util/print-events.c             |   2 +-
 tools/perf/util/python.c                   | 212 +++++++++++++++++----
 13 files changed, 218 insertions(+), 71 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c056df42a78f..1168759983da 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -449,10 +449,10 @@ static int evsel__init_tp_ptr_field(struct evsel *evsel, struct tp_field *field,
 	({ struct syscall_tp *sc = __evsel__syscall_tp(evsel);\
 	   evsel__init_tp_ptr_field(evsel, &sc->name, #name); })
 
-static void evsel__delete_priv(struct evsel *evsel)
+static void evsel__put_and_free_priv(struct evsel *evsel)
 {
 	zfree(&evsel->priv);
-	evsel__delete(evsel);
+	evsel__put(evsel);
 }
 
 static int evsel__init_syscall_tp(struct evsel *evsel)
@@ -532,7 +532,7 @@ static struct evsel *perf_evsel__raw_syscall_newtp(const char *direction, void *
 	return evsel;
 
 out_delete:
-	evsel__delete_priv(evsel);
+	evsel__put_and_free_priv(evsel);
 	return NULL;
 }
 
@@ -3560,7 +3560,7 @@ static bool evlist__add_vfs_getname(struct evlist *evlist)
 
 		list_del_init(&evsel->core.node);
 		evsel->evlist = NULL;
-		evsel__delete(evsel);
+		evsel__put(evsel);
 	}
 
 	return found;
@@ -3674,9 +3674,9 @@ static int trace__add_syscall_newtp(struct trace *trace)
 	return ret;
 
 out_delete_sys_exit:
-	evsel__delete_priv(sys_exit);
+	evsel__put_and_free_priv(sys_exit);
 out_delete_sys_enter:
-	evsel__delete_priv(sys_enter);
+	evsel__put_and_free_priv(sys_enter);
 	goto out;
 }
 
diff --git a/tools/perf/tests/evsel-tp-sched.c b/tools/perf/tests/evsel-tp-sched.c
index 226196fb9677..9e456f88a13a 100644
--- a/tools/perf/tests/evsel-tp-sched.c
+++ b/tools/perf/tests/evsel-tp-sched.c
@@ -64,7 +64,7 @@ static int test__perf_evsel__tp_sched_test(struct test_suite *test __maybe_unuse
 	if (evsel__test_field(evsel, "next_prio", 4, true))
 		ret = TEST_FAIL;
 
-	evsel__delete(evsel);
+	evsel__put(evsel);
 
 	evsel = evsel__newtp("sched", "sched_wakeup");
 
@@ -85,7 +85,7 @@ static int test__perf_evsel__tp_sched_test(struct test_suite *test __maybe_unuse
 	if (evsel__test_field(evsel, "target_cpu", 4, true))
 		ret = TEST_FAIL;
 
-	evsel__delete(evsel);
+	evsel__put(evsel);
 	return ret;
 }
 
diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index 3644d6f52c07..605d41295e8a 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -58,7 +58,7 @@ static int test__openat_syscall_event_on_all_cpus(struct test_suite *test __mayb
 			 "tweak /proc/sys/kernel/perf_event_paranoid?\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
 		err = TEST_SKIP;
-		goto out_evsel_delete;
+		goto out_evsel_put;
 	}
 
 	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
@@ -115,8 +115,8 @@ static int test__openat_syscall_event_on_all_cpus(struct test_suite *test __mayb
 	evsel__free_counts(evsel);
 out_close_fd:
 	perf_evsel__close_fd(&evsel->core);
-out_evsel_delete:
-	evsel__delete(evsel);
+out_evsel_put:
+	evsel__put(evsel);
 out_cpu_map_delete:
 	perf_cpu_map__put(cpus);
 out_thread_map_delete:
diff --git a/tools/perf/tests/openat-syscall.c b/tools/perf/tests/openat-syscall.c
index b54cbe5f1808..9f16f0dd3a29 100644
--- a/tools/perf/tests/openat-syscall.c
+++ b/tools/perf/tests/openat-syscall.c
@@ -42,7 +42,7 @@ static int test__openat_syscall_event(struct test_suite *test __maybe_unused,
 			 "tweak /proc/sys/kernel/perf_event_paranoid?\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
 		err = TEST_SKIP;
-		goto out_evsel_delete;
+		goto out_evsel_put;
 	}
 
 	for (i = 0; i < nr_openat_calls; ++i) {
@@ -64,8 +64,8 @@ static int test__openat_syscall_event(struct test_suite *test __maybe_unused,
 	err = TEST_OK;
 out_close_fd:
 	perf_evsel__close_fd(&evsel->core);
-out_evsel_delete:
-	evsel__delete(evsel);
+out_evsel_put:
+	evsel__put(evsel);
 out_thread_map_delete:
 	perf_thread_map__put(threads);
 	return err;
diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
index 68bd994c8880..f12c45c27c40 100644
--- a/tools/perf/util/bpf_counter_cgroup.c
+++ b/tools/perf/util/bpf_counter_cgroup.c
@@ -314,7 +314,7 @@ static int bperf_cgrp__destroy(struct evsel *evsel)
 		return 0;
 
 	bperf_cgroup_bpf__destroy(skel);
-	evsel__delete(cgrp_switch);  // it'll destroy on_switch progs too
+	evsel__put(cgrp_switch);  // it'll destroy on_switch progs too
 
 	return 0;
 }
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index ed230cd44ba7..5409878e3ec6 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -468,7 +468,7 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str, bool open_cgro
 
 		leader = NULL;
 		evlist__for_each_entry(orig_list, pos) {
-			evsel = evsel__clone(/*dest=*/NULL, pos);
+			evsel = evsel__clone(pos);
 			if (evsel == NULL)
 				goto out_err;
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index ea1f398c14e3..bfa99d0c9e25 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -182,7 +182,7 @@ static void evlist__purge(struct evlist *evlist)
 	evlist__for_each_entry_safe(evlist, n, pos) {
 		list_del_init(&pos->core.node);
 		pos->evlist = NULL;
-		evsel__delete(pos);
+		evsel__put(pos);
 	}
 
 	evlist->core.nr_entries = 0;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 6769cd27b6e4..514ad4797562 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -385,10 +385,11 @@ bool evsel__is_function_event(struct evsel *evsel)
 #undef FUNCTION_EVENT
 }
 
-void evsel__init(struct evsel *evsel,
+static void evsel__init(struct evsel *evsel,
 		 struct perf_event_attr *attr, int idx)
 {
 	perf_evsel__init(&evsel->core, attr, idx);
+	refcount_set(&evsel->refcnt, 1);
 	evsel->tracking	   = !idx;
 	evsel->unit	   = strdup("");
 	evsel->scale	   = 1.0;
@@ -470,7 +471,7 @@ static int evsel__copy_config_terms(struct evsel *dst, struct evsel *src)
  * The assumption is that @orig is not configured nor opened yet.
  * So we only care about the attributes that can be set while it's parsed.
  */
-struct evsel *evsel__clone(struct evsel *dest, struct evsel *orig)
+struct evsel *evsel__clone(struct evsel *orig)
 {
 	struct evsel *evsel;
 
@@ -483,11 +484,7 @@ struct evsel *evsel__clone(struct evsel *dest, struct evsel *orig)
 	if (orig->bpf_obj)
 		return NULL;
 
-	if (dest)
-		evsel = dest;
-	else
-		evsel = evsel__new(&orig->core.attr);
-
+	evsel = evsel__new(&orig->core.attr);
 	if (evsel == NULL)
 		return NULL;
 
@@ -571,7 +568,7 @@ struct evsel *evsel__clone(struct evsel *dest, struct evsel *orig)
 	return evsel;
 
 out_err:
-	evsel__delete(evsel);
+	evsel__put(evsel);
 	return NULL;
 }
 
@@ -630,6 +627,12 @@ struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx, bool
 	return ERR_PTR(err);
 }
 
+struct evsel *evsel__get(struct evsel *evsel)
+{
+	refcount_inc(&evsel->refcnt);
+	return evsel;
+}
+
 #ifdef HAVE_LIBTRACEEVENT
 struct tep_event *evsel__tp_format(struct evsel *evsel)
 {
@@ -1728,7 +1731,7 @@ void evsel__set_priv_destructor(void (*destructor)(void *priv))
 	evsel__priv_destructor = destructor;
 }
 
-void evsel__exit(struct evsel *evsel)
+static void evsel__exit(struct evsel *evsel)
 {
 	assert(list_empty(&evsel->core.node));
 	assert(evsel->evlist == NULL);
@@ -1764,11 +1767,14 @@ void evsel__exit(struct evsel *evsel)
 		xyarray__delete(evsel->start_times);
 }
 
-void evsel__delete(struct evsel *evsel)
+void evsel__put(struct evsel *evsel)
 {
 	if (!evsel)
 		return;
 
+	if (!refcount_dec_and_test(&evsel->refcnt))
+		return;
+
 	evsel__exit(evsel);
 	free(evsel);
 }
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index f4540920604e..2e65a3d84a7f 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -8,6 +8,7 @@
 #include <internal/evsel.h>
 #include <linux/list.h>
 #include <linux/perf_event.h>
+#include <linux/refcount.h>
 #include <linux/types.h>
 #include <perf/evsel.h>
 
@@ -46,6 +47,7 @@ typedef int (evsel__sb_cb_t)(union perf_event *event, void *data);
 struct evsel {
 	struct perf_evsel	core;
 	struct evlist		*evlist;
+	refcount_t		refcnt;
 	off_t			id_offset;
 	int			id_pos;
 	int			is_pos;
@@ -258,7 +260,7 @@ static inline struct evsel *evsel__new(struct perf_event_attr *attr)
 	return evsel__new_idx(attr, 0);
 }
 
-struct evsel *evsel__clone(struct evsel *dest, struct evsel *orig);
+struct evsel *evsel__clone(struct evsel *orig);
 
 int copy_config_terms(struct list_head *dst, struct list_head *src);
 void free_config_terms(struct list_head *config_terms);
@@ -273,14 +275,13 @@ static inline struct evsel *evsel__newtp(const char *sys, const char *name)
 	return evsel__newtp_idx(sys, name, 0, true);
 }
 
+struct evsel *evsel__get(struct evsel *evsel);
+void evsel__put(struct evsel *evsel);
+
 #ifdef HAVE_LIBTRACEEVENT
 struct tep_event *evsel__tp_format(struct evsel *evsel);
 #endif
 
-void evsel__init(struct evsel *evsel, struct perf_event_attr *attr, int idx);
-void evsel__exit(struct evsel *evsel);
-void evsel__delete(struct evsel *evsel);
-
 void evsel__set_priv_destructor(void (*destructor)(void *priv));
 
 struct callchain_param;
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index c194de5ec1ec..b531b1f0ceb3 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -47,7 +47,7 @@ static void free_list_evsel(struct list_head* list_evsel)
 
 	list_for_each_entry_safe(evsel, tmp, list_evsel, core.node) {
 		list_del_init(&evsel->core.node);
-		evsel__delete(evsel);
+		evsel__put(evsel);
 	}
 	free(list_evsel);
 }
diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
index e5b3a2a5ddef..f226ffd2b596 100644
--- a/tools/perf/util/pfm.c
+++ b/tools/perf/util/pfm.c
@@ -158,7 +158,7 @@ static bool is_libpfm_event_supported(const char *name, struct perf_cpu_map *cpu
 		result = false;
 
 	evsel__close(evsel);
-	evsel__delete(evsel);
+	evsel__put(evsel);
 
 	return result;
 }
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 8f3ed83853a9..bbefbc49a062 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -179,7 +179,7 @@ bool is_event_supported(u8 type, u64 config)
 		}
 
 		evsel__close(evsel);
-		evsel__delete(evsel);
+		evsel__put(evsel);
 	}
 
 	perf_thread_map__put(tmap);
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 4149a51e9878..27410b3fb7c5 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -275,6 +275,7 @@ static PyMemberDef pyrf_sample_event__members[] = {
 
 static void pyrf_sample_event__delete(struct pyrf_event *pevent)
 {
+	evsel__put(pevent->evsel);
 	perf_sample__exit(&pevent->sample);
 	Py_TYPE(pevent)->tp_free((PyObject*)pevent);
 }
@@ -946,7 +947,7 @@ static int pyrf_counts_values__setup_types(void)
 struct pyrf_evsel {
 	PyObject_HEAD
 
-	struct evsel evsel;
+	struct evsel *evsel;
 };
 
 static int pyrf_evsel__init(struct pyrf_evsel *pevsel,
@@ -1054,20 +1055,20 @@ static int pyrf_evsel__init(struct pyrf_evsel *pevsel,
 	attr.sample_id_all  = sample_id_all;
 	attr.size	    = sizeof(attr);
 
-	evsel__init(&pevsel->evsel, &attr, idx);
-	return 0;
+	pevsel->evsel = evsel__new(&attr);
+	return pevsel->evsel ? 0 : -1;
 }
 
 static void pyrf_evsel__delete(struct pyrf_evsel *pevsel)
 {
-	evsel__exit(&pevsel->evsel);
+	evsel__put(pevsel->evsel);
 	Py_TYPE(pevsel)->tp_free((PyObject*)pevsel);
 }
 
 static PyObject *pyrf_evsel__open(struct pyrf_evsel *pevsel,
 				  PyObject *args, PyObject *kwargs)
 {
-	struct evsel *evsel = &pevsel->evsel;
+	struct evsel *evsel = pevsel->evsel;
 	struct perf_cpu_map *cpus = NULL;
 	struct perf_thread_map *threads = NULL;
 	PyObject *pcpus = NULL, *pthreads = NULL;
@@ -1103,7 +1104,7 @@ static PyObject *pyrf_evsel__cpus(struct pyrf_evsel *pevsel)
 	struct pyrf_cpu_map *pcpu_map = PyObject_New(struct pyrf_cpu_map, &pyrf_cpu_map__type);
 
 	if (pcpu_map)
-		pcpu_map->cpus = perf_cpu_map__get(pevsel->evsel.core.cpus);
+		pcpu_map->cpus = perf_cpu_map__get(pevsel->evsel->core.cpus);
 
 	return (PyObject *)pcpu_map;
 }
@@ -1114,7 +1115,7 @@ static PyObject *pyrf_evsel__threads(struct pyrf_evsel *pevsel)
 		PyObject_New(struct pyrf_thread_map, &pyrf_thread_map__type);
 
 	if (pthread_map)
-		pthread_map->threads = perf_thread_map__get(pevsel->evsel.core.threads);
+		pthread_map->threads = perf_thread_map__get(pevsel->evsel->core.threads);
 
 	return (PyObject *)pthread_map;
 }
@@ -1148,7 +1149,7 @@ static int evsel__ensure_counts(struct evsel *evsel)
 static PyObject *pyrf_evsel__read(struct pyrf_evsel *pevsel,
 				  PyObject *args, PyObject *kwargs)
 {
-	struct evsel *evsel = &pevsel->evsel;
+	struct evsel *evsel = pevsel->evsel;
 	int cpu = 0, cpu_idx, thread = 0, thread_idx;
 	struct perf_counts_values *old_count, *new_count;
 	struct pyrf_counts_values *count_values = PyObject_New(struct pyrf_counts_values,
@@ -1193,7 +1194,7 @@ static PyObject *pyrf_evsel__read(struct pyrf_evsel *pevsel,
 static PyObject *pyrf_evsel__str(PyObject *self)
 {
 	struct pyrf_evsel *pevsel = (void *)self;
-	struct evsel *evsel = &pevsel->evsel;
+	struct evsel *evsel = pevsel->evsel;
 
 	return PyUnicode_FromFormat("evsel(%s/%s/)", evsel__pmu_name(evsel), evsel__name(evsel));
 }
@@ -1226,26 +1227,170 @@ static PyMethodDef pyrf_evsel__methods[] = {
 	{ .ml_name = NULL, }
 };
 
-#define evsel_member_def(member, ptype, help) \
-	{ #member, ptype, \
-	  offsetof(struct pyrf_evsel, evsel.member), \
-	  0, help }
+static PyObject *pyrf_evsel__get_tracking(PyObject *self, void */*closure*/)
+{
+	struct pyrf_evsel *pevsel = (void *)self;
 
-#define evsel_attr_member_def(member, ptype, help) \
-	{ #member, ptype, \
-	  offsetof(struct pyrf_evsel, evsel.core.attr.member), \
-	  0, help }
+	if (pevsel->evsel->tracking)
+		Py_RETURN_TRUE;
+	else
+		Py_RETURN_FALSE;
+}
 
-static PyMemberDef pyrf_evsel__members[] = {
-	evsel_member_def(tracking, T_BOOL, "tracking event."),
-	evsel_attr_member_def(type, T_UINT, "attribute type."),
-	evsel_attr_member_def(size, T_UINT, "attribute size."),
-	evsel_attr_member_def(config, T_ULONGLONG, "attribute config."),
-	evsel_attr_member_def(sample_period, T_ULONGLONG, "attribute sample_period."),
-	evsel_attr_member_def(sample_type, T_ULONGLONG, "attribute sample_type."),
-	evsel_attr_member_def(read_format, T_ULONGLONG, "attribute read_format."),
-	evsel_attr_member_def(wakeup_events, T_UINT, "attribute wakeup_events."),
-	{ .name = NULL, },
+static int pyrf_evsel__set_tracking(PyObject *self, PyObject *val, void */*closure*/)
+{
+	struct pyrf_evsel *pevsel = (void *)self;
+
+	pevsel->evsel->tracking = Py_IsTrue(val) ? true : false;
+	return 0;
+}
+
+static int pyrf_evsel__set_attr_config(PyObject *self, PyObject *val, void */*closure*/)
+{
+	struct pyrf_evsel *pevsel = (void *)self;
+
+	pevsel->evsel->core.attr.config = PyLong_AsUnsignedLongLong(val);
+	return PyErr_Occurred() ? -1 : 0;
+}
+
+static PyObject *pyrf_evsel__get_attr_config(PyObject *self, void */*closure*/)
+{
+	struct pyrf_evsel *pevsel = (void *)self;
+
+	return PyLong_FromUnsignedLongLong(pevsel->evsel->core.attr.config);
+}
+
+static int pyrf_evsel__set_attr_read_format(PyObject *self, PyObject *val, void */*closure*/)
+{
+	struct pyrf_evsel *pevsel = (void *)self;
+
+	pevsel->evsel->core.attr.read_format = PyLong_AsUnsignedLongLong(val);
+	return PyErr_Occurred() ? -1 : 0;
+}
+
+static PyObject *pyrf_evsel__get_attr_read_format(PyObject *self, void */*closure*/)
+{
+	struct pyrf_evsel *pevsel = (void *)self;
+
+	return PyLong_FromUnsignedLongLong(pevsel->evsel->core.attr.read_format);
+}
+
+static int pyrf_evsel__set_attr_sample_period(PyObject *self, PyObject *val, void */*closure*/)
+{
+	struct pyrf_evsel *pevsel = (void *)self;
+
+	pevsel->evsel->core.attr.sample_period = PyLong_AsUnsignedLongLong(val);
+	return PyErr_Occurred() ? -1 : 0;
+}
+
+static PyObject *pyrf_evsel__get_attr_sample_period(PyObject *self, void */*closure*/)
+{
+	struct pyrf_evsel *pevsel = (void *)self;
+
+	return PyLong_FromUnsignedLongLong(pevsel->evsel->core.attr.sample_period);
+}
+
+static int pyrf_evsel__set_attr_sample_type(PyObject *self, PyObject *val, void */*closure*/)
+{
+	struct pyrf_evsel *pevsel = (void *)self;
+
+	pevsel->evsel->core.attr.sample_type = PyLong_AsUnsignedLongLong(val);
+	return PyErr_Occurred() ? -1 : 0;
+}
+
+static PyObject *pyrf_evsel__get_attr_sample_type(PyObject *self, void */*closure*/)
+{
+	struct pyrf_evsel *pevsel = (void *)self;
+
+	return PyLong_FromUnsignedLongLong(pevsel->evsel->core.attr.sample_type);
+}
+
+static PyObject *pyrf_evsel__get_attr_size(PyObject *self, void */*closure*/)
+{
+	struct pyrf_evsel *pevsel = (void *)self;
+
+	return PyLong_FromUnsignedLong(pevsel->evsel->core.attr.size);
+}
+
+static int pyrf_evsel__set_attr_type(PyObject *self, PyObject *val, void */*closure*/)
+{
+	struct pyrf_evsel *pevsel = (void *)self;
+
+	pevsel->evsel->core.attr.type = PyLong_AsUnsignedLong(val);
+	return PyErr_Occurred() ? -1 : 0;
+}
+
+static PyObject *pyrf_evsel__get_attr_type(PyObject *self, void */*closure*/)
+{
+	struct pyrf_evsel *pevsel = (void *)self;
+
+	return PyLong_FromUnsignedLong(pevsel->evsel->core.attr.type);
+}
+
+static int pyrf_evsel__set_attr_wakeup_events(PyObject *self, PyObject *val, void */*closure*/)
+{
+	struct pyrf_evsel *pevsel = (void *)self;
+
+	pevsel->evsel->core.attr.wakeup_events = PyLong_AsUnsignedLong(val);
+	return PyErr_Occurred() ? -1 : 0;
+}
+
+static PyObject *pyrf_evsel__get_attr_wakeup_events(PyObject *self, void */*closure*/)
+{
+	struct pyrf_evsel *pevsel = (void *)self;
+
+	return PyLong_FromUnsignedLong(pevsel->evsel->core.attr.wakeup_events);
+}
+
+static PyGetSetDef pyrf_evsel__getset[] = {
+	{
+		.name = "tracking",
+		.get = pyrf_evsel__get_tracking,
+		.set = pyrf_evsel__set_tracking,
+		.doc = "tracking event.",
+	},
+	{
+		.name = "config",
+		.get = pyrf_evsel__get_attr_config,
+		.set = pyrf_evsel__set_attr_config,
+		.doc = "attribute config.",
+	},
+	{
+		.name = "read_format",
+		.get = pyrf_evsel__get_attr_read_format,
+		.set = pyrf_evsel__set_attr_read_format,
+		.doc = "attribute read_format.",
+	},
+	{
+		.name = "sample_period",
+		.get = pyrf_evsel__get_attr_sample_period,
+		.set = pyrf_evsel__set_attr_sample_period,
+		.doc = "attribute sample_period.",
+	},
+	{
+		.name = "sample_type",
+		.get = pyrf_evsel__get_attr_sample_type,
+		.set = pyrf_evsel__set_attr_sample_type,
+		.doc = "attribute sample_type.",
+	},
+	{
+		.name = "size",
+		.get = pyrf_evsel__get_attr_size,
+		.doc = "attribute size.",
+	},
+	{
+		.name = "type",
+		.get = pyrf_evsel__get_attr_type,
+		.set = pyrf_evsel__set_attr_type,
+		.doc = "attribute type.",
+	},
+	{
+		.name = "wakeup_events",
+		.get = pyrf_evsel__get_attr_wakeup_events,
+		.set = pyrf_evsel__set_attr_wakeup_events,
+		.doc = "attribute wakeup_events.",
+	},
+	{ .name = NULL},
 };
 
 static const char pyrf_evsel__doc[] = PyDoc_STR("perf event selector list object.");
@@ -1257,7 +1402,7 @@ static PyTypeObject pyrf_evsel__type = {
 	.tp_dealloc	= (destructor)pyrf_evsel__delete,
 	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
 	.tp_doc		= pyrf_evsel__doc,
-	.tp_members	= pyrf_evsel__members,
+	.tp_getset	= pyrf_evsel__getset,
 	.tp_methods	= pyrf_evsel__methods,
 	.tp_init	= (initproc)pyrf_evsel__init,
 	.tp_str         = pyrf_evsel__str,
@@ -1539,7 +1684,7 @@ static PyObject *pyrf_evlist__add(struct pyrf_evlist *pevlist,
 		return NULL;
 
 	Py_INCREF(pevsel);
-	evsel = &((struct pyrf_evsel *)pevsel)->evsel;
+	evsel = ((struct pyrf_evsel *)pevsel)->evsel;
 	evsel->core.idx = evlist->core.nr_entries;
 	evlist__add(evlist, evsel);
 
@@ -1776,12 +1921,7 @@ static PyObject *pyrf_evsel__from_evsel(struct evsel *evsel)
 	if (!pevsel)
 		return NULL;
 
-	memset(&pevsel->evsel, 0, sizeof(pevsel->evsel));
-	evsel__init(&pevsel->evsel, &evsel->core.attr, evsel->core.idx);
-
-	evsel__clone(&pevsel->evsel, evsel);
-	if (evsel__is_group_leader(evsel))
-		evsel__set_leader(&pevsel->evsel, &pevsel->evsel);
+	pevsel->evsel = evsel__get(evsel);
 	return (PyObject *)pevsel;
 }
 
@@ -2188,7 +2328,7 @@ static int pyrf_session_tool__sample(const struct perf_tool *tool,
 	if (pyevent == NULL)
 		return -ENOMEM;
 
-	pevent->evsel = evsel;
+	pevent->evsel = evsel__get(evsel);
 	memcpy(&pevent->sample, sample, sizeof(struct perf_sample));
 
 	PyObject_CallFunction(psession->sample, "O", pyevent);
-- 
2.51.1.851.g4ebd6896fd-goog

