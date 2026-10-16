Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0289848DB57;
	Fri, 16 Oct 2026 21:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792185720; cv=none; b=MzRbxOwWIqJ5gWzS7kvzoJT8f3oXZcVzKkCQD8aUDTljDKyCbo9ZyBH+HFD6BNESLhDjdfo3eipsF0t83ESWpX9qzX6gNTX48uTzwJ9OQvEcNpDhYyIIJKC6tXtJGsanpsdeg2dLlcFpyziGw7oIWdYOG2HO0eDx6anBn4kbLhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792185720; c=relaxed/simple;
	bh=OjSan2BMYnIlS++ZHCXwRg4U8LB4xQENcbvxxD6e/GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXQ4gmKnqUujxRZkGirxzZjpeEKk1q5kblUty6B8CeDbLBLW7MQoTsJyL9dUXl3DI3uW0XrTHXU3prZoQ8OZqamloCCZG/zKrCtQ+/NSQuSRMMjLTeZW+QLb6Djno/g4j189MTwIk4inuqgVMNGLUraikUhWilBYoQte/+9JRyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EclzSZ1c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EclzSZ1c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFC31F000C5;
	Fri, 16 Oct 2026 21:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792185718;
	bh=mKzw1bE2JKRKG6Uj0mGK+WDnDZ5D1dXy7uj6nYUhq9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EclzSZ1cXoPrnF6NIbrKFuzaDKBwV5wzX0KUhfh2zcYkY3DKP3fH6IPCIkf1R4wSr
	 TEE4/A9QlO8R9u7nlQJZVXnf0ppm4dS6MI9UfYcMrUxgH3U+f1vaBSCMjQCRvbbI4Z
	 RSgPS0Cg5JSzXOhJkP4LvtJx/bE/q4FAoxN7+9sHdTJslMoro83hKcBiQzzIG3N5IB
	 OqfqNolr/EE4jl1aL6TaoaH5hVkJdiEmlFhJcvy/3abWOOEAOj3/4MxhXvEBatTepj
	 4wzu0CKivlDsREnLX5o+j0wldsZ2JYyz+72LXf5jEysWmc6eG34o6twgGAlcGy3VSh
	 9+os2H2UBeu0A==
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
Subject: [PATCH v4 15/21] perf test attr: Ignore the group read_format bit the PMU count can remove
Date: Fri, 16 Oct 2026 18:20:56 -0300
Message-ID: <20261016212102.76550-16-acme@kernel.org>
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

read_format's PERF_FORMAT_GROUP bit asks for the group members to be read
along with the leader, which aside from this bit is verified with the
fd/group_fd based group checking in Test.compare(), and with more than
one core PMU a group whose members are pinned to one of them, say
'default_core', leaves the clones for the other core PMUs without any
members:

  $ perf stat -e '{cycles,default_core/legacy-hardware-config=3/}:S'
  ... the A53 leader keeps its cohort, both A73 cycles clones are alone,
      read_format 20 instead of 28

so that bit isn't there: whether it is there is a consequence of how the
evlist got expanded to more than one core PMU, not of the groupness the
expectations say about, which is verified structurally, so take it out on
both sides.

That leaves the A73 leader clones, now with:

  expected read_format=28|31, got 20

matching the base event expectations again.

With a single core PMU there is nothing to expand, so there is nothing to
explain away: count the core PMUs when the script starts, from what perf
makes of 'cycles', see parse_events_multi_pmu_add(), and take the bit out
only when there is more than one, leaving the machines with a single core
PMU verifying what the expectations say about it.  That count is 2 on the
Amlogic A311D, where its A53 and A73 PMUs both answer for 'cycles', and 1
on a machine with a single core PMU.  Where there is no binding to ask,
as when attr.py runs without setup_python.sh, the count isn't available
and the bit is taken out as well.

core_pmu_count() takes the count from the same probe core_pmu_available()
uses, so the binding is asked once, and only when a comparison needs the
answer, not at import time.

The sample id bits hide_sample_id() takes out when the expectations ask
for none are another consequence of having more than one core PMU, so the
same single core PMU gate covers them; equating the two id bits, needed
when the evlist has more than one event even with a single core PMU, keeps
applying.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/lib/attr.py | 75 +++++++++++++++++++++++++-----
 1 file changed, 63 insertions(+), 12 deletions(-)

diff --git a/tools/perf/tests/shell/lib/attr.py b/tools/perf/tests/shell/lib/attr.py
index d485a491c717c96c..09ee496b4947f470 100644
--- a/tools/perf/tests/shell/lib/attr.py
+++ b/tools/perf/tests/shell/lib/attr.py
@@ -30,6 +30,7 @@ def data_equal(a, b):
     return False
 
 CORE_PMU_AVAILABLE = None
