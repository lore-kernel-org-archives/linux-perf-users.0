Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568422F0682
	for <linux-perf-users@vger.kernel.org>; Wed, 13 Aug 2025 13:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092360; cv=none; b=dUtO9iqlHVhd+V4dJh+EC5UE6VGg8mtZact3JfdX36UFJwG/KR6W6HF53CC0Tx2SzhzhHBH7NjFmAEaWze4P4s15+PBp1oldTAQ7uh5gdTUKmnIxQy6kW9ePuV0jUS8p0MEo/oj5TVUlpprCyngDVbwaUb6zE4QZP4c1cDvA9mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092360; c=relaxed/simple;
	bh=Cj09as8AhkwGyMZb6hqGsQUOrGvO1cZWnTecDA9y7WQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KUhyR1nzGTdphGQWWlV8ArQA3yIkRKLRNa6+4yK/wLJix98Oqmh45D9ngpbPuRbYkjhfEzxq3v+h3tnUGUF9AkZULNd9DQkH5B44OaWVCGV+c/+r7vPWCN63G8lDGEps/cZ+tDy2oRgIuzqQSQ5h8Zq2l3sG/hAfna+psNe5UQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OoUmWnmP; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OoUmWnmP"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-458bf6d69e4so59508375e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Aug 2025 06:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755092356; x=1755697156; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7YfMIUKfALfBR+AjJWVdhiJltI5m6xsjP1Rg9Wv99io=;
        b=OoUmWnmPt2OeiYtukJhE1JibUoZ40bp0uqkGHOM5zYyXsTBz8cv89JNbM3UIGHwAKh
         OaenMwXGYx337oq5AeEg/4BcUiXd//4q+WPGevOgD3mYwj+nCaObwOLP9jEwK18zw6LO
         IDrHu2hXgzcMuCaSPBuP0RVbrlJ/a4CFGpvWRSrANjm7ILRKcjfkQ1WOCY00AwiqbRQ8
         Jk4By09NPde/UdCGurY0Wyuc4vohOYXdQSHxJu9ZvhC0PmWng/U9qCwL6/XVDclzkwaR
         dEes6lHOflt9GytDauonHmkdPE+e8iDXf1WWjqAqPAwE+qDpFkqkovO40RkZESlvtE0K
         gO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755092356; x=1755697156;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YfMIUKfALfBR+AjJWVdhiJltI5m6xsjP1Rg9Wv99io=;
        b=vfWxClfF1gHPY70Ioe1S3H21OU7iI/BzomQXvTTnrAwE/DRu5JoUDVf81DgfxZV9S6
         IVUTEQUUBpIIWhdejFugPdM8OlHDz8pRFUNXkJNCzq5eZQlOY4VgnwP8xffQ8FYjwj9j
         0L+y5DMci+7OrBHr8sBUiWsI3D8mRnc8yrYu1V8q/qMIAyXRZZ4CJsDhhljaRU7CimhO
         QOTuBn1lMg3gm1UNDId4/3gGt1O1czukgk1WCvTi0DWw9BcWEIxu4GeCsnLYklBwWxQk
         PG3ZC1frt6EV0nBtmlWGz/rnuyC1qYYaKt4wfwCgX0/NFCfqHlwf+XhkUdrJS/Jvx5Cp
         kA5A==
X-Gm-Message-State: AOJu0YzUQxMg1XGlNZUV3XGCemiLaiMspa75CrKcXRx4JiYOH7qe3bXD
	WmR3cIR5qJTgMn5xMK7gSblqsAHiUUog8J4jsNKLmF6OIFNvOzRM7irJcxcexoANG8c=
X-Gm-Gg: ASbGncv/80c6NXGDJ3y20eEcjkuLhAAUJQLKVGvOfjhDm6Ky5+Y7L+TcHEAD91G9zum
	6ObXwXcDTtKGP8ZpQCr0ADZ6NFrq1E5Im2abCZ3Pyw2QRlIzvkDyNnbK4u76f0ZoKNAUy4+OduD
	kgoTobroDe6DAlahLMvi+MvhsE+zqQAPSqC+fTSI3wwEJLotCjB58PBR7G9ZMWCCPuxZzxaR59U
	X8AgUAvYS46eehPcmC1bUflOvMR8+rpBono29P5nf7Q+49h9+ad82CO758AmyxFw9bUNNowefFU
	Z2AntT7Q7yg5HlJh5iGejOfc566DCI0thMwODlRIvtxniIomsr81hNXE0UissjA4xxYGQWFGEkQ
	JTc6lyhhXxK+Zn+DxkAvdXCA2olAw9OE=
X-Google-Smtp-Source: AGHT+IFCJ2V2UElphjXDu+KrovoN3PMnal4w2lEqDYxhJn5SbJZNtsKOGhd80c4dDIQ4M/2sKAthzw==
X-Received: by 2002:a05:600c:4750:b0:440:6a1a:d89f with SMTP id 5b1f17b1804b1-45a165b7b22mr32839765e9.4.1755092356447;
        Wed, 13 Aug 2025 06:39:16 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1a596280sm2559145e9.28.2025.08.13.06.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:39:16 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 13 Aug 2025 14:38:51 +0100
