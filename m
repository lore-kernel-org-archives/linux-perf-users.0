Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7CE2EA732
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 05:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782192932; cv=none; b=jR6yUxI52jguuXc7G2fUrfI2/bs7RvFJXTHIVBjA2YxE57abCnKWwLqE8XX2zswY/4aT9kr31cQ3FFQ2B0LZ6SwJv/P3XlGsofNBKrsQBD0iio9WjN+XUqxucmdV0UJQ0IoV2jGknkiykV+nUyXZhtAxgE2d5HjtUgzTktKstKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782192932; c=relaxed/simple;
	bh=+IjoXTe3LoqZbQjteS+7xvGi2Lzg2frewhtU79bnp9Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Quwndju/VrMUv9m1g7nVBank1fhZIerqe/+8oVeSbmC7ZfCLWCrUZtKNdwQXWORTXp2CCtNGqQt2s4+8ZxEC8Px+CXbOA/uLtbnR4SMZipoNQDclAUY/9A6mVCntua+0Ndl+0CwKsEQt8JofjV8C0WxecZF2wlVuR6iFBTrvksU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HPk/tCcn; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HPk/tCcn"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8bad49b171so2100194a12.3
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 22:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782192930; x=1782797730; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JbmeyCeCBW04cw8K6TppsmyFgHsQCkQuuVYDaiK18I0=;
        b=HPk/tCcnmXFG8djk0xFaHnDAFT6A6berJFFxPkSlWt65bL3plx9wCMC4FpXTkG0p2b
         NNyg0uJIMt0h5WxmzKY5zp8XZleFoCeL+fk6dZnj2H2ebndqIeiSKY1y2ksI2sE1X9uS
         +xFviyHGKakUCISVW4l4eshdgc8Bwis2dwS3pAYCn2ONkx5N95/A1TQ2uK1gfRUD5N9G
         FryVC37nQtaWCY9Z30izzcO51Db5jrT6jQsgluXmFYMHQ+iWQ1ryVcrt2olOUAJxQSrV
         VU7IzTryq2D9WGv7Xjg++BT3OnzaF2d+PjVuPkTjaJCsBrFs3N+IXkASSLXFbiDNJEU2
         aidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782192930; x=1782797730;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JbmeyCeCBW04cw8K6TppsmyFgHsQCkQuuVYDaiK18I0=;
        b=nUV3DjNsWa/ia2i90LLnaqUWvbZRinZcgsde7nG0t8JvGXIq1JDW63Al5J4RNYXpWs
         OEh4hOOV/nxCfxUAxtKudAyzkdc8pc9Z/Ks0PSf4zVMc0UQs6dA31onCHgvMJCWqNimX
         UNJNvvt9An4vLEr1j7VQ/y9h2Qxus3E1/NeGvfyaPWJY3VU9Qsff6fsVKKqzhGR4n3zT
         l4Aw+dz4+n4hRIEqJmV60ynksJXvjYKT6T7Ab+xQkOxOqfhMjRdW+EJiWpfZLHTD/PAA
         IXvFTMVmXGwz8VaxbEXwcu18iPENVPc1xdYu4t4OpLzVyavPRGiTWSRjFyfSvF3G1rpY
         Ns2w==
X-Forwarded-Encrypted: i=1; AFNElJ/sC7CEh3eeck99uANjjb51HQroY6RxMb40/5HIgEE3rvDhJRAvYByTxIhyw3ItkcYrv+AGdkI4drj2g+Y5/m6f@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/HB4OiPO277jBAjMO5ELmQrJoAvsDo7gl02WyY7OPFAtcIGcp
	cXgBCxlGladMHJUnEyE3Hr8kFyCk7tAl0bmc2rVH++Z2TttAcYVGvPa940sptqav99z+CtBrf60
	5eskorPI3ZQ==
X-Received: from pfld2.prod.google.com ([2002:a05:6a00:1982:b0:842:32f6:5738])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9515:b0:822:6830:5900
 with SMTP id d2e1a72fcca58-84550785d61mr17739865b3a.6.1782192929851; Mon, 22
 Jun 2026 22:35:29 -0700 (PDT)
Date: Mon, 22 Jun 2026 22:35:02 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260623053515.2677888-1-irogers@google.com>
Subject: [PATCH v1 00/13] perf python: Fix python extension bugs and memory leaks
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series addresses a number of leaks and python extension bugs
discovered during the review of the python scripting phase 1 refactoring
series.

These fixes have been separated from the scripting changes into their own
dedicated patch series to ease review and integration, as they address
regressions or existing bugs rather than adding new features.

The series breaks down the monolithic python extension fixes into discrete
logical patches addressing validation, initialization, and resource leaks.

Ian Rogers (13):
  perf script: Fix metric_evlist leak in script_find_metrics
  perf stat: Fix evsel_list leak in cmd_stat
  perf top: Fix sb_evlist leak
  perf python: Fix memory leak in pyrf_evlist__get_pollfd
  perf synthetic-events: Fix uninitialized pthread_join
  perf data: Fix directory file descriptor leak in perf_data__switch
  perf test: Fix skiplist leak in cmd_test
  perf python: Check counts_values size in set_values
  perf python: Validate CPU and thread maps in pyrf_evsel__open
  perf python: Validate attribute setters in pyrf_evsel
  perf python: Zero initialize perf_data in pyrf_data__init
  perf python: Add thread uninitialized checks
  perf python: Fix MetricGroup return type in perf.pyi

 tools/perf/builtin-script.c        |   2 +-
 tools/perf/builtin-stat.c          |   9 ++-
 tools/perf/builtin-top.c           |   1 +
 tools/perf/python/perf.pyi         |   4 +-
 tools/perf/tests/builtin-test.c    |   5 +-
 tools/perf/util/data.c             |   3 +-
 tools/perf/util/python.c           | 114 +++++++++++++++++++++++++----
 tools/perf/util/synthetic-events.c |   4 +-
 8 files changed, 116 insertions(+), 26 deletions(-)

-- 
2.55.0.rc0.786.g65d90a0328-goog

