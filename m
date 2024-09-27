Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082E61C2304;
	Fri, 27 Sep 2024 18:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727463253; cv=none; b=i0wnIkonv4obbGg18713M5YJy11mp8cbqvme1iMPWvQLbEvDjLtgzlYGBK+VRGVf5td8dfSFWWh07LBeVsSo0LCAQ5njWEU63I0uKQk+63ngFDlFZF4A5QSYpVoGeRXElvOKiq3HE25SHIscAiHR0MOElUrfuqo7UFQZY+vcnFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727463253; c=relaxed/simple;
	bh=X+JKJXC1a/9G1YNDO53mXwGlKy1Lamq4AKlhcURPFo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5ABRGIqOufO8YZ7fnSiauM0jJPNseQKq5oMUh4OqLUaiOzmvpnux+PRtTMx1kzplSAb1iYxIH1CddV2EnzXFGzMc1DHPOG0jBjJdgPWRYCixFQtxbJZuiyd/uLZx2xY1qktQZuYoDfYydwi9tt2SwmFCye5jMAYK67CEBCNues=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fg4F0tJw; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fg4F0tJw"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71c63a43146so162989b3a.3;
        Fri, 27 Sep 2024 11:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727463251; x=1728068051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQIfGB7He5t4n0D5C8kX1a3R4H2i7SsPsgMHkzIUBDk=;
        b=Fg4F0tJwvlUbReoDhn4yE9pkT7tecZsJhfARUBkMXkfuYejVAwdt/e1VGlOMAplSQ/
         3PP6hzCFBXK6JT5UjWT6WRzav3h0Q6DJj8G8IozAaYOdM0vXBKmtU+Ufaz4+4FhwWsU6
         +II3WsOCEyRWmOce/aDL105yB/5R50JbGHS5QeumDt8PENP+umZ8WcTfWWV9JKh/4tNx
         o/oA1YAurdJ2T2sSJZV94D9j0uri3ojz1HEZnTI4+AvQPPP8AMb9qQKGEJLfPNXT+6ce
         jAk1Y7tqGig/0Q9IYA91U6nPj9KYFeQfTZd3RnnX+OV+1v7iM77FQcl8n/hzuTdaH2Gq
         YybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727463251; x=1728068051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQIfGB7He5t4n0D5C8kX1a3R4H2i7SsPsgMHkzIUBDk=;
        b=CDRjubb6wMPQy/f4p7pgAghtIdsDFezHsmgdjcoWt2m/T5JuRgWs1hk8pX3yXYzcma
         RJaR8NYjyVGS7K+ZBKTy6O1O8UMa2oD1AJDynZRngiGz0+cOhAMlrYxS3iFTc+ccEy+A
         XU9ZnJChxTojbimkb2qzCM2VYMN7s4N/ZzStY+iLCGW8775lD9mvp4J2VQn+WVR2PIKl
         JvGEkyOlzLOHswz6b7BiWoj3FYsU5AW/CluguAkg+HnD7vHWJHyQuMDCUFGugYBVeMr/
         nRzfiTSyHi4zcu6+llcvjuydXeGBHVZA0I4awzo8KxeiDhKfJI40t+vGGI1bkXcuLzOs
         4zrA==
X-Forwarded-Encrypted: i=1; AJvYcCWW1oyNlWk8f2Mn4y5bavFIla55Ar97BxeUww44V27pSqj8OzTri12EVFouqPGqIuBSjKQHZ6cxlT3v0QkooceZHg==@vger.kernel.org, AJvYcCXdzlX23OqBnTSnW1QXhYx5eWCJHKzYy7ocC1WM4luN4yMb4R98fWnL95pDLMNb7/kkFT7GrQuxmjj25zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYYDR1Fcn43JsmYl7To0Wc3rCaiHUI3WC0zp20nqsLObFoRJi8
	ErsgnZxFB9yogXdFXp03qk7xdiyKE1LOy8Jk6p1aBYhE4eOra26o
X-Google-Smtp-Source: AGHT+IGv7A8SJeT/RZ+teJHR1dJlL0YCz2iTt7Efr60ulXkrDL3WWMcnEPYOYTV8nyHfSj7049qFcA==
X-Received: by 2002:a05:6a00:cc1:b0:719:7475:f073 with SMTP id d2e1a72fcca58-71b25f01de6mr6784585b3a.1.1727463251467;
        Fri, 27 Sep 2024 11:54:11 -0700 (PDT)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264c23b6sm1930244b3a.88.2024.09.27.11.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 11:54:11 -0700 (PDT)
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
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v5 8/8] perf test: Add direct off-cpu dumping test
Date: Fri, 27 Sep 2024 11:53:40 -0700
Message-ID: <20240927185340.658143-9-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240927185340.658143-1-howardchu95@gmail.com>
References: <20240927185340.658143-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple workload(offcpu.c) to create the scenario for direct
off-cpu dumping.

Please run this test with 'perf test offcpu'

Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/tests/builtin-test.c         |  1 +
 tools/perf/tests/shell/record_offcpu.sh | 29 +++++++++++++++++++++++++
 tools/perf/tests/tests.h                |  1 +
 tools/perf/tests/workloads/Build        |  1 +
 tools/perf/tests/workloads/offcpu.c     | 16 ++++++++++++++
 5 files changed, 48 insertions(+)
 create mode 100644 tools/perf/tests/workloads/offcpu.c

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 470a9709427d..aa33beaf58c8 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -153,6 +153,7 @@ static struct test_workload *workloads[] = {
 	&workload__brstack,
 	&workload__datasym,
 	&workload__landlock,
+	&workload__offcpu,
 };
 
 static int num_subtests(const struct test_suite *t)
diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/shell/record_offcpu.sh
index 67c925f3a15a..69a9324ad7f5 100755
--- a/tools/perf/tests/shell/record_offcpu.sh
+++ b/tools/perf/tests/shell/record_offcpu.sh
@@ -6,6 +6,10 @@ set -e
 
 err=0
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+TEST_PROGRAM="perf test -w offcpu"
+
+ts=$(printf "%u" $((~0 << 32))) # same as the OFF_CPU_TIMESTAMP
+dummy_timestamp=${ts%???} # remove the last 3 digits, like perf script
 
 cleanup() {
   rm -f ${perfdata}
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
index 6ea2be86b7bf..c7a5e27c4567 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -206,6 +206,7 @@ DECLARE_WORKLOAD(sqrtloop);
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

