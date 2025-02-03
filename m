Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DC1213228
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Feb 2025 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593070; cv=none; b=umC0HOT+URYyY2zZ/eumtKurRlKV4UX9dhWESiUdURfpJ89qSH47nUCnDx9wUYwo2ZiSkLIP51Ze9OvU9oFH7lESSxC7BMIj2PcJJtvjC/LCIELy1u68w81TVl7mVvS4O6mPNuncfNjgxLoEl10ydESnN4/dL8v57s/kT5ZvRMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593070; c=relaxed/simple;
	bh=PVbFWCN7HItodTQ7x+MpdorA3QHoDoHexz9bhRZGmus=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GwaYSjj3jphSvTyLBCfAcQWM/er0OvmC7Ts7Vuj/BrpEormc2VsAUvF5I1jriHL2X/BWrYjTQnIr/HHbYRbuEBY/y3ML5zfU3MvQeMWcCP5aiAknq5VmW1r/zoRpV44BqzXhBNa+DmOehx6/CTOWdo+X4W8X6DREIspvHIR/oc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y9pfs2ke; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y9pfs2ke"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-aa67fcbb549so22962366b.0
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Feb 2025 06:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738593067; x=1739197867; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZoYuftsJovCPiMK5YLE5Tz6ZOId2A3gszI9fRt9aptA=;
        b=Y9pfs2ke1doV3Om8jDzxiFkFQz5ufV2Ks4mO8tNMacUeDgFV5d1KtRy6F5nuP4d4PR
         k9Ub4BOJe995Djf6B36BGTvlsM+tJ758EsrZfhmjlyLy7bAbDFuVtxERod4Q6qnkPPTR
         9qR349dNUYJmXQB8Awuakf1y+RA8UIS6qlgLv2TMxBW+You/9bBUsWvwmYhGh5GV5/sD
         4vP/8SvEcT8zld3ZBxFVNbBDl1moqxIC1nJHQVKhxH/2U6zI+W4UQi4U/sBF9dQ8mOpG
         MYxB6OAWddjfFYEfesSFhOp08Ctc1nOIazIfgMOtmsBjtzQHzYKwY4P9/q/sv3ZmvL5v
         G/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738593067; x=1739197867;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZoYuftsJovCPiMK5YLE5Tz6ZOId2A3gszI9fRt9aptA=;
        b=QneeZ5TkFfpNI2CBayAvUpJ8buoyeMsGM3LDShZyya2rJz2z2NSo60Qk53YkSANQyT
         D+ugHMwFtIEFQ4sRjlL91enrvAzkYmF1Y81m5laOU+QAbA7j4hz0bb9y4KwRskl2EOXx
         8kKq/HpePhkVYmZjH69AMZd/juvnbYZREeIi//lRFv9bcXW7eqYPSH8pcO+ofvvGdkJC
         OUM+RqGiUU4VZHAN+q6NhsYGJizOIHZDeyzQ7BTtUUEvSHmH4yK+qWr2urgRCy/VbY2A
         5/EeB2J8Gbsr1OVfFvdKcKY0T3Ag9pvC5QlxaV2aQubRxNFx5mc+v9QNbe4PoG0CAEg/
         EkAQ==
X-Gm-Message-State: AOJu0Yy28PMtZ+BxVaqjee4gZrAxX7bUmcRJTJIqj9drTcSWsypj0Bpk
	09eGBpJrLqAZsJIWdTQ6UcUiGJSCQaid98ZlMg7kXoOi2JiJPf2Z7hUsIkq3UvIj77E4Le0MMdc
	mIc6//Q==
X-Google-Smtp-Source: AGHT+IECppgacT++xJLUxgVzyFh92FyH95V1O4u0p40+2AOGv/Oah3vC8US1Upz3woTGzfV6BHPnUIZGdjuW
X-Received: from edbef12.prod.google.com ([2002:a05:6402:28cc:b0:5db:f38e:f8c9])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:7d93:b0:aae:c3c1:1361
 with SMTP id a640c23a62f3a-ab6cfdd6b4fmr2453177766b.44.1738593067429; Mon, 03
 Feb 2025 06:31:07 -0800 (PST)
