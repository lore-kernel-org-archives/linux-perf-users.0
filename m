Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7200D407CD2
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410453; cv=none; b=lP3x20lyf2Zp3QCS1rYpqFN6owauMj51u8J7T1cxH+Mka/VtzVd5rhJBztpapsZHGB7Tj6xDrAadJizWOl3pGqD03pHbkcSQzrdVDfoGySF3KMbRYz5nFfs6AQiNya08eMGpW3E4qubGECMcPn+OyS24eJD8YOmZCifqWqzmoac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410453; c=relaxed/simple;
	bh=WLH4cINrrVBixvMSWcM5m8NSt3CkPZQErqsTHkkdWTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pLnuS2/y/m0uLC05giC+VCoj7sB/YD6a4dnzDB8IsCk451z2GZME9lF5IMqr+ogxRf8A4jZuZwjYsoY56lXfe6Xkn80kqKIVT0f7nEaIJGBmiUxkH2Fkb6Qaz25JBDah/Cqt/1i2cKPLbLL6P4jNvwi4jM6e2P+KUV9Wyc7Ql+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oVCyHgB6; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oVCyHgB6"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490388fd0dbso115136905e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 07:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780410450; x=1781015250; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JHk81hDI2gaCho27XBexwyVVmXUcvCJnAHjowmiTXsU=;
        b=oVCyHgB6cjaT2Piuu+3kIcuXNlCYUFAMCPXs7GHqpEWIafv1mNXaOoRcxlblNI+KAB
         xnZvh5dsbUruZXKouNwprYdujhNgnAu2kYDEVdmC7MgntrBNyTP7F4qBDxGubXFrtmFk
         jOJ28kxFOAZOzvzNzGbPzP7kz6RVDLtbM+sA1hYiihokLIH8sNu0ZZ6xnIv/pS9uEEif
         64GDwOspoKNgmkHSVCozI6mF2pz8a7jMi92ZBkdZ681f4uffMWeoqqdlc3osshZ5+S6M
         gwZmlxkvt8vFAPH8dPQmkMiPs2TSSyYrxp3pJwy7HSPTyk9LqRyoKYOZwvCjX3BEmvxL
         O2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410450; x=1781015250;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JHk81hDI2gaCho27XBexwyVVmXUcvCJnAHjowmiTXsU=;
        b=SuTznUojHe4ZdbhmiUhwP2XIUHsleNneM7R25xo/Em03I1gwApNzC7jFzrwF+SpwgS
         a0Ad6pRsewwnSWVHgbTKXlRHhyZpsW8y9UvyRnBvWeZ9bA35nX/3sBrz4BN91RjtEN+b
         xbQfgwQyJ6P4kjPP1nkroGgS+L8vwMXiag/Jhov7z0VDz0lIFUUDD4OLh+ICMCjXxWuA
         WRX3vJp0cgq9peBM76TFsR4/DxWk3hLDLZUHXuVY+cb8KtEO3sgGNtgRUSSDTa/HGq8q
         nHGZyu+kyhYccUSZHPAD3K7lsGmIcRwZHbtyARZ8zrkj8Ufu/4IDPrE3sHvcY0MRGYyF
         C/Dw==
X-Forwarded-Encrypted: i=1; AFNElJ9Snf0izu6FwykbUtOuTvyF09jiIkmNlA5JJwo6lHWMcZLOHCao+tx9nw/Vsr2zDHmzeqQPOvCE/SvMWw6HFS/O@vger.kernel.org
X-Gm-Message-State: AOJu0YxUP2rmwrsSvKY+mSLxsm5I3SRz5nfEoDYglD4bDE9JRDZUKgEI
	4/rnA+E00qby+MMzDH+devYidRBOi4Nl3rY9EjMr4TOGV8mna2Vj+uNdDMIO7weMKyE=
X-Gm-Gg: Acq92OHXnYzEd4W526B+An4rLN+2BD96d4uJywjlrz5RPmaSJbjg3abij5OUGjldqyb
	vWHyEq6dStM4KxOvu+YQC8JXJVoCjEUeNzyH7ZYT91j8Zfh8AmASDQZbUudJlt3A5I8MumWB9lH
	eSF1x090OfJQEC+xwwWHVTYE5lfipBAW/uic00YZAcPCWz0KXIyhvIxRJQ9oRzy5qtB8XQG7gfS
	rXRuqtpXlSJwZYHi6aFHx0eBXGkSy+c4h8upn9rzQV69t93gfPqVCY+Uq8Bj9NNvZ8G/aktPzdq
	PhydoeX/dfaZg3w7gF+uChB/8QCyhbox2nTSZ4MK8vUNq9yFd3TstifCQPHRuZTa1nzR6yRQlyo
	PLb0c0fZ5DBAKbACNC+xrIFgvkvmKWz7blx4We7pOsIL+9pMq8hDC09PpvqOzIIOAZVB0ZozBkK
	Tzi3DnUfr0soG7rPuDAlkNOJubxigv7kVB4q/WM8Yi3dk=
X-Received: by 2002:a05:600c:5544:b0:48e:6db3:ff33 with SMTP id 5b1f17b1804b1-490a29438camr230654865e9.14.1780410449854;
        Tue, 02 Jun 2026 07:27:29 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e18e1csm66771965e9.4.2026.06.02.07.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:27:29 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 02 Jun 2026 15:26:51 +0100
Subject: [PATCH v2 09/18] perf test: Add named_threads workload
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-james-cs-context-tracking-fix-v2-9-85b5ce6f55c6@linaro.org>
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
In-Reply-To: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
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
index 7ec70c054cac..778c37f6efdb 100644
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
index 3c6d3de98be9..e5b6707bb119 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -149,6 +149,7 @@ static struct test_suite *generic_tests[] = {
 static struct test_workload *workloads[] = {
 	&workload__noploop,
 	&workload__thloop,
+	&workload__named_threads,
 	&workload__leafloop,
 	&workload__sqrtloop,
 	&workload__brstack,
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index f8bba2d68769..ef3c3a269132 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -235,6 +235,7 @@ struct test_workload workload__##work = {	\
 /* The list of test workloads */
 DECLARE_WORKLOAD(noploop);
 DECLARE_WORKLOAD(thloop);
+DECLARE_WORKLOAD(named_threads);
 DECLARE_WORKLOAD(leafloop);
 DECLARE_WORKLOAD(sqrtloop);
 DECLARE_WORKLOAD(brstack);
diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index 599a37c87878..81f5516f0767 100644
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
index 000000000000..dc8070a98df4
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
+		named_threads_work *= 3;				\
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

