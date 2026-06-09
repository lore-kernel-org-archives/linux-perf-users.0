Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31113793B0
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016040; cv=none; b=L2OVFTrwdxFT0/hVSUDS4a3rXbEwbfhAfTzdagYxf6tVwcNRTHvZuCF9jonVTvwbo12rs8zRQ2B8cOey6M3Dzv1h12PzL7M7g0w/3gzgfHxcme6Fn4m4kTEQPkCwnUfeqv8MDnc8mxXEisuWXGpoQUoiSTz4MREI+UzM6w+VWpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016040; c=relaxed/simple;
	bh=WCF37Je8MxyyOE4gwzCHUUj3VQznGEyT8txE/wxHMAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IQMEjF9L4MLSu622iS+Xde0F/zwSEa9pyXWFQqPuxrQrOLdLJQS0mFVoN7m+/MUd/1CyNWTIBV8NJQ3cfWZI9kAP6HU+NVNvqaBqQmtgvzrkDotcayQKwMVXHu4FNLz07a00rLzdrwibufb5YBQjI3PMNbNUChLXsIZMILYoxSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BWE8ptwy; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BWE8ptwy"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490bb83a3f6so46652715e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 07:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781016036; x=1781620836; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4f1wgMP8HKBDMVa7qiKIEB8ImxwlPbZld8s+b9RAewo=;
        b=BWE8ptwyTTxLW+lcRvDNTuEqbrhO8I8a+anTBI533VYwxdhiDCHhEIz4LXkBKKt+Hy
         2bdhdhnJakrV65h/KRnpSI7b2yRYQi6RBpmCaPuXgBXMDLIe9BLrNvCgRbzXzwZoWmqm
         VoNbATd2ZwmAD1Vj1OfHAeUcklOd8yazA+DFaSdBDuz9VGMvFFzzuSISitc6y7A2TCWG
         TL2IicLqINQOQwSIeYypFhDtaz7QCKgaeO7ZXfBcd+iKx1oR1Cb582EyFTpfilaTvt1R
         tEJ4hi48YZIzJUHXilDnSMTwOCJvHjh4Puf8YStf2LMmf/mcD/WqzwJpdchXLQ8HL2SB
         ltPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016036; x=1781620836;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4f1wgMP8HKBDMVa7qiKIEB8ImxwlPbZld8s+b9RAewo=;
        b=bhzpC3f+lXxkaCac+SO8i01+LtSJioTdpCboCV14rOYBTXqn+mJX2fg4920TJcXaQu
         KOH5LFkTwIYcIXOhtx5X0dOXyEKZddQunCDdwcKY5Gkcu4XFQSbD/bmYQvChM7I+yhYC
         HyVXolCmTLsUvoKI9+X6p4oUts/PsnX15bFPQhyWRi/DFkj8iej60iR8jef7K977NQH/
         0dDhWDXO6a40BBZv5h1211ggIwHLxjNcqNPAKIxqZPYgNmwiH2/g1O0qpB54YmqEkUej
         HBPATpby74AJH317DrM9SFPLoMlZZsUZWMchO6Z9gHvrA5bmaX4/JAvsKeV/Cr7SHddy
         AGkQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Of0MfpBKNa+cIES64wIUn0pQnVoy6lZFqJtoNi9PSkTUs5u81eU+A9+nMVqdCoZdeUsIp51KiFmWl16XGLLFp@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrv2N2KjdYunErzlMDV3ajHDQMPSxV3FbLyHjAHnk3791fRm7+
	nVgrPrUcIGgqAor9f6WuijbU4ZTx8wBQYV819NAmjxoGRPysfm9tAYFD7Obcwtym+D4=
X-Gm-Gg: Acq92OGWn3FnZVRHHRRZjPsidALu87cXq0tF2fw94H3VpZtWPKvI3MwaSOCmL6bqt4t
	awCUT+bzYL5QSX9GB6OhpLNyTCbaI2Mop7n/UgBxpZVNMtqoxdmMRU+inOXDhp/rC09s8wi1Dvo
	ob3nDOY8qW/ridwuC1Jv9+D847WaSs3RSs1vHjV3aCRz7iOgSmMqnGoPRP1HTm7wTStpEV5spH8
	rxx94sKxIiFrWgESqyqS7jx9GleNCP6M0ZV4QGQrBNjdfH0/RqDue615wwKVRf5DTAGc3SCS/F+
	MIcPtx+uLXL+ZCTd/JKthadoHurR/ZwTiiDrbfJHHGvBVmoRj9rvtSadkyQyFf52vFIkWb6uqr2
	dfvFBwqJQ87y4lhr7hysBruMqVX56iYcF7BHj7pzulgs6iSo1RCLtgYGNFyJeKjHjmeMJqlI6yB
	hCjYFKwJB8cO59QT/fQFXIGCFKD5C2TUUw+gg9ib2VHjA=
X-Received: by 2002:a05:600d:8444:20b0:490:48b7:c1ff with SMTP id 5b1f17b1804b1-490d72239damr30304245e9.17.1781016036424;
        Tue, 09 Jun 2026 07:40:36 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c1149sm428411935e9.4.2026.06.09.07.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:40:35 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 09 Jun 2026 15:40:14 +0100
Subject: [PATCH v5 09/19] perf test: Add named_threads workload
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-james-cs-context-tracking-fix-v5-9-d53a7d096a19@linaro.org>
References: <20260609-james-cs-context-tracking-fix-v5-0-d53a7d096a19@linaro.org>
In-Reply-To: <20260609-james-cs-context-tracking-fix-v5-0-d53a7d096a19@linaro.org>
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

