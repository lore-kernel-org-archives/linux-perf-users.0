Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24865A95C
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 23:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753312957; cv=none; b=j9fvievgs1x4e6oTrDBZ1vj64mU+68ZdqjM4JKtT9Vj17Ay1HSwFy9T4tRlq0lnrGn6ByTH60qwaXiRNXzpFkt5ValU7DCnHOON31SlLvNZKvRgM2xETXdlfz3YndVFcNe79hADGbcQsg42OjfcCnJAOnzj2yEtq3FMljnHETUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753312957; c=relaxed/simple;
	bh=VcpanhCkZm3FRe9xGqjSs8sLmkYF/QBYBBgcOLz2BN0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=rWwFcn43co+w+O3X0vqHkMNYpWwA521pGQsrOS/0u60VBu1qo2+r3W+Dy/Svza/r+uSUD8Ye75nzJe33WLX7AXmLgPOeDM7nRsblN7FtO3M5lJRHWH/dvvQUfILV15xihmUcgBzX/lmO2rYA7GMIT/wcod4+4EsuEOUZjtpQbko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J+xK7b3s; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J+xK7b3s"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74ad608d60aso343556b3a.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 16:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753312955; x=1753917755; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0ZDtxjF+caerujr20HCUgzj0FnWdX8QfIpvW2GkLj1I=;
        b=J+xK7b3sPkIZQapB/jdEvcGZs8dt4uM1cABPeipwmK0yaQ65WuIy5xKoZR08557xk0
         pJydVOp2IkXfCQqUssujBjN0J26Zi3V+cOxorvFQQo1zoqWnDX/Zp6LDQXM69ZtOJBo2
         Lj5wW//76Cv3U05V8pUvimyEWocyaIjwIDxav+pScxa3hkOrzOR5s/7droqcqTFkhP3+
         CkNazCemonsNZXBCS/4CVk4Pw+8dguBD1DuP/FuM5/f9r766AliYHaREXvq1GoVMJNx6
         WO9BiBJbm64CV7hkPFsjwePfl+y0caOCB+4L266LWMdWDEk37Lnn4DR9/auNZ2ft48IA
         LKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753312955; x=1753917755;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ZDtxjF+caerujr20HCUgzj0FnWdX8QfIpvW2GkLj1I=;
        b=b+Bl9GjN6TgJruMnTfqVlUVSW5tiMyhrRbmIXi+SAny0GIVYXVvalmsU9fVXfNcYBP
         d/86273gvh+rPRVlXCYSgn69mJyzO+WSGnM5V7MSiSGCuVz5Fm4g93aF76EIaWLQxAL4
         eORF5Di6QyZc9gGqsc/D64Xk1dFYvahNreHV9t3csiqIB1skv0nQvbefbxtMrfJtVCMa
         Cq7MuZGKQtmmOESAw1XG57FNLgdyI5k9MeLEBNDb7VY9ROySfUhZY3/C/BzJcvCcCxZ9
         IoRtBYQF9pJdO5PMpis5uNQOWZ2Crj+4gF/BFRLzwmIJopiHXoOaTFiOyeJ2q/bulXnh
         MHrw==
X-Forwarded-Encrypted: i=1; AJvYcCVb+RCBgVwrzHEvGGWF5HpWrAjzXKEGAFlulqE3D7O6KUvYlKjG/D+abBw/XM3IKsfsDpJcdA3Ca9XhA+8G1LwQ@vger.kernel.org
X-Gm-Message-State: AOJu0YycVla4QctAWSyfhpyo3ihaOHRr1zxXwM1cNv0Vrmo2kt+bines
	1zHVOakOhaZWFZsflQzYK+PYXYF224/O0iPMXur8E36JhQpQFcT1ek7lLZJRLPpkv64j9q9qN5W
	UqEBuxwwYZA==
X-Google-Smtp-Source: AGHT+IH+DgQvHJsPj3FakFLGYtedKSjVmdch3GQz+inZc5S92HXOog4OyD7q+VA2qKgfv1Gj0RcAUvyZ4dGC
X-Received: from pfbde7.prod.google.com ([2002:a05:6a00:4687:b0:748:ed01:df48])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2303:b0:736:4d05:2e2e
 with SMTP id d2e1a72fcca58-7603400d8c1mr6259641b3a.6.1753312955269; Wed, 23
 Jul 2025 16:22:35 -0700 (PDT)
Date: Wed, 23 Jul 2025 16:22:01 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250723232217.516179-1-irogers@google.com>
Subject: [PATCH v8 00/16] New perf ilist app
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
 .../arch/common/common/software.json          |  92 ++++
 tools/perf/pmu-events/empty-pmu-events.c      | 266 +++++----
 tools/perf/pmu-events/jevents.py              |  15 +-
 tools/perf/python/ilist.py                    | 500 +++++++++++++++++
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
 tools/perf/util/tp_pmu.c                      | 210 +++++++
 tools/perf/util/tp_pmu.h                      |  19 +
 19 files changed, 1648 insertions(+), 441 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/common/common/software.json
 create mode 100755 tools/perf/python/ilist.py
 create mode 100644 tools/perf/util/tp_pmu.c
 create mode 100644 tools/perf/util/tp_pmu.h

-- 
2.50.0.727.gbf7dc18ff4-goog