+CORE_PMU_COUNT = None
 
 def core_pmu_available():
     """
@@ -38,40 +39,47 @@ def core_pmu_available():
     check the expectations that pin their legacy encodings.  The answer can't
     change while the tests run, so probe the binding only once.
     """
-    global CORE_PMU_AVAILABLE
-
-    if CORE_PMU_AVAILABLE is None:
-        CORE_PMU_AVAILABLE = core_pmu_probe()
-
+    core_pmu_probe()
     return CORE_PMU_AVAILABLE
 
 def core_pmu_probe():
     """
-    Ask perf itself, through its python binding, to parse and open 'cycles':
-    a parse failure or an ENOENT means no PMU can count it, any other error
-    means we can't tell whether there is one.
+    Ask perf itself, through its python binding, to parse and open 'cycles'
+    once: a parse failure or an ENOENT means no PMU can count it, any other
+    error means we can't tell whether there is one, and the number of events
+    it expanded to is the number of core PMUs, see
+    parse_events_multi_pmu_add(), which is what core_pmu_count() asks for.
     """
+    global CORE_PMU_AVAILABLE, CORE_PMU_COUNT
+
+    if CORE_PMU_AVAILABLE is not None:
+        return
+
     try:
         import perf
         parse_events = perf.parse_events
     except (ImportError, AttributeError):
         # Nothing to ask about it, let the expectations speak.
-        return True
+        CORE_PMU_AVAILABLE = True
+        return
 
     try:
         evlist = parse_events('cycles')
     except OSError:
         # No PMU that can count it, the same as the ENOENT below.
-        return False
+        CORE_PMU_AVAILABLE = False
+        return
 
+    CORE_PMU_COUNT = len(evlist)
     try:
         evlist.open()
     except OSError as err:
         # Anything else is a permission problem or alike, not our business here.
-        return err.errno != errno.ENOENT
+        CORE_PMU_AVAILABLE = err.errno != errno.ENOENT
+        return
     evlist.close()
 
-    return True
+    CORE_PMU_AVAILABLE = True
 
 PERF_TYPE_HARDWARE = 0
 PERF_TYPE_HW_CACHE = 3
@@ -131,6 +139,45 @@ SAMPLE_ID_BITS = PERF_SAMPLE_ID | PERF_SAMPLE_IDENTIFIER
 # sample id bits" when comparing the two sides.
 SAMPLE_ID_EITHER = 1 << 40
 
+PERF_FORMAT_GROUP = 1 << 3
+
+def core_pmu_count():
+    """
+    How many core PMUs does perf see?  An event with no PMU named in it
+    becomes one event per core PMU, see parse_events_multi_pmu_add(), and
+    that is the expansion that leaves the clones for the other core PMUs
+    without any group members and that makes perf qualify 'config' with the
+    type of the PMU it is for, so this is the number of events perf makes of
+    'cycles', from the probe core_pmu_available() shares.
+    """
+    core_pmu_probe()
+    return CORE_PMU_COUNT
+
+def single_core_pmu():
+    """
+    Does perf see only one core PMU?  Asked for by the comparisons that need
+    it, not at import time, as a run may never get to one.
+    """
+    return core_pmu_count() == 1
+
+def hide_group_format(expected, recorded):
+    """
+    read_format's PERF_FORMAT_GROUP bit asks for the group members to be read
+    along with the leader, which aside from this bit is verified with the
+    fd/group_fd based group checking, and with more than one core PMU a group
+    whose members are pinned to one of them, say 'default_core', leaves the
+    clones for the other core PMUs without any members, so that bit isn't
+    there: whether it is there is a consequence of how the evlist got
+    expanded to more than one core PMU, not of what the expectations are
+    about, so take it out on both sides.  On a machine with a single core PMU
+    there is nothing to expand, so the expectations keep verifying it.
+    """
+    if single_core_pmu():
+        return expected, recorded
+
+    return (mask_bits(expected, PERF_FORMAT_GROUP),
+            mask_bits(recorded, PERF_FORMAT_GROUP))
+
 def hide_sample_id(expected, recorded):
     """
     perf asks for a way to tell the samples apart, PERF_SAMPLE_IDENTIFIER where
@@ -160,6 +207,8 @@ def hide_sample_id(expected, recorded):
         return expected, mask_bits(recorded, SAMPLE_ID_BITS)
 
     if not asked:
+        if single_core_pmu():
+            return expected, recorded
         return expected, mask_bits(recorded, SAMPLE_ID_BITS)
 
     return (str(int(expected, 0) & ~SAMPLE_ID_BITS | SAMPLE_ID_EITHER),
@@ -261,6 +310,8 @@ class Event(dict):
     def hide_event_count_dependent_terms(self, term, expected, recorded):
         if term == 'sample_type':
             return hide_sample_id(expected, recorded)
+        if term == 'read_format':
+            return hide_group_format(expected, recorded)
 
         return expected, recorded
 
-- 
2.55.0

