Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD6D274B53;
	Fri, 16 Oct 2026 00:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792109978; cv=none; b=t3dLC2ww71dIhMKMBp1m6KOR1FRGuAftZfAfpbDq2JO1IYAjOk7OVasKiX7prfG55nSByjWqDTUFkCZIcdMbQgtzoUD6gyirr4Yen11bEE0vpHVoZI2Qh7PX8KNSpo4lD2mUXbskYsIyjCsQEprYfUZZ7+4eVGp/uQTeYBk4UP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792109978; c=relaxed/simple;
	bh=3Kb9em5FMFYZuE5472BeV4xNe+VYBgnd1Wzf3UTQtfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1gV0gBpbAzULxZs0jDqF35/ifHPRdT91JGQb6qTEITBfVh/SmphN2PC4zCZTaJgz074+pvpFjEMnIkt1Q9BqGaH9yKsTEpuhiR8BOWxRX6o4ENzZPu25ct55wN/qpiYLABCcrkLKJLfin2c2rUsodvThl2SXnJFT+bQhGM/130=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MV95/EKh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MV95/EKh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548341F000C5;
	Fri, 16 Oct 2026 00:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792109976;
	bh=hSL1j5xAyoTslHpt3OLlOBt1Mfp8Stg5mYSfwvg6/xA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MV95/EKhcEHKKLmQsM+JWlpyVzfWZeT8s+URqnFHIMVox1cfCVo+PsWAvkNT72nEn
	 toy4aOrOdtphDLgCt/4kVxaTRzjtmBwS7DVD78JS2F1BCMbAB3bCjdNGNLN2TwxhMk
	 hWnVBEaa2w5oQU2Qwi6iNKnxKMmJo6tMK9iyxAGw0rm22pir/byTgpdXqKPQoWky5C
	 vuchi+fdLvuyq7FNxWHKhItvbnfmrJmVgO6MRgCC4NRnDU5U5wiW3+MqOsN7nsROB9
	 c+v3Oe+dh+0BrOg3wdX9BX86SJ+bHGEF3p0WgZ3Y284cAEcin+O3NaTxHa1oTwQa60
	 IN7YCdosHPPFg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v3 17/19] perf tests: Mark the shell tests not mapping perf ring buffers
Date: Thu, 15 Oct 2026 21:18:41 -0300
Message-ID: <20261016001843.71978-18-acme@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016001843.71978-1-acme@kernel.org>
References: <20261016001843.71978-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Shell tests run perf, that maps ring buffers, so they take a turn using
the per user budget in kernel.perf_event_mlock_kb by default; the ones
that don't map them, like the ones running just 'perf stat', say
" (no_mlock)" in their description line and thus keep running in parallel
with the ones taking turns.

The 'perf sched stats' tests are among them, they synthesize the samples
from /proc/schedstat without mapping a ring buffer, and the tests already
marked " (exclusive)" don't need it, exclusive implies every other
requisite and keeps them running alone.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/drm_pmu.sh                       | 2 +-
 tools/perf/tests/shell/ftrace.sh                        | 2 +-
 tools/perf/tests/shell/kallsyms.sh                      | 2 +-
 tools/perf/tests/shell/list.sh                          | 2 +-
 tools/perf/tests/shell/perf_sched_stats.sh              | 2 +-
 tools/perf/tests/shell/probe_vfs_getname.sh             | 2 +-
 tools/perf/tests/shell/python-use.sh                    | 2 +-
 tools/perf/tests/shell/schedstat_snapshots.sh           | 2 +-
 tools/perf/tests/shell/stat+csv_output.sh               | 2 +-
 tools/perf/tests/shell/stat+csv_summary.sh              | 2 +-
 tools/perf/tests/shell/stat+event_uniquifying.sh        | 2 +-
 tools/perf/tests/shell/stat+json_output.sh              | 2 +-
 tools/perf/tests/shell/stat+shadow_stat.sh              | 2 +-
 tools/perf/tests/shell/stat+std_output.sh               | 2 +-
 tools/perf/tests/shell/stat.sh                          | 2 +-
 tools/perf/tests/shell/stat_all_metricgroups.sh         | 2 +-
 tools/perf/tests/shell/stat_all_metrics.sh              | 2 +-
 tools/perf/tests/shell/stat_all_pfm.sh                  | 2 +-
 tools/perf/tests/shell/stat_bpf_counters_cgrp.sh        | 2 +-
 tools/perf/tests/shell/stat_metrics_cgrp.sh             | 2 +-
 tools/perf/tests/shell/stat_metrics_values.sh           | 2 +-
 tools/perf/tests/shell/test_ilist_python.sh             | 2 +-
 tools/perf/tests/shell/test_stat_cpi_python.sh          | 2 +-
 tools/perf/tests/shell/test_test_junit_output.sh        | 5 ++++-
 tools/perf/tests/shell/test_uprobe_from_different_cu.sh | 2 +-
 25 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/tools/perf/tests/shell/drm_pmu.sh b/tools/perf/tests/shell/drm_pmu.sh
