Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0217381E9C
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 06:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541576; cv=none; b=sU12z645En0Zbfg13jBg0AAip2x5nHIvXY2FABJPBrjglNhV10oscEp877AD1VGH6MSdJqou08lVuDtaLezKkzeRa3KWbRyv1F6f6ZzoTKBPEWFu2WV6lIniNTJxvpDUdjxqc857Saio06cerkWOZJneZQ7FQ1XytdRALc6dnBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541576; c=relaxed/simple;
	bh=z8VHYhTRIy3duEWi23Uc1KU937nLjl44jarDshm6x8g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lkjcSCnztiU92f9q+kv6qvFns6bUCvvzYtx6n/5ctn1Db3ui7/jH0QwaunGHcQ1OWMcBrfhNx1ObQyH78uj8GxvARytou4Mlmk8lZw+akiFheoFnYvow2knEaD8vzuK/5TUCzhCCDkfzlkv0s4ofSTpqCxEhRM0gFpLlyHS/rZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aIm4rMdO; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aIm4rMdO"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39de4a68f7cso5115529a91.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 23:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789541574; x=1790146374; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=meVDATHG1uPCpDl32HPsPsTL+5tKHdB4l0qq2TTnQ5Q=;
        b=aIm4rMdO3neLwNTz7KcmNMSDVEXtxnDzKECZZtZKqzbNOtcKif34aPb17LTy8C/cz3
         4M3A5VyU/gnjzdGyNcEalHHJmWVGuXE9PJyzLugQ/+2af/7I8bpS+rabgxnxcOMpaT5g
         DEve0AL+CfFY0jEVpYVZM4bMFv/B6SbO0UNPcSMTTnki4cyyIc3Frj/KLvGlHcyT9ZC/
         jx88mHQiH4NPv56LZVr0anjtLpZS4PtW6w6AbznWmF6LD/1hXsbn7R/SxNqPjtj2vpTD
         hKQRKEPrVS3/MexhMJhhwajiRLBiw3atz4QWY7E8y3UEFp2Bl7Gjrc4HxwyMzsFCno0q
         5sZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789541574; x=1790146374;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=meVDATHG1uPCpDl32HPsPsTL+5tKHdB4l0qq2TTnQ5Q=;
        b=SOBfy7hiHsDDnLB1b5LO3jonpxZla681s1TtNvySmaVTaAh/oBtAaNa6xMW/Tk1C2a
         CNJi90fVIK0aiBpPvlkivEhemVCNfgQmDHckHaI6gIZDLQSFnKdF0jKhhgwx0ZxzFxpf
         nfrn4UVDrduCtIoNKctwyaIDGpDoo6AYf8RPjzdy8srmpXO+tg1Uk+HXlHjlKt2j7nxk
         nyTMvZGx8VWWh35NQ7bZjRe5HESKZxqp9iUQHy4eQblAbXVy0pRYJf6ekoQEIhCxUoS6
         N+GSV9jKkQgiFA3qCB+uy3eoOgo+3RxFRTZx/dDmAR/VTYfEZbODwBA4IKdcvLdeEhnT
         uAAw==
X-Gm-Message-State: AFuF++nL93C6rTdDS7hABhLMVL+h0/WAk/9QL0ZT4DT9+7mA531YINQ0
	YVvthmRk7QqUwKhNYXtuwYBeff5m1Amj4k0sPjVtVie6skIEzPMI4DjGgKjigy1Oy/Kv1f1Gm8D
	6/+7JOr5noQ==
X-Received: from dlee7.prod.google.com ([2002:a05:7022:6287:b0:143:90c1:9534])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c41:b0:39d:fe64:5733
 with SMTP id 98e67ed59e1d1-39e1e5612demr4342750a91.24.1789541573835; Tue, 15
 Sep 2026 23:52:53 -0700 (PDT)
Date: Tue, 15 Sep 2026 23:52:39 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916065248.3153556-1-irogers@google.com>
Subject: [PATCH v2 0/9] perf report/top: Add opt-in --hybrid-merge
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, ak@kernel.org, ak@linux.intel.com, 
	andi@firstfloor.org, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org
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
--hierarchy and --hybrid-merge on the command line is an error.

perf stat is deliberately untouched. Counting already has its own
merging options, and this is aimed at sampling.

The events to merge are found with first_wildcard_match, which parsing
fills in. perf report reads events from a file rather than parsing
them, so there the wildcard grouping is recovered by matching event
names, and core PMUs are identified from the perf.data header topology
so that a file recorded on another machine is read correctly.

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

 tools/perf/Documentation/perf-config.txt      |   8 +
 tools/perf/Documentation/perf-report.txt      |   5 +
 tools/perf/Documentation/perf-top.txt         |   5 +
 tools/perf/Documentation/tips.txt             |   2 +
 tools/perf/builtin-report.c                   |  25 ++
 tools/perf/builtin-top.c                      |  29 ++-
 tools/perf/tests/Build                        |   1 +
 tools/perf/tests/builtin-test.c               |  50 +++-
 tools/perf/tests/hybrid-merge.c               | 206 +++++++++++++++
 tools/perf/tests/shell/report_hybrid_merge.sh | 121 +++++++++
 tools/perf/tests/shell/top.sh                 |  73 +++++-
 tools/perf/tests/tests.h                      |   1 +
 tools/perf/ui/browsers/hists.c                |   7 +-
 tools/perf/ui/hist.c                          | 246 +++++++++++++++++-
 tools/perf/util/config.c                      |  10 +
 tools/perf/util/evlist.c                      | 230 +++++++++++++++-
 tools/perf/util/evlist.h                      |   3 +
 tools/perf/util/evsel.h                       |   1 +
 tools/perf/util/hist.h                        |  15 +-
 tools/perf/util/parse-events.c                |   4 +-
 tools/perf/util/pmu.c                         |  43 ++-
 tools/perf/util/pmu.h                         |   3 +
 tools/perf/util/symbol.c                      |   1 +
 tools/perf/util/symbol_conf.h                 |   1 +
 24 files changed, 1046 insertions(+), 44 deletions(-)
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
prerequisite-patch-id: 9d468f113dffb082d74eb6d76e442b6ac69d9983
prerequisite-patch-id: 6f38fc0028b7d5eba7b8b646b402b8187bc3dbfa
prerequisite-patch-id: bc536fd240b5ddd999c781831a6445cb04ace25c
-- 
2.55.0.1032.g73a4cd73de-goog

