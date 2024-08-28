Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E85113BAC3
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724854083; cv=none; b=Sy5+inKHEIchl4NizZpDn8xZryUPLRR/HJsJu4FhuyUWPphX3I1g2nzhUZf0gwdBo9tm4cGwbhwdZW+/uhUD4Ljh0CG7EuARNpKj+FrXs+1pF79AfQ6gi084+ZoTY1WFuNwO1gnALa20411YevUOj3lK6KHZmYQ0kD5limNAymg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724854083; c=relaxed/simple;
	bh=4xE/vzrw3jJwfmxRQTphStFe7kpYvfTa09+FdtD4X0U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DERyJDoahWTf95qye0P8UXvL43rYquPjyUiSO+ta2Q8dONTAXub0C8RKLSFc3l9gXSvgnXOy+FtmS+9SdXU/EYnx4aiaTp6PS54ZWFtmqiM6xbIVOiupEHZRJ7HbM44H8ddaubHpSF4czdJ0BnGOMVcKcS5IUm56G0doNIv63Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yZaZQ4CT; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yZaZQ4CT"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a866cea40c4so775874066b.0
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 07:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724854080; x=1725458880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5aAwIVJgVIh1Hv8hW6DlJQ9xqCzcxOReEhk3tFKI30U=;
        b=yZaZQ4CTACX1VlFrjY6HMvytN0DdXUUgzz2/HtKCuDmiuP3DXn0mvw8N4hby1ii6iS
         8I2VDKYwvevKuJrybcG06V62TlRI+9jgG0maFuqImWk6fu9FVaUXdyFfzmXj1Q22iRLA
         B5BP6nL/Or9e1c88GgRWwRkaN8SuLx3mEdtNZAfOtQS7V2/FL195TXGUr0l1XMcc4YAQ
         3KdRLyRgL4DOOjJ+wWZYGPP4UQ8JGDO2QenjQiBW61pVyOIbfbMgnIgSOrFXFbyRC8Xq
         wKctHG5kmirJgPlq+s/FGKzjkXI1+FJL7Pw8OY5emyLGAcdFPaJA/U1ELQ7Nhw3XOw7e
         n1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724854080; x=1725458880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5aAwIVJgVIh1Hv8hW6DlJQ9xqCzcxOReEhk3tFKI30U=;
        b=VP3Au391pbqW3GIimtlyXfuLoXvCpvEfXQzIX4k8dFXa0bs9oZeQ0PNcm5YtqbRYDE
         jcHr/KnOvUEe9n5HfFUdgefXkFIYdOFtbauSG9u1w4f08eEVKDDiRT6YaSO74waTPdc7
         w8+l44ZL7VAs3DPxgiE4BbKx04iBF20HLbEumT+z1I1+2flosi2+te8wqZguFy+aG1iK
         qQz1+ecfqBcVddTHDdWw2bHX6SkASQAoBD75vikHqBpKG0P6A1J36TxeSmm2JBtVTvFN
         NQjjFyyziaiVJWId5Xv5uL0DAZ1Kg3mgG0tq/wrOS9XE+htSR2PVhepyy4F/dQACA/xh
         y94g==
X-Forwarded-Encrypted: i=1; AJvYcCWRrJmVB8RbA9F7kMH55gcWLunPINFnq1lI8D9gsujAvH8/vMTbZdtwBa0x8MU5QvezhhN+sQsMKP7c2GJ9z51u@vger.kernel.org
X-Gm-Message-State: AOJu0YyTzshtOVY1L39IWNsOna6rpSioNe2xC6hmXbWS1RCBhtvunAYN
	0H04+G3HJNZWX3xhXukHr21inCIkba6pgOC/SZ+OJRpbwJ56fKdkS4/Id7bDTOU=
X-Google-Smtp-Source: AGHT+IEoC5n0vdz3tJYOdnNb4XTomlnmxEipp/sr7m19JHJooP7z4Rm7SltooV8l5QLlj4Ott0pVNQ==
X-Received: by 2002:a17:907:1b1e:b0:a86:e9ab:f6c6 with SMTP id a640c23a62f3a-a86e9abfe01mr432673066b.68.1724854079782;
        Wed, 28 Aug 2024 07:07:59 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e5832855sm251302666b.130.2024.08.28.07.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 07:07:59 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: irogers@google.com,
	linux-perf-users@vger.kernel.org,
	kan.liang@linux.intel.com,
	ak@linux.intel.com
Cc: James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Jihong <yangjihong@bytedance.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Ze Gao <zegao2021@gmail.com>,
	Yunseong Kim <yskelg@gmail.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/7] Event parsing fixes
Date: Wed, 28 Aug 2024 15:07:14 +0100
Message-Id: <20240828140736.156703-1-james.clark@linaro.org>
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

There is one small difference where it now hides _all_ <not supported>
events, when previously it would only hide some selected subset of
events like "stalled-cycles-frontend". I think this is now more
consistent across platforms because, for example, Apple M only has
cycles and instructions, and the rest of the default events would
always show as <not supported> there.

Tested on Raptor Lake, Juno, N1, Ampere (with the DSU cycles PMU) and
I also faked an Apple M on Juno. 

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
 tools/perf/tests/shell/stat.sh                |  33 +-
 .../perf/tests/shell/test_stat_intel_tpebs.sh |  11 +-
 tools/perf/util/evlist.c                      |  46 +--
 tools/perf/util/evlist.h                      |  12 -
 tools/perf/util/evsel.c                       |  28 +-
 tools/perf/util/evsel.h                       |  22 +-
 tools/perf/util/metricgroup.c                 |   4 +-
 tools/perf/util/parse-events.c                |  58 ++--
 tools/perf/util/parse-events.h                |   8 +-
 tools/perf/util/parse-events.y                |   2 +-
 tools/perf/util/pmu.c                         |   6 +-
 tools/perf/util/pmu.h                         |   2 +-
 tools/perf/util/stat-display.c                | 109 +++++--
 tools/perf/util/stat-shadow.c                 |  14 +-
 tools/perf/util/stat.c                        |   2 +-
 21 files changed, 356 insertions(+), 413 deletions(-)

-- 
2.34.1

