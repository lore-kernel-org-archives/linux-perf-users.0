Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591D61D8A0A
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Apr 2025 06:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744179054; cv=none; b=FSg9i2lPIwxoVv5JU/5pf8sxseVJlsHrWIpckuJ6kaCKTViAeNds4JpVNIJweQj3Hqj9ckUTHz+6jAzNAYYKjs0t/se59JQnHFad34/RrE47f0ZBomS97R0J1TeDInwrrJmWlXH3zS4oU6U3EjX74N4iTgSPQCIY7K1kpw/pyck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744179054; c=relaxed/simple;
	bh=VOlrE0q1Dgt0/ufOq2NjQaIoTeL0CeB1PTgY3Vto+Q4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=Df063wohLKDVuIXKCNAOS3PcayeZHlcTv2yMpDdX+GTg6P4o1M7IcgOiOlh7wB7KDsuB2K9L2Zd62EeXXzPSc2oY9C4PW1ymxqReiIHvH2m/alNC0XLUMchSzFxWxs9T26xsR2X0pU7LN/ielZ3R8NVk+jptSH1IQdl5mh11xn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KnuFQagS; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KnuFQagS"
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2c238fbc14fso7544965fac.1
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Apr 2025 23:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744179052; x=1744783852; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IQysTOtg9Kdj+LrUMGXjnelf/uERWnWmH3sm6GDGrDs=;
        b=KnuFQagSm5GTyhX1SSFrHZgPcs4q+p0SHHFCyNnt6dfKQjr2xByeUR13qQdNCbwoWd
         tqWbOj7JDe6BRS84/N+ywKJuT9iiz9aSy0yQaf18D6wUKV2YGpK/uWyFUqBF3TKX11Pg
         DWssBktP9qb1nSoKHiJ/C05F8TgJ+IjTZIulgpcgybBdwR7Zd0Ne4rQJw8Y+n39RmHCQ
         YihXqJpu0l7b5E3365IZQtziv4eMF7vafCJjMuv7wBm94TsKEsr93XOD2vXd+kucHPHN
         pSR6GGOwTdp506ii2kkKXyiPrUj2iECcDXCC2dOS+wpy65LQ30GmTo/+E8XoL2C3zYbc
         md5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744179052; x=1744783852;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IQysTOtg9Kdj+LrUMGXjnelf/uERWnWmH3sm6GDGrDs=;
        b=C0HUknDT5ksLk5ZpoVAwie6eRSBkBYlNgTZT3AyRrw2wnZY2Y+xMJ0T5DRcwpL02Hu
         0RBq9r2IhE0jnfM5ygGQkl933mHLrVHdRdpvfIynlultlDnwNwCJhfe+7L2ax/I9chOf
         vA02NQu0rRgWoDLdcFg7vmrsXfw9+ZzmA/1vr/yxpInmQU7CW8jALL7wwSYR8tGIRF0W
         1sIOH97jTMBQYpqoE8qTZpUTUpqBO3QSqN4G4uAzCkl73A7ukGwvwCNJnmSjRAVFYoOl
         y9BBpzGeRmpPBI4GMgHx2MHMV+qO1c1C01IgVNCCKIMonnQOoZVR+CO2DpTbmbBoG6dd
         9Wgg==
X-Forwarded-Encrypted: i=1; AJvYcCXwlvC02SVgTIsYVSJREDdjj4/Oca3zn+xu4zQNsjBc/eoq1d4WZryEBa+AwSCjkiU/iAJ1jwzOAuPkAZyBGN6k@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2NGTgpYYBqn9T9NxRnZd3hq6JQkabScMLnVCmDmQXPuxf34ga
	n5RmUWKe4zupsQ8ve3u7Dvf8EsaHWXh0tREdMeVuWNYImizBIdach/iOk40gttZBMloKZN9O7zz
	uovY0cQ==
X-Google-Smtp-Source: AGHT+IEQV4QF+BtOk9XKaaDJXmt70/LQ97tjKNA6w7SsotefkMcSscPT06n12/bTAX31grcBsCWOjkz9q7z4
X-Received: from oabxi11.prod.google.com ([2002:a05:6870:4f0b:b0:2c1:fc56:4d62])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:9598:b0:2a7:d856:94a
 with SMTP id 586e51a60fabf-2d08dded4damr919045fac.22.1744179052187; Tue, 08
 Apr 2025 23:10:52 -0700 (PDT)
Date: Tue,  8 Apr 2025 23:10:27 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250409061043.700792-1-irogers@google.com>
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

