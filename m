Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC35282F14;
	Fri, 16 Oct 2026 00:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792109950; cv=none; b=A+5O5AXr5vYv2aKVfLfphC/sqsdbD4Dh6lV7zxe3LaPxAN8j1PPwoDnBDGaUMRYM4FagP67ycBW5DwIXH7BAzYO+maHNje2FolDYwjfCtKH6xuB8u95g8+c8sCZiVAFodYH+iCkLDgd/+iJ4pOLGMbiU847lPPHx3EElbDsjtiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792109950; c=relaxed/simple;
	bh=xo6vkvvbUVSE9MIZR/uwsKHaojZvPm1K9aTsPJMxxYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C0InsgWEWcwnh7WjFwBLMbIC43Ool7PgAxJxi74sPYNMQiY2hsbuKSjXktzzp/337/UQs+DaEL4UvlkJ30U267OSw7A/EgX1JGlmXyHcbLCU7hvdo2lImfCkgdeYUGzMLz7O1D0o/yAAZIvbffg4KGpNAJ8Ap/6gjJBXoMoOBFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYvYbqru; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYvYbqru"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0CD1F000C5;
	Fri, 16 Oct 2026 00:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792109949;
	bh=wCN7aKNMh2ATJsQE3Igxk6y8QHVz53IwimmPZOJv6ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VYvYbqruBoJhZw9iFnG5pH7cINsUn9A2BaYvNJoq9GJMG5dww15lOEJMdkFgbI1mW
	 cTphZceK0dwj074unrHzYiE2X2OZuK5do+7kGHgDvWA7xgAHBv+V+vVLLXfIfUPske
	 OysVGM6wFq7yR01XWHSnml9wTxcHbruyZwuw45j2jQF6t8+6HumyE5Nswz5o03F5P/
	 ekiPCHuYT7KDEr2TGDKazSgoAwIWb0/Bq8r+F+eOGkdjsdTrDJFgTP/4gHB0FYA+7t
	 OWUqjI0lkbGgYcz85jpxrs0cPFtA7Wf6GyG1h3Ld8IDDsVHQfToAWYo/dZNJmpfcH2
	 BdlFCM3+7Xjhw==
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
Subject: [PATCH v3 07/19] perf test attr: Ignore the core PMU type perf puts in 'config'
Date: Thu, 15 Oct 2026 21:18:31 -0300
Message-ID: <20261016001843.71978-8-acme@kernel.org>
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

Since commit 55bcf6ef314a ("perf: Extend PERF_TYPE_HARDWARE and
PERF_TYPE_HW_CACHE") in v5.13, and arm_pmu opted in with commit
5c816728651a ("arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE capability")
in v6.6, the kernel can be told which core PMU a legacy type event is
meant for, with its type in the top 32 bits of 'config', see
perf_pmus__supports_extended_type(), which __parse_events_add_numeric()
does for HARDWARE and HW_CACHE events, but only when there is more than
one core PMU, i.e. on heterogeneous machines, where asking for one event
ends up being one event per core PMU:

  $ perf stat -e cycles -a -- sleep 1
     20,520,998      armv8_cortex_a53/cycles/
     13,029,350      armv8_cortex_a73/cycles/

and what lands in PERF_TEST_ATTR is the extended encoding:

  type=0
  config=38654705664    # core PMU type 9, PERF_COUNT_HW_CPU_CYCLES

so the expectations written for the single core PMU case fail with:

  expected config=0|1, got 38654705664
  expected config=0, got 38654705664    # 'perf stat -d' L1-dcache events

which is what now happens on an Amlogic A311D (2 Cortex-A53 + 4
Cortex-A73), a machine that just got the CPU PMU nodes it was missing.

Take those bits out when comparing the 'config' of legacy type events,
keeping what these expectations mean on machines with a single core PMU:
which of the PMUs is counting is not what we're asking here.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/lib/attr.py | 53 ++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/lib/attr.py b/tools/perf/tests/shell/lib/attr.py
index 087bfa4532b69c58..fb866fb75175dc95 100644
--- a/tools/perf/tests/shell/lib/attr.py
+++ b/tools/perf/tests/shell/lib/attr.py
@@ -73,6 +73,32 @@ def core_pmu_probe():
 
     return True
 
+PERF_TYPE_HARDWARE = 0
+PERF_TYPE_HW_CACHE = 3
+
+# The legacy event types, where perf may qualify 'config' with the core PMU
+# type in its top 32 bits when there is more than one core PMU.
+LEGACY_TYPES = (str(PERF_TYPE_HARDWARE), str(PERF_TYPE_HW_CACHE))
+
+def hide_core_pmu_type(value):
+    """
+    The kernel can be told which core PMU a legacy type event is meant for by
+    putting its type in the top 32 bits of 'config', which perf only does when
+    there is more than one core PMU, so take those bits out to keep the
+    expectations written for the single core PMU case matching on
+    heterogeneous machines.
+    """
+    hidden = []
+
+    for alternative in value.split('|'):
+        try:
+            alternative = str(int(alternative, 0) & 0xffffffff)
+        except ValueError:
+            pass
+        hidden.append(alternative)
+
+    return '|'.join(hidden)
+
 class Fail(Exception):
     def __init__(self, test, msg):
         self.msg = msg
@@ -146,12 +172,33 @@ class Event(dict):
         self.add(base)
         self.add(data)
 
+    def hide_core_pmu_type_terms(self, other):
+        """
+        Is this a legacy type event? Then the core PMU type that perf may have
+        put in the top 32 bits of 'config' to tell the kernel which core PMU it
+        wants isn't part of what we asked for, see hide_core_pmu_type().
+        """
+        for event in (self, other):
+            for type in event.get('type', '').split('|'):
+                if type in LEGACY_TYPES:
+                    return True
+
+        return False
+
+    def hide_core_pmu_type(self, term, value, other):
+        if term == 'config' and self.hide_core_pmu_type_terms(other):
+            return hide_core_pmu_type(value)
+
+        return value
+
     def equal(self, other):
         for t in Event.terms:
             log.debug("      [%s] %s %s", t, self[t], other[t])
             if t not in self or t not in other:
                 return False
-            if not data_equal(self[t], other[t]):
+            exp = self.hide_core_pmu_type(t, self[t], other)
+            got = self.hide_core_pmu_type(t, other[t], other)
+            if not data_equal(exp, got):
                 return False
         return True
 
@@ -164,7 +211,9 @@ class Event(dict):
         for t in Event.terms:
             if t not in self or t not in other:
                 continue
-            if not data_equal(self[t], other[t]):
+            exp = self.hide_core_pmu_type(t, self[t], other)
+            got = self.hide_core_pmu_type(t, other[t], other)
+            if not data_equal(exp, got):
                 log.warning("expected %s=%s, got %s", t, self[t], other[t])
 
 def parse_version(version):
-- 
2.55.0

