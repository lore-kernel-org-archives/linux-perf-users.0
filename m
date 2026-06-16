Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68058373BF2
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781572566; cv=none; b=h4lX4UHUeMTB1K/TQjHKEieTf5okkwyMpXAil+rc3WyoecT/J4O4oskRrfO2bYIJDJyNu1FPKyK5iWNjDQPV9MINmTflidEq3AeiFlI0L5ZWWACGZSA10Enmsgbd2FKKoR4JBDxfzIsSCedUY/SI1DmfqZS5HiftwP4q+lUgmjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781572566; c=relaxed/simple;
	bh=D4A55K05qM1N58tSx/a6bxtXy2QyjQYt+iy7ZnZJlN0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QCim1TFgdQ/R/HU7usdyrSPw+D0NUeejppXRoykMpqrZXDw5USsJrWl2K3akAB0AmUQxtDjcFySuVoAWGamftpfa+JxZAzUt75GqjNQRpGVNicGwcXdjK4+CHSTv4j7tw2aBD3hzBcRAHVCj6JXb5dgllSgofLnYvZ0i9NkVXng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S7vR6oA7; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S7vR6oA7"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-139553dd8acso4698612c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 18:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781572564; x=1782177364; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1o+mO8fTPBJl3rGVTyoPTR9w2vm8LdDfWMVkqkDv++I=;
        b=S7vR6oA7UOpySjRfwoR2qkhP5GLJgp0pibZkjCVhRs4Y4zBfi47eX7KU+8qfIfP6nd
         aMUxm5lUMdz6AyU/mntDO1g3qXOsI7YlI/G0rIzg6lGunvxZgMNiGHElg8CrGaqhMUmZ
         ybDopdElVMB2/zU5c5SdXrZLV4xMQfl81WwcL5KxZGfDXzje8t9DNMN0OcRnn4SO6AMu
         hHIzOHiiLM954s0zl/znqHILmqSnfGvMhix48Xaiq/lxF22MPpvs8EXtpvjgMFvMcjSE
         1HCvvsl5lio8lrvH/Rs7vWXQZqmUTkv4KrmIB0qhQQKue+e0t2jJbZZv+m1eUQ129zqX
         vD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781572564; x=1782177364;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1o+mO8fTPBJl3rGVTyoPTR9w2vm8LdDfWMVkqkDv++I=;
        b=BakygDf9zlzzCKOeuzj8T/J85w8h9lus21eoZUHmTO+WBxuEVGiQGayoYinjj2hGTd
         GHgtv8TWRUeU05yCDwVTo/bTEqxufZbPb8SHATZC7gxVWOP9zb28giY/6QnxLQpoKy4B
         Sbn6h87LWmWStfnmjPbACKjQFijrh7NaORXu6PkFcKuOo2XG8gmSTadlQRM3eOaAdPq8
         x5OK/0fZM6StuTdsM0T+xSLqr8Ukm6ceDF6YbTUriiKiBVy/NwgVOf/SLm7pR3pgDK2y
         56qnwE0YqY7svw7E0we1ViFUkus8bbc8XVt1bRctK0JdvtfgYLeRJ6fUeO/sCXpqPDyM
         2djg==
X-Forwarded-Encrypted: i=1; AFNElJ8U0/p7ResXkunAeAObtYoHnF8nTte62JT4J6d5YSypf2O7cW3H0ZQc2c491HZAJ16Vxi5NtVL3ktk9ZhLIYYP/@vger.kernel.org
X-Gm-Message-State: AOJu0YwOuu7JT15mdd/ZNTO2sL4JxT65gzIWgGeJIAl0j+EgZsz/qpv8
	D8XaHphfFC3LBg39Ef/jj5djCAmlrg8LDWls1Rb2BEf35qktTEtKbWBpO+fUr/PFujIv77biOgI
	Qe7IASXYzzA==
X-Received: from dled13-n2.prod.google.com ([2002:a05:701b:42cd:20b0:138:14f4:c975])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e98f:b0:138:4023:8b6
 with SMTP id a92af1059eb24-13985ea8962mr729847c88.10.1781572563213; Mon, 15
 Jun 2026 18:16:03 -0700 (PDT)
