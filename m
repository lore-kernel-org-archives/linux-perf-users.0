Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A8C3FFD
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Apr 2025 06:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744178875; cv=none; b=ugrKWzykzD9KqqIvQkr0XVKgKlZP6lfPjoxJzZmfcK4Xe/eeMLuMof1f5IlUxkGIaN8vtzvbtsgICcivsqtIPJzp+U6UCeXQACFGXMhXYD78EOZwKo/harq0CtNeYWkos1jWdBUvhx3ngqWbRkZuRM467oKIJAzUgFT81pqBqag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744178875; c=relaxed/simple;
	bh=VOlrE0q1Dgt0/ufOq2NjQaIoTeL0CeB1PTgY3Vto+Q4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=WDHObxmcVylXG3qwB9bFfxWiqDjQrx8rDnEUFtVXVJ2RMRdp6jF7Rg0l52urd0vPpndgTBRKkHS8ikLpqkfc6tGGBmgYrY90gOBR7y3K7VPDlZbncRCWVP7ZWLv+PLcqCcbWrP6o7Pd2Uhxthb1aNbCqprIHTrv2BO2qTAyMuvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ngfsJBiX; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ngfsJBiX"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-af534e796baso3935952a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Apr 2025 23:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744178873; x=1744783673; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IQysTOtg9Kdj+LrUMGXjnelf/uERWnWmH3sm6GDGrDs=;
        b=ngfsJBiXBIV7wcxP5XM6hFaphmGAKxVaqUm8TT8jtqcFVGrhvQb41w6nlTwHpjS6FR
         wWp8CgU2iE/ydosf7H68IJXEzREJz/D9pETtle1Z+qnV7S780XXG9e7ntQsqROWr8WB/
         4sRO1fWA/LyFGVnuUQGZKpBLzFfCKQcOWBmFebeiwf098rvqzHRyARk7NQzUtY7mXmCX
         k6mRWM9dPH00v5xOwIoAI8fDdm/srrq2m2diRMqVHRWAZ6tLpSbrh6p0luqE+j5P61A4
         Dbki+PTttopX086L20tNeTNEVJSHlDJHb+TIizSJ0SZFs8f6s2voYZmndPDoOQRgE+5r
         vaug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744178873; x=1744783673;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IQysTOtg9Kdj+LrUMGXjnelf/uERWnWmH3sm6GDGrDs=;
        b=Xb73FA73b0d0ugW+n5Sz2ec82VlVvQYuntbMnYOBHki/jE/E9+Wdqj9Oz0tMKvl5Bs
         gdw/EwhR0kLx8ZycXxa22JTL1TwH90jpzS22lXXlVqIcKRKTH02jG49GDd6SWChULckI
         qxnEhfCqH7JaMn1LJJnBO55oUzE5XedrcOUhIyThZiyqY3gujMa79H3zbe6CEFs9hpVv
         rVpg449h3wtZl9GBFSSW/i8kl65eBn3/g5DjxULOx1QkqfRKdoGJ9Xgk7MoeSxaLno8p
         HjXvj1V2XztuxIy2OpHWg2dablpQOqE8REk30w4ub8YOVuwf61VkqU4MwN9F5x+7tLQw
         OFuA==
X-Forwarded-Encrypted: i=1; AJvYcCWvlNBdQaMcKYsW2yHd0BZA6VWrsNDmwYmE199qG4G84/bxCf4fAXf4roxi9ArTBjcrnu2mGeMdO2Lod9bdCYlj@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ75I7TBRu96If45rbzI8+EdcDvT59xDdCWomiBOjtGbqJaSz0
	3Ov6R7TQmlJqHTnbZiWJmHnh3PEWHdZhW1KX5rLmPOnTOl838bSlpkdBSxIAJEDS1bfL80cRBlC
	7GM+8hg==
