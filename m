Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F416822092
	for <linux-perf-users@vger.kernel.org>; Wed, 13 Nov 2024 01:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731460807; cv=none; b=G+KMQ3z7nz3I6rsN3aNHHx+oUcdXWTGzefMtopFvU84f2AqzxzjEiiz3s8jKboaVzD7DKca/Ez0HaHmdao78N4ZTXaWldH90iYjlKwebnpQ93yIiB864K+D4XKA2PB/j2eAoTrwTQ+mvVZdhzqGI+iF14/ZntODW4ZQ7nMeW4ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731460807; c=relaxed/simple;
	bh=27n8L5sWSPJhAE2JEG3O/r5G40z8Xit8zaf4tomXVDQ=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=CX//PC92uSZUmq18iZHmqldxDVY24i1LjPdMsbZ7fBWA2+FjSdhi4as0hBWU3RVa+Pe9/+HmsES3w77bX3qpmemNZPZjrcLt17UIQ2ZZVqW05hBhCKO+IsJHaqWCWyD5Ty4amWhMpOTf1lupsVFXnnig98XHsrUZRerohIpGRm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ICOc/ztT; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ICOc/ztT"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6eae6aba72fso78054497b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Nov 2024 17:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731460804; x=1732065604; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NiQczml56JgVVMWTkxc0gHOxNZYXXQnLIMolkM8qQ3I=;
        b=ICOc/ztTNpIrODtKBrAVLrJhfnlZPJTOnmB4d45BOCzasHlmAQCFgl0ZB0/V5JETW7
         xnaA7HFw7lNiRpH65/Yzs8ea5WxuSud5v4Fe7/vJgoTWPLv+wpn2rkLpf9SBQGBQnMuC
         NteHPDbygICN6a9V7raXXmumWso5vlStSsqUd/VHkCqxq66ZAUWIzuo9yRe5zP1M/PLX
         97ORNmZDn9w1uKYL4Go7UUOPXBXyaNChVwhvopGU4Z8adLO0kwS4pBDmc46Rn6yl93jd
         9AVx7O7snLKFTa9L6o6FuR5nkQdKa8Xb/aLtwYwM6qFuLhMs0bG8h8wg6Zr2dECXg4AM
         ASiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731460804; x=1732065604;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NiQczml56JgVVMWTkxc0gHOxNZYXXQnLIMolkM8qQ3I=;
        b=j6iykqusRJq4/VULYN0U3pbyNlIJO/lH6KfC8Vw+Inx+Vx0d74AvCED6DBAevX5hN0
         n5Rm61zkJXzQddkMC5AkZ0kV/AJQJGqZh4JGRMAfjWqvN7cbNcQgcpfGQ77VK0wZXtlP
         BbVJB3YiCR2HHeVMTiO8GboHyMjaYnvnOF3M27sA7xMonkegJJQbvE1bVRPPma+18sKX
         kI+7AUOeui5WaAyDod2/3J6Duu/W6U6wXLpxoVFbETUW6m3fq1jH093893wMPuR3voaN
         AltevCpU2BZD6f6hvDUh0cUbHslBL4jRTzIVFbzG3djw4bFesEr070irReQkBdfcqGvr
         czag==
X-Forwarded-Encrypted: i=1; AJvYcCXRMqhUPrGT7VJWsg8Wm8RVH9mZrYoI6J34KNeHVnr8R0v0tbyKP3e7v6bd4d2XllfUp2k5hyxRV8wFM0oxnYP+@vger.kernel.org
X-Gm-Message-State: AOJu0YzNBg6Xra/hfWnJtWJpTdUx1MiFL0Uzo0QpImB9saaCIvZr3Mfr
	IO4gzsjd2q4nRKOliXNi6OL6RWWgGYsHvt/VwkpOKa4pTzlqu+zXsrk2Y1VzBCJIb/l6tU+M6ig
	TvEMCnQ==
X-Google-Smtp-Source: AGHT+IEGILWef6FrLG2dff4ry+9/9vbZOuphjIijHW0mVc/gaalZy4aAfkn001gZ2CIKsGYePE+4YgGAkh/G
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ba3:1d9a:12e0:c4af])
 (user=irogers job=sendgmr) by 2002:a05:690c:3688:b0:6ea:fa4:a365 with SMTP id
 00721157ae682-6eaddfec9efmr1467337b3.8.1731460803953; Tue, 12 Nov 2024
 17:20:03 -0800 (PST)
Date: Tue, 12 Nov 2024 17:19:52 -0800
Message-Id: <20241113011956.402096-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v2 0/4] Prefer sysfs/JSON events also when no PMU is provided
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
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

v2: Rebase and add tested-by tags from James Clark, Leo Yan and Atish
    Patra who have tested on RISC-V and ARM CPUs, including the
    problem case from before.

Ian Rogers (4):
  perf evsel: Add pmu_name helper
  perf stat: Fix find_stat for mixed legacy/non-legacy events
  perf record: Skip don't fail for events that don't open
  perf parse-events: Reapply "Prefer sysfs/JSON hardware events over
    legacy"

 tools/perf/builtin-record.c    | 22 +++++++---
 tools/perf/util/evsel.c        | 10 +++++
 tools/perf/util/evsel.h        |  1 +
 tools/perf/util/parse-events.c | 26 +++++++++---
 tools/perf/util/parse-events.l | 76 +++++++++++++++++-----------------
 tools/perf/util/parse-events.y | 60 ++++++++++++++++++---------
 tools/perf/util/pmus.c         | 20 +++++++--
 tools/perf/util/stat-shadow.c  |  3 +-
 8 files changed, 145 insertions(+), 73 deletions(-)

-- 
2.47.0.277.g8800431eea-goog

