Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE4F14A9B
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Sep 2025 21:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758750588; cv=none; b=qroDjLcJoU9/f/aU32h+zeD0cYS2f/3IsESJWbVeqbjLon2vO1rzfcCgaNlgjVQRhLO99kqQsZYQzMIZgTmHP2B/0i70QgVzZar6mgvKrL0o0u2UYI1adgDcCmr7Koe1jKsk0t2lP2K5EuOWDHTIak0jOq4NiesL7EvMzZBnKTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758750588; c=relaxed/simple;
	bh=GWYtZbeYbpW8w97l5i6HJsikqt6icbDuVis+D9ScMc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aaUloCEciqytq7N3jgTB/6XL9dtEov61gQBWIBxaW3368asCpxxtKGfvCTzRO3HZWFwqVS7JHXt7uEQMY/Qi7BSIQFnDFrdcrNWuOFVfMuiMJIetWjqMtsMqJli4wMNzmlWSqJ+zynJXzWkqbNZRZXMslAMNX/kCvlz+kheweZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hz7yAft7; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hz7yAft7"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2731ff54949so252645ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Sep 2025 14:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758750586; x=1759355386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3HDVNWJ9AP4sLfDQFWKcbzWNRC8jMSO7rPt8JusEKE=;
        b=hz7yAft7UC0q6Q62MvlEZcQfcjYvdim3e0PTNcSo5m9Ug7oy9vRGX3P0wDgQGtlkSm
         5woF8t81saIQP7Vrj3y2Be1tdjz5r8CUyrnLQvSHqwReFwX9poIGTfJMaXh5phJu0Erp
         26EA+hXvmzZ1jIqa1lfjyQ47RCyfSP9cR+OzpBBCg7COIpGabUbyVkfeaqtxidNACgtP
         I/7Osw/EWCFRtZeWgErPhE7Cxm9miS4mgPgULBuTTtAuUde+wFJA5yf2qYng1hLdzE+n
         sut6gCJvLlb/8E71MBxfoXHr8mVObER/1CGecixUU1mHiBFIzgqI1xTSwXxZxt0izxY9
         vqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758750586; x=1759355386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3HDVNWJ9AP4sLfDQFWKcbzWNRC8jMSO7rPt8JusEKE=;
        b=NR18RaIoTkSD1vjdmtgWU/ufO6YHjszZZfXOgjlI3qOk6aqVoo69qqf/27AgZ+cn2X
         d2SxXuVgd+Py+KTFHAJWsRwBwPeV8fqWpBMtcSXu1Of6tp1gKXqD9G5JHozk0J7mghzm
         BJOR3cpyHHgX6pz0o10N550nm9yL4t15FCnSz09KlxKtGOysTQQWXR/FPzs0/tnoCEIY
         KdVFUb+xRC0PwM3pa/HwXYqvOwSjdlNOiRNmmLfnU+gxDwnLGpZXQsyD654WRLSvh2S0
         VE9Ms5H1H0vcURbAagEOyhq4X1ej0wxTAe30NaFF2OVv/CiUyYBDK3pfxYxlFfbx2UZP
         LqDA==
X-Forwarded-Encrypted: i=1; AJvYcCWU80S4ZSESby9ePmUIP7R50+FVe3iqAnhhP5OEKaITdfTGO+m7SeOsnHc0UP6uLlF5E7cat7Jm3SKPrwX8dqmQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+kDzY/Jky2Jw/+wZvdKpUCGA88wM55k1kF9BZUKI2elQuTgci
	X/9LeAtXQ9nrV/ejjlgSK5HJmEptjd3S3nm9Su+rmK0MMJb7pHZwfuHlvdIf5xjZvbpl4MyljEM
	t2C2PxbiHHl9+TkxKmWyEX0gi6Y7u/hqpANUXnQw6