Date: Mon, 15 Jun 2026 18:15:28 -0700
In-Reply-To: <20260616011543.4037138-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615223011.3873955-1-irogers@google.com> <20260616011543.4037138-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616011543.4037138-7-irogers@google.com>
Subject: [PATCH v21 06/21] perf evsel: Add reference count
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
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
 tools/perf/util/evsel.c                    |  26 +-
 tools/perf/util/evsel.h                    |  11 +-
 tools/perf/util/parse-events.y             |   2 +-
 tools/perf/util/pfm.c                      |   2 +-
 tools/perf/util/print-events.c             |   2 +-
 tools/perf/util/python.c                   | 325 +++++++++++++++++----
 tools/perf/util/session.c                  |   3 +
 14 files changed, 321 insertions(+), 84 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index ae1977082749..cbe25b96b8fb 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -460,10 +460,10 @@ static int evsel__init_tp_ptr_field(struct evsel *evsel, struct tp_field *field,
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
@@ -543,7 +543,7 @@ static struct evsel *perf_evsel__raw_syscall_newtp(const char *direction, void *
 	return evsel;
 
 out_delete:
-	evsel__delete_priv(evsel);
+	evsel__put_and_free_priv(evsel);
 	return NULL;
 }
 
@@ -3612,7 +3612,7 @@ static bool evlist__add_vfs_getname(struct evlist *evlist)
 
 		list_del_init(&evsel->core.node);
 		evsel->evlist = NULL;
-		evsel__delete(evsel);
+		evsel__put(evsel);
 	}
 
 	return found;
@@ -3728,9 +3728,9 @@ static int trace__add_syscall_newtp(struct trace *trace)
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
index 0be43f8db3bd..cc63df2b3bc5 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -59,7 +59,7 @@ static int test__openat_syscall_event_on_all_cpus(struct test_suite *test __mayb
 			 "tweak /proc/sys/kernel/perf_event_paranoid?\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
 		err = TEST_SKIP;
-		goto out_evsel_delete;
+		goto out_evsel_put;
 	}
 
 	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
@@ -116,8 +116,8 @@ static int test__openat_syscall_event_on_all_cpus(struct test_suite *test __mayb
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
index e1ce5aa3b957..6842c9f6d71e 100644
--- a/tools/perf/util/bpf_counter_cgroup.c
+++ b/tools/perf/util/bpf_counter_cgroup.c
@@ -336,7 +336,7 @@ static int bperf_cgrp__destroy(struct evsel *evsel)
 		return 0;
 
 	bperf_cgroup_bpf__destroy(skel);
-	evsel__delete(cgrp_switch);  // it'll destroy on_switch progs too
+	evsel__put(cgrp_switch);  // it'll destroy on_switch progs too
 
 	return 0;
 }
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 652a45aac828..914744724467 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -469,7 +469,7 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str, bool open_cgro
 
 		/* copy the list and set to the new cgroup. */
 		evlist__for_each_entry(orig_list, pos) {
-			struct evsel *evsel = evsel__clone(/*dest=*/NULL, pos);
+			struct evsel *evsel = evsel__clone(pos);
 
 			if (evsel == NULL)
 				goto out_err;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 82cc33259d81..1721a2470fb6 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -194,7 +194,7 @@ static void evlist__purge(struct evlist *evlist)
 	evlist__for_each_entry_safe(evlist, n, pos) {
 		list_del_init(&pos->core.node);
 		pos->evlist = NULL;
-		evsel__delete(pos);
+		evsel__put(pos);
 	}
 
 	evlist->core.nr_entries = 0;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 19e48b9260e9..f5a9ecf87c21 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -393,10 +393,11 @@ bool evsel__is_function_event(struct evsel *evsel)
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
@@ -477,7 +478,7 @@ static int evsel__copy_config_terms(struct evsel *dst, struct evsel *src)
  * The assumption is that @orig is not configured nor opened yet.
  * So we only care about the attributes that can be set while it's parsed.
  */
-struct evsel *evsel__clone(struct evsel *dest, struct evsel *orig)
+struct evsel *evsel__clone(struct evsel *orig)
 {
 	struct evsel *evsel;
 
@@ -490,11 +491,7 @@ struct evsel *evsel__clone(struct evsel *dest, struct evsel *orig)
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
 
@@ -579,7 +576,7 @@ struct evsel *evsel__clone(struct evsel *dest, struct evsel *orig)
 	return evsel;
 
 out_err:
-	evsel__delete(evsel);
+	evsel__put(evsel);
 	return NULL;
 }
 
@@ -638,6 +635,12 @@ struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx, bool
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
@@ -1976,7 +1979,7 @@ void evsel__set_priv_destructor(void (*destructor)(void *priv))
 	evsel__priv_destructor = destructor;
 }
 