Date: Mon,  3 Feb 2025 15:30:35 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <cover.1738592865.git.dvyukov@google.com>
Subject: [PATCH v4 0/8] perf report: Add latency and parallelism profiling
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com, acme@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"

There are two notions of time: wall-clock time and CPU time.
For a single-threaded program, or a program running on a single-core
machine, these notions are the same. However, for a multi-threaded/
multi-process program running on a multi-core machine, these notions are
significantly different. Each second of wall-clock time we have
number-of-cores seconds of CPU time.

Currently perf only allows to profile CPU time. Perf (and all other
existing profilers to the be best of my knowledge) does not allow to
profile wall-clock time.

Optimizing CPU overhead is useful to improve 'throughput', while
optimizing wall-clock overhead is useful to improve 'latency'.
These profiles are complementary and are not interchangeable.
Examples of where latency profile is needed:
 - optimzing build latency
 - optimizing server request latency
 - optimizing ML training/inference latency
 - optimizing running time of any command line program

CPU profile is useless for these use cases at best (if a user understands
the difference), or misleading at worst (if a user tries to use a wrong
profile for a job).

This series add latency and parallelization profiling.
See the added documentation and flags descriptions for details.

Brief outline of the implementation:
 - add context switch collection during record
 - calculate number of threads running on CPUs (parallelism level)
   during report
 - divide each sample weight by the parallelism level
This effectively models that we were taking 1 sample per unit of
wall-clock time.

We still default to the CPU profile, so it's up to users to learn
about the second profiling mode and use it when appropriate.

Changes in v4:
 - added "Shrink struct hist_entry size" commit
 - rebased to perf-tools-next HEAD

Changes in v3:
 - rebase and split into patches
 - rename 'wallclock' to 'latency' everywhere
 - don't enable latency profiling by default,
   instead add record/report --latency flag

Dmitry Vyukov (8):
  perf report: Add machine parallelism
  perf report: Add parallelism sort key
  perf report: Switch filtered from u8 to u16
  perf report: Add parallelism filter
  perf report: Add latency output field
  perf report: Add --latency flag
  perf report: Add latency and parallelism profiling documentation
  perf hist: Shrink struct hist_entry size

 .../callchain-overhead-calculation.txt        |  5 +-
 .../cpu-and-latency-overheads.txt             | 85 ++++++++++++++++++
 tools/perf/Documentation/perf-report.txt      | 49 ++++++----
 tools/perf/Documentation/tips.txt             |  3 +
 tools/perf/builtin-record.c                   | 20 +++++
 tools/perf/builtin-report.c                   | 39 ++++++++
 tools/perf/ui/browsers/hists.c                | 27 +++---
 tools/perf/ui/hist.c                          | 64 +++++++++----
 tools/perf/util/addr_location.c               |  1 +
 tools/perf/util/addr_location.h               |  7 +-
 tools/perf/util/event.c                       | 11 +++
 tools/perf/util/events_stats.h                |  2 +
 tools/perf/util/hist.c                        | 90 +++++++++++++++----
 tools/perf/util/hist.h                        | 32 +++++--
 tools/perf/util/machine.c                     |  7 ++
 tools/perf/util/machine.h                     |  6 ++
 tools/perf/util/sample.h                      |  2 +-
 tools/perf/util/session.c                     | 12 +++
 tools/perf/util/session.h                     |  1 +
 tools/perf/util/sort.c                        | 69 ++++++++++++--
 tools/perf/util/sort.h                        |  3 +-
 tools/perf/util/symbol.c                      | 34 +++++++
 tools/perf/util/symbol_conf.h                 |  8 +-
 23 files changed, 502 insertions(+), 75 deletions(-)
 create mode 100644 tools/perf/Documentation/cpu-and-latency-overheads.txt


base-commit: 8ce0d2da14d3fb62844dd0e95982c194326b1a5f
-- 
2.48.1.362.g079036d154-goog