X-Google-Smtp-Source: AGHT+IGuYfcr/8lN8n8ocPw+qJEdejKNXBFvT6qWMwOzhkrBpUs+ZreTH2w02P2FRgxW3y3tQvY3rhbGG4DT
X-Received: from plbkp4.prod.google.com ([2002:a17:903:2804:b0:220:ca3c:96bc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b2c:b0:223:6657:5003
 with SMTP id d9443c01a7336-22ac2a27c95mr29924845ad.32.1744178873438; Tue, 08
 Apr 2025 23:07:53 -0700 (PDT)
Date: Tue,  8 Apr 2025 23:07:27 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250409060744.698511-1-irogers@google.com>
Subject: [PATCH v4 00/16] Intel TPEBS min/max/mean/last support
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	John Garry <john.g.garry@oracle.com>, Howard Chu <howardchu95@gmail.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The patches add support to computing the min, max, mean or last
retirement latency and then using that value as the basis for metrics.
When values aren't available, support is added to use the retirement
latency as recorded for an event in the perf json.

Support is added for reading the retirement latency from the forked
perf command more than once. To avoid killing the process commands are
sent through the control fd. Some name handling is changed to make it
more robust.

Rather than retirement latency events having issues with perf record,
make it so that the retirement latency modifier enables sample
weights.

v4: Don't use json min/max in retirement latency stats as they will
    never update afterwards. Warn once if json data is used when TPEBS
    recording was requested.

v3: Two fixes from Kan Liang. Ensure min/max statistics don't vary
    when real samples are encountered.

v2: Addition of header cleanup patch originally posted:
    https://lore.kernel.org/lkml/20241210191823.612631-1-irogers@google.com/
    as there are no arch specific reasons not to build this code.
    Fix bug in "perf pmu-events: Add retirement latency to JSON events
    inside of perf" where "t->stats.n != 0" should have been
    "t->stats.n == 0".
    Add patch so that perf record of a retirement latency event
    doesn't crash but instead enables sample weights for the event.

Ian Rogers (16):
  perf intel-tpebs: Cleanup header
  perf intel-tpebs: Simplify tpebs_cmd
  perf intel-tpebs: Rename tpebs_start to evsel__tpebs_open
  perf intel-tpebs: Separate evsel__tpebs_prepare out of
    evsel__tpebs_open
  perf intel-tpebs: Move cpumap_buf out of evsel__tpebs_open
  perf intel-tpebs: Reduce scope of tpebs_events_size
  perf intel-tpebs: Inline get_perf_record_args
  perf intel-tpebs: Ensure events are opened, factor out finding
  perf intel-tpebs: Refactor tpebs_results list
  perf intel-tpebs: Add support for updating counts in evsel__tpebs_read
  perf intel-tpebs: Add mutex for tpebs_results
  perf intel-tpebs: Don't close record on read
  perf intel-tpebs: Use stats for retirement latency statistics
  perf stat: Add mean, min, max and last --tpebs-mode options
  perf pmu-events: Add retirement latency to JSON events inside of perf
  perf record: Retirement latency cleanup in evsel__config

 tools/perf/Documentation/perf-stat.txt   |   7 +
 tools/perf/builtin-stat.c                |  29 +-
 tools/perf/pmu-events/empty-pmu-events.c | 216 +++----
 tools/perf/pmu-events/jevents.py         |   6 +
 tools/perf/pmu-events/pmu-events.h       |   3 +
 tools/perf/util/Build                    |   2 +-
 tools/perf/util/evlist.c                 |   1 -
 tools/perf/util/evsel.c                  |  22 +-
 tools/perf/util/evsel.h                  |   6 +
 tools/perf/util/intel-tpebs.c            | 682 ++++++++++++++---------
 tools/perf/util/intel-tpebs.h            |  40 +-
 tools/perf/util/parse-events.c           |   4 +
 tools/perf/util/pmu.c                    |  52 +-
 tools/perf/util/pmu.h                    |   3 +
 14 files changed, 666 insertions(+), 407 deletions(-)

-- 
2.49.0.504.g3bcea36a83-goog

