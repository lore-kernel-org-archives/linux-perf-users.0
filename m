Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA1017A5B0;
	Fri, 26 Jul 2024 10:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721989729; cv=none; b=HNh52gYmO2jAKm3VpmCz003pu/xIDKUoJjuLVx3hgkfken2jQsTMAip16kAmiLEZHpddcpw85d/Ort9b7WdxOqG+jRRT85B9KvSytTDgKXZhFmBkCcrTcrWH/fr+kmmhDY5XOp69HnWbk4F0MNxFYebp8LSqUcE8Zw68iln0gYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721989729; c=relaxed/simple;
	bh=MAniNW6exOIfhgyVeDMNsX7sKp9KMJrR8w2MhqpQl8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nS/Joexxn+aoKUhu8ToxqhR2QP+/qzw/gBjQJfhGSc6tdwCEHFNuIYPlErdtE/AT2APMpEz3Rt4KPtTDcSYeQmaCYB8fcgYBGOO5kFlvTMrKJr97Aa5hYS0S+v9X5yidWtsIZZ3yx7Zrg9tvbLKBX517yIjACMzgcqywbvTpTbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JisWuyFk; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JisWuyFk"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70d162eef54so618503b3a.3;
        Fri, 26 Jul 2024 03:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721989727; x=1722594527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAFOybRrHVVIIzrVmtJN/cXHf1xuv3xo8wBTAcQABMQ=;
        b=JisWuyFkTYnR9sjz1lIyfoi1eKB/WhKV6M3lijRHYs00gQNqwyh3/BeSLx67lg6klV
         sa4Ie4R+VliXozuA8eKyzmzSzGhJwtm8l0/ez/iWHKyccChTL6UYoduiD8dlFdn0kQQ2
         sIbSxLCiX6OFXUtyA50kbPbroTLJxyGVy7S96CfZqR5YU8Zkwd8+HRSC7VuSAPEgNLm/
         qMKd/6QqxVRMMAqr6aLSfxB85HdkGMcJtO0uAGHV/8Cjh/Y3gkiSLFhlPfmFDo5azzIR
         mudrQhtx3FhWT0iyVUyUsyNcfq47Oi7jdbszn3idgDKxbMz6mhukNa+f9ijtN8V8rzKA
         NNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721989727; x=1722594527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAFOybRrHVVIIzrVmtJN/cXHf1xuv3xo8wBTAcQABMQ=;
        b=H86ukazBZuy8liKIeU8FUpVNvKt2vbdJMqOMmtjXBKuoP/1ocUQv61b6hx/LWjXe26
         idOIqwqWa7RfCwYtREPF4oOLJGHK6MtbPFLzCuMWJWqAaSN2k+xeEd5BXnDJ+7bDxymH
         dfJJIkon+NCmfJT+8N7Yc4BKOlZwg8nyuT4/A2aP4WnZgbqUI+xz1d+b0BRSZSYyUITn
         9HXbmhrkGEyfQtnPhsOA/eY/5IILuJP7EmVSjJJ+GcGdjx/VilB0D6SEBcLqlQxNPM+3
         5T2SoruayXkET1EGBoZMkvnlcsoT1qpSG96HZjhwPEZGn407i1cYuvlzzAcNn48Q+5rJ
         S8mA==
X-Forwarded-Encrypted: i=1; AJvYcCXkmIM2DwN8/QzpIrExby6iYnB+ovsvZ6OgZQWH/gC7Ys9TEL/UNPXTawxkxZooVFfyAy8cTj3k/42YH5Uzfx8PqvNhdlt6J4pIAcDAZn1wqv4ML4tWPtUs9HMv2Av/n1gp34cHumaq2vasg2B3Ng==
X-Gm-Message-State: AOJu0YzKLnEg0HYXuHTbnm5/RWJWavgbEyhnxGyEq3/ZaoZj4MzaX/ZR
	vllzoApiBPeXikQ2AS1PCSLCazUthJLcwG8Rhaeba3YKeJYh5KuS
X-Google-Smtp-Source: AGHT+IHXRSXS/mOd2+p5p5/ObMsJf4TTNl9biEclyY5h3umOpra/yhAdPpKRMwz8xRhMFyC4WjZW0w==
X-Received: by 2002:a05:6a20:9f8d:b0:1c2:905c:dc2 with SMTP id adf61e73a8af0-1c47283dba2mr6842842637.15.1721989727211;
        Fri, 26 Jul 2024 03:28:47 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f816da89sm2179964a12.20.2024.07.26.03.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 03:28:47 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: namhyung@kernel.org
