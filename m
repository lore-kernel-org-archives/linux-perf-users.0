Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC12B1624E9
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Apr 2025 17:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652518; cv=none; b=TMf5HKln72Cw9NV8qCXvKPck2pDUqlBsQWo6A2yy39nxIFffu7SXKnJi78Kg0P3G+fGHbaQNDcpCs9H5wsOUaOEJ2nwsSqgdaIaS32PuI10CeSnzA2349pvUr0HymCBJapZeTUMpYBBmzc9M7tENTrK+5WNfgIHF0+9KwHj1K1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652518; c=relaxed/simple;
	bh=FdG+8kzfFYHqzK1gCSiNFkpWhlnOXiLti0wHwDLG0v8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=TG30ofbMDBRL9geMH+W7avW13KrG+yWlOFlj98pXEyNtss+9ect6nTO54cU1T+bYLMCydKwu40ECW9U6dybauiT5U6UnFM2LPdJTHTHtky3BE1NNwVCBypUDe4tBlVtB99Qvs9/8jNYPlat+QovJskYT4xKrWN42DDOYht+r7XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XU2LCflb; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XU2LCflb"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2240c997059so53064905ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Apr 2025 10:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744652516; x=1745257316; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o/iAnNtGFU1pfVKBc4OFpKhZxlOH2dBXm9EvHilUe0A=;
        b=XU2LCflbBol/Kif+4ASuldCTaWr86MYmF5c5ziyNswHiWvTD/uWx9iQK9QKGOY+m71
         vT0ICeefD2rqwrQCGiORllUn0qwbuB2o7K4fJyIUHRoY6lzU8vCkIu+VH8yxJRPFbWb7
         aTUeDd9niS9wWjQx4FeQytge0DL2wpge5VyNDiR+QXoIWoNyUD6pzR6rS/TFM5911p4i
         AsNschjLe+af2hYstPISyKatFnEhn5Aao8jaL0BNqa4e41Jb40QdD8KG0EDMvesVB8b9
         tOBcYTQG1DlHfLd14I55EF9zV5cH+oKVIqmTi6bK8hb06dmMoH9Ss4mRT4NxBV9GWWvt
         1/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744652516; x=1745257316;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o/iAnNtGFU1pfVKBc4OFpKhZxlOH2dBXm9EvHilUe0A=;
        b=M9+nFZb/KyaFTCv4WX347r/Ml+jECEAZtJlx1Zuu+QN8HZcFUKIsDrRMFr0nnCJOW/
         FE5lmU7Y3w+cC71UFrTCRKCXJIOSnlA2sYLOfgDK6thTakl3sau3BQ33vLgF3yRoOLsy
         n8YxVjY9b2YtvxODX+BNYy8jQiMXtILg2yzpF6IDmralDsBRPEnpLicnufujWjjiJZIV
         wPgkN1lIuUIRinHLMWp0vY3T2K3vs+zDUcQlBNt2F8S8sXDS+90Eqmb56uXHKWDmyfF4
         IRf5VDE9/nClg+p/S4ocyGR8R0c9RVMA9sUVmIC/ZZKILnHjHEl/3sQ3PZjijozQBk3s
         HMcA==
X-Forwarded-Encrypted: i=1; AJvYcCV8I/fHFwPgxN9w8rQEHIQNOMdAutVAZyOKo2Dh6MaH180/d1NzHmdCxNon86CQ/C24rZve4ceMKkxAGISOE+pC@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4rhgOwFVw0fm4h2WsWBWn8PurOeO2sC+pH6b4gAeKEdInd9RW
	dnVw/f0SgGHx7YBU78w3HeUvZOUEyNt/YvqfUMtaeqMEX6wjU7dSno2mcbL2traNF2DPjSvlBfX
	4gAVtGQ==
