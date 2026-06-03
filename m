Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE2044E03B
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 10:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481860; cv=none; b=LeIf3605PNOzs+pVfqgMIg1JjXBXaqbDLQ7t/PUOYwKOXxm9kG+N5FC33a8GzU7tWnomXlmgvZiHjbdsjNg7fcUn+ejuOKr5otlGH0ajXqb/N9sNXonRPebCavaJqy05mauJinhwRT8xcx1N80/o20vzqpDODMGQmPjZQqvsoP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481860; c=relaxed/simple;
	bh=f7nYZOjqRymoF8HLdou2qxt3lFfZBlP2peDzjQpRTcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DSY40eXt4EM2dZQhOZ3me6ssARv/qUgoftp+XjvTwMH4kwpBPgkinxXBhCQEjP1mtgEDViYDTAlBjR4z0I43eHDOl4WTh+pYjOjqro6lAaxX5Cj77UWaVVihpN0Z+jDvIqv9khrjema02lJXLyu4JWU0RlqbY3uS8WTswhkv8l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QEnahXil; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QEnahXil"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490b1bbcf3aso16376125e9.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 03:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780481852; x=1781086652; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mfmfQz4GZFVkBiOlSPmMGw2k+07TI77rK2unIhsiSv4=;
        b=QEnahXilFEZNlerG7QjRhF6wmmc29cowLUHh9dP0zFnenw746LHgktPY1LmIXbdLnm
         mz+LwJX/hQ8dSuGGjyJpmk31XyVwgdcDmxm9kn/VH3guKZ1yAfxG+o+3IclHaIfKpkaV
         bAHzx2SmtsJqez4axkXoo6QNQpEYtSSPUCODg8q+nkEW7mW+8hUlBVMKZkrqIqsTyhoF
         SSuWcAgzcjrUO3ujpvqgxtYptz1BsEBha8mYZKPSjcC244bkgfupgywiRhAbvXVjCICq
         VlXG7DgxxWSnSHXmI+LIXbgLVr4L1QJHd1OjDuZP1Pn3P4TVr2k+kfAHUjJSXCGO9akT
         Y0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780481852; x=1781086652;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mfmfQz4GZFVkBiOlSPmMGw2k+07TI77rK2unIhsiSv4=;
        b=lRVNZgTBr7EjYrc4oWO0Kva1pAaesmgZjTZpQtKy0GT8qi5xdq/WgVazOs7tNomjvw
         bJsQba4B9+tLRsK4gX+DLMORoQI4jciJxXbubRT2K+3sZq4yaB+UYmX/WpzdjqRtp7P/
         Qa5C3eHyrQGpZztAAXqAW6AlZLwE0Xef8ptrGdYcbJ6zlVk1oQ/n9L3bxhJL2em8DgNk
         xr6l+QT39pnYi/GA40uXmxzH8H+7AuLAPY3HXZhWuyOnQwF9aF/1B6uM0hjIt3lPO5zh
         gwHqz7JqstDqbUe+XGuKKZ26TLob8ZIy4sVJGvbrVP0VmWO+coGK5YFo7di6jvoN8EMH
         uWYA==
X-Forwarded-Encrypted: i=1; AFNElJ+XXq1IxT8QFw+UCT+oOaZqHHEaTBfD6gSEpyTy7NHjqYoVpLrsh2qTvOBedF3L6ewu/4jZIXHNVS5nV49BDSgu@vger.kernel.org
X-Gm-Message-State: AOJu0YzaU6qRZskdLGMpget2sdPxakUsvtQ65F49uYshApK/wktKDdik
	Qf9KOPGUz9qCsN+Ez8/2z0JuuDQ6OHBq4mpVHqgeRN4IiHl979VbFd4vyt43gMNaCG0mQ6GwseV
	55XTkGvw=
X-Gm-Gg: Acq92OEboUNqRIEo5I2uZqRgn9E97L4GOErUy0w5wh1K95IfCMI3/NmqI1zVtyLqNxO
	3wN1Kfrc+rbdHUMiiMpLhbEUW9scs5/qg9cJK5DZi64j8PPnDX8NwS9jqiOxFCllVPyJ7AW+ZfD
	8qxO0CYSbSam25Gt8ZGhoUtWhgkKoE6orArqfe2YxHUpkQCAV5FohvTaMrGe12Olr3Mb7KbDqgH
	9WV3ejwP4OqIk2bmYMcPNM4vCmhFLGWBp2vp5xhgNjusw7hl57WYCE0aq8IGq1gwW6Ku8wc2LHO
	OUQpRLAvi8/+oGdpAUtYCCU4NDvbw6iQReLAUQYv5E85wUlt0qly6mcikh1Vt+J/OR6WOXQXqqG
	QwQaqv5G8yAuy2IY+x7Kyga2+JRy6JA3AOUBH8b5a1XULL/ZqOF2g8jDilrKPRwoakbjY2PSkk8
	huS0qQpuQu7N+JhuIu3hrPEuMby5FnYIIE+3MASMFtof0=
X-Received: by 2002:a05:600c:630f:b0:490:b025:f324 with SMTP id 5b1f17b1804b1-490b60e41a8mr46919575e9.32.1780481851759;
        Wed, 03 Jun 2026 03:17:31 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b63d8205sm38681875e9.11.2026.06.03.03.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 03:17:31 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 03 Jun 2026 11:17:13 +0100
Subject: [PATCH v3 09/19] perf test: Add named_threads workload
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-james-cs-context-tracking-fix-v3-9-c392945d9ed5@linaro.org>
References: <20260603-james-cs-context-tracking-fix-v3-0-c392945d9ed5@linaro.org>
In-Reply-To: <20260603-james-cs-context-tracking-fix-v3-0-c392945d9ed5@linaro.org>
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
index 5a2ab67cd85d..2fee93858c86 100644
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
index cca7ad354227..7db5eea713a3 100644
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

