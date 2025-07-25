Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E869E19C569
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 18:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753469529; cv=none; b=hFuijaQZChQLb0rNxYOwQcMQ+c8Fm8pLq2IbTM7ZL1ZUt+HrHVocI3pPTRpnj1yFSHdCCIl4xcm4cxMY8Us1MxEK88eaX2BW2IFz1Irj48jQ6DB0b/ws1aazhIARXY+aKjsq7GL6/772LPjDK7TG1/9mbAErdoSuyjHLU6dUHIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753469529; c=relaxed/simple;
	bh=8oIJfngvMrW9fWNdIZtgw9J8kD377p/Q73Fdf9p4VWI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=f55oEsOdFYz/VLDm8mUOoTbJRW6m167oxj86LYp7B9BAtZ6lszYqnjJCK6Ie1bY5JvmP2wYuYpLmGCm59C+g5SVtBt6M8Q5PcgeY775nozhF3ktt10B7b7nVhMpoJAoAsaiO7jk8mdd5MBDxzHKhY5ljQeD/x6eruX76nK0oNvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4u9LLLPW; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4u9LLLPW"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7494999de28so3664178b3a.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 11:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753469527; x=1754074327; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aVdpOVhjubNeYXQI6WN7gRgwIt8lIecjgPQif1dr7Kk=;
        b=4u9LLLPW+sBApLGI/tboTBF00aafMQB/e6kIsmKbH2DKCgS+WQpwehG6I7Uuw3dZ0M
         +j6ixt6dk4wDUEb07djZTo+BZ0crifhjTasLoSIFjoAGgYx5AVm/nbnNtrmrK2gmxyYF
         GYQAwBDlAR9xwBKpPsiyQeYkurF9WxBSCmk3+H8N9WGYbK5SEcQalC0Or0AynxtdeSkC
         t3qq+btgHmOIN2rFD76kOdrfjUzcfdnfhxkFZvBRPzwGWursyIUyE71wKtMtLf0VX3D8
         Xwl1cj/f5ZdbGVK6GMaq9ZDdHVJq2Z4UyKogoGzas9zftR887BJ5mIGxLnVZYqoAdgbk
         ooDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753469527; x=1754074327;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aVdpOVhjubNeYXQI6WN7gRgwIt8lIecjgPQif1dr7Kk=;
        b=v0XfPRinqdFI/G7S77sWMPTjCRFersAjBiO8GQOiOMvyP9d9TJxauOkk2LXCW5D85+
         obSkXf1m2aHtB0wPzPV8EhMVjv2qI/s3/t83OH8GinUMTF8D7bE+K6IebdhWLEv1qDiU
         lmmAzleJM3COJmo+c9UfZ5T1bYugKhJfO3QUn4e+AlBr2yeD8Wo48dVkc7xbsK1tL4dz
         2aM5S3roOINEC59D6qQNc29lDGv4e7d6Cd62BZUL6ZNZLkSAAT8oz7omKSCjOBx+b3NG
         rnECWA6zZ2aZFD/lCFs/hT8IUQEOBYfjtcxEaKB+VwlvTckqHTqV6154Ezy3K7L7jkKE
         sezQ==
X-Forwarded-Encrypted: i=1; AJvYcCXENi5bw42syCMoVkNiwK06cFxhlWMzbm1LKyJH6gEuhrx9LlwXqXrUeQvPaftOSVrudq14nJ3MnM0SER32Rsfb@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1seShRJQdlN72xWbnWJvQthiyXcGNlt5zAv9f+8NnK6THPRxw
	rF1ams8AHatQJKByj2Jv2ttmD7ZWD5N+T/nxIfHQDPNw0DnV3109v3y238QmZYCClMmWM/iR8BM
	bUFaq9WHWRg==
X-Google-Smtp-Source: AGHT+IFTsgoRQeW0+jQaNwoXU0fLedDjM4YKYe8UCZRJoEegwGeJYQ/3hDX0/UHgKn03H+3hcPGEAUr7zkx9
X-Received: from pfbay34.prod.google.com ([2002:a05:6a00:3022:b0:740:b0f1:1ede])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1741:b0:736:4644:86ee
 with SMTP id d2e1a72fcca58-763343da65dmr4477635b3a.14.1753469527072; Fri, 25
 Jul 2025 11:52:07 -0700 (PDT)
Date: Fri, 25 Jul 2025 11:51:46 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250725185202.68671-1-irogers@google.com>
Subject: [PATCH v9 00/16] New perf ilist app
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

v9: sys metric support and pep8 clean up suggested by Xu Yang
    <xu.yang_2@nxp.com>.

v8: nit fixing of issues caught by Arnaldo and Namhyung. Add Arnaldo's
    tested-by. Fail to repro issue reported by Thomas Falcon but
    encounter textual rendering and DOM query race, add an exception
    handling path to avoid the race being fatal. The change is minor
    in patch 16, so Arnaldo's tested-by is kept.

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
 .../arch/common/common/software.json          |  92 +++
 tools/perf/pmu-events/empty-pmu-events.c      | 266 +++++----
 tools/perf/pmu-events/jevents.py              |  15 +-
 tools/perf/python/ilist.py                    | 495 +++++++++++++++++
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
 tools/perf/util/python.c                      | 522 +++++++++++++++++-
 tools/perf/util/tp_pmu.c                      | 210 +++++++
 tools/perf/util/tp_pmu.h                      |  19 +
 19 files changed, 1646 insertions(+), 441 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/common/common/software.json
 create mode 100755 tools/perf/python/ilist.py
 create mode 100644 tools/perf/util/tp_pmu.c
 create mode 100644 tools/perf/util/tp_pmu.h

-- 
2.50.1.552.g942d659e1b-goog

