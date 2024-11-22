Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBF018593A;
	Fri, 22 Nov 2024 04:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732250342; cv=none; b=bKGoENM4uAuY/PeHfMqmjxKglC4eGhw1uAYWAf/tsAmy9RU6cAIHTjpun53CT6+YVz5KbY37xQvMxR6DTW1uvzgSqRgn+jTRTehD1M/Hdo43GEQyD8aYAXOqxaa7rUDyUZU/Yls2j2qrUhH5dkHCK6doFdHVSXMC8TsXgaoysxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732250342; c=relaxed/simple;
	bh=i38KITFoXQxHV5vC+zLrvHnE4A5s7OsP/Virq4w9OTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ur9sYkHcb/ColRTtIHBDg3lwBYVZNuWS6cXEhES0zhAm/ajNxG7OiWpEkz2b4I0EJu9uKQIroICFArugtJmFkY9Yh5K3fPniU7WUmb9BvyuswSgS4n0gwl+PYZ+0xQu5X54Nd4mEsNDcGflixX29sWMXFrpKaSjy6qMBANyNdnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9R9ebXv; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9R9ebXv"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21207f0d949so15752645ad.2;
        Thu, 21 Nov 2024 20:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732250340; x=1732855140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghYLYuPX8XvrvfkfC7VIB18q5PzN1p3CvZzBe/JSGjo=;
        b=H9R9ebXvX3Keqq4p/eJlfrvpxi2M88pi7OA5e7AT/u55d4rM/Qbr0eObFNXo+QmQKM
         9PF6YV8f9I/WNKEsHV1jafoto7XY6fRDMYpkbvvutOayQX37zSmYr5AaeUlP4Eh9bzl6
         zcCl6iyEz73wiSVt127vKaFJZjTM1o+PaVtFrTA6cOnOPC3gcmunalny32H9pdvjwXSu
         5yh+fkGNdpxU7c8NUaX4rY6hI2/JUgzrQjkYQ/rn3awL5WtXSOADYwAeHLtlKx2DmrNS
         zF135dkkPta5NjKXv/zLLZPGG1wCz3qlbghb6qOnLTCOMtZY8XWL3TG0nHVZ0qvTuBlb
         df0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732250340; x=1732855140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ghYLYuPX8XvrvfkfC7VIB18q5PzN1p3CvZzBe/JSGjo=;
        b=egf6y4EB/ihpKPcvqipZxolJpC7+kvOWzIGxYje82IyjiGasjmQJ6Sh+eaF7LZnS+X
         YD7QadYY5EyzE5CCZ8YMjrFLNMa8C9S7gRFdSamCkUAH85yu05kS5+70UIcsLktx1utq
         OgN3NKaHoBREM30IDRBS091Txd6oIKRBD5iVx41EiSTapi1zNy60RZ/Ebrl5srRaTbXI
         WQ72iO4rs3lJpOQHGNg55lITOQZaKfMMry30z4i2Hfmto/WAaivyk1v2W+blkWF3CXhh
         1mIPnhxnK85Gy9hbeTq42SxCsfZ+6DKjbvw/ryucxJuEYuM6v32kCHtaOFwpjNgkCr/Z
         4buA==
X-Forwarded-Encrypted: i=1; AJvYcCW6S/IQB2KVOSiJBLZF+a1ibDXT3k2EQQ+/2kEP0GJ2NcQ4O2DjNvU39wTFxwRnmp5iqnTMZZ7+eLnPn+9efRzk9g==@vger.kernel.org, AJvYcCXFZ9rINuQ2Fn31yXX1ZTAjiojvLm/KxgWW532JJ4Id31qK1NuaVej8irgGh7bYDFSa2CDS3gvRhWUVv2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNka0LRw3nzySFltN0PJq1rVp+onk5e8K/fpbFBEnPJHlNq/Gl
	DYy8Le3RpK1yyPt9CbAS6uPbon5q+3gGGkf1UUYqk/QPa2ZuwVbu
X-Gm-Gg: ASbGncuj8w6pEnqoDaXrf0/wrmGf4auAMfpHe3KN+vPiiWjHyMJc5+4R8GgLkGaXmVT
	p2/JQZhbQXic+pK8f5QIIHFtjiJMZBBbLDVjxmdASmpl9TWnBdPP2i4/D6aEl8XmQAxK6gSPsEY
	G9B4FNBLRginKt2sAu/oT4tPnbjwM1OaQgRqZfIC0l/CiEOtCd6H4eO71aJp9A1gw2B0W0A0XKO
	sjMdp1taWpglXTurSaS7onEoZ0Nztp9He84TcNxYmBWQA35iJ3BEPSN/pq2scfAIG7oL+I/XWE0
	iitXKFf3u54=
X-Google-Smtp-Source: AGHT+IGIxtkFFLur8UVdFDG0iwtb4KDnzz7Zl10IsNEo3w/bPPCZ5sC5/M5XIKfo/6AHXo/zF2Rczg==
X-Received: by 2002:a17:902:ebc4:b0:212:5120:f212 with SMTP id d9443c01a7336-2129f51d710mr20643365ad.5.1732250340020;
        Thu, 21 Nov 2024 20:39:00 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc1544bsm6638135ad.193.2024.11.21.20.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 20:38:59 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v9 10/10] perf test: Add direct off-cpu test
Date: Thu, 21 Nov 2024 20:38:40 -0800
Message-ID: <20241122043840.217453-11-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241122043840.217453-1-howardchu95@gmail.com>
References: <20241122043840.217453-1-howardchu95@gmail.com>
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

