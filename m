Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EFF3A9610
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 05:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621647; cv=none; b=GzrZKXG8PBojtf4ksKK7XUBEKKfh5Qm3zZddJr6wyfmBTglDXSV/JUivvueNK5mSilh7iesudP9J6LB1mbFSJBKdcIty/k7mEoN0nEhwN7VjpVd+kjFV+TE7kSch0mo9PcP6I1IG2ZEsEJoxna9g/4dkZ5wS92CQgzPT1LlgkKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621647; c=relaxed/simple;
	bh=cFt44SHxGcWDgcO63lFzq/+IFdXSjvSDpV+OhK2AK7c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OIPNdBZrAUvbAxi8Kv+NCG6Rij5YRK8FzeMUS+4pqk69AZ72QbagNd3Bv+FAT4DGx5QvgxSTbx4YO3UaYQ1C0v5W3GIER1gVa3o9DbCnl+oCanJfuEezpEPwbazd0MmSyTksodfd3QPn7UP5vfGOVPPf6BZv3amMfWIavo/fbRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C0K7701B; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C0K7701B"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3965ba1ba3eso640920a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 22:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789621646; x=1790226446; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jZlUINB9kVpvLrcQBGXYEdhSBdWhJN/y2NDxIZPrIk8=;
        b=C0K7701BJUDweL9fGWbdNOmzuXoYBLxhqaX2R09sPQ3dsDgX9K5PuUY3ayoqZXATpV
         Edr2l6H7mLz1K1JVrpyCrPwT62qnXClgoJA1XESEQ+Y25dP7/8n6rOzNbUbJ7fJi77v2
         /CC+YyZx4iHuqTAb8MwunpssS0kjBltLUybOJFEFIWEDYvpBRctG/Ghhq7v5HKbsA/g5
         2ir2Ah925UAFYp4m5pwlVzA1D5Em2V8GJ213g3xAGWkazm85+ms6y/CMhPwGRkYvJwMI
         /P139bH9ynbP4Ktk2KA4kJn2paqrvWnOxlZsa7hnkgQGx6lBapBlqwD6dHSQbooU0atd
         QvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789621646; x=1790226446;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jZlUINB9kVpvLrcQBGXYEdhSBdWhJN/y2NDxIZPrIk8=;
        b=fkT0MjboRNzSugeD0CdZ/QsiLnwsYUnnEkqlyRUlbJVf6S3T0HD3gTm9rCPMI8Ef7Q
         2YzlgksXdvAqrzpRobSRmVKWJTApfoQUNrflDNhIddEYZIK3RJsNwQUdiRn/+oo2gO2H
         7EfYrqbOT4q01ujzyXSxXdeMfMpN7f2BPxiGwKGEO4oOWH0FCXrDciJrMzObE1BfkWEI
         j6lTyYWPn0SuP8dWj/KJQidrvX5ZffZYTZmzoJdV/AbWH/nG813B+q1F6jTB0r/xm3i9
         81mZoeJordk9XazDMvUCEdP3XA+sGgLvslZcJcbQVJW31b9XwJ0CTRddQ0hOxVHvf56A
         mK9Q==
X-Forwarded-Encrypted: i=1; AKwUvBybY7irjyvwQrPCAFN1P50InnaXeEQsjkMGBf4x7ZAQtsFgdECsIocUgX0LeV5Xq42NJj1dZprZGx3P4Wg3T0/2@vger.kernel.org
X-Gm-Message-State: AFuF++mI3VV9mRYPc/b5g/0OQhNq4BeHyeX7ofQLfPfQGDDREBATMIYN
	0dNbZQDZj7qvm81ovbatQ2UEkpRrPl9fROT/XwppcSlN6GcIhdZc3UZOzbQvfl7YMZUO9y7dTVR
	Y33S7jQ5luw==
