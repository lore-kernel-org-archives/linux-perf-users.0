Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8642213B2A5;
	Wed, 13 Nov 2024 00:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731457719; cv=none; b=tO8fojNRw66aGYS+reAxu1lAD6yzK32LYr8mEf/AiwmsaNf9jSJMu7XXMcKzdDj+Vo9Hb6K/X+6AYeX3BSqtGlQ7B0imKPmjF/+jBm5ASoiyrEVnekzOavpfx2rFietyQ9nVOLHrOGZVjzeRn1clBmWX1003U5cxNTejAIQTwFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731457719; c=relaxed/simple;
	bh=i38KITFoXQxHV5vC+zLrvHnE4A5s7OsP/Virq4w9OTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdxHvt8VufC3RzrZeuYvsWVWriq/VGfHX93lail5qsP0OyTiCPakmHNpx+vHxv3/3PS1EBAg4lqd5CEIeU5IEVz8cQhk0TuFFIh39fUXIR7RXFSy6nWB5P7AuKNlZVvVpoQmoKwjy8fFD/DI44jn3oBFTQ5rJOaZihAi42V9Uyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtVt8KDM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtVt8KDM"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20e6981ca77so72872785ad.2;
        Tue, 12 Nov 2024 16:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731457717; x=1732062517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghYLYuPX8XvrvfkfC7VIB18q5PzN1p3CvZzBe/JSGjo=;
        b=LtVt8KDMPn3MAcDOer1YNxjyzrIsl4wpauLPrNYMBX16K2OUtbnhDVToJX72du0BLy
         +4F3lhOVMUCNc5zoncHGieWWUOpY5+wz7g/Q70Vn3/Q5xzi8yoNM0elJ4h9GIXvbslIg
         qLgZgSdB+6EgN6VTubjA+efJs0oQpBHGNz31dib1ksD6XjqsA6nnROxt1tbqX/Rup33/
         dSJhaptgTPGUG0rEBohyayMM9rCghCyGrQpp+eDQmvGC4hA8kvym4RdyN3g5wnjlyCrh
         wrThxnLg2byV2fi0wmFvmjNU6bT5N16BDod9ktFpW06p3esFcPLkzv20IMANkx67cc2W
         pCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731457717; x=1732062517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ghYLYuPX8XvrvfkfC7VIB18q5PzN1p3CvZzBe/JSGjo=;
        b=ZTgb12M1Kcq31T3KW7QEhwf5yerib0gAUo11xubTAshbftq1dLe12x7QIgHZpojkOW
         U8r0GJwGgFog7fZm4rCRwQajd1GW1A7T/vUDxeTyHU9ef4yBib9euttxF/z0hA2S8CJU
         9/gzWB+GkFpghY/XJQD+jyE/4WNGI0+OcDndWQSCC3YahWxQw4u9Pcz7PDkiVa7SUtYm
         6fmknKYc+yJdU+eSG0US0wMV1fE/qfkBEZBoy13EzKPtRBBdk0W31olAGHpNal307P/d
         ZITzArCBXcbTpZghuKkNPqXfok8ud2DORl0qr9G7ih/MJ1sea4+DR8EcqDkKDhpcIq+X
         Duyg==
X-Forwarded-Encrypted: i=1; AJvYcCUKeNzReF+VKfmFyQjvBTT2oAqv7T0t8D6xqRimH/SYGJhmmq5J0IBubMgthgt2l+EJ1UEYTYyikQBxfHgoPsJJhA==@vger.kernel.org, AJvYcCXlMnRTe33uSVsTDcaMUkbv4H4xMY+uUhDrHKd8/Xx4zY+dmmv8/mbpI9VoqpHHBBZEN7lpdrOw0AXPMWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7GssVpwTavbMq4ADnjIccHuQ8Pfd8RwsAELFOzrttbCAn9jd8
	ZJDzDuZucwaUE3XSfjGaPt9DeRemZ6M63sOgihw4O0e2NlXVS0Vh
X-Google-Smtp-Source: AGHT+IFlIs8DtmqJHA1/pZmtXpdKQvE3IgCCH7jggV6P9t/wXULHezqSkIGXqItGieSsloamXvfLCg==
X-Received: by 2002:a17:903:2282:b0:20e:552c:53ee with SMTP id d9443c01a7336-211b5c884acmr11159055ad.24.1731457716874;
        Tue, 12 Nov 2024 16:28:36 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e458bdsm100158425ad.133.2024.11.12.16.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 16:28:36 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org,
	peterz@infradead.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mingo@redhat.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v8 10/10] perf test: Add direct off-cpu test
Date: Tue, 12 Nov 2024 16:28:18 -0800
Message-ID: <20241113002818.3578645-11-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241113002818.3578645-1-howardchu95@gmail.com>
References: <20241113002818.3578645-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Why is there a --off-cpu-thresh 2000000?

We collect an off-cpu period __ONLY ONCE__, either in direct sample form,
or in accumulated form (in BPF stack trace map).

If I don't add --off-cpu-thresh 200000, the sample in the original test
goes into the ring buffer instead of the BPF stack trace map.

