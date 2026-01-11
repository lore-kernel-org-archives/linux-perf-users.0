Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8542F21D59B
	for <linux-perf-users@vger.kernel.org>; Sun, 11 Jan 2026 04:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768104842; cv=none; b=ngGfFAQN0bcTPG1ikGOpTdZKpBOLWN0CE7N181WKOYU5y1PtK1MbGi27JWfJYJskInkDVnig3dGL8VahYseSDJcUhjMB1fNRxn5u96Jg7oU1jaT4WZlgtffRLojoex8gP/cULKBDVOHDgJfmWACBm6g3/zsjpAj4guYQhbwNWbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768104842; c=relaxed/simple;
	bh=uzEtsFy0IeVG96C7cTzkE8RkZxzyVZ3pUWgMlhMyoDA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=biI17rN45bQ9SgSLBWwJyrpxMNnv0rW5ii4PC0STQ6c7KU410pAQlCgx0X4o+CfRoVZH7uTpHqWuM9Tb5rvNo8wO3fmmR4GrOO9OWJ45LThSaZ4Kyzxf9zlBIX7yQB/qCcYQtZ3LaTroQwI68d1P12vRfV2QtsozhP0c7RbLWSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TGBkBJFd; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TGBkBJFd"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-11b9786fb51so587747c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 10 Jan 2026 20:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768104835; x=1768709635; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ocxcW+CrbKRyA7dscXnknw+e+BoFyfbyTfcxor6PA9I=;
        b=TGBkBJFdxrBFu+92SS/tX4RKMwD/i/W4i0pbuqFpVkt/QAhrM+xiOvKw+TDsM8y13A
         izKHGreNyd4/3r6ScsEn4pca8bvAjHQBp2ulyH0G414jJQVkGX9BERMlsRw89wTK6nmn
         p0qgSOIBbtXNPtjNrqWXFTINUOoiKG2kxtdXL1fdri/TnMOhxdOVid3moCSZSd5PPWbd
         imaQtGeTmbAAi5zVS2H7rle2WPez2GMdXKbCBxq9+ceTcrX87Lh+4TVAOLZL9tth2i9W
         KWGVvnduN935gwqFYRYpbnFERs13922i10HbiF3U6SSDH6nkknmp0jN6V1OlAwAAMUMF
         aVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768104835; x=1768709635;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ocxcW+CrbKRyA7dscXnknw+e+BoFyfbyTfcxor6PA9I=;
        b=f4gu8zW8dgxN44ESwlQAHYkvW8rlb9PKUbF47Qp2IHL3hbRLPx8HKYWk/+xB9PmQgg
         erAKV8UasZnesPs1rpTUB4lz2YxOdfiiiUgedsgjSLi5HqZzONtS8bgxqf6EU0B08zTD
         D6li5w0DPeCNqSl5+QawJJIWKcMr7LIFmHb9plQKIIDm/7rJwL6VND0oASa/ZvQfEMEV
         xlfqo6qvX2KA9+k0Su76jSYN/ib8Yq+ms1LiwXalvfQrsJVbWKNNbF9YagY1W4uDBZiw
         NFXOjgTOwtDkJ+qhzk+6rNlhBvBQyKeiOu6CoKtcmN9XSe7jdbJLj8uWVqQ5lzYEcYTG
         LYdg==
X-Forwarded-Encrypted: i=1; AJvYcCUvURqQgSR7+2coawP3CyA0i6BGFsbTXCQ09HWKCzSLNyrcwKLREi/vvh0gI5rA2syr64Vsir2vD5ineoCln9BC@vger.kernel.org
X-Gm-Message-State: AOJu0YzTB+HLCQwGbxj0jIFa5vwGfivSJTmLf1Aj+jNBYjE1/ajRAIug
	8uNly60FNGnyf0BX5yRTaR3vxVFQW77On5/tZBriB77NaOSvM3YZVvrKSgYxmpGyXMIS1hSLQzu
	2YrEzZKkJSw==
X-Google-Smtp-Source: AGHT+IHtQ5dHNzSN22wy2BFoSUc/G0rGe/XCGDJa1Gk7SFJy76Ug5vah4X2Q+c0F0Mhtu0OSHWM5rSiq9z7N
X-Received: from dlbeg28.prod.google.com ([2002:a05:7022:f9c:b0:11f:3ccd:73d7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:305:b0:121:9f05:7e4c
 with SMTP id a92af1059eb24-121f8ae6090mr13455768c88.16.1768104835073; Sat, 10
 Jan 2026 20:13:55 -0800 (PST)
Date: Sat, 10 Jan 2026 20:13:37 -0800
In-Reply-To: <20260111041338.1817056-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260111041338.1817056-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260111041338.1817056-7-irogers@google.com>
Subject: [PATCH v3 6/7] perf test workload: Add inlineloop test workload
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

