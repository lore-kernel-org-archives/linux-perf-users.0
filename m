Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965E035DA79
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015493; cv=none; b=g/OypRd75Ss2yljGYYBGzT1Mr2gJqVdq/Ff8MXHObMW4rUUtFaqxj153fowNdBefPNh7Cx11MZz8xfJiyMzTM19WgcqDBOsq02fbJ2az4e60XHuwbmHSzrw3QTaQgwKDCK/MG0M56X7ERFKIodLLNqui4ZOX/H+CD7rSxsJ4osg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015493; c=relaxed/simple;
	bh=WCF37Je8MxyyOE4gwzCHUUj3VQznGEyT8txE/wxHMAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K72Ckk/1tvCqfJllXWqKtQ+UsyZ0huaNJPUDJfpLhNOzQXUvy9JlR55970E2dgNPGcX4FiaiPLyDmIUXTCs8svpkjJPL6X+wep4/ZQbzQQdSCUWJWKYnqjLvxgLNdO/KxLEzT9e/3dyhblIXhM4Rg5ER28ZJ7jLhOMs6KJgzFSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XzF/63Nc; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XzF/63Nc"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45ef1198766so3235558f8f.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 07:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781015490; x=1781620290; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4f1wgMP8HKBDMVa7qiKIEB8ImxwlPbZld8s+b9RAewo=;
        b=XzF/63NcocMMEUupzZxvJEPcJ5QT6DdVLjhufmGDbtlrUYxYX32GmermMzAyDfim3c
         5dypaYvoiEkloMGx5ijlT9+wbOg2MC1i+e/Tus+WJJ0c3SzpmjzehHCL+K6wVqDsn8nf
         e5zWY8DFD5TCcSQj5DDi+TI1rViKAWKrgcLdo9kdZ5+tf622mBoQK/EoKnWDZDawiKru
         MMGzi5Cd0y6uvxe1k+ujf8wjBC+T7HstXLIpelVLaN7xiIh6sAZB3ejQt2aJ0e35bHIE
         ROTvpZsWgnPi0ELhh0jv/FSsGjUNNRheJUreW7TkoozGKdRhowJ1Ujac3feCufJngg5n
         ixMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015490; x=1781620290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4f1wgMP8HKBDMVa7qiKIEB8ImxwlPbZld8s+b9RAewo=;
        b=gmQAJBUholih9EQ90jVSkkUHQ0FBZ0BJC4N1uuok04iSDOzDy+LpMTvFQ867HfldGC
         Bu9va3Xd2n/HMOAhBq4Gvy6FT5fdbZkdk7YFzwhh0X7US9rK/V2pmJYxHR/Zs6YxJfsv
         mtVDo+9aWKk4reO57Ap3wEGjZxXwFvmVhvpSKmKF1wNSbFuSbOzGOxuTNXzA+lndrdHX
         dk9WWHZQF+lERbaUEX/B6u/n1p+f4lxf4tJ5NnAao6ovhgj1d0elryXmTg8UFEwK3EJ6
         4VaqAkwlZ3c+LLXHqKD4nSwVN61WLV9C5/bJVlvVplDswae7TaFcX3Ge40Wkyu2PoeUO
         RF2w==
X-Forwarded-Encrypted: i=1; AFNElJ+zjhxY+vrNhop7R1RV3UTG28857sfm8glboGnf5AMJW2fBYcUl+lJ5b49XJsuUTO6OULhYBFdAWuAtZnTlRfqJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyR4BTNsCNmDloPrwNU4/eIK2QJXKW0X5Ffw+F5KCEECtCrgsOo
	LDncpeAvRubQwjIrzp0oAHHixWHb11icn79w6UFo+kYGQVZMcZfkM8UE/AehTpVU1sc=
