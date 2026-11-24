Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795559499;
	b=yDOsEYhpO8QaHeOOSPrVXdtGq3yvViacOCvtocPwg7CpVvY+wObcHqi8j/m8/Q5vRIUh
	 ouUYqfzLGODLogYnvyxhu8lpDH8Kx8foGwlYUnueU9ylHJhnKMkpksBieIlUJ6w96XJV4
	 fbVpTSzJ8/SUuPxosnYMLuyvv8uff2MSp/3kz0KSuoZy+kfgFTOoD3eQU0sPZQn1Q6UmC
	 gUfmCUyVmFuL1AuokJUdC6P4kuFYNDSDCIPnzOWxhsP0QNFFizAmyQ3eBKAZnnrAlGFwI
	 pku1LJvpVjadFDiFEZ47/1uKJyv9eWkeZirNA8iJ6Iz9pCC0OnM3GEY7BekuKKUO8zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795559499;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=RsmvyqoxjJQi3Q1huECeOWqRkhasm5OYuNo6XKF5asA=;
	b=OOlAvcsdZsYo2/eoLxh+QAveKBVBvYWYE/nhC3r4SB7dTRk5xOoU7/XcfgtT43TqG2iw
	 p3v2ajRhR7qYYyXBrwD6UxRsmIKg5HpbSEvAPofNufAcm9HE65xIEtAL4CHcq7JaJOu1j
	 IeQ5tjoY3CA3xmc3grnhGBX/7XDaqJPpX5jMvYyZ5CT7vtt6Xb/gpsbp5gCQaq/7EeSam
	 iaNp4BCOqmQjIF9uqHih9ERyHpIDg+RutSqnYaYsBJ+XhLMZZSv6mA3flJqVts2UQ/2/E
	 uWLQsMCpFIBY9WP45nkCIMHk9pvJci54568UZeIOM+tWfOGfA1HsaydFBGC0G4Uv13g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HMpVIkHw;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6831E606A68F
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 22:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6831E606A68F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HMpVIkHw
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-14373747468so4924952c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 14:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795559498; x=1796164298; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RsmvyqoxjJQi3Q1huECeOWqRkhasm5OYuNo6XKF5asA=;
        b=HMpVIkHwN0t9yFfafEGJxSZtu3GeqfzAWne/Hb1j6FH3ZJROoq8L6m0pjGIVi1C8xf
         v4dNaPagaCH3mHkDkpgKvVbC8BNlbPXHuHDGWfDKv9MqkSL4E4Tjr6MYy3XFscxnm3HV
         vi8j597eYddQJ5xFnz6MFCMZFSVdEy/dvTP3JT7q4GNYvjE5de7mUutEKIr57yy9C+qc
         O08QgiJ8ymcWpYgsz6gV4rLnJcB9LVZnfosodbImNbozvkI187eUpKz7X3AxEEPHLjLn
         qwxQpKnqShbs18YRwjn7qLZhq5IEVqvO8FbH3H4tjOhVxHS3AtNNuxg+KhcXKUEZWxac
         su+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795559498; x=1796164298;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RsmvyqoxjJQi3Q1huECeOWqRkhasm5OYuNo6XKF5asA=;
        b=cAW4CEwKuaeDivkmxfQA3EScxHptFGDir/1FDfSFSmNgvuqwCfSmo98MoPGs/FmShT
         VWCYPXstvdJGWIDWQGHwa5ToM1+Fm85elngUGHju1RGIPSshblx8qWU6zuGIPVA2bDLL
         aUZV13Ywcy8FRgftQyUNR/w54Gi8wjMSiaED/5eB0qIwFwC6mDqB4wuE4fEwjvYJBRb2
         zAHuhtvbbjD5MkwdpxPwIhCcGyufNevvtE8iituuXjDI5BXxXIpRl/VgLVxqghxKGYOu
         eI/CvILUDRpFj9C9w+lBLfpJmGMY2oH82NCUmRpDRjZrYB9aTIKcCCu0z7HXW5qETusn
         oXNg==
