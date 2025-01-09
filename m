Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D926C1991A1
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 22:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736461284; cv=none; b=rbDBCweqWs+3FFyugZ1TsdtdrR1m/wW6+cevAQfwqfFE/5HfZXL6MoHhTZqYk8OGfkOwXPLPKzA949BWfwWoFYFgBg0WPei/MDxSwPrkGnK8bH7qypNnWlZzbXMJ2dIapts+PbTEP0eDOmDlQ80rKfYexraH5eNTSME0kJ2yjKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736461284; c=relaxed/simple;
	bh=mvA1+Ex46Afr5EU7kgIAy/4+P4BO/+x8UtIHJZIgc8w=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=mZ+7yLCZw0xfFn+CsuJqUV0IV3nyT83kK4c1Mjj/fCAuXF8aToVSGRLEAx7fwOwe+nFI2zVs/Cuvi+kyJesl32kI0u3Ivkg7UbQ+1KtEbQMpQLv5ZfQfSjxsl23xFP6YZr+Hq4KLd4QZPA+jecmJRoBh7VfMeu4jRdRHBZMlOQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PKUDEwnC; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PKUDEwnC"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e39fd56398cso3361008276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jan 2025 14:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736461282; x=1737066082; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=APc5U5ywEy/Tuysn23d9TyrNsPrZRpQl20ea4//4lhA=;
        b=PKUDEwnCQ6WmUvzdwqzNathBrMLw2PIZG9dHzhztTjU/atKJ87ONiEU+ZifF9h+Lmm
         fgzgPGyj5qrefHy9M/cHRdrQJqetASuZPDnXo7mdhRZ92tlhldDxHH2eGs1WqZQwjukN
         jthQs9XdfojDq8SaTFGkb3aOfJEd8begy/XLtahPI9/loYhvP1gkRZevYS3qaXDafeLB
         2ggRlEM6nX1/oOWITOiVc1kP8bEHYN6pXn+1AHvppK6QX8e104lpI/DwfGBeLEviO5I4
         bJtvWSw/mMcVQN+9QUOJvleHK0oxlnLxWBla0tDOQsySI/bXM8Fhfa7gINXR/4FAV1op
         yvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736461282; x=1737066082;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=APc5U5ywEy/Tuysn23d9TyrNsPrZRpQl20ea4//4lhA=;
        b=dn9p/454k8EpT73TEQYfKQWPOkX6OnyDDPpXs7yf50y6bAZyqfQLafPTdqpnbWPEZM
         ZL6OQk2VSe/GguwexCanjTDFrWSnPDJJxD1C3hRy1L0H8W4zLJdDHZkxmg1X3VQ3xrki
         attXORydp68kG+50oMp2YjhN2HcCbcmSKD2kU72rzYgfZHmMSKbjG8yWpWK0Ke+6lX/Z
         4iIVRltkYnXI5WmM/n0vsU71eHsgjym4cBVFnpi1rO1OlwBFk9bu+DJWCliucGrEvbXg
         Ofntv6WqhbnBVVSQNQm7iCgPb8RN0eES7pKhhBVtkxVbcgngbi555ilsFwjFFB4E7IKY
         CkOw==
X-Forwarded-Encrypted: i=1; AJvYcCWpHA4hSwom1uYBnJnuhaYKk01XLDWxPa2G80OE9dpuE2DWPcYEncFvbUp0gdej8RpckX5DwUe7Db4RVhFDmFI4@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+5LdCgNjanMwYW6kcrCoWXEaQ5mZPUwlcA2mH9TnNrdMOkx+5
	Cgy4thFtLus/yCQzXEnnG44M+WpeTav6F2s4JKHfzxJ4jVWg7bvdZ5hUbAU3SsXgqKuAqINzt1b
	dUPqvvw==
X-Google-Smtp-Source: AGHT+IEe6F5Ce5TfBJPxh7qc3R18Dao084HnkopZCGY7i0JfAo+p/O6PdN/YqnnDQI3QcM7irH/ROTvAtqBj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7ea3:d1e5:495a:9a4f])
 (user=irogers job=sendgmr) by 2002:a25:ae67:0:b0:e39:6e00:7177 with SMTP id
 3f1490d57ef6-e54ee165a9cmr17649276.4.1736461281772; Thu, 09 Jan 2025 14:21:21
 -0800 (PST)
