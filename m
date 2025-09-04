Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CD52264BA
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002336; cv=none; b=I10ZdTwyGyukdfQ10s3k2VrCg/SQv4n3ZxzstVo4Ul3ViDGM0Ug+OYJqUjwYjG4yYwFZYyYT3TDtfcz8BRxTmspkUaELmSpvvewD00lXN7OIhE3/AMZomSetA5uEdMGvEVkAMpkBntfIo2HaKOM3uYOok8fWKwlQqDSDdOtMJSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002336; c=relaxed/simple;
	bh=K9Fczei7Gse+fy6tTEDoXiORVBMNIRe6agRMkzng1jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=GlEO6DAZ7UtlieSHKiPYNKuLvwvBC0KkWSNmiazFxIpyyGXMGooEwVJ+4TykNLqJUQxP4W25HMLWoM3MZrRsjrQ/svzuDCjIRO/wnrSms2heNgguYMF7uJkE/AdnACQ3IqXsE4qRdT9Z3Mlh27E5rWjo4Ne6rvGJ+D0Te9oQOGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m8gc2bo3; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m8gc2bo3"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24b2d018f92so208075ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Sep 2025 09:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757002334; x=1757607134; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oxg6KGbvMXnhKUZiGVSFPxFZrjrAk2t56vsmdG05ac8=;
        b=m8gc2bo3wEQdiMJDw/kMFXwqSQ7zDyY3W+CuWdKrvqpRCRJEtTbZyElJhvjX1Ah4lh
         5sm3d4pdrC+NKM7Xmo4BTAekS0BGkikg1eaVz+x00ygpNh7nZl0ZPLhyks3w0udjLBEE
         xBBJm+1sdKuhSGDjL2WYPovvtO8G8okPhcoV3VuedyNB8LNaE1ASna7jXsqbzQb/MZAG
         06oGLsm+KPJwOr6kEoqB6WGbWVodXeklhMeYbavbdT0wjJ6wbWTA2Qv/8A5D90vCu7tL
         SrSp899UWQAQy+oK6sqUGmHw0tZg07he3SQ5ysPBSorChR3zNqwpJND+Uuq2AhopqoXE
         Rk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757002334; x=1757607134;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oxg6KGbvMXnhKUZiGVSFPxFZrjrAk2t56vsmdG05ac8=;
        b=dTC+cYKye/O6lmQ0VIcNW6kPkksn/2qMOkUl5R5JhOAMqpt82wlQRQUq4eYupB8QFK
         ynSHbxK9eQo2OsC5Z0X2oGsLqwmdBLwDGreY3yC2FzDfCefDDS0tXLxYPfT2e3Gy5gAq
         y+bmciVVXCl75mavrxued/IWum0ZCFzx0nwr7NCA2srbLXf9MUnleXfSQdg0bwBQnh6r
         ZfWHB63wEAqAAVzF4feNsyXx3BmEHNvH2A9OxDRXRX50EMWG2SbrRmP6YjEHchBbHDGa
         wBuycjbQtxzhVASC6it4uI/eAfJFwf2N0f+of4COAeIE27ekK0VWmjxYyxP1kPzSUD2I
         LZ9A==
X-Forwarded-Encrypted: i=1; AJvYcCXkMHjQn9Pv0IVMwU2TZ4itC2yNh0jrpAvNcvUyKWfRvUWJyHth6Lf8/1GcL3k2KAXrdL3WwQLx9zrfCuJh9Ccv@vger.kernel.org
X-Gm-Message-State: AOJu0YyXLay0dVVD7twTdH/9VJ5we7vmHX47233lvS+ZK/rqbN0M/GBM
	+JmAQ58j5k7J0dM/JXLp02hiQ8jVsgjMPFbCEKpgjhRVj6TSh16pOyWOOMTVsEvA8Zg39mzp4Bi
	oR8sqXnquaMORDef08isdykIenczKfrRkwM+VYGFW
X-Gm-Gg: ASbGncvnl+XYZq3sug4DYjaYJrvPAQ3m/yIVjMf/ec3vnh7Vy/tNGpROPJGu9pMJNlA
	uACX8DR55bvjRKtZ4gKQC1Emp1p78SLD6wv8Fc9Xx6X5+106FRH7tyzCvIwjbAMUNAm3cMLPx9l
	3eZoXOnWPfwJVIIlUUOxFSC5AZa6GDaBF60vo78baeKpMTEYdjJE2vxFf4gmOrs8HR0Yxb/MFtU
	73eLETMg/WhzROOOudU9nKLoFPs1tpvu0HxwpM3OywIuDIH2bf5Uwk=
