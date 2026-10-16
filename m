Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4A423E330;
	Fri, 16 Oct 2026 00:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792109959; cv=none; b=tb2Z2FCMB9aJHnh0d55mXlhrwYGm5KOAaZ1EnkHBje0sVxcudvtyH0lCJd7c4wVXRJYmb5TVJeRyzmFMEr31aSYSmGMWAgJ/+doSTK2m0r/YOVp0ZhmS7etUEUdzwJwAopxYE8I0H6a6Or+H1v7U1IFRqb/Yw0dxjdynvCeIFQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792109959; c=relaxed/simple;
	bh=LPi/4S/ximBzDhKKOIAbzNoZgwRbLStPp6HwkoENirk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9wd5CiPuQh2Q3/IKcaMHL+e816v6wKswpkHKFWjWSsa6R8JGQooV92KGM6u9rlTJsEWQu1GUSsE1O8BVTnqSbNfQEZZwVY85aEul/Ua+k2p8kg4fgRqvUUQbb0bkpXVnqwq9Tom9Rl3Jj0qmdjBV8s8CTskrzK2ooj12SFPtPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHalfb3y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHalfb3y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DEF31F000C4;
	Fri, 16 Oct 2026 00:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792109957;
	bh=jUlm5FDHjfSbeD70IUl2mfhHCD5Etr5t45T8zRpgY+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mHalfb3yYgdfnXVTaZHIXj6nhI4hhNBrrixS1xc4lbBSKdHIcCN5q14SA0t1j9HZy
	 IHefVA017bObwqXIcR+/q4r1ATrmTtqeN6F939VuZGc9W+dpDGfE4wPm6fBXbVGYQR
	 t6L+Dizx6oQmjvjDC/evVUfRFoAHsPVc2tDLCm6PVbH0Wr8PUQimAFWCLUkjSn2u6s
	 fTTOgFFglGJdfWyPOG3X0rqPs9b5tMW+DECpbXuMlZ0lvb06FzptqL2MROdz3eHx2l
	 fOXkvvVdw220h1vSMYSqCc5/OkLoFMYePey7Qj5INUr0+vCuoJDoUMeKtUhm7vDJm2
	 AgCPFuwhH5gmg==
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
Subject: [PATCH v3 10/19] perf test attr: Accept either sample id bit perf asks for
Date: Thu, 15 Oct 2026 21:18:34 -0300
Message-ID: <20261016001843.71978-11-acme@kernel.org>
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

evlist__config() asks for a way to tell the samples apart,
PERF_SAMPLE_IDENTIFIER where available, PERF_SAMPLE_ID otherwise:

  bool sample_id = opts->sample_id;
  ...
  if (opts->full_auxtrace || opts->sample_identifier) {
        ...
        use_sample_identifier = perf_can_sample_identifier();
        sample_id = true;
  } else if (evlist__nr_entries(evlist) > 1) {
        ...
        use_sample_identifier = perf_can_sample_identifier();
        sample_id = true;
  }

so the id is asked for whenever the evlist has more than one event, and
also when asked to outright, with --sample-identifier or by an auxtrace
session, or by record__config() for a pipe run, through opts->sample_id,
none of which depends on the sample types: 'perf record
--sample-identifier -e cycles' and the arm SPE expectations in this very
directory ask for it with a single event.

Which one it asks for depends on the composition of the evlist: with
more than one core PMU a request for 'cycles' becomes one event per core
PMU, the extra dummy tracking events then make the sample types differ and
perf goes for IDENTIFIER, while the expectations were written on machines
with a single core PMU, where perf asks for ID:

  expected sample_type=263, got 65799    # 263 | (1 << 16)
  expected sample_type=343, got 65815    # (343 & ~(1 << 6)) | (1 << 16), group-sampling

Both bits mean the same thing here, how the samples get associated with the
event that produced them, so when the expectation asks for one of them, ask
for "an id of some sort" on both sides, and when the expectation doesn't
ask for any, take the bits out of what got recorded: whether they are there
and which one it is are consequences of what was asked for and of how the
request got expanded, none of that is what these expectations are about.

Since Test.compare() looks at both directions, expectations matching the
recorded events and recorded events matching the expectations, keep track
of which side is the one perf recorded to take the bits out of the right
side.

The masking is only for the comparison: the warnings keep showing the
values as they are, nothing to un-mask by hand to see what is being
complained about.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/lib/attr.py | 82 ++++++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/shell/lib/attr.py b/tools/perf/tests/shell/lib/attr.py
index ee55fbe6f07bd7b5..da4614068772eaec 100644
--- a/tools/perf/tests/shell/lib/attr.py
+++ b/tools/perf/tests/shell/lib/attr.py
@@ -75,6 +75,8 @@ def core_pmu_probe():
 
 PERF_TYPE_HARDWARE = 0
 PERF_TYPE_HW_CACHE = 3
