Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25E7233933;
	Fri, 16 Oct 2026 00:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792109937; cv=none; b=b+6jpj/MQ5IT1vuVaoL4ygVG1RfmVP3iH+pEfoeMN3V7f8ZI5RGGgD+Bbg9qKeNcxbMNacdrwjrYnCi1NfcoJQ9iPkltLlIjKu0QzFJgwP8U20ucUanTSBavGGy/xKBY8D4ZkrqeYeAziVxP6EeCZpyD7/UlE1CNoBc4JTE74RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792109937; c=relaxed/simple;
	bh=xGB/n90vHnG+ioo5rQMlD23mUdaCxIjk2IyxBgfYqpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nu6OKm9PP4QM79AJcx5FaFZoLQZk8ywX4eMaQzflyxMpenGPvQFAXnd9jXCtXL6c8zreVv9L5FXpLMgJJCaV3QYyZ7LYSseWk3lBCMu7JTIxTnhxSP+8DJY281AVr+11cXxXyv0z9ZXut8nUhfyBPHNGNw/LTAhpdyVKrr/1CFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbiw8+Nd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbiw8+Nd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E6F1F000C4;
	Fri, 16 Oct 2026 00:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792109935;
	bh=vu2dxBhtjOX32mukUGPMQr+WNAc4H6EvEK2F/8Ip1nM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dbiw8+NdmmlEHF07iGidJUcc5caI6BrubmcY+9qY+bcytQKFlT+FVsZ9UwYrtDfvE
	 8g9+89UglZJvKN6M6+l9Psa2AWERFeHrvVLrDR6UFoQiO3EufPOkWktaYFZ4NHHR+s
	 47YAxM5Vy/mx3opZiBD6vj6i0VkePl0rVULxcFR54y/FzQtqrc11ZKqMjarIjDaJNy
	 wWM1SkUJzWtPee/eMDq3fEXYT57FNHBUhvZ02L/3mmm3Gxj5Mz87oWyP15jOtKU6si
	 cpfQwYlidNuKNtdLIY4MTJr4tepg1OW+CE6Wv6+Tmig0/5BFXYJsm0M4mhBbbpfWFh
	 aWLlxIhx2sOWw==
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
Subject: [PATCH v3 02/19] perf test attr: Allow tests to require a core PMU
Date: Thu, 15 Oct 2026 21:18:26 -0300
Message-ID: <20261016001843.71978-3-acme@kernel.org>
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

On machines without a usable core PMU, like an aarch64 box with no DT
node for the ARM PMU, the expectations that pin the legacy hardware
encoding can't be checked: without a core PMU at all 'cycles' doesn't
even resolve, and with one that can't be opened 'perf record' takes the
software fallback and records attributes they can never match:

  expected type=0, got 1
  expected config=0, got 1
  FAILED '.../attr/test-record-group-sampling1' - match failure

And since attr.py stops at the first failure, every expectation that
would come after that one ends up not being run at all.

Add a 'requires' limitation, modelled after the existing 'arch', 'auxv'
and 'kernel_since/until' ones, with 'core-pmu' as its first value, that
is checked by asking perf itself to open 'cycles' via its python
binding: a parse failure or an ENOENT means there is no PMU that can
count it, hence nothing to check and the test gets skipped, while any
other error means we can't tell, so the test keeps running as it does
today, where there is no binding to ask either.

When there is no core PMU, asking the binding fails and prints a parse
error, once for every test that asks, so the answer is kept: it is asked
once per run.  A value other than 'core-pmu' is warned about, not
silently ignored, so a typo can't turn the skip into a no-op.

An old distro python package may have a 'perf' module without
parse_events(), i.e. there is nothing to ask with, so that
AttributeError gets the same treatment as the ImportError: let the
expectations speak.