X-Gm-Gg: Acq92OE7snCcGtxH6wXmRPtrBVmUdjGm7aq4hi+PcQ4LYiKJnH3UHZqb82pz2Awy5qm
	xjmLQYUhXxz+yc9uMUy8mU92jYrllYeIdcWi6Z2YMoGnN40YuLZqLgHnq7Bh+p10jO+C1lwua+m
	Q5gj7SLvjhIXIj4XsnXeL0uv7PzBMwjyl2x4xCtIluWbgA1foyPDAxXDgeiaNT5MVKe5lzLuQ53
	ZUuQdqBjqh7MRWxWCkQdEaFCgEn/9vNmP1pND1A66TtfJejq1QZSg+Nl7F1KGKHeSwxT03mlrfW
	abmIkzhJSZVt8pPfNW40cS14PcrBb6SXAZKG+mPCs5BJjYdRgg2hADH3LWGaoi5VrqqZjJtQqc3
	OeM6rqtO6EtxwzZHB8Wbvy2Gg61y3IGE0iSrnGUlO0Q5NskkYbTWIBgv8hxMvpSdkt7dkUrTPzV
	Mpw0Hxdcw0IGs1rq1fG8BlRxtiQ5ZfQPoeiBPO65CBdB4=
X-Received: by 2002:adf:ee81:0:b0:45e:9304:a4c3 with SMTP id ffacd0b85a97d-46032dced69mr19907159f8f.19.1781015489867;
        Tue, 09 Jun 2026 07:31:29 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3444fesm62738388f8f.20.2026.06.09.07.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:31:29 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 09 Jun 2026 15:31:02 +0100
Subject: [PATCH v4 09/19] perf test: Add named_threads workload
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-james-cs-context-tracking-fix-v4-9-44f9fb9e5c42@linaro.org>
References: <20260609-james-cs-context-tracking-fix-v4-0-44f9fb9e5c42@linaro.org>
In-Reply-To: <20260609-james-cs-context-tracking-fix-v4-0-44f9fb9e5c42@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Paschalis Mpeis <Paschalis.Mpeis@arm.com>
Cc: coresight@lists.linaro.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-doc@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Add a workload that runs X threads that run a unique function named
"named_threads_thread[x]" which performs a multiplication in a loop for
Y loops. Each thread sets its name to "thread[x]".

This can be used to test that processor trace decoding handles
concurrent threads correctly and the correct symbols and thread names
are assigned to samples.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/Documentation/perf-test.txt     |   5 +-
 tools/perf/tests/builtin-test.c            |   1 +
 tools/perf/tests/tests.h                   |   1 +
 tools/perf/tests/workloads/Build           |   1 +
 tools/perf/tests/workloads/named_threads.c | 109 +++++++++++++++++++++++++++++
 5 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Documentation/perf-test.txt
index c50a4b2d2d29..81c8525f5946 100644
--- a/tools/perf/Documentation/perf-test.txt
+++ b/tools/perf/Documentation/perf-test.txt
@@ -57,7 +57,7 @@ OPTIONS
 --workload=::
 	Run a built-in workload, to list them use '--list-workloads', current
 	ones include: noploop, thloop, leafloop, sqrtloop, brstack, datasym,
-	context_switch_loop, deterministic and landlock.
+	context_switch_loop, deterministic, named_threads and landlock.
 
 	Used with the shell script regression tests.
 
@@ -66,6 +66,9 @@ OPTIONS
 		seconds: leafloop, noploop, sqrtloop, thloop
 		nrloops: brstack, context_switch_loop
 
