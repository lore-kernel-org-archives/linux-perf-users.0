Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D785338D
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727362154; cv=none; b=BKcuUoU8Gf7XNmum3gTXltlMCgirmAS3BEwwEigh/J8p2zJP9OfV4az+hbcbLDkxwKqGkycs5pWmGhflf+Zfsqjs4wG1/dsDcsR/p9XBYgz4lc3ixf44a32eKG2v4R23AQ40r1kUNY7mHtDcoPp9uYH3gbguE8nypK8BQ85Ssao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727362154; c=relaxed/simple;
	bh=OSGnjJWD2AUBP6nI/tMbL5fnjDrNC3+r3I4DIEtTgjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g60FAzoe3Jx0s5KZUWc0NATTooYOI35JAuBE7/znHEmwyCPAeiRaGwLpMR5NPHHozX42vEemOe9lzMpcXKMEpG5g4e7zbfEQIRnvtxCHUYORMM4xPL0M0oydl5ZXanJnlAjGKzP3+flsYDoUgDnFe/Z8wY9hOXWA61fjpRqlyQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zjfub3xD; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zjfub3xD"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c3d20eed0bso1194827a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 07:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727362150; x=1727966950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/nmo5sfzFJvh03XPWULjDAkriT3KqgWW1PyKr3ieQ8E=;
        b=Zjfub3xDLVwsPxCVtUBlN9PtOwFkf/3Ab4ki7gbbcniEvFQPvTn//qoCJ7lgL8HE3e
         jnfgalqHrOSCSrrO3FsVU/5jf9XWdWErjjWZsZzpsez9M5MwsBJIcba4YvpdF/KtNCI5
         gIR6jbRvD5I1ij1x8She+RLAYk4tqnZAPBhoO/vvxGb8h8gaiI1P4l30/9ipUxUz+kiS
         0biK7ke0yc8uVI6yZXVxM5DIoSdUF01fTap3+mbt8VoRGHH6z/S9nXz++nEr26D3pErc
         NIr1ttyJyizmdXeBRV7HL9RAPlmqXwFhIS61xbABQI1WpM+/T1PvQguJW1qmbJylgwfP
         4ZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727362150; x=1727966950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/nmo5sfzFJvh03XPWULjDAkriT3KqgWW1PyKr3ieQ8E=;
        b=iRhSMtk7QX/ajLlEBaSt9iGJLsW++Q+iYRmmAu5ATvrM2E+hHDIuGYS+nCLEG9MBoo
         a2yEhMFQSlLLEVWHZgMHFdUdoA3lXDbkFA/CaYLvWVIZbEWBbKyNxVItu/tLnNiQrgCY
         UHgHByV2vvQquHv1Cs+b5+ySrbpivhESFuQjbspq+N47K2Sl/2eLxzn0J29qzRKIfw3Y
         BR32teSEptZjasLHbHLo/LLDDiIpetJUfwTHV+nlaGvD1is87Uw5wPJQ1YkzUwlMEI8h
         qJa0UAJ2WpyilOlQkYIJmRDAbdfD1/xXsfdx0rr8X8SfhSE1tj0O2zEdV8+jEpKwS6j6
         xbGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXtmhZBiTt26jy14d31pGsSB+VXi8SovSEGpiI6PQ+0yn1BVkxEe4xSAaHfRiS3ZmXjX2O39+P2o3yfhlGyXqr@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq+a4qJwdd6VZIF/uFpe+3ehfuvcwWp6qrGBK4IBc1sPmKY1mC
	E+U9INY66RXqD29ODdawtqe4FThfBA8G90CWmKQ+tbKllw6cjJ/o8JgLon7YJyE=
X-Google-Smtp-Source: AGHT+IEEXyvhJCDptdkfXlYuLzjr9lZI+o2LHFX4/RBpRoo60JvvnSuQQ77087WzgbwG59bASlVU1g==
X-Received: by 2002:a17:906:dc8f:b0:a86:83f8:f5a2 with SMTP id a640c23a62f3a-a93a038c991mr608490966b.19.1727362150042;
        Thu, 26 Sep 2024 07:49:10 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c294833asm5589966b.98.2024.09.26.07.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 07:49:09 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: irogers@google.com,
	linux-perf-users@vger.kernel.org,
	kan.liang@linux.intel.com,
	ak@linux.intel.com,
	namhyung@kernel.org
