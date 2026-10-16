Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C0A48DB2E;
	Fri, 16 Oct 2026 21:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792185716; cv=none; b=mJ+JqLJEgrJfC8ZwjvGozDTrDpw1hhXwvnGaDua6iB57GOs7eJRm1Er/jfrk3esUQ9ZWk/M14UiNJPdEkMUV6NgP/Lz5m+m9s4KcP+CESdSHiIqWeyWHPPtoRIdo/RseKwt3P79uu9aGn74C73CVxYRLoYSgmGWjVDn4MK1jECk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792185716; c=relaxed/simple;
	bh=2GwR2vPjo6ao1MAIQsAqU1UG+er2vCL47+HNf6XhhpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJh0JkeSzxkY2ZG8MImXEaqgmiRBb3KftcjzHC4p2ONBHsNrCkK9ixhrJiWpHzC3r12G3JQ/xHGaEvZTtr+KyjmanBrnKdKHA1y9qKpgaMRnzSk73v5sPrFHPXc6JIs7JtsUw4VQRMFQSvfVKw5kfS/gQZjopFhboLvpn0P/SbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvmJZ1tJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvmJZ1tJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F5F1F000C4;
	Fri, 16 Oct 2026 21:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792185715;
	bh=S02rUCMUk6BgE4l4cral83kTRBp5hEJpTHW2k3WwjZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PvmJZ1tJx8UmNnQULPHEwstGY5U1biwZrVx2/AuIS8AQWGiE3Pq/NpLFaDmxtyBKd
	 Eyv/07TwX7YyLDEUchVGoBVrRvg0lTf9buSere/sv3VGpMdJ5/9nidE0HGCsol3WWN
	 cmyZyJSwAuxZmZnqJUgL+zDo1sA9QevrN7G5Gpe2BD1f/ttzmBlpmVFGAMORMZ75B9
	 E+euQpxMX1D+TJzrGc0rwc/91TvOnVmqD2AbHBgKRb6UzKhpwLkfFPklGIEn1ghy2V
	 Pn9NQEWvl9oeiz055yZNURqcbd43JJZVKbMlGsQb49PKYDLGY5M7ooWITLbs1j5zUa
	 mNNasT6GUn8XQ==
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
Subject: [PATCH v4 14/21] perf test attr: Leave out the events of the other core PMUs
Date: Fri, 16 Oct 2026 18:20:55 -0300
Message-ID: <20261016212102.76550-15-acme@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016212102.76550-1-acme@kernel.org>
References: <20261016212102.76550-1-acme@kernel.org>
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
index 47a09f00000ff762..d485a491c717c96c 100644
--- a/tools/perf/tests/shell/lib/attr.py
+++ b/tools/perf/tests/shell/lib/attr.py
@@ -563,6 +563,44 @@ class Test(object):
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
 
@@ -645,6 +683,7 @@ class Test(object):
                 event.recorded = True
 
             self.drop_dummy_tracking_events()
+            self.drop_other_core_pmu_events()
 
             # resolve group_fd to event names
             self.resolve_groups(self.expect)
-- 
2.55.0

