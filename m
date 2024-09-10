Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD371188CC1
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Sep 2024 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981420; cv=none; b=mOvo78BC/RIB/eQBgq916k/DP9lbz+CqSDA79HdCafg7xattvq6l7+L6ph68WjiJyFCGopBH4Ejia/YTlnF8oyQCt+HnenOC/ep2riniu13vZH0xHt9PuMDSiPEzQAy/hPWAGqzjKLAICmKFyckj6LI04QxgvbUPh02HiZSj1IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981420; c=relaxed/simple;
	bh=0Il9gUilvXVA/dk9Es4AP9g8H1fSbRkbEK30g8KcdAw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IeHYzDVCt0wJJF+D3ggpWYMw7oddvG1wrwKavxVHhlclLT0zSY2OmO+VmiKkEyOHiATn+Vut2W0IR1NpuqrW5Y41Qo+jz1STexJJpNyyVfxiwGBYeKmQuKYTP80F6yFwSlZiX96N8+6m43p4vOq+K++fjEZTzaFSE3suRn1DSak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tFbGW4jY; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tFbGW4jY"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3780c8d689aso3560253f8f.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Sep 2024 08:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725981416; x=1726586216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r5MBPcCy+Qj+9t27opnhlV5dPMrZLWwOE2W/OYIME0E=;
        b=tFbGW4jYY350Wibep8IAu1ko6r1c/EHexGiNE1K8B7/bjX0T0dh4cEJeaf/SMZbGiZ
         2CeeTDz9Cxli63utnvBaX+ya6sN+0xr76OvQVfKyYss5DhvOAfIFkvGxoVM/+114Rdvm
         Rj9N6w8EDlhvsX8SzKA89Lxb97GV0OhKUKfr4KG3s4tidmJiroQMTiuYNIVuRJ3G3/nC
         OcqDEmDn9FsD31ThdyTAKP5VmJmPdRLdhJ8hY9QF+K4/HeCMSINanRWT+5370MV5JVkp
         fNACAIhK3qYiH7TM1sTJTP8Wjc0yPIiyN0FMTJx2ap3pR0vER2nDlb1+bplrsGF3J4Li
         KA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725981416; x=1726586216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r5MBPcCy+Qj+9t27opnhlV5dPMrZLWwOE2W/OYIME0E=;
        b=bxz/d5LE7woxYddM54m75sJeq8lI6GKF8rYzWS5eJvscUwsl1sWmtQLCUQNv/PTsmC
         nQxicphoE2clWPKVJ82tkUc1jgEYZnLfOJveAankq7XXq6Z5ghvKaCiNUZbDJ0Vn1c2l
         RnjrhAJ6DdyZaehG28qdOzKR7BaddllaBeRz7b0meZsMe4m4juUPaOe+HncTXlPvQ3pa
         jpDCh5cnN0ku+I8kpgvi7ZMjqzCPlCqfjevPQhhrKofpncW97j5GM9S/im+0Q+CJ1iwK
         tXQJ7yKk39fBCYOKU4iYdCTaXiaeeRKC4AwfYOfYcTtMWq8xuobm32QpUxRCHhF+1vOg
         6hkA==
X-Forwarded-Encrypted: i=1; AJvYcCUiXZh2Z0sb8uWnWNzIsnateqR4Uxs/bU3vwzKukRJyfdtrLusTUV6qt108PsIifW3U78njCLZwuZ0tf+tmxP2A@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4IDy+v9UduahD96DFGMPWoa/PRH52SxUMV6oeHPBnZfc+Du4A
	aj6rq2FpjrhfezNiJGkXrZasjHjLrjfuY6VrN17YhhJ4VNl6J92K+cfeagja32Q=
X-Google-Smtp-Source: AGHT+IHKeSKSBm0+rpl/r1FpX1mbk5kM2fP44EaDZRom8BtEbAvMR91fjnKbqy07zPqIhDsFvWdBFg==
X-Received: by 2002:adf:e60c:0:b0:376:27b7:da7d with SMTP id ffacd0b85a97d-378895de69emr9023296f8f.32.1725981415510;
        Tue, 10 Sep 2024 08:16:55 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895665517sm9440844f8f.36.2024.09.10.08.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 08:16:55 -0700 (PDT)
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
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Colin Ian King <colin.i.king@gmail.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	Howard Chu <howardchu95@gmail.com>,
	Ze Gao <zegao2021@gmail.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/7] Event parsing fixes
Date: Tue, 10 Sep 2024 16:16:18 +0100
Message-Id: <20240910151640.907359-1-james.clark@linaro.org>
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
 tools/perf/builtin-stat.c                     | 291 +++++++-----------
 tools/perf/tests/parse-events.c               |   2 +-
 tools/perf/tests/shell/stat.sh                |  37 ++-
 .../perf/tests/shell/test_stat_intel_tpebs.sh |  11 +-
 tools/perf/util/evlist.c                      |  46 +--
 tools/perf/util/evlist.h                      |  12 -
 tools/perf/util/evsel.c                       |  28 +-
 tools/perf/util/evsel.h                       |  22 +-
 tools/perf/util/metricgroup.c                 |   4 +-
 tools/perf/util/parse-events.c                |  57 ++--
 tools/perf/util/parse-events.h                |   8 +-
 tools/perf/util/parse-events.y                |   2 +-
 tools/perf/util/pmu.c                         |   6 +-
 tools/perf/util/pmu.h                         |   2 +-
 tools/perf/util/stat-display.c                | 109 +++++--
 tools/perf/util/stat-shadow.c                 |  14 +-
 tools/perf/util/stat.c                        |   2 +-
 21 files changed, 359 insertions(+), 413 deletions(-)

-- 
2.34.1

