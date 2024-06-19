Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123267F48C;
	Wed, 19 Jun 2024 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718785209; cv=none; b=CEOXE+4myWW0vxA/LVJ4l5T27xhsMN8/xO5RzDPwdf8yTekApPDgNmU77xuWPdRwEpoQQX2fT3pQks9FMJ51vzyvc/jfUFww5J4kCK2taA6xJkP4VDLZMykoYnpsuCHMNgMxAx5jfoJnh30+l+xTWEbt+jjBYjimFcVcXjSmvDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718785209; c=relaxed/simple;
	bh=wqrWbQjJHLVk77hDbRS9Ov7m0yXFPnxx5SOMZYtv92I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcI9CP1CKODoOSuuELKyNr4AQn6vkgaDFjAu2kN51tqv657YoGZxyJEh+Q98EvfnVi2hNq3Tb+r2iooV+3bYdOG2wemzE74MjmT2o77l1U8kuQ3kC3/iJL1Ky8NxLTGq2iVTKST6XV4J2YFdXu3WDxVZocQgxoOr+KHs4ApCQ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrEytrsZ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrEytrsZ"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-705c0115192so5325898b3a.1;
        Wed, 19 Jun 2024 01:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718785207; x=1719390007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXpj4ctbnoq9X2eril6gkLuWQ94xgN+SdmmMtAnJByc=;
        b=lrEytrsZM6FCfzFpDQHOSrNfaB/kJFEo/4T/zs9J6NzPMsY1I7kNU9LCDPHbM9m1XR
         TlsPCxUSLAzxb68/8+tMd3sM+PmabxevEUXHN5FlESSZd6f42gPFtakeaDymZmD9T3OE
         Tmy9ka7WPQYimXpECSkzXvrZQGHm4GVinprHaa/JxEgTG1xYWw2hAGSeOknAcQV5/JLP
         puH6wgn4fl6iRi1si9HqFo3YKvvyrhz1X1c3OIKH0uOly3Wcr0BlJiaFh63Ly0EF/nmT
         4GVW91I+Hpc8JHgUVjV3r6F7i/E7IyQb7Ccplj31WYe7htZ4sFFTqpsh8GRJuN+HLYf/
         J1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718785207; x=1719390007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sXpj4ctbnoq9X2eril6gkLuWQ94xgN+SdmmMtAnJByc=;
        b=XTKLsKEjBfwbOcAFKFSgr6vrJzAJEyLqhPbCEi/n875TVjQOwFbEfSjbPaoGIxll/c
         AfGQsXU9uHiBmVBqzq5s92ykpgShkkU2Jpoh+1VFxaGh/TzvLw6zue2Mjt4K/XmUs8vj
         TRxOiLNXva30lvVKi6djRjBpbt/iMVeGUE8k4dNt+s5r6aRuTxVHU+6jDLzPDGvDn2YG
         7T++rJ/y1ePyHA7J7nQ3YgwUIIhAGzMiDpAQ/LW6+FIZ535G760KH5wdXXvkDwIfIW53
         IimPvPtbaG4BSV/+i0K5DlKdXXcbQqkbIj3mvT5AAEHFoE7Wgi+rP8d2eYpTNLLvYJ1E
         V7Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVVvfxDAkKmhnLsPGLYiqXxL2bz6+0k0Sm4vZtkMlZS/IyS1VnPJfPRwbbiwcz2DNPENvBkHnanxED5Xlc7t75bKA4ZptVs2QtW1+gxeEEPAWHNHbap3ajlvTf5tzSOmetRVtE9cdV8qEEwEpYf+w==
X-Gm-Message-State: AOJu0YypavrCEaqH6dmFp1EnN71kVvGf+Fxbt77skT1VPwbP42G/p/NH
	WyH+NiJHr1sJWrKGnXv2lmkWYW6+3E1JFKwa2td+KCsgCbP/6TU8
X-Google-Smtp-Source: AGHT+IFlCusWPb36kf8gjCLYKpQVEm7ZjoWSHk4AtCbufMJyPycqkGt1Ke9V1dMr/9q08waHXPGl4Q==
X-Received: by 2002:a05:6a20:ba3:b0:1b2:aa82:4b33 with SMTP id adf61e73a8af0-1bcbb617386mr1881167637.49.1718785207304;
        Wed, 19 Jun 2024 01:20:07 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f1decfsm110368105ad.250.2024.06.19.01.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 01:20:07 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 5/5] perf trace: Add test for enum augmentation
Date: Wed, 19 Jun 2024 16:20:42 +0800
Message-ID: <20240619082042.4173621-6-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619082042.4173621-1-howardchu95@gmail.com>
References: <20240619082042.4173621-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check for vmlinux's existence in sysfs as prerequisite.

Add landlock_add_rule.c workload. Trace landlock_add_rule syscall to see
if the output is desirable.

