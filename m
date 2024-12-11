Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95601F63C0;
	Wed, 11 Dec 2024 22:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733955951; cv=none; b=RYbg+CvF467WmNgS5/40nABgvYe7jFLAW/ONvzp4JpsxdRt7POO/Mh0M2wNxhjS/LDjZuMrP8UPjPYtdbr858JhGZ7/pAN6Jq5HaLPqFROY4nR3td2DVnet8gBF5LuM4mmfp54l5tszBN4JJbzhDFoM8qyozA7RBpJVzs9EDAKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733955951; c=relaxed/simple;
	bh=fk3U5R0mb2SGsJQOBzOHol5ZzILTnf2AqVHElPU/gK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiXhDz4it0EgSWCXlZYS83HBEETW3k41CmMRwiQC1ieRf0kHtXMk6FrP4byd0Qad05kSGsPnJWguffk7NLEwZZSz4UCQIPlss28jkOP5uP7XbeC8B7NLB6QtoZEfbP8PI49C1AANcjm5TtL5Kice0U76qOY9QSsc9hFeALr3mWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mThNAhgv; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mThNAhgv"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ee67e9287fso6492633a91.0;
        Wed, 11 Dec 2024 14:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733955949; x=1734560749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5O/mxMoka0idCukTIL5JDxkmARERO0QsLTM8t6jJJsc=;
        b=mThNAhgvsrR0FfSbb1kZ6uhD7d3Iple6twpbxqKddl7zoK0Pz0GEJS/Gx81vV+nW3n
         Bi+5gwDLG9okXp4R94q5bHEax5BrIqk1Zk8paUdf1QyiLe0iNJHd+YAt4j9vP++w9aRb
         x+iCsw9p/FinPrYVPfdweKpdSqCzp8EfbhXXdiQi767vch6vD3XBWGZ/LzRgjv1VfVKT
         +s3FT2ura6sCpRiujzJZuGOpVnocc7vUx+lAjL03e6cxbN6wdh9L73mznOSxgyMHvBHK
         8veWOxNiY5HjjF+AweE60EVzD/qegXpXeFQAz5f8LCWh5Dx/iGrKA7W4xAfUSCAn2vGz
         MQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733955949; x=1734560749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5O/mxMoka0idCukTIL5JDxkmARERO0QsLTM8t6jJJsc=;
        b=jjC9dtLdK958lQktcce9DPjHYmMAdQvk+Fhn9ie1BcUZQXKaC2QSo4To7nXLMflsqH
         d1eRkpME19RHCkuXsVSvNat5h2DLmOOhyX/Q2goBbOtcQIYuUGqiFmAwzokzbnQxdd5k
         oHaTge6zCVO/ksjWGUOyOLpQZ5HuTIzbJftov/N8yel+dh3AmaVYaMl+XUhddiB3inPW
         xaJYu5O6U9VXYaQIxANXE/deNOazGMRQ+LoGJl1AQ5v8DfmOMk0UNLSYbiQYoTGONIvB
         3nHBsohpocvyAYcWuLmYB4UEqY5uIeSCu/yjHpnG5ALZz5cDIwTHD/ELOdR+KGWRrsYP
         waTg==
X-Forwarded-Encrypted: i=1; AJvYcCWaHWh+8ULaNgOmA8tP9Vpga3dGtg7YX9yJOOorCoqRV6ezAZ7Td3P9+yjTKhj7PWYW3abW+v+HSCjVyxA=@vger.kernel.org, AJvYcCXVcJ8iAwoDms8Zn2ftD0MdCHQd5MQiG9lJ6MYw+3JiFFo/ZYESLVMcTDzy0/v9mYWfN33QRzW/eZocf50MyeJ4UA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSHZib25Pt80Q7KtujibtAjNrpGNDINvDK5uR0701pWIW0N99G
	HMEspRpdBqbTFMOVy5N3JgVvmfPsB+YjpSULqCdHeuE8lizX8Oi5
X-Gm-Gg: ASbGncsEPBdmdoVeu4utQLxUQIyx4rYtnbaXwEMlJ4VC4miCDWhqhhpRrMHkiDhuS/A
	5OMsyo7DyYE7EwR/bF81ZCjN0lWXBwKtjOR3273/OUDCakicDfE9pb5mVzdJMZctNdeDwG6Gx0Z
	GaTEJRqsXVjn2+PIwpPxVEeUX+vmwh6mrsu63OZ/RN/95MuxzOGdruy7oj4pRnQDf4qtPsVE2wo
	VWBwOj9lhBs166wd2Drsuu7HaL+YeOx+zFNZG+hIp0VIHdKBAjLf9o8E6IhWBE8n4ZQajPHFnzq
	AbMedVMPYNnz
X-Google-Smtp-Source: AGHT+IGhqnworwMDyl5Z4xUJUbflNw3VZlIqOIJWmVDLpLcc0lXTXJ7uAa43lQ3S+QGodOVPfTaUfQ==
X-Received: by 2002:a17:90b:278f:b0:2ee:cd83:8fe6 with SMTP id 98e67ed59e1d1-2f13932900amr2550323a91.35.1733955949094;
        Wed, 11 Dec 2024 14:25:49 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef6d1fd68asm11241561a91.36.2024.12.11.14.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 14:25:48 -0800 (PST)
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
Subject: [PATCH v11 10/10] perf test: Add direct off-cpu test
Date: Wed, 11 Dec 2024 14:25:28 -0800
Message-ID: <20241211222528.945590-11-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211222528.945590-1-howardchu95@gmail.com>
References: <20241211222528.945590-1-howardchu95@gmail.com>
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