X-Google-Smtp-Source: AGHT+IHDcITR5PoegvS4RYgxchOZRV7BwitRhcZsOBedy51KkpAuKBXIfhivEvYmWe/m8t2BkhS9eXfgnlgN
X-Received: from plgz6.prod.google.com ([2002:a17:903:186:b0:223:4788:2e83])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:8d0:b0:216:3d72:1712
 with SMTP id d9443c01a7336-22bea4fcfd6mr195972475ad.48.1744652515989; Mon, 14
 Apr 2025 10:41:55 -0700 (PDT)
Date: Mon, 14 Apr 2025 10:41:18 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250414174134.3095492-1-irogers@google.com>
Subject: [PATCH v5 00/16] Intel TPEBS min/max/mean/last support
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

The patches add support to computing the min, max, mean or last
retirement latency and then using that value as the basis for metrics.
When values aren't available, support is added to use the retirement
latency as recorded for an event in the perf json.

Support is added for reading the retirement latency from the forked
perf command more than once. To avoid killing the process commands are
sent through the control fd. Some name handling is changed to make it
more robust.

Rather than retirement latency events having issues with perf record,
make it so that the retirement latency modifier enables sample
weights.

Note: the retirement latency JSON updates are part of:
https://lore.kernel.org/lkml/20250328175006.43110-1-irogers@google.com/

v5: Add Namhyung and Weilin's tags. Fix missing error path mutex
    unlock spotted by Namhyung.

v4: Don't use json min/max in retirement latency stats as they will
    never update afterwards. Warn once if json data is used when TPEBS
    recording was requested.

v3: Two fixes from Kan Liang. Ensure min/max statistics don't vary
    when real samples are encountered.

v2: Addition of header cleanup patch originally posted:
    https://lore.kernel.org/lkml/20241210191823.612631-1-irogers@google.com/
    as there are no arch specific reasons not to build this code.
    Fix bug in "perf pmu-events: Add retirement latency to JSON events
    inside of perf" where "t->stats.n != 0" should have been
    "t->stats.n == 0".
    Add patch so that perf record of a retirement latency event
    doesn't crash but instead enables sample weights for the event.

Ian Rogers (16):
  perf intel-tpebs: Cleanup header
  perf intel-tpebs: Simplify tpebs_cmd
  perf intel-tpebs: Rename tpebs_start to evsel__tpebs_open
  perf intel-tpebs: Separate evsel__tpebs_prepare out of
    evsel__tpebs_open
  perf intel-tpebs: Move cpumap_buf out of evsel__tpebs_open
  perf intel-tpebs: Reduce scope of tpebs_events_size
  perf intel-tpebs: Inline get_perf_record_args
  perf intel-tpebs: Ensure events are opened, factor out finding
  perf intel-tpebs: Refactor tpebs_results list
  perf intel-tpebs: Add support for updating counts in evsel__tpebs_read
  perf intel-tpebs: Add mutex for tpebs_results
  perf intel-tpebs: Don't close record on read
  perf intel-tpebs: Use stats for retirement latency statistics
  perf stat: Add mean, min, max and last --tpebs-mode options
  perf pmu-events: Add retirement latency to JSON events inside of perf
  perf record: Retirement latency cleanup in evsel__config

 tools/perf/Documentation/perf-stat.txt   |   7 +
 tools/perf/builtin-stat.c                |  29 +-
 tools/perf/pmu-events/empty-pmu-events.c | 216 +++----
 tools/perf/pmu-events/jevents.py         |   6 +
 tools/perf/pmu-events/pmu-events.h       |   3 +
 tools/perf/util/Build                    |   2 +-
 tools/perf/util/evlist.c                 |   1 -
 tools/perf/util/evsel.c                  |  22 +-
 tools/perf/util/evsel.h                  |   6 +
 tools/perf/util/intel-tpebs.c            | 682 ++++++++++++++---------
 tools/perf/util/intel-tpebs.h            |  40 +-
 tools/perf/util/parse-events.c           |   4 +
 tools/perf/util/pmu.c                    |  52 +-
 tools/perf/util/pmu.h                    |   3 +
 14 files changed, 666 insertions(+), 407 deletions(-)

-- 
2.49.0.604.gff1f9ca942-goog

