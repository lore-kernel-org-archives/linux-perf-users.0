Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E9221C194
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 01:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762738390; cv=none; b=R2lVgMqMS9lm1fUvAqZiYGmwJ8MA2yoGSaozwiHJQG9kmjgTgjpUXxmgYJLuqmDi9hv3jnJ0Y0dHICJCr2+49MAPLwWQhcTpYgDAQ+F7szB4zQrTUJcJAyweVGMUi7NED+SMDqf0xdmpsAHKVbsGLL5l7xjTcNWMFAahvDxBnMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762738390; c=relaxed/simple;
	bh=AX4zMck4hJ8CekkhoIGM9prEjuQFEeMORcOKF9pOIrA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=lgoo7m9YISNKjOaJ4bEYEZ8C348bE5JQNGAWijPy877MggsRSKPcL2ZLOspPo3qA8it2vN5GX28WtJBF52jjapgJD9tdRqMXBqX5tCaLjRWdohkzV8r2mhik3KxuoejNvM9hL/AtyHnQhEx56Ur1wUhwN/A09X/nF4u6UsI14oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i51VBkJf; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i51VBkJf"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b969f3f5c13so2360758a12.0
        for <linux-perf-users@vger.kernel.org>; Sun, 09 Nov 2025 17:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762738388; x=1763343188; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pSEYPQKRqvkubRMw5YfRHz+OHOI6nD8jZSkaptJ6Ozg=;
        b=i51VBkJfJYICAwgJDqyBpWrTHTgYpB5LKFrq8AKkxz8HVdkP3vhVz9yt2i2oJNJNXa
         bckjpTWIPW0z8sMbQD7TzYnrXoE+HJct39njQTBXpr8h3A76XUvfUoCQt7JTMiR/cRt2
         LOCwkjgW5mqzCWnRura6vRQMD7FhbN4IyRC+07U0ifTgQrEkSowH181fi3fjgBE3lVLq
         REyXfEydu4ZKx3N/6p8KDEVevXXM+DMCz8J75NElrUwiPNy5dGelVZ1MpFHXGM8EHWrq
         TPGZKLAlXvyML4k6+NWrBMt/kKtDBZ+/0p1GDZcc/cJttutaR1DD100k+ERIMgEzk3um
         81YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762738388; x=1763343188;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pSEYPQKRqvkubRMw5YfRHz+OHOI6nD8jZSkaptJ6Ozg=;
        b=O0AJ73URBbZWJlwQH004RpSQHEeem0rbubcrg0tn4k2mCa7e+IYbQiEo9s58TQUACF
         NG39ei9bfAPlGjyvOyi51HnmR6cQQu+618b407TT1vRYvX14iBB+Yr6N1J/t4TvOy074
         /8Pn2GM3sJC2OkA9W1GYsT1pSXtmUSH13NtbI6gJBdRptRzwO4XVaFXd3nDxzniN8Vks
         8H7FoAa0dtCmTPDL+NIzp4hZfN5PwUaKlRjcizpH4nlkd4sHM+jqyV2MKtLK4QT/6GCj
         yq30jBdN4MG3pAfWshSDe1tsGkYZ6ZpDEhQQm1VVTuEF+8k1QmVGJGYwL6tnjCBPXcbk
         eKUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0Xgx5WkLr98fYep5YHz8kZH35jyCvWp0m1uzR5RvUDWIKfb3DfLgTDWn+TXloUMqGeEav21abQ2473xAWq0q9@vger.kernel.org
X-Gm-Message-State: AOJu0YxDRO94zz1U1Ve0FbZ6zFrk+vUbZfQvhQDWD9FyJhT7zmY0uFfk
	HddtCzvcjFQuiX3GCSIT6y10TtsVzRkeNqfrCR9+bWqmvuhMeCbzlVZ4ydAoWFGB4+q6F7r9+yb
	ilQ6ET4ycuA==
X-Google-Smtp-Source: AGHT+IEsioVmpfAvAsJ243BW96Rxy80dTUlatEny8pA+pQJ/dH5U12GBogPLq/rlz9xJNcJ4bBYqrILf/NB/
X-Received: from plii20.prod.google.com ([2002:a17:902:eb54:b0:269:770b:9520])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f601:b0:295:3584:1bbd
 with SMTP id d9443c01a7336-297e56ca193mr86932355ad.41.1762738388100; Sun, 09
 Nov 2025 17:33:08 -0800 (PST)
