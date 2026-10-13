Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7152A54DAEF;
	Tue, 13 Oct 2026 20:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922505; cv=none; b=NSjad+alPenVUew9/rR0AX8+seH+Y9VUFpkWe7AvzIFkKFOzfuUklhq2ea/rnQTxPOnRrQmi1dC2k+phlVBCP+iPWFBlYR+BpqXoRnjzUKZ6TNO1U2fsdOLpoY63uOYYd8o8j2RZKf6y2AFkZQEEt1X83x9K7/APM+PrXcWFdTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922505; c=relaxed/simple;
	bh=qeBg26zOYqqdxzz+45miObF1TeX5Y9NjWl3YDA5Jq5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3YE4mNJl+DkoejPm2zBWGyIzi68Oea4PJs5OQVwfLaqA6EHAqJE4SWGenwA6gGCUCD1vhgUKuHF3B1bJWslaXdMvckcIWcd09otEgxcfC7ACFNM6GzyH57t2xMfw7ggcZAc5hTUPaVs/82N/JpLUsNeZO2WDZ9AA/0Yk/0AXrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orRaOkjO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orRaOkjO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1541F00893;
	Tue, 13 Oct 2026 20:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791922501;
	bh=ztKLYD6iVWRJBLvTv/2UKAv5bmFBL2HBxANZbtkkpTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=orRaOkjOQ1cB6JtRFF1kK4AI6bI/HQ/RE3tuop7wZwaMGHvDqSSrBGtv/1uzbBf/q
	 A1WFqV3tIFY2GpTC+SlnjgRsMcXQTgb0bDuOo206Uh9ieGnD6Y1fDP8RWA66y/fils
	 Cf3yPVU7SdCieUb5g0Ih32QVN2OejgTPFkOjGt72ua45l6FKwUpY+pfQ2vIhbLBW1P
	 8RabtSmu34HZZMbCK/aFHeBCWAZcmIDbojjj6lOD8tEMgBqTLQr9lV0Y5i6Plsy0sV
	 CQR/auM+1uoD3L09+oeYdjlyWrfT339Fe3fcjpZGJt8GQcS6hh57GmiQaUiyfC3R2W
	 jtbrwsRn8Fn4w==
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
Subject: [PATCH v2 12/19] perf test attr: Leave out the events of the other core PMUs
Date: Tue, 13 Oct 2026 17:14:07 -0300
Message-ID: <20261013201415.36428-13-acme@kernel.org>
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
index 222ce6f598831e3f..65b1e655a2bcb505 100644
--- a/tools/perf/tests/shell/lib/attr.py
+++ b/tools/perf/tests/shell/lib/attr.py
@@ -532,6 +532,44 @@ class Test(object):
         for event in self.result.values():
             event.tracking_moved_to_dummy = True
 
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
 
@@ -614,6 +652,7 @@ class Test(object):
                 event.recorded = True
 
             self.drop_dummy_tracking_events()
+            self.drop_other_core_pmu_events()
 
             # resolve group_fd to event names
             self.resolve_groups(self.expect)
-- 
2.55.0

