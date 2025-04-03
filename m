Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEC3258CD1
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Apr 2025 19:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743709434; cv=none; b=pfLSf6fWT8sulajkjtBqHx/c3uuvi19AEnpCzRUMzgnOs3lXT4fYl4MJuxuF/OtvKF1HpfzMygGFRlyUL22FZjg4p6UHkieDUF++wrx7Xs3I6P5sth61K75eUoBUp8GhQOgk0iw7lKYp1ZAo6BUN9VadHWHsu+TXNShcOAHrv5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743709434; c=relaxed/simple;
	bh=cXfW9/0OU/0PyisdzgfnQJhAlEI2L+o6BnIDpCQT0l4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=L0TJYnwxCo5pQ1CFah98jLTs/1L2hsWi3PpxR49VaSaso+tBB35iHKWJEDMo7X1pFaam6zXAxsy+sSelaP22Mu9cByLjviUeB8wtCcmzIzkrYetD09+Il9jUWTNX0OL3B3oMR4xGdo/yA8FklVHZG96D1CETXcuLR/pkU3Zb4YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zmCAMTRT; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zmCAMTRT"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff4b130bb2so1370435a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 03 Apr 2025 12:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743709432; x=1744314232; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GGndkCIwJ2dCB4/lFmxP5CCCR2wtm75SoTbBfRh2ZiI=;
        b=zmCAMTRTYhXYwb8+UJDJPCF1V7yqhoGu+kuFlyqexghArIooVFZ+GXNwcm0Bt4m7YU
         8qIu1DQ+qOQABRG241YzMW3FWKm9EAQ7JE1BOPdQ3ff8xfi1a4I2FYVNdXGjIc9wNktH
         kO+eNvplpDO/Zjx6T+ofGXllDDzc6HwIutNoQsrEOwozIQIcA59+CfCqZrkD63/eaw3w
         j9ArV91igFp60dhpwifzS+D51C2QkaowIbm5UZwffLfgOHrk+hiEkz4BEO1WN8RrPFl0
         VH4AtBqMDGtiF5rPDe/i1pKzsJEqvTdkm2zR974d+WOP73rmORQETPehpdctrP+KevK7
         hO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743709432; x=1744314232;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GGndkCIwJ2dCB4/lFmxP5CCCR2wtm75SoTbBfRh2ZiI=;
        b=dhDXEWfJM4FH2V3ORlBQniU2DaMyD0OVb5VymUaeIBoNXfFAG2k8BwLzIl9rnguwjM
         JoR8H3aIErYBKb6hclkbHRs6weyjFY3kzjseCHbMJr0aWxzFM7M2mxOIkHfnDOG5ayvJ
         aJ74znbWNlDd7zsSZW3WF6mhEIBAI1DJgP1QnL6ZIF5omBpMpoYsgVX26HiwJ57oYifc
         noCy68uVIYkBy8HlJPdTv/78Ytee35OPkmCzVGJbOC/iTK0/WdCpofotKHgctRtUPVfq
         cFvpkwk1jJCPtvu/OTMzMfCiWL/BCtaEvAVVKKxUJiFWCPUUSSq4/OGqw44oXAngrwM9
         BNOA==
X-Forwarded-Encrypted: i=1; AJvYcCXB09/la+JHAN22BpgIM5PrBo0h2MvIbiQQePzruYjdy7i8XhIHGu24OhULnVTRyF9xiFmbpzO3ox4G5W9fwNZE@vger.kernel.org
X-Gm-Message-State: AOJu0YxyRZlH9CGrKwC1NqlIqis4c9pkfTr+ktSbdFaLiw5+dnrVaYom
	4BFdXXGbX37+hObKf94MuGgr5ipVFArQ5NXa89l9PZTG38dRtfC2qqMm+7P8YevGV8vOdczTKD3
	lcYvABg==
X-Google-Smtp-Source: AGHT+IFH4as/fB2qgVLc9DQ6sPVatN3cGYX3oKMIJhzOKyN6ezZpbj4HIpwyKWj7moSp/97yD0UvclVI8GMt
X-Received: from pjboh16.prod.google.com ([2002:a17:90b:3a50:b0:2fc:2f33:e07d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5150:b0:2ff:7b15:813b
 with SMTP id 98e67ed59e1d1-306a615bd8emr5318a91.17.1743709432129; Thu, 03 Apr
 2025 12:43:52 -0700 (PDT)
Date: Thu,  3 Apr 2025 12:43:33 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250403194337.40202-1-irogers@google.com>
Subject: [PATCH v6 0/4] Add support for cpu event term
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>, 
	James Clark <james.clark@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
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

v6: Purely a rebase.
v5: Purely a rebase.
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
 tools/perf/util/evsel_config.h         |   1 +
 tools/perf/util/parse-events.c         | 113 ++++++++++++++++++-------
 tools/perf/util/parse-events.h         |   3 +-
 tools/perf/util/parse-events.l         |   1 +
 tools/perf/util/pmu.c                  |   3 +-
 tools/perf/util/stat-display.c         |  21 +++--
 9 files changed, 124 insertions(+), 39 deletions(-)

-- 
2.49.0.504.g3bcea36a83-goog

