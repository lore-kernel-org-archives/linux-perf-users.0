Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173AB17A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 03:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756438311; cv=none; b=PU72HOL+6+aA0OHqHm52VwqtJbqEIL9O5rqvpSjQaO7BO8kNAIeunuxZ/+sXUXTlNJ1woSRKNXSR7o8hydNYvXXbYMKhjnDROrZqX67IG6s3RMLj9+r21zIFAaj8ERNx2lpEZXK3thvvi5xD0PYPik2O6HtyDyntUDooyif35rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756438311; c=relaxed/simple;
	bh=Pbjjn0DMDsr4UJIsyA5NmeVJklRb3qZ6fa1FiiHg9TY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=JJZw4ICD6ObiT5hGF6LwaWXQgMWcPMnvz8vTwz8GzZQ+cboPzZUOx3dLLdQo6L8luCoHy2tmS2sTN7e1x9UrFQvzO68O9ZpySkt2pZjvy/ogrsgCOFISHMjf3DYf8hRw8EDLNZKxpCatQ7zz6+dENeNoJToIMYhrf7na9FcPeG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mpGRm0jN; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mpGRm0jN"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e96e9af7ad8so2862425276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 20:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756438307; x=1757043107; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Igh8wQcHkEb8Eesa8vg0g54cvftBtL9bkZsN4Nn7hfE=;
        b=mpGRm0jNl+QSK71OiA0K3AmKDxsffSg8bwgri8W/KWrIEpIfVOJCU+GnmbJWK+2ZSU
         Xlu5g2+YMwHFWvjpv4nTeybZCXUtZdWOzwvx2puOyOyciZ166f2pokw3Y0hRD+OFKnFn
         4Lkr8USuOBKcNbJR7cnFh1Nhs4VV1nF2GWbYNT0dWz1KlEou9+b+B0++DdgLHsskNTvE
         +JlZZ+VfLRJYpatmvOFyoxb5RjQE9pTE2Tyc4myQFpcuhBBjbgexrkwCwYO5SfLYPIA3
         Uc/UBhRaGe+i/MkwdmEFeM8+s7W1hOEhKgXQ+iY97auUY40dhrb51KMy4Zyp37peqUqt
         3orQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756438307; x=1757043107;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Igh8wQcHkEb8Eesa8vg0g54cvftBtL9bkZsN4Nn7hfE=;
        b=E6/Ci+gZDag8FhXV+bGOiMP7P+ASs5QEu3GK1f+yEPD+DE26xrabOQqZgOURdcQrar
         wV/H/IwBDVPzh/sLcQEBohAKbtQcp5pnYyc3CPtAU6K+/1CEwqkbv3C7GLx+2pNNHRfM
         GgDnq1E5grf5UgdgGQS3HOb17NQoqtmeegioK+u98tcM7+prj20QD8pZEaYeITfpu4G6
         sWgLhtxFPIoWciw84PvCwu9Y/56wxMW2GfF1bDscpcJPEHp0sk8NfPOOnMY2mTp8KpLi
         AlVIDCYZdchMU7rRSPYNfhJpKWWHSF5UL+NQJFhNn65nImpvwj6ZkJQ2Fy4jPqpn3oGK
         +kCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEez7vO1CicquD8UlUu687kLrzofpEEozuJ4wzapkvBtYUHtBCx6E96/qWuf5aj9Ivy+dr8PWfq7wBCdSC6HPa@vger.kernel.org
X-Gm-Message-State: AOJu0Yw40en0SIwF9xK7lXl+jD+7ilEjIOAMPbxdMeKczzZiyReGDD8k
	vUiNMlo5ySmJfhVTJLr3qHY28lhyLByhTWabbqiQeeVdp4yf0bSx1ggTzCnZTPDxLVjPq6SZWsQ
	21nNXqaGDIg==
X-Google-Smtp-Source: AGHT+IEAqPl/PUmtC3gYt7eLN0CBsJXSLELBytYsBAWO3YREnVqyHQlp4RQeG/vjJn4twfvM09nEds7Abb6T
X-Received: from ybbdo18.prod.google.com ([2002:a05:6902:2312:b0:e96:c754:b4e6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a25:2904:0:b0:e96:c2d2:4af5
 with SMTP id 3f1490d57ef6-e96e4792de0mr9656813276.16.1756438306896; Thu, 28
 Aug 2025 20:31:46 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:31:25 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829033138.4166591-1-irogers@google.com>
Subject: [PATCH v5 00/13] Python generated AMD Zen metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Generate thirteen sets of additional metrics for AMD zen.  Rapl and
Idle metrics aren't specific to AMD but are placed here for ease and
convenience. Uncore L3 metrics are added along with the majority of
core metrics.

The patches should be applied on top of:
https://lore.kernel.org/lkml/20250829030727.4159703-1-irogers@google.com/

v5. Rebase. Add uop cache hit/miss rates patch. Prefix all metric
    names with lpm_ (short for Linux Perf Metric) so that python
    generated metrics are clearly namespaced.

v4. Rebase.
    https://lore.kernel.org/lkml/20240926174101.406874-1-irogers@google.com/

v3. Some minor code cleanup changes.
    https://lore.kernel.org/lkml/20240314055839.1975063-1-irogers@google.com/

v2. Drop the cycles breakdown in favor of having it as a common
    metric, suggested by Kan Liang <kan.liang@linux.intel.com>.
    https://lore.kernel.org/lkml/20240301184737.2660108-1-irogers@google.com/

v1. https://lore.kernel.org/lkml/20240229001537.4158049-1-irogers@google.com/

Ian Rogers (13):
  perf jevents: Add RAPL event metric for AMD zen models
  perf jevents: Add idle metric for AMD zen models
  perf jevents: Add upc metric for uops per cycle for AMD
  perf jevents: Add br metric group for branch statistics on AMD
  perf jevents: Add software prefetch (swpf) metric group for AMD
  perf jevents: Add hardware prefetch (hwpf) metric group for AMD
  perf jevents: Add itlb metric group for AMD
  perf jevents: Add dtlb metric group for AMD
  perf jevents: Add uncore l3 metric group for AMD
  perf jevents: Add load store breakdown metrics ldst for AMD
  perf jevents: Add ILP metrics for AMD
  perf jevents: Add context switch metrics for AMD
  perf jevents: Add uop cache hit/miss rates for AMD

 tools/perf/pmu-events/amd_metrics.py | 654 ++++++++++++++++++++++++++-
 1 file changed, 651 insertions(+), 3 deletions(-)

-- 
2.51.0.318.gd7df087d1a-goog

