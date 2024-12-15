Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5631C82E2;
	Sun, 15 Dec 2024 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734286374; cv=none; b=j3Sm4hIBEGPHYcd8GdjuRjsDbUkRdSXXsUiiv/FBQhSGVnWpvyoY2sXff/DWbJZMr3/PEk+Fh0RSHWzvFo/Lt+ffY6cU4yPWihz4iBUoZT3awOY34luOq9jMBDBJp7ZxQhYPFI1M/AyzsXq92+rSWkvRJneLDABytJ7FV5n0VPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734286374; c=relaxed/simple;
	bh=4WAIAiXBlkGgyD9H4cZ0yDqhMm/Or5jQiLufWPGrXcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gO6wqtcRTa5D/maNZLCXHUHHUPECGZW3xDcuu/kEY16LDWQYw4fC+CCLvH0PD3gXeNLKA+pv5UIlsZfyXFjY+cdEMian7WDjnPu/2/aWzpEcGP9fGyQRZ+89kC27iJor2gXeRrYgL3tUekdFk/BApWU3vilxFXDDHSf2OwtQaM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiWN/AMd; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiWN/AMd"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7242f559a9fso4250596b3a.1;
        Sun, 15 Dec 2024 10:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734286372; x=1734891172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qu3/uFK5/Qyd9VqlUJrIK5ot4oLtLxNVYvtxgrzh1U=;
        b=aiWN/AMdY5CcdBzGEi8UTvTTUE7KguhBX0fYvPZOMiH+j3iB78PtKmMZzhib0/ECgg
         R8bRExK/F/sCe5We6XaVAkJt0+g9dQ8XBfK1MAmLVpF7TbbVBcppe1u55DOcxWLhW8FX
         YpzDRxi9+pQ/xRSJ9JdQ2QwVl9w7DqbuqV++faJCQcnerhLbzwwmMyzKNdeXqqSc8NJr
         7rS6HbJC8Ny1U7zcl6eA9mpUJiFr8oVlXCIsJYsCEjE/d0J9TBF1j32wVhM0Efq7VRYz
         Qy7Fen0yBGg0WS/PtDXFGqIfK4zxpgvdO8LQ7T2f0UuaxPbh+U7axRbiezZfPGUTTPSq
         LjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734286372; x=1734891172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qu3/uFK5/Qyd9VqlUJrIK5ot4oLtLxNVYvtxgrzh1U=;
        b=EBVOrsODEGq4E41yirI2eby2TBCo+yqkaSp1cwZOj7T8rdZ7IBiHG7T7/cCV6iBWe6
         LgaVDwrhWCm0Ad3AnIQuFr/UEXL6r4BgK7tBVJ6WNbWUL7zEFswso2lgzvVslfG1Oqwp
         jgcT7MpBGNpmOU9MQsnWsRw+3XCSqDXlgzYwye1rP51jMPLch8CEvdc/0/2NXiRmO7mt
         Bmp5dATMJRqVr1FAYFBzWWEvrGUX/n62ox84SeApTvRXKrva7cnZ04/evdsOvzGT8sVg
         cBXNccFkwqYwjInVaPJu6FXudWew+W9g9YOXf++JvcX2VZQv9lMxekLYK//MqagRphSA
         mUzg==
X-Forwarded-Encrypted: i=1; AJvYcCXD55ifepLjIBLIXOOyoqrW2GJqpuLG74OJKxvSBzVAY2B60RZ6v7yMUrF4SMMK8WiXbovgSPg66ak2OYQ=@vger.kernel.org, AJvYcCXiyfcculhvZV0DacjNeaFM16yZQ9C6MomdE6/sY7zisGQ9Vys0rdueOy16fBlQnH4Gsw8eh9sZhrZGVLsv/vU26w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSa+MVtJ89SMfdgsSuEoHbLKyJi+m+RWXW/518I+xm/BD7ysOt
	uvDNS9dQbN6pkbWZCV8igTyKWsU01S/rGuqVQ4muZGoGy5FUIIzA
X-Gm-Gg: ASbGncvjzTVITnUknhZcaaGNSQq3dezvZLM8JJhTUZ8Vq4+GOUoQrqXo6wx5DGR6nhR
	uL77/Eaj1ur7WGAgG4ZyOlwR1IaAhUF4iK1CJlO84+3RTOJ6lVSYvIc0y1RTKQ07NkfLQEPJAy9
	E/EWtHvQyXczK2UJ+Gnb1XVJr0OdI72j+jHXyqRR8SirFVc0dNrk4Apbs4lcVF+u2vaUJ8ob2T5
	jJe0eaP7YXRn0R8n4+68y7HVQO+5P7Nc8yA/2ykYFktVmskwWT0OpQ7QYEQqfEVMYV1ZT0yGmYq
	Azae+KDigfGf
X-Google-Smtp-Source: AGHT+IFrsN7TLzP3bPBN6JtqJa8ARsNkgxktZhcFQzRiiGDau6PYTZ+r7x/S1oalrZm+9Ho9fmTmkQ==
X-Received: by 2002:a05:6a00:2e0f:b0:728:e182:a8b with SMTP id d2e1a72fcca58-7290c15eab3mr13924977b3a.9.1734286372576;
        Sun, 15 Dec 2024 10:12:52 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5a90ba0sm2808120a12.16.2024.12.15.10.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 10:12:51 -0800 (PST)
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
Subject: [PATCH v14 10/10] perf test: Add direct off-cpu test
Date: Sun, 15 Dec 2024 10:12:20 -0800
Message-ID: <20241215181220.754822-11-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215181220.754822-1-howardchu95@gmail.com>
References: <20241215181220.754822-1-howardchu95@gmail.com>
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
index a5b9ccd0033a..261325a1088b 100644
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

