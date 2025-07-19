Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B3E216E1B
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Jul 2025 03:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752896727; cv=none; b=gewp8rE69crReGzZdFEFmZmUS+hhnadikXaD1uROmZZDZr6zZo4RNZdS0BhRcCHvTzAmknSuY4LS1UjuANH7OPnvDviab7zGxQCGYRyeWMFr2ptVnPigHifd/15u8MN3EEImOXPeeeVX5EOofC+tnB10QFFMl/OrAFFfZ8UxGDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752896727; c=relaxed/simple;
	bh=4sPNJohyZiSaP6bVdNUZSFtFW0sP5pkTkymnqX8jPwQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=W+4ldLmnO/WmxR/3K58/VowI53vt7pMRq3Lji7W+zDM5S2+9IHGnQBf7xXEVXXInne+XdxMoZuipcZjgtRQyMvKiBMT7+k9oWzFDE1J0lIVR4JLmsmb+LJ5crAYPyo9/uaBILodKmHjB2BLH0Fd6psFMspEPpv/Ye26gqVBw57Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uEta7Ds5; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uEta7Ds5"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2356ce55d33so44786635ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Jul 2025 20:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752896725; x=1753501525; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WqiLWeTfwca+ZCiVwfRlVuUMX0C/baa/Iki7LyO/m5k=;
        b=uEta7Ds5bhZ8eBw28Ly/pZX5MugsJdNsg9Ed73F+UTCsvO2lcCAZAmeQ/CKDBe8xmG
         2FYds+DmTeQgk7lIiGPrvQxVLnrL++zFJCWsB3TT7Rrvbm1NrUc/1MQ4cJEeFyLytZUg
         /J67ptV04BjAjjttXaDBYrjKpiVH7gNreKGoGdLF5D2DxF9GXK/jsCaNLMtBTj+e95xk
         5S5ApZlDB27t8tx+CXONmfvXOP7JS6kIXZDSjKvuanUbgKtWwcoNH5MTHH7zIQybeHc/
         FPehmdtu3Rrh9nKQqu+yoxTqCJvys0jEwaUcPco9Coob7SieyptyY+k/4FO0JMcp6IF5
         m3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752896725; x=1753501525;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WqiLWeTfwca+ZCiVwfRlVuUMX0C/baa/Iki7LyO/m5k=;
        b=U+Tgy2Iksh/3O57C2JIOZF8YgUGmbLKfBTT3PGWEP8ln9G4HIiH+sUhELVdv45bKb9
         5flDnWwvQKdGshKFLBRKL9RYgVMCoeNZZ6H1sms6y7G1RB/+MXZcEKu2ciB45/WOZSVy
         9ZBJga5KRkDfE/tLhAXcpwnjSVxMBqi+qDbo5IEr8qPGa9uMl82ny7KdvOdnCX/3XgA9
         B/fRKZtS9cYhXFquPTXXbqcBoYeVqF0mJKV7ZDpD9dmz7jNrbhykfcGFAciVaQjW2Kki
         2jLw+wN7k2GFF2nm1cH+MkuKIQqofSwTlExlRdB1DWXTTqZ04OEIIV4WHx+rHTJBpq8s
         u2yw==
X-Forwarded-Encrypted: i=1; AJvYcCUhvNp1mrEgf5qnHtVOYE/CNuLqVddLrCInWngotqfj6FKkJWJrdPoDKWUsfeQJzmk6uYbJWxx2RjvHUg0KoezB@vger.kernel.org
X-Gm-Message-State: AOJu0YwWXbhVh2SFPsL/udX9iAfwXvbJ477DVbKFxUZWAWu1K8136Gnw
	xawkKMrXJ5sqdVrSzMXg1yCuGO4JE8Jl+1bMz/Vk9T/pYB+y5iPQ0rC5Q7WKfjuhfNmSeAro9W4
	pvgFud4ytwA==
X-Google-Smtp-Source: AGHT+IHOdI8T6cUx74r7dZ/PvCczYxC1VCDvNVPBQLTqMZoVUSnomyHJted7sh7Fd5TYTJMr/OnALNl7AWMj
X-Received: from plbkh3.prod.google.com ([2002:a17:903:643:b0:236:945a:3454])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf0f:b0:23e:277b:b921
 with SMTP id d9443c01a7336-23e3035f774mr127637705ad.42.1752896725602; Fri, 18
 Jul 2025 20:45:25 -0700 (PDT)
