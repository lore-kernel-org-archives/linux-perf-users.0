Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795490998;
	b=2sMqftkZ9Id04mWmgi3UE9/wvYxy75Um4x8L/QUtXEjaxwKiKz60tbZaQjzQFOZ5W6Wl
	 7jqnxDUfL4qPU/3Zo6qr3DEVSoaP8Q4iXZbrDyfvmUyHCyNj/rgItCJaFY3hzY/UKI13Z
	 2wXl/Kq64l6fbGQFqE+tRQHS1uCq4EweC+NQnrgmAAQF6GUw/NkgRvs5VowhYSd5LtMh4
	 pYyASniXoDpzgzdbK8huLnZppm/Bup/RutiHmlPLTp79vqzvkxBkFzrbavSg4X4xj1S3M
	 QP8xpcf7OcZ6RWrasmWZx+pLPc/xvEzGEBrPw1XQDvtptztqUcX/y4qy3sURrN3+Ahw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795490998;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=8eCq9dib8jOAF7T/Xv3lvdH1JoM5UBCk+ZQipVveLXA=;
	b=OiEhabAiu9lujBdOZV0YZLt649fNbBw561f8FfwP9SqdaBqMjQJDynHvOc0R5u9BKOSP
	 Luxk2sZSFMEBAwspMXPtrRJHmpglIQVnvgHdtylEQoylNj5K8S/2WPQdJIfTkDtWax7kD
	 +DtFzMrtMc9+tc1L6QbBGulTtIkSvhB0ty0HP/7uPK+iauRH9QPzmgQtHva6+MJbOaUec
	 oLZKDen4u3+fLhspL0uugfdG80ma3E3FhYqsUI916Yu/71VHawZcxaZfejEBI8onhboei
	 iFY8BrPdNSQxjsrkPrKrtRXXvxqtQfGKfN1zfkocDQX3pBygiy/PWzrQho8Dlj8FSaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nM6iVLRV;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7E3606A32C
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 03:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D7E3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nM6iVLRV
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-38531c1a566so2779524eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 19:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795490997; x=1796095797; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8eCq9dib8jOAF7T/Xv3lvdH1JoM5UBCk+ZQipVveLXA=;
        b=nM6iVLRV+E5DEkmJ8PrBOFUkLT1+E0ajv2uzNxmiCETMayVDGZQIAACNQV2LGmp1jo
         8MSB9tByEVkGCYavNn0Gl/aUb7wDTzReNQ/RkCfy4rDo4KfC1up6dXDk54LmgHSD4B7y
         6jicJi1ntP7lLQKpGt1j8kGGz5whtqBV6AB0r12KNLtcoa4qNtUIieD0Mp3AkmgA5kj4
         tR4uau9kpl8oYfdTrn4Nfz0uxLZ3Aot68KuUH0XWGwc6M3WidaiI+0R3aa/PNs7HQZcB
         0XLNVpQr7cZsaCS71X4X++d0EJvojjyOBUthrbGSKH7A3VRBggJrL/fwzoTznIRlEOxj
         LedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795490997; x=1796095797;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8eCq9dib8jOAF7T/Xv3lvdH1JoM5UBCk+ZQipVveLXA=;
        b=lZWHLIcP7LbzuUjApIDtorabmpf1Qmob/GGdIiK0VrImXkQ56GhZ+VVp3KWBhIgfcp
         Q0/5wQXLURjfuzpYDrrzLWme8384YRMMoNs28WblAMXZ9ieQQCM1hOS7q9P/ZEsbdVTi
         xPq1wZlqodcmPDXIo+L1p+QGp/zX3gV0Mq13qdaACBj5afFJBhGcaunrdD2aZYAc7k1K
         z8iwt3VmSqBriYwHvigXR0qR9sqOnp1zA3m8mK7nqdGstiV+l75qcV5WWZovYwTC14Ag
         UqXlmcn8KvYXE0em9kE8NMf6ErKHpF1ppiEJ8ACdSz7eLbjJXbD8R78dNfcBTQBc2nKh
         1LLQ==
X-Forwarded-Encrypted: i=1; AL+hErGkt8U2XlUh9UW3JbaPXji8cyLDqljnHrU+wMV9KrniplVGqXc2d/BB1vb33mibSUnledGe2YaW7FO1yePU6jdj@vger.kernel.org
X-Gm-Message-State: APuU4Z87dirreX3qQMO9OiKrcFEyGeUxJUsmHUur4Y5pzCreGKs/Q3E5
	qCDnZ/kU3ayq6QOkxVpFMS2396SZX6QSuRSdbkwZieE7iWN6dEJ9Tmfmkoiug75IjXceD3NCrAe
	zIx791zp5Ag==
X-Received: from dybzy8.prod.google.com ([2002:a05:7301:e108:b0:382:22da:973b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d941:b0:381:3a24:1be2
 with SMTP id 5a478bee46e88-3856fd5d566mr15197140eec.13.1795490996929; Mon, 23
 Nov 2026 19:29:56 -0800 (PST)
Date: Mon, 23 Nov 2026 19:29:02 -0800
In-Reply-To: <20261124032902.3859564-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261124032902.3859564-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261124032902.3859564-12-irogers@google.com>
Subject: [PATCH v9 11/11] perf test symbols: Add session allocation wrapper
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
index 1fd6bfdc4147..c6375bd7e3d9 100644
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
2.56.1.809.ga0b61035b5-goog