The expectations that have a strict 'type=0', plus the group tests,
where the fallback drops a member and leaves nothing to compare the
group leader attributes with, now state that they require a core PMU.
They are marked here, before the commit that has the group tests ask for
the legacy encodings, so the requisite comes with that dependency.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../shell/attr/test-record-group-sampling     |  1 +
 .../shell/attr/test-record-group-sampling1    |  1 +
 .../shell/attr/test-record-group-sampling2    |  1 +
 .../perf/tests/shell/attr/test-record-group1  |  1 +
 .../perf/tests/shell/attr/test-record-group2  |  1 +
 .../perf/tests/shell/attr/test-record-group3  |  1 +
 tools/perf/tests/shell/attr/test-stat-C0      |  1 +
 tools/perf/tests/shell/attr/test-stat-basic   |  1 +
 tools/perf/tests/shell/attr/test-stat-default |  1 +
 .../tests/shell/attr/test-stat-detailed-1     |  1 +
 .../tests/shell/attr/test-stat-detailed-2     |  1 +
 .../tests/shell/attr/test-stat-detailed-3     |  1 +
 tools/perf/tests/shell/attr/test-stat-group1  |  1 +
 .../tests/shell/attr/test-stat-no-inherit     |  1 +
 tools/perf/tests/shell/lib/attr.py            | 63 +++++++++++++++++++
 15 files changed, 77 insertions(+)

diff --git a/tools/perf/tests/shell/attr/test-record-group-sampling b/tools/perf/tests/shell/attr/test-record-group-sampling
index 86a940d7895d7404..b43d9fe3af75c096 100644
--- a/tools/perf/tests/shell/attr/test-record-group-sampling
+++ b/tools/perf/tests/shell/attr/test-record-group-sampling
@@ -3,6 +3,7 @@ command = record
 args    = --no-bpf-event -e '{cycles,cache-misses}:S' kill >/dev/null 2>&1
 ret     = 1
 kernel_until = 6.12
+requires = core-pmu
 
 [event-1:base-record]
 fd=1
diff --git a/tools/perf/tests/shell/attr/test-record-group-sampling1 b/tools/perf/tests/shell/attr/test-record-group-sampling1
index 4748ab7bf68437c7..3def72161820dca3 100644
--- a/tools/perf/tests/shell/attr/test-record-group-sampling1
+++ b/tools/perf/tests/shell/attr/test-record-group-sampling1
@@ -3,6 +3,7 @@ command = record
 args    = --no-bpf-event -e '{cycles,cache-misses}:S' kill >/dev/null 2>&1
 ret     = 1
 kernel_since = 6.12
+requires = core-pmu
 
 [event-1:base-record]
 fd=1
diff --git a/tools/perf/tests/shell/attr/test-record-group-sampling2 b/tools/perf/tests/shell/attr/test-record-group-sampling2
index e0432244a0eb7f6c..227c18bb221c4b2f 100644
--- a/tools/perf/tests/shell/attr/test-record-group-sampling2
+++ b/tools/perf/tests/shell/attr/test-record-group-sampling2
@@ -3,6 +3,7 @@ command = record
 args    = --no-bpf-event -c 10000 -e '{cycles,cache-misses}:S' kill >/dev/null 2>&1
 ret     = 1
 kernel_since = 6.12
+requires = core-pmu
 
 [event-1:base-record]
 fd=1
diff --git a/tools/perf/tests/shell/attr/test-record-group1 b/tools/perf/tests/shell/attr/test-record-group1
index eeb1db392bc9ceac..a57c7ee8aaa4f9c9 100644
--- a/tools/perf/tests/shell/attr/test-record-group1
+++ b/tools/perf/tests/shell/attr/test-record-group1
@@ -2,6 +2,7 @@
 command = record
 args    = --no-bpf-event -e '{cycles,instructions}' kill >/dev/null 2>&1
 ret     = 1
+requires = core-pmu
 
 [event-1:base-record]
 fd=1
diff --git a/tools/perf/tests/shell/attr/test-record-group2 b/tools/perf/tests/shell/attr/test-record-group2
index 891d41a7bddf785a..fb6e664eeacc10ef 100644
--- a/tools/perf/tests/shell/attr/test-record-group2
+++ b/tools/perf/tests/shell/attr/test-record-group2
@@ -3,6 +3,7 @@ command = record
 args    = --no-bpf-event -e '{cycles/period=1234000/,instructions/period=6789000/}:S' kill >/dev/null 2>&1
 ret     = 1
 kernel_until = 6.12
+requires = core-pmu
 
 [event-1:base-record]
 fd=1
diff --git a/tools/perf/tests/shell/attr/test-record-group3 b/tools/perf/tests/shell/attr/test-record-group3
index 249be884959eaaba..7b90b4411d8f4b90 100644
--- a/tools/perf/tests/shell/attr/test-record-group3
+++ b/tools/perf/tests/shell/attr/test-record-group3
@@ -3,6 +3,7 @@ command = record
 args    = --no-bpf-event -e '{cycles/period=1234000/,instructions/period=6789000/}:S' kill >/dev/null 2>&1
 ret     = 1
 kernel_since = 6.12
