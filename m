Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0283F1E0499;
	Thu, 12 Dec 2024 23:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734046059; cv=none; b=EgTAkvELVOLoKNFqyz6jOrmuTfkKbXyyALTGLBEpqLM+hQ+Jr8sgPvgOFxFYPRXhLU2W/JmOSUg4/1iHeTtEt4OfQQu/nz8k2xjv4aBI1MKofDvvKAj24VzWn+0BNgFF9xiYKehRSOjfWG0hHkWx/nXvnU3urFFh2qvHdWXmJW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734046059; c=relaxed/simple;
	bh=fk3U5R0mb2SGsJQOBzOHol5ZzILTnf2AqVHElPU/gK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKgJzxrfN3I4o3ScKjYVipHMahVS/taCUPP2lJUYJf4frbHfVgiDPw5rXjafI3SWK8VFTBTQR4C+IbLhVjH2ks6KNQtToE8pHMa8jyAfjZQv3Xer4bQtKeYHblyzXql4Uj0ki/mraea6NzGuuAqFrkm91J2+ppeWHyboQm8NJZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVTuzPC6; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVTuzPC6"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-725f4623df7so962503b3a.2;
        Thu, 12 Dec 2024 15:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734046057; x=1734650857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5O/mxMoka0idCukTIL5JDxkmARERO0QsLTM8t6jJJsc=;
        b=UVTuzPC62x2I63NRK/4Ss+eeuLR3fmgDoOLIoNZ18AJyQE1sXYFjuTL19kJf651h5k
         bfdcOVEnSH6hx585iqXwWC/qRugqcF/gBsJdMM92gubESqHoJtWQeFBtfeh5rC8v8VLI
         b6EZJ0WjzoU+r++BLPPmSRiUN18aaJxGN9kbkvlgNEV+iZw14925UcTHIVDyuOY4YaQg
         MFWP87iuTt21dLJGFxqWEZRZ+Nnom9wdpR2+WzdmutTgDjxjCclstQivspDR9DZlp9iL
         S4oxNmRODvxyKtdcKKcqZHPrygUnwoWL+pkT7WiloxtndSRFy61am794HbOHnDV1/knK
         lgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734046057; x=1734650857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5O/mxMoka0idCukTIL5JDxkmARERO0QsLTM8t6jJJsc=;
        b=NWf09K82DOGmPaZNTKEQZR20m4sYP9FXCt2Ps2ARPSjMfyMFFJMk4RMrfWvy/XeF/8
         mzegJ8z3SPm42GMDPR8/jti6QCdV83nFZ/o0ljmPy5UiNNpMUbghZ+sgq5Gzp/ZBR5vI
         uSq6UALFv/JSlxZ3t+GqheYR4lJTBdISb+CDZWP9DX4c6lJrOyt5PgKGa1wmgyYpd25Z
         5bncwXmnbV13uSlR6w74GJt4DXgEmNeoBRbFN0w0CQB3Pom20WYYJxx26zK2s8wwBtUX
         WLm47OOJi9I6vTsFJ8rREpHZLO5kJcSBc6vfi0ZwxMrbusdtyNMmZ2ASPsKuTF7GDuIG
         f9vA==
X-Forwarded-Encrypted: i=1; AJvYcCVHcjb774CvwmlJILa5FeTQMTI6UozZcsP+l1FoVNqjnt/a0tcf7GZsI35hZcxJ38t2AQlyzXks/E2SYrNtyaP4Ww==@vger.kernel.org, AJvYcCX/b1A6K1aifZDfnP+biMxhK7515Rj8ZPBG2z4PYI50eA+WFKJjTxdz6l5kftZGOKn1xnG08v0YHeiTh7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmsfLHOfCbW1X54PqbaS7TLtFoz7zxMU9hJP54yhdWeSWF2uCW
	y2i3BZ+Uoe4TQxGTLaeIZ+Gn82RV6mLFadRUez5P005h0cQb9J2D
X-Gm-Gg: ASbGncuXBPe2vbVd7R+lwSknMi0BxBrBismgR0z3cs8JHSlRoXlyuE/B8oENhos2VA4
	S3oFnSILGnRqcp4WYi0zta+EgnldB6ct+cPtCwj/PbOsmUZe5qVQCGOC7LL+i8HuK6VDG07XEsw
	jKmFnXEL9nmUE7LBD1q+Hs7QoVKD/we3dmbzIu9vBFoBnbuey0mPkQf0rarksQzSQSeTnaOJKsu
	VMp9s9ZzpRrYFLuE5JVADB12RCDaQIIcsxooz6Egs/B1vtZrW8qUjDm1fcdhvTaya9biHXFEr20
	JVR2YI8Cwj9F
X-Google-Smtp-Source: AGHT+IEX178AqgV5eMiD3YAtcXT+gXvPnTRnRyqJsCltdUI4UMWfAPoa7WqsHUvVon6vXNy3wga6/w==
X-Received: by 2002:a05:6a00:3e10:b0:725:1d37:ebff with SMTP id d2e1a72fcca58-7290c273eaamr487286b3a.22.1734046057126;
        Thu, 12 Dec 2024 15:27:37 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd4e202e9asm7324674a12.72.2024.12.12.15.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 15:27:36 -0800 (PST)
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
Subject: [PATCH v13 10/10] perf test: Add direct off-cpu test
Date: Thu, 12 Dec 2024 15:27:17 -0800
Message-ID: <20241212232717.232507-11-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212232717.232507-1-howardchu95@gmail.com>
References: <20241212232717.232507-1-howardchu95@gmail.com>
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