Additionally, when using -e dummy, the ring buffer is not open, causing
us to lose a sample.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241108204137.2444151-11-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c         |  1 +
 tools/perf/tests/shell/record_offcpu.sh | 35 ++++++++++++++++++++++++-
 tools/perf/tests/tests.h                |  1 +
 tools/perf/tests/workloads/Build        |  1 +
 tools/perf/tests/workloads/offcpu.c     | 16 +++++++++++
 5 files changed, 53 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/tests/workloads/offcpu.c

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 8dcf74d3c0a3..43dc04075ecb 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -146,6 +146,7 @@ static struct test_workload *workloads[] = {
 	&workload__brstack,
 	&workload__datasym,
 	&workload__landlock,
+	&workload__offcpu,
 };
 
 #define workloads__for_each(workload) \
diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/shell/record_offcpu.sh
index 678947fe69ee..8719130fbf70 100755
--- a/tools/perf/tests/shell/record_offcpu.sh
+++ b/tools/perf/tests/shell/record_offcpu.sh
@@ -6,6 +6,10 @@ set -e
 
 err=0
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+TEST_PROGRAM="perf test -w offcpu"
+
+ts=$(printf "%u" $((~0 << 32))) # OFF_CPU_TIMESTAMP
+dummy_timestamp=${ts%???} # remove the last 3 digits to match perf script
 
 cleanup() {
   rm -f ${perfdata}
@@ -39,7 +43,11 @@ test_offcpu_priv() {
 test_offcpu_basic() {
   echo "Basic off-cpu test"
 
-  if ! perf record --off-cpu -e dummy -o ${perfdata} sleep 1 2> /dev/null
+  # We collect an off-cpu period __ONLY ONCE__, either in direct sample form, or in accumulated form
+  # (in BPF stack trace map). Without the --off-cpu-thresh 200000 below, the sample will go into the
+  # ring buffer instead of the BPF stack trace map. Additionally, when using -e dummy, the ring
+  # buffer is not enabled, resulting in a lost sample.
+  if ! perf record --off-cpu --off-cpu-thresh 2000000 -e dummy -o ${perfdata} sleep 1 2> /dev/null
   then
     echo "Basic off-cpu test [Failed record]"
     err=1
@@ -88,6 +96,27 @@ test_offcpu_child() {
   echo "Child task off-cpu test [Success]"
 }
 
+test_offcpu_direct() {
+  echo "Direct off-cpu test"
+
+  # dump off-cpu samples for task blocked for more than 1.999999s
+  # -D for initial delay, to enable evlist
+  if ! perf record -e dummy -D 500 --off-cpu --off-cpu-thresh 1999999 -o ${perfdata} ${TEST_PROGRAM} 2> /dev/null
+  then
+    echo "Direct off-cpu test [Failed record]"
+    err=1
+    return
+  fi
+  # Direct sample's timestamp should be lower than the dummy_timestamp of the at-the-end sample.
+  if ! perf script -i ${perfdata} -F time,period | sed "s/[\.:]//g" | \
+       awk "{ if (\$1 < ${dummy_timestamp} && \$2 > 1999999999) exit 0; else exit 1; }"
+  then
+    echo "Direct off-cpu test [Failed missing direct sample]"
+    err=1
+    return
+  fi
+  echo "Direct off-cpu test [Success]"
+}
 
 test_offcpu_priv
 
@@ -99,5 +128,9 @@ if [ $err = 0 ]; then
   test_offcpu_child
 fi
 
+if [ $err = 0 ]; then
+  test_offcpu_direct
+fi
+
 cleanup
 exit $err
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index cb58b43aa063..2e655a617b30 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -217,6 +217,7 @@ DECLARE_WORKLOAD(sqrtloop);
 DECLARE_WORKLOAD(brstack);
 DECLARE_WORKLOAD(datasym);
 DECLARE_WORKLOAD(landlock);
+DECLARE_WORKLOAD(offcpu);
 
 extern const char *dso_to_test;
 extern const char *test_objdump_path;
diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index 5af17206f04d..0e78fd01eaf1 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -7,6 +7,7 @@ perf-test-y += sqrtloop.o
 perf-test-y += brstack.o
 perf-test-y += datasym.o
 perf-test-y += landlock.o
+perf-test-y += offcpu.o
 
 CFLAGS_sqrtloop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer -U_FORTIFY_SOURCE
diff --git a/tools/perf/tests/workloads/offcpu.c b/tools/perf/tests/workloads/offcpu.c
new file mode 100644
index 000000000000..57cee201a4c3
--- /dev/null
+++ b/tools/perf/tests/workloads/offcpu.c
@@ -0,0 +1,16 @@
+#include <linux/compiler.h>
+#include <unistd.h>
+#include "../tests.h"
+
+static int offcpu(int argc __maybe_unused, const char **argv __maybe_unused)
+{
+	/* get past the initial delay */
+	sleep(1);
+
+	/* what we want to collect as a direct sample */
+	sleep(2);
+
+	return 0;
+}
+
+DEFINE_WORKLOAD(offcpu);
-- 
2.43.0

