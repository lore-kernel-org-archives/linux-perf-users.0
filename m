Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D7B15A8
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 03:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749613572; cv=none; b=ALp2UHvHf6BZrSDXaRB9l9D7a/a6ANDxW4re5TmrPGgjn01nznyap7EFJavR47JsB5XofdogHFQHc/eXJjywO3TDLY9LzlylEBUfYP6nmnLvViFrNBALA7ZxO9iNagIkaW1yrLuaeOn3rusmfGMTAulCeYTMt8OQg8CMNDJawvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749613572; c=relaxed/simple;
	bh=2csHkhy2pXePCMc2AeZp5RyvwxoSeOzPWo8EYRzgOAI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=X25tlzdwxZhsXYAK7NiLCtcxFr1B3ql8RykKuH2+SIqAbBb3+lAdwZdLGWPB8xC1QJrx2U69To+Sc1ZyJQS7bHmEuNveY8JAu7fHXC9qW/DU8FBjv7V6NR1jS+qjrvf7fj8uspPpeEr1C2IV3f7El0XroFhi7EQYOzxTQ7eL9BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DnyeTBXU; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DnyeTBXU"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-234fedd3e51so55356245ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Jun 2025 20:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749613570; x=1750218370; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+xygVmSuw4hRMMSU5Uh3UPTWtcUCVelVQHOMGdOm8CI=;
        b=DnyeTBXUj0KoRKf8B3ihvPNmu5qu/27RBSCSZJpliZJASmFTVDnLjJfDUflpfZqigK
         fOSDOWD3+zjUuDtnQOL7MGx/GcupA9S7nxwW5ZAGrfKTgOgGuUPSNfIYXHyQamP5df5D
         Vm/zPU1HXT/NfgYMtukHO2E+oV0iEP+/6FvMwrP6ecEl/3zaYwYm85f3TgxEJLsGX9hz
         9oLyP7oVErfqfUKoluae1pgCXv+LvqU2GFObzdA9ZKytaFiYqKEaI3VcDOS0lMhWpna8
         I307CjxzyDmxKeBQfy04xjX0urHGsfY0MUE+Me2iGw3KEVV+Kg24mniSYEVPGNQHV3zh
         qvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749613570; x=1750218370;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+xygVmSuw4hRMMSU5Uh3UPTWtcUCVelVQHOMGdOm8CI=;
        b=VnW3IiCmicJ+uHFnzbtWnmcGN3M5/sCetBlqkELtbeL6vBVYFeHUrl8WR0t7bl2F1N
         WxfxF7U/kBQczN96VoAk39h6PIzpu64J2zrImZsv+uytlnLe3K4taYVJ0qoxSbCE/ebB
         h2EGqcP3YB7ZaPr5hjp2yTU+gi3uYja3VmdAjVT5CthdEVCWvAOrm6+/qBHmGr/uoEni
         DlYp02wPT5J755sMFRh3vKOdHx6SgAwqEFOa3rU6CVndCnz1V5hsYm7csTj3vAWKae7l
         VCyeJvFo8NsAqQYuHzqGeEPECmDK/+ScrMI3gKB5sLLcf8nkoi7s+I2kDMKWEZ9Sa7mn
         Wl9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQqcDmnovfJhl3ZWGGI14UbPJc+e2LH31nJWIIuiv+Sp1QrKe0l47jclBklWmE8qnB2wpD2JZAdJt50ZkrDQtM@vger.kernel.org
X-Gm-Message-State: AOJu0YwYXDY+Aeq8KkzjxADLbaC5Ej7gG2NSf8tgE9Eoa3Ap313BCswR
	7Pci57xCy/sqER+vZF7L52tO//LjzPIZkE8hgv8CIEAeMNFCT+oRxJ2nyKDcuCXQYifp27f7u8d
	e9xAFWGIAKA==
