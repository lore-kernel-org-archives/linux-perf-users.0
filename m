Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7DD4A090F;
	Tue,  6 Oct 2026 16:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303224; cv=none; b=t+ZS9B07t7hU9pm+49WMgD4aq/pF2Q8TZQGMtRQbtyAUXwfMKjtSUiJuM1CZa1mBZUbRkTD8UxsGfLPcQ1kyCmtvprmX+uHuDmiK8f6tmxWVxHkEc+kDJLbp8LBT/XsSj7hdTxoIbDzRoPRSMU4x/PGBwEJ1mpwLTwoTp55l3xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303224; c=relaxed/simple;
	bh=cn9ATthoxgRo3l56gSjiqOLCzAPnbVLpZX8bL18SjQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sy3gdE1PA4/Ji/9Oi692mIpuHSwWOLEEfAUo2A8c7/EAl4N59/K8V0Pn8M597VvMpBwVhUGwkoCTPy7apbsklsasTqjCm43z4+p4Dta2N3xdjpzULZY1mlxNrEU6oz61fc841WocqwzsCFHuPu8tilQFQx3RYt7x7CiIhsisW7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHrO7+G6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHrO7+G6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5271F0089B;
	Tue,  6 Oct 2026 16:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791303222;
	bh=jpV8XOLQ2le0NOOJOkcISFewNf3fZzRSgAANTZ8I+MY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KHrO7+G6WlsvR9xnW+FhZdD/zY1WubAM0xAbHfdUzIsinPPyCe/7KVLLZnKQ6mm9y
	 irUvdGi1mLWPS57IhdXfOnTg/ATR/4aUfjhs3s9ijpAZGZL27i3knJHtCxvIHWEBUw
	 PHNJS03sRXJBBim0rXGT7Ex+pPkQXPf4/i0NC252X0g/i1uLnR+Sl5vp07JVrIZya/
	 4zMUmICJtXCOr9SSFbgY6ZXKg+YKlCthLMyaLYMAYURm4Do96FgJKQ+FC9a8FNVVSr
	 5axgYDNtyL3prBrYvFwGkJjk9aDMHCBxypix2oIGcacJJW4wXZ912w8d/p33O0Vubf
	 uD4YM3xMqDKlg==
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
Subject: [PATCH 4/6] perf test attr: Fix legacy event encodings in group tests
Date: Tue,  6 Oct 2026 18:13:07 +0200
Message-ID: <20261006161309.3078488-5-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006161309.3078488-1-acme@kernel.org>
References: <20261006161309.3078488-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since b1c5efbfd92eb84d ("perf parse-events: Remove hard coded legacy
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

This went unnoticed because tests/attr.sh ignored attr.py's return
value until 04a0a19ede01e771 ("perf test attr: Propagate the return
value from the test to the wrapper").

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
index 86a940d7895d7404..766aadef2f1f9ffd 100644
--- a/tools/perf/tests/shell/attr/test-record-group-sampling
+++ b/tools/perf/tests/shell/attr/test-record-group-sampling
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = --no-bpf-event -e '{cycles,cache-misses}:S' kill >/dev/null 2>&1
+args    = --no-bpf-event -e '{cycles,default_core/legacy-hardware-config=3/}:S' kill >/dev/null 2>&1
 ret     = 1
 kernel_until = 6.12
 
@@ -15,7 +15,7 @@ inherit=0
 fd=2
 group_fd=1
 
-# cache-misses
+# cache-misses, explicitly requested with the legacy hardware encoding
 type=0
 config=3
 
diff --git a/tools/perf/tests/shell/attr/test-record-group-sampling1 b/tools/perf/tests/shell/attr/test-record-group-sampling1
index 4748ab7bf68437c7..5be9a1a2a4ff0751 100644
--- a/tools/perf/tests/shell/attr/test-record-group-sampling1
+++ b/tools/perf/tests/shell/attr/test-record-group-sampling1
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = --no-bpf-event -e '{cycles,cache-misses}:S' kill >/dev/null 2>&1
+args    = --no-bpf-event -e '{cycles,default_core/legacy-hardware-config=3/}:S' kill >/dev/null 2>&1
 ret     = 1
 kernel_since = 6.12
 
@@ -30,7 +30,7 @@ inherit=1
 fd=2
 group_fd=1
 
-# cache-misses
+# cache-misses, explicitly requested with the legacy hardware encoding
 type=0
 config=3
 
diff --git a/tools/perf/tests/shell/attr/test-record-group-sampling2 b/tools/perf/tests/shell/attr/test-record-group-sampling2
index e0432244a0eb7f6c..c05225167ec3464b 100644
--- a/tools/perf/tests/shell/attr/test-record-group-sampling2
+++ b/tools/perf/tests/shell/attr/test-record-group-sampling2
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = --no-bpf-event -c 10000 -e '{cycles,cache-misses}:S' kill >/dev/null 2>&1
+args    = --no-bpf-event -c 10000 -e '{cycles,default_core/legacy-hardware-config=3/}:S' kill >/dev/null 2>&1
 ret     = 1
 kernel_since = 6.12
 
@@ -36,7 +36,7 @@ write_backward=0
 fd=2
 group_fd=1
 
-# cache-misses
+# cache-misses, explicitly requested with the legacy hardware encoding
 type=0
 config=3
 
diff --git a/tools/perf/tests/shell/attr/test-record-group1 b/tools/perf/tests/shell/attr/test-record-group1
index eeb1db392bc9ceac..0437ea4939e88865 100644
--- a/tools/perf/tests/shell/attr/test-record-group1
+++ b/tools/perf/tests/shell/attr/test-record-group1
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = --no-bpf-event -e '{cycles,instructions}' kill >/dev/null 2>&1
+args    = --no-bpf-event -e '{cycles,default_core/legacy-hardware-config=1/}' kill >/dev/null 2>&1
 ret     = 1
 
 [event-1:base-record]
diff --git a/tools/perf/tests/shell/attr/test-record-group2 b/tools/perf/tests/shell/attr/test-record-group2
index 891d41a7bddf785a..ca5bbf441968fd8c 100644
--- a/tools/perf/tests/shell/attr/test-record-group2
+++ b/tools/perf/tests/shell/attr/test-record-group2
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = --no-bpf-event -e '{cycles/period=1234000/,instructions/period=6789000/}:S' kill >/dev/null 2>&1
+args    = --no-bpf-event -e '{cycles/period=1234000/,default_core/legacy-hardware-config=1,period=6789000/}:S' kill >/dev/null 2>&1
 ret     = 1
 kernel_until = 6.12
 
diff --git a/tools/perf/tests/shell/attr/test-record-group3 b/tools/perf/tests/shell/attr/test-record-group3
index 249be884959eaaba..8191b3af936de5aa 100644
--- a/tools/perf/tests/shell/attr/test-record-group3
+++ b/tools/perf/tests/shell/attr/test-record-group3
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = --no-bpf-event -e '{cycles/period=1234000/,instructions/period=6789000/}:S' kill >/dev/null 2>&1
+args    = --no-bpf-event -e '{cycles/period=1234000/,default_core/legacy-hardware-config=1,period=6789000/}:S' kill >/dev/null 2>&1
 ret     = 1
 kernel_since = 6.12
 
diff --git a/tools/perf/tests/shell/attr/test-stat-group1 b/tools/perf/tests/shell/attr/test-stat-group1
index 1746751123dcb2c4..fa2ca74e4cf29ad5 100644
--- a/tools/perf/tests/shell/attr/test-stat-group1
+++ b/tools/perf/tests/shell/attr/test-stat-group1
@@ -1,6 +1,6 @@
 [config]
 command = stat
-args    = -e '{cycles,instructions}' kill >/dev/null 2>&1
+args    = -e '{cycles,default_core/legacy-hardware-config=1/}' kill >/dev/null 2>&1
 ret     = 1
 
 [event-1:base-stat]
-- 
2.55.0

