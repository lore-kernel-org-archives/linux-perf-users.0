Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A119836B15
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Oct 2023 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UA0+ynfW"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D1CC9
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Oct 2023 10:56:49 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59c09bcf078so19624537b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Oct 2023 10:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697133409; x=1697738209; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WBYNCwMRWf2j/q/jHdVPvtgHF8EEuq5iigzIRPIKj74=;
        b=UA0+ynfW3kqF8FpfieUTk/yFBWoxAkzVA+DSBD//QT/H3HY8SsUWulcrR/bYvaJDxo
         LKCH/IkD/fevswyvkjFZ9Me3zSljXO9s9JG0DJQYoimj5keNf9N+7oVzEdJWCgbt8/E/
         UWWN/XcAhgwRwNz2Pv0tI74XiiYjTIW/8jAmTnBjsFpt5tTwI0/smjIJdtKIgsc22hUM
         wyEYwg1AquvVWoxb4a69yESAPlVzVvdLMQVCYPdr/nVhFpawpVIkTnAzVYT+DP4FO1yN
         zEILy4Vv+dCcQ4dTI0j1dxUTdSFodrPSKWv8gSiwYHZsHateGcyIOQGofWEIwe+GOESU
         HEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133409; x=1697738209;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WBYNCwMRWf2j/q/jHdVPvtgHF8EEuq5iigzIRPIKj74=;
        b=CWcAYSxvUmAQV0AUmNbY/L2sxChAtMboSdjNXULofgKLPxniPmLw9FkeFHZnQ27fWl
         MSF+QACXrtF+QVF7cqofEOSNqkq/nfSC+bTknoSdkx0jY5vKGngiRoAV0gHgeELBrCay
         3mf8kQosIppaX4H7eOAy0x22HicozR0YIBGeyU+Noq6bbll4AmdhICLy6E4bKf3gmf1j
         /C+12uhToF7cmb+XLVLoK4Yb7dyBOL/jYuXm9D2pnfJkmV7POqgqVonfsF+Jykmjh5zh
         mgy1imTjYAE7bERzNRCGHmIjQJ8AurWojBwrbHy5GfwvdcW2Sh1Uc+HUuo7PeLHplYZ7
         6yrQ==
X-Gm-Message-State: AOJu0Yzj8IJwC+ihpgoCDvvSwdsbcIVk5eKX26b9GaIZu0+SjRz2gTi4
	QGKF0Z68V6kk2de5D1EJc16gyXnUQXSr
X-Google-Smtp-Source: AGHT+IHw+89XI9SqD0f3m9NX2o1w09tj2COvD8HCR0n2aQj6ML6m/aLtOYL6vAFj+X7KkMX5yLAMWHeWEz1n
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6a89:babc:124b:e4e6])
 (user=irogers job=sendgmr) by 2002:a81:bc0d:0:b0:58c:b45f:3e94 with SMTP id
 a13-20020a81bc0d000000b0058cb45f3e94mr498616ywi.8.1697133409197; Thu, 12 Oct
 2023 10:56:49 -0700 (PDT)
Date: Thu, 12 Oct 2023 10:56:38 -0700
Message-Id: <20231012175645.1849503-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Subject: [PATCH v2 0/7] PMU performance improvements
From: Ian Rogers <irogers@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Performance improvements to pmu scanning by holding onto the
event/metric tables for a cpuid (avoid regular expression comparisons)
and by lazily computing the default perf_event_attr for a PMU.

Before
% Running 'internals/pmu-scan' benchmark:
Computing performance of sysfs PMU event scan for 100 times
  Average core PMU scanning took: 251.990 usec (+- 4.009 usec)
  Average PMU scanning took: 3222.460 usec (+- 211.234 usec)
% Running 'internals/pmu-scan' benchmark:
Computing performance of sysfs PMU event scan for 100 times
  Average core PMU scanning took: 260.120 usec (+- 7.905 usec)
  Average PMU scanning took: 3228.995 usec (+- 211.196 usec)
% Running 'internals/pmu-scan' benchmark:
Computing performance of sysfs PMU event scan for 100 times
  Average core PMU scanning took: 252.310 usec (+- 3.980 usec)
  Average PMU scanning took: 3220.675 usec (+- 210.844 usec)

After:
% Running 'internals/pmu-scan' benchmark:
Computing performance of sysfs PMU event scan for 100 times
  Average core PMU scanning took: 28.530 usec (+- 0.602 usec)
  Average PMU scanning took: 275.725 usec (+- 18.253 usec)
% Running 'internals/pmu-scan' benchmark:
Computing performance of sysfs PMU event scan for 100 times
  Average core PMU scanning took: 28.720 usec (+- 0.446 usec)
  Average PMU scanning took: 271.015 usec (+- 18.762 usec)
% Running 'internals/pmu-scan' benchmark:
Computing performance of sysfs PMU event scan for 100 times
  Average core PMU scanning took: 31.040 usec (+- 0.612 usec)
  Average PMU scanning took: 267.340 usec (+- 17.209 usec)

Measuring the pmu-scan benchmark on a Tigerlake laptop: core PMU
scanning is reduced to 11.5% of the previous execution time, all PMU
scanning is reduced to 8.4% of the previous execution time. There is a
4.3% reduction in openat system calls.

v2. Address feedback from Adrian Hunter and Yang Jihong to allow the
    caching to address varying CPUIDs per PMU (currently an ARM64 only
    feature) and to cache when there is no table to return.

Ian Rogers (7):
  perf pmu: Rename perf_pmu__get_default_config to perf_pmu__arch_init
  perf intel-pt: Move PMU initialization from default config code
  perf arm-spe: Move PMU initialization from default config code
  perf pmu: Const-ify file APIs
  perf pmu: Const-ify perf_pmu__config_terms
  perf pmu-events: Remember the perf_events_map for a PMU
  perf pmu: Lazily compute default config

 tools/perf/arch/arm/util/cs-etm.c    |  13 +---
 tools/perf/arch/arm/util/pmu.c       |  10 +--
 tools/perf/arch/arm64/util/arm-spe.c |  48 ++++++------
 tools/perf/arch/s390/util/pmu.c      |   3 +-
 tools/perf/arch/x86/util/intel-pt.c  |  27 +++----
 tools/perf/arch/x86/util/pmu.c       |   6 +-
 tools/perf/pmu-events/jevents.py     | 109 +++++++++++++++++----------
 tools/perf/util/arm-spe.h            |   4 +-
 tools/perf/util/cs-etm.h             |   2 +-
 tools/perf/util/intel-pt.h           |   3 +-
 tools/perf/util/parse-events.c       |  12 +--
 tools/perf/util/pmu.c                |  38 +++++-----
 tools/perf/util/pmu.h                |  22 +++---
 tools/perf/util/python.c             |   2 +-
 14 files changed, 160 insertions(+), 139 deletions(-)

-- 
2.42.0.655.g421f12c284-goog