+requires = core-pmu
 
 [event-1:base-record]
 fd=1
diff --git a/tools/perf/tests/shell/attr/test-stat-C0 b/tools/perf/tests/shell/attr/test-stat-C0
index a2c76d10b2bb2a15..9d242e93e3a92009 100644
--- a/tools/perf/tests/shell/attr/test-stat-C0
+++ b/tools/perf/tests/shell/attr/test-stat-C0
@@ -2,6 +2,7 @@
 command = stat
 args    = -e cycles -C 0 kill >/dev/null 2>&1
 ret     = 1
+requires = core-pmu
 
 [event:base-stat]
 # events are disabled by default when attached to cpu
diff --git a/tools/perf/tests/shell/attr/test-stat-basic b/tools/perf/tests/shell/attr/test-stat-basic
index 69867d049fda926f..277897bd2626a41f 100644
--- a/tools/perf/tests/shell/attr/test-stat-basic
+++ b/tools/perf/tests/shell/attr/test-stat-basic
@@ -2,6 +2,7 @@
 command = stat
 args    = -e cycles kill >/dev/null 2>&1
 ret     = 1
+requires = core-pmu
 
 [event:base-stat]
 optional=1
diff --git a/tools/perf/tests/shell/attr/test-stat-default b/tools/perf/tests/shell/attr/test-stat-default
index 8dd27c1fb661fb77..74691188e859a169 100644
--- a/tools/perf/tests/shell/attr/test-stat-default
+++ b/tools/perf/tests/shell/attr/test-stat-default
@@ -2,6 +2,7 @@
 command = stat
 args    = kill >/dev/null 2>&1
 ret     = 1
+requires = core-pmu
 
 # PERF_TYPE_SOFTWARE / PERF_COUNT_SW_TASK_CLOCK
 [event1:base-stat]
diff --git a/tools/perf/tests/shell/attr/test-stat-detailed-1 b/tools/perf/tests/shell/attr/test-stat-detailed-1
index 12a2ebf4e64a0077..d9a6236054f2dfb1 100644
--- a/tools/perf/tests/shell/attr/test-stat-detailed-1
+++ b/tools/perf/tests/shell/attr/test-stat-detailed-1
@@ -2,6 +2,7 @@
 command = stat
 args    = -d kill >/dev/null 2>&1
 ret     = 1
+requires = core-pmu
 
 
 # PERF_TYPE_SOFTWARE / PERF_COUNT_SW_TASK_CLOCK
diff --git a/tools/perf/tests/shell/attr/test-stat-detailed-2 b/tools/perf/tests/shell/attr/test-stat-detailed-2
index 66ea25b7d38f8d59..582a30289ccfa6df 100644
--- a/tools/perf/tests/shell/attr/test-stat-detailed-2
+++ b/tools/perf/tests/shell/attr/test-stat-detailed-2
@@ -2,6 +2,7 @@
 command = stat
 args    = -dd kill >/dev/null 2>&1
 ret     = 1
+requires = core-pmu
 
 
 # PERF_TYPE_SOFTWARE / PERF_COUNT_SW_TASK_CLOCK
diff --git a/tools/perf/tests/shell/attr/test-stat-detailed-3 b/tools/perf/tests/shell/attr/test-stat-detailed-3
index 4a27bbfb9f87a538..2d0fca8b5020f504 100644
--- a/tools/perf/tests/shell/attr/test-stat-detailed-3
+++ b/tools/perf/tests/shell/attr/test-stat-detailed-3
@@ -2,6 +2,7 @@
 command = stat
 args    = -ddd kill >/dev/null 2>&1
 ret     = 1
+requires = core-pmu
 
 
 # PERF_TYPE_SOFTWARE / PERF_COUNT_SW_TASK_CLOCK
diff --git a/tools/perf/tests/shell/attr/test-stat-group1 b/tools/perf/tests/shell/attr/test-stat-group1
index 1746751123dcb2c4..3d8b44ba42d6ae19 100644
--- a/tools/perf/tests/shell/attr/test-stat-group1
+++ b/tools/perf/tests/shell/attr/test-stat-group1
@@ -2,6 +2,7 @@
 command = stat
 args    = -e '{cycles,instructions}' kill >/dev/null 2>&1
 ret     = 1
+requires = core-pmu
 
 [event-1:base-stat]
 fd=1
