Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355291509B9
	for <linux-perf-users@vger.kernel.org>; Fri, 10 May 2024 05:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715319486; cv=none; b=ij0VejOnVuiQj5su0IdlhdMZg37986ibZU1zbCZXmHuhjJKzq3B6Di6G5WB+lgMz5NyrFTjJ+fZIfZHnohTIwcKrhwd/mlGXRSNuT/EeHhBV2/IFCurNmvCehKrsyy89HBDoMY+UOIJeEpjOXcd793wB9ZXRDwMR4MG3p/e26Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715319486; c=relaxed/simple;
	bh=slEtYCfWIhr8biE7XSNhRtKBTqVpKRtQjsG53b28TGU=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=Of4KiHuiOtAMhgtGV44nzS7Dw43NfpzK8JbC3Sv1rw4BiQGt9+OZqplIVJgIX2hPtoZHM9E86vK7utX+FeSypSMwjkclshucZTig2SmotyKS3RIj1nSnrOzGPpxm414LGryzBezhDondb4RFIdpfXdeYD0OYv/jdHvJEtolydxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ow318hcG; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ow318hcG"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61c9e36888bso28274097b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 09 May 2024 22:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715319484; x=1715924284; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qRnQ9X+E01Wjh7aw9HSdFUGOAwjIttVy/fHoTKboCKE=;
        b=Ow318hcGE76bjHwuZ1cHYKjCwPN4+zd7KVCAhcM7YHnO8uV7gASY5Zw1mCnAKnhdv0
         3H7qBfxR1wepkKAIMtbSPmQdmuAvViXR/HcXkO09rLS+q/8cFW0NunBfnDPrWXrypLvo
         ofDM9Uqhe3zUjjBdU5QPSw+0IPZKqb5KHOxkHEZ9Z2bvHXPiR1OlyxsajE59kaX67xjY
         7v3ZPRIHgsdL4d7zCdFW/qRzR0XGUUm6lJ/Xtyi4rI12mCZvi1vgsO0T4vV5nIi62IY2
         eoAP0XuEclknqF5GSr0pTNlLQnUerZie2TnqbgWVIt6z4pv267dPxI+K5MZwx4okvYCN
         GIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715319484; x=1715924284;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qRnQ9X+E01Wjh7aw9HSdFUGOAwjIttVy/fHoTKboCKE=;
        b=dSZhrm4kA7ym3m50TWFU9hAGSRtw7r7ikynDk4+6wZk31GaRfbqBii+4hh0+I5PoWD
         39pIFlB1DK8jLcy5iM9IVbCpRsywKFwDDauiQxXUyzsWQPROrvmKKKU8vsfHVGWJAY4q
         P8ge83h4nRK4m9WfKr3+02qBinUfoO/pNzdTKGz1FKLWL1y8LXD4HlPwtgMtQUbHr+Hl
         3EBq14AEbfaE6oxIhVDW9AjN9wpJ6ITpsG71HbVOqDavcV3IcfeLsUT+8mCsvTnZ06yy
         gIPOqPg2kWhn+QcwN9c65L3HTOCfweKA5NFlVbBJVgcqEju6zyKkSD1QwtNJ9E+yltNQ
         WhQw==
X-Forwarded-Encrypted: i=1; AJvYcCUZsPZrWnt+AiUuh/SbPYH0kK1d+nyvMbEjUNS3DO4GHCckvAPPtaRKQRO6RebOpvfNIIriEDY2Puq4q8gzjtK1AEq2hwFKDLHmRiAWIDeFSQ==
X-Gm-Message-State: AOJu0YzAGnVom0Rleju1IJOfps20UlwUojER/71+f7oYwqVuTmv38D5k
	3d3BTw2opY+9QN9EEFlt/pXlNx0fFpVwIFjlvD1hM4/C9i10Ogpmz+Y2deSVxdJQjUDJZFylCBE
	3jpr5Mw==
X-Google-Smtp-Source: AGHT+IHWovI0a7yoCvT5NcytTQIcFejcvg0GmjVsmKX73kR7VrRBxxnVvHZPNfZGC+BVlbbGbJyzwZO3vTwK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:79ed:c375:51e3:ed39])
 (user=irogers job=sendgmr) by 2002:a25:aa4a:0:b0:de5:1ea2:fc6f with SMTP id
 3f1490d57ef6-dee4f1962e3mr96944276.6.1715319484195; Thu, 09 May 2024 22:38:04
 -0700 (PDT)
Date: Thu,  9 May 2024 22:37:00 -0700
Message-Id: <20240510053705.2462258-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Subject: [PATCH v3 0/5] Event parsing fixes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@arm.com>, Yang Jihong <yangjihong@bytedance.com>, 
	Ze Gao <zegao2021@gmail.com>, Leo Yan <leo.yan@linux.dev>, Song Liu <song@kernel.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Kaige Ye <ye@kaige.org>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For the default events, parse from strings rather than use pre-cooked
perf_event_attr. This fixes non-x86 heterogeneous CPUs where legacy
hardware events wouldn't be opened for all PMUs. v2 was previously
just patch 3 but it is extended in v3 to incorporate related fixes.

When a sysfs/json event is used in preference to a legacy event, allow
evsel__match to still function using a saved hardware config
number. This fixes hard coded metrics in stat-shadow for events like
"instructions" on Intel that have a sysfs file.

Fix/improve uniquifying event names fixing the test "102: perf stat
metrics (shadow stat) test:" that was broken by a formatting issue
when the sysfs instructions event was used.

Having evsel->pmu_name and evsel->pmu->name is confusing, get rid of
the former. Fix/improve evsel__sys_has_perf_metrics in the process.

Ian Rogers (5):
  perf evsel: Add alternate_hw_config and use in evsel__match
  perf stat: Uniquify event name improvements
  perf stat: Remove evlist__add_default_attrs use strings
  perf evsel x86: Make evsel__has_perf_metrics work for legacy events
  perf evsel: Remove pmu_name

 tools/perf/arch/x86/util/evlist.c |  74 +-------
 tools/perf/arch/x86/util/evsel.c  |  35 +++-
 tools/perf/builtin-diff.c         |   6 +-
 tools/perf/builtin-stat.c         | 291 ++++++++++++------------------
 tools/perf/tests/parse-events.c   |   2 +-
 tools/perf/util/evlist.c          |  46 +----
 tools/perf/util/evlist.h          |  12 --
 tools/perf/util/evsel.c           |  28 ++-
 tools/perf/util/evsel.h           |  22 +--
 tools/perf/util/metricgroup.c     |   4 +-
 tools/perf/util/parse-events.c    |  52 ++++--
 tools/perf/util/parse-events.h    |   6 +
 tools/perf/util/pmu.c             |   6 +-
 tools/perf/util/pmu.h             |   2 +-
 tools/perf/util/stat-display.c    | 101 ++++++++---
 tools/perf/util/stat-shadow.c     |  14 +-
 tools/perf/util/stat.c            |   2 +-
 17 files changed, 305 insertions(+), 398 deletions(-)

-- 
2.45.0.118.g7fe29c98d7-goog

