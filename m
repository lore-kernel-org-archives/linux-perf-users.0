Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D881C460F;
	Fri, 27 Sep 2024 20:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727468883; cv=none; b=qbV5KwH5OSXPr7ULvY/lkJ3ytUHI8WgxsIRZEu3qdy7A5iN5PRECKb8d0DyeLRaHDH0rBi4extInR0pI0s2/v/NudO27LqfD17r1SmL6XPlvTyJKbmYxGKUn/bDib5y2TqGvpOLCbkCqDqf/ebujGxlwKVQJ1K+AJ2DZzTfBKvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727468883; c=relaxed/simple;
	bh=X+JKJXC1a/9G1YNDO53mXwGlKy1Lamq4AKlhcURPFo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3VcgyyV/GIw9u8wxZ2zegSMj8de3J1zrkbnvzCNGDbYmewavq9A8DlFJek/pljV+ep5lm+Q+td0CXyLVseNQ+5uzAgJUQ1DJn3Osvgo6wPU5+3MW6Ef6qNLSxWURHU09uPgDUCKLHti0Sd57Z+JXOIobNYVjoNOk6R0MNYoUtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oy2gWn25; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oy2gWn25"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71b8d10e9b3so864473b3a.3;
        Fri, 27 Sep 2024 13:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727468881; x=1728073681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQIfGB7He5t4n0D5C8kX1a3R4H2i7SsPsgMHkzIUBDk=;
        b=Oy2gWn25K8n29HI3EcMX4SCsmpHNo8r2mQrU+ika3lIhehDZMi5wEXzQzj5Ag4zUqI
         7F7e6ST011oUEswelVfV69oJDSq6zGOZMeu8Ag4QFLKzoop1xTyi5rwP8goRd8e/hihp
         tGn09y0ZIwFvNTadR8wSVMeVk2gyIMB3E1v4yKtPU4TXbR3VRZZDyhhtlzDY1U3kP6aI
         HtLJJ7rvGziu/BHzjU6nqE6kUDY2Rpv5wgEljbzU30GnNrVz3B1ZZ8Ow8AixeAQvBUKk
         GlxZpeMoH0E4UE8pSLsljfi3OpTWRvRicXGhL/pn7fmDEcYkIXmkLdJbYa753+8U0F/R
         VlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727468881; x=1728073681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQIfGB7He5t4n0D5C8kX1a3R4H2i7SsPsgMHkzIUBDk=;
        b=Esj8IApoiYooKbZ2ZHO11/IMRNvD3GsQc9gAhC+J2RbbnMm0iNt68ElA75qOpJLooG
         noWe+RHJg8zUJXewdO3J6WTH/EWsdlWWzf32YA6DQMgoQZLQKZfVk/66o6rGHFWhweK4
         7KBwuBzWKq2ojFlpnNxJR/d6BXDNhRQ6v4zwnOv2i06mElWDiRu/Mx5Osj3BDDhpqFwi
         DHajthwq8VIUD7sf35WalzNhwQLCgnYrpXDXySDpZPQwRXBHoa+b3HIxUkgToUY5mMnb
         4Hit34kODVl92FVpxvklFhNaSdHt3ArPTG3gtD/pP2uZJurvFx6a0Pc/bsYsGY42hR6p
         x8tA==
X-Forwarded-Encrypted: i=1; AJvYcCUYjcbLZg+3hXV7HAzM6D7efnzz5mS6tnzuYQKdvjB5nVjTGJcxwFFKW4FsoNfg2WhiVIXXaqT/lwx/gpU=@vger.kernel.org, AJvYcCXN9t4cCBmmjHIxhV6h/SuGQb01Qrt6BwVEvM0zUcgPhQEcwgbcMpQpzDNaH3PVrwbQascsaOI6iQ5Uj8FeOkLUCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzV0RKucFvFVUa5657BjB4Uv+brUX4xqdH5ED3/Gy3bf6wcV/Pw
	kmldpzpty8dsp88dempDPLxQeDzYUiwS43TRwvJ1eOuoUk6koXjT
X-Google-Smtp-Source: AGHT+IHuls8O3luaymooSSTfoyhCXkxxZZQryTG0EzUisbgROYAUH3+M+BNPDSYTlJpJe98y3D8MCg==
X-Received: by 2002:a05:6a00:178d:b0:714:1a74:9953 with SMTP id d2e1a72fcca58-71b25f6ef48mr6566110b3a.16.1727468881483;
        Fri, 27 Sep 2024 13:28:01 -0700 (PDT)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26524c32sm1998410b3a.157.2024.09.27.13.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 13:28:01 -0700 (PDT)
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
Subject: [PATCH v6 8/8] perf test: Add direct off-cpu dumping test
Date: Fri, 27 Sep 2024 13:27:36 -0700
Message-ID: <20240927202736.767941-9-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240927202736.767941-1-howardchu95@gmail.com>
References: <20240927202736.767941-1-howardchu95@gmail.com>
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

