Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A140B2E6CB2
	for <linux-perf-users@vger.kernel.org>; Sat, 10 Jan 2026 08:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768033638; cv=none; b=QIGU7mVNuhBoW6h0ERHW4aEORKARX9M+wXqLQ7TXaWb+KOksg46C76PR0hkph2LMuZRWSmw9MaOJRhklPkjWKpM+f58tW+kJGVL28PVphO22ux6VKUTmU+L0wfJsnizuVzVdZeD0A7Y08AduT+g+oLGoQQfcfQw41wrSYaUCWds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768033638; c=relaxed/simple;
	bh=uzEtsFy0IeVG96C7cTzkE8RkZxzyVZ3pUWgMlhMyoDA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=fHLZE1M2WembdTLKt6wPxaShydKdQz8a6uFN+nOlIhnLg7ISYmO4ydNptyEQEul+sNbSJ0m0JNsB6gYlhr4+rz/7iDMCZjmjXzLgz2QI7LkhCMrLkTB6lQ4SlTqp+WUL4fPGyX8ds6RHQgfSEEzYyfqeqHRt1pwHMppn2J02v2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VT6mYFS+; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VT6mYFS+"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ac39bd5501so4067007eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 10 Jan 2026 00:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768033632; x=1768638432; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ocxcW+CrbKRyA7dscXnknw+e+BoFyfbyTfcxor6PA9I=;
        b=VT6mYFS+VkI9t3NeXIAtZqs1P6oOZDla7AqVGhUnXhTjeUPuI94SfqIWFaUJr7qnf9
         mtqeYAMHPonTNPa0KJx2dmsL+Jxkv8iIZfCi0i8NFLRGt36Ax4KQ8mhEhde6K7V0fN3s
         xPSUke9+2A7v8cCRFuiZ3ni+TuG8CHB6igoDa/WFnBBS4DeHsDg1rKY2CKodelg5on/s
         Rpf8lPr9U3UemNo5tFifrCCFakOMe+DoW6o5jqSsqsHjczaRPODXb7KWnAK3AQ6fkPR0
         N77Ial3do99UPH0clggfacUvEp7MQCa88UBovteoG5yWX3opRYCvha98fH02OD3GUgG3
         Psbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768033632; x=1768638432;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ocxcW+CrbKRyA7dscXnknw+e+BoFyfbyTfcxor6PA9I=;
        b=IeZ8xgq1hOc7Dm6wloSTEYeqPzzLFneLYSQNTSLGCMG3atR5/ykDiH29B7ZSyTBCtt
         adxOEk3rxG1rcGe2hRnMQcCF4qk3OJzEY5rqU666UAWtCumqPZXWbJ0oJlQeNP03/u6r
         eb2fuINb+EcNgTll6MhLt2GU1USokfpoA3Cy8bvu7VatiqFnDDO2xVhDjWvLMddhUmCf
         lFsd7zhUVJH40/b3y/ekT6NriwFVSZQ7a+p7PEvuC95eWvbx8kwe9v3BJO4jp5J5IP0Z
         LsBSmard45VeSh139j3DKvsQ91PdBV3gF2n+vZHlVQzp7Zc8P6ywV0Pj5iCZ7NGaqQ+b
         jHMA==
X-Forwarded-Encrypted: i=1; AJvYcCVfQrzHv1DdXTQGGiWN4zDM0JpjahHR0pjdWb3BG/zQMeyE27WHKocmU0Ehi0GszGlMG6OKhTFx5n8p0qnYDUg+@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ8m61dDn9G9vv2bRcO42SoU/2J1OmXUCv8wMmcoAU5+9etteU
	mMnMW3W7UGaIJ4bUEVOEBGULCmKzxLxSEB3C5TcGSziZMwTz2b87dcdYVMxZJZkeFsAJ+ycspZW
	+daUBy2PbDg==