X-Google-Smtp-Source: AGHT+IHW7f3F5NWf9sYWKBTAjggA1mZgGkBd01ZKSCBDGYwxoF8q6+EZJZxRJLKs0yJt+GZptAwL9pppaDotP6kYM7s=
X-Received: by 2002:a17:902:c402:b0:24c:863a:4ccc with SMTP id
 d9443c01a7336-24ccaea1adcmr3953915ad.4.1757002333199; Thu, 04 Sep 2025
 09:12:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818190416.145274-1-irogers@google.com>
In-Reply-To: <20250818190416.145274-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 4 Sep 2025 09:12:01 -0700
X-Gm-Features: Ac12FXxysLLHAhErdPoKUPnZVN0keF2Cr89cgrhUhX9PHhv7CPUoctpU94BOENA
Message-ID: <CAP-5=fUJcaK75cfkDJBueh39EXbWtD-A_rOm-VYbnz4bsDq3XA@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] Intel TMA 5.1 metrics and event updates
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Manivannan Sadhasivam <mani@kernel.org>, Caleb Biggers <caleb.biggers@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-actions@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 12:05=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> Update events from:
> v1.31 -> v1.33 for alderlake
> v1.09 -> v1.12 for arrowlake
> v1.14 -> v1.16 for emeraldrapids
> v1.10 -> v1.12 for graniterpaids
> v1.14 -> v1.17 for lunarlake
> v1.14 -> v1.16 for meteorlake
> v1.28 -> v1.30 for sapphirerapids
>
> Update TMA 5.0 to 5.1 removing the slots event workaround as the patch se=
ries:
> https://lore.kernel.org/lkml/20250719030517.1990983-1-irogers@google.com/
> is assumed.
>
> The patches are generated by:
> https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
> with pull requests 323 and 324 applied.
>
> v2: Add Thomas Falcon's tested-by. Both Thomas and myself had tested
>     v1 on hybrid machines with cpu_atom and cpu_core PMUs. Namhyung
>     reported issues on non-hybrid/AMD machines with the fake_pmu test
>     - the metrics using those PMUs were failing event parsing. Add a
>     patch so that the PMU in a cpu=3DPMU term is ignored when fake PMUs
>     are in use.

Ping.

Thanks,
Ian