X-Forwarded-Encrypted: i=1; AL+hErEkPHzUxRrG/nJa65ViTC7XK0kKLOn5S1Io2TF9rLsLuUOOwIhgU9MjfWvnQGJ6T4Y7ZaZNl145ltL3r88pkzuh@vger.kernel.org
X-Gm-Message-State: APuU4Z9MGjdW0SKGE7tNQSWGX5G4fLM4bqZiwvUBWY/VlNjayCx+tid7
	zvanmeLpQXKNiChn1rqnoUaJxm79tzfQ5d5GD0ckHnZT7mO8XCPhEftBbmsyIQE/25kTAHSha4W
	dujzXKgE/jg==
X-Received: from dlea6-n2.prod.google.com ([2002:a05:701b:4206:20b0:15f:5ef4:b896])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:45a7:b0:1b5:4eec:14e5
 with SMTP id a92af1059eb24-1b55687f18fmr22474342c88.6.1795559497649; Tue, 24
 Nov 2026 14:31:37 -0800 (PST)
Date: Tue, 24 Nov 2026 14:31:09 -0800
In-Reply-To: <20261124223109.820609-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261124223109.820609-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261124223109.820609-13-irogers@google.com>
Subject: [PATCH v10 12/12] perf test symbols: Add session allocation wrapper
 and lock contention tests
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alireza Haghdoost <haghdoost@uber.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add test_session_alloc_shrink() to tools/perf/tests/symbols.c verifying:
- machine__session() and dso__session() back-pointer resolution.
- perf_session__malloc(), zalloc(), calloc(), realloc(), and strdup()
  allocation wrappers and perf_session__shrink() eviction.
- Multithreaded contention between dso__find_binary_type()
  (dso__data_open_lock -> dso__lock(dso)) and perf_session__shrink() under
  dso__lock(dso), plus perf_session__e_machine() shard iteration.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/symbols.c | 162 +++++++++++++++++++++++++++++++++++++
 1 file changed, 162 insertions(+)

diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
index 66756d988a5d..48d89cea88bf 100644
--- a/tools/perf/tests/symbols.c
+++ b/tools/perf/tests/symbols.c
@@ -8,6 +8,8 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <limits.h>
+#include <pthread.h>
+#include <stdatomic.h>
 #include <stdbool.h>
 #include <stddef.h>
 #include <stdio.h>
@@ -19,6 +21,7 @@
 #include "dso.h"
 #include "env.h"
 #include "machine.h"
+#include "session.h"
 #include "srcline.h"
 #include "thread.h"
 #include "symbol.h"
@@ -320,6 +323,161 @@ static int test_dsos_shrink(void)
 	return ret;
 }
 