Date: Thu,  9 Jan 2025 14:21:05 -0800
Message-Id: <20250109222109.567031-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v5 0/4] Prefer sysfs/JSON events also when no PMU is provided
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>
Content-Type: text/plain; charset="UTF-8"

At the RISC-V summit the topic of avoiding event data being in the
RISC-V PMU kernel driver came up. There is a preference for sysfs/JSON
events being the priority when no PMU is provided so that legacy
events maybe supported via json. Originally Mark Rutland also
expressed at LPC 2023 that doing this would resolve bugs on ARM Apple
M? processors, but James Clark more recently tested this and believes
the driver issues there may not have existed or have been resolved. In
any case, it is inconsistent that with a PMU event names avoid legacy
encodings, but when wildcarding PMUs (ie without a PMU with the event
name) the legacy encodings have priority.

The patch doing this work was reverted in a v6.10 release candidate
as, even though the patch was posted for weeks and had been on
linux-next for weeks without issue, Linus was in the habit of using
explicit legacy events with unsupported precision options on his
Neoverse-N1. This machine has SLC PMU events for bus and CPU cycles
where ARM decided to call the events bus_cycles and cycles, the latter
being also a legacy event name. ARM haven't renamed the cycles event
to a more consistent cpu_cycles and avoided the problem. With these
changes the problematic event will now be skipped, a large warning
produced, and perf record will continue for the other PMU events. This
solution was proposed by Arnaldo.

Two minor changes have been added to help with the error message and
to work around issues occurring with "perf stat metrics (shadow stat)
test".

The patches have only been tested on my x86 non-hybrid laptop.

v5: Follow Namhyung's suggestion and ignore the case where command
    line dummy events fail to open alongside other events that all
    fail to open. Note, the Tested-by tags are left on the series as
    v4 and v5 were changing an error case that doesn't occur in
    testing but was manually tested by myself.

v4: Rework the no events opening change from v3 to make it handle
    multiple dummy events. Sadly an evlist isn't empty if it just
    contains dummy events as the dummy event may be used with "perf
    record -e dummy .." as a way to determine whether permission
    issues exist. Other software events like cpu-clock would suffice
    for this, but the using dummy genie has left the bottle.

    Another problem is that we appear to have an excessive number of
    dummy events added, for example, we can likely avoid a dummy event
    and add sideband data to the original event. For auxtrace more
    dummy events may be opened too. Anyway, this has led to the
    approach taken in patch 3 where the number of dummy parsed events
    is computed. If the number of removed/failing-to-open non-dummy
    events matches the number of non-dummy events then we want to
    fail, but only if there are no parsed dummy events or if there was
    one then it must have opened. The math here is hard to read, but
    passes my manual testing.

v3: Make no events opening for perf record a failure as suggested by
    James Clark and Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>. Also,
    rebase.

v2: Rebase and add tested-by tags from James Clark, Leo Yan and Atish
    Patra who have tested on RISC-V and ARM CPUs, including the
    problem case from before.

Ian Rogers (4):
  perf evsel: Add pmu_name helper
  perf stat: Fix find_stat for mixed legacy/non-legacy events
  perf record: Skip don't fail for events that don't open
  perf parse-events: Reapply "Prefer sysfs/JSON hardware events over
    legacy"

 tools/perf/builtin-record.c    | 47 ++++++++++++++++++---
 tools/perf/util/evsel.c        | 10 +++++
 tools/perf/util/evsel.h        |  1 +
 tools/perf/util/parse-events.c | 26 +++++++++---
 tools/perf/util/parse-events.l | 76 +++++++++++++++++-----------------
 tools/perf/util/parse-events.y | 60 ++++++++++++++++++---------
 tools/perf/util/pmus.c         | 20 +++++++--
 tools/perf/util/stat-shadow.c  |  3 +-
 8 files changed, 169 insertions(+), 74 deletions(-)

-- 
2.47.1.613.gc27f4b7a9f-goog

