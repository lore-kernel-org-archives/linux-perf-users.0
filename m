Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA64529AAF5
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 23:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191867; cv=none; b=exuYD02yWrPunOXL0/gG9jjIu3FYKRMhTSPGZclS+ZsqrRFuMRZ4/6U31JSQczUmykwEW8uT2oCX3sB3wPgOkr2VEg4cSHU2RYNZEoDr/OeSirG+bTpAdE+M/JpM6ljhFSVDm2KYEQDSv1xzJeQEzhW5t4A8aURRZ8tjKUTmu0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191867; c=relaxed/simple;
	bh=95+AUuyoYEuhtL3fuf6WVONPyYA4Z7sb4lObaArXfc0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=il8RytBy2FEkVN+AxORthQ+9ykqDByyFk8IWK/Dna/4Q9o4KeqZPK3Z2UAtnb5IWLrvRefpaNXcj9fpenBuNn7wxXBfvUMD0GYNdmPFMpx9cdrqXooKScTbHD3LNUGuhYK9Kyx2bHDMCTt8drDnchqTo5iQjWXGplMdfc+Y/kjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w2j/ZaWD; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w2j/ZaWD"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b26e33ae9d5so1827483a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 16:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752191865; x=1752796665; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dN2TK04HBhD29nOWl6/VfFNctXN6qs0Tn4WpjxjIjMQ=;
        b=w2j/ZaWDz8os8qIghsRKhz5rmNFJ+RNjQ01X/CWae5Rx1Cymr1tmjuoFwhhXIyFIPB
         w1RVIBs8nzcSuBeYdnW2WTgRGkepOnRTJCseR4H0R9+f9IHV3xY+WDW1VdXIz3cvIUNc
         h3y/MYHcAePV5rOGjqVNdA1J9KNTSxAjagjihu3864mVmBkWxLTxEqjoC3bhNnscwOaD
         PoW77QUsU6C5bm23sWZ58rwoFUFqN5WqirRQ7PkGP/2KDpVjY+kM4I3V2ASOS3bgG00d
         sbUEsrlNaGt2GNRO24pgxzYCl7mPvPI/qxl7AqlCbQkbTAen5ZjJ8ApzaVqCYZD5Mz5p
         prBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752191865; x=1752796665;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dN2TK04HBhD29nOWl6/VfFNctXN6qs0Tn4WpjxjIjMQ=;
        b=vrDgV2Jwq9Sblab2p1uMGBwfPHkI1hxzYWXBgBjFnCeE2VcLEyBuqf7JvYuMke1y7D
         xMcrp6Z/+drTTiXBKEXyK0jw5yZr4wGtcruguMgVFAfUYXJ1GVe+YpS4vtdfspoEodh2
         MiJsa6rfO5ZYrdvNzQEiwSt5esYMHySXYJv7aC7XOIXWtb+6sfSkElrGj6MVa1eMRvYB
         7f5xLTSqJ0WQJUgM+jSlDLXAGKGIzM8jixK/Va9soXg+MzY2LsQbAxg0d1MSXAPKYulX
         Ts6Gva0kPZ6DnSG31s1NwvfeUS8g899lzZ1z1TgIK81iBZcSM2el0lHO54OjjgsHJmUy
         sNXw==
X-Forwarded-Encrypted: i=1; AJvYcCUWqCBw43Nzm2e6m48a4C7Eohd4A7yNEAzAkXXcYOXwxIkQxVSqq+0CUsoTTIwS0pvf/ZDw8cKv3RnHc6wazqKp@vger.kernel.org
X-Gm-Message-State: AOJu0YxWvwiYGgl2s/k106wONItB/jyE3nDMRx12p7+LDsrzr0Hgb1Zg
	7ExUbbJmGzgYKb/1qM4qeWp0ezffrIiLopR4H8anuYiX9S5N+itaAhvk+/2rHZJGbUdj/WnLgrz
	akAoWDiNEFw==
X-Google-Smtp-Source: AGHT+IE4CQ8/t6vW7E9YA7ZWHL6Xvc0yIKbgJ22MQ9g+SUAwscsjH90ZIIAaI+ibEq5p4BNwquiYEsR5MUXe
X-Received: from plbki3.prod.google.com ([2002:a17:903:683:b0:234:c2e4:1df6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce08:b0:234:bfcb:5c1d
 with SMTP id d9443c01a7336-23dede873eamr12523075ad.40.1752191865130; Thu, 10
 Jul 2025 16:57:45 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:57:21 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710235735.1089240-1-irogers@google.com>
Subject: [PATCH v6 00/14] New perf ilist app
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

Ian Rogers (14):
  perf jevents: Add common software event json
  perf parse-events: Remove non-json software events
  perf tp_pmu: Factor existing tracepoint logic to new file
  perf tp_pmu: Add event APIs
  perf list: Remove tracepoint printing code
  perf list: Skip ABI PMUs when printing pmu values
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
 tools/perf/pmu-events/empty-pmu-events.c      | 266 ++++++----
 tools/perf/pmu-events/jevents.py              |  15 +-
 tools/perf/python/ilist.py                    | 486 ++++++++++++++++++
 tools/perf/util/Build                         |   1 +
 tools/perf/util/evsel.c                       |  21 +-
 tools/perf/util/parse-events.c                | 198 +++----
 tools/perf/util/parse-events.h                |   1 -
 tools/perf/util/parse-events.l                |  38 +-
 tools/perf/util/parse-events.y                |  29 +-
 tools/perf/util/pfm.c                         |   2 +
 tools/perf/util/pmu.c                         |   7 +
 tools/perf/util/pmus.c                        |   2 +
 tools/perf/util/print-events.c                | 100 +---
 tools/perf/util/print-events.h                |   4 +-
 tools/perf/util/python.c                      | 485 +++++++++++++++++
 tools/perf/util/tp_pmu.c                      | 209 ++++++++
 tools/perf/util/tp_pmu.h                      |  19 +
 19 files changed, 1612 insertions(+), 428 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/common/common/software.json
 create mode 100755 tools/perf/python/ilist.py
 create mode 100644 tools/perf/util/tp_pmu.c
 create mode 100644 tools/perf/util/tp_pmu.h

-- 
2.50.0.727.gbf7dc18ff4-goog