X-Google-Smtp-Source: AGHT+IF/uSZnbAdG0hb8q5tKkUv66JlQFX3QvHJ00VWJpoNrjcX+WjJPQg1r+i/rrgsWoKQm2wMVsQqMfIVg
X-Received: from dlbur8-n1.prod.google.com ([2002:a05:7022:ea48:10b0:121:766b:11e4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4590:b0:11b:a36d:a7f7
 with SMTP id a92af1059eb24-121f8b15e40mr10204622c88.16.1768033631646; Sat, 10
 Jan 2026 00:27:11 -0800 (PST)
Date: Sat, 10 Jan 2026 00:26:46 -0800
In-Reply-To: <20260110082647.1487574-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260110082647.1487574-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260110082647.1487574-6-irogers@google.com>
Subject: [PATCH v2 5/6] perf test workload: Add inlineloop test workload
From: Ian Rogers <irogers@google.com>
To: Tony Jones <tonyj@suse.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The purpose of this workload is to gather samples in an inlined
function. This can be used to test whether inlined addr2line works
correctly.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c         |  1 +
 tools/perf/tests/tests.h                |  1 +
 tools/perf/tests/workloads/Build        |  2 +
 tools/perf/tests/workloads/inlineloop.c | 52 +++++++++++++++++++++++++
 4 files changed, 56 insertions(+)
 create mode 100644 tools/perf/tests/workloads/inlineloop.c

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index bd6ffa8e4578..e2490652f030 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -153,6 +153,7 @@ static struct test_workload *workloads[] = {
 	&workload__datasym,
 	&workload__landlock,
 	&workload__traploop,
+	&workload__inlineloop,
 };
 
 #define workloads__for_each(workload) \
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index cb67ddbd0375..1f0f8b267fb1 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -240,6 +240,7 @@ DECLARE_WORKLOAD(brstack);
 DECLARE_WORKLOAD(datasym);
 DECLARE_WORKLOAD(landlock);
 DECLARE_WORKLOAD(traploop);
+DECLARE_WORKLOAD(inlineloop);
 
 extern const char *dso_to_test;
 extern const char *test_objdump_path;
diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index fb1012cc4fc3..866a00bd14a0 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -8,9 +8,11 @@ perf-test-y += brstack.o
 perf-test-y += datasym.o
 perf-test-y += landlock.o
 perf-test-y += traploop.o
+perf-test-y += inlineloop.o
 
 CFLAGS_sqrtloop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer -U_FORTIFY_SOURCE
 CFLAGS_brstack.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_datasym.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_traploop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
+CFLAGS_inlineloop.o       = -g -O2
diff --git a/tools/perf/tests/workloads/inlineloop.c b/tools/perf/tests/workloads/inlineloop.c
new file mode 100644
index 000000000000..bc82dfc7c410
--- /dev/null
+++ b/tools/perf/tests/workloads/inlineloop.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <pthread.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <unistd.h>
+#include <linux/compiler.h>
+#include "../tests.h"
+
+static volatile int a;
+static volatile sig_atomic_t done;
+
+static void sighandler(int sig __maybe_unused)
+{
+	done = 1;
+}
+
+static inline void __attribute__((always_inline)) leaf(int b)
+{
+again:
+	a += b;
+	if (!done)
+		goto again;
+}
+
+static inline void __attribute__((always_inline)) middle(int b)
+{
+	leaf(b);
+}
+
+static noinline void parent(int b)
+{
+	middle(b);
+}
+
+static int inlineloop(int argc, const char **argv)
+{
+	int sec = 1;
+
+	pthread_setname_np(pthread_self(), "perf-inlineloop");
+	if (argc > 0)
+		sec = atoi(argv[0]);
+
+	signal(SIGINT, sighandler);
+	signal(SIGALRM, sighandler);
+	alarm(sec);
+
+	parent(sec);
+
+	return 0;
+}
+
+DEFINE_WORKLOAD(inlineloop);
-- 
2.52.0.457.g6b5491de43-goog

