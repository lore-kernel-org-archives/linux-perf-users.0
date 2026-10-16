Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B11269D18;
	Fri, 16 Oct 2026 00:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792109964; cv=none; b=RLSVFJh1RTyA89gzptR+yMD0uWkVFnhlG8cBGk27TVcIZYGwo+CKHORoL12NVPFofAwJL9cU1/pPiYzRGbjrlrckWgTTu/WOSPvTLt8jKE96TZnBxPFArZ905s4aTg3BiL3yPdNjpbYqwkTDJOk3+AFsSy/gfiAFT4UA7HCwLjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792109964; c=relaxed/simple;
	bh=YrEE1R4ghTf9VjslJMaCPbdcN6AiOLkRkH/XDSAJJ9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMHi/P/qgxMf8oGOZjEotqwgvj86KS/fdpgi9B2wc6W0TGG/laSxYla7ifFeeU1z9bM0ywmuHhl7IVAmCQsVXcT6oP+h/S0Kb9COvKBIFb9cz0IXVqRP6M7hYe35Ndji+u4tNbZZsM2P8YlkTVOCH2zz4M9KyYzS5KOM4Yne1a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuiWoCF3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuiWoCF3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45AF1F000C4;
	Fri, 16 Oct 2026 00:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792109963;
	bh=BpcoR4DPNdc8jENa15R1dVBDwy+nTd5zNdRcynqdkCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DuiWoCF3QM/ZzK/EHJbGmDv92hWFaXNc4gBmVFl2P/IR0o1jkZhMWY754JrCKm3Yn
	 UlSJOhJzN+eqNXGHxC/lTZNnza2sr02C+j/0qCoS/Ja9PZTHLaRddLz8AVlX3nSCGO
	 hZXt2+o+npYShVvPdmUVfThblV++YoZYPezTIuuNmFYsCoT4iugV9+ZLfl365RsuWj
	 Tfovt3zUWeJKgoPTaC5tuQbxncMchRJeXDYgK5KpW9zpihvDn05gN591MJsVwHVV1G
	 dn+rqksYvc0qFXpw9fTGiQuNcZ95QNX2CiF3djztntD9DGQgNW3Kl9I95vQtNS0WcN
	 sYkqKmxO7iqrA==
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
Subject: [PATCH v3 12/19] perf test attr: Leave out the events of the other core PMUs
Date: Thu, 15 Oct 2026 21:18:36 -0300
Message-ID: <20261016001843.71978-13-acme@kernel.org>
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

On a hybrid machine the default stat metrics are opened on each core PMU,
and the events of the other one have their own encodings: on an i7-14700K
cpu_atom (type 10) opens UOPS_RETIRED.ALL, config 194, which the
expectations, written for cpu_core (type 4), don't name:

  expected type=4, got 10
  expected config=209|391, got 194

The test already masks the core PMU type out of 'config' for the legacy
events, but raw events keep their type and encoding, so leave out the
events of the core PMUs no expectation names, like the dummy tracking
event.  Core PMUs are found as perf finds them: 'cpu' or 'cpum_cf', or a
PMU with a 'cpus' file in sysfs.  Nothing is left out unless an
expectation names a core PMU, so single core PMU machines and the tests
with only legacy expectations are not affected.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/lib/attr.py | 39 ++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/perf/tests/shell/lib/attr.py b/tools/perf/tests/shell/lib/attr.py
index c39f2603ec077b2c..260e3ec077932cab 100644
--- a/tools/perf/tests/shell/lib/attr.py
+++ b/tools/perf/tests/shell/lib/attr.py
@@ -557,6 +557,44 @@ class Test(object):
         for event in self.result.values():
             event.tracking_moved_to_dummy = moved
 
+    def drop_other_core_pmu_events(self, devices='/sys/bus/event_source/devices'):
+        """
+        Leave out the events of the other core PMUs, which have their own
+        encodings, when the expectations name one of the core PMUs.
+        """
+        asked = set()
+        for event in self.expect.values():
+            types = event.get('type', '').split('|')
+            if '*' in types:
+                return
+            asked.update(types)
+
+        try:
+            names = os.listdir(devices)
+        except OSError:
+            return
+
+        core = set()
+        for name in names:
+            path = os.path.join(devices, name)
+            has_cpus = os.path.exists(os.path.join(path, 'cpus'))
+            if name not in ('cpu', 'cpum_cf') and not has_cpus:
+                continue
+            try:
+                with open(os.path.join(path, 'type'), encoding='utf-8') as f:
+                    core.add(f.read().strip())
+            except OSError:
+                pass
+
+        if not core & asked:
+            return
+
+        others = core - asked
+        for name, event in list(self.result.items()):
+            if event.get('type') in others:
+                log.debug("      dropping other core PMU event [%s]", name)
+                del self.result[name]
+
     def compare(self, expect, result, strict_groups=True):
         match = {}
 
@@ -639,6 +677,7 @@ class Test(object):
                 event.recorded = True
 
             self.drop_dummy_tracking_events()
+            self.drop_other_core_pmu_events()
 
             # resolve group_fd to event names
             self.resolve_groups(self.expect)
-- 
2.55.0

