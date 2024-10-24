Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896831B0F18
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Oct 2024 07:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729755223; cv=none; b=DKxb+8cjnvjpwUXQvcBq3Qbb16ONiSJpe8sU9BAIZitm7Z3tzvttfA3txL9inCSTncuSrE6cdWX8h0q35G2PgYumYdg2vonlJ4pW86SxGNpTiypl92vwObXGhSTj+MxNidDvjBfzuCzlplE4YgtjkfQDSk6jiE7tJILnGYlaOHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729755223; c=relaxed/simple;
	bh=mzs9bpF6JHwXJ8hIAxSNZGhb19FZ05kQ6DmUcVcuGGM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=bglLRY60/sNf6wX8tkREIoISCiDDsVIjD6klV85YZTiGdtqy62khk4siylxPojwOxEFadqZk1GwKsAx5cJPOXfhfooIHr/yaDvfNpxXtlleh8rNcIxUFhOa8XkPYtdJtEWbi9kcg7+tQESZ1ZVAGqcqJZo9uIVwFOcQCqw5m+/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W63uR3LJ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W63uR3LJ"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e165fc5d94fso1300448276.2
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Oct 2024 00:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729755219; x=1730360019; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yoDrzi0jU1SDEZaATimUzGZrwxZdaWaGm3pLE7ogKGc=;
        b=W63uR3LJEznTv6uvLVXibK18/sBISfhWdvQgWhFhe1dBqHlH9F0HruuO98Se/1QSnr
         a8nJTZL+cherxzt/3NKYuiIEEYq+djRwvAJfcs7o6W3EO37HBPqbQ4JVUMmVLhWFiOU7
         7mg7rwyyHliMqLC+eWp2j2+bHuqMC0WupMVWIFsUw+jflo7wwNJmGC3BYCLkqG0nc6oi
         014PYWYNuv1r0Zpy9SJFVVPqE/lQ3PsgoGVL0XIBWh+4pyTmA7hKwnrwIVA4FjSSqTZe
         ucyDG9FhF3oB1e86CpqTDoB9bNkFHuPTq3k5fsbBfh4HVmw7H02XeE0ukJRZ6gcwNq9K
         Fnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729755219; x=1730360019;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yoDrzi0jU1SDEZaATimUzGZrwxZdaWaGm3pLE7ogKGc=;
        b=tQFh048Zlarb6MSSrcVHBifD4I0ttSeNjC92tZg+9CN26jYhfdIMaPEj43JG/rcbY3
         2glFHfHdKZ9HlAAXXpn3mZ2fKOCHwIkm/6cfqxgKrafnW8zFMkumDwLMVQaS8qFF85b0
         DJNTdTEOIfLQvmiGC7hWuXSDWg1oo+fTeW514De3ZyZXqk4lv7CFakU4nEbA8abt1dL5
         hBJHSHMUQYYra6IvH397j1RZIjnVi4CfRKxUulL5zrgz0puDF4FBWGo3kmN7J/s+/kNI
         EX0j6J+wX4X/obxaIhY3I2S+nEOHklcrXguti1bTAZmb1zLa+UVD4EpZZv52c0A7JyVS
         NlYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyqCDoNUZUprMR8wcx2GEk/c5GqzqMzJ/QcKG8k7ZJzGMTKQlycLc8bRnWM8W+uC6es2S8vaywwLK52mlQXbfi@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/KanOkAshRSSidAY1pxmAvwdRCFhFyZaIRiscIx7QylNh8Gxz
	KZ6vNZFkmMBboJhVFpy2RShdKR2BAy1F9HnkGM7gYOeJOx7p+hLgTry6R6bYiR+XQwWLaUQI0DF
	oc9Oz9w==
X-Google-Smtp-Source: AGHT+IFfChWNLIB2mUkSnuKKVqSRAHn4XQBzn3+pf1GdHvalOj6torjmW24OVSVViNgdqzFBtdZ3QxP1jdpv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:2391:e0be:5394:f85d])
 (user=irogers job=sendgmr) by 2002:a25:d810:0:b0:e29:7479:402a with SMTP id
 3f1490d57ef6-e2f2fc4964dmr1671276.10.1729755219393; Thu, 24 Oct 2024 00:33:39
 -0700 (PDT)
Date: Thu, 24 Oct 2024 00:33:19 -0700
In-Reply-To: <20241024073324.1513433-1-irogers@google.com>
Message-Id: <20241024073324.1513433-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241024073324.1513433-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v4 05/10] perf test: Tag parallel failing shell tests with "(exclusive)"
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Some shell tests compete for resources and so can't run with other
tests, tag such tests.  The "(exclusive)" stems from shared/exclusive
to describe how the tests run as if holding a lock.

For ARM/coresight tests:
Suggested-by: James Clark <james.clark@linaro.org>

