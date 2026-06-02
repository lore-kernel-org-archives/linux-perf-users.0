Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507323FF893
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410447; cv=none; b=BajgcYZfa0wllPf32AMGp8kQdy99LThPbpsQwNi9D/bNwwoQmJJLtOr2WUsudMuoo/a+NDXiMnYFBMM4v2kmbBQLm3DuCOo4x4kOqhHzmNbRwmKVCiqlBDetz8O3dyEKWV07fAQwA6muuH9sY7leufnFvSKrECP71NhrkEGOF2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410447; c=relaxed/simple;
	bh=nhbvUtvVfJ4XCxkw1g44IbixuAqwQ8Swfcda4PtYylk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SW4/oS7+X2XdjEeVmNHl8tvC4JXEXUzv9OFaIOFQ/l7Sa5/kjyhK1J7FtL+4eZj+60LnFMg87sUIqgbJf0yMTlMZ8n3jKy4z7abn42GhRIdNjnPMTx7lTM1/2N0WHm7BwdXMs5Vgo9tX/UYjQ0JzAwsJrMBg9xKT4/If3i3nPck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dJ2UfuQI; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dJ2UfuQI"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490a7629380so26087445e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 07:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780410444; x=1781015244; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2AzHCCZdh7j2BBDmmO5WAtLEfltvQL21ELilOv+mRsY=;
        b=dJ2UfuQI2FggK7kFLlp1OrCDE2KPorv1zZiHEuIZHc0bZHAls0sZPrb8iRVkEkM0BR
         I28TlQ1tUc0FRZSpp4VZtjokmPL8gab5ynRs+9q+b2zGBevkgHXxo3FQ0RWsbj7BMOK5
         5xI38d+RS4TcL7jNkJBZf8jswSg4G2bajA+TmQiQ2EqwyeFlIdrVEATimXO/v+jmvfEJ
         1BCazO1DRd8B+NTvaKJ6fRWiSVnhcm1ZnFidZl/aBUxtA4/xEcZGyKfN/bW0nRigfCgh
         AaUeJoIOW2/liGJaJZc9u+s9mnyrFMla3WV0smh93ipOm5G/2Itw/rxnikQgmQ6gqa00
         GvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410444; x=1781015244;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2AzHCCZdh7j2BBDmmO5WAtLEfltvQL21ELilOv+mRsY=;
        b=RHLeJzeO95nqOC/9WBQDij5PN7CYCly6pTAcdLeHEpcCEmbtbhVSzBIFQvscEO0sqt
         PKxtNJIAWe4EDAblJLOhP4XW7cRM2zNZR/Cd6CpDnjOrnlp32U241LsAL4wiha3Wd56c
         l1oBZTicaHopQfw2cOPkCm0q496f+kSQBkxQXOR/AAPl1PhO7UEqxrkWEuA74D2Cq8k0
         PciVrxeeir+wMaafuaeVA6Sf95dCZxmuYl/BurLEFxKJoEgoB7EY2qECxMZpwbuLlJYI
         ugA1yPoOlvdK1zmtNmNpATRELDq/dsfmsBWutU6K9Ut3hf3KNkmTLGQaRROA9cUkXL+l
         EYog==
X-Forwarded-Encrypted: i=1; AFNElJ/eX/xwaxXI+B1QU4/plO1qUb5J0hN1EdHIW384o+vsAgZN+bzzLTCVwnSMehfYjXgSBo8dosmq/jWcCqjKeAAC@vger.kernel.org
X-Gm-Message-State: AOJu0YxnytK6Nmokld+5foEPT2iv2u3vEFFosDVZ7QzSda9B+MQC3y1r
	WmQt8b/lJB5b6QGHqe57ktJU+LDK87aMXdiIjyLP5aXVasCAVzPasn5HnBhDuVx0IsE=
X-Gm-Gg: Acq92OHAC/fJraJr6YlqLySTXoDD0Bat0Zau7lPEnIGLQa73M9q4NlC6KivwDsIUWVK
	Q82tIbDbdHzsrQVCuwe7gK87RTdA4MD5svR1IrJXDKKxQXATvK6yN2bae+JIqxvyLqjNFYl0KZg
	233wE7eDiNlwC9yDQlZfdp0PPWDvCq26nSAxb3ao6G8zsZYwlPyZ9qzL7aNaj0xY420TZX1Dz9s
	rgFjRf2N7GDd4sbuUDbM4gpzUqNYGPBOFFvsX5azUdMO6qPREaOLM9/jOtieIYOfW/CKsnRT88c
	LnXaw35YBa1d+0x8SmT7AxJ/1YiGTcegoYWQ0NwnWOIEJxukvnbQ/pxu+lPC85YCeMfZDNEd8Ur
	uXQRedV2lgOsLjdNWbhfaJe2JcyQ/3xdaeDbdjR5G1/yWxovZyEol1lUh3QnhTRM3v18IGJcXxW
	tW1qnVBK09gI8u9ltcsxGTs/aT0XvCytpOEdisAt7soPA=
X-Received: by 2002:a05:600c:8b57:b0:490:3c15:7146 with SMTP id 5b1f17b1804b1-490a5013670mr251592175e9.19.1780410443909;
        Tue, 02 Jun 2026 07:27:23 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e18e1csm66771965e9.4.2026.06.02.07.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:27:23 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 02 Jun 2026 15:26:45 +0100
Subject: [PATCH v2 03/18] perf test: Add a workload that forces context
 switches
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-james-cs-context-tracking-fix-v2-3-85b5ce6f55c6@linaro.org>
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

This workload launches two processes that block when reading and writing
to each other forcing the other process to be scheduled for each
read/write pair.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/Documentation/perf-test.txt           |  7 +-
 tools/perf/tests/builtin-test.c                  |  1 +
 tools/perf/tests/tests.h                         |  1 +
 tools/perf/tests/workloads/Build                 |  1 +
 tools/perf/tests/workloads/context_switch_loop.c | 95 ++++++++++++++++++++++++
 5 files changed, 102 insertions(+), 3 deletions(-)

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
index d5df3efdce3b..1057ee836c30 100644
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
index 000000000000..73bfcaeff5b0
--- /dev/null
+++ b/tools/perf/tests/workloads/context_switch_loop.c
@@ -0,0 +1,95 @@
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
+		exit(0);
+	}
+
+	prctl(PR_SET_NAME, "proc2", 0, 0, 0);
+	context_switch_loop_proc2(a_to_b[0], b_to_a[1]);
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