Cc: James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Howard Chu <howardchu95@gmail.com>,
	Ze Gao <zegao2021@gmail.com>,
	Yanteng Si <siyanteng@loongson.cn>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 0/7] Event parsing fixes
Date: Thu, 26 Sep 2024 15:48:31 +0100
Message-Id: <20240926144851.245903-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I rebased this one and made some other fixes so that I could test it,
so I thought I'd repost it here in case it's helpful. I also added a
new test.

But for the testing it all looks ok.

There is one small difference where it now hides _all_ default
<not supported> events, when previously it would only hide some
selected subset of events like "stalled-cycles-frontend". I think
this is now more consistent across platforms because, for example,
Apple M only has cycles and instructions, and the rest of the
default events would always show as <not supported> there.

Tested on Raptor Lake, Kaby Lake, Juno, N1, Ampere (with the DSU
cycles PMU) and I also faked an Apple M on Juno. 

Changes since v8:
  * Fix rebase by adding NULL check before perf_pmu__is_fake()
  * Keep 'cycles' default event as non-skippable so permissions
    errors are shown

Changes since v7:
  * Resolve conflicts and rebase onto perf-tools-next 1de5b5dcb835
  * Fix build error by using the new perf_pmu__is_fake()

Changes since v6:
  * Fix empty PMU name in perf report
  * Rebase onto perf-tools-next 003265bb6f02

Changes since v5:
  * Test on x86 non hybrid
  * Assume 1 PMU in the test when no PMUs expose /cpus file

Changes since v4:
  * Hide all <not supported> default events when not verbose
  * Remove previous note about <not supported> behavior from the cover
    letter and replace it with a new note about the new behavior
 
Changes since v3:
  * Rebase onto perf-tools-next 6236ebe07
  * Fix Intel TPEBS counting mode test
  * Fix arm-spe build
  * Add support for DT devices in stat test
  * Add a new test for hybrid perf stat default arguments

Ian Rogers (5):
  perf evsel: Add alternate_hw_config and use in evsel__match
  perf stat: Uniquify event name improvements
  perf stat: Remove evlist__add_default_attrs use strings
  perf evsel x86: Make evsel__has_perf_metrics work for legacy events
  perf evsel: Remove pmu_name

James Clark (2):
  perf test: Make stat test work on DT devices
  perf test: Add a test for default perf stat command

 tools/perf/arch/arm64/util/arm-spe.c          |   4 +-
 tools/perf/arch/x86/util/evlist.c             |  74 +----
 tools/perf/arch/x86/util/evsel.c              |  35 ++-
 tools/perf/builtin-diff.c                     |   6 +-
 tools/perf/builtin-stat.c                     | 297 +++++++-----------
 tools/perf/tests/parse-events.c               |   2 +-
 tools/perf/tests/shell/stat.sh                |  37 ++-
 .../perf/tests/shell/test_stat_intel_tpebs.sh |  11 +-
 tools/perf/util/evlist.c                      |  46 +--
 tools/perf/util/evlist.h                      |  12 -
 tools/perf/util/evsel.c                       |  28 +-
 tools/perf/util/evsel.h                       |  22 +-
 tools/perf/util/metricgroup.c                 |   4 +-
 tools/perf/util/parse-events.c                |  60 ++--
 tools/perf/util/parse-events.h                |   8 +-
 tools/perf/util/parse-events.y                |   2 +-
 tools/perf/util/pmu.c                         |   8 +-
 tools/perf/util/pmu.h                         |   3 +-
 tools/perf/util/stat-display.c                | 109 +++++--
 tools/perf/util/stat-shadow.c                 |  14 +-
 tools/perf/util/stat.c                        |   2 +-
 21 files changed, 369 insertions(+), 415 deletions(-)

-- 
2.34.1

