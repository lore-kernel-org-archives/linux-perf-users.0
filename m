Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5674219E29;
	Fri,  8 Nov 2024 20:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731098521; cv=none; b=AIOrC9LUN0jTXBz6GOTL2JMfB+inJN3EWmzulLiCTsYr/c5usBAE1z/sgFtHknWr+XT30u4F9EManzs+jmr8DmholM3P4rH+QO4poCDg3aJoQIIWhk0kblGfqHS1lhjnhhqFFWIsVGjpydtfF8zFg4yTRgOID4CQCXwfBbO0iX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731098521; c=relaxed/simple;
	bh=q4GbxqglWbwouKr8KdSERhNWfS9I5/5YSVXoB2PdQg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dc2IOOjla9Npzi0fAwh/ihVN4fZEsyrH+W2tio/6I16a+k14wXtNsOEXUIFJ6wbv11nh5LBwY/VQQLL2NggC0lggKi35V8809JKNsjokTwAO5YoKVNQZjjGtx0TwxQ+kX2XrPwVKow6dV/CiJTIZR3mvJmYw6icB3CCYlWZ5bcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IN1U/bm+; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IN1U/bm+"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-720cb6ac25aso2334370b3a.3;
        Fri, 08 Nov 2024 12:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731098519; x=1731703319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9Lk9CTgyzuah9Ju7zGNf6f0xwTQJZoRr7qB88GnpTw=;
        b=IN1U/bm+2ajBF9w0NljuYWhOXhw8AgqEV+VbI0dnqNfMBldPRpWrIE1Ye3W2zC5Sis
         Mdis0QdvRZmDUdz47/T+XMRPo0eRGNGfbSnR35HS4mADCwYvIMrp3PZzMt3apn5UmLoh
         GIcpB/PkEKUqwJjgFACi9YZd6rPTPGyDmiKUfoSRTcJMXVQgvVnwd32w7h+ojXe6Zces
         HO24VLTATb5KI02n2d+c8SRLJ44HgZPw6oXcf26XkG1HPnl4BDU0Q8nl5FqjbtrRBEGO
         uYCqwVmPalZ7Te0vcQ9VcogWryKT99hvB9h3ZSy2fnPOBF2bmvLf+Vexu9a034Ui5JKh
         6Wow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731098519; x=1731703319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9Lk9CTgyzuah9Ju7zGNf6f0xwTQJZoRr7qB88GnpTw=;
        b=oiW3NeXD2x7qHLwbHW7UPzlRWdXvwQu5nNbJtOyO53W22YYKqhAH2TYn8prk4K/gPG
         JXg4DOR4jTFhcY5VVTLtn+Ha7HF7JaeJRKWj+eqrI+D7WIDlP/3XMLTVLDqsz7MqcMJE
         soipvgUHkuD+agqgKJq0vvAfGdjHeoCwnR/cWi8RyH+DBky8D+Cr8/7N0yZ5MO+eHa0H
         7tOS+WdM0wQqU1r75mQ80pe9BZelwzVIsM42rNK9nJ5UOB8bJ6h+Rwsx66YmQNDjDNy0
         dI1u/ML11ZgLl25jqE3LSg52UEF2icnH6t8TYUwCk3+coKXbEXpHd5VPoFK8RYMmaZrx
         NmVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7P76gFyBHc8HtpOs5RN2q0gGWyhPIse5fq1c6Dshz2/tKAp/kBaPD7TYPS4udJ1ZXedxXKU7v7YCukubjDXQOTQ==@vger.kernel.org, AJvYcCXs4gNhz+a4GMF3I6gtL2rYdv4CnmfL4TyxFvCSZb0PjXdqfQZwRINpzUhH2Vl1CIyGLyNHeRisR4dxh2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEthUTG5JM5yqFQP/vqHmIgmPDDOoO2vwd94r6iIiumjMxF1A1
	XAZCWzHHOQQPadH0XzKCh3XxMzbN+ZlHN8Jyyoa8qMM8ENGAJGJS
X-Google-Smtp-Source: AGHT+IEsMr5E8h+qnJG/vsq1MKhJingnqkuEUIg4BoJm7eKwa/JP2/THICiKY41oiUTy1y22yTPyag==
X-Received: by 2002:a05:6a20:8404:b0:1d9:d9a7:dd36 with SMTP id adf61e73a8af0-1dc22b54192mr5234525637.32.1731098519167;
        Fri, 08 Nov 2024 12:41:59 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffe3sm4221945b3a.2.2024.11.08.12.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 12:41:58 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org,
	peterz@infradead.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mingo@redhat.com,
	mark.rutland@arm.com,
	james.clark@linaro.org,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v7 10/10] perf test: Add direct off-cpu test
Date: Fri,  8 Nov 2024 12:41:37 -0800
Message-ID: <20241108204137.2444151-11-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241108204137.2444151-1-howardchu95@gmail.com>
References: <20241108204137.2444151-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Why is there a --off-cpu-thresh 2000000?

We collect an off-cpu period __ONLY ONCE__, either in direct sample form,
or in accumulated form (in BPF stack trace map). If I don't add
--off-cpu-thresh 200000, the sample in the original test goes into the
ring buffer instead of the BPF stack trace map. Additionally, when using
-e dummy, the ring buffer is not open, causing us to lose a sample.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/tests/builtin-test.c         |  1 +
 tools/perf/tests/shell/record_offcpu.sh | 31 ++++++++++++++++++++++++-
 tools/perf/tests/tests.h                |  1 +
 tools/perf/tests/workloads/Build        |  1 +
 tools/perf/tests/workloads/offcpu.c     | 16 +++++++++++++
 5 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/tests/workloads/offcpu.c

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index d2cabaa8ad92..2228e6064d16 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -145,6 +145,7 @@ static struct test_workload *workloads[] = {
 	&workload__brstack,
 	&workload__datasym,
 	&workload__landlock,
+	&workload__offcpu,
 };
 
 #define workloads__for_each(workload) \
diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/shell/record_offcpu.sh
index 678947fe69ee..fda1c1ad4555 100755
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
@@ -39,7 +43,7 @@ test_offcpu_priv() {
 test_offcpu_basic() {
   echo "Basic off-cpu test"
 
-  if ! perf record --off-cpu -e dummy -o ${perfdata} sleep 1 2> /dev/null
+  if ! perf record --off-cpu --off-cpu-thresh 2000000 -e dummy -o ${perfdata} sleep 1 2> /dev/null
   then
     echo "Basic off-cpu test [Failed record]"
     err=1
@@ -88,6 +92,27 @@ test_offcpu_child() {
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
index af284dd47e5c..58de36e0edc5 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -216,6 +216,7 @@ DECLARE_WORKLOAD(sqrtloop);
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

