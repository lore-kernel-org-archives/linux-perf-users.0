Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C44217A2EC
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Apr 2025 04:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744260347; cv=none; b=ThpoVZ6rJrjIC5il+0WTuH9mwnd3kANGvPblRbHwssBwEeTyiTRCiEEc6oII0fEIPVd+NfugmXw0P8mPOBM7CoNVD2BTuDv8kZGbiW+PaoOVerf3aFNqdbLkHKvzNdu9aeWwFaFSadFDMRsY7X29Rsp0D8yCDIv7drk9GrYgDiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744260347; c=relaxed/simple;
	bh=l2MapbAWPEBH8Qtq9hbgGBPoxnDIQllvf+gDDdA9wLo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=q1zPO/rytqI06TWVWutFyw1+Kk9oPVvva8bPAVybP3hBLqBiCg56rRQbpu3Bh7fT2c8uXSjW1GQ9quzZyROyFwp7tteUAL2pvCy230i1oRvV4T2TdVAZAzXp/UzGP7RJR+2cwTmRL1jSWLJc2zzwY0YbNeEeB+mhfryTrqEUx3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zc2UHXy+; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zc2UHXy+"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736bf7eb149so295067b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Apr 2025 21:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744260346; x=1744865146; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ssrQr5jp1XbqeNme6OYBRMcEgvoLcrD6fxGL7PcU8Og=;
        b=Zc2UHXy+g8RNuSqCq1zT0LU7u0SLGD6eOif+bwAASevP7rvNq5EXMqexBvf2vpRSOg
         t/evPasWaC9PNTwZuO73g34+4ENl4DEXXYd9ILerRr99noc5g0+tnh7lkY5jTw+5xkae
         jVzGxyhjykADBGmNN4bMVVPrZ6RM3stui0PyDOV9yZimq/VyKF5yOIwzEhhzEKjPGXU0
         yX3rTZvaTQ2FoHCvBdUZEI1HGkvC1Rwe+q0UVAPeRr8N2DYupxVz/Q/hLFKh/iVz/oTN
         +xiVr7rRoDyn66Qwk7lY2N9ysdB1qsZYklW9wVh4Z3lH3NKYXvBARk0Q4WfJPGBeAgkd
         gCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744260346; x=1744865146;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ssrQr5jp1XbqeNme6OYBRMcEgvoLcrD6fxGL7PcU8Og=;
        b=IzmdwSq/r2VQYqjx8G6MfrmvI0v8jtc8VGyIdidTnl5DbMMwDir9btCsdx1nlIx87j
         33DH2yOGdXFg0+s4EKjPU46pu+gzlMoQ0qVRRFoiCaYNVUacC1HSzQhQOd0cSHTyf2uo
         WIGyfa9SiK9USq/xijlvIwJUyNQYf72h7WrHBiLzucapcj+aqEraPB8mtJiKXIuhneUz
         5wfqNy3bl2oGXy0Ni7z1xMLPfI32JM7auousci6jADLBrJmQtzhZEoPmAFs2PM0sbin0
         rbppI52JCIWUoRSo/Gi17YJcqvWO/Ym/2KsMjBQ2U8YjTvx84cl2ZFNVE/d24wkdJ7nw
         SZYA==
X-Forwarded-Encrypted: i=1; AJvYcCUMQgTIXMbL69VjwUr3/2RDerZazyk+VNGr5MgKfeC8ONsg/YLinEJzjTIqtoTRR902rW6+cUWANhNbrXyvFF3K@vger.kernel.org
X-Gm-Message-State: AOJu0YwrcKhELJaKmYvpmJnzyo61yl7i9pKNYWQF/CD2ZnK1ETfPKC1S
	DtAaM503DPNhqzgcIKjLnFSnJhfBcAR7ve/Q0UeOCPGEA8CkjvZpcNsZ/eepHbFZ6WnUUN1f9nE
	DKpj6sQ==
X-Google-Smtp-Source: AGHT+IG8qev6jAK3+G7MQEZMOQnUrDNetBN3j7CxzUxCy575TG64NYTf2zoxL2tYpfGXDe7/7oIoWyX73iIT
X-Received: from plgf12.prod.google.com ([2002:a17:902:ce8c:b0:223:f441:fcaa])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f602:b0:224:e2a:9ff5
 with SMTP id d9443c01a7336-22b2eda9814mr20701615ad.9.1744260345479; Wed, 09
 Apr 2025 21:45:45 -0700 (PDT)
Date: Wed,  9 Apr 2025 21:45:29 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250410044532.52017-1-irogers@google.com>
Subject: [PATCH v1 0/3] Metric related performance improvements
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, John Garry <john.g.garry@oracle.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
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

Ian Rogers (3):
  perf pmu: Change aliases from list to hashmap
  perf fncache: Switch to using hashmap
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
2.49.0.504.g3bcea36a83-goog

