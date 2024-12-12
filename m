Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44ED18A6A3;
	Thu, 12 Dec 2024 02:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733970307; cv=none; b=pMPRw0rmWh7B8vAp1HaGpYXMsR8z6BXaujNrr8A2jQB72fLmxgfHHLK3OdKMyOwqwb6lhMzST0lG132enUIGH0lG1BL9nTVGdd20VrvzVmxYte4ys9INcRsQp0ZvImG3FWvHh1i5WPdfHXsbWZ8pw5I3fHavzh46oP5yLYasFFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733970307; c=relaxed/simple;
	bh=fk3U5R0mb2SGsJQOBzOHol5ZzILTnf2AqVHElPU/gK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/uo0GVWPKsA64mOOfqAKUOWvHsXVfQU8RQkmsM6q2SEZeUYbUAG22UB1kQDjWlNeuAktGKw8YiCa0VYj7dClHmQyxKtTaNt24EdJJ7dChAbV1hXyewX+PPxDFXnAcHiYpBbWqGiBJ1wZDwAJCFiDVdJYuAkukVmDDXDHmTYDFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bI6GJZs5; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bI6GJZs5"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ee8aa26415so79283a91.1;
        Wed, 11 Dec 2024 18:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733970305; x=1734575105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5O/mxMoka0idCukTIL5JDxkmARERO0QsLTM8t6jJJsc=;
        b=bI6GJZs510eATWRo7bD8ur2tcfPc8pgdEbppAWhqfqqNvqopBwKlhT2mht7xQPGt90
         OVy+Qg9BRMU47J73olRZYmp0nL1F0gltUHDKR2xDedYMxRaR4PVjPvosWS74cH6GivFW
         z6E86Iztgu5Ub4q3lRO9fNKz5Qm1Zf7Hcd6hXwOOUuOglDXvIXn8W8iA78xNKFhsyBBM
         uXq2dLglGIXOUmxV209QYgwAtiPqqtpJftY/NnBBUpeqrLZh+DBegIF55mcdRXqVqVsu
         QfQ071HVfSrap+wHvS5Mu/8SdYoKIXHR+5vohQ6ekOo5kfNH7nhA9Z28hHe1cAKnpaA6
         +INQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733970305; x=1734575105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5O/mxMoka0idCukTIL5JDxkmARERO0QsLTM8t6jJJsc=;
        b=kVXoOV/eLCWg/p1MuYL2RKIRjNKjKT2mwKmDzixD4tohloHgu7eZ9qfzCifJCW0vj9
         Nq0BsVjTfDAdm5O8ufap82DdcPQ/Sx7eUqb3kf+2Rkx+PVJhQx+UAucCfLmkn2LHVji5
         Sv44UoBd/sZWY800OGJXtzn5XbKxQnT5pLRKZ2eThOV/9hx2N2i/pWCN5komCrjhKbhp
         gFmHfpc1fpUJxUB1XF6Hl33BOHUuWJ5cLZmIg+P0/BQbnWIXIKOkhA/OluyCxKV+kF1U
         rM629O9eaWpE3wsKZxWuhEFLsKCDyVzOLB+XfvFDisSaoegTVjQjbPKqcZvDP7JDX3hT
         59NQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/SI7vDOLwDNeVyuxLjo3MU0xA8MGn3KCdnQwJdD3WBiNRQ90GdJ/VYxH56xy6zrxC2WmuRb3owpi7lO8=@vger.kernel.org, AJvYcCWInBPUMVKx6e0J64aEmd9/+MHwSXWQKYHgvM5f2meivpFjpfbFuNG2vlMW76oTEFlDVNYFyz8FS0aTRpdUC3tk8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeTwJUuCAHcgukYZlMUDIVR8QhNLpAkW6iC9a7AnVUhmN1ERnt
	/JFnu3PmhwJ6oqxPJcWh8ySA9P3U8/diAuKBtK5Q74wb+4/BTC0X
X-Gm-Gg: ASbGnctXLx0LrsEYROrRo77Ib46sFWbD+gS3XpVW4+vqCQuSw97kgEBR4fttU/rysOD
	w/siCiTw9e/S++Cu7NwYO6UPuOuDHCun7I9GblPz/QLOCX/ZYeHruDffyEDcPaIPPdWBs6Bkw3g
	wPfi+sybWHgux6oUHtAYOYKzFGLfo9FvJ/e4elXw9UVqOVXIBPb3bnrNWdf1PystwgagHkCO9Ph
	zirf4qTR/3nfaAL9Sut4jUftObxrxLbf9UR9JIcTkuWYaopGedxcXRt765hwcQrhdssfSnj9Xgo
	M0RgY6gQXAa5
X-Google-Smtp-Source: AGHT+IF5wwfvTE4vovgmTarTXkpaFYUmrXYHiP9OBr1D0rATwpyHCq3JtYtGz9GbgDTGcOQk+ScoaA==
X-Received: by 2002:a17:90b:3d0b:b0:2ea:4a6b:79d1 with SMTP id 98e67ed59e1d1-2f139293f4bmr3315366a91.11.1733970304917;
        Wed, 11 Dec 2024 18:25:04 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142daeb5asm112583a91.12.2024.12.11.18.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 18:25:04 -0800 (PST)
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
Subject: [PATCH v12 10/10] perf test: Add direct off-cpu test
Date: Wed, 11 Dec 2024 18:24:20 -0800
Message-ID: <20241212022420.1035999-11-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212022420.1035999-1-howardchu95@gmail.com>
References: <20241212022420.1035999-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Why is there a --off-cpu-thresh 2000?

We collect an off-cpu period __ONLY ONCE__, either in direct sample form,
or in accumulated form (in BPF stack trace map).

If I don't add --off-cpu-thresh 2000, the sample in the original test
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
index 678947fe69ee..73ce16d61b5d 100755
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
+  # (in BPF stack trace map). Without the --off-cpu-thresh 2000 below, the sample will go into the
+  # ring buffer instead of the BPF stack trace map. Additionally, when using -e dummy, the ring
+  # buffer is not enabled, resulting in a lost sample.
+  if ! perf record --off-cpu --off-cpu-thresh 2000 -e dummy -o ${perfdata} sleep 1 2> /dev/null
   then
     echo "Basic off-cpu test [Failed record]"
     err=1
@@ -88,6 +96,27 @@ test_offcpu_child() {
   echo "Child task off-cpu test [Success]"
 }
 
+test_offcpu_direct() {
+  echo "Direct off-cpu test"
+
+  # dump off-cpu samples for task blocked for more than 1.999s
+  # -D for initial delay, to enable evlist
+  if ! perf record -e dummy -D 500 --off-cpu --off-cpu-thresh 1999 -o ${perfdata} ${TEST_PROGRAM} 2> /dev/null
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