+struct shrink_lock_race_args {
+	struct dso *dso;
+	atomic_bool stop;
+};
+
+static void *shrink_lock_race_worker(void *arg)
+{
+	struct shrink_lock_race_args *args = arg;
+
+	while (!atomic_load_explicit(&args->stop, memory_order_relaxed))
+		dso__find_binary_type(args->dso);
+
+	return NULL;
+}
+
+static int test_session_alloc_shrink(void)
+{
+	struct perf_session *session = zalloc(sizeof(*session));
+	struct dso *dso;
+	struct thread *th;
+	pid_t pid = getpid();
+	char *p1 = NULL, *p2 = NULL, *p3 = NULL, *s = NULL, *tmp;
+	int ret = TEST_FAIL;
+
+	if (!session)
+		return TEST_FAIL;
+
+	perf_env__init(&session->header.env);
+	if (machines__init(&session->machines, session))
+		goto out;
+	session->machines.host.env = &session->header.env;
+	if (machine__session(&session->machines.host) != session) {
+		pr_debug("machine__session did not return owning session!\n");
+		goto out;
+	}
+
+	dso = machine__findnew_dso(&session->machines.host, "/tmp/perf_test_session_dso");
+	if (!dso)
+		goto out;
+	if (dso__session(dso) != session) {
+		pr_debug("dso__session did not return owning session!\n");
+		dso__put(dso);
+		goto out;
+	}
+	dso__put(dso);
+
+	p1 = perf_session__malloc(session, 64);
+	p2 = perf_session__zalloc(session, 64);
+	p3 = perf_session__calloc(session, 4, 16);
+	s = perf_session__strdup(session, "perf_session_alloc_test");
+	if (!p1 || !p2 || !p3 || !s || strcmp(s, "perf_session_alloc_test") != 0) {
+		pr_debug("perf_session allocation wrappers failed!\n");
+		goto out;
+	}
+
+	tmp = perf_session__realloc(session, p1, 128);
+	if (!tmp) {
+		pr_debug("perf_session__realloc failed!\n");
+		goto out;
+	}
+	p1 = tmp;
+
+	if (perf_session__shrink(session) == 0) {
+		pr_debug("perf_session__shrink failed to evict unreferenced DSO!\n");
+		goto out;
+	}
+	down_read(&session->machines.host.dsos.lock);
+	if (session->machines.host.dsos.cnt != 0) {
+		up_read(&session->machines.host.dsos.lock);
+		pr_debug("perf_session__shrink failed to evict unreferenced DSO!\n");
+		goto out;
+	}
+	up_read(&session->machines.host.dsos.lock);
+
+	/*
+	 * Regression test for AB-BA lock inversion between dso__lock(dso_A)
+	 * (held by dso__load() when calling perf_session__shrink() to evict
+	 * unreferenced dso_B) and dso__data_open_lock (acquired before
+	 * dso__lock(dso_A) by dso__find_binary_type()).
+	 */
+	dso = machine__findnew_dso(&session->machines.host, "/tmp/perf_test_contended_dso");
+	if (!dso)
+		goto out;
+	{
+		bool was_singlethreaded = perf_singlethreaded;
+		struct shrink_lock_race_args race_args = {
+			.dso = dso,
+			.stop = false,
+		};
+		pthread_t worker;
+
+		perf_set_multithreaded();
+		if (pthread_create(&worker, NULL, shrink_lock_race_worker, &race_args) != 0) {
+			if (was_singlethreaded)
+				perf_set_singlethreaded();
+			dso__put(dso);
+			goto out;
+		}
+		for (int i = 0; i < 200; i++) {
+			struct dso *evict = machine__findnew_dso(&session->machines.host,
+								 "/tmp/perf_test_evict_dso");
+
+			dso__put(evict);
+			mutex_lock(dso__lock(dso));
+			RC_CHK_ACCESS(dso)->bintype_searched = 0;
+			perf_session__shrink(session);
+			mutex_unlock(dso__lock(dso));
+		}
+		atomic_store_explicit(&race_args.stop, true, memory_order_relaxed);
+		pthread_join(worker, NULL);
+		if (was_singlethreaded)
+			perf_set_singlethreaded();
+	}
+	dso__put(dso);
+	perf_session__shrink(session);
+
+	/*
+	 * Verify perf_session__e_machine() -> threads__for_each_thread() does
+	 * not self-deadlock on table->lock when a non-leader thread looks up or
+	 * creates its leader thread in the same shard.
+	 */
+	{
+		bool was_singlethreaded = perf_singlethreaded;
+		uint16_t e_machine;
+
+		perf_set_multithreaded();
+		th = machine__findnew_thread(&session->machines.host, pid,
+					     pid + THREADS__TABLE_SIZE);
+		if (!th) {
+			if (was_singlethreaded)
+				perf_set_singlethreaded();
+			goto out;
+		}
+		thread__put(th);
+		e_machine = perf_session__e_machine(session, NULL);
+		if (was_singlethreaded)
+			perf_set_singlethreaded();
+		if (e_machine == EM_NONE) {
+			pr_debug("perf_session__e_machine failed!\n");
+			goto out;
+		}
+	}
+
+	ret = TEST_OK;
+out:
+	free(p1);
+	free(p2);
+	free(p3);
+	free(s);
+	machines__exit(&session->machines);
+	perf_env__exit(&session->header.env);
+	free(session);
+	return ret;
+}
+
 struct shrink_reload_find_args {
 	struct symbol *kept;
 	u64 first_start;
@@ -822,6 +980,10 @@ static int test__symbols(struct test_suite *test __maybe_unused, int subtest __m
 	if (ret != TEST_OK)
 		return ret;
 
+	ret = test_session_alloc_shrink();
+	if (ret != TEST_OK)
+		return ret;
+
 	ret = init_test_info(&ti);
 	if (ret != TEST_OK)
 		return ret;
-- 
2.56.1.831.g720f3f5937-goog

