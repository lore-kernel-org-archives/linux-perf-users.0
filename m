Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBCD499F22
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 23:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602419; cv=none; b=tSRQRFuN43PzxRIVqNIznM9WB2ArU/ybDQVHzpQNA8XJRT+dY0YbiZhZSmsJiiJHR7Uclfo53B/pD7gFvTwtvVhQsqA6D7ivnpWyQrpdpuAbpvWOevUI87zcr5VgeYv95QOixxg2CZXSeRsVBPyUKylRVu3+k9lU1h00P/E39XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602419; c=relaxed/simple;
	bh=OyY1TZja93GT0HmA32yaLI5WkHXKsmEd3xpYjKsQdm4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=duzEoOuBcCpsdU2rkVogFpFsbamPOhICGIxq9hJyLMsZDrxyYRg0Ugf3nYfKtXFqx041TCMbWdJ16hNYs3V/O0k8pS//ROjZor3sjHy5MK+k3LFcu68K23sW6qQvJakUrlHjIlgTOu4h5mxYohHcCA9gAzYt5RFzJFW9t/uMO5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YJYcodZF; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YJYcodZF"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3823dcc1647so293323a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 16:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789602416; x=1790207216; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J9EbBeA5uug6KWLQDTVdpQF98+BNu8eUYWBhNRSoa/w=;
        b=YJYcodZFC2tRg/OANZFygYUFXojNYeZgxdEes/oFN38lzxNwu8r7Oxc//Cx8MLS5D0
         dEReEhn8HSseQHNhar80ih90N04sppSi8aonPSDKr0UsbyOwY6kyKMbUiljC+Jd3xDtd
         bwBkJVcwErdigaYBbUEavilLM5j1jVRP4WRizLzDn45JzhBDfx8mwzxBH5cWzYFjP8rQ
         15f6aEPGrBBM+og+/b9VzcG+m++m6oEODO0bXB87r8bRJ3bhbQR/w33WEVsKaD9QXedX
         0tBqCgwlUpHQOpwYd+DK1naefdzEcj5ZFUAA/ILlAzpRLeGu7+7kEiYXm/T4rw7MvXbW
         3s1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789602417; x=1790207217;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J9EbBeA5uug6KWLQDTVdpQF98+BNu8eUYWBhNRSoa/w=;
        b=nWg4ooAfAUWxMi8OeWKNXffRtoAiqq2AFhMJS/LL2UG1n+oSR/ghQXndlJKYAgqwky
         81aRMF5DSO7QPkWtGe2/4IalHwuD/oNDKMp+qJ+OjFDy6UQkEFOSAFhX/gZ7AZzx+Gp/
         2LM6r3NszYkQ5u7glUKB7XAQ0ic+C7R85C9yHwgaJGcWdkAGNsv/lKVxhH/ejpTGWhlZ
         LOPpYmBWendON1WXIDzdSZ+p9r7/fcDqqbxbU0PNfaX7PnZjDHucqDfZHUQzEbxzfeZ1
         ADLivmYNt1b70qLMF7Ddqnlg/IhLySSCPh8gpXSpmrsda3pAycNhqGBSKZzbpfhwDk6J
         4VeQ==
X-Forwarded-Encrypted: i=1; AKwUvBw6f7/p/+O5ieJ1WxQsUw9MwsTPZvg550oTEl5iNXhH3QyNjA0RFJCVVORtG8eULmSaTJ1ZfnVQIPcqb3OeY6Zi@vger.kernel.org
X-Gm-Message-State: AFuF++lWgzd2kLbrkUSX1zRweFoZ0CtGhY6vPdBPYDTyY19eF1AmpmZJ
	yV15cPvk6Fc8PBsbI47q8S/akGUCXdNYjQv8Ta9SEWw2L8wCHLXoiNs8gzlPZqP8zZWXupncH4I
	YldDrVSIKew==
X-Received: from dyau26.prod.google.com ([2002:a05:7300:601a:b0:335:65c3:a0a9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b91:b0:39d:ec43:3cc3
 with SMTP id 98e67ed59e1d1-39e1e2f3e9fmr9294287a91.10.1789602415733; Wed, 16
 Sep 2026 16:46:55 -0700 (PDT)
Date: Wed, 16 Sep 2026 16:46:43 -0700
In-Reply-To: <20260916065248.3153556-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916065248.3153556-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260916234652.439778-1-irogers@google.com>
Subject: [PATCH v3 0/9] perf report/top: Add opt-in --hybrid-merge
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
--hierarchy and --hybrid-merge on the command line is an error.

perf stat is deliberately untouched. Counting already has its own
merging options, and this is aimed at sampling.

The events to merge are found with first_wildcard_match, which parsing
fills in. perf report reads events from a file rather than parsing
them, so there the wildcard grouping is recovered by matching event
names, and core PMUs are identified from the perf.data header topology
so that a file recorded on another machine is read correctly.

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
 tools/perf/util/evlist.c                      | 218 +++++++++++++++-
 tools/perf/util/evlist.h                      |   3 +
 tools/perf/util/evsel.h                       |   1 +
 tools/perf/util/hist.h                        |  15 +-
 tools/perf/util/parse-events.c                |   4 +-
 tools/perf/util/pmu.c                         |  43 ++-
 tools/perf/util/pmu.h                         |   3 +
 tools/perf/util/symbol.c                      |   1 +
 tools/perf/util/symbol_conf.h                 |   1 +
 24 files changed, 1038 insertions(+), 40 deletions(-)
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
prerequisite-patch-id: 6210f4401a97fc55532f1078089921f64dad7d3e
prerequisite-patch-id: 9dd334df517a2d163e4b73358facd4369635032f
prerequisite-patch-id: bc536fd240b5ddd999c781831a6445cb04ace25c
-- 
2.55.0.1082.g2b9226bbc0-goog