Subject: [PATCH 3/3] perf test: Extend branch stack sampling test for Arm64
 BRBE
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-james-brbe-test-v1-3-76a0144b73fb@linaro.org>
References: <20250813-james-brbe-test-v1-0-76a0144b73fb@linaro.org>
In-Reply-To: <20250813-james-brbe-test-v1-0-76a0144b73fb@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Mark Rutland <mark.rutland@arm.com>, "Rob Herring (Arm)" <robh@kernel.org>, 
 Adam Young <admiyo@os.amperecomputing.com>, Will Deacon <will@kernel.org>, 
 German Gomez <german.gomez@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

BRBE emits IRQ and ERET branches for branching and returning from
trapped instructions. Add a test that loops on a trapped instruction
(MRS - Read special register) for this.

Extend the expected 'any_call' branches to include FAULT_DATA and
FAULT_INST as these are emitted by BRBE.

Co-developed-by: German Gomez <german.gomez@arm.com>
Signed-off-by: German Gomez <german.gomez@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/builtin-test.c        |  1 +
 tools/perf/tests/shell/test_brstack.sh | 26 +++++++++++++++++++++++++-
 tools/perf/tests/tests.h               |  1 +
 tools/perf/tests/workloads/Build       |  2 ++
 tools/perf/tests/workloads/traploop.c  | 31 +++++++++++++++++++++++++++++++
 5 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 85142dfb3e01..8921846b3f36 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -152,6 +152,7 @@ static struct test_workload *workloads[] = {
 	&workload__brstack,
 	&workload__datasym,
 	&workload__landlock,
+	&workload__traploop,
 };
 
 #define workloads__for_each(workload) \
diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
index 252d22d39c7b..85233d435be6 100755
--- a/tools/perf/tests/shell/test_brstack.sh
+++ b/tools/perf/tests/shell/test_brstack.sh
@@ -34,6 +34,10 @@ trap_cleanup() {
 }
 trap trap_cleanup EXIT TERM INT
 
+is_arm64() {
+	[ "$(uname -m)" = "aarch64" ];
+}
+
 check_branches() {
 	if ! tr -s ' ' '\n' < "$TMPDIR/perf.script" | grep -E -m1 -q "$1"; then
 		echo "Branches missing $1"
@@ -76,9 +80,24 @@ test_user_branches() {
 		err=1
 	fi
 	# some branch types are still not being tested:
-	# IND COND_CALL COND_RET SYSRET IRQ SERROR NO_TX
+	# IND COND_CALL COND_RET SYSRET SERROR NO_TX
 }
 
+test_trap_eret_branches() {
+	echo "Testing trap & eret branches"
+	if ! is_arm64; then
+		echo "skip: not arm64"
+	else
+		perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u,k -- \
+			perf test -w traploop 1000
+		perf script -i $TMPDIR/perf.data --fields brstacksym | \
+			tr ' ' '\n' > $TMPDIR/perf.script
+
+		# BRBINF<n>.TYPE == TRAP are mapped to PERF_BR_IRQ by the BRBE driver
+		check_branches "^trap_bench\+[^ ]+/[^ ]/IRQ/"
+		check_branches "^[^ ]+/trap_bench\+[^ ]+/ERET/"
+	fi
+}
 
 test_kernel_branches() {
 	echo "Testing that k option only includes kernel source addresses"
@@ -162,9 +181,14 @@ set -e
 test_user_branches
 test_syscall
 test_kernel_branches
+test_trap_eret_branches
 
 any_call="CALL|IND_CALL|COND_CALL|SYSCALL|IRQ"
 
+if is_arm64; then
+	any_call="$any_call|FAULT_DATA|FAULT_INST"
+fi
+
 test_filter "any_call" "$any_call"
 test_filter "call"	"CALL|SYSCALL"
 test_filter "cond"	"COND"
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 97e62db8764a..cf3a14a95b67 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -239,6 +239,7 @@ DECLARE_WORKLOAD(sqrtloop);
 DECLARE_WORKLOAD(brstack);
 DECLARE_WORKLOAD(datasym);
 DECLARE_WORKLOAD(landlock);
+DECLARE_WORKLOAD(traploop);
 
 extern const char *dso_to_test;
 extern const char *test_objdump_path;
diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index 5af17206f04d..fb1012cc4fc3 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -7,8 +7,10 @@ perf-test-y += sqrtloop.o
 perf-test-y += brstack.o
 perf-test-y += datasym.o
 perf-test-y += landlock.o
+perf-test-y += traploop.o
 
 CFLAGS_sqrtloop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer -U_FORTIFY_SOURCE
 CFLAGS_brstack.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_datasym.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
+CFLAGS_traploop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
diff --git a/tools/perf/tests/workloads/traploop.c b/tools/perf/tests/workloads/traploop.c
new file mode 100644
index 000000000000..68dec399a735
--- /dev/null
+++ b/tools/perf/tests/workloads/traploop.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdlib.h>
+#include "../tests.h"
+
+#define BENCH_RUNS 999999
+
+#ifdef __aarch64__
+static void trap_bench(void)
+{
+	unsigned long val;
+
+	asm("mrs %0, ID_AA64ISAR0_EL1" : "=r" (val));   /* TRAP + ERET */
+}
+#else
+static void trap_bench(void) { }
+#endif
+
+static int traploop(int argc, const char **argv)
+{
+	int num_loops = BENCH_RUNS;
+
+	if (argc > 0)
+		num_loops = atoi(argv[0]);
+
+	for (int i = 0; i < num_loops; i++)
+		trap_bench();
+
+	return 0;
+}
+
+DEFINE_WORKLOAD(traploop);

-- 
2.34.1

