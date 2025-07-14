Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B17261591
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Jul 2025 16:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511456; cv=none; b=JqIXczjlT5whOtXjDc1SS8fnui+5faNN8anvcF8RvV6FVCQKVhkd5JmcImD0m0CBCPMDyaX7g/vaxUj8SDgtC7DRAo+Q82ivlAjO6sDIzYtjYTKcnxuvQ0AfLJypQGkNMmX8+03ETqSyjtJIvfTOxHSHv0q9Gww1btlEpjaDrAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511456; c=relaxed/simple;
	bh=t+a2SkAcj6T0eSvmTD7qi0+lN7j3n2GYAMGtMfSgSPc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=O2cHui5AFiFgnt6d61UUDRi7DwNBtAbTpvoYSxHscONTWgHL+ycLGKZKylFq4Ue7hM2m7HNnwteSp6AcK/DyAzxvcYTUXldvvObaCSnNHxLK0yWmd3smEEgRoGtWCSO1Mnse7hB1vJcKIcQ2nfMw8sEq/eG3//Q9IelQvmuYNyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V49QPCoA; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V49QPCoA"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-313d6d671ffso4076996a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Jul 2025 09:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752511454; x=1753116254; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VFyPI1s2IkbVzCYG2Z7Ep8TUV3hH0CXbA021pYJRVyM=;
        b=V49QPCoAICa+OJiPjtN+K3uQd3CpE9txc7LrCqqTjEYBNpMSirbtMqhDjfSQTLI4X+
         lbJqclhhlTwMV1dPQr5Uy/jliKA4gKrdiOdnRZvxkBAghVxXbGxpOk95XCzaMGwCYI0+
         IaOw/lUni/m1qKDG/oKtnjb5hedmVZhBuJ333VDpSsAiwHVKkOLgcXAqI4Q1RnEIcohe
         x4x6sqvQdocqyJKqQHcKCT6qBVqf6zxD8L1hPv3e8j93q3nCauE4jxib+y8DMDokZJuH
         16BRnS6iicL41MiPaE/OgBo95cIO+Pi2T9m5z5EnRXE+AKDhcBll4ycTmZt+5TPHEEcZ
         APAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752511454; x=1753116254;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VFyPI1s2IkbVzCYG2Z7Ep8TUV3hH0CXbA021pYJRVyM=;
        b=hLuxHyE5x0hooSMPZA74KVa74OkuB71Au18SAEh5brQD1VjSmb6V5V01OWfTpUHZRM
         geYJpCLXaY7b4bjNKhzNhsYaBwmWw+CzxyQgHyJcSr1Td02EwypAXalIMBeqA/I/5g8c
         SyMw6D0dgD2mtlQc55tatScvaNGSxCb5m2EjBBgQtpoPMtmZCtXALPvd5qZP4aqAnq3h
         ZxBriDoU9VeGTprFeiQTzsJcN5BsQZskjCarfnz1HgLg7yJNOY/hK+ASGKAuH/05kdhB
         dgaIM/K5euojTppk+zNJzxVaTpSFhLIgsBhKw2Fe+j9cJGHzz696kkodYtUjSrpy16BV
         layg==
X-Forwarded-Encrypted: i=1; AJvYcCXn9hNDLhlfVKqmhcPYkcGPEfVZk8x1IBmY8+bZCMczxfLykPlJzBHOCKectZ/TA0L6FrhWfPaD7+Bn83sEMbWI@vger.kernel.org
X-Gm-Message-State: AOJu0YyFl+AP1CFfNfVBXi/pjweIKCROeCgrsOZ9SgkAApKhP9PQnkPn
	LSyFyoofjCMl7Mnwpc1Y9V13j8kNFxYI5iXGBr5dpHtqFOrC7Y2ki9IGHKnh6aIlxFALJhM2vTU
	5chrr793t9A==