index e629fe0e8463d6cc..c827e613fc66ee0f 100755
--- a/tools/perf/tests/shell/drm_pmu.sh
+++ b/tools/perf/tests/shell/drm_pmu.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# DRM PMU
+# DRM PMU (no_mlock)
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
diff --git a/tools/perf/tests/shell/ftrace.sh b/tools/perf/tests/shell/ftrace.sh
index 9f6e590f6437b2d9..84d6126bf94d1e61 100755
--- a/tools/perf/tests/shell/ftrace.sh
+++ b/tools/perf/tests/shell/ftrace.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf ftrace tests
+# perf ftrace tests (no_mlock)
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
diff --git a/tools/perf/tests/shell/kallsyms.sh b/tools/perf/tests/shell/kallsyms.sh
index d0eb99753f477f57..e3674cc52b30983f 100755
--- a/tools/perf/tests/shell/kallsyms.sh
+++ b/tools/perf/tests/shell/kallsyms.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf kallsyms tests
+# perf kallsyms tests (no_mlock)
 # SPDX-License-Identifier: GPL-2.0
 
 err=0
diff --git a/tools/perf/tests/shell/list.sh b/tools/perf/tests/shell/list.sh
index 14a03e0290ed1b4d..d4a0b04154d636f0 100755
--- a/tools/perf/tests/shell/list.sh
+++ b/tools/perf/tests/shell/list.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf list tests
+# perf list tests (no_mlock)
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
diff --git a/tools/perf/tests/shell/perf_sched_stats.sh b/tools/perf/tests/shell/perf_sched_stats.sh
index f13eb0a75b76ef5a..4ede9d701630c719 100755
--- a/tools/perf/tests/shell/perf_sched_stats.sh
+++ b/tools/perf/tests/shell/perf_sched_stats.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# perf sched stats tests
+# perf sched stats tests (no_mlock)
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
diff --git a/tools/perf/tests/shell/probe_vfs_getname.sh b/tools/perf/tests/shell/probe_vfs_getname.sh
index c40e5f3f0825b051..43bdd693076b408c 100755
--- a/tools/perf/tests/shell/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/probe_vfs_getname.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# Add vfs_getname probe to get syscall args filenames
+# Add vfs_getname probe to get syscall args filenames (no_mlock)
 # SPDX-License-Identifier: GPL-2.0
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
 
diff --git a/tools/perf/tests/shell/python-use.sh b/tools/perf/tests/shell/python-use.sh
index 2d6017d5dd9d9eab..ece4d306869ae48e 100755
--- a/tools/perf/tests/shell/python-use.sh
+++ b/tools/perf/tests/shell/python-use.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# 'import perf' in python
+# 'import perf' in python (no_mlock)
 # SPDX-License-Identifier: GPL-2.0
 # Just test if we can load the python binding.
 set -e