Additional failing tests:
Suggested-by: Namhyung Kim <namhyung@kernel.org>

Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/coresight/asm_pure_loop.sh            | 2 +-
 tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh     | 2 +-
 tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh | 2 +-
 tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh  | 2 +-
 tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh    | 2 +-
 tools/perf/tests/shell/perftool-testsuite_report.sh          | 2 +-
 tools/perf/tests/shell/probe_vfs_getname.sh                  | 2 +-
 tools/perf/tests/shell/record+script_probe_vfs_getname.sh    | 2 +-
 tools/perf/tests/shell/record.sh                             | 2 +-
 tools/perf/tests/shell/record_lbr.sh                         | 2 +-
 tools/perf/tests/shell/record_offcpu.sh                      | 2 +-
 tools/perf/tests/shell/stat_all_pmu.sh                       | 2 +-
 tools/perf/tests/shell/stat_bpf_counters.sh                  | 2 +-
 tools/perf/tests/shell/test_arm_coresight.sh                 | 2 +-
 tools/perf/tests/shell/test_arm_coresight_disasm.sh          | 2 +-
 tools/perf/tests/shell/test_arm_spe.sh                       | 2 +-
 tools/perf/tests/shell/test_data_symbol.sh                   | 2 +-
 tools/perf/tests/shell/test_intel_pt.sh                      | 2 +-
 tools/perf/tests/shell/test_stat_intel_tpebs.sh              | 2 +-
 tools/perf/tests/shell/trace+probe_vfs_getname.sh            | 2 +-
 20 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/tools/perf/tests/shell/coresight/asm_pure_loop.sh b/tools/perf/tests/shell/coresight/asm_pure_loop.sh
index 2d65defb7e0f..c63bc8c73e26 100755
--- a/tools/perf/tests/shell/coresight/asm_pure_loop.sh
+++ b/tools/perf/tests/shell/coresight/asm_pure_loop.sh
@@ -1,5 +1,5 @@
 #!/bin/sh -e
-# CoreSight / ASM Pure Loop
+# CoreSight / ASM Pure Loop (exclusive)
 
 # SPDX-License-Identifier: GPL-2.0
 # Carsten Haitzler <carsten.haitzler@arm.com>, 2021
diff --git a/tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh b/tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh
index ddcc9bb850f5..8e29630957c8 100755
--- a/tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh
+++ b/tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh
@@ -1,5 +1,5 @@
 #!/bin/sh -e
-# CoreSight / Memcpy 16k 10 Threads
+# CoreSight / Memcpy 16k 10 Threads (exclusive)
 
 # SPDX-License-Identifier: GPL-2.0
 # Carsten Haitzler <carsten.haitzler@arm.com>, 2021
diff --git a/tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh b/tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh
index 2ce5e139b2fd..0c4c82a1c8e1 100755
--- a/tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh
+++ b/tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh
@@ -1,5 +1,5 @@
 #!/bin/sh -e
-# CoreSight / Thread Loop 10 Threads - Check TID
+# CoreSight / Thread Loop 10 Threads - Check TID (exclusive)
 
 # SPDX-License-Identifier: GPL-2.0
 # Carsten Haitzler <carsten.haitzler@arm.com>, 2021
diff --git a/tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh b/tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh
index 3ad9498753d7..d3aea9fc6ced 100755
--- a/tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh
+++ b/tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh
@@ -1,5 +1,5 @@
 #!/bin/sh -e
-# CoreSight / Thread Loop 2 Threads - Check TID
+# CoreSight / Thread Loop 2 Threads - Check TID (exclusive)
 
 # SPDX-License-Identifier: GPL-2.0
 # Carsten Haitzler <carsten.haitzler@arm.com>, 2021
diff --git a/tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh b/tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh
index 4fbb4a29aad3..7429d3a2ae43 100755
--- a/tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh
+++ b/tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh
@@ -1,5 +1,5 @@
 #!/bin/sh -e
-# CoreSight / Unroll Loop Thread 10
+# CoreSight / Unroll Loop Thread 10 (exclusive)
 
 # SPDX-License-Identifier: GPL-2.0
 # Carsten Haitzler <carsten.haitzler@arm.com>, 2021