X-Gm-Gg: ASbGncugvF7MTMa2XXKLmlfVD0CAZTQVocC1ie7ViqWYxPc0eW8Y+TzSMYQBiMJ82bZ
	ydkhW7h6zvLmWL8hn0RbFYMRveL0JqmVghHYowah0Xl+6/A5LBCZfgS8OU/jNkWzpp2vsTeWeJH
	ZdFFCzLNSVin9UtKhDwSHglwmW9aw010RmdwLuQ6inuBeZ9qtNt+NkY8SANwm1Cl2uF2uSy9Nn4
	gK84npE/QqogthinVyaDPtxg/+RWJJV+n3xWVypadUC
X-Google-Smtp-Source: AGHT+IHgfh/bnEKI5ZG6ydJJO89r1MO2Jayc5KZ22fVyjJEtrbiWq4ff9SosWj/Hhe1/Rq3bn213LQ9prx7ajV1hK7k=
X-Received: by 2002:a17:902:e80b:b0:25b:fba3:afb5 with SMTP id
 d9443c01a7336-27ed4027f80mr2529035ad.11.1758750586153; Wed, 24 Sep 2025
 14:49:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924060229.375718-1-irogers@google.com> <5275b98eff5e686521c407f4d38eed8448be5a3b.camel@intel.com>
In-Reply-To: <5275b98eff5e686521c407f4d38eed8448be5a3b.camel@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 24 Sep 2025 14:49:35 -0700
X-Gm-Features: AS18NWCkawn9Aupm1GEZZqFcGGLsV0ngulWs5uUmK05QF9mk4JuEqEvJQDEGI0Y
Message-ID: <CAP-5=fVm+AY=cHE4izpwjUnSnZ=qyCmo55d6wJA-WCJo4Rp3cw@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] perf vendor events intel update
To: "Falcon, Thomas" <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	"Taylor, Perry" <perry.taylor@intel.com>
Cc: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, 
	"afaerber@suse.de" <afaerber@suse.de>, "Biggers, Caleb" <caleb.biggers@intel.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, "acme@kernel.org" <acme@kernel.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "Hunter, Adrian" <adrian.hunter@intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"namhyung@kernel.org" <namhyung@kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>, 
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mani@kernel.org" <mani@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 2:13=E2=80=AFPM Falcon, Thomas <thomas.falcon@intel=
.com> wrote:
>
> On Tue, 2025-09-23 at 23:02 -0700, Ian Rogers wrote:
> > Update events and some metrics to the latest perfmon versions:
> >  - alderlake 1.34
> >  - arrowlake 1.13
> >  - emeraldrapids 1.20
> >  - grandridge 1.10
> >  - graniterapids 1.15
> >  - lunarlake 1.18
> >  - meteorlake 1.17
> >  - sapphirerapids 1.35
> >  - sierraforest 1.12
> >
>
> Metrics tests passed on Alder Lake, Sapphire Rapids, and Arrow Lake.
>
> Tested-by: Thomas Falcon <thomas.falcon@intel.com>

Thanks! I think we found an issue on emeraldrapids that
pcu_0/UNC_P_CLOCKTICKS/ should be pcu/UNC_P_CLOCKTICKS/ in the
cpu_cstate metrics. The question is, how many PCUs does an
emeraldrapids have? Is it guaranteed to be 1 or do we need to support
suffixes when there is >1. I'm guessing the story on sapphirerapids is
similar, we just didn't test it.

The use of a suffix in the PMU of the event name is to avoid
aggregating all the clockticks together.  A less efficient way to do
this would be "UNC_P_CLOCKTICKS / source_count(UNC_P_CLOCKTICKS)"
which would compute an average of the clockticks. We could update perf
to ignore _0 suffixes when looking for PMUs, which feels kind of hacky
and ARM has different suffix conventions. We could do:
"pcu_0@UNC_P_CLOCKTICKS@ if has_event(pcu_0@UNC_P_CLOCKTICKS@) else
pcu@UNC_P_CLOCKTICKS@"
which feels a little long winded. If we know EMR and SPR have just 1
PCU I think I'd prefer just to turn pcu_0 into pcu as a fix.

Thanks,
Ian

