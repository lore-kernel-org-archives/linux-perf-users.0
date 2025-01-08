Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD32199FAB
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jan 2025 05:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736314486; cv=none; b=JyO/YGktMI0kx37nAl3j3ScJ3Jd3uEHAkkLEUctvLP35wS9KnJwzTykzPklDBSUia0CceHu1FI3WYRKR/Iehn8UrX3eX3T//70IMoB7Ac94+l1R3+1hrQ9Isg7qRWEgW4nFphDm9dBY+vzcDpl67kLkRyF6B5dUUjwyBmsVqkPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736314486; c=relaxed/simple;
	bh=fRubG9Uj4EADvG1b2dx/UDBozfw94Y76+55qgWq6LR0=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=ZPHlKDUF2lcsFe2CCITTjbGQY6RIrRA1CRy3FopgTs0aTKvUY4SEBztlInlOO7nHnWmicuVCZj1DVObw0hDlvf1c0b6oO21WZwpdYuv59YncYcbn0P91GFuLkzINqGEQD1+6Ck1tSp4NvUSZCdXsGBSPOCqbE+Ejot1v5CpAwsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v/im+8L1; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v/im+8L1"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e54cb50c3baso1504173276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Jan 2025 21:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736314483; x=1736919283; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YM9oLCD+JjMjR6emO8lQG0gPNIoZMKCy7YDX6xwdFOQ=;
        b=v/im+8L1OAbgIqV6KJlW+Y0aS+rZxkA6MkpYrE9P1ME5FDaYcCoLH24CuTCUormfTs
         7B4vh1YtTzGY/G9Z5T+Vl5OlBQl4pwT73zKZwc7PTBNf/PTxyiOZZYjHfjHAHKR2zXQu
         VsZaPTCIeRgrn2rgR1taImrtSwKy6+EvBSrGWoPaLBLkSe9isAi3ZH0184Xqza0PzlWE
         1BUSzjfyxMVbbq1UDx7azmOqnljrN1h7IbORN6+n5PKUpQ/ALFidzleSh0nyB0azbr4R
         Kolt9FMz3mYOc8GfLPuxM1zAofiDqNwT3MacNh31dl7NODoGom8B4rRyCh++xO1QzGoj
         56Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736314483; x=1736919283;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YM9oLCD+JjMjR6emO8lQG0gPNIoZMKCy7YDX6xwdFOQ=;
        b=A24qfjhvDxoJV0nD+bgu59YYjguZiu20eNemTZ4s9NW3kKQ2jqkJyjRVC8qjSnwqz2
         XQJVzT6l51/rsdXac9gTBfdfRRgl4+rdioH1zzwBG9aLmPfT7lSASm0hBbQYsPBaqzHF
         MLKGUqJChSpC4O6W5onFUAbZ/DsPw8BisD4D5OFymIF4JuAdiQw/l11QJth+vn6A3kNu
         j+lclI8H9SzTduU8E2PPAkoXE17V9E+WAJotASSEYizvBBdGOPGjK2fT9t/tgFVJrTPG
         HXvWCn8Ii8if9GuDMbRL11P2LuUDn1RKPQ7WR+3M3YYj0fXSklFbDNY8YLIv+55C8kPs
         k+QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbGWRQbUhjAeQ9Aob/wo38dqaVvXxEedejqIDwavtZlmomQyoikrqb5BALYmyn//0MG5CJw31K3+c3s5PvOQl7@vger.kernel.org
X-Gm-Message-State: AOJu0YyrM/gLhM5gucaL67se50hDXlFDxOZdeGilSwCrmYfxX1+Xt5nJ
	zVgVyyDDpFciKuUWNtEGoURkOJKu0qcWne8hfsr9srdIeKR7FfzXdIuB2NCeK1iW0P0k0SzAsYT
	a6Un79A==
X-Google-Smtp-Source: AGHT+IEpUipVvgAO18nA82MZLV4sMXwillP8LlIqxEmOqw3XOk06rFS/TW2kMh46gs9rNzjTn3KBRsrZRpju
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7ae:a887:5504:e3ca])
 (user=irogers job=sendgmr) by 2002:a25:c704:0:b0:e38:225a:c3be with SMTP id
 3f1490d57ef6-e54d254c330mr18371276.5.1736314483570; Tue, 07 Jan 2025 21:34:43
 -0800 (PST)
Date: Tue,  7 Jan 2025 21:34:24 -0800
Message-Id: <20250108053428.1724490-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v4 0/4] Add support for cpu event term
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>, 
	Yoshihiro Furudera <fj5100bi@fujitsu.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yicong Yang <yangyicong@hisilicon.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Being able to set the cpu mask per event was discussed in the context
of a sysfs event.cpus file is discussed here:
https://lore.kernel.org/lkml/CAP-5=fXXuWchzUK0n5KTH8kamr=DQoEni+bUoo8f-4j8Y+eMBg@mail.gmail.com/
Ultimately Kan preferred to have multiple PMUs with a cpumask each
rather than an event.cpus file per event. It is still useful to have
the cpu event term and so the sysfs part of the original patch series
is dropped.

v4: Add the stat-display output change for zero counters Namhyung
    requested as part of the series:
    https://lore.kernel.org/lkml/Zvx9VbJWtmkcuSBs@google.com/
    This skips zero values for CPUs not in the evsel's cpumask rather
    than the evsel's PMU's cpumask.
v3: Drop sysfs event.cpus file support patch from series.  Reference
    to using cpu to modify uncore events is dropped from the commit
    message. Reference counting issues on the cpumap are addressed.
v2: Add support for multiple cpu terms on an event that are
    merged. For example, an event of "l1d-misses/cpu=4,cpu=5/" will
    now be opened on both CPU 4 and 5 rather than just CPU 4.

Ian Rogers (4):
  libperf cpumap: Add ability to create CPU from a single CPU number
  perf stat: Use counter cpumask to skip zero values
  perf parse-events: Set is_pmu_core for legacy hardware events
  perf parse-events: Add "cpu" term to set the CPU an event is recorded
    on

 tools/lib/perf/cpumap.c                |  10 +++
 tools/lib/perf/include/perf/cpumap.h   |   2 +
 tools/perf/Documentation/perf-list.txt |   9 ++
 tools/perf/tests/event_update.c        |   1 +
 tools/perf/util/evsel_config.h         |   1 +
 tools/perf/util/parse-events.c         | 113 ++++++++++++++++++-------
 tools/perf/util/parse-events.h         |   3 +-
 tools/perf/util/parse-events.l         |   1 +
 tools/perf/util/pmu.c                  |   3 +-
 tools/perf/util/stat-display.c         |  21 +++--
 10 files changed, 125 insertions(+), 39 deletions(-)

-- 
2.47.1.613.gc27f4b7a9f-goog