diff --git a/tools/perf/tests/shell/attr/test-stat-no-inherit b/tools/perf/tests/shell/attr/test-stat-no-inherit
index 924fbb9300d16259..38f746855b1b3e11 100644
--- a/tools/perf/tests/shell/attr/test-stat-no-inherit
+++ b/tools/perf/tests/shell/attr/test-stat-no-inherit
@@ -2,6 +2,7 @@
 command = stat
 args    = -i -e cycles kill >/dev/null 2>&1
 ret     = 1
+requires = core-pmu
 
 [event:base-stat]
 inherit=0
diff --git a/tools/perf/tests/shell/lib/attr.py b/tools/perf/tests/shell/lib/attr.py
index 68f06df9565a0811..2d7dd26a5737777c 100644
--- a/tools/perf/tests/shell/lib/attr.py
+++ b/tools/perf/tests/shell/lib/attr.py
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 import configparser
+import errno
 import os
 import sys
 import glob
@@ -28,6 +29,50 @@ def data_equal(a, b):
 
     return False
 
+CORE_PMU_AVAILABLE = None
+
+def core_pmu_available():
+    """
+    Is there a core PMU on this machine? Without one hardware events aren't
+    supported and get replaced by the software fallback, so there's no way to
+    check the expectations that pin their legacy encodings.  The answer can't
+    change while the tests run, so probe the binding only once.
+    """
+    global CORE_PMU_AVAILABLE
+
+    if CORE_PMU_AVAILABLE is None:
+        CORE_PMU_AVAILABLE = core_pmu_probe()
+
+    return CORE_PMU_AVAILABLE
+
+def core_pmu_probe():
+    """
+    Ask perf itself, through its python binding, to parse and open 'cycles':
+    a parse failure or an ENOENT means no PMU can count it, any other error
+    means we can't tell whether there is one.
+    """
+    try:
+        import perf
+        parse_events = perf.parse_events
+    except (ImportError, AttributeError):
+        # Nothing to ask about it, let the expectations speak.
+        return True
+
+    try:
+        evlist = parse_events('cycles')
+    except OSError:
+        # No PMU that can count it, the same as the ENOENT below.
+        return False
+
+    try:
+        evlist.open()
+    except OSError as err:
+        # Anything else is a permission problem or alike, not our business here.
+        return err.errno != errno.ENOENT
+    evlist.close()
+
+    return True
+
 class Fail(Exception):
     def __init__(self, test, msg):
         self.msg = msg
@@ -138,6 +183,9 @@ def parse_version(version):
 #     'arch'    - architecture specific test (optional)
 #                 comma separated list, ! at the beginning
 #                 negates it.
+#     'requires' - Comma separated list of things the test needs, it is
+#                 skipped when any of them isn't there, currently:
+#                   core-pmu - the machine can count hardware events.
 #     'auxv'    - Truthy statement that is evaled in the scope of the auxv map. When false,
 #                 the test is skipped. For example 'auxv["AT_HWCAP"] == 10'. (optional)
 #     'kernel_since' - Inclusive kernel version from which the test will start running. Only the
@@ -173,6 +221,7 @@ class Test(object):
             self.arch  = ''
 
         self.auxv = parser.get('config', 'auxv', fallback=None)
+        self.requires = parser.get('config', 'requires', fallback='')
         self.kernel_since = parse_version(parser.get('config', 'kernel_since', fallback=None))
         self.kernel_until = parse_version(parser.get('config', 'kernel_until', fallback=None))
         self.expect   = {}
@@ -242,6 +291,17 @@ class Test(object):
                 return False
         return True
 
+    def skip_test_requires(self):
+        for requirement in filter(None, map(str.strip, self.requires.split(','))):
+            if requirement == 'core-pmu':
+                if not core_pmu_available():
+                    log.warning("test limitation 'requires %s'", requirement)
+                    return True
+            else:
+                log.warning("unknown requirement '%s', ignored", requirement)
+
+        return False
+
     def restore_sample_rate(self, value=10000):
         try:
             # Check value of sample_rate
@@ -296,6 +356,9 @@ class Test(object):
         if self.skip_test_kernel_until():
             raise Notest(self, "new kernel skip")
 
+        if self.skip_test_requires():
+            raise Notest(self, "requirements skip")
+
         self.restore_sample_rate()
         cmd = "PERF_TEST_ATTR=%s %s %s -o %s/perf.data %s" % (tempdir,
               self.perf, self.command, tempdir, self.args)
-- 
2.55.0

