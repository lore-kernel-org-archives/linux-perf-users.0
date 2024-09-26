Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6FB1494AC
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 17:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372168; cv=none; b=IIn45FchYwbiWB+RaOnja4mOiqFLziRXsw7kF4Y8yt57sAxQ21k9lSunijXKITKaE1Y7i54/tIpFU/Bfd5/FrC6iJ2jaPyBzpLeQakK4nDvBW37claWxCgr+1vRXgBvPWBU6y0uCjffn3mbIrIZaQ+O0IMqBUbdE9kZEGgyg52g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372168; c=relaxed/simple;
	bh=qcy+RpV2vbrVmrGURYFWlXNt7s+hWt135vi8pUWprCc=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=EUkl88GykS8v4mj81FZtRVyj5IeSytpUufv/TEenBnglQxidrU3k9VmAX+pt2KhOdoSKjyoViCkBRJnigrJrBitSq+T1UgISSKHMul9ES5LpSEOwUxF1yxwiuhQFH1vxdf86fMKB2jjowuAimwMADw85ACfQN/LCUDeyCxJnyeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zk2Zw7fU; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zk2Zw7fU"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e25d62bfe12so1044796276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 10:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727372166; x=1727976966; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yxYcIYohZlas4VM7SOhVCX8bDWL8M8YuZQaG8xAXc/s=;
        b=zk2Zw7fUqK6nxD3PizqVwqTjXfDqWOQuktQJh3XZLGZYmvK5cljlT+G5RMy+EeKc0s
         eTPxEkPDx7F5pdf/tDbt2AptkmrFcfa25g/+x7xVMI1cL6WLAgTjYM5cpZURbgPp5S4O
         gB8CUjdvEUk3EF5qahUtOD1COPxbvwUofqVlAKtcj6VM5FfINIMX0DpXvVf+qNsyU8/N
         QRl99BxvkhFEOQ1JqzI5FM743n+gtZ69Ehvpoix38r84oe0W7sGUIbKt6wULFcKLBKyZ
         SETAlZUnzZ96HYWMFhEhlh7XATYVkibcol7v7xzVWH2i2KqEXI5cTyKk9ySH9fVRAwVQ
         YDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372166; x=1727976966;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yxYcIYohZlas4VM7SOhVCX8bDWL8M8YuZQaG8xAXc/s=;
        b=PtrMkR3oW6mlXavYpP5862Tomz3m7l/lk+diP0SmeW0UF4eYMdMgfukrHqyngj/XKF
         YX0Fb655sCX29k7YoPUxc/Lu2vKXgStHKUFhdSKwNMbhE/hUs6x7wL9iesNccUUMVcuS
         dS4xGYHOroi0+f4811Az/vD9iyVgvn4Oi59EYI3OXcrPV0jWNUCqvHUdksG3YMcliaZF
         Bt6PQtdGj9VDxVcmPrCtnZJTrKH5MNQBXJ1Cqk2MbrgFQ6BjinysEUvd4rd4otXOv/bL
         kEwB6cmfx4xlNN9O3LBFkljD+kYSQ78URxh/qAULblSq89BDpzWY+REIT1GM87KT42Wx
         rP8A==
X-Forwarded-Encrypted: i=1; AJvYcCWMozasAMpafQYks2k7Xounl+Eu0WtYrY6DSrnZ0sYfNjzjpkWwrIxszRG1cuwCkRbp/J1YDCVQe30S+y/2CVzk@vger.kernel.org
X-Gm-Message-State: AOJu0YwWgHy/2NiPSv1TT5SFcxlP1pRao1R/bDd0HxMmaBRKwQ3+xSK/
	N84Aud/x+nZR5F68ATdEJJJ1uYG7JZssudtbJIPL8t4MXyWTkG8WNmiqFfzXiMLgg/oOBCaiNKx
	TaCSakA==
X-Google-Smtp-Source: AGHT+IEyd4n02CVR6nEreiqxHqV8a9sHCLgR24twhhVBcHmDoVskxT38W8/3BBhxdfBHRwZ891T8PiGhoHBg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a25:ce85:0:b0:e1d:2043:da46 with SMTP id
 3f1490d57ef6-e2604b2b428mr147276.3.1727372165851; Thu, 26 Sep 2024 10:36:05
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:35:42 -0700
Message-Id: <20240926173554.404411-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 00/12] Foundations for metric generation with Python
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Metrics in the perf tool come in via json. Json doesn't allow
comments, line breaks, etc. making it an inconvenient way to write
metrics. Further, it is useful to detect when writing a metric that
the event specified is supported within the event json for a model.

These patches introduce infrastructure and fixes for the addition of
metrics written in python for Arm64, AMD Zen and Intel CPUs. Later
patches will introduce the metrics split apart by the vendor.

v4. Rebase and small Build/Makefile tweak
v3. Some code tidying, make the input directory a command line
    argument, but no other functional or output changes.
v2. Fixes two type issues in the python code but no functional or
    output changes.

Ian Rogers (12):
  perf jevents: Allow multiple metricgroups.json files
  perf jevents: Update metric constraint support
  perf jevents: Add descriptions to metricgroup abstraction
  perf jevents: Allow metric groups not to be named
  perf jevents: Support parsing negative exponents
  perf jevents: Term list fix in event parsing
  perf jevents: Add threshold expressions to Metric
  perf jevents: Move json encoding to its own functions
  perf jevents: Drop duplicate pending metrics
  perf jevents: Skip optional metrics in metric group list
  perf jevents: Build support for generating metrics from python
  perf jevents: Add load event json to verify and allow fallbacks

 tools/perf/.gitignore                  |   2 +
 tools/perf/Makefile.perf               |  23 +++-
 tools/perf/pmu-events/Build            |  62 +++++++++-
 tools/perf/pmu-events/amd_metrics.py   |  42 +++++++
 tools/perf/pmu-events/arm64_metrics.py |  43 +++++++
 tools/perf/pmu-events/intel_metrics.py |  42 +++++++
 tools/perf/pmu-events/jevents.py       |   6 +-
 tools/perf/pmu-events/metric.py        | 162 +++++++++++++++++++++----
 tools/perf/pmu-events/metric_test.py   |   4 +
 9 files changed, 348 insertions(+), 38 deletions(-)
 create mode 100755 tools/perf/pmu-events/amd_metrics.py
 create mode 100755 tools/perf/pmu-events/arm64_metrics.py
 create mode 100755 tools/perf/pmu-events/intel_metrics.py

-- 
2.46.1.824.gd892dcdcdd-goog

