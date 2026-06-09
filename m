Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE2234C981
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015484; cv=none; b=SwFWm5qPPEAXFHGgGCZ2k1/q5vIpjooLVL4Vv8EYIlJgd7WhqJ1vWIDmsIBMJ0D3A28kwCBMAFO/ON1t/vTSlYbIG6guNLSPIMIAfid02sEJztwz+iFtc1ercSnu01gB1p+yKcOh9MLSmjmTgt9gh1xcBr26jSto18a9o28/hgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015484; c=relaxed/simple;
	bh=MpqHY1226EZDlsL7AYrF9I24rCLFkLMgGMHa7jjWFqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N9HTCTRxpyEY2vrinQZ0LZdYCEM7WnRbCMHVKu1IsaamjXk1wWKFnm5Ey9Qar2OsOvhELNhSUNA/G59lSn2zeA1vgkFi4xAe/46Tx1UXpw74D1ZEf90ZCaZ0aUfATwKj0rQL6u8TiRl7bQJF51UxR+NJMjVDKnx8gc5Aci6tWfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZP/NePNW; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZP/NePNW"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4600ddc4017so3954585f8f.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 07:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781015480; x=1781620280; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9nUZrv+uXShy5oUjVbWJnHpZlIUPoN1ZejbvjYmlEBM=;
        b=ZP/NePNWLMRI/JPOMSuM6zmRGaAVXu+Z2MAJlyCzQbeD8x8YOeM2tO1kZaT8iCNBi9
         GfmD/1dG5zYsMCFTk4n+MoCiIPezZKoajOFmxu53311PQeqYLQgpvlPKVw27gsLE0plE
         DQM4dQLsZQeREo76JnWlmhRDL2rUXkFau+WN9/TpD//YyWOBDrKgR7sdgIgBDlktUVoN
         gE7hxlwaK0gngXqNFc2u6v7z6Od42B9TaajfTuXtf2aejbbSPdIj4rNe2F4VdZg+fX19
         4/HBROThrhabT/eUD0vMRD/QMvZtGGA9JvPmOzFUTrYSCKan7C23XAuJm5HYTy6OjwAq
         93Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015480; x=1781620280;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9nUZrv+uXShy5oUjVbWJnHpZlIUPoN1ZejbvjYmlEBM=;
        b=fYKCJBV1aP8tGk5i8T3rGOWrAb1AGV6N1UXXjOzu6if6LlxEboMZk+bzLo7h/r+npx
         8tc23EbHz/bmQbQ781ygO1FuNb+0ZC3PqoChqzHoE/MoYp9Wo545E9NfDmdUd5xDyb7G
         lc/kWvUDYoiL3Seu0mf/bYB7YEj9wK3JFtsmavrfdIC9xm5mkKCYz1bsHijn/qQO/wca
         Pr3M0rr8b2xEg1EyjCeEnUc3bcQmkEvkwEHNZEGHc+BTLhOY5rDGHZMhjAf4DT7uxJCU
         tv5tRC0pGoCSsqYJ619yseRls8l7/oe030eBNFGkWJB/dGgwTkUji41cqfilM/fFNCMa
         BE7A==
X-Forwarded-Encrypted: i=1; AFNElJ/tghs9TYqveHuJkofQ4C8NEK61PEtuM1X/h2+fFqACrDwhTd+Qyof3f5GFt2WrtEgzMRUc6Vr+kkNQPt8VUaTq@vger.kernel.org
X-Gm-Message-State: AOJu0YxdkIcxW9p9xRbN+E/kJ4bp5EaUW8QPNY4+nMMpjCZ5ynHtb3g8
	gjRmwC8y7TUSEgg9vXZaBfGoWJFlvG29PNHnVqSX6d0EAW0kjexOdHWVPvdZ1v6joi0jljkT68n
	/iKEn7hI=
X-Gm-Gg: Acq92OFckZ1Le5DCUCevHhry5la6RQA8RlCz2955OMIWrR4QH04mfuLf0jLry7Xkg/G
	z17DaejqMgV0HUDel+6jhrkipCc7p0CYinoHmv5e1ksLxo3KwaWDZweryJS7Qiofl5BFJlpRhbV
	bEDy8l6s4uNvbXnfCEZy5PI0tnK22sRvSsB0RZDHPfoA3mTA7WEBfsiKzmfElcAM7G3D3oAJkf8
	EEkE3ucRwm8q1TVgf15VRogy7CozCV1sz/qMqDGpbVby1nTYgHeXIN7+LwQKa5n9woP7zUsMmV3
	LfllEi8iW79Jmu7p2EzaH9lHbJinvhCgiINBALaB9o51b+b91nJ//ToEIu0jftKJdx+XotWNYMG
	inJBogiCbwAW1TFT9q45TWQL43eD/K08jzX/OV9OLccu3FP0WbYDzmkON3rYUOFy+vz4Bh7R14G
	xbftn+2hsXnvauxIt3txKMRBBdOhcgYNol06ACnBrn/Qg=
X-Received: by 2002:adf:e30e:0:b0:460:1233:ecf2 with SMTP id ffacd0b85a97d-46030609798mr24080728f8f.30.1781015480385;
        Tue, 09 Jun 2026 07:31:20 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3444fesm62738388f8f.20.2026.06.09.07.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:31:19 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 09 Jun 2026 15:30:56 +0100
Subject: [PATCH v4 03/19] perf test: Add a workload that forces context
 switches
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-james-cs-context-tracking-fix-v4-3-44f9fb9e5c42@linaro.org>
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

