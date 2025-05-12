Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2A51CA84
	for <linux-perf-users@vger.kernel.org>; Mon, 12 May 2025 19:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747079191; cv=none; b=g20qEHLbR+sA3CmU5h0UYRgqzDuBB7+6TbAKfH+A/gRj5OMHvFhDt03tC0PC5XVbGKaaLyAo50r7+jN58j7HzMEcQATrg4rfO9AjykpVawqkwMUK65H1zDURvfDAuuoPEgysRuuOs2vVUaDeeVdYm3iaU3x9DqA5RGWDbSPe/1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747079191; c=relaxed/simple;
	bh=kSZe5BRqz0dhczAp2bhd4QJpIEWetSdNut71QQAL5cA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=jjflJq7ZahNGU9/IlpYxv6ejhuvGSdDEwqe64iLvJHg/F4MCEXn2di7M0lezaWnUWCPLe/eQjoRntPGG7ju4VSaWrmS0evPbz6GKZ7Fax1DsMZ8RMF4N8uXx3FpKO/D/NgJUgM6AyMH2o8FK7PgZ5acCdfTa+GCKX4IyFivowEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uqn8VZgG; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uqn8VZgG"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7425fc3357aso2039963b3a.1
        for <linux-perf-users@vger.kernel.org>; Mon, 12 May 2025 12:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747079189; x=1747683989; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KCS6TCz2k4JMDGyXshw5mX//JzYJvJIRNOVd3LwESJQ=;
        b=Uqn8VZgGmQKTVbioMwLrxxo91jT0JDRGYF8uomIapThqDR9s+Clkz6vULesP5GkTjX
         tf45uJANXEUnkvpay+kXhNBo2BaQn2+065rHVJOFhqUVYUYWITp3MnQC3V1RYj3v/NiK
         QpBYDT/89nb2v1elgEKnOo7wXOELzrm8FEUim7RoK3gwRmvUhKGLadRo4Idg5Tl140wR
         vnT4ieo0HUSnY8Er8ci5WWH6C43wuxeXDC7Kw2wSWDjsJ0PvJtsBkNLmhzYUoFiyg0re
         uz0OMMnU3uyUbV9bplMbrdkcyBPaITQGobaZWMYdnBceAZvV2E+5po4febkBidQOgkE8
         Ag3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747079189; x=1747683989;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KCS6TCz2k4JMDGyXshw5mX//JzYJvJIRNOVd3LwESJQ=;
        b=Wmomgkqg/cTsKp3FBOG2TTrIan4lfh8+oKDeb5mAKXDvFckVXuTaFk1uvtL0yQq65h
         c+tyWY3V8KOGg7W+z+/372cTcRwFdmqEMGrPHF+JmT/va/q7sQIB84CbX9R4l4tRNYJw
         zEio1CqhMOXkNkJkcLYMnKep88h7DRxrspX30cbOa6vv5swemPajwtYJB7QssUzmMnfp
         Ob6b/k46eu3NQlvvKVckuz0djjW6lPp24zIJ8ZNdXuDOOYAAS4ZDJHiTcZJTrA72jwk/
         K5NrsrhKcNxxt9MF5LfmFYtBYp4Q8OyqC2jnxJ4nKGAecBH2dHJGASu1/SyHFxHY9wOU
         CHVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU47X8eZ8J1fmWFrN1YzhX+9IMgjo81rc05I8bxG7afl3lP90OIyDqWSb1KIQZzPmZqFYquxId0RlEd2xSWLoo@vger.kernel.org
X-Gm-Message-State: AOJu0YwwolmaqVTVieETq1dgcUSGw/59ieMOfJqLhaakLCBhm9P0oahF
	6TPULKtQcfhqRsGNpD8Jo+/f+iiIjXCq0+Q5P06pb6UIUuhLweGIx+tXrMebLZaBbW34r3lqQrh
	8DMGofw==
X-Google-Smtp-Source: AGHT+IEeTcRv9UOqhEhkvudchZcUoofJuCiliW2oNTTuFaFiCUkmau+51NAFjGXKNF1O3yPqn5kZoJtpPdAx
X-Received: from pfht4.prod.google.com ([2002:a62:ea04:0:b0:740:4dd9:9ebf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2313:b0:73c:c11:b42e
 with SMTP id d2e1a72fcca58-7423c0176f2mr19391272b3a.20.1747079189274; Mon, 12
 May 2025 12:46:29 -0700 (PDT)
Date: Mon, 12 May 2025 12:46:19 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250512194622.33258-1-irogers@google.com>
Subject: [PATCH v2 0/3] Metric related performance improvements
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The "PMU JSON event tests" have been running slowly, these changes
target improving them with an improvement of the test running 8 to 10
times faster.

The first patch changes from searching through all aliases by name in
a list to using a hashmap. Doing a fast hashmap__find means testing
for having an event needn't load from disk if an event is already
present.

The second patch switch the fncache to use a hashmap rather than its
own hashmap with a limited number of buckets. When there are many
filename queries, such as with a test, there are many collisions with
the previous fncache approach leading to linear searching of the
entries.

The final patch adds a find function for metrics. Normally metrics can
match by name and group, however, only name matching happens when one
metric refers to another. As we test every "id" in a metric to see if
it is a metric, the find function can dominate performance as it
linearly searches all metrics. Add a find function for the metrics
table so that a metric can be found by name with a binary search.

Before these changes:
```
$ time perf test -v 10
 10: PMU JSON event tests                                            :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
 10.5: Parsing of metric thresholds with fake PMUs                   : Ok

real    0m18.499s
user    0m18.150s
sys     0m3.273s
```

After these changes:
```
$ time perf test -v 10
 10: PMU JSON event tests                                            :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
 10.5: Parsing of metric thresholds with fake PMUs                   : Ok

real    0m2.338s
user    0m1.797s
sys     0m2.186s
```

v2: Rebase on tmp.perf-tools-next.

Ian Rogers (3):
  perf fncache: Switch to using hashmap
  perf pmu: Change aliases from list to hashmap
  perf metricgroup: Binary search when resolving referred to metrics

 tools/perf/builtin-stat.c                |   6 +-
 tools/perf/pmu-events/empty-pmu-events.c |  66 ++++++++-
 tools/perf/pmu-events/jevents.py         |  66 ++++++++-
 tools/perf/pmu-events/pmu-events.h       |  23 +++-
 tools/perf/tests/pmu-events.c            | 129 +++++++++--------
 tools/perf/util/fncache.c                |  69 +++++-----
 tools/perf/util/fncache.h                |   1 -
 tools/perf/util/hwmon_pmu.c              |  43 +++---
 tools/perf/util/metricgroup.c            | 102 ++++++--------
 tools/perf/util/metricgroup.h            |   2 +-
 tools/perf/util/pmu.c                    | 167 +++++++++++++++--------
 tools/perf/util/pmu.h                    |   4 +-
 tools/perf/util/srccode.c                |   4 +-
 tools/perf/util/tool_pmu.c               |  17 +--
 14 files changed, 430 insertions(+), 269 deletions(-)

-- 
2.49.0.1045.g170613ef41-goog