Trace the non-syscall tracepoint 'timer:hrtimer_init' and
'timer:hrtimer_start', see if the 'mode' argument is augmented,
the 'mode' enum argument has the prefix of 'HRTIMER_MODE_'
in its name.

Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/tests/builtin-test.c               |  1 +
 tools/perf/tests/shell/trace_btf_enum.sh      | 57 +++++++++++++++++++
 tools/perf/tests/tests.h                      |  1 +
 tools/perf/tests/workloads/Build              |  1 +
 .../perf/tests/workloads/landlock_add_rule.c  | 32 +++++++++++
 5 files changed, 92 insertions(+)
 create mode 100755 tools/perf/tests/shell/trace_btf_enum.sh
 create mode 100644 tools/perf/tests/workloads/landlock_add_rule.c

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index c3d84b67ca8e..e83200415ad1 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -152,6 +152,7 @@ static struct test_workload *workloads[] = {
 	&workload__sqrtloop,
 	&workload__brstack,
 	&workload__datasym,
+	&workload__landlock_add_rule,
 };
 
 static int num_subtests(const struct test_suite *t)
diff --git a/tools/perf/tests/shell/trace_btf_enum.sh b/tools/perf/tests/shell/trace_btf_enum.sh
new file mode 100755
index 000000000000..4861983553ab
--- /dev/null
+++ b/tools/perf/tests/shell/trace_btf_enum.sh
@@ -0,0 +1,57 @@
+#!/bin/sh
+# perf trace enum augmentation tests
+# SPDX-License-Identifier: GPL-2.0
+
+err=0
+set -e
+
+syscall="landlock_add_rule"
+non_syscall="timer:hrtimer_init,timer:hrtimer_start"
+
+TESTPROG="perf test -w landlock_add_rule"
+
+. "$(dirname $0)"/lib/probe.sh
+skip_if_no_perf_trace || exit 2
+
+check_vmlinux() {
+  echo "Checking if vmlinux exists"
+  if ! ls /sys/kernel/btf/vmlinux 1>/dev/null 2>&1
+  then
+    echo "trace+enum test [Skipped missing vmlinux BTF support]"
+    err=2
+  fi
+}
+
+trace_landlock() {
+  echo "Tracing syscall ${syscall}"
+  if perf trace -e $syscall $TESTPROG 2>&1 | \
+     grep -q -E ".*landlock_add_rule\(ruleset_fd: 11, rule_type: (LANDLOCK_RULE_PATH_BENEATH|LANDLOCK_RULE_NET_PORT), rule_attr: 0x[a-f0-9]+, flags: 45\) = -1.*"
+  then
+    err=0
+  else
+    err=1
+  fi
+}
+
+trace_non_syscall() {
+  echo "Tracing non-syscall tracepoint ${non-syscall}"
+  if perf trace -e $non_syscall --max-events=1 2>&1 | \
+     grep -q -E '.*timer:hrtimer_.*\(.*mode: HRTIMER_MODE_.*\)$'
+  then
+    err=0
+  else
+    err=1
+  fi
+}
+
+check_vmlinux
+
+if [ $err = 0 ]; then
+  trace_landlock
+fi
+
+if [ $err = 0 ]; then
+  trace_non_syscall
+fi
+
+exit $err
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 3aa7701ee0e9..69126299bb08 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -205,6 +205,7 @@ DECLARE_WORKLOAD(leafloop);
 DECLARE_WORKLOAD(sqrtloop);
 DECLARE_WORKLOAD(brstack);
 DECLARE_WORKLOAD(datasym);
+DECLARE_WORKLOAD(landlock_add_rule);
 
 extern const char *dso_to_test;
 extern const char *test_objdump_path;
diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index a1f34d5861e3..5b12b93ecffa 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -6,6 +6,7 @@ perf-y += leafloop.o
 perf-y += sqrtloop.o
 perf-y += brstack.o
 perf-y += datasym.o
+perf-y += landlock_add_rule.o
 
 CFLAGS_sqrtloop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer -U_FORTIFY_SOURCE
diff --git a/tools/perf/tests/workloads/landlock_add_rule.c b/tools/perf/tests/workloads/landlock_add_rule.c
new file mode 100644
index 000000000000..529b5f1ea5a7
--- /dev/null
+++ b/tools/perf/tests/workloads/landlock_add_rule.c
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/compiler.h>
+#include <uapi/asm-generic/unistd.h> // for __NR_landlock_add_rule
+#include <unistd.h>
+#include <linux/landlock.h>
+#include "../tests.h"
+
+static int landlock_add_rule(int argc __maybe_unused, const char **argv __maybe_unused)
+{
+	int fd = 11;
+	int flags = 45;
+
+	struct landlock_path_beneath_attr path_beneath_attr = {
+	    .allowed_access = LANDLOCK_ACCESS_FS_READ_FILE,
+	    .parent_fd = 14,
+	};
+
+	struct landlock_net_port_attr net_port_attr = {
+	    .port = 19,
+	    .allowed_access = LANDLOCK_ACCESS_NET_CONNECT_TCP,
+	};
+
+	syscall(__NR_landlock_add_rule, fd, LANDLOCK_RULE_PATH_BENEATH,
+		&path_beneath_attr, flags);
+
+	syscall(__NR_landlock_add_rule, fd, LANDLOCK_RULE_NET_PORT,
+		&net_port_attr, flags);
+
+	return 0;
+}
+
+DEFINE_WORKLOAD(landlock_add_rule);
-- 
2.45.2