X-Google-Smtp-Source: AGHT+IEL+txh97AlLkbqHQYDwYP5jUms57DZbdCAPxU9yEb/WsUoLOnvzZykVmJTMMVdAWMDCUEn3hk5mm9+
X-Received: from plbkq3.prod.google.com ([2002:a17:903:2843:b0:234:b5d2:a1a9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f68b:b0:235:6f7:b918
 with SMTP id d9443c01a7336-23642683114mr20289155ad.28.1749613570377; Tue, 10
 Jun 2025 20:46:10 -0700 (PDT)
Date: Tue, 10 Jun 2025 20:45:14 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250611034529.508842-1-irogers@google.com>
Subject: [PATCH v1 00/15] New perf ilist app
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, John Garry <john.g.garry@oracle.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Gautam Menghani <gautam@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch series builds up to the addition of a new ilist app written
in python using textual [1] for the UI. The app presents perf PMUs and
events, displays the event information as in `perf list` while at the
bottom of the console showing recent activity of the event in total
and across all CPUs.

The first part of the patches are a few perf and perf python C API
fixes, most importantly the counter reading in python supports tool
PMUs.

The second part of the patches adds event json for the software PMU
and makes the tracepoint PMU support iteration of events and the
like. Without these improvements the tracepoint and software PMUs will
appear to have no events in the ilist app. As the software PMU moves
parsing to json, the legacy hard coded parsing is removed. This has
proven controversial for hardware events and so that cleanup isn't
done here.

The final patch adds the ilist command. To run it you need the updated
perf.cpython.so in your PYTHONPATH and then execute the
script. Expanding PMUs and then selecting events will cause event
informatin to be displayed in the top-right and the counters values to
be displayed as sparklines and counts in the bottom half of the
screen.

[1] https://textual.textualize.io/

Ian Rogers (15):
  perf hwmon_pmu: Avoid shortening hwmon PMU name
  perf parse-events: Minor tidy up of event_type helper
  perf python: In str(evsel) use the evsel__pmu_name helper
  perf python: Fix thread check in pyrf_evsel__read
  perf python: Correct pyrf_evsel__read for tool PMUs
  perf python: Add basic PMU abstraction and pmus sequence
  perf python: Add function returning dictionary of all events on a PMU
  perf jevents: If the long_desc and desc are identical then drop the
    long_desc
  perf jevents: Add common software event json
  perf pmu: Tolerate failure to read the type for wellknown PMUs
  perf parse-events: Remove non-json software events
  perf tp_pmu: Factor existing tracepoint logic to new file
  perf tp_pmu: Add event APIs
  perf list: Remove tracepoint printing code
  perf ilist: Add new python ilist command

 tools/perf/builtin-list.c                     |  47 ++--
 .../arch/common/common/software.json          |  92 ++++++
 tools/perf/pmu-events/empty-pmu-events.c      | 266 +++++++++++-------
 tools/perf/pmu-events/jevents.py              |  18 +-
 tools/perf/python/ilist.py                    | 238 ++++++++++++++++
 tools/perf/util/Build                         |   1 +
 tools/perf/util/evsel.c                       |  21 +-
 tools/perf/util/hwmon_pmu.c                   |   2 +-
 tools/perf/util/parse-events.c                | 225 +++++----------
 tools/perf/util/parse-events.h                |   3 +-
 tools/perf/util/parse-events.l                |  38 +--
 tools/perf/util/parse-events.y                |  29 +-
 tools/perf/util/pmu.c                         |  41 ++-
 tools/perf/util/print-events.c                |  95 -------
 tools/perf/util/print-events.h                |   1 -
 tools/perf/util/python.c                      | 248 +++++++++++++++-
 tools/perf/util/tp_pmu.c                      | 209 ++++++++++++++
 tools/perf/util/tp_pmu.h                      |  19 ++
 18 files changed, 1143 insertions(+), 450 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/common/common/software.json
 create mode 100644 tools/perf/python/ilist.py
 create mode 100644 tools/perf/util/tp_pmu.c
 create mode 100644 tools/perf/util/tp_pmu.h

-- 
2.50.0.rc0.642.g800a2b2222-goog