diff --git a/tools/perf/tests/shell/schedstat_snapshots.sh b/tools/perf/tests/shell/schedstat_snapshots.sh
index a4bdf2673d43ccc0..2050478e3f1a682f 100755
--- a/tools/perf/tests/shell/schedstat_snapshots.sh
+++ b/tools/perf/tests/shell/schedstat_snapshots.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Validate CPU and domain pairing in perf sched stats snapshots
+# Validate CPU and domain pairing in perf sched stats snapshots (no_mlock)
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests/shell/stat+csv_output.sh
index a5b34c42e8d72aff..8beb6c674d055a52 100755
--- a/tools/perf/tests/shell/stat+csv_output.sh
+++ b/tools/perf/tests/shell/stat+csv_output.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf stat CSV output linter
+# perf stat CSV output linter (no_mlock)
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 # Tests various perf stat CSV output commands for the
 # correct number of fields and the CSV separator set to ','.
diff --git a/tools/perf/tests/shell/stat+csv_summary.sh b/tools/perf/tests/shell/stat+csv_summary.sh
index 9a4353db3825ede9..6d8beb88fb6f300a 100755
--- a/tools/perf/tests/shell/stat+csv_summary.sh
+++ b/tools/perf/tests/shell/stat+csv_summary.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf stat csv summary test
+# perf stat csv summary test (no_mlock)
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
diff --git a/tools/perf/tests/shell/stat+event_uniquifying.sh b/tools/perf/tests/shell/stat+event_uniquifying.sh
index b5dec6b6da369382..f5c6fa30d8db38d1 100755
--- a/tools/perf/tests/shell/stat+event_uniquifying.sh
+++ b/tools/perf/tests/shell/stat+event_uniquifying.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf stat events uniquifying
+# perf stat events uniquifying (no_mlock)
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
diff --git a/tools/perf/tests/shell/stat+json_output.sh b/tools/perf/tests/shell/stat+json_output.sh
index 4969ad70b67b6196..cbf7a4ffd7e8ab4f 100755
--- a/tools/perf/tests/shell/stat+json_output.sh
+++ b/tools/perf/tests/shell/stat+json_output.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf stat JSON output linter
+# perf stat JSON output linter (no_mlock)
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 # Checks various perf stat JSON output commands for the
 # correct number of fields.
diff --git a/tools/perf/tests/shell/stat+shadow_stat.sh b/tools/perf/tests/shell/stat+shadow_stat.sh
index cabbbf17c662df23..7a58e1507ce27957 100755
--- a/tools/perf/tests/shell/stat+shadow_stat.sh
+++ b/tools/perf/tests/shell/stat+shadow_stat.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf stat metrics (shadow stat) test
+# perf stat metrics (shadow stat) test (no_mlock)
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
index 64c2b81f02deb18b..b915656a20f69d68 100755
--- a/tools/perf/tests/shell/stat+std_output.sh
+++ b/tools/perf/tests/shell/stat+std_output.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf stat STD output linter
+# perf stat STD output linter (no_mlock)
 # SPDX-License-Identifier: GPL-2.0
 # Tests various perf stat STD output commands for
 # default event and metricgroup
diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 1f5d4cc05807a247..ac9e031831daca9c 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf stat tests
+# perf stat tests (no_mlock)
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf/tests/shell/stat_all_metricgroups.sh
index 81bc7070b5ab0d5c..074a437da0ae3dce 100755
--- a/tools/perf/tests/shell/stat_all_metricgroups.sh
+++ b/tools/perf/tests/shell/stat_all_metricgroups.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf all metricgroups test
+# perf all metricgroups test (no_mlock)
 # SPDX-License-Identifier: GPL-2.0
 
 ParanoidAndNotRoot()
diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
index df5fa27b21ae28d8..9d0d4b8a217e6730 100755
--- a/tools/perf/tests/shell/stat_all_metrics.sh
+++ b/tools/perf/tests/shell/stat_all_metrics.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf all metrics test
+# perf all metrics test (no_mlock)
 # SPDX-License-Identifier: GPL-2.0
 
 ParanoidAndNotRoot()
diff --git a/tools/perf/tests/shell/stat_all_pfm.sh b/tools/perf/tests/shell/stat_all_pfm.sh
index c08c186af2c42e84..78d8006fb729c8f4 100755
--- a/tools/perf/tests/shell/stat_all_pfm.sh
+++ b/tools/perf/tests/shell/stat_all_pfm.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf all libpfm4 events test
+# perf all libpfm4 events test (no_mlock)
 # SPDX-License-Identifier: GPL-2.0
 
 if perf version --build-options | grep HAVE_LIBPFM | grep -q OFF
diff --git a/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh b/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
index febe3af0644157f3..d1b4632c17a3e8e1 100755
--- a/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf stat --bpf-counters --for-each-cgroup test
+# perf stat --bpf-counters --for-each-cgroup test (no_mlock)
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
diff --git a/tools/perf/tests/shell/stat_metrics_cgrp.sh b/tools/perf/tests/shell/stat_metrics_cgrp.sh
index 0728f48f21fa971d..75b8e01d11cc7ff3 100755
--- a/tools/perf/tests/shell/stat_metrics_cgrp.sh
+++ b/tools/perf/tests/shell/stat_metrics_cgrp.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf stat metrics --for-each-cgroup test
+# perf stat metrics --for-each-cgroup test (no_mlock)
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
diff --git a/tools/perf/tests/shell/stat_metrics_values.sh b/tools/perf/tests/shell/stat_metrics_values.sh
index 0982f6b9737a780f..3e073a0e5b9f9b99 100755
--- a/tools/perf/tests/shell/stat_metrics_values.sh
+++ b/tools/perf/tests/shell/stat_metrics_values.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf metrics value validation
+# perf metrics value validation (no_mlock)
 # SPDX-License-Identifier: GPL-2.0
 
 shelldir=$(dirname "$0")
diff --git a/tools/perf/tests/shell/test_ilist_python.sh b/tools/perf/tests/shell/test_ilist_python.sh
index 83048474710d2857..a235539c01767ee5 100755
--- a/tools/perf/tests/shell/test_ilist_python.sh
+++ b/tools/perf/tests/shell/test_ilist_python.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf script ilist and perf list --tui test
+# perf script ilist and perf list --tui test (no_mlock)
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
diff --git a/tools/perf/tests/shell/test_stat_cpi_python.sh b/tools/perf/tests/shell/test_stat_cpi_python.sh
index 6cb376c92e2f13a7..d1571a20f4683d73 100755
--- a/tools/perf/tests/shell/test_stat_cpi_python.sh
+++ b/tools/perf/tests/shell/test_stat_cpi_python.sh
@@ -1,6 +1,6 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
-# stat-cpi python test
+# stat-cpi python test (no_mlock)
 
 set -e
 
diff --git a/tools/perf/tests/shell/test_test_junit_output.sh b/tools/perf/tests/shell/test_test_junit_output.sh
index 38a29e646906e3aa..8fc92e083c342a5c 100755
--- a/tools/perf/tests/shell/test_test_junit_output.sh
+++ b/tools/perf/tests/shell/test_test_junit_output.sh
@@ -1,6 +1,9 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
-# perf test junit XML output validation
+# perf test junit XML output validation (no_mlock)
+#
+# Waiving the mlock requisite this way holds only while the 'perf test'
+# runs below keep picking tests that don't map ring buffers.
 
 set -e
 
diff --git a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
index 33bf36c4037e45ae..0a02ff9b86d6f326 100755
--- a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
+++ b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# test perf probe of function from different CU
+# test perf probe of function from different CU (no_mlock)
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
-- 
2.55.0

