Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E92A370D75
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481849; cv=none; b=SyP22QugJhZiGDcWAB/J9T5CwWvz5GR7d+1UZ1MpK5TupqfF15Ji3dsSwri3MsNIcdh10ixTP2YkFNBEwvjpuFPbsQKqJo9Z3I6O/IJtbEx9zX+5nXyE4ZlTzRMkhz8tjsk5fSd3z83tYzsyJOhEpFcf8xjmr00gZDDFf+ELfL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481849; c=relaxed/simple;
	bh=6k19SDxCL9D1KuWrvkZA+rOT1XqhgBbavkC2y8a1YGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DzEl3pC9OO0AlEZ/h1yi62vnFv2P6Vfboy3Tg1qor6fjDUfoSCuWcbGAxnN8ru7cv8bE0rW8oqiRqtJL2EtbxL7gw6r1z5ULbkEOAXP0n/0RldZ8s4bz8t2d0ErLowbXvXNDa9TqHm5QwqzZcE/rPJH5OytU8YOF72YgA1Aegu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NRHjaWbH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NRHjaWbH"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b2b037d2so14725655e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 03:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780481845; x=1781086645; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bb5mYn/X2kb9euudhIWHaZoD8uTAINcjaTMlJ6g7asU=;
        b=NRHjaWbH/NosnK3mk4a1TSXb77uMj8/xnIVl66ntzIrcvmp+gXIE/tZnJrjA50lnhC
         LsjuavdjEfADvJFLi5ZZhBe3IB5bS9pRsmaZUpKQwYfiaQkBxEW2uj7OsWzAYqfk2JRS
         +0vw7yqQ/sYevhTHuf1y27WtyID0S5uYQZkSceIWQXzUEAeQwPdqgqOBZpPPR4whrPPm
         PqChzSBdievRPTdWZokbWxlQZTIXvuRsnRAb5CSVDiFnOq33crjzs+HF1Zcm+93hlxK0
         55JZbJCTh7TB08MCieSmJ4NMjW9VwAV6YKi0t9n87eq1Z8LiuPJ3XvZFWd1WCigd7pSc
         u+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780481845; x=1781086645;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bb5mYn/X2kb9euudhIWHaZoD8uTAINcjaTMlJ6g7asU=;
        b=RCdhq9NM5IJajoQck2kPoqu3vqnaVnWCpRoEycB/lqLGfI9lfomXSLgx54FgqLIRh9
         puSvIUtZTaWZVL0Yy1v6DlFDwZGN1kicjKB5/2uYFB69t0C5xPrUHniduGAtx6NYUGUj
         TEJuxqdzyK91b98C/MB0lnM19yWFCWz6CBu25ySsYF7a/z4pd0HDV0/09xShAIqa19eQ
         Nm2hNUG1bQuGCTx8fApnxu44Vrd1kBjhk7frsJ7Op2T7dLK3x8p4ZIgsP9C2ppSKM9kq
         VAqfOLtZVIjxy2/LsnQtNdkNW9oBcc0oeJkdnFJSQ+8tvMBjtp8dp+Ohxg8yrmmY7I19
         QHPg==
X-Forwarded-Encrypted: i=1; AFNElJ/FPWFNwJHCY/6foC1UvVfKLnkoFbPDolJhzftfeac9ApBM+rJ2lgD63YzzSv0DxnFVkOFOKYXgdZ1LDkumdrJx@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/qfMRp2zgkrHJUNmrbl56u2a66+1bgJ4QaHE9HJrPPw0WU5XB
	iCeAK25KUpVPG5pMcF/nmpgZtxxL5sq9i/k6dClCGloPoLt7jeHmHNAZKkTK4b2RCKE=
X-Gm-Gg: Acq92OEzNWOWOX5Huztlx9IgV4v3Y+91LCvjwuJq+0gHYNHaz1jeDr7RdkH3YEmg0l7
	sph1SVX0BvBglPlv+MCpyAEKWfMQF6p6M6l+zoZ3O7hQ3AI7wk+MqhJ976YMYqyEHPMVpTZqSJQ
	ukolMkCSo4O5eR2vtTZLREKjpN9AdrbouFLOQaemi0TJhxrrd3HEEeN4eDd2SkI8jCkafYeGxhH
	RTshAcXGBHoh+e1OxM5KwYechwOZFwAf5ZJpRv4jyl+8qSESIw+OZORn2mF4SClszgDUkjFFyYs
	xvHlFXTqVp+MN9RgXFDiCMJY1tDMaPOQF+aap9Czg9P3GFQbgtVxQ61+5vWtzx/Qtnq459dmAQt
	x5gbyhOr9+8wPro73Id56crbgc24f7y2miEv5dwPRQCHwyjvPS8UNpceGLtBFXEWE8nyGCuJc2T
	xlABEH0lPVTIRTL5tSK14aG2LHuZEMVbWYu/GMQxmy7WLudDMS5q1WCA==
X-Received: by 2002:a05:600c:1c1e:b0:490:b35c:88ea with SMTP id 5b1f17b1804b1-490b5ed1429mr46254965e9.15.1780481844944;
        Wed, 03 Jun 2026 03:17:24 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b63d8205sm38681875e9.11.2026.06.03.03.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 03:17:24 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 03 Jun 2026 11:17:07 +0100
Subject: [PATCH v3 03/19] perf test: Add a workload that forces context
 switches
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-james-cs-context-tracking-fix-v3-3-c392945d9ed5@linaro.org>
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

