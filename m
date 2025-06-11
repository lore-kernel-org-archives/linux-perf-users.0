Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73AE8828
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657732; cv=none; b=POZERfC9Lc75zUcl2OCaDqPtcvf1SwiTzOL03q9onCOZrnhMaxUc9FrjiK1EdZTC3x0DoN4NUTJtVP7h795LTuLwnTq3sNeJHHQgkbwO65DB+99o8jVSOO31sSDw8BlYdvFhUMB/ip3J9uyNiVTzYmhyJsB49kB6ScAQgI46jYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657732; c=relaxed/simple;
	bh=znvhDvTA1BJf0cBqZdVezqV2z5dtsbF5RwqcL3qLCRU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=qjejaJ9fY7/QpYxJfRNQ60yoOWejeg6Kja12C1ZYyPJvHOQgiD28J7xmngDnPC6Ch7AxzRreieGRcIytWc9fw0IYDnwKTyTGb0dj7saog+EWlYMyA3ac6TYWusIVMx6ZjuVApwVA4yCp9SHwFC3y6q+MYklY4fTLHF7/AqSfbac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rj/IJOiL; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rj/IJOiL"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-747d143117eso25893b3a.3
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 09:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749657730; x=1750262530; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VvBM1i8NXfL7mOxsWT454fX7megUt2b8d725v+ousD4=;
        b=rj/IJOiLwMMthvWacVGRt/p4eeAfX9GadnmiZj7tYPUI2NF2uVI4s3zOEJLnrFdvh9
         ww6cqYXaU8k/LQJDuIDEGuXSVChmlXg2RYG/GgiF3XrlnuKJuRoiWgRylH6jbbf0g3/+
         tg0TdBMVNYwK5B279KnC+H/Xtjnb7I3DR/QnHoq/KtHvlSMNoP5oBb0BD7q7hFt9Da0u
         zYhMjumXTJXJAvntg0GPJceiYW/nags0+f9+TudijyAXgs1sAH0ph+w/sQ2tplzInHBB
         7fF1RMFkVWNaHLAtDH+yUdb0x8oXSCMh3gnX7oRI4L54FLy0aRxKHsvycKEz4KZpzy8+
         NQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749657730; x=1750262530;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VvBM1i8NXfL7mOxsWT454fX7megUt2b8d725v+ousD4=;
        b=fFHH5q4Q+8dIOCsCnuxSWiv02xiIrdVY1toaowuAXU/4JIXIXqtEaNzDgU+yJamGux
         MZXr+zozWyNKHT2Khv28GX2GnUNVb3DQmE3JriH2DBrxShNrlfApx+UiupzhYvBwghmq
         syyZA81djP56V1jidpbwsaA0s+v/Tm17p8u6LOBU5bbLruAJRsjLOpyLwRtV7K+47YUt
         sRAsiqs4cZLP5kktPHv4xbYTU0FRxEwKslyb7zdNkvnR7goXTS9BBAVIRW2VSe/vX26L
         FVet+espWQWDkyYgc9wk3/j9NV6i1q6AjkC1lh3GyzkCcK8IWwp3kENo9OsfrZWqwiNm
         xHCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlws9ejv0Yuf2pELd2IM6FHqD1Ig+hyx45DDG79ANMn3FbYoDgSdsHYSijevJMzumDFOA4x++eIlN+mFXa7kJj@vger.kernel.org
X-Gm-Message-State: AOJu0YwSAOHOKyYWDtBZFOCkqeXffmJ5Zk0DItNT4EYzXCwipyt7DLjQ
	nML8xsB9ED3tNw9Ur9z2GakUlXySVUPxNdo7csCSvn9IqRDBH+tG1qzYh9EASYmHab7SDO8YNT9
	lSLw3APzIIQ==
X-Google-Smtp-Source: AGHT+IHBzEuO3GTJ/9QMTDMXpNjitW0SZZV+SmnXhzalRJjSSa163nbGGWjt9fXIDYI2lK9vIDh8Phda1/C0
X-Received: from pfkq19.prod.google.com ([2002:a05:6a00:853:b0:746:2b90:bbe5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:854:b0:748:2d1d:f7b3
 with SMTP id d2e1a72fcca58-7486ce17f89mr4746167b3a.22.1749657729939; Wed, 11
 Jun 2025 09:02:09 -0700 (PDT)
Date: Wed, 11 Jun 2025 09:01:51 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250611160206.552030-1-irogers@google.com>
Subject: [PATCH v2 00/15] New perf ilist app
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

Some thoughts on the series:

 - The PMU changes will conflict with the addition of the DRM PMU:
   https://lore.kernel.org/lkml/20250403202439.57791-1-irogers@google.com/
   when these two are merged together ilist will show yet more
   counters. It'd be nice if the DRM stuff could land and then I can
   rebase these patches.

 - The parse-events clean up of the software and tracepoint PMU. The
   software PMU hard coding to be legacy first has similar issues and
   will conflict with the clean up in:
   https://lore.kernel.org/lkml/20250416045117.876775-1-irogers@google.com/
   Moving the software work to json means we don't need special parse
   events terms for software events, etc. We can just treat things
   like regular PMUs with json, etc. I'd much rather we had less
   special case logic so that series is best rebased on top of this
   work and it should drop the changes for software terms, etc. which
   this series removes. Maybe one day the whole event parsing can be
   much more regular in how PMUs are treated but there's always
   "cycles".

 - Should python libraries have feature tests? How does this get
   packaged outside the kernel tree? I think these are open
   questions. Clearly textual is kind of a big dependency and we've
   largely been moving in the direction of fewer dependencies
   recently. Hopefully the app makes it clear why I think this one is
   worth carrying. We carry libslang as a dependency and I think
   textual clearly far surpasses it.

 - How to launch? Currently I run tools/perf/python/ilist.py but it
   would be much nicer if we could do `perf ilist` much as we do for
   perf-archive.sh. There are probably other scripts that should be
   perf commands like flamegraph and gecko. It'd be nice to follow up
   the series with something to make using these commands easy.

[1] https://textual.textualize.io/

v2: In the jevents event description duplication, some minor changes
    accidentally missed from v1 meaning that in v1 the descriptions
    were still duplicated. Expand the cover letter with some thoughts
    on the series.

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
 tools/perf/util/pmu.c                         |  44 ++-
 tools/perf/util/print-events.c                |  95 -------
 tools/perf/util/print-events.h                |   1 -
 tools/perf/util/python.c                      | 248 +++++++++++++++-
 tools/perf/util/tp_pmu.c                      | 209 ++++++++++++++
 tools/perf/util/tp_pmu.h                      |  19 ++
 18 files changed, 1144 insertions(+), 452 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/common/common/software.json
 create mode 100755 tools/perf/python/ilist.py
 create mode 100644 tools/perf/util/tp_pmu.c
 create mode 100644 tools/perf/util/tp_pmu.h

-- 
2.50.0.rc0.642.g800a2b2222-goog