> Ian Rogers (20):
>   perf parse-events: Handle fake PMUs in CPU terms
>   perf vendor events: Update alderlake events/metrics
>   perf vendor events: Update arrowlake events/metrics
>   perf vendor events: Update broadwell metrics
>   perf vendor events: Update cascadelakex metrics
>   perf vendor events: Update emeraldrapids events/metrics
>   perf vendor events: Update grandridge metrics
>   perf vendor events: Update graniterapids events/metrics
>   perf vendor events: Update haswell metrics
>   perf vendor events: Update icelake metrics
>   perf vendor events: Update ivybridge/ivytown metrics
>   perf vendor events: Update jaketown metrics
>   perf vendor events: Update lunarlake events/metrics
>   perf vendor events: Update meteorlake events/metrics
>   perf vendor events: Update rocketlake metrics
>   perf vendor events: Update sandybridge metrics
>   perf vendor events: Update sapphirerapids events/metrics
>   perf vendor events: Update sierraforest metrics
>   perf vendor events: Update skylake metrics
>   perf vendor events: Update tigerlake metrics
>
>  .../arch/x86/alderlake/adl-metrics.json       | 104 ++++----
>  .../pmu-events/arch/x86/alderlake/cache.json  |  99 ++++----
>  .../arch/x86/alderlake/floating-point.json    |  28 +--
>  .../arch/x86/alderlake/frontend.json          |  42 ++--
>  .../pmu-events/arch/x86/alderlake/memory.json |  12 +-
>  .../pmu-events/arch/x86/alderlake/other.json  |   8 +-
>  .../arch/x86/alderlake/pipeline.json          | 163 +++++--------
>  .../x86/alderlake/uncore-interconnect.json    |   2 -
>  .../arch/x86/alderlake/virtual-memory.json    |  40 +--
>  .../arch/x86/alderlaken/adln-metrics.json     |  20 +-
>  .../x86/alderlaken/uncore-interconnect.json   |   2 -
>  .../arch/x86/arrowlake/arl-metrics.json       | 180 ++++++++------
>  .../pmu-events/arch/x86/arrowlake/cache.json  | 122 +++++++---
>  .../arch/x86/arrowlake/frontend.json          |  40 +--
>  .../pmu-events/arch/x86/arrowlake/memory.json |  22 +-
>  .../arch/x86/arrowlake/pipeline.json          |  94 +++++---
>  .../arch/x86/broadwell/bdw-metrics.json       |  30 +--
>  .../arch/x86/broadwellde/bdwde-metrics.json   |  30 +--
>  .../arch/x86/broadwellx/bdx-metrics.json      |  33 ++-
>  .../arch/x86/cascadelakex/clx-metrics.json    | 139 ++++++++---
>  .../arch/x86/emeraldrapids/cache.json         | 100 ++++----
>  .../arch/x86/emeraldrapids/emr-metrics.json   | 131 +++++-----
>  .../x86/emeraldrapids/floating-point.json     |  43 ++--
>  .../arch/x86/emeraldrapids/frontend.json      |  42 ++--
>  .../arch/x86/emeraldrapids/memory.json        |  30 +--
>  .../arch/x86/emeraldrapids/other.json         |  28 ++-
>  .../arch/x86/emeraldrapids/pipeline.json      | 167 +++++--------
>  .../arch/x86/emeraldrapids/uncore-memory.json |  82 +++++++
>  .../x86/emeraldrapids/virtual-memory.json     |  40 +--
>  .../arch/x86/grandridge/grr-metrics.json      |  20 +-
>  .../arch/x86/graniterapids/cache.json         | 227 +++++++++++++-----
>  .../x86/graniterapids/floating-point.json     |  43 ++--
>  .../arch/x86/graniterapids/frontend.json      |  42 ++--
>  .../arch/x86/graniterapids/gnr-metrics.json   | 131 +++++-----
>  .../arch/x86/graniterapids/memory.json        |  33 ++-
>  .../arch/x86/graniterapids/other.json         |  30 ++-
>  .../arch/x86/graniterapids/pipeline.json      | 167 ++++++-------
>  .../arch/x86/graniterapids/uncore-io.json     |   1 -
>  .../arch/x86/graniterapids/uncore-memory.json |  31 ---
>  .../x86/graniterapids/virtual-memory.json     |  40 +--
>  .../arch/x86/haswell/hsw-metrics.json         |  32 ++-
>  .../arch/x86/haswellx/hsx-metrics.json        |  35 ++-
>  .../arch/x86/icelake/icl-metrics.json         |  96 ++++----
>  .../arch/x86/icelakex/icx-metrics.json        | 155 ++++++++----
>  .../arch/x86/ivybridge/ivb-metrics.json       |  30 +--
>  .../arch/x86/ivytown/ivt-metrics.json         |  33 ++-
>  .../arch/x86/jaketown/jkt-metrics.json        |  20 +-
>  .../pmu-events/arch/x86/lunarlake/cache.json  | 104 ++++++--
>  .../arch/x86/lunarlake/frontend.json          |  40 +--
>  .../arch/x86/lunarlake/lnl-metrics.json       | 216 +++++++++--------
>  .../pmu-events/arch/x86/lunarlake/memory.json |  22 +-
>  .../arch/x86/lunarlake/pipeline.json          |  85 ++++---
>  .../x86/lunarlake/uncore-interconnect.json    |  10 +
>  .../arch/x86/lunarlake/uncore-memory.json     |   8 +
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |  16 +-
>  .../pmu-events/arch/x86/meteorlake/cache.json | 129 +++++-----
>  .../arch/x86/meteorlake/floating-point.json   |  28 +--
>  .../arch/x86/meteorlake/frontend.json         |  42 ++--
>  .../arch/x86/meteorlake/memory.json           |  15 +-
>  .../arch/x86/meteorlake/mtl-metrics.json      | 103 ++++----
>  .../pmu-events/arch/x86/meteorlake/other.json |   5 +-
>  .../arch/x86/meteorlake/pipeline.json         | 173 ++++++-------
>  .../arch/x86/meteorlake/virtual-memory.json   |  40 +--
>  .../arch/x86/rocketlake/rkl-metrics.json      |  97 ++++----
>  .../arch/x86/sandybridge/snb-metrics.json     |  19 +-
>  .../arch/x86/sapphirerapids/cache.json        | 100 ++++----
>  .../x86/sapphirerapids/floating-point.json    |  43 ++--
>  .../arch/x86/sapphirerapids/frontend.json     |  42 ++--
>  .../arch/x86/sapphirerapids/memory.json       |  30 +--
>  .../arch/x86/sapphirerapids/other.json        |  28 ++-
>  .../arch/x86/sapphirerapids/pipeline.json     | 167 +++++--------
>  .../arch/x86/sapphirerapids/spr-metrics.json  | 153 +++++++-----
>  .../x86/sapphirerapids/uncore-memory.json     |  82 +++++++
>  .../x86/sapphirerapids/virtual-memory.json    |  40 +--
>  .../arch/x86/sierraforest/srf-metrics.json    |  20 +-
>  .../arch/x86/skylake/skl-metrics.json         | 101 +++++---
>  .../arch/x86/skylakex/skx-metrics.json        | 101 +++++---
>  .../arch/x86/tigerlake/tgl-metrics.json       |  97 ++++----
>  tools/perf/util/parse-events.c                | 116 ++++-----
>  79 files changed, 2930 insertions(+), 2381 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/uncore-inter=
connect.json
>
> --
> 2.51.0.rc1.167.g924127e9c0-goog
>