Date: Sun,  9 Nov 2025 17:31:50 -0800
In-Reply-To: <20251110013152.3099080-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110013152.3099080-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251110013152.3099080-4-irogers@google.com>
Subject: [PATCH v1 3/5] tool build: Remove __get_cpuid feature test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Tomas Glozar <tglozar@redhat.com>, 
	Quentin Monnet <qmo@kernel.org>, Yuzhuo Jing <yuzhuo@google.com>, Blake Jones <blakejones@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Yeoreum Yun <yeoreum.yun@arm.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Collin Funk <collin.funk1@gmail.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Zecheng Li <zecheng@google.com>, tanze <tanze@kylinos.cn>, 
	Gabriele Monaco <gmonaco@redhat.com>, GuoHan Zhao <zhaoguohan@kylinos.cn>, 
	Markus Elfring <Markus.Elfring@web.de>, Colin Ian King <colin.i.king@gmail.com>, 
	Kan Liang <kan.liang@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This feature test is no longer used so remove.

The function tested by the feature test is used in:
tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
however, the Makefile just assumes the presence of the function and
doesn't perform a build feature test for it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature         | 2 --
 tools/build/feature/Makefile         | 4 ----
 tools/build/feature/test-all.c       | 5 -----
 tools/build/feature/test-get_cpuid.c | 8 --------
 4 files changed, 19 deletions(-)
 delete mode 100644 tools/build/feature/test-get_cpuid.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 32bbe29fe5f6..fc6abe369f73 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -90,7 +90,6 @@ FEATURE_TESTS_BASIC :=                  \
         timerfd                         \
         zlib                            \
         lzma                            \
-        get_cpuid                       \
         bpf                             \
         scandirat			\
         sched_getcpu			\
@@ -146,7 +145,6 @@ FEATURE_DISPLAY ?=              \
          llvm-perf              \
          zlib                   \
          lzma                   \
-         get_cpuid              \
          bpf			\
          libaio			\
          libzstd
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 49b0add392b1..7c90e0d0157a 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -56,7 +56,6 @@ FILES=                                          \
          test-lzma.bin                          \
          test-bpf.bin                           \
          test-libbpf.bin                        \
-         test-get_cpuid.bin                     \
          test-sdt.bin                           \
          test-cxx.bin                           \
          test-gettid.bin			\
@@ -318,9 +317,6 @@ $(OUTPUT)test-zlib.bin:
 $(OUTPUT)test-lzma.bin:
 	$(BUILD) -llzma
 
-$(OUTPUT)test-get_cpuid.bin:
-	$(BUILD)
-
 $(OUTPUT)test-bpf.bin:
 	$(BUILD)
 
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 8a354b81417c..eb346160d0ba 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -114,10 +114,6 @@
 # include "test-lzma.c"
 #undef main
 
-#define main main_test_get_cpuid
-# include "test-get_cpuid.c"
-#undef main
-
 #define main main_test_bpf
 # include "test-bpf.c"
 #undef main
@@ -168,7 +164,6 @@ int main(int argc, char *argv[])
 	main_test_pthread_attr_setaffinity_np();
 	main_test_pthread_barrier();
 	main_test_lzma();
-	main_test_get_cpuid();
 	main_test_bpf();
 	main_test_scandirat();
 	main_test_sched_getcpu();
diff --git a/tools/build/feature/test-get_cpuid.c b/tools/build/feature/test-get_cpuid.c
deleted file mode 100644
index bb4f065f28a6..000000000000
--- a/tools/build/feature/test-get_cpuid.c
+++ /dev/null
@@ -1,8 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <cpuid.h>
-
-int main(void)
-{
-	unsigned int eax = 0, ebx = 0, ecx = 0, edx = 0;
-	return __get_cpuid(0x15, &eax, &ebx, &ecx, &edx);
-}
-- 
2.51.2.1041.gc1ab5b90ca-goog

