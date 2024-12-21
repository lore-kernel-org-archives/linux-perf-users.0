Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FDD17BB24
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Dec 2024 19:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734809221; cv=none; b=KA8DWzslgLPYykt24NHK4zSoUy3hRtvjAHU3hAVlqFnzwRYcj6kp/koNJpd/6sT8a2thxB/zddiDYzeWAFXadZmuVpQyL7bBRwcDOD4kOXnAkqfJave7gyD2Fqn13GP0Scs+V1vgKidk+4RcadLbcXePRoQT3rE/pyoFzQo0IxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734809221; c=relaxed/simple;
	bh=CYhbP77Y+itdUk9EZRAHbUqOOAzcfzJ5Z6fc96Q2VVY=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=ofzamEhf4mrLjEnRnvp+z7kbIpBZgVfRO1vbls3n+qsTp7wr/wAodSs0eExetS5KZ4rmjcz1S5gLDIPI2HDUf0zojaxo61IuALsMSImzKcUJaD9YL58V81vO4YD6av0ENXMbu42n4dHYzCp6z63BTnHgzrHPr2smMi617WK+MIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=duvjJAKM; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="duvjJAKM"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6f003073a95so24214377b3.3
        for <linux-perf-users@vger.kernel.org>; Sat, 21 Dec 2024 11:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734809218; x=1735414018; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=khbaf3YPAMV9CfglLchWYjPoJjw6OVX8mcR2dtFxUQs=;
        b=duvjJAKMAkFPP1NGKT7xZBCbLR866WvazlZE6pwjDxP06WiaLVCI/YUUEo2BMiqzJg
         AiFDjvNpE/6v7EOthlyIHhDb3B0BbYx2HUHX+tFJ0nwmqvCAXZ7fWoxjWuXnKOdsTXkb
         MgwDor7YLBhdZ6DFPiRuWbieLNM6W/HMtd47AxL7qvbMJJoR+Rz61sUNBgoNoSoFAoGr
         WKg9PMCdoSPO3mJ0AXQBG9MbfljBcAx7M+x9ic1ZHkOOGfnaNB8bWRxqTJ9xa9GiKST2
         hq9J2P6nAoNh3OELqMt1KW3UGwEe51KBEZQ1QBtnKF9gdofvXa9E538lTgVlTOb4B/7o
         k8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734809218; x=1735414018;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=khbaf3YPAMV9CfglLchWYjPoJjw6OVX8mcR2dtFxUQs=;
        b=WZk9wx3EnXpzam/bksYcfuAuG/8RuGfk5dXc+L2ML+27lRvtGF7q20kbm7uvWXsL8p
         WxYjATkrjzRQpK2ZKWeALdi090f0B9ZzZhMXA33R5OTU9/KpqjkpeD8veAIvd/yPFPQe
         c4wsvNP/mYv9h+UTKgegBthj6hZl3dRK7Rq50UyomnzrwfkTFq8w38M3ooSaWWHc1Sj6
         1vaDumWdL6aBRkLj9q2RP3PSHjMuF0HMMhuvgMTGHoCEwAAf8ds1R4FR83Qdr1PLcpzg
         87ui5uivA9E1Ssv4qh+rvLu/Xv0YJFNYhzfgSnFm3SnFzkzrfcfcxd9Io87VevkmyE79
         YrkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSv5gZEX+w6crSToAxsqaFfRCsnjmvgwQPGkE9zcur/SstoHIh811S2mwQSl8ss6fNClZcBMmFi1z1k8cUhFFc@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8AskKsYEZCyiSm6pTsDo4/lXRXFDWM5+d+9EyZE7lvK8ebkmg
	yeQ/fMFL2Z+1k82IYkvQmwrodrPLwlfDSqV1jOKY5PlPeve7+WtJdLVe6iwU7loKSid6NAVIxT0
	e7+wXdg==
X-Google-Smtp-Source: AGHT+IEUPVSq8lBgYTPQFcTqPnjauWVaFibsYrI1AVzY9v9JhHQtrgLP0tfvy5Nuebxp1GkuuHWp20EUvSdz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a2bc:ec03:1143:41ab])
 (user=irogers job=sendgmr) by 2002:a05:690c:2502:b0:6ef:7372:10f8 with SMTP
 id 00721157ae682-6f3f822b63emr238087b3.5.1734809218491; Sat, 21 Dec 2024
 11:26:58 -0800 (PST)
Date: Sat, 21 Dec 2024 11:26:50 -0800
Message-Id: <20241221192654.94344-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v3 0/4] Prefer sysfs/JSON events also when no PMU is provided
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

 tools/perf/builtin-record.c    | 34 ++++++++++++---
 tools/perf/util/evsel.c        | 10 +++++
 tools/perf/util/evsel.h        |  1 +
 tools/perf/util/parse-events.c | 26 +++++++++---
 tools/perf/util/parse-events.l | 76 +++++++++++++++++-----------------
 tools/perf/util/parse-events.y | 60 ++++++++++++++++++---------
 tools/perf/util/pmus.c         | 20 +++++++--
 tools/perf/util/stat-shadow.c  |  3 +-
 8 files changed, 156 insertions(+), 74 deletions(-)

-- 
2.47.1.613.gc27f4b7a9f-goog

