Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388071F4E35;
	Wed, 11 Dec 2024 22:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954442; cv=none; b=PDSDljn/Mz/xhg2KrN8ig2TUcGhq0DcDwxNUfdKWSu3EFPMp0sqtcUpg2zqaT6X9+R8NoMjFXeXFx/NhMfayaU913RPxBH3LBIddR8wz9itOoh8R+vQGSzy5E2KEUGvgsZqw4EqiV1PyGxL2Npfqe1eSBSWwHk7kduxvm7CuBqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954442; c=relaxed/simple;
	bh=5nGYyxgY3B9mVbxCdPzUtVeTM5bCMbgiAaUPIEyAA9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LkoCpg/vbcglcU18yTCAINLcVbYM1KB9MhsF0MN50nytlEwrVrm6KG9FrojXRLckmNBHiPDwup1N6YmP+UM+bvbZG3bP0aVp76pQ+SxeAu/zld7u09JYsWTggW5pl7idjNdzkm099BM3ufhOp2XlRJCiW7DjwiGv0qAsC5xSSCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3SExPcV; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3SExPcV"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7fc88476a02so5882072a12.2;
        Wed, 11 Dec 2024 14:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733954440; x=1734559240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J85GkjASuqbDMp7TzMhDbcWcWzC+KLekepi7rqoFfYE=;
        b=O3SExPcVxrfohGXwqNfpFPvPZQiwkiubSVthMeo1AV4H7yNKA5GnF5wuExOMx6iXEH
         lSlWpxiXDfan6YIJ483aTOd0SV2cCdYhid7xVGOrt45ysNi65K/FLX716lk5cT+VPEVS
         TzZ6F2ftdXJ5esDtNZzT0IuKqg1+f8Lia/GdqlH7ZpPqWmuSNn3ftfozzQ7kcTK3Llc9
         AOH9z0K5VhN8HGkmaowKqBqALSlde6cD9Y04quUCSHJ4XMNTYxvdYZxiiEWTKQRkuDhS
         fwRxUPrU1+U8qH/VwuOg/yFIG6GFz8ZpRNWh8KzShAikis3SPhph7Ytt8qE0VaxPGkdq
         NxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733954440; x=1734559240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J85GkjASuqbDMp7TzMhDbcWcWzC+KLekepi7rqoFfYE=;
        b=muh0zLyOWPR0AJ4rpiBVt1aGBuByaJwK3U1rS5RdVEQaf3QXzdU9DLyGGI5GfXdRDG
         LqWtfuuf/57yr5ln40WU2ZiOLeeJmbWAL7M7BwoM3ri3LVNktmu5ofmn4nH/tIw5KfgB
         gSb6YqZvHNPhF2VvrUXg9pVZwZ52Wvmcc6qiw+fDpE6U7frkpD1z2hyDDQJk3c5leDXn
         x1RBMNXRag+1hi6YHkNu3HLubUwhdYt6iBxJkgO5rF851K7csQd9ojyXI/I8lS13+Bj6
         k5rWKRvXUplRHHSrNfHjfK9JZeeu9cRkFzSw8b40rYPc7CIzZY6i4ZD6qbSZMXx1VGnN
         zBpw==
X-Forwarded-Encrypted: i=1; AJvYcCVejvHNOKQzsx0iA0nTGZub026jJOgWKG/L38YU52k4rD3pEwhMELOsV46wNBrIkRii2+ZqQZ/zmBhXJxsKpcd4kQ==@vger.kernel.org, AJvYcCXtuNCdMciR8sBq6T8cP5HXm5t3Vhxv3Pdk7+MLTIzjSnhcjPR1/ccFzQCD/DQy0tlfvVywZEGIh9IVpLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRtEbkdGZAilO2ziNKnpwsCzJ0CJ2OUURydmvt1ziGPMAFYLHc
	Eo+iJ0SQnd+IS16+1zXiIljVMhB8BtutsbeBDFRMBuKI7+m5i745
X-Gm-Gg: ASbGnct29djp8inUxC/ihGcMBO9vSI+NIqeqeAw/FeXTNoSPSR/HCsKjR7tHQsCRBVh
	u7vP5R0b9+0qoOxAfEYtyIo6j6TgBPDOlrgRuD+wRfGUpb5GxJ14Jf9s3G4pInDe0uDnZOyiY1m
	ZOYo0I3yqdG7KcID88NOitFkG8KGjFdrlzUr2afg2v6aFK4bD1VrxbZmsxcyjlyEInKuD7P6TWy
	VBwHQT9srs+/21PFTvI3LhdEIZ0fv+alaab9u9bY9vmm7B0Y2Upz8EQMZLwaa5rtUJ68o68ucPD
	931NtlO3jA==
X-Google-Smtp-Source: AGHT+IE5zRLXj6fZiOzJz4zq6e8BaXIwZJ6K35XFacR4S+Xhp2Y7p5AtXZxQx6N6lhVAmfHCywYdbg==
X-Received: by 2002:a17:90b:3c4f:b0:2ea:61de:38f7 with SMTP id 98e67ed59e1d1-2f13930bd0fmr2448831a91.29.1733954440336;
        Wed, 11 Dec 2024 14:00:40 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2700cccasm13912665a91.22.2024.12.11.14.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 14:00:40 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v10 10/10] perf test: Add direct off-cpu test
Date: Wed, 11 Dec 2024 14:00:14 -0800
Message-ID: <20241211220014.931479-11-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211220014.931479-1-howardchu95@gmail.com>
References: <20241211220014.931479-1-howardchu95@gmail.com>
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
index 738ad32b2c8a..a79157593c8b 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -144,6 +144,7 @@ static struct test_workload *workloads[] = {
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