> Thanks,
> Tom
>
> > Ian Rogers (10):
> >   perf vendor events intel: Update alderlake events to v1.34
> >   perf vendor events intel: Update arrowlake events to v1.13
> >   perf vendor events intel: Update emeraldrapids events to v1.20
> >   perf vendor events intel: Update grandridge events to v1.10
> >   perf vendor events intel: Update graniterapids events to v1.15
> >   perf vendor events intel: Update lunarlake events to v1.18
> >   perf vendor events intel: Update meteorlake events to v1.17
> >   perf vendor events intel: Update pantherlake events to v1.00
> >   perf vendor events intel: Update sapphirerapids events to v1.35
> >   perf vendor events intel: Update sierraforest events to v1.12
> >
> >  .../pmu-events/arch/x86/alderlake/cache.json  |   36 +
> >  .../pmu-events/arch/x86/arrowlake/cache.json  |   46 +-
> >  .../pmu-events/arch/x86/arrowlake/memory.json |    6 +-
> >  .../pmu-events/arch/x86/arrowlake/other.json  |    2 +-
> >  .../arch/x86/emeraldrapids/cache.json         |   63 +
> >  .../arch/x86/emeraldrapids/emr-metrics.json   |   12 +
> >  .../arch/x86/emeraldrapids/uncore-cache.json  |   11 +
> >  .../arch/x86/emeraldrapids/uncore-memory.json |   22 +
> >  .../arch/x86/emeraldrapids/uncore-power.json  |    2 -
> >  .../pmu-events/arch/x86/grandridge/cache.json |   20 +-
> >  .../graniterapids/uncore-interconnect.json    |   10 +-
> >  .../arch/x86/graniterapids/uncore-memory.json |  112 ++
> >  .../pmu-events/arch/x86/lunarlake/cache.json  |   46 +-
> >  .../pmu-events/arch/x86/lunarlake/memory.json |    6 +-
> >  .../pmu-events/arch/x86/lunarlake/other.json  |    2 +-
> >  tools/perf/pmu-events/arch/x86/mapfile.csv    |   20 +-
> >  .../pmu-events/arch/x86/meteorlake/cache.json |   36 +
> >  .../arch/x86/pantherlake/cache.json           | 1207 ++++++++++-
> >  .../arch/x86/pantherlake/counter.json         |    9 +-
> >  .../arch/x86/pantherlake/floating-point.json  |  286 +++
> >  .../arch/x86/pantherlake/frontend.json        |  535 +++++
> >  .../arch/x86/pantherlake/memory.json          |  106 +-
> >  .../arch/x86/pantherlake/other.json           |   44 +
> >  .../arch/x86/pantherlake/pipeline.json        | 1776
> > ++++++++++++++++-
> >  .../arch/x86/pantherlake/uncore-memory.json   |   26 +
> >  .../arch/x86/pantherlake/virtual-memory.json  |  248 +++
> >  .../arch/x86/sapphirerapids/cache.json        |   63 +
> >  .../arch/x86/sapphirerapids/spr-metrics.json  |   12 +
> >  .../arch/x86/sapphirerapids/uncore-cache.json |   11 +
> >  .../x86/sapphirerapids/uncore-memory.json     |   22 +
> >  .../arch/x86/sapphirerapids/uncore-power.json |    2 -
> >  .../arch/x86/sierraforest/cache.json          |   61 +-
> >  .../x86/sierraforest/uncore-interconnect.json |   10 +-
> >  .../arch/x86/sierraforest/uncore-io.json      |    1 -
> >  .../arch/x86/sierraforest/uncore-memory.json  |  103 +-
> >  35 files changed, 4712 insertions(+), 262 deletions(-)
> >  create mode 100644 tools/perf/pmu-
> > events/arch/x86/pantherlake/floating-point.json
> >  create mode 100644 tools/perf/pmu-
> > events/arch/x86/pantherlake/other.json
> >  create mode 100644 tools/perf/pmu-
> > events/arch/x86/pantherlake/uncore-memory.json
> >
>