+	'named_threads' accepts the number of threads and the number of loops to
+	do in each thread.
+
 	The datasym, landlock and deterministic workloads don't accept any.
 
 --list-workloads::
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index ef7e3f52a383..afc06cec4954 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -155,6 +155,7 @@ static struct test_suite *generic_tests[] = {
 static struct test_workload *workloads[] = {
 	&workload__noploop,
 	&workload__thloop,
+	&workload__named_threads,
 	&workload__leafloop,
 	&workload__sqrtloop,
 	&workload__brstack,
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index bcfe9c33fc66..7cedf05be544 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -237,6 +237,7 @@ struct test_workload workload__##work = {	\
 /* The list of test workloads */
 DECLARE_WORKLOAD(noploop);
 DECLARE_WORKLOAD(thloop);
+DECLARE_WORKLOAD(named_threads);
 DECLARE_WORKLOAD(leafloop);
 DECLARE_WORKLOAD(sqrtloop);
 DECLARE_WORKLOAD(brstack);
diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index 90f2d8aa4941..75b377934a0e 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -2,6 +2,7 @@
 
 perf-test-y += noploop.o
 perf-test-y += thloop.o
+perf-test-y += named_threads.o
 perf-test-y += leafloop.o
 perf-test-y += sqrtloop.o
 perf-test-y += brstack.o
diff --git a/tools/perf/tests/workloads/named_threads.c b/tools/perf/tests/workloads/named_threads.c
new file mode 100644
index 000000000000..d051d41a3cfe
--- /dev/null
+++ b/tools/perf/tests/workloads/named_threads.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <limits.h>
+#include <pthread.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <linux/compiler.h>
+#include "../tests.h"
+
+#define MAX_THREADS 25
+
+static int iterations = 500;
+int named_threads_work = 1234;
+
+typedef void *(*thread_fn_t)(void *);
+
+#define DEFINE_THREAD(n)						\
+noinline void *named_threads_thread##n(void *arg __maybe_unused)	\
+{									\
+	pthread_setname_np(pthread_self(), "thread" #n);		\
+	for (int i = 0; i < iterations; i++)				\
+		named_threads_work += 3;				\
+									\
+	return NULL;							\
+}
+
+#define THREAD_LIST(macro)	\
+	macro(1)		\
+	macro(2)		\
+	macro(3)		\
+	macro(4)		\
+	macro(5)		\
+	macro(6)		\
+	macro(7)		\
+	macro(8)		\
+	macro(9)		\
+	macro(10)		\
+	macro(11)		\
+	macro(12)		\
+	macro(13)		\
+	macro(14)		\
+	macro(15)		\
+	macro(16)		\
+	macro(17)		\
+	macro(18)		\
+	macro(19)		\
+	macro(20)		\
+	macro(21)		\
+	macro(22)		\
+	macro(23)		\
+	macro(24)		\
+	macro(25)
+
+#define DECLARE_THREAD(n) void *named_threads_thread##n(void *arg);
+
+THREAD_LIST(DECLARE_THREAD)
+THREAD_LIST(DEFINE_THREAD)
+
+#define THREAD_ENTRY(n) named_threads_thread##n,
+
+static thread_fn_t thread_fns[MAX_THREADS] = {
+	THREAD_LIST(THREAD_ENTRY)
+};
+
+/*
+ * Creates argv[0] threads that run a unique function named "thread[x]" which performs
+ * a multiplication in a loop for argv[1] loops.
+ */
+static int named_threads(int argc, const char **argv)
+{
+	pthread_t threads[MAX_THREADS];
+	int nr_threads = 1;
+	int err = 0;
+
+	if (argc > 0)
+		nr_threads = atoi(argv[0]);
+
+	if (nr_threads <= 0 || nr_threads > MAX_THREADS) {
+		fprintf(stderr, "Error: num threads must be 1 - %d\n", MAX_THREADS);
+		return 1;
+	}
+
+	if (argc > 1)
+		iterations = atoi(argv[1]);
+
+	if (iterations < 0) {
+		fprintf(stderr, "Error: iterations must be non-negative\n");
+		return 1;
+	}
+
+	for (int i = 0; i < nr_threads; i++) {
+		int ret;
+
+		ret = pthread_create(&threads[i], NULL, thread_fns[i], NULL);
+		if (ret) {
+			fprintf(stderr, "Error: failed to create thread%d: %s\n",
+				i + 1, strerror(ret));
+			return 1;
+		}
+	}
+
+	for (int i = 0; i < nr_threads; i++)
+		pthread_join(threads[i], NULL);
+
+	return err;
+}
+
+DEFINE_WORKLOAD(named_threads);

-- 
2.34.1