This workload launches two processes that block when reading and writing
to each other forcing the other process to be scheduled for each
read/write pair.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/Documentation/perf-test.txt           |   7 +-
 tools/perf/tests/builtin-test.c                  |   1 +
 tools/perf/tests/tests.h                         |   1 +
 tools/perf/tests/workloads/Build                 |   1 +
 tools/perf/tests/workloads/context_switch_loop.c | 101 +++++++++++++++++++++++
 5 files changed, 108 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Documentation/perf-test.txt
index 1faf30d4a7be..9c0d7ac2bc64 100644
--- a/tools/perf/Documentation/perf-test.txt
+++ b/tools/perf/Documentation/perf-test.txt
@@ -55,15 +55,16 @@ OPTIONS
 
 -w::
 --workload=::
-	Run a built-in workload, to list them use '--list-workloads', current ones include:
-	noploop, thloop, leafloop, sqrtloop, brstack, datasym and landlock.
+	Run a built-in workload, to list them use '--list-workloads', current
+	ones include: noploop, thloop, leafloop, sqrtloop, brstack, datasym,
+	context_switch_loop and landlock.
 
 	Used with the shell script regression tests.
 
 	Some accept an extra parameter:
 
 		seconds: leafloop, noploop, sqrtloop, thloop
-		nrloops: brstack
+		nrloops: brstack, context_switch_loop
 
 	The datasym and landlock workloads don't accept any.
 
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index a9e67d7da700..2830a431771f 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -156,6 +156,7 @@ static struct test_workload *workloads[] = {
 	&workload__landlock,
 	&workload__traploop,
 	&workload__inlineloop,
+	&workload__context_switch_loop,
 
 #ifdef HAVE_RUST_SUPPORT
 	&workload__code_with_type,
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index ee00518bf36f..79f50bacfc94 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -242,6 +242,7 @@ DECLARE_WORKLOAD(datasym);
 DECLARE_WORKLOAD(landlock);
 DECLARE_WORKLOAD(traploop);
 DECLARE_WORKLOAD(inlineloop);
+DECLARE_WORKLOAD(context_switch_loop);
 
 #ifdef HAVE_RUST_SUPPORT
 DECLARE_WORKLOAD(code_with_type);
diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index 2ef97f7affce..3bda6da04a35 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -9,6 +9,7 @@ perf-test-y += datasym.o
 perf-test-y += landlock.o
 perf-test-y += traploop.o
 perf-test-y += inlineloop.o
+perf-test-y += context_switch_loop.o
 
 ifeq ($(CONFIG_RUST_SUPPORT),y)
     perf-test-y += code_with_type.o
diff --git a/tools/perf/tests/workloads/context_switch_loop.c b/tools/perf/tests/workloads/context_switch_loop.c
new file mode 100644
index 000000000000..173d770ae619
--- /dev/null
+++ b/tools/perf/tests/workloads/context_switch_loop.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/compiler.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/prctl.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "../tests.h"
+
+static int loops = 100;
+static char buf;
+int context_switch_loop_work = 1234;
+
+#define write_block(fd) \
+	do { \
+		if (write(fd, &buf, 1) <= 0) \
+			exit(1); \
+	} while (0)
+
+#define read_block(fd) \
+	do { \
+		if (read(fd, &buf, 1) <= 0) \
+			exit(1); \
+	} while (0)
+
+/* Not static to avoid LTO clobbering the function name */
+void context_switch_loop_proc1(int in_fd, int out_fd);
+noinline void context_switch_loop_proc1(int in_fd, int out_fd)
+{
+	for (int i = 0; i < loops; i++) {
+		read_block(in_fd);
+		context_switch_loop_work += i * 3;
+		write_block(out_fd);
+	}
+}
+
+void context_switch_loop_proc2(int in_fd, int out_fd);
+noinline void context_switch_loop_proc2(int in_fd, int out_fd)
+{
+	for (int i = 0; i < loops; i++) {
+		write_block(out_fd);
+		context_switch_loop_work += i * 7;
+		read_block(in_fd);
+	}
+}
+
+/*
+ * Launches two processes that take turns to execute a multiplication N times
+ */
+static int context_switch_loop(int argc, const char **argv)
+{
+	int a_to_b[2], b_to_a[2];
+	pid_t proc1_pid;
+	int status;
+
+	if (argc > 0) {
+		loops = atoi(argv[0]);
+		if (loops < 0) {
+			fprintf(stderr, "Invalid number of loops: %s\n", argv[0]);
+			return 1;
+		}
+	}
+
+	if (pipe(a_to_b) || pipe(b_to_a)) {
+		perror("Pipe error");
+		return 1;
+	}
+
+	proc1_pid = fork();
+	if (proc1_pid < 0) {
+		perror("Fork error");
+		return 1;
+	}
+
+	if (!proc1_pid) {
+		close(a_to_b[0]);
+		close(b_to_a[1]);
+		prctl(PR_SET_NAME, "proc1", 0, 0, 0);
+		context_switch_loop_proc1(b_to_a[0], a_to_b[1]);
+		close(a_to_b[1]);
+		close(b_to_a[0]);
+		exit(0);
+	}
+
+	close(a_to_b[1]);
+	close(b_to_a[0]);
+	prctl(PR_SET_NAME, "proc2", 0, 0, 0);
+	context_switch_loop_proc2(a_to_b[0], b_to_a[1]);
+	close(a_to_b[0]);
+	close(b_to_a[1]);
+
+	if (waitpid(proc1_pid, &status, 0) != proc1_pid || !WIFEXITED(status) ||
+	    WEXITSTATUS(status))
+		return 1;
+
+	return 0;
+}
+
+DEFINE_WORKLOAD(context_switch_loop);

-- 
2.34.1

