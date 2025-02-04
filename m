Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC78A25A655
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Feb 2025 02:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738634596; cv=none; b=B9JHkKuNXdPYiOrWvzR5fRROoH9Ii470ZYMQTogjlPFOLixO8b+2S1xHCp0rJvp/pELkduG66KM5y0SA08GNrIO17VcrCcSnHUVuhBZuL1N8IP0B8eLdkI/A6z3JAvvudkCDrHs3ZGvaxoG0uD8B24m/o6c4DMYSNCIviv/9k0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738634596; c=relaxed/simple;
	bh=0NV2nHwStpzCSS3OsHDt40WOKulbabfqZ0EyRxhiL6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=bsrFxsH6ipxtFKKjkDqcct5A2cLgmx8cyMkT3MyjwiVpw099kCk8Ix/swehyL1YY50OJI78jNFQev6gwUFMd9zIqhCIuZsa+d3ZnREc8JB1Q2XLEVSzUtt4oYeRuEVfggZQvOkVNbyh7hM/J8pFc3ACCFezP7TL8WESTyVVGLZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Saz5UwJx; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Saz5UwJx"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a814c54742so31175ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Feb 2025 18:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738634594; x=1739239394; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PC8T4AAlVjkmtZjSdef1l1SOofh0x851DLqmMDZYR9Q=;
        b=Saz5UwJx9Gsei72xCItfAYgFe1NwxZ9dBlNOaw+rW+zD5G5UIGNFHl6z00eunrL7D3
         sK9yTdqmfm/tLUg5L38pWR8BHLIb+3wz2TFodlK8xon80OZl09Sr+oOi26AZ7xqwxYrO
         NJcfHkrn9AY+1HY39YhRltZl4DXQIkWojr90IMQcNgtFyu2G+9Jx5K65C6XvfAZ6QXB6
         loFEwCyehCgsQO9iR+S9awzoI0nMiClKN+Rmqiwac8smiWtcBPhRQwNZSGdt92SVKmA6
         DTyVXaDJjz4elpiQMJ7ZDed5bWhLoMwGWogbMtz4LJThsv5JrYhVrKaIn56BzDdS1l0I
         aW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738634594; x=1739239394;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PC8T4AAlVjkmtZjSdef1l1SOofh0x851DLqmMDZYR9Q=;
        b=G3yy3eh2IdDBnJ5btEXDU9BOBJn4EUMvcXVzBy7VrLf4lUWXlNbi4rFRu6TXqPtAqJ
         bpyrJDgneGxdPSHim2rW20GBbXaC7++1x9y+7ilicQANcWI98n8Q2YekWpqPTzlQdBZN
         UfcuTEnvAuxv7nAoWDbpo36Pk1u99Qjz3T2ZlNYmh0JzDGszEmrgzRNAMcaHVNr5iBZv
         yiGukYABFRlS6+dsXum0q25mD65u2uY3R4OfGFMnEpA1nNaYRBLLDCYVhO/I0LWh6ttm
         6EMh7iu/cVGa7fNdZOa95x5GN/85dES8oMryP32m4+MPvPu3hGEGiS119VvBDutkWXPh
         h5Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVZr+jMP7LXGps5/uCOCKqeu/6RdNM8rkkf+n0YIIr2tJOxi3wkuKuasCHH0F+rPV7q+SDsyAjvcMoZDA1KeeaP@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/r/dB4QlpgXidpuGp3dXoc3xetC7TIPYue+iEkKRivwZZtek8
	gnhPtmSK110Yu0NG660VbULRb+kAW9zvoaKO64/CD9genyqp0P3B3kL4eKAX+qBsU7S6L3/aQ6j
	b1yjnjrNlJCfvresoaNza7r5unnfPCH0SoD21
X-Gm-Gg: ASbGncviUjVtpaCrmQ0CrUMqtQTN7xkjpGmyLD38lncPuOVO0UYYTjqtI6HJbTdbNjO
	p+lJqaZ+J8u04H57RtoPB8H4ImNhISCbv9U6OkiCo916dkB6x4o1gLmoWMBLmcWmuWs0as0aq5A
	==
X-Google-Smtp-Source: AGHT+IFjs8t16DNv+gDJ8jH4wldRSKKNY6TjWYk332AxVr0GDzlq0u7vt3HRqmYmkfmLHDBi2nOPvr9MMYrzc9PDleM=
X-Received: by 2002:a05:6e02:1c21:b0:3a7:5be0:5a06 with SMTP id
 e9e14a558f8ab-3d040f66ee8mr703655ab.29.1738634593563; Mon, 03 Feb 2025
 18:03:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203230150.106823-1-irogers@google.com>
