Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370F0351C35
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016031; cv=none; b=X0ekzpge1zq0xBUdEJ88jMtl/M4R/JP7+WtEkZLgQ6TDYIO9/12ObZEoBk6HL5DCpqtKODYziA7dDPhE8G3Hg4ZNsBoUS2bfvoa/s5vymDVjYawywaoWVVciN5TD1VbM1qnGQKbPvL5HVA/ebUA8eZHkfs6l2qd4SeDTgjzkdeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016031; c=relaxed/simple;
	bh=MpqHY1226EZDlsL7AYrF9I24rCLFkLMgGMHa7jjWFqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GU34kVRHVa2138ilDMINiLVeKbJyyypKIRQG08rxGYEI6R2o7mHTbwsOXcBkianYTVnNiK1cik6GJ+8RI91hy8Br57rmdEZ0crHi6K4oo97K7jAfnre+IaSj1zkAi7LbFWe6P5GTJGE6l8aWwvkuecmYTDiZg2pd+QJUOaUmRB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wFMfn8AQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wFMfn8AQ"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b64c8311so62873525e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 07:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781016028; x=1781620828; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9nUZrv+uXShy5oUjVbWJnHpZlIUPoN1ZejbvjYmlEBM=;
        b=wFMfn8AQKgwPpf5kmqGxAb0QgWyosBDa1ZDJV7wREiSG4Uf3LdikSWBpt3LPJJpEgd
         moI0WehV1RUARu8IQjSnqHbxPAg8lxgxSf8rm8OV0UeuZSmj/qGcJA5M62Jrm4Xi+afw
         Qedi37QSfLty+a4elrO7pRBTgNaHmGZAwyEbvrU6cij/f67fZ4wPwMkWWJSn5w5pwffG
         90gsdyOu4+LbL83t5ipiP+pjwbZ3UwLFn2RxxDPcYRUyu8l6XX5waa1uk2C/vxUPW/2r
         dP9mg6LqIKHEgSaP3B9uop6Vn9rLxXmgLFYGF7KSR7to5q5FIUpGmC6Dj3ZppQ4iyrUy
         uAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016028; x=1781620828;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9nUZrv+uXShy5oUjVbWJnHpZlIUPoN1ZejbvjYmlEBM=;
        b=CuNZJKBsScLtPVx+nLj95E3BZ/0RubvHvCvqwNRBNxis3+F72zvcz8pPL1mdIxcVVU
         y/knnKnEnU3bUDRI5PkrEq0uyftKaZPWFj+8UPw0MrZD1ONCSvx+IPqtPQu15P+JpuYS
         llZ5MLAZDdZJ2QjgVXxAHY3Y/eRoG5GRtXS8oILzHHgBUEt91mrBA8jGsJv+/b41M48o
         pNhVhxV8waRf/Zolwlj0qKAr8m4jhIvhb3y3BHvj4YQ9OvCA25kbKTA3jKeh2P6MP08i
         acn/oSp95YoSED2YjznAwpcIz9OfJ/g00ap+rSuIp4mCxPnvLAXeH7Cfa3DWhU66EiTx
         VtZA==
X-Forwarded-Encrypted: i=1; AFNElJ+wQqsBYJzLv3GG6K076PHjnfJo0VuGG+b+OpCO38JdEFPvHyoTZeGhK6U5pMR2z0FodLyxy+0VfUZwazsZCy+E@vger.kernel.org
X-Gm-Message-State: AOJu0Yy09uFMvX+99hQOK0oKs/eJHNZ3fvKWN5ZfcZOYPk8FSdfvN1C8
	lfqmWsHjQQltUA4D/48c5bmibz7ZHNrvls8Yht1VjXjZil7aIAxMjqcB8LuwXbiqx/A=
X-Gm-Gg: Acq92OEfHwaL6DQ5QenIGMaaopjjwkJAufHxKTTzI9+O9gu+us8P8zQi0DtkwtH5IdB
	0DszCrTCqsZxRgDK9ABlIdwvyuy+MOxV4vhMDFsFxuKVc7zW6ZAyqAicbuQOk/1DKEI/3eq37/b
	qQw3SrTmQ1vXiAvrQvUzgmOZBjxg+tPh9PJlInW8lWn1bXXvRGGKqY3rGNaNRpXJq0uW+VKa8Jn
	NTTavsOS4ilIJCaGhS051FwNMnULcTS3CZXL0Pl7LzUTZ6WFgZ/T9hQ5p4tzlFaGU5fAV37VEoO
	ycqJ9tkjs9hhxGEC80Vzjdmkmb8Vhm86tTsCLt3V2HGEbMzGizZVxM4ct3ZpSIa5wX7N73pTf3F
	nbkcLe5OTsV7mmykN+Fd8My7GOBOa1/weilu3dSx1fijvoH9OpkYyawb5gWUPxwy4n8ewzF2xSw
	b4TQG95zd4GggNJ4TgzNUhsMWfyl0nn7D5vNrnw7zTT+g=