+PERF_SAMPLE_ID = 1 << 6
+PERF_SAMPLE_IDENTIFIER = 1 << 16
 
 # The legacy event types, where perf may qualify 'config' with the core PMU
 # type in its top 32 bits when there is more than one core PMU.
@@ -106,6 +108,49 @@ def hide_core_pmu_type(value):
     """
     return mask_bits(value, 0xffffffff00000000)
 
+# The two sample id bits mean the same thing here: how the samples of the
+# events in the evlist get associated with the event that produced them.
+SAMPLE_ID_BITS = PERF_SAMPLE_ID | PERF_SAMPLE_IDENTIFIER
+
+# No real sample_type bit is this high, so it can stand for "either of the
+# sample id bits" when comparing the two sides.
+SAMPLE_ID_EITHER = 1 << 40
+
+def hide_sample_id(expected, recorded):
+    """
+    perf asks for a way to tell the samples apart, PERF_SAMPLE_IDENTIFIER where
+    available, PERF_SAMPLE_ID otherwise, see evlist__config(): whenever the
+    evlist has more than one event, and when asked to outright, with
+    --sample-identifier, by an auxtrace session, or by record__config() for a
+    pipe run, none of which depends on the sample types, as those only choose
+    between the two bits:
+    with more than one core PMU the dummy tracking events make the sample types
+    differ, so IDENTIFIER is asked for even for events whose expectations ask
+    for ID, written on a machine with a single core PMU.
+
+    So treat the two as the same thing: when the expectation asks for either
+    of them, ask for "an id of some sort" on both sides, and when the
+    expectation doesn't ask for any, take the bits out of what got recorded.
+    """
+    try:
+        asked = int(expected, 0) & SAMPLE_ID_BITS
+    except ValueError:
+        # The expectation is a wildcard or a set of alternatives.
+        return expected, recorded
+
+    try:
+        recorded_id_bits = int(recorded, 0) & SAMPLE_ID_BITS
+    except ValueError:
+        # The recorded side is a wildcard or a set of alternatives.
+        return expected, mask_bits(recorded, SAMPLE_ID_BITS)
+
+    if not asked:
+        return expected, mask_bits(recorded, SAMPLE_ID_BITS)
+
+    return (str(int(expected, 0) & ~SAMPLE_ID_BITS | SAMPLE_ID_EITHER),
+            str(int(recorded, 0) & ~SAMPLE_ID_BITS |
+                (SAMPLE_ID_EITHER if recorded_id_bits else 0)))
+
 class Fail(Exception):
     def __init__(self, test, msg):
         self.msg = msg
@@ -198,13 +243,33 @@ class Event(dict):
 
         return value
 
+    def hide_event_count_dependent_terms(self, term, expected, recorded):
+        if term == 'sample_type':
+            return hide_sample_id(expected, recorded)
+
+        return expected, recorded
+
+    def recorded_side(self, other):
+        """
+        Which one is what perf recorded? Both directions get compared, see
+        Test.compare(), so this can't be taken from the arguments' order.
+        """
+        if getattr(other, 'recorded', False):
+            return other
+
+        return self if getattr(self, 'recorded', False) else None
+
     def equal(self, other):
         for t in Event.terms:
             log.debug("      [%s] %s %s", t, self[t], other[t])
             if t not in self or t not in other:
                 return False
-            exp = self.hide_core_pmu_type(t, self[t], other)
-            got = self.hide_core_pmu_type(t, other[t], other)
+            recorded = self.recorded_side(other)
+            expected = other if recorded is self else self
+            exp = self.hide_core_pmu_type(t, expected[t], recorded or expected)
+            got = self.hide_core_pmu_type(t, (recorded or self)[t], expected)
+            if recorded is not None:
+                exp, got = self.hide_event_count_dependent_terms(t, exp, got)
             if not data_equal(exp, got):
                 return False
         return True
@@ -218,10 +283,15 @@ class Event(dict):
         for t in Event.terms:
             if t not in self or t not in other:
                 continue
-            exp = self.hide_core_pmu_type(t, self[t], other)
-            got = self.hide_core_pmu_type(t, other[t], other)
+            recorded = self.recorded_side(other)
+            expected = other if recorded is self else self
+            exp = self.hide_core_pmu_type(t, expected[t], recorded or expected)
+            got = self.hide_core_pmu_type(t, (recorded or self)[t], expected)
+            if recorded is not None:
+                exp, got = self.hide_event_count_dependent_terms(t, exp, got)
             if not data_equal(exp, got):
-                log.warning("expected %s=%s, got %s", t, self[t], other[t])
+                log.warning("expected %s=%s, got %s", t, expected[t],
+                            (recorded or self)[t])
 
 def parse_version(version):
     if not version:
@@ -506,6 +576,8 @@ class Test(object):
             log.debug("  loading result events")
             for f in glob.glob(tempdir + '/event*'):
                 self.load_events(f, self.result)
+            for event in self.result.values():
+                event.recorded = True
 
             # resolve group_fd to event names
             self.resolve_groups(self.expect)
-- 
2.55.0