diff --git a/tools/perf/tests/shell/perftool-testsuite_report.sh b/tools/perf/tests/shell/perftool-testsuite_report.sh
index 973012ce92a7..a8cf75b4e77e 100755
--- a/tools/perf/tests/shell/perftool-testsuite_report.sh
+++ b/tools/perf/tests/shell/perftool-testsuite_report.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perftool-testsuite_report
+# perftool-testsuite_report (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 test -d "$(dirname "$0")/base_report" || exit 2
diff --git a/tools/perf/tests/shell/probe_vfs_getname.sh b/tools/perf/tests/shell/probe_vfs_getname.sh
index 554e12e83c55..0c5aacc446b3 100755
--- a/tools/perf/tests/shell/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/probe_vfs_getname.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Add vfs_getname probe to get syscall args filenames
+# Add vfs_getname probe to get syscall args filenames (exclusive)
 
 # SPDX-License-Identifier: GPL-2.0
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
diff --git a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
index 9a61928e3c9a..5940fdc1df37 100755
--- a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Use vfs_getname probe to get syscall args filenames
+# Use vfs_getname probe to get syscall args filenames (exclusive)
 
 # Uses the 'perf test shell' library to add probe:vfs_getname to the system
 # then use it with 'perf record' using 'touch' to write to a temp file, then
diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index f0e79200b981..85d512f5a126 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf record tests
+# perf record tests (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
diff --git a/tools/perf/tests/shell/record_lbr.sh b/tools/perf/tests/shell/record_lbr.sh
index 32314641217e..8d750ee631f8 100755
--- a/tools/perf/tests/shell/record_lbr.sh
+++ b/tools/perf/tests/shell/record_lbr.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf record LBR tests
+# perf record LBR tests (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/shell/record_offcpu.sh
index 67c925f3a15a..678947fe69ee 100755
--- a/tools/perf/tests/shell/record_offcpu.sh
+++ b/tools/perf/tests/shell/record_offcpu.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# perf record offcpu profiling tests
+# perf record offcpu profiling tests (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/shell/stat_all_pmu.sh
index 42456d89c5da..8b148b300be1 100755
--- a/tools/perf/tests/shell/stat_all_pmu.sh
+++ b/tools/perf/tests/shell/stat_all_pmu.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf all PMU test
+# perf all PMU test (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
index f250b7d6f773..a038c1b1a706 100755
--- a/tools/perf/tests/shell/stat_bpf_counters.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# perf stat --bpf-counters test
+# perf stat --bpf-counters test (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
index 6b8c4831eedc..573af9235b72 100755
--- a/tools/perf/tests/shell/test_arm_coresight.sh
+++ b/tools/perf/tests/shell/test_arm_coresight.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Check Arm CoreSight trace data recording and synthesized samples
+# Check Arm CoreSight trace data recording and synthesized samples (exclusive)
 
 # Uses the 'perf record' to record trace data with Arm CoreSight sinks;
 # then verify if there have any branch samples and instruction samples
diff --git a/tools/perf/tests/shell/test_arm_coresight_disasm.sh b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
index dba086a40d84..be2d26303f94 100755
--- a/tools/perf/tests/shell/test_arm_coresight_disasm.sh
+++ b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Check Arm CoreSight disassembly script completes without errors
+# Check Arm CoreSight disassembly script completes without errors (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 # The disassembly script reconstructs ranges of instructions and gives these to objdump to
diff --git a/tools/perf/tests/shell/test_arm_spe.sh b/tools/perf/tests/shell/test_arm_spe.sh
index 6c21fb1f10d8..3258368634f7 100755
--- a/tools/perf/tests/shell/test_arm_spe.sh
+++ b/tools/perf/tests/shell/test_arm_spe.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Check Arm SPE trace data recording and synthesized samples
+# Check Arm SPE trace data recording and synthesized samples (exclusive)
 
 # Uses the 'perf record' to record trace data of Arm SPE events;
 # then verify if any SPE event samples are generated by SPE with
diff --git a/tools/perf/tests/shell/test_data_symbol.sh b/tools/perf/tests/shell/test_data_symbol.sh
index 3dfa91832aa8..c86da0235059 100755
--- a/tools/perf/tests/shell/test_data_symbol.sh
+++ b/tools/perf/tests/shell/test_data_symbol.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# Test data symbol
+# Test data symbol (exclusive)
 
 # SPDX-License-Identifier: GPL-2.0
 # Leo Yan <leo.yan@linaro.org>, 2022
diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index bf9017b812aa..e6f0070975f6 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Miscellaneous Intel PT testing
+# Miscellaneous Intel PT testing (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
diff --git a/tools/perf/tests/shell/test_stat_intel_tpebs.sh b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
index 9a11f42d153c..f95fc64bf0a7 100755
--- a/tools/perf/tests/shell/test_stat_intel_tpebs.sh
+++ b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# test Intel TPEBS counting mode
+# test Intel TPEBS counting mode (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
index 97b4b9cd2378..708a13f00635 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Check open filename arg using perf trace + vfs_getname
+# Check open filename arg using perf trace + vfs_getname (exclusive)
 
 # Uses the 'perf test shell' library to add probe:vfs_getname to the system
 # then use it with 'perf trace' using 'touch' to write to a temp file, then
-- 
2.47.0.163.g1226f6d8fa-goog