Cc: irogers@google.com,
	acme@kernel.org,
	adrian.hunter@intel.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] perf record off-cpu: Add direct off-cpu test
Date: Fri, 26 Jul 2024 18:28:26 +0800
Message-ID: <20240726102826.787004-6-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726102826.787004-1-howardchu95@gmail.com>
References: <20240726102826.787004-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple workload(offcpu.c) to create the scenario for direct
off-cpu dumping.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
Suggested-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c         |  1 +
 tools/perf/tests/shell/record_offcpu.sh | 29 +++++++++++++++++++++++++
 tools/perf/tests/tests.h                |  1 +
 tools/perf/tests/workloads/Build        |  1 +
 tools/perf/tests/workloads/offcpu.c     | 16 ++++++++++++++
 5 files changed, 48 insertions(+)
 create mode 100644 tools/perf/tests/workloads/offcpu.c

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index c3d84b67ca8e..5062058ad17d 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -152,6 +152,7 @@ static struct test_workload *workloads[] = {
 	&workload__sqrtloop,
 	&workload__brstack,
 	&workload__datasym,
+	&workload__offcpu,
 };
 
 static int num_subtests(const struct test_suite *t)
diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/shell/record_offcpu.sh
index 67c925f3a15a..1ea0a44336e2 100755
--- a/tools/perf/tests/shell/record_offcpu.sh
+++ b/tools/perf/tests/shell/record_offcpu.sh
@@ -6,6 +6,7 @@ set -e
 
 err=0
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+TEST_PROGRAM="perf test -w offcpu"
 
 cleanup() {
   rm -f ${perfdata}
@@ -88,6 +89,30 @@ test_offcpu_child() {
   echo "Child task off-cpu test [Success]"
 }
 
+test_offcpu_direct() {
+  echo "Direct off-cpu test"
+  # dump off-cpu samples for tasks blocked for more than 1999ms (1.9s)
+  # -D for initial delay, which is necessary if we want to enable evlist
+  if ! perf record -F 1 -D 999 --off-cpu --off-cpu-thresh 1999 -o ${perfdata} ${TEST_PROGRAM} 2> /dev/null
+  then
+    echo "Direct off-cpu test [Failed record]"
+    err=1
+    return
+  fi
+  if ! perf evlist -i ${perfdata} | grep -q "offcpu-time-direct"
+  then
+    echo "Direct off-cpu test [Failed no event]"
+    err=1
+    return
+  fi
+  if ! perf script -i ${perfdata} | grep -q -E ".*2[0-9]{9}[ ]*offcpu-time-direct" # 2 seconds (2,000,000,000)
+  then
+    echo "Direct off-cpu test [Failed missing output]"
+    err=1
+    return
+  fi
+  echo "Direct off-cpu test [Success]"
+}
 
 test_offcpu_priv
 
@@ -99,5 +124,9 @@ if [ $err = 0 ]; then
   test_offcpu_child
 fi
 
+if [ $err = 0 ]; then
+  test_offcpu_direct
+fi
+
 cleanup
 exit $err
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 3aa7701ee0e9..84ab15683269 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -205,6 +205,7 @@ DECLARE_WORKLOAD(leafloop);
 DECLARE_WORKLOAD(sqrtloop);
 DECLARE_WORKLOAD(brstack);
 DECLARE_WORKLOAD(datasym);
+DECLARE_WORKLOAD(offcpu);
 
 extern const char *dso_to_test;
 extern const char *test_objdump_path;
diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index 48bf0d3b0f3d..f37e9be8b142 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -6,6 +6,7 @@ perf-test-y += leafloop.o
 perf-test-y += sqrtloop.o
 perf-test-y += brstack.o
 perf-test-y += datasym.o
+perf-test-y += offcpu.o
 
 CFLAGS_sqrtloop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer -U_FORTIFY_SOURCE
diff --git a/tools/perf/tests/workloads/offcpu.c b/tools/perf/tests/workloads/offcpu.c
new file mode 100644
index 000000000000..02be3d05b06d
--- /dev/null
+++ b/tools/perf/tests/workloads/offcpu.c
@@ -0,0 +1,16 @@
+#include <linux/compiler.h>
+#include <unistd.h>
+#include "../tests.h"
+
+static int offcpu(int argc __maybe_unused, const char **argv __maybe_unused)
+{
+	/* get pass initial delay */
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
2.45.2

