Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE492AD00
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Jun 2025 05:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750050928; cv=none; b=jn3lpaNMAV/OzSq09XruwDqMKEDyy5lLmEBSrOfPxVINicRaFbL/bcm3FzUOx66DYSOzqMwvUGQXP2mDOUDhPtbrSsQkE+sPF7jjQBEGfr+y+s5ebSsdE/JcPBzkJdM5CkICKRGKGi74ETRou0yLsDwLQoO/uv3EgKUVo+iL+8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750050928; c=relaxed/simple;
	bh=sM00XjHMFbq/ecTSs00LP5tVfdCmiGEqc4YU3xkdTtk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=AvNgDXx0MaRiwEDVIuFsBdemuzVMiil3MLCq4q2rvAE7FRJ2Xei2quPEvGzlzLBGS2lo0yskgWwm+mSj7oGPfRvg5iOKR2g1aopdVu7AKrA/BtN1/Wa331SwBflRAm7M6nXTSkZDAD3Xhw75kTRfx80eB7Ka/cLK7WocJQcpi7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uq76THyu; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uq76THyu"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3121cffd7e8so3386305a91.0
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Jun 2025 22:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750050926; x=1750655726; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ivPTZpmxX2ElfI/cSlheshsBgnhAB/W8LTyvJx8IZQE=;
        b=Uq76THyuTT4hSgndQ00rNLbEN6iHcS0XBVGn+vHRh6hs75L4UiPLu26E5AKLBFphaZ
         wAE6OMDfMW91RJ3hBnHCoI613yo7DM5TXrIidCnUuisFg8XyzO2/YZWD90CcGxYiY4Nq
         Lk0JBHJkZ4mqYhaF5yrm822jdEVWgi7SeUTnYxKV4+X2IyT6e6fwa/b2kDsNmLiTX5+N
         IJtiBpflJbMSZw28Y0nKcAIy0PJDTESu4f6bfA5NQ1DVgapBhnDH9igR/Ny/iMJLHcvx
         gE79u6OQWPB6in+WPzvftOfAZjffyzYbVfs/0uoyR0378yzsmigyH+3eiqYTlqzUPunO
         ZvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750050926; x=1750655726;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ivPTZpmxX2ElfI/cSlheshsBgnhAB/W8LTyvJx8IZQE=;
        b=ujXmrSoSGVrmaGF7dMGVKy0SDEMflJO1wdDhqqo7vtOsJhP66giBedOuWNH0O69AxH
         xcHQ0Au6UDZBxywABLF/0e3wY6i5TX+YkP8TGx6kFblOWTdPWX2DmYTUOPniApRabobY
         J1sCO0pVk0oeiOhSjQWT5r8cBnoi9Odc5mGBeOqlB86Hn5DdI1124VfL5sed0OwQPdFP
         /xjnDamc43YoI+LCgPNBRGPnwKcVFjziHB0gabytdh+ajzmmCq3NSBrWETIe9WNXyPOn
         Ex4eu7qEuKL37h/kHrJbFikQGTrB1RaIp+pCF6KNCWbeyYYcAbgit+1hRVY9RvWXWVRo
         Dxhw==
X-Forwarded-Encrypted: i=1; AJvYcCVHyreQzi+K5VS6zIkLHItx7G+n7ByD9KE5jcR7Ijinv2b/HvfK2vC32Jn9nfiY0GS/8zRX3nVQFxzTU05b1is9@vger.kernel.org
X-Gm-Message-State: AOJu0YxkgAj5QsxfjYS5SE1g+K8UZldjYpSzi2C4wbu3HQ0N/LltDr7a
	U5SiSdXWvFgnYVpWN4Ka+a7A7xY2BCzI9phNUTQsghv9PjxXLpNWIEqiIAC5p0AEPzrLqJfKPSB
	w2BW91Evu4w==
X-Google-Smtp-Source: AGHT+IG7viZ1D+PslmII9o7bbht4gRgXyMwb7kHK+9d2oEyWX4s7C+PRLWmaIiV8o8tlZiPYvogcwXDbsZSF
X-Received: from pjbsp12.prod.google.com ([2002:a17:90b:52cc:b0:311:7bc3:2a8d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:f944:b0:311:e305:4e97
 with SMTP id 98e67ed59e1d1-313f1cb1ae5mr10850455a91.19.1750050926194; Sun, 15
 Jun 2025 22:15:26 -0700 (PDT)
Date: Sun, 15 Jun 2025 22:14:45 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc2.696.g1fc2a0284f-goog
Message-ID: <20250616051500.1047173-1-irogers@google.com>
Subject: [PATCH v3 00/15] New perf ilist app
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

 - Additional thoughts were captured on the mailing list:
   https://lore.kernel.org/lkml/CAP-5=fWC+doaVd5rEMWJXSQi_db_Wu2tyAe5Lm6jnQjcwXkF+w@mail.gmail.com/
 
[1] https://textual.textualize.io/

v3: Add a search dialog to the ilist app with 'n'ext and 'p'revious
    keys. No changes in the ground work first 14 patches.

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

 tools/perf/builtin-list.c                     |  47 ++-
 .../arch/common/common/software.json          |  92 +++++
 tools/perf/pmu-events/empty-pmu-events.c      | 266 ++++++++-----
 tools/perf/pmu-events/jevents.py              |  18 +-
 tools/perf/python/ilist.py                    | 376 ++++++++++++++++++
 tools/perf/util/Build                         |   1 +
 tools/perf/util/evsel.c                       |  21 +-
 tools/perf/util/hwmon_pmu.c                   |   2 +-
 tools/perf/util/parse-events.c                | 225 ++++-------
 tools/perf/util/parse-events.h                |   3 +-
 tools/perf/util/parse-events.l                |  38 +-
 tools/perf/util/parse-events.y                |  29 +-
 tools/perf/util/pmu.c                         |  44 +-
 tools/perf/util/print-events.c                |  95 -----
 tools/perf/util/print-events.h                |   1 -
 tools/perf/util/python.c                      | 248 +++++++++++-
 tools/perf/util/tp_pmu.c                      | 209 ++++++++++
 tools/perf/util/tp_pmu.h                      |  19 +
 18 files changed, 1282 insertions(+), 452 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/common/common/software.json
 create mode 100755 tools/perf/python/ilist.py
 create mode 100644 tools/perf/util/tp_pmu.c
 create mode 100644 tools/perf/util/tp_pmu.h

-- 
2.50.0.rc2.696.g1fc2a0284f-goog

