Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF3D548554;
	Tue, 13 Oct 2026 20:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922478; cv=none; b=fw9ViLfl6z3mOZ6KLWhKNiCDl+w8D1Wtl+wcGTe2TCqImqd5nYH6RBE1N8Bzp5xRzFmZLEk+m+DEsPQpyNm2mM0plH5HNtLJg375WTt+BICbLrK7q/ac662aBVQufLwQOfiVs7KX6P7MXRjsWWcBnT1yeHSUMIOEJzKGGyyV118=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922478; c=relaxed/simple;
	bh=t+E4tfGih3vpPFUBNIItrMqIS5ICE/llhm1+MlVKsK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tyf7luTwUN+7QC5fcDjQSdHP3//iki8zBjCQou05R9gnr/WThEtANhxmOh1t29IfRqkd0TXOWiUgvQG3JOzW6zxS5GA5pQ8Lu/jzdM0dCjYzkvpqcGESPyUB9Z1JHjYKI3wxe9OFk/k0snCufla2VT79mzKGWMm+Alm3sSVWZQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWztGbTe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWztGbTe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4771F00893;
	Tue, 13 Oct 2026 20:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791922475;
	bh=ThfGu+E8dYc3sCcwVfn5sEvFJjR1zE67fI30NdxP95g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YWztGbTeHZ8ZsEtvrrYLg2cgsY0+r1sB7wnLek1f5ame0JbAr9vxaj3TICpMx6cg7
	 mn4BzQQJDSx+ojgaB1lGA2fo1mx/vJhQ8S5Gob8LWqKuOy1trrGZRFOaA3KXeewpXo
	 JjPO4S9msJowJEnVQBFB2MuN0XvhjlI297Qj1OwlG+XHF67Zp51WZVTmrOBc4hb/0S
	 NrOXIjB9zhyBIPCHIfOgW5hZP9R+X9m17N5Ev5i7LGlbYVxGMG0xHIqWf/09UuU6dp
	 z9Y80M1ulznYDGDdZCgaVOWCFNDAgCAxw8FWfpBH0cjHY3RBdO3k5cXqfqPEIL0cVv
	 lC/RIEAZ0K+bQ==
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
Subject: [PATCH v2 03/19] perf test attr: Fix legacy event encodings in group tests
Date: Tue, 13 Oct 2026 17:13:58 -0300
Message-ID: <20261013201415.36428-4-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013201415.36428-1-acme@kernel.org>
References: <20261013201415.36428-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since commit b1c5efbfd92e ("perf parse-events: Remove hard coded legacy
hardware and cache parsing"), event names are resolved with sysfs/JSON
priority over the legacy encodings, so bare cache-misses and
instructions now become the core PMU sysfs/JSON events (on x86 type 4,
configs 0x412e and 0xc0) rather than the legacy
PERF_TYPE_HARDWARE/config=3 and config=1 events the tests expect, e.g.:

  expected config=3, got 0
  expected disabled=0, got 1
  expected mmap=0, got 1
  expected comm=0, got 1
  expected freq=0, got 1
  expected enable_on_exec=0, got 1
  expected task=0, got 1
  FAILED '.../test-record-group-sampling1' - match failure

The shown diff is against the cycles group leader, as no result event
matches the expected cache-misses member anymore.

Request the legacy encodings explicitly with the legacy-hardware-config
term, introduced for this purpose, keeping the original attribute
expectations unchanged, in:

  test-record-group1
  test-record-group2
  test-record-group3
  test-record-group-sampling
  test-record-group-sampling1
  test-record-group-sampling2
  test-stat-group1

This went unnoticed until tests/attr.sh stopped ignoring attr.py's
return value.

Fixes: b1c5efbfd92eb84d ("perf parse-events: Remove hard coded legacy hardware and cache parsing")
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/attr/README                     | 10 +++++-----
 tools/perf/tests/shell/attr/test-record-group-sampling |  4 ++--
 .../perf/tests/shell/attr/test-record-group-sampling1  |  4 ++--
 .../perf/tests/shell/attr/test-record-group-sampling2  |  4 ++--
 tools/perf/tests/shell/attr/test-record-group1         |  2 +-
 tools/perf/tests/shell/attr/test-record-group2         |  2 +-
 tools/perf/tests/shell/attr/test-record-group3         |  2 +-
 tools/perf/tests/shell/attr/test-stat-group1           |  2 +-
 8 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/perf/tests/shell/attr/README b/tools/perf/tests/shell/attr/README
index 67c4ca76b85d5611..c7b49cdf87297177 100644
--- a/tools/perf/tests/shell/attr/README
+++ b/tools/perf/tests/shell/attr/README
@@ -49,10 +49,10 @@ Following tests are defined (with perf commands):
   perf record --call-graph dwarf kill		(test-record-graph-dwarf)
   perf record --call-graph fp kill              (test-record-graph-fp)
   perf record --call-graph fp kill              (test-record-graph-fp-aarch64)
-  perf record -e '{cycles,instructions}' kill   (test-record-group1)
-  perf record -e '{cycles/period=1/,instructions/period=2/}:S' kill (test-record-group2)
-  perf record -e '{cycles,cache-misses}:S' kill (test-record-group-sampling1)
-  perf record -c 10000 -e '{cycles,cache-misses}:S' kill (test-record-group-sampling2)
+  perf record -e '{cycles,default_core/legacy-hardware-config=1/}' kill (test-record-group1)
+  perf record -e '{cycles/period=1234000/,default_core/legacy-hardware-config=1,period=6789000/}:S' kill (test-record-group2)
+  perf record -e '{cycles,default_core/legacy-hardware-config=3/}:S' kill (test-record-group-sampling1)
+  perf record -c 10000 -e '{cycles,default_core/legacy-hardware-config=3/}:S' kill (test-record-group-sampling2)
   perf record -D kill                           (test-record-no-delay)
   perf record -i kill                           (test-record-no-inherit)
   perf record -n kill                           (test-record-no-samples)
@@ -67,5 +67,5 @@ Following tests are defined (with perf commands):
   perf stat -d kill                             (test-stat-detailed-1)
   perf stat -dd kill                            (test-stat-detailed-2)
   perf stat -ddd kill                           (test-stat-detailed-3)
-  perf stat -e '{cycles,instructions}' kill     (test-stat-group1)
+  perf stat -e '{cycles,default_core/legacy-hardware-config=1/}' kill (test-stat-group1)
   perf stat -i -e cycles kill                   (test-stat-no-inherit)
diff --git a/tools/perf/tests/shell/attr/test-record-group-sampling b/tools/perf/tests/shell/attr/test-record-group-sampling
index b43d9fe3af75c096..ed47dd1e5984535b 100644
--- a/tools/perf/tests/shell/attr/test-record-group-sampling
+++ b/tools/perf/tests/shell/attr/test-record-group-sampling
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = --no-bpf-event -e '{cycles,cache-misses}:S' kill >/dev/null 2>&1
+args    = --no-bpf-event -e '{cycles,default_core/legacy-hardware-config=3/}:S' kill >/dev/null 2>&1
 ret     = 1
 kernel_until = 6.12
 requires = core-pmu
@@ -16,7 +16,7 @@ inherit=0
 fd=2
 group_fd=1
 
-# cache-misses
+# cache-misses, explicitly requested with the legacy hardware encoding
 type=0
 config=3
 
diff --git a/tools/perf/tests/shell/attr/test-record-group-sampling1 b/tools/perf/tests/shell/attr/test-record-group-sampling1
index 3def72161820dca3..9cf013dc03dd0309 100644
--- a/tools/perf/tests/shell/attr/test-record-group-sampling1
+++ b/tools/perf/tests/shell/attr/test-record-group-sampling1
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = --no-bpf-event -e '{cycles,cache-misses}:S' kill >/dev/null 2>&1
+args    = --no-bpf-event -e '{cycles,default_core/legacy-hardware-config=3/}:S' kill >/dev/null 2>&1
 ret     = 1
 kernel_since = 6.12
 requires = core-pmu
@@ -31,7 +31,7 @@ inherit=1
 fd=2
 group_fd=1
 
-# cache-misses
+# cache-misses, explicitly requested with the legacy hardware encoding
 type=0
 config=3
 
diff --git a/tools/perf/tests/shell/attr/test-record-group-sampling2 b/tools/perf/tests/shell/attr/test-record-group-sampling2
index 227c18bb221c4b2f..bd1eb4161e4aee46 100644
--- a/tools/perf/tests/shell/attr/test-record-group-sampling2
+++ b/tools/perf/tests/shell/attr/test-record-group-sampling2
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = --no-bpf-event -c 10000 -e '{cycles,cache-misses}:S' kill >/dev/null 2>&1
+args    = --no-bpf-event -c 10000 -e '{cycles,default_core/legacy-hardware-config=3/}:S' kill >/dev/null 2>&1
 ret     = 1
 kernel_since = 6.12
 requires = core-pmu
@@ -37,7 +37,7 @@ write_backward=0
 fd=2
 group_fd=1
 
-# cache-misses
+# cache-misses, explicitly requested with the legacy hardware encoding
 type=0
 config=3
 
diff --git a/tools/perf/tests/shell/attr/test-record-group1 b/tools/perf/tests/shell/attr/test-record-group1
index a57c7ee8aaa4f9c9..5fdd5288555f32ea 100644
--- a/tools/perf/tests/shell/attr/test-record-group1
+++ b/tools/perf/tests/shell/attr/test-record-group1
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = --no-bpf-event -e '{cycles,instructions}' kill >/dev/null 2>&1
+args    = --no-bpf-event -e '{cycles,default_core/legacy-hardware-config=1/}' kill >/dev/null 2>&1
 ret     = 1
 requires = core-pmu
 
diff --git a/tools/perf/tests/shell/attr/test-record-group2 b/tools/perf/tests/shell/attr/test-record-group2
index fb6e664eeacc10ef..e7274108f5fd7e7b 100644
--- a/tools/perf/tests/shell/attr/test-record-group2
+++ b/tools/perf/tests/shell/attr/test-record-group2
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = --no-bpf-event -e '{cycles/period=1234000/,instructions/period=6789000/}:S' kill >/dev/null 2>&1
+args    = --no-bpf-event -e '{cycles/period=1234000/,default_core/legacy-hardware-config=1,period=6789000/}:S' kill >/dev/null 2>&1
 ret     = 1
 kernel_until = 6.12
 requires = core-pmu
diff --git a/tools/perf/tests/shell/attr/test-record-group3 b/tools/perf/tests/shell/attr/test-record-group3
index 7b90b4411d8f4b90..e74fd3a48ac9094f 100644
--- a/tools/perf/tests/shell/attr/test-record-group3
+++ b/tools/perf/tests/shell/attr/test-record-group3
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = --no-bpf-event -e '{cycles/period=1234000/,instructions/period=6789000/}:S' kill >/dev/null 2>&1
+args    = --no-bpf-event -e '{cycles/period=1234000/,default_core/legacy-hardware-config=1,period=6789000/}:S' kill >/dev/null 2>&1
 ret     = 1
 kernel_since = 6.12
 requires = core-pmu
diff --git a/tools/perf/tests/shell/attr/test-stat-group1 b/tools/perf/tests/shell/attr/test-stat-group1
index 3d8b44ba42d6ae19..7a31b27933f11959 100644
--- a/tools/perf/tests/shell/attr/test-stat-group1
+++ b/tools/perf/tests/shell/attr/test-stat-group1
@@ -1,6 +1,6 @@
 [config]
 command = stat
-args    = -e '{cycles,instructions}' kill >/dev/null 2>&1
+args    = -e '{cycles,default_core/legacy-hardware-config=1/}' kill >/dev/null 2>&1
 ret     = 1
 requires = core-pmu
 
-- 
2.55.0