In-Reply-To: <20250203230150.106823-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 3 Feb 2025 18:03:02 -0800
X-Gm-Features: AWEUYZlS9FUS2wPz-BjF4JNW6Gi6MlhD_OxzrgZfBOUmRkMXwcof5Koury697wQ
Message-ID: <CAP-5=fXmoTvtCmDnOi7PLh01Z1xk=u3SCHUCtj+Gmj40i6ovAQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/23] Intel vendor events and TMA 5.01 metrics
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Michael Petlan <mpetlan@redhat.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 3:02=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> Update the Intel vendor events to the latest.
> Update the metrics to TMA 5.01.
> Add Arrowlake and Clearwaterforest support.
> Add metrics for LNL and GNR.
> Address IIO uncore issue spotted on EMR, GRR, GNR, SPR and SRF.
>
> The perf json was generated using the script:
> https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
> with the generated json being in:
> https://github.com/intel/perfmon/tree/main/scripts/perf
>
> Thanks to Perry Taylor <perry.taylor@intel.com>, Caleb Biggers
> <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com> and
> Weilin Wang <weilin.wang@intel.com> for helping get this patch series
> together.
>
> v3: Fixes for hybrid metrics that were missing PMU. Update to the
>     latest events.
> v2: Fix hybrid and Co-authored-by tag issues reported by
>     Arnaldo. Updates to Lunarlake and Meteorlake events. Addition of
>     Clearwaterforest.

Silly me, I forgot to add Thomas who spotted the hybrid issues with
v2. The full series of emails is here:
https://lore.kernel.org/all/20250203230150.106823-1-irogers@google.com/
I recommend using the b4 tool to apply them :-)
As is normal, I removed Kan's acked by on the updated patches in v3.
So fresh reviews/acked-by would be appreciated.

Thanks,
Ian

