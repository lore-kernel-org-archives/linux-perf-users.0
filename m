Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03BF14F123
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Apr 2025 05:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744002072; cv=none; b=uZxanS88lFkX/QrM1YgdYTNudyPh5llpLOQnsXjFMznAEPIv62PE++TE9CzaQRo9LH5a/hYd3uCttQoskm+7YnWNDKBQ+g3pfDunKpLsmnTNspGHhFvVjPWG1qtNr9fbWt6ynDOvRhy9JXSKrKlzn3Yieq+WcYPa4W0ZGcrYh70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744002072; c=relaxed/simple;
	bh=MiqLbhrZGLPWn0Pk2WlozjtvboHlUSyDcOAAVryKdBg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=i3c6vo1frNoXTvsGTfSn9BUmO3FED4D9K5qrVS/tpb9H7UaWEuk4+iqLu3Q5mawVuJPzwpcCrnnoOKMpLb/QAWJEtsRAFC98zmw/kcKvCJqfiWbDQJPvKSnHpa+nWCyuP7dc5eq6eVvJkDUzx04NnvG+H671zK0HVh2szCzlzto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HvuexNw2; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HvuexNw2"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-73009f59215so4696851b3a.1
        for <linux-perf-users@vger.kernel.org>; Sun, 06 Apr 2025 22:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744002069; x=1744606869; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iVUQUuNjQVEkVXgouqSloj+am8brbBcXvDBVOfIMeRo=;
        b=HvuexNw2WiC3uPNmIITchoUR2zwP280w+ToXBZztjddqdJJLq98tR2fpCbTQziQ2gv
         HRQVavC4yqzHIUoXqUjtLhdkxy0yHc8amFfhfrcdRyuiRIwA469pHHKzsllvpQwJniNM
         tK4BtvTDzIsf/BvOx6OsG2wiLqnIQSmH1+ENTU8YpexGltWhJk4rqfotpivm8n9Xd5KN
         MDOlgTPxcEmlYEW4Ov5e13E3EyqjhvKGmoZTP6ZmMA9dRjvYdKxHE1KlBrzKukNw22Qm
         +V7MTnoRnbwUNOFhS+IK9rYR5Le0uouwl8Kys5V1HMgnDWwbHwQSg1fLeWghEjEXAWCO
         lMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744002069; x=1744606869;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iVUQUuNjQVEkVXgouqSloj+am8brbBcXvDBVOfIMeRo=;
        b=c6MjF9fbKHhOuYfOCw4BB5Q+KZa5NYmYzFDeB1RAtuIn0W6Al6xfsoN9agkS0MEwxa
         l3eyDklnh6SpktwlwZDkbkfFzJeFOUa5bRWkPu3BshTN4eNVHeeLvK3m/uIMVGbI6OiZ
         4CinuMX2XredhEjP4tRzqXE6z3EVK+8rm0ggC7Ve1b6AXEEnKbeeATS02zzD8f/TV0u8
         87P0w9m95bU/RKfsvDVorIUYbQmef1mZdXko+s4xLbb3aCZY29476hWLEtMzbr1tz7mt
         crPy35/tNfG9h6uaDFoEFZWoCvDH686xosnZ2bA5a0x/Qq6yS78spq7NiwK11gb/VuYd
         wyJg==
X-Forwarded-Encrypted: i=1; AJvYcCXkNtbnplGw2qTJ0+kfBLFhehMJmW6uhNHcZKeN84V2Z7O9Q5/hAYyXctHwJ+qO3CJQrwN14yJbx9UroiPIPM1M@vger.kernel.org
X-Gm-Message-State: AOJu0YwgPCyBt9RsuMF4ZtzSOXt2mPsbbCMNfHqGJl8FJNysZ/ebiMib
	xlwiDB07oSiVIzO+DvY1Sd8x/2gWrG8r6SR1o+fHizmrtRUcfOlT8yFloKXEyWJwOIEPIv25qKi
	Set209w==
X-Google-Smtp-Source: AGHT+IFK8Q8TKDbXknHh/uMraXEDMoryD2Y6GrWrDfIu8/Cd/TE4jYBkShXV9FSoWmJbJiART0hAp4tiCN+h
X-Received: from pfbjc15.prod.google.com ([2002:a05:6a00:6c8f:b0:737:6066:fee8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d04a:b0:1f5:97c3:419c
 with SMTP id adf61e73a8af0-20107ea25b4mr14553261637.6.1744002068912; Sun, 06
 Apr 2025 22:01:08 -0700 (PDT)
Date: Sun,  6 Apr 2025 22:00:45 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407050101.1389825-1-irogers@google.com>
Subject: [PATCH v2 00/16] Intel TPEBS min/max/mean/last support
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
 tools/perf/pmu-events/empty-pmu-events.c | 216 ++++----
 tools/perf/pmu-events/jevents.py         |   6 +
 tools/perf/pmu-events/pmu-events.h       |   3 +
 tools/perf/util/Build                    |   2 +-
 tools/perf/util/evlist.c                 |   1 -
 tools/perf/util/evsel.c                  |  22 +-
 tools/perf/util/evsel.h                  |   6 +
 tools/perf/util/intel-tpebs.c            | 677 ++++++++++++++---------
 tools/perf/util/intel-tpebs.h            |  40 +-
 tools/perf/util/parse-events.c           |   4 +
 tools/perf/util/pmu.c                    |  52 +-
 tools/perf/util/pmu.h                    |   3 +
 14 files changed, 662 insertions(+), 406 deletions(-)

-- 
2.49.0.504.g3bcea36a83-goog