-void evsel__exit(struct evsel *evsel)
+static void evsel__exit(struct evsel *evsel)
 {
 	assert(list_empty(&evsel->core.node));
 	assert(evsel->evlist == NULL);
@@ -2013,11 +2016,14 @@ void evsel__exit(struct evsel *evsel)
 	}
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
index 6b28cd754a18..3fdb68e75bd1 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -6,6 +6,7 @@
 
 #include <linux/list.h>
 #include <linux/perf_event.h>
+#include <linux/refcount.h>
 #include <linux/types.h>
 #include <sys/types.h>
 
@@ -47,6 +48,7 @@ typedef int (evsel__sb_cb_t)(union perf_event *event, void *data);
 struct evsel {
 	struct perf_evsel	core;
 	struct evlist		*evlist;
+	refcount_t		refcnt;
 	off_t			id_offset;
 	int			id_pos;
 	int			is_pos;
@@ -268,7 +270,7 @@ static inline struct evsel *evsel__new(struct perf_event_attr *attr)
 	return evsel__new_idx(attr, 0);
 }
 
-struct evsel *evsel__clone(struct evsel *dest, struct evsel *orig);
+struct evsel *evsel__clone(struct evsel *orig);
 
 int copy_config_terms(struct list_head *dst, struct list_head *src);
 void free_config_terms(struct list_head *config_terms);
@@ -283,14 +285,13 @@ static inline struct evsel *evsel__newtp(const char *sys, const char *name)
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
index d9043f4afbe7..5f53c2f68a96 100644
--- a/tools/perf/util/pfm.c
+++ b/tools/perf/util/pfm.c
@@ -159,7 +159,7 @@ static bool is_libpfm_event_supported(const char *name, struct perf_cpu_map *cpu
 		result = false;
 
 	evsel__close(evsel);
-	evsel__delete(evsel);
+	evsel__put(evsel);
 
 	return result;
 }
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index cb27e2898aa0..0242243681b6 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -174,7 +174,7 @@ bool is_event_supported(u8 type, u64 config)
 		}
 
 		evsel__close(evsel);
-		evsel__delete(evsel);
+		evsel__put(evsel);
 	}
 
 	perf_thread_map__put(tmap);
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 7483741c024a..5482b68b8c0b 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -294,8 +294,9 @@ static PyMemberDef pyrf_sample_event__members[] = {
 
 static void pyrf_sample_event__delete(struct pyrf_event *pevent)
 {
+	evsel__put(pevent->evsel);
 	perf_sample__exit(&pevent->sample);
-	Py_TYPE(pevent)->tp_free((PyObject*)pevent);
+	Py_TYPE(pevent)->tp_free((PyObject *)pevent);
 }
 
 static PyObject *pyrf_sample_event__repr(const struct pyrf_event *pevent)
@@ -526,8 +527,10 @@ static PyObject *pyrf_event__new(const union perf_event *event)
 
 	ptype = pyrf_event__type[event->header.type];
 	pevent = PyObject_New(struct pyrf_event, ptype);
-	if (pevent != NULL)
+	if (pevent != NULL) {
 		memcpy(&pevent->event, event, event->header.size);
+		pevent->evsel = NULL;
+	}
 	return (PyObject *)pevent;
 }
 