X-Received: from dyu18.prod.google.com ([2002:a05:693c:8112:b0:339:7697:72ea])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b91:b0:398:a486:81ec
 with SMTP id 98e67ed59e1d1-39e1e380e12mr16256957a91.11.1789621645452; Wed, 16
 Sep 2026 22:07:25 -0700 (PDT)
Date: Wed, 16 Sep 2026 22:06:59 -0700
In-Reply-To: <20260916234652.439778-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916234652.439778-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260917050708.704702-1-irogers@google.com>
Subject: [PATCH v4 0/9] perf report/top: Add opt-in --hybrid-merge
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: ak@kernel.org, ak@linux.intel.com, andi@firstfloor.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On a hybrid machine a wildcard event expands to one event per core
PMU, so "perf record -e cycles" records cpu_core/cycles/ and
cpu_atom/cycles/. perf report and perf top then show one histogram per
PMU, and a symbol that ran on both kinds of core is split across them,
with each percentage relative to its own PMU's total. There is no way
to ask for the single combined profile.

Add --hybrid-merge to perf report and perf top, which merges the
histograms of the events that came from the same wildcard into one,
with percentages taken against the summed period.

Merging is opt-in because it isn't always the right thing to do. The
cores differ in performance, so a merged cycles count mixes work done
at different rates and a merged IPC is not the IPC of either core
type. perf-tips notes this. When merging is possible but wasn't asked
for, the TUI says so, rather than merging silently.

core.hybrid-merge in .perfconfig turns it on by default. As a default
rather than an explicit request it yields to the command line: with
--hierarchy it is ignored with a warning, whereas asking for both
--hierarchy and --hybrid-merge on the command line is an error. For
the same reason it is silent when there is nothing to merge, so it
doesn't warn on every invocation on a machine with a single core PMU.

perf stat is deliberately untouched. Counting already has its own
merging options, and this is aimed at sampling.

The events to merge are found with first_wildcard_match, which parsing
fills in. perf report reads events from a file rather than parsing
them, so there the wildcard grouping is recovered by matching event
names, and core PMUs are identified from the perf.data header topology
so that a file recorded on another machine is read correctly.

Changes in v4:
 - Patch 7: don't warn that there is nothing to merge when merging came
   from core.hybrid-merge rather than the command line. In v3, setting
   the config on a machine with a single core PMU made every perf report
   and perf top warn, which in the TUI is a popup that has to be
   dismissed. Track whether the option was given on the command line in
   symbol_conf so an explicit --hybrid-merge still warns, and document
   the difference.

Changes in v3:
 - Patch 5: remove the redundant if (!pos->merged_hybrid_group) guard
   around the group member walk in __evlist__enable() and
   __evlist__disable(), and update the commit message. In v2, that guard
   claimed to skip walking the members of a merged leader, but
   merged_hybrid_group is only set on merged members (which have no
   group members to walk), never on the leader itself.

Changes in v2:
 - The interactive 'M' keystroke that toggled merging in the hists
   browser is gone. Merging is now asked for on the command line or
   through core.hybrid-merge, and the browser instead points out that
   --hybrid-merge is available when there are events it could merge.
 - Fold "perf ui hist: Format group headers iteratively based on
   proportional visual allocations" into patch 2, as the two only make
   sense together.
 - New patch 5, so that enabling and disabling a merged set touches
   every event in it. The merged events are made members of a leader
   but are not a real group, so each still has to be toggled in its
   own right.
 - New patch 7, adding core.hybrid-merge.
 - New patch 9, so that "perf test" doesn't inherit the user's
   ~/.perfconfig. Without it, setting core.hybrid-merge breaks the
   output matching of unrelated shell tests.
 - Patch 8 adds a C test for the merging decision and a report shell
   test, rather than only extending the perf top test.
 - Rewrite the commit messages of patches 2, 3, 5 and 8 to describe
   the problem being solved rather than the diff.

