Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4922B9A9
	for <linux-perf-users@vger.kernel.org>; Sat,  1 Feb 2025 07:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738395806; cv=none; b=WteNL202eF/M7xP2uQhhtjpcIWU4dp8aJoQH7TWKygwxWnDIMi3KsldNCL6aUNmo1apVRue/fvzm79yH1vVz54UlwQAjaZuOIDcQn0jCYoNXlWM/+N/i9gZpun5juFFhcWGYH3EqR7YCOlN8rU9ENTa24Pi4MB5/CTQr6AYZt6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738395806; c=relaxed/simple;
	bh=9k2M4+erGEhCQ+ZNEbepukp9n10RgfHeWLxV4CelytA=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=RIIAUovFX3umcSnSiq/5R4bNKFsmbBtLcmYWLb4VJ0qNyXihMEh/EDv5LtJBbP2YcInbeDezPL0uyFv4N8XMIidz6iAZSt9TazHPMfmB2GkEah2GV90S64EXpkUOhw8hCnHNcr7Ah1mUHcSORKQpI13PkjmFAW0Zkl2g88zJ8E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q+9UqwA4; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q+9UqwA4"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6f2bc451902so31468957b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 31 Jan 2025 23:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738395804; x=1739000604; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O3+/E+TgZZGMv/gtL7KYzyxWyAV4KsI6xSgcExMsoWQ=;
        b=q+9UqwA4YgkvjBNgW+kwbxXD8LS+gNset3+/Vj0HTPNEl0ynbKpcEAI2Rh1vThbBYb
         vqMuDxnAlBRZiTzUHY2OdC4yNvyiIkr9WJuBLdXbNcqMK0lrbrLDKN7OUjYTakbeDppN
         oFkkW1qknQzZQK+SsCcGc7aeMS6T9Sbpqgm4L+yWUtQ2z5MgrFaT4bmuY1yVGuUnuVww
         724CXWMt+5fODcb+EKO0svF887jwvmk3WzuhPEl26xHGswuDdCmG8zreZZrFXQGSxESV
         3yU6SDeAAlzmUpU1AFka0/GiI00QEbcPG8bb4yqd0N/XUv2V7/f6Hp+xfZDuPTDahrxa
         DEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738395804; x=1739000604;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O3+/E+TgZZGMv/gtL7KYzyxWyAV4KsI6xSgcExMsoWQ=;
        b=wLK+r3NskxZTj8JnbTP6ssbwByU+q+NiEoV8zdUBY1rpZxE43Bl+gD1Zxpxhri57jg
         B+ef/yWhdvtePCz4Z3sYXAXUDWNOiVIqsXzYAdjciYjdxap4k/5cH+WJwB/oICtwBofe
         HLtS07z1ZA0F1mwIVgsTpVRvYS6WZpQqiZpe7W1hdpjky6oX+P4H/IBPCRZrr032bcZC
         iEsVlv3kLavaBNMxUbWTkKAYSsRMsBoEaBwDzHZSTvEOCKlvecyY32A7ZbLpz9pEbn2S
         zMNEhkNArtpPNEprdV6Ggrq0YGYF9eGLRDkp1CUp3jkh218PQXXUdMudKF2burRv4w42
         3DeA==
X-Forwarded-Encrypted: i=1; AJvYcCX/msH7sK8gPodZ+LU/GhyfRAYSzkYDUEmlJu88afGdCIJ90WUPOyjSMOxAz/lfI8swNs+cM4b37vRUzk4PsaXq@vger.kernel.org
X-Gm-Message-State: AOJu0YwbMrSBlbu7d5zbo3BGltqwkQ6+wwBC55le8GcxtfQn5CpM/e2X
	pSqw45lVVJpo3kjHlQmoTRjSNSh9Hg2brMZa04PQl/8dU+v3W7S+MxF8tmLUBvj27xGlS8p/r0E
	H7I2HiA==
X-Google-Smtp-Source: AGHT+IGA4ATIsK1jhK9IHYmMcUSHwoEb9uRlp8EU9tSYg7SiOsaqSVffyzPoCZ1/CdDctJsmRSLKh5KhSJCu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:de26:87db:e4d0:62b6])
 (user=irogers job=sendgmr) by 2002:a05:6902:1741:b0:e57:f577:5564 with SMTP
 id 3f1490d57ef6-e58a4bfd0dbmr32246276.8.1738395803837; Fri, 31 Jan 2025
 23:43:23 -0800 (PST)
Date: Fri, 31 Jan 2025 23:43:15 -0800
Message-Id: <20250201074320.746259-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Subject: [PATCH v3 0/5] perf hwmon related improvements
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Try to do less scanning of files/directories with or without hwmon
PMUs. Don't merge all events with the same name, only merge those on
the same PMU ignoring suffix. Tidy PMU name matching to distinguish no
suffix or wildcard matching. Refactor uniquification so the evsels
with the same name as other evsels in the evlist are uniquified.

v3: Address potential segv and styling nits from Kan Liang.
v2: Rename ignore suffix PMU name matching that is really a
    wildcard/prefix match. Use a proper ignore suffix when not merging
    counters purely on name.

Ian Rogers (5):
  perf evsel: Reduce scanning core PMUs in is_hybrid
  perf pmus: Restructure pmu_read_sysfs to scan fewer PMUs
  perf pmu: Rename name matching for no suffix or wildcard variants
  perf stat: Don't merge counters purely on name
  perf stat: Changes to event name uniquification

 tools/perf/pmu-events/empty-pmu-events.c |   8 +-
 tools/perf/pmu-events/jevents.py         |   8 +-
 tools/perf/tests/pmu.c                   |  85 ++++----
 tools/perf/util/evsel.c                  |   4 +-
 tools/perf/util/evsel.h                  |   1 +
 tools/perf/util/parse-events.c           |   2 +-
 tools/perf/util/pmu.c                    | 256 ++++++++++++++++-------
 tools/perf/util/pmu.h                    |   7 +-
 tools/perf/util/pmus.c                   | 146 ++++++++-----
 tools/perf/util/stat-display.c           | 111 +++++++---
 tools/perf/util/stat.c                   |  13 +-
 11 files changed, 424 insertions(+), 217 deletions(-)

-- 
2.48.1.362.g079036d154-goog

