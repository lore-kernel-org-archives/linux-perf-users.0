Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C350548571;
	Tue, 13 Oct 2026 20:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922505; cv=none; b=rk02qXhY3/h5Lm8wnoz192vyEU4JuqGX8NJ3oNpqbLQGCp1qSWikmSc1FZV81PKdHwgn03K8DM7KK4kVfp/hIRtPXpBDSqdSTGiDC5nT8KNpQTfHYfvRy+iXboEAOI29mg3rG/rtY5xrEPdbPrTq0Z8+VtcHYhL8DgElw1JAgB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922505; c=relaxed/simple;
	bh=WovNExGZiFzdFWR7F1M30yfO6VJBw8v7D7zHTHoSSk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DbpN2RCdtn4VtvG0UFdKIIgyaR4btgAtaGeDWoaelaUSG4RmGWhq/R9jyKbSQqTWZUdYp7cVKVGIAI0e3daddAV8OWIFjd0CjmiSp6Gy7oKEh8F09b2M9Yl1sCz3Y8dOL0MdjParUg8stHUzNEfRx8reWkhpeBgjJU9Fj9TCROQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTooHdI/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTooHdI/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937D21F000FF;
	Tue, 13 Oct 2026 20:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791922504;
	bh=Zgi7YhpIR7wMSAazs7tO3pTqYAeCHrzL1I8KPI2OwcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RTooHdI/Jw6GPAzDVn34C2uV/8URh++lV/pA1dB/plZtzfUtpoc8DLu43/OFTaZIO
	 llndZ7Q5YyhoeTAgDJ+636N+WQvrPQ/yuHRQ96tJ9DtcuQ5NuYR1StU3AgqVd6LAJ+
	 UsgeuJyanxKUudYgvzySCos6t12tB651y8pmt9dkLTtsQCOB9qPfYj5zVIGQwUeTd+
	 25Gvmhv4lM3v4AOOfOT1Cm+/vpoWCBiS50DU/v+P7QCJTlir/cywSL5qKLD4LYatzv
	 qksQ9Mf3kW7hT4c8iTgBNEPkRDfE5JmNsLZdwZlTACT/qnZYFr/AYdfqZhSw9vcq8A
	 /pIvl0oNDP5jg==
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
Subject: [PATCH v2 13/19] perf test attr: Ignore the group read_format bit the PMU count can remove
Date: Tue, 13 Oct 2026 17:14:08 -0300
Message-ID: <20261013201415.36428-14-acme@kernel.org>
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

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/lib/attr.py | 46 ++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/perf/tests/shell/lib/attr.py b/tools/perf/tests/shell/lib/attr.py
index 65b1e655a2bcb505..3bf07d4df95987d8 100644
--- a/tools/perf/tests/shell/lib/attr.py
+++ b/tools/perf/tests/shell/lib/attr.py
@@ -115,6 +115,50 @@ SAMPLE_ID_BITS = PERF_SAMPLE_ID | PERF_SAMPLE_IDENTIFIER
 # sample id bits" when comparing the two sides.
 SAMPLE_ID_EITHER = 1 << 40
 
+PERF_FORMAT_GROUP = 1 << 3
+
+def core_pmu_count():
+    """
+    How many core PMUs does perf see?  An event with no PMU named in it
+    becomes one event per core PMU, see parse_events_multi_pmu_add(), and
+    that is the expansion that leaves the clones for the other core PMUs
+    without any group members and that makes the kernel qualify 'config'
+    with the type of the PMU it is for, so this is the number of events perf
+    makes of 'cycles'.  None when there is no binding to ask, as in
+    core_pmu_available().
+    """
+    try:
+        import perf
+        parse_events = perf.parse_events
+    except (ImportError, AttributeError):
+        return None
+
+    try:
+        return len(parse_events('cycles'))
+    except OSError:
+        # No PMU that can count it, see core_pmu_available().
+        return None
+
+SINGLE_CORE_PMU = core_pmu_count() == 1
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
+    if SINGLE_CORE_PMU:
+        return expected, recorded
+
+    return (mask_bits(expected, PERF_FORMAT_GROUP),
+            mask_bits(recorded, PERF_FORMAT_GROUP))
+
 def hide_sample_id(expected, recorded):
     """
     perf asks for a way to tell the samples apart, PERF_SAMPLE_IDENTIFIER where
@@ -245,6 +289,8 @@ class Event(dict):
     def hide_event_count_dependent_terms(self, term, expected, recorded):
         if term == 'sample_type':
             return hide_sample_id(expected, recorded)
+        if term == 'read_format':
+            return hide_group_format(expected, recorded)
 
         return expected, recorded
 
-- 
2.55.0