Testing:

 - New "Hybrid event merging" perf test with three subtests: merging
   events of 2 core PMUs, of 3 core PMUs, and events that must not be
   merged.
 - New "perf report hybrid merge" shell test, and the perf top shell
   test extended.
 - perf test 13, 17, 27, 30, 31, 66, 67, 68, 78, 102, 113 and 172 pass,
   covering the hists, --hierarchy and addr2line paths this touches.
 - Builds in 13 configurations, and every patch builds on its own so
   the series stays bisectable.

Ian Rogers (9):
  perf evlist: Implement evlist__can_merge_hybrid using
    first_wildcard_match
  perf ui hist: Add support for aggregated total_period and merging
    entries
  perf tools: Expose opt-in --hybrid-merge
  perf Documentation: Add tip for hybrid event merging
  perf evlist: Toggle merged_hybrid_group properly in enable/disable
  perf tools: Add TUI hints for --hybrid-merge
  perf config: Add core.hybrid-merge to configure event merging
  perf test: Expand tests for --hybrid-merge
  perf test: Isolate test suite from user .perfconfig natively

 tools/perf/Documentation/perf-config.txt      |  10 +
 tools/perf/Documentation/perf-report.txt      |   5 +
 tools/perf/Documentation/perf-top.txt         |   5 +
 tools/perf/Documentation/tips.txt             |   2 +
 tools/perf/builtin-report.c                   |  31 +++
 tools/perf/builtin-top.c                      |  35 ++-
 tools/perf/tests/Build                        |   1 +
 tools/perf/tests/builtin-test.c               |  50 +++-
 tools/perf/tests/hybrid-merge.c               | 206 +++++++++++++++
 tools/perf/tests/shell/report_hybrid_merge.sh | 121 +++++++++
 tools/perf/tests/shell/top.sh                 |  73 +++++-
 tools/perf/tests/tests.h                      |   1 +
 tools/perf/ui/browsers/hists.c                |   7 +-
 tools/perf/ui/hist.c                          | 246 +++++++++++++++++-
 tools/perf/util/config.c                      |  10 +
 tools/perf/util/evlist.c                      | 218 +++++++++++++++-
 tools/perf/util/evlist.h                      |   3 +
 tools/perf/util/evsel.h                       |   1 +
 tools/perf/util/hist.h                        |  15 +-
 tools/perf/util/parse-events.c                |   4 +-
 tools/perf/util/pmu.c                         |  43 ++-
 tools/perf/util/pmu.h                         |   3 +
 tools/perf/util/symbol.c                      |   1 +
 tools/perf/util/symbol_conf.h                 |   3 +
 24 files changed, 1054 insertions(+), 40 deletions(-)
 create mode 100644 tools/perf/tests/hybrid-merge.c
 create mode 100755 tools/perf/tests/shell/report_hybrid_merge.sh


base-commit: 91b0782fc9e9d2f0a40b5256146e014802fdbb36
prerequisite-patch-id: b6fdc526887b71fb66f5fe0c0d41f7ef9493861e
prerequisite-patch-id: d47077f674c700f4f6296e9367f7ddfe004aea89
prerequisite-patch-id: ed0db23450840601762fe85ca1bef06ce6d28fe7
prerequisite-patch-id: d84e6b96d533ee6ed549e26e94216e2da60f7f74
prerequisite-patch-id: 6e8f19551d771621a5037096626cfe7e271b36f9
prerequisite-patch-id: 3768dfd588c7439deb741bce44c74763011c6be7
prerequisite-patch-id: babac99a4faa3b1525e44d3f34ab33a88103334c
prerequisite-patch-id: 5279827453fea1536abc620aa33c887c44e41ee9
prerequisite-patch-id: bdc0d648a577142b9270fb59b54496bc2bf8d5ea
prerequisite-patch-id: f840408dcc3cc637a071f2540b31cc7b8d2ca146
prerequisite-patch-id: 8f4f390a5a60f62b61c6c9220e96bfce155fa233
prerequisite-patch-id: bc536fd240b5ddd999c781831a6445cb04ace25c
-- 
2.55.0.1082.g2b9226bbc0-goog