> Ian Rogers (23):
>   perf vendor events: Update Alderlake events/metrics
>   perf vendor events: Update AlderlakeN events/metrics
>   perf vendor events: Add Arrowlake events/metrics
>   perf vendor events: Update Broadwell events/metrics
>   perf vendor events: Update BroadwellDE events/metrics
>   perf vendor events: Update BroadwellX events/metrics
>   perf vendor events: Update CascadelakeX events/metrics
>   perf vendor events: Add Clearwaterforest events
>   perf vendor events: Update EmeraldRapids events/metrics
>   perf vendor events: Update GrandRidge events/metrics
>   perf vendor events: Update/add Graniterapids events/metrics
>   perf vendor events: Update Haswell events/metrics
>   perf vendor events: Update HaswellX events/metrics
>   perf vendor events: Update Icelake events/metrics
>   perf vendor events: Update IcelakeX events/metrics
>   perf vendor events: Update/add Lunarlake events/metrics
>   perf vendor events: Update Meteorlake events/metrics
>   perf vendor events: Update Rocketlake events/metrics
>   perf vendor events: Update Sapphirerapids events/metrics
>   perf vendor events: Update Sierraforest events/metrics
>   perf vendor events: Update Skylake metrics
>   perf vendor events: Update SkylakeX events/metrics
>   perf vendor events: Update Tigerlake events/metrics
>
>  .../arch/x86/alderlake/adl-metrics.json       | 3379 +++++++++---
>  .../pmu-events/arch/x86/alderlake/cache.json  |  292 +-
>  .../arch/x86/alderlake/floating-point.json    |   19 +-
>  .../arch/x86/alderlake/frontend.json          |   19 -
>  .../pmu-events/arch/x86/alderlake/memory.json |   32 +-
>  .../arch/x86/alderlake/metricgroups.json      |   10 +-
>  .../pmu-events/arch/x86/alderlake/other.json  |   92 +-
>  .../arch/x86/alderlake/pipeline.json          |  127 +-
>  .../arch/x86/alderlake/virtual-memory.json    |   33 +
>  .../arch/x86/alderlaken/adln-metrics.json     |   83 +-
>  .../pmu-events/arch/x86/alderlaken/cache.json |  227 +-
>  .../arch/x86/alderlaken/floating-point.json   |   17 +-
>  .../arch/x86/alderlaken/memory.json           |   20 +
>  .../pmu-events/arch/x86/alderlaken/other.json |   81 +-
>  .../arch/x86/alderlaken/pipeline.json         |   97 +-
>  .../arch/x86/alderlaken/virtual-memory.json   |   30 +
>  .../arch/x86/arrowlake/arl-metrics.json       | 4597 ++++++++++++++++
>  .../pmu-events/arch/x86/arrowlake/cache.json  | 1491 ++++++
>  .../arch/x86/arrowlake/floating-point.json    |  532 ++
>  .../arch/x86/arrowlake/frontend.json          |  609 +++
>  .../pmu-events/arch/x86/arrowlake/memory.json |  387 ++
>  .../arch/x86/arrowlake/metricgroups.json      |  150 +
>  .../pmu-events/arch/x86/arrowlake/other.json  |  279 +
>  .../arch/x86/arrowlake/pipeline.json          | 2308 +++++++++
>  .../arch/x86/arrowlake/uncore-cache.json      |   20 +
>  .../x86/arrowlake/uncore-interconnect.json    |   47 +
>  .../arch/x86/arrowlake/uncore-memory.json     |  160 +
>  .../{haswell =3D> arrowlake}/uncore-other.json  |    0
>  .../arch/x86/arrowlake/virtual-memory.json    |  522 ++
>  .../arch/x86/broadwell/bdw-metrics.json       |  312 +-
>  .../pmu-events/arch/x86/broadwell/cache.json  |   10 +-
>  .../arch/x86/broadwell/frontend.json          |    4 +-
>  .../pmu-events/arch/x86/broadwell/memory.json |    8 +-
>  .../arch/x86/broadwell/metricgroups.json      |    5 +
>  .../arch/x86/broadwell/pipeline.json          |   10 +-
>  .../arch/x86/broadwellde/bdwde-metrics.json   |  256 +-
>  .../arch/x86/broadwellde/cache.json           |   10 +-
>  .../arch/x86/broadwellde/frontend.json        |    4 +-
>  .../arch/x86/broadwellde/memory.json          |    6 +-
>  .../arch/x86/broadwellde/metricgroups.json    |    5 +
>  .../arch/x86/broadwellde/pipeline.json        |   10 +-
>  .../arch/x86/broadwellde/uncore-cache.json    |   28 +-
>  .../x86/broadwellde/uncore-interconnect.json  |   16 +-
>  .../arch/x86/broadwellx/bdx-metrics.json      |  344 +-
>  .../pmu-events/arch/x86/broadwellx/cache.json |   10 +-
>  .../arch/x86/broadwellx/frontend.json         |    4 +-
>  .../arch/x86/broadwellx/memory.json           |    6 +-
>  .../arch/x86/broadwellx/metricgroups.json     |    5 +
>  .../arch/x86/broadwellx/pipeline.json         |   10 +-
>  .../arch/x86/broadwellx/uncore-cache.json     |   28 +-
>  .../x86/broadwellx/uncore-interconnect.json   |   36 +-
>  .../arch/x86/broadwellx/uncore-memory.json    |    1 +
>  .../arch/x86/cascadelakex/clx-metrics.json    |  767 +--
>  .../arch/x86/cascadelakex/metricgroups.json   |    9 +-
>  .../arch/x86/cascadelakex/uncore-cache.json   |   60 +-
>  .../x86/cascadelakex/uncore-interconnect.json |   11 -
>  .../arch/x86/clearwaterforest/cache.json      |  144 +
>  .../arch/x86/clearwaterforest/counter.json    |    7 +
>  .../arch/x86/clearwaterforest/frontend.json   |   18 +
>  .../arch/x86/clearwaterforest/memory.json     |   22 +
>  .../arch/x86/clearwaterforest/other.json      |   22 +
>  .../arch/x86/clearwaterforest/pipeline.json   |  113 +
>  .../x86/clearwaterforest/virtual-memory.json  |   29 +
>  .../arch/x86/emeraldrapids/cache.json         |   28 +-
>  .../arch/x86/emeraldrapids/emr-metrics.json   | 1036 ++--
>  .../arch/x86/emeraldrapids/frontend.json      |   19 -
>  .../arch/x86/emeraldrapids/memory.json        |   15 +-
>  .../arch/x86/emeraldrapids/metricgroups.json  |   10 +-
>  .../arch/x86/emeraldrapids/pipeline.json      |   23 -
>  .../arch/x86/emeraldrapids/uncore-io.json     |  218 +-
>  .../arch/x86/grandridge/grr-metrics.json      |  284 +-
>  .../arch/x86/grandridge/pipeline.json         |    3 +-
>  .../arch/x86/grandridge/uncore-cache.json     |    4 +-
>  .../x86/grandridge/uncore-interconnect.json   |   60 +
>  .../arch/x86/grandridge/uncore-io.json        |  214 +-
>  .../arch/x86/grandridge/uncore-memory.json    |    2 +-
>  .../arch/x86/graniterapids/cache.json         |  130 +-
>  .../arch/x86/graniterapids/counter.json       |   24 +-
>  .../arch/x86/graniterapids/frontend.json      |   24 +-
>  .../arch/x86/graniterapids/gnr-metrics.json   | 2313 +++++++++
>  .../arch/x86/graniterapids/memory.json        |  121 +-
>  .../arch/x86/graniterapids/metricgroups.json  |  145 +
>  .../arch/x86/graniterapids/other.json         |  109 +
>  .../arch/x86/graniterapids/pipeline.json      |   40 +-
>  .../arch/x86/graniterapids/uncore-cache.json  |   48 +-
>  .../arch/x86/graniterapids/uncore-cxl.json    |    2 -
>  .../graniterapids/uncore-interconnect.json    |   87 +
>  .../arch/x86/graniterapids/uncore-io.json     |  280 +-
>  .../arch/x86/graniterapids/uncore-memory.json |  122 +-
>  .../arch/x86/graniterapids/uncore-power.json  |   98 +
>  .../arch/x86/haswell/hsw-metrics.json         |  260 +-
>  .../pmu-events/arch/x86/haswell/memory.json   |    2 +-
>  .../arch/x86/haswell/metricgroups.json        |    5 +
>  .../arch/x86/haswellx/hsx-metrics.json        |  296 +-
>  .../arch/x86/haswellx/metricgroups.json       |    5 +
>  .../arch/x86/haswellx/uncore-cache.json       |   28 +-
>  .../x86/haswellx/uncore-interconnect.json     |   38 +-
>  .../pmu-events/arch/x86/icelake/cache.json    |   34 +-
>  .../pmu-events/arch/x86/icelake/frontend.json |   17 -
>  .../arch/x86/icelake/icl-metrics.json         |  849 +--
>  .../pmu-events/arch/x86/icelake/memory.json   |   13 +-
>  .../arch/x86/icelake/metricgroups.json        |   10 +-
>  .../pmu-events/arch/x86/icelake/pipeline.json |   30 +-
>  .../arch/x86/icelake/uncore-interconnect.json |   76 -
>  .../arch/x86/icelake/uncore-other.json        |    2 +-
>  .../arch/x86/icelake/virtual-memory.json      |   18 +
>  .../pmu-events/arch/x86/icelakex/cache.json   |   41 +-
>  .../arch/x86/icelakex/frontend.json           |   17 -
>  .../arch/x86/icelakex/icx-metrics.json        |  852 +--
>  .../pmu-events/arch/x86/icelakex/memory.json  |   13 +-
>  .../arch/x86/icelakex/metricgroups.json       |   10 +-
>  .../arch/x86/icelakex/pipeline.json           |   30 +-
>  .../pmu-events/arch/x86/lunarlake/cache.json  | 1352 ++++-
>  .../arch/x86/lunarlake/floating-point.json    |  484 ++
>  .../arch/x86/lunarlake/frontend.json          |  654 ++-
>  .../arch/x86/lunarlake/lnl-metrics.json       | 4611 +++++++++++++++++
>  .../pmu-events/arch/x86/lunarlake/memory.json |  262 +-
>  .../arch/x86/lunarlake/metricgroups.json      |  150 +
>  .../pmu-events/arch/x86/lunarlake/other.json  |  496 +-
>  .../arch/x86/lunarlake/pipeline.json          | 2105 +++++++-
>  .../arch/x86/lunarlake/uncore-memory.json     |   36 +
>  .../arch/x86/lunarlake/virtual-memory.json    |  428 ++
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |   42 +-
>  .../pmu-events/arch/x86/meteorlake/cache.json |  109 +-
>  .../arch/x86/meteorlake/frontend.json         |   30 +-
>  .../arch/x86/meteorlake/memory.json           |   22 +-
>  .../arch/x86/meteorlake/metricgroups.json     |   10 +-
>  .../arch/x86/meteorlake/mtl-metrics.json      | 3554 ++++++++++---
>  .../pmu-events/arch/x86/meteorlake/other.json |   54 +
>  .../arch/x86/meteorlake/pipeline.json         |   89 +-
>  .../pmu-events/arch/x86/rocketlake/cache.json |   34 +-
>  .../arch/x86/rocketlake/frontend.json         |   17 -
>  .../arch/x86/rocketlake/memory.json           |   13 +-
>  .../arch/x86/rocketlake/metricgroups.json     |   10 +-
>  .../arch/x86/rocketlake/pipeline.json         |   30 +-
>  .../arch/x86/rocketlake/rkl-metrics.json      |  849 +--
>  .../x86/rocketlake/uncore-interconnect.json   |   10 -
>  .../arch/x86/rocketlake/uncore-other.json     |    2 +-
>  .../arch/x86/rocketlake/virtual-memory.json   |   18 +
>  .../arch/x86/sapphirerapids/cache.json        |   30 +-
>  .../arch/x86/sapphirerapids/frontend.json     |   19 -
>  .../arch/x86/sapphirerapids/memory.json       |   15 +-
>  .../arch/x86/sapphirerapids/metricgroups.json |   10 +-
>  .../arch/x86/sapphirerapids/pipeline.json     |   23 -
>  .../arch/x86/sapphirerapids/spr-metrics.json  |  968 ++--
>  .../arch/x86/sapphirerapids/uncore-io.json    |  138 +-
>  .../arch/x86/sierraforest/cache.json          |  130 +-
>  .../arch/x86/sierraforest/counter.json        |   24 +-
>  .../arch/x86/sierraforest/frontend.json       |    8 +
>  .../arch/x86/sierraforest/other.json          |   20 +
>  .../arch/x86/sierraforest/pipeline.json       |   46 +-
>  .../arch/x86/sierraforest/srf-metrics.json    |  308 +-
>  .../arch/x86/sierraforest/uncore-cache.json   |   61 +-
>  .../arch/x86/sierraforest/uncore-cxl.json     |    2 -
>  .../x86/sierraforest/uncore-interconnect.json |   87 +
>  .../arch/x86/sierraforest/uncore-io.json      |  280 +-
>  .../arch/x86/sierraforest/uncore-memory.json  |  122 +-
>  .../arch/x86/sierraforest/uncore-power.json   |   98 +
>  .../arch/x86/skylake/metricgroups.json        |    9 +-
>  .../arch/x86/skylake/skl-metrics.json         |  684 ++-
>  .../arch/x86/skylakex/metricgroups.json       |    9 +-
>  .../arch/x86/skylakex/skx-metrics.json        |  740 +--
>  .../arch/x86/skylakex/uncore-cache.json       |   60 +-
>  .../x86/skylakex/uncore-interconnect.json     |   11 -
>  .../pmu-events/arch/x86/tigerlake/cache.json  |   45 +-
>  .../arch/x86/tigerlake/frontend.json          |   17 -
>  .../pmu-events/arch/x86/tigerlake/memory.json |   13 +-
>  .../arch/x86/tigerlake/metricgroups.json      |   10 +-
>  .../arch/x86/tigerlake/pipeline.json          |   30 +-
>  .../arch/x86/tigerlake/tgl-metrics.json       |  745 +--
>  .../x86/tigerlake/uncore-interconnect.json    |    4 +-
>  .../arch/x86/tigerlake/uncore-other.json      |    2 +-
>  .../arch/x86/tigerlake/virtual-memory.json    |   18 +
>  173 files changed, 38476 insertions(+), 7876 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/arl-metrics.=
json
>  create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/floating-poi=
nt.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/frontend.jso=
n
>  create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/metricgroups=
.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/other.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/pipeline.jso=
n
>  create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/uncore-cache=
.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/uncore-inter=
connect.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/uncore-memor=
y.json
>  rename tools/perf/pmu-events/arch/x86/{haswell =3D> arrowlake}/uncore-ot=
her.json (100%)
>  create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/virtual-memo=
ry.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/cache=
.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/count=
er.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/front=
end.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/memor=
y.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/other=
.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/pipel=
ine.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/virtu=
al-memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/gnr-metr=
ics.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/metricgr=
oups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/floating-poi=
nt.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/lnl-metrics.=
json
>  create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/metricgroups=
.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/uncore-memor=
y.json
>
> --
> 2.48.1.362.g079036d154-goog
>