Date: Fri, 18 Jul 2025 20:44:56 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250719034515.2000467-1-irogers@google.com>
Subject: [PATCH v1 00/19] Intel TMA 5.1 metrics and event updates
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-actions@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Update events from:
v1.31 -> v1.33 for alderlake
v1.09 -> v1.12 for arrowlake
v1.14 -> v1.16 for emeraldrapids
v1.10 -> v1.12 for graniterpaids
v1.14 -> v1.17 for lunarlake
v1.14 -> v1.16 for meteorlake
v1.28 -> v1.30 for sapphirerapids

Update TMA 5.0 to 5.1 removing the slots event workaround as the patch series:
https://lore.kernel.org/lkml/20250719030517.1990983-1-irogers@google.com/
is assumed.

The patches are generated by:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
with pull requests 323 and 324 applied.

Ian Rogers (19):
  perf vendor events: Update alderlake events/metrics
  perf vendor events: Update arrowlake events/metrics
  perf vendor events: Update broadwell metrics
  perf vendor events: Update cascadelakex metrics
  perf vendor events: Update emeraldrapids events/metrics
  perf vendor events: Update grandridge metrics
  perf vendor events: Update graniterapids events/metrics
  perf vendor events: Update haswell metrics
  perf vendor events: Update icelake metrics
  perf vendor events: Update ivybridge/ivytown metrics
  perf vendor events: Update jaketown metrics
  perf vendor events: Update lunarlake events/metrics
  perf vendor events: Update meteorlake events/metrics
  perf vendor events: Update rocketlake metrics
  perf vendor events: Update sandybridge metrics
  perf vendor events: Update sapphirerapids events/metrics
  perf vendor events: Update sierraforest metrics
  perf vendor events: Update skylake metrics
  perf vendor events: Update tigerlake metrics

 .../arch/x86/alderlake/adl-metrics.json       | 104 ++++----
 .../pmu-events/arch/x86/alderlake/cache.json  |  99 ++++----
 .../arch/x86/alderlake/floating-point.json    |  28 +--
 .../arch/x86/alderlake/frontend.json          |  42 ++--
 .../pmu-events/arch/x86/alderlake/memory.json |  12 +-
 .../pmu-events/arch/x86/alderlake/other.json  |   8 +-
 .../arch/x86/alderlake/pipeline.json          | 163 +++++--------
 .../x86/alderlake/uncore-interconnect.json    |   2 -
 .../arch/x86/alderlake/virtual-memory.json    |  40 +--
 .../arch/x86/alderlaken/adln-metrics.json     |  20 +-
 .../x86/alderlaken/uncore-interconnect.json   |   2 -
 .../arch/x86/arrowlake/arl-metrics.json       | 180 ++++++++------
 .../pmu-events/arch/x86/arrowlake/cache.json  | 122 +++++++---
 .../arch/x86/arrowlake/frontend.json          |  40 +--
 .../pmu-events/arch/x86/arrowlake/memory.json |  22 +-
 .../arch/x86/arrowlake/pipeline.json          |  94 +++++---
 .../arch/x86/broadwell/bdw-metrics.json       |  30 +--
 .../arch/x86/broadwellde/bdwde-metrics.json   |  30 +--
 .../arch/x86/broadwellx/bdx-metrics.json      |  33 ++-
 .../arch/x86/cascadelakex/clx-metrics.json    | 139 ++++++++---
 .../arch/x86/emeraldrapids/cache.json         | 100 ++++----
 .../arch/x86/emeraldrapids/emr-metrics.json   | 131 +++++-----
 .../x86/emeraldrapids/floating-point.json     |  43 ++--
 .../arch/x86/emeraldrapids/frontend.json      |  42 ++--
 .../arch/x86/emeraldrapids/memory.json        |  30 +--
 .../arch/x86/emeraldrapids/other.json         |  28 ++-
 .../arch/x86/emeraldrapids/pipeline.json      | 167 +++++--------
 .../arch/x86/emeraldrapids/uncore-memory.json |  82 +++++++
 .../x86/emeraldrapids/virtual-memory.json     |  40 +--
 .../arch/x86/grandridge/grr-metrics.json      |  20 +-
 .../arch/x86/graniterapids/cache.json         | 227 +++++++++++++-----
 .../x86/graniterapids/floating-point.json     |  43 ++--
 .../arch/x86/graniterapids/frontend.json      |  42 ++--
 .../arch/x86/graniterapids/gnr-metrics.json   | 131 +++++-----
 .../arch/x86/graniterapids/memory.json        |  33 ++-
 .../arch/x86/graniterapids/other.json         |  30 ++-
 .../arch/x86/graniterapids/pipeline.json      | 167 ++++++-------
 .../arch/x86/graniterapids/uncore-io.json     |   1 -
 .../arch/x86/graniterapids/uncore-memory.json |  31 ---
 .../x86/graniterapids/virtual-memory.json     |  40 +--
 .../arch/x86/haswell/hsw-metrics.json         |  32 ++-
 .../arch/x86/haswellx/hsx-metrics.json        |  35 ++-
 .../arch/x86/icelake/icl-metrics.json         |  96 ++++----
 .../arch/x86/icelakex/icx-metrics.json        | 155 ++++++++----
 .../arch/x86/ivybridge/ivb-metrics.json       |  30 +--
 .../arch/x86/ivytown/ivt-metrics.json         |  33 ++-
 .../arch/x86/jaketown/jkt-metrics.json        |  20 +-
 .../pmu-events/arch/x86/lunarlake/cache.json  | 104 ++++++--
 .../arch/x86/lunarlake/frontend.json          |  40 +--
 .../arch/x86/lunarlake/lnl-metrics.json       | 216 +++++++++--------
 .../pmu-events/arch/x86/lunarlake/memory.json |  22 +-
 .../arch/x86/lunarlake/pipeline.json          |  85 ++++---
 .../x86/lunarlake/uncore-interconnect.json    |  10 +
 .../arch/x86/lunarlake/uncore-memory.json     |   8 +
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  16 +-
 .../pmu-events/arch/x86/meteorlake/cache.json | 129 +++++-----
 .../arch/x86/meteorlake/floating-point.json   |  28 +--
 .../arch/x86/meteorlake/frontend.json         |  42 ++--
 .../arch/x86/meteorlake/memory.json           |  15 +-
 .../arch/x86/meteorlake/mtl-metrics.json      | 103 ++++----
 .../pmu-events/arch/x86/meteorlake/other.json |   5 +-
 .../arch/x86/meteorlake/pipeline.json         | 173 ++++++-------
 .../arch/x86/meteorlake/virtual-memory.json   |  40 +--
 .../arch/x86/rocketlake/rkl-metrics.json      |  97 ++++----
 .../arch/x86/sandybridge/snb-metrics.json     |  19 +-
 .../arch/x86/sapphirerapids/cache.json        | 100 ++++----
 .../x86/sapphirerapids/floating-point.json    |  43 ++--
 .../arch/x86/sapphirerapids/frontend.json     |  42 ++--
 .../arch/x86/sapphirerapids/memory.json       |  30 +--
 .../arch/x86/sapphirerapids/other.json        |  28 ++-
 .../arch/x86/sapphirerapids/pipeline.json     | 167 +++++--------
 .../arch/x86/sapphirerapids/spr-metrics.json  | 153 +++++++-----
 .../x86/sapphirerapids/uncore-memory.json     |  82 +++++++
 .../x86/sapphirerapids/virtual-memory.json    |  40 +--
 .../arch/x86/sierraforest/srf-metrics.json    |  20 +-
 .../arch/x86/skylake/skl-metrics.json         | 101 +++++---
 .../arch/x86/skylakex/skx-metrics.json        | 101 +++++---
 .../arch/x86/tigerlake/tgl-metrics.json       |  97 ++++----
 78 files changed, 2870 insertions(+), 2325 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/uncore-interconnect.json

-- 
2.50.0.727.gbf7dc18ff4-goog