@@ -965,7 +968,7 @@ static int pyrf_counts_values__setup_types(void)
 struct pyrf_evsel {
 	PyObject_HEAD
 
-	struct evsel evsel;
+	struct evsel *evsel;
 };
 
 static int pyrf_evsel__init(struct pyrf_evsel *pevsel,
@@ -1006,6 +1009,7 @@ static int pyrf_evsel__init(struct pyrf_evsel *pevsel,
 		"bp_type",
 		"bp_addr",
 		"bp_len",
+		"idx",
 		 NULL
 	};
 	u64 sample_period = 0;
@@ -1027,11 +1031,11 @@ static int pyrf_evsel__init(struct pyrf_evsel *pevsel,
 	    watermark = 0,
 	    precise_ip = 0,
 	    mmap_data = 0,
-	    sample_id_all = 1;
-	int idx = 0;
+	    sample_id_all = 1,
+	    idx = 0;
 
 	if (!PyArg_ParseTupleAndKeywords(args, kwargs,
-					 "|iKiKKiiiiiiiiiiiiiiiiiiiiiiKK", kwlist,
+					 "|iKiKKiiiiiiiiiiiiiiiiiiiiiiKKi", kwlist,
 					 &attr.type, &attr.config, &attr.sample_freq,
 					 &sample_period, &attr.sample_type,
 					 &attr.read_format, &disabled, &inherit,
@@ -1073,26 +1077,33 @@ static int pyrf_evsel__init(struct pyrf_evsel *pevsel,
 	attr.sample_id_all  = sample_id_all;
 	attr.size	    = sizeof(attr);
 
-	evsel__init(&pevsel->evsel, &attr, idx);
+	evsel__put(pevsel->evsel);
+	pevsel->evsel = evsel__new(&attr);
+	if (!pevsel->evsel) {
+		PyErr_NoMemory();
+		return -1;
+	}
 	return 0;
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
 	int group = 0, inherit = 0;
 	static char *kwlist[] = { "cpus", "threads", "group", "inherit", NULL };
 
+	CHECK_INITIALIZED(evsel, "evsel");
+
 	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|OOii", kwlist,
 					 &pcpus, &pthreads, &group, &inherit))
 		return NULL;
@@ -1119,21 +1130,26 @@ static PyObject *pyrf_evsel__open(struct pyrf_evsel *pevsel,
 
 static PyObject *pyrf_evsel__cpus(struct pyrf_evsel *pevsel)
 {
-	struct pyrf_cpu_map *pcpu_map = PyObject_New(struct pyrf_cpu_map, &pyrf_cpu_map__type);
+	struct pyrf_cpu_map *pcpu_map;
 
+	CHECK_INITIALIZED(pevsel->evsel, "evsel");
+
+	pcpu_map = PyObject_New(struct pyrf_cpu_map, &pyrf_cpu_map__type);
 	if (pcpu_map)
-		pcpu_map->cpus = perf_cpu_map__get(pevsel->evsel.core.cpus);
+		pcpu_map->cpus = perf_cpu_map__get(pevsel->evsel->core.cpus);
 
 	return (PyObject *)pcpu_map;
 }
 
 static PyObject *pyrf_evsel__threads(struct pyrf_evsel *pevsel)
 {
-	struct pyrf_thread_map *pthread_map =
-		PyObject_New(struct pyrf_thread_map, &pyrf_thread_map__type);
+	struct pyrf_thread_map *pthread_map;
+
+	CHECK_INITIALIZED(pevsel->evsel, "evsel");
 
+	pthread_map = PyObject_New(struct pyrf_thread_map, &pyrf_thread_map__type);
 	if (pthread_map)
-		pthread_map->threads = perf_thread_map__get(pevsel->evsel.core.threads);
+		pthread_map->threads = perf_thread_map__get(pevsel->evsel->core.threads);
 
 	return (PyObject *)pthread_map;
 }
@@ -1167,12 +1183,15 @@ static int evsel__ensure_counts(struct evsel *evsel)
 static PyObject *pyrf_evsel__read(struct pyrf_evsel *pevsel,
 				  PyObject *args, PyObject *kwargs)
 {
-	struct evsel *evsel = &pevsel->evsel;
+	struct evsel *evsel = pevsel->evsel;
 	int cpu = 0, cpu_idx, thread = 0, thread_idx;
 	struct perf_counts_values *old_count, *new_count;
-	struct pyrf_counts_values *count_values = PyObject_New(struct pyrf_counts_values,
-							       &pyrf_counts_values__type);
+	struct pyrf_counts_values *count_values;
+
+	CHECK_INITIALIZED(evsel, "evsel");
 
+	count_values = PyObject_New(struct pyrf_counts_values,
+							       &pyrf_counts_values__type);
 	if (!count_values)
 		return NULL;
 
@@ -1212,7 +1231,10 @@ static PyObject *pyrf_evsel__read(struct pyrf_evsel *pevsel,
 static PyObject *pyrf_evsel__str(PyObject *self)
 {
 	struct pyrf_evsel *pevsel = (void *)self;
-	struct evsel *evsel = &pevsel->evsel;
+	struct evsel *evsel = pevsel->evsel;
+
+	if (!evsel)
+		return PyUnicode_FromString("evsel(uninitialized)");
 
 	return PyUnicode_FromFormat("evsel(%s/%s/)", evsel__pmu_name(evsel), evsel__name(evsel));
 }
@@ -1245,30 +1267,227 @@ static PyMethodDef pyrf_evsel__methods[] = {
 	{ .ml_name = NULL, }
 };
 
-#define evsel_member_def(member, ptype, help) \
-	{ #member, ptype, \
-	  offsetof(struct pyrf_evsel, evsel.member), \
-	  0, help }
+static PyObject *pyrf_evsel__get_tracking(PyObject *self, void *closure __maybe_unused)
+{
+	struct pyrf_evsel *pevsel = (void *)self;
 
-#define evsel_attr_member_def(member, ptype, help) \
-	{ #member, ptype, \
-	  offsetof(struct pyrf_evsel, evsel.core.attr.member), \
-	  0, help }
+	CHECK_INITIALIZED(pevsel->evsel, "evsel");
 
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
+	if (pevsel->evsel->tracking)
+		Py_RETURN_TRUE;
+	else
+		Py_RETURN_FALSE;
+}
+
+static int pyrf_evsel__set_tracking(PyObject *self, PyObject *val, void *closure __maybe_unused)
+{
+	struct pyrf_evsel *pevsel = (void *)self;
+	int is_true;
+
+	CHECK_INITIALIZED_INT(pevsel->evsel, "evsel");
+
+	is_true = PyObject_IsTrue(val);
+	if (is_true < 0)
+		return -1;
+
+	pevsel->evsel->tracking = is_true;
+	return 0;
+}
+
+static int pyrf_evsel__set_attr_config(PyObject *self, PyObject *val, void *closure __maybe_unused)
+{
+	struct pyrf_evsel *pevsel = (void *)self;
+
+	CHECK_INITIALIZED_INT(pevsel->evsel, "evsel");
+
+	pevsel->evsel->core.attr.config = PyLong_AsUnsignedLongLong(val);
+	return PyErr_Occurred() ? -1 : 0;
+}
+
+static PyObject *pyrf_evsel__get_attr_config(PyObject *self, void *closure __maybe_unused)
+{
+	struct pyrf_evsel *pevsel = (void *)self;
+
+	CHECK_INITIALIZED(pevsel->evsel, "evsel");
+
+	return PyLong_FromUnsignedLongLong(pevsel->evsel->core.attr.config);
+}
+
+static int pyrf_evsel__set_attr_read_format(PyObject *self, PyObject *val, void *closure __maybe_unused)
+{
+	struct pyrf_evsel *pevsel = (void *)self;
+
+	CHECK_INITIALIZED_INT(pevsel->evsel, "evsel");
+
+	pevsel->evsel->core.attr.read_format = PyLong_AsUnsignedLongLong(val);
+	return PyErr_Occurred() ? -1 : 0;
+}
+
+static PyObject *pyrf_evsel__get_attr_read_format(PyObject *self, void *closure __maybe_unused)
+{
+	struct pyrf_evsel *pevsel = (void *)self;
+
+	CHECK_INITIALIZED(pevsel->evsel, "evsel");
+
+	return PyLong_FromUnsignedLongLong(pevsel->evsel->core.attr.read_format);
+}
+
+static int pyrf_evsel__set_attr_sample_period(PyObject *self, PyObject *val, void *closure __maybe_unused)
+{
+	struct pyrf_evsel *pevsel = (void *)self;
+
+	CHECK_INITIALIZED_INT(pevsel->evsel, "evsel");
+
+	pevsel->evsel->core.attr.sample_period = PyLong_AsUnsignedLongLong(val);
+	return PyErr_Occurred() ? -1 : 0;
+}
+
+static PyObject *pyrf_evsel__get_attr_sample_period(PyObject *self, void *closure __maybe_unused)
+{
+	struct pyrf_evsel *pevsel = (void *)self;
+
+	CHECK_INITIALIZED(pevsel->evsel, "evsel");
+
+	return PyLong_FromUnsignedLongLong(pevsel->evsel->core.attr.sample_period);
+}
+
+static int pyrf_evsel__set_attr_sample_type(PyObject *self, PyObject *val, void *closure __maybe_unused)
+{
+	struct pyrf_evsel *pevsel = (void *)self;
+
+	CHECK_INITIALIZED_INT(pevsel->evsel, "evsel");
+
+	pevsel->evsel->core.attr.sample_type = PyLong_AsUnsignedLongLong(val);
+	return PyErr_Occurred() ? -1 : 0;
+}
+
+static PyObject *pyrf_evsel__get_attr_sample_type(PyObject *self, void *closure __maybe_unused)
+{
+	struct pyrf_evsel *pevsel = (void *)self;
+
+	CHECK_INITIALIZED(pevsel->evsel, "evsel");
+
+	return PyLong_FromUnsignedLongLong(pevsel->evsel->core.attr.sample_type);
+}
+
+static PyObject *pyrf_evsel__get_attr_size(PyObject *self, void *closure __maybe_unused)
+{
+	struct pyrf_evsel *pevsel = (void *)self;
+
+	CHECK_INITIALIZED(pevsel->evsel, "evsel");
+
+	return PyLong_FromUnsignedLong(pevsel->evsel->core.attr.size);
+}
+
+static int pyrf_evsel__set_attr_type(PyObject *self, PyObject *val, void *closure __maybe_unused)
+{
+	struct pyrf_evsel *pevsel = (void *)self;
+
+	CHECK_INITIALIZED_INT(pevsel->evsel, "evsel");
+
+	pevsel->evsel->core.attr.type = PyLong_AsUnsignedLong(val);
+	return PyErr_Occurred() ? -1 : 0;
+}
+
+static PyObject *pyrf_evsel__get_attr_type(PyObject *self, void *closure __maybe_unused)
+{
+	struct pyrf_evsel *pevsel = (void *)self;
+
+	CHECK_INITIALIZED(pevsel->evsel, "evsel");
+
+	return PyLong_FromUnsignedLong(pevsel->evsel->core.attr.type);
+}
+
+static int pyrf_evsel__set_attr_wakeup_events(PyObject *self, PyObject *val, void *closure __maybe_unused)
+{
+	struct pyrf_evsel *pevsel = (void *)self;
+
+	CHECK_INITIALIZED_INT(pevsel->evsel, "evsel");
+
+	pevsel->evsel->core.attr.wakeup_events = PyLong_AsUnsignedLong(val);
+	return PyErr_Occurred() ? -1 : 0;
+}
+
+static PyObject *pyrf_evsel__get_attr_wakeup_events(PyObject *self, void *closure __maybe_unused)
+{
+	struct pyrf_evsel *pevsel = (void *)self;
+
+	CHECK_INITIALIZED(pevsel->evsel, "evsel");
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
 
+static PyObject *pyrf_evsel__getattro(struct pyrf_evsel *pevsel, PyObject *attr_name)
+{
+	if (!pevsel->evsel) {
+		PyErr_SetString(PyExc_ValueError, "evsel not initialized");
+		return NULL;
+	}
+	return PyObject_GenericGetAttr((PyObject *) pevsel, attr_name);
+}
+
+static int pyrf_evsel__setattro(struct pyrf_evsel *pevsel, PyObject *attr_name, PyObject *value)
+{
+	if (!pevsel->evsel) {
+		PyErr_SetString(PyExc_ValueError, "evsel not initialized");
+		return -1;
+	}
+	return PyObject_GenericSetAttr((PyObject *) pevsel, attr_name, value);
+}
+
 static PyTypeObject pyrf_evsel__type = {
 	PyVarObject_HEAD_INIT(NULL, 0)
 	.tp_name	= "perf.evsel",
@@ -1276,16 +1495,28 @@ static PyTypeObject pyrf_evsel__type = {
 	.tp_dealloc	= (destructor)pyrf_evsel__delete,
 	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
 	.tp_doc		= pyrf_evsel__doc,
-	.tp_members	= pyrf_evsel__members,
+	.tp_getset	= pyrf_evsel__getset,
 	.tp_methods	= pyrf_evsel__methods,
 	.tp_init	= (initproc)pyrf_evsel__init,
 	.tp_str         = pyrf_evsel__str,
 	.tp_repr        = pyrf_evsel__str,
+	.tp_getattro	= (getattrofunc) pyrf_evsel__getattro,
+	.tp_setattro	= (setattrofunc) pyrf_evsel__setattro,
 };
 
+static PyObject *pyrf_evsel__new(PyTypeObject *type, PyObject *args, PyObject *kwargs)
+{
+	struct pyrf_evsel *pevsel;
+
+	pevsel = (struct pyrf_evsel *)PyType_GenericNew(type, args, kwargs);
+	if (pevsel)
+		pevsel->evsel = NULL;
+	return (PyObject *)pevsel;
+}
+
 static int pyrf_evsel__setup_types(void)
 {
-	pyrf_evsel__type.tp_new = PyType_GenericNew;
+	pyrf_evsel__type.tp_new = pyrf_evsel__new;
 	return PyType_Ready(&pyrf_evsel__type);
 }
 
@@ -1584,13 +1815,14 @@ static PyObject *pyrf_evlist__add(struct pyrf_evlist *pevlist,
 	PyObject *pevsel;
 	struct evsel *evsel;
 
-	if (!PyArg_ParseTuple(args, "O", &pevsel))
+	if (!PyArg_ParseTuple(args, "O!", &pyrf_evsel__type, &pevsel))
 		return NULL;
 
-	Py_INCREF(pevsel);
-	evsel = &((struct pyrf_evsel *)pevsel)->evsel;
+	CHECK_INITIALIZED(((struct pyrf_evsel *)pevsel)->evsel, "evsel");
+
+	evsel = ((struct pyrf_evsel *)pevsel)->evsel;
 	evsel->core.idx = evlist->core.nr_entries;
-	evlist__add(evlist, evsel);
+	evlist__add(evlist, evsel__get(evsel));
 
 	return Py_BuildValue("i", evlist->core.nr_entries);
 }
@@ -1648,7 +1880,7 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 			return Py_None;
 		}
 
-		pevent->evsel = evsel;
+		pevent->evsel = evsel__get(evsel);
 
 		perf_mmap__consume(&md->core);
 
@@ -1828,12 +2060,7 @@ static PyObject *pyrf_evsel__from_evsel(struct evsel *evsel)
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
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 1bc25d5c2715..479e0844f5e1 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1844,7 +1844,10 @@ static int evlist__deliver_deferred_callchain(struct evlist *evlist,
 		struct evsel *saved_evsel = sample->evsel;
 
 		sample->evsel = evlist__id2evsel(evlist, sample->id);
+		if (sample->evsel)
+			sample->evsel = evsel__get(sample->evsel);
 		ret = tool->callchain_deferred(tool, event, sample, machine);
+		evsel__put(sample->evsel);
 		sample->evsel = saved_evsel;
 		return ret;
 	}
-- 
2.54.0.1136.gdb2ca164c4-goog