X-Google-Smtp-Source: AGHT+IFYzaZMjwWmVuW83RRm9jtD9SNB2OKHGMhucx6i5rlSKlsH5lMDboikiOyfR5br1heqyLd124VNy0wg
X-Received: from pjbtc11.prod.google.com ([2002:a17:90b:540b:b0:312:15b:e5d1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d484:b0:316:e77:e2cf
 with SMTP id 98e67ed59e1d1-31c50e46632mr13772225a91.35.1752511453971; Mon, 14
 Jul 2025 09:44:13 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:43:48 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714164405.111477-1-irogers@google.com>
Subject: [PATCH v7 00/16] New perf ilist app
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Collin Funk <collin.funk1@gmail.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch series builds up to the addition of a new ilist app written
in python using textual [1] for the UI. The app presents perf PMUs and
events, displays the event information as in `perf list` while at the
bottom of the console showing recent activity of the event in total
and across all CPUs. It also displays metrics, placed in a tree
through their metric group, again with counts being displayed in the
bottom panel.

The first ground work patches of fixes, cleanup and refactoring were
separated into their own series here:
https://lore.kernel.org/lkml/20250709214029.1769089-1-irogers@google.com/

The second part of the patches adds event json for the software PMU
and makes the tracepoint PMU support iteration of events and the
like. Without these improvements the tracepoint and software PMUs will
appear to have no events in the ilist app. As the software PMU moves
parsing to json, the legacy hard coded parsing is removed. This has
proven controversial for hardware events and so that cleanup isn't
done here.

The final patches expand the perf python APIs and add the ilist
command. To run it you need the updated perf.cpython.so in your
PYTHONPATH and then execute the script. Expanding PMUs and then
selecting events will cause event informatin to be displayed in the
top-right and the counters values to be displayed as sparklines and
counts in the bottom half of the screen.
 
[1] https://textual.textualize.io/

v7: Better handle errors in the python code and ignore errors when
    scanning PMU/events in ilist.py, improving the behavior when not
    root. Add a tp_pmu/python clean up. Minor kernel coding style
    clean up. Fix behavior of ilist if a search result isn't found but
    then next is chosen.

v6: For metrics on hybrid systems don't purely match by name, also
    match the CPU and thread so that if the same metric exists for
    different PMUs the appropriate one is selected and counters may be
    read. Likewise use evsel maps and not the evlists.

v5: Split the series in two. Add metric support. Various clean ups and
    tweaks to the app in particular around the handling of searches.

v4: No conflict rebase. Picks up perf-tools-next DRM PMU which
    displays as expected.

v3: Add a search dialog to the ilist app with 'n'ext and 'p'revious
    keys. No changes in the ground work first 14 patches.

v2: In the jevents event description duplication, some minor changes
    accidentally missed from v1 meaning that in v1 the descriptions
    were still duplicated. Expand the cover letter with some thoughts
    on the series.

Ian Rogers (16):
  perf python: Add more exceptions on error paths
  perf jevents: Add common software event json
  perf parse-events: Remove non-json software events
  perf tp_pmu: Factor existing tracepoint logic to new file
  perf tp_pmu: Add event APIs
  perf list: Remove tracepoint printing code
  perf list: Skip ABI PMUs when printing pmu values
  perf python: Improve the tracepoint function if no libtraceevent
  perf python: Add basic PMU abstraction and pmus sequence
  perf python: Add function returning dictionary of all events on a PMU
  perf ilist: Add new python ilist command
  perf python: Add parse_metrics function
  perf python: Add evlist metrics function
  perf python: Add evlist compute_metric
  perf python: Add metrics function
  perf ilist: Add support for metrics

 tools/perf/builtin-list.c                     |  65 ++-
 .../arch/common/common/software.json          |  92 ++++
 tools/perf/pmu-events/empty-pmu-events.c      | 266 +++++----
 tools/perf/pmu-events/jevents.py              |  15 +-
 tools/perf/python/ilist.py                    | 491 +++++++++++++++++
 tools/perf/util/Build                         |   1 +
 tools/perf/util/evsel.c                       |  21 +-
 tools/perf/util/parse-events.c                | 198 ++-----
 tools/perf/util/parse-events.h                |   1 -
 tools/perf/util/parse-events.l                |  38 +-
 tools/perf/util/parse-events.y                |  29 +-
 tools/perf/util/pfm.c                         |   2 +
 tools/perf/util/pmu.c                         |   7 +
 tools/perf/util/pmus.c                        |   2 +
 tools/perf/util/print-events.c                | 100 +---
 tools/perf/util/print-events.h                |   4 +-
 tools/perf/util/python.c                      | 519 +++++++++++++++++-
 tools/perf/util/tp_pmu.c                      | 209 +++++++
 tools/perf/util/tp_pmu.h                      |  19 +
 19 files changed, 1638 insertions(+), 441 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/common/common/software.json
 create mode 100755 tools/perf/python/ilist.py
 create mode 100644 tools/perf/util/tp_pmu.c
 create mode 100644 tools/perf/util/tp_pmu.h

-- 
2.50.0.727.gbf7dc18ff4-goog

