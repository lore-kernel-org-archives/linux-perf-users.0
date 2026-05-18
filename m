Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E87731A81C
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 18:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779129567; cv=none; b=thivKHXiFLzMBDg/bNEPqvvkSUyHDzjrlLl62ccRNxt27h2pwTSZ2FTSKCEHidQDTlR3OcF30ahE4ZwcE+QghPiS/t+cxzrd2oMn/af+7V+x+Cfi1LR5tsbg0daOGGsOEr1EajMX0OjwFh+xbtHehcnvIQR/eXOzkbuzVZEU7bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779129567; c=relaxed/simple;
	bh=EZqnjx+QHU2XUgAf2IBXEYH5LSWpOnCzLKQ0dwWi+14=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=gkzxgmJNRMErjdNFIJQUFpkLJJisW+EgJDlJAblwlqjuSCk7hBdaq8FDzo87Bp9QuNKg4Jw5SpaAYHUBP26w5dwJIeGp03Jg0jC8WlUFKmiJGiooWNPVLI2eHei5EUHRr1hEENdzKgE9I5GfWOG08Gn1CyEdjbgIZhzKzaKWR4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ViREnynE; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ViREnynE"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ef62078ee7so3640332eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 11:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779129565; x=1779734365; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bi1SI3b6igqsdTxuANV2VTKVvY/gVbtOWbbYVK3yPMs=;
        b=ViREnynEL5zeoL7JrQThpGf4GtJ9LpBRiy3l0J7vL5S7+X9iB+oOtYEJVgQCA8BeuT
         QoHBWXLVDPLsZukz6JhbdF2NAW97i4avuERE44eeX5ydKiplSwpwqEoJMq4xZV+baFvR
         53oOYP2kR79pgrd40OpHwhN44ES1esZn+8IymkY6n7+MIiHDSf8M2eivsooeuboQ2GWe
         s7Lgx/gvK4gKBF4igrLvEbiF8TVW59rgazNqySNLnnA8p5bxfiGg7UdeWmIpGS1VSjNZ
         +7s4ey6gNby0FmWmk+QIOuXIWYm6KaOeKaOdW6f2b50gKiP/iyDO98ku5ASZjhCjpjyG
         04pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779129565; x=1779734365;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bi1SI3b6igqsdTxuANV2VTKVvY/gVbtOWbbYVK3yPMs=;
        b=LcUacZCTf/LWDAuf0pKNzVaYWJ6NqoT4ImwwAuRInGdjS316d/AbOhrq8izeBwCb7X
         q8YPCdHoe0iUlb1VX8Sv4A3nIopQNh3bGmghOOywECLXDYZFPZPrmrA3mf9CkbYmEkW7
         X5VqQSDo+APHVUmT2iUGk1z7wq+QoCr/7pMJmXXbFc8YrV1nD+e5EOasnGgSaYFKl5zP
         NNunPX1vrCEaZ5b3q+leteV4pbcgQ3rrYesnqWMMCZpjnpEdYkgP2UeMDIfvsH8I/q3i
         4So9sfaLs1XUlzppvKvXQgC84J6Spd2q/Hi1FBktAOxwiCcq2ARmcClYG17pf3BvILya
         TjJQ==
X-Forwarded-Encrypted: i=1; AFNElJ9nv+pDqIm6Jhfugh+w0FSR+D0EKWE0bvY4RhDH68oZwCG+ydZ4j5hjTpToSdTKral0xqGe5dizsIU9qehLXmia@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr4Ejx63es9F5sTaEWxckuVjHEbMgXoSNf1iOXcMFWykWLo9lm
	SyBV18yiC62T5x/WRb10qtJgWDZox3K/3eanfZUmZ7fcaKIDs//jwwAkdoYgPuW/nxg/loQnAx4
	vslxB9Oib0Q==
X-Received: from dybgr25.prod.google.com ([2002:a05:7301:2019:b0:2df:c53c:24a5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:8187:b0:2d9:5cd9:b8ff
 with SMTP id 5a478bee46e88-3039818af3amr6823525eec.6.1779129564826; Mon, 18
 May 2026 11:39:24 -0700 (PDT)
Date: Mon, 18 May 2026 11:39:18 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260518183920.2894502-1-irogers@google.com>
Subject: [PATCH v1 0/2] perf tool_pmu: Support enable/disable for tool PMU events
From: Ian Rogers <irogers@google.com>
To: Francesco Nigro <nigro.fra@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A regression in perf stat was reported where tool PMU events (like
duration_time used in CPUs_utilized metric) incorrectly included the
delay period when using the delay option (-D).

This series fixes the regression by making tool PMU events
(duration_time, user_time, system_time) behave more like regular
counters by implementing proper enable and disable support. They now
correctly accumulate values only when enabled.

The first patch implements the core enable/disable support for tool PMU
events, and the second patch adds a shell test to verify that
duration_time correctly excludes the delay period.

Ian Rogers (2):
  perf tool_pmu: Make tool PMU events respect enable/disable
  perf tests: Add test for stat delay option with duration_time

 tools/perf/tests/shell/stat.sh |  33 +++++
 tools/perf/util/evsel.c        |  85 +++++++------
 tools/perf/util/evsel.h        |  10 +-
 tools/perf/util/tool_pmu.c     | 212 ++++++++++++++++++++++++---------
 tools/perf/util/tool_pmu.h     |   2 +
 5 files changed, 249 insertions(+), 93 deletions(-)

-- 
2.54.0.631.ge1b05301d1-goog