X-Received: by 2002:a05:600c:35d4:b0:490:b8d3:5dcc with SMTP id 5b1f17b1804b1-490c25e4634mr350034245e9.19.1781016027564;
        Tue, 09 Jun 2026 07:40:27 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c1149sm428411935e9.4.2026.06.09.07.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:40:26 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 09 Jun 2026 15:40:08 +0100
Subject: [PATCH v5 03/19] perf test: Add a workload that forces context
 switches
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-james-cs-context-tracking-fix-v5-3-d53a7d096a19@linaro.org>
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

This workload launches two processes that block when reading and writing
to each other forcing the other process to be scheduled for each
read/write pair.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/Documentation/perf-test.txt           |   7 +-
 tools/perf/tests/builtin-test.c                  |   1 +
 tools/perf/tests/tests.h                         |   1 +
 tools/perf/tests/workloads/Build                 |   1 +
 tools/perf/tests/workloads/context_switch_loop.c | 110 +++++++++++++++++++++++
 5 files changed, 117 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Documentation/perf-test.txt
index 2f4a91f5b9dc..213eb62603eb 100644
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
index 86ea427eb0aa..9284f897de3c 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -163,6 +163,7 @@ static struct test_workload *workloads[] = {
 	&workload__traploop,
 	&workload__inlineloop,
 	&workload__jitdump,
+	&workload__context_switch_loop,
 
 #ifdef HAVE_RUST_SUPPORT
 	&workload__code_with_type,
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index bf8ff7d54727..7cd4da4e96d3 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -245,6 +245,7 @@ DECLARE_WORKLOAD(landlock);
 DECLARE_WORKLOAD(traploop);
 DECLARE_WORKLOAD(inlineloop);
 DECLARE_WORKLOAD(jitdump);
+DECLARE_WORKLOAD(context_switch_loop);
 
 #ifdef HAVE_RUST_SUPPORT
 DECLARE_WORKLOAD(code_with_type);
diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index 0eb6d99528eb..7134a031cb7c 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -10,6 +10,7 @@ perf-test-y += landlock.o
 perf-test-y += traploop.o
 perf-test-y += inlineloop.o
 perf-test-y += jitdump.o
+perf-test-y += context_switch_loop.o
 
 ifeq ($(CONFIG_RUST_SUPPORT),y)
     perf-test-y += code_with_type.o
diff --git a/tools/perf/tests/workloads/context_switch_loop.c b/tools/perf/tests/workloads/context_switch_loop.c
new file mode 100644
index 000000000000..5431af6147e6
--- /dev/null
+++ b/tools/perf/tests/workloads/context_switch_loop.c
@@ -0,0 +1,110 @@
+
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
+			return 1; \
+	} while (0)
+
+#define read_block(fd) \
+	do { \
+		if (read(fd, &buf, 1) <= 0) \
+			return 1; \
+	} while (0)
+
+/* Not static to avoid LTO clobbering the function name */
+int context_switch_loop_proc1(int in_fd, int out_fd);
+int context_switch_loop_proc1(int in_fd, int out_fd)
+{
+	for (int i = 0; i < loops; i++) {
+		read_block(in_fd);
+		context_switch_loop_work += i * 3;
+		write_block(out_fd);
+	}
+	return 0;
+}
+
+int context_switch_loop_proc2(int in_fd, int out_fd);
+int context_switch_loop_proc2(int in_fd, int out_fd)
+{
+	for (int i = 0; i < loops; i++) {
+		write_block(out_fd);
+		context_switch_loop_work += i * 7;
+		read_block(in_fd);
+	}
+	return 0;
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
+	int ret;
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
+		ret = context_switch_loop_proc1(b_to_a[0], a_to_b[1]);
+		close(a_to_b[1]);
+		close(b_to_a[0]);
+		exit(ret);
+	}
+
+	close(a_to_b[1]);
+	close(b_to_a[0]);
+	prctl(PR_SET_NAME, "proc2", 0, 0, 0);
+	ret = context_switch_loop_proc2(a_to_b[0], b_to_a[1]);
+	close(a_to_b[0]);
+	close(b_to_a[1]);
+
+	if (ret) {
+		kill(proc1_pid, SIGKILL);
+		return ret;
+	}
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

