Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22D5441020
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 16:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772124886; cv=pass; b=nrTNg20iqsfKPkJsDCvHOBMjRbU7OvlyaV6dEfsThnh5i2nJTpuFTbxh1PrJn3pGKkaUyqexRC3EMryOS17wT32oGDf1i16vsTdQL8DTOcEa+R/43khpUQJXZZkrOLpyfIpW1m218Z3qW1S2cTDbPiyI4lunDM7xFyIkV6XCBPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772124886; c=relaxed/simple;
	bh=7Cx9UmoBZbrOk/2vL2RE1WkaslgePURVYcG2mTuRHec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9Kp06KLoaWZQyLWb/z8Vc8P4gtjL+JI+592A/B5EbQ9f61HekCxZC9U6RF0u86tL1wJ1rsQTDzNaQobSDUNPyV+FJd+6bJr/Rkc4gtTKoLhnkBYGxZsEdjDXFkXs4bWtr79lg2/cGn9WhZ+VlJjWemvE3sVtM4V/do8SvXjaqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YD1Y4aMT; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YD1Y4aMT"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1270fc2bdf2so13188c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 08:54:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772124883; cv=none;
        d=google.com; s=arc-20240605;
        b=Cb4R7AI5oulzYQDlkJGzGyhkNGCs8H9ypKilKF9CrfcII7w9PKM/fCu3g9iQEkoNjm
         XnsEcDfDfrV1/rFEcFQUKKWLMB8zGONmPypAC9FsNQ+mwVlM9gF9jEPGO2mI5OGhmdKL
         gJIow+CFsZohGWc6VzvPAft0Z6avdc8SUL+aLd+l4AjtBWvMOjqR1d/5waC4Ovvwmm03
         ZeqgNrWQe3ZW24yJQWM2C2dbQtUlFeqOsgULGoSTlV/BJDyXizAI+OUAADwQ7EQuYwWj
         CrIYf1jr89Di74MaR9WoURB76qjulFIEpqmPDy/8eMk0xqOexHI31HmUSbpCQGkWkNqe
         BkNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4rtJDN0QD5O7aAyBkCBa5nhSWzf8i+UFfCGfyhfbtmg=;
        fh=1c0foRSj3Ih1qFkXhJVm+PUmHuLQO8bscOR0GQ7TagI=;
        b=Ny69Jq+lAr8dTqOsvQTViHP1RGPhfSeB8D/XZar76UnXRBNpFSGhNKEo+CaA7a/92o
         xYMBmho5gpQZRl4jeRx4hkwzaEGXzaB8mstgaWYG8HQQorp1iTxDEfutHAkDZlpVwNVC
         swbEMiO/9oFMZuU6Qd0UtijxS8xdPksZ2f47MaX+6WCj6IaBjft9xC79wMRgDcquSpBN
         BqsE7IBRrxosKFQhCgFztro/Ng2mPbbPTJfmcOq28cI5SSswnuwM4UpVj+nUNKrAZEku
         KpkVp3h1QvL09/TO592hNEjBzyJCbCygQLmWKiaN59+1LHtW7CLXTokYB9XFzUUSthY7
         iIRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772124883; x=1772729683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rtJDN0QD5O7aAyBkCBa5nhSWzf8i+UFfCGfyhfbtmg=;
        b=YD1Y4aMT6zZZuqHE/NZEG+45FzRKgeF+3GTa1HOd49YfPfZnSYnT9YQ85gyUfjyP2z
         mp/MW+CmCO/Md8kVgDlJRKZSUiIjQguk3+OTdCrpd9WixfnVMffTjcgV6QwT1AnCkE/g
         CMlqCBeULTbb/tJzSkvmrLhq14bLVQ4iNIKmiTFZgMqwUjP2dbcvZlGNAE9sLHjXgRc1
         I7Wm2CeKWiCrqdC4Vkm3jYtjMekD+DcZDwWzEI/wtgjxqlwSXwVFk8T6AR1lL9nUWtlg
         S3IqlXpFEeYafUPRmpDB3yqcbX45kCjKRNiOiZUkqtgn7A0A36F9msKfKCosGTx7TGal
         dgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772124883; x=1772729683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4rtJDN0QD5O7aAyBkCBa5nhSWzf8i+UFfCGfyhfbtmg=;
        b=YNzrDGdhl1Tr4zrCF8uFmSnfLdKO4NS6CcIIPt+W+Xq8Uq0NTdvHSmu+Dsqhu5PpHY
         ruUGiGLuJwq3zOfADOAZalAAjaFRsvOp7AdX7ofj7lkZEujdONnV3vw/C1jybxw9UmQB
         iPVnkA1pDD1kP44yMrBm3ni8Xr93NfzdmRWrOGFtDiQ0vLhjmVhQu9bXzmf3asn9B257
         /exvD76pTkefHyyK7gbCmN/jOsV3ptvcFHtIWtgOuIiU4dPDgpl56miaTy3+1Eby+TKZ
         PnnuYq8u81LdJYhf0y7D7FTujJNrvY+wgliMNyl+7kfdpV49RU2P40pV7dJ+RBitp5l/
         JAxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ9epfEdOH4FTA76jOCx+EQB9ZTyybmq17Iatwcfs58TwhNL5jQX8lfPmudW6CAoX2/keDXw5ztIL33Bo44Vob@vger.kernel.org
X-Gm-Message-State: AOJu0YzXf0pHfgSUXKfiCg9PH+80Dg4ywJfCn02/V7jYV4e9t1JbKHGi
	RCvA3jipHhsrvAmvW6s3t7aj0zVyJ0kwRKEGWpy/2IOjJKn+HMvsVtAFNK7VVkfAKOVzHgEFDVJ
	j2iAF4cWze2d77CCjY9v9kJpXRhM5jeJpKzhwE96s
X-Gm-Gg: ATEYQzxUyTQ+FSregY4S4Obc5fDo0nTzShn5rSkv7KEdshmP1pv6F+qAKlVPp951bxM
	uWTSDNd/P9z665EZxRmlfEoKfdWJBusXN+zADhwMfkv0pjtALE2ulnTpXZVe5qyGOBR+euQCBVT
	4dDH+OH2wck58T4T/WunfSbLI5iRDxXWhVLBFtB/CPS9sg9Kv2GrW+CZhP3EoA0rM8gL8r+yWJp
	X9pzwfdPphX1+MDki+nPbeWR/fDCWmh3hdARo6avz6YrFbDDuA2OA/mb0jL1VED3yPhKmucA+J+
	ErKyq2dHoz6HY5R9nXequ7iz2b6vDTHBbWz+
X-Received: by 2002:a05:7022:a93:b0:11a:b4dc:7773 with SMTP id
 a92af1059eb24-12788f9e86dmr202866c88.12.1772124882303; Thu, 26 Feb 2026
 08:54:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226045301.459948-1-irogers@google.com> <20260226045301.459948-7-irogers@google.com>
 <fd7649cf-d436-47ab-a7b9-eb5e915fce05@linux.intel.com>
In-Reply-To: <fd7649cf-d436-47ab-a7b9-eb5e915fce05@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 26 Feb 2026 08:54:30 -0800
X-Gm-Features: AaiRm53pNUx05GWj0EESJ8Q5p1ojVkmfoDxCXb6YAlNkCCXM_Kl_64KH1H56iQs
Message-ID: <CAP-5=fUMXAd5m95qUEe9NoTr8Q655U5050SdG70Gw+P_vvwfig@mail.gmail.com>
Subject: Re: [PATCH v1 07/10] perf vendor events intel: Update lunarlake
 events from 1.18 to 1.20
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Manivannan Sadhasivam <mani@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 11:20=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel=
.com> wrote:
>
> It seems a typo in the shortlog, it should be meteorlake instead of
> lunarlake. :)

You're right, wil fix in v2.

Thanks,
Ian

>
> On 2/26/2026 12:52 PM, Ian Rogers wrote:
> > The updated events were published in:
> > https://github.com/intel/perfmon/commit/2eebd8e2612a0655e82b88e1d2fab96=
0315c025b
> > https://github.com/intel/perfmon/commit/81c4ce2c16f05b839d2c40e8cf183ed=
110357b73
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
> >  .../pmu-events/arch/x86/meteorlake/cache.json | 67 ++++++++++++++++---
> >  .../arch/x86/meteorlake/frontend.json         | 18 +++++
> >  .../arch/x86/meteorlake/pipeline.json         | 46 +++++++++++--
> >  4 files changed, 116 insertions(+), 17 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pm=
u-events/arch/x86/mapfile.csv
> > index a2dde3faad5e..8d8fd8b08166 100644
> > --- a/tools/perf/pmu-events/arch/x86/mapfile.csv
> > +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
> > @@ -23,7 +23,7 @@ GenuineIntel-6-3E,v24,ivytown,core
> >  GenuineIntel-6-2D,v24,jaketown,core
> >  GenuineIntel-6-(57|85),v16,knightslanding,core
> >  GenuineIntel-6-BD,v1.21,lunarlake,core
> > -GenuineIntel-6-(AA|AC|B5),v1.18,meteorlake,core
> > +GenuineIntel-6-(AA|AC|B5),v1.20,meteorlake,core
> >  GenuineIntel-6-1[AEF],v4,nehalemep,core
> >  GenuineIntel-6-2E,v4,nehalemex,core
> >  GenuineIntel-6-CC,v1.02,pantherlake,core
> > diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json b/too=
ls/perf/pmu-events/arch/x86/meteorlake/cache.json
> > index d3fc04b2ffbd..4c1220c19456 100644
> > --- a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
> > +++ b/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
> > @@ -513,6 +513,15 @@
> >          "UMask": "0x6",
> >          "Unit": "cpu_atom"
> >      },
> > +    {
> > +        "BriefDescription": "Counts the number of unhalted cycles when=
 the core is stalled due to an ICACHE or ITLB miss which hit in the LLC, no=
 snoop was required. LLC provides the data. If the core has access to an L3=
 cache, an LLC hit refers to an L3 cache hit, otherwise it counts zeros.",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0x35",
> > +        "EventName": "MEM_BOUND_STALLS_IFETCH.LLC_HIT_NOSNOOP",
> > +        "SampleAfterValue": "1000003",
> > +        "UMask": "0x2",
> > +        "Unit": "cpu_atom"
> > +    },
> >      {
> >          "BriefDescription": "Counts the number of unhalted cycles when=
 the core is stalled due to an ICACHE or ITLB miss which missed all the cac=
hes. If the core has access to an L3 cache, an LLC miss refers to an L3 cac=
he miss, otherwise it is an L2 cache miss.",
> >          "Counter": "0,1,2,3,4,5,6,7",
> > @@ -522,6 +531,15 @@
> >          "UMask": "0x78",
> >          "Unit": "cpu_atom"
> >      },
> > +    {
> > +        "BriefDescription": "Counts the number of unhalted cycles when=
 the core is stalled due to an ICACHE or ITLB miss which missed all the cac=
hes. DRAM, MMIO or other LOCAL memory type provides the data. If the core h=
as access to an L3 cache, an LLC miss refers to an L3 cache miss, otherwise=
 it is an L2 cache miss.",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0x35",
> > +        "EventName": "MEM_BOUND_STALLS_IFETCH.LLC_MISS_LOCALMEM",
> > +        "SampleAfterValue": "1000003",
> > +        "UMask": "0x50",
> > +        "Unit": "cpu_atom"
> > +    },
> >      {
> >          "BriefDescription": "Counts the number of unhalted cycles when=
 the core is stalled due to an L1 demand load miss.",
> >          "Counter": "0,1,2,3,4,5,6,7",
> > @@ -559,6 +577,24 @@
> >          "UMask": "0x6",
> >          "Unit": "cpu_atom"
> >      },
> > +    {
> > +        "BriefDescription": "Counts the number of unhalted cycles when=
 the core is stalled due to a demand load miss which hit in the LLC, no sno=
op was required. LLC provides the data. If the core has access to an L3 cac=
he, an LLC hit refers to an L3 cache hit, otherwise it counts zeros.",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0x34",
> > +        "EventName": "MEM_BOUND_STALLS_LOAD.LLC_HIT_NOSNOOP",
> > +        "SampleAfterValue": "1000003",
> > +        "UMask": "0x2",
> > +        "Unit": "cpu_atom"
> > +    },
> > +    {
> > +        "BriefDescription": "Counts the number of unhalted cycles when=
 the core is stalled due to a demand load miss which hit in the LLC, a snoo=
p was required, the snoop misses or the snoop hits but NO_FWD. LLC provides=
 the data. If the core has access to an L3 cache, an LLC hit refers to an L=
3 cache hit, otherwise it counts zeros.",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0x34",
> > +        "EventName": "MEM_BOUND_STALLS_LOAD.LLC_HIT_SNOOP",
> > +        "SampleAfterValue": "1000003",
> > +        "UMask": "0x4",
> > +        "Unit": "cpu_atom"
> > +    },
> >      {
> >          "BriefDescription": "Counts the number of unhalted cycles when=
 the core is stalled due to a demand load miss which missed all the local c=
aches. If the core has access to an L3 cache, an LLC miss refers to an L3 c=
ache miss, otherwise it is an L2 cache miss.",
> >          "Counter": "0,1,2,3,4,5,6,7",
> > @@ -568,6 +604,15 @@
> >          "UMask": "0x78",
> >          "Unit": "cpu_atom"
> >      },
> > +    {
> > +        "BriefDescription": "Counts the number of unhalted cycles when=
 the core is stalled to a demand load miss and the data was provided from a=
n unknown source. If the core has access to an L3 cache, an LLC miss refers=
 to an L3 cache miss, otherwise it is an L2 cache miss.",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0x34",
> > +        "EventName": "MEM_BOUND_STALLS_LOAD.LLC_MISS_LOCALMEM",
> > +        "SampleAfterValue": "1000003",
> > +        "UMask": "0x50",
> > +        "Unit": "cpu_atom"
> > +    },
> >      {
> >          "BriefDescription": "Counts the number of unhalted cycles when=
 the core is stalled to a store buffer full condition",
> >          "Counter": "0,1,2,3,4,5,6,7",
> > @@ -969,7 +1014,7 @@
> >          "Unit": "cpu_atom"
> >      },
> >      {
> > -        "BriefDescription": "Counts the number of tagged load uops ret=
ired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESH=
OLD - Only counts with PEBS enabled.",
> > +        "BriefDescription": "Counts the number of tagged load uops ret=
ired that exceed the latency threshold of 1024. Only counts with PEBS enabl=
ed.",
> >          "Counter": "0,1",
> >          "Data_LA": "1",
> >          "EventCode": "0xd0",
> > @@ -981,7 +1026,7 @@
> >          "Unit": "cpu_atom"
> >      },
> >      {
> > -        "BriefDescription": "Counts the number of tagged load uops ret=
ired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESH=
OLD - Only counts with PEBS enabled.",
> > +        "BriefDescription": "Counts the number of tagged load uops ret=
ired that exceed the latency threshold of 128. Only counts with PEBS enable=
d.",
> >          "Counter": "0,1",
> >          "Data_LA": "1",
> >          "EventCode": "0xd0",
> > @@ -993,7 +1038,7 @@
> >          "Unit": "cpu_atom"
> >      },
> >      {
> > -        "BriefDescription": "Counts the number of tagged load uops ret=
ired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESH=
OLD - Only counts with PEBS enabled.",
> > +        "BriefDescription": "Counts the number of tagged load uops ret=
ired that exceed the latency threshold of 16. Only counts with PEBS enabled=
.",
> >          "Counter": "0,1",
> >          "Data_LA": "1",
> >          "EventCode": "0xd0",
> > @@ -1005,7 +1050,7 @@
> >          "Unit": "cpu_atom"
> >      },
> >      {
> > -        "BriefDescription": "Counts the number of tagged load uops ret=
ired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESH=
OLD - Only counts with PEBS enabled.",
> > +        "BriefDescription": "Counts the number of tagged load uops ret=
ired that exceed the latency threshold of 2048. Only counts with PEBS enabl=
ed.",
> >          "Counter": "0,1",
> >          "Data_LA": "1",
> >          "EventCode": "0xd0",
> > @@ -1017,7 +1062,7 @@
> >          "Unit": "cpu_atom"
> >      },
> >      {
> > -        "BriefDescription": "Counts the number of tagged load uops ret=
ired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESH=
OLD - Only counts with PEBS enabled.",
> > +        "BriefDescription": "Counts the number of tagged load uops ret=
ired that exceed the latency threshold of 256. Only counts with PEBS enable=
d.",
> >          "Counter": "0,1",
> >          "Data_LA": "1",
> >          "EventCode": "0xd0",
> > @@ -1029,7 +1074,7 @@
> >          "Unit": "cpu_atom"
> >      },
> >      {
> > -        "BriefDescription": "Counts the number of tagged load uops ret=
ired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESH=
OLD - Only counts with PEBS enabled.",
> > +        "BriefDescription": "Counts the number of tagged load uops ret=
ired that exceed the latency threshold of 32. Only counts with PEBS enabled=
.",
> >          "Counter": "0,1",
> >          "Data_LA": "1",
> >          "EventCode": "0xd0",
> > @@ -1041,7 +1086,7 @@
> >          "Unit": "cpu_atom"
> >      },
> >      {
> > -        "BriefDescription": "Counts the number of tagged load uops ret=
ired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESH=
OLD - Only counts with PEBS enabled.",
> > +        "BriefDescription": "Counts the number of tagged load uops ret=
ired that exceed the latency threshold of 4. Only counts with PEBS enabled.=
",
> >          "Counter": "0,1",
> >          "Data_LA": "1",
> >          "EventCode": "0xd0",
> > @@ -1053,7 +1098,7 @@
> >          "Unit": "cpu_atom"
> >      },
> >      {
> > -        "BriefDescription": "Counts the number of tagged load uops ret=
ired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESH=
OLD - Only counts with PEBS enabled.",
> > +        "BriefDescription": "Counts the number of tagged load uops ret=
ired that exceed the latency threshold of 512. Only counts with PEBS enable=
d.",
> >          "Counter": "0,1",
> >          "Data_LA": "1",
> >          "EventCode": "0xd0",
> > @@ -1065,7 +1110,7 @@
> >          "Unit": "cpu_atom"
> >      },
> >      {
> > -        "BriefDescription": "Counts the number of tagged load uops ret=
ired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESH=
OLD - Only counts with PEBS enabled.",
> > +        "BriefDescription": "Counts the number of tagged load uops ret=
ired that exceed the latency threshold of 64. Only counts with PEBS enabled=
.",
> >          "Counter": "0,1",
> >          "Data_LA": "1",
> >          "EventCode": "0xd0",
> > @@ -1077,7 +1122,7 @@
> >          "Unit": "cpu_atom"
> >      },
> >      {
> > -        "BriefDescription": "Counts the number of tagged load uops ret=
ired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESH=
OLD - Only counts with PEBS enabled.",
> > +        "BriefDescription": "Counts the number of tagged load uops ret=
ired that exceed the latency threshold of 8. Only counts with PEBS enabled.=
",
> >          "Counter": "0,1",
> >          "Data_LA": "1",
> >          "EventCode": "0xd0",
> > @@ -1159,7 +1204,7 @@
> >          "Unit": "cpu_atom"
> >      },
> >      {
> > -        "BriefDescription": "Counts the number of  stores uops retired=
 same as MEM_UOPS_RETIRED.ALL_STORES",
> > +        "BriefDescription": "Counts the number of stores uops retired.=
",
> >          "Counter": "0,1,2,3,4,5,6,7",
> >          "Data_LA": "1",
> >          "EventCode": "0xd0",
> > diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json b/=
tools/perf/pmu-events/arch/x86/meteorlake/frontend.json
> > index 6484834b1127..dcf8c8e720f3 100644
> > --- a/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json
> > +++ b/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json
> > @@ -430,6 +430,24 @@
> >          "UMask": "0x4",
> >          "Unit": "cpu_core"
> >      },
> > +    {
> > +        "BriefDescription": "ICACHE_TAG.STALLS_INUSE",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x83",
> > +        "EventName": "ICACHE_TAG.STALLS_INUSE",
> > +        "SampleAfterValue": "200003",
> > +        "UMask": "0x10",
> > +        "Unit": "cpu_core"
> > +    },
> > +    {
> > +        "BriefDescription": "ICACHE_TAG.STALLS_ISB",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x83",
> > +        "EventName": "ICACHE_TAG.STALLS_ISB",
> > +        "SampleAfterValue": "200003",
> > +        "UMask": "0x8",
> > +        "Unit": "cpu_core"
> > +    },
> >      {
> >          "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deli=
vering any Uop",
> >          "Counter": "0,1,2,3",
> > diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json b/=
tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
> > index bfdaabe9377d..7662846745bd 100644
> > --- a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
> > +++ b/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
> > @@ -517,7 +517,7 @@
> >          "Unit": "cpu_core"
> >      },
> >      {
> > -        "BriefDescription": "Fixed Counter: Counts the number of unhal=
ted core clock cycles",
> > +        "BriefDescription": "Fixed Counter: Counts the number of unhal=
ted core clock cycles. [This event is alias to CPU_CLK_UNHALTED.THREAD]",
> >          "Counter": "Fixed counter 1",
> >          "EventName": "CPU_CLK_UNHALTED.CORE",
> >          "SampleAfterValue": "2000003",
> > @@ -583,7 +583,7 @@
> >          "Unit": "cpu_core"
> >      },
> >      {
> > -        "BriefDescription": "Fixed Counter: Counts the number of unhal=
ted reference clock cycles",
> > +        "BriefDescription": "Fixed Counter: Counts the number of unhal=
ted reference clock cycles.",
> >          "Counter": "Fixed counter 2",
> >          "EventName": "CPU_CLK_UNHALTED.REF_TSC",
> >          "SampleAfterValue": "2000003",
> > @@ -620,7 +620,7 @@
> >          "Unit": "cpu_core"
> >      },
> >      {
> > -        "BriefDescription": "Fixed Counter: Counts the number of unhal=
ted core clock cycles",
> > +        "BriefDescription": "Fixed Counter: Counts the number of unhal=
ted core clock cycles. [This event is alias to CPU_CLK_UNHALTED.CORE]",
> >          "Counter": "Fixed counter 1",
> >          "EventName": "CPU_CLK_UNHALTED.THREAD",
> >          "SampleAfterValue": "2000003",
> > @@ -804,10 +804,10 @@
> >          "Unit": "cpu_core"
> >      },
> >      {
> > -        "BriefDescription": "Fixed Counter: Counts the number of instr=
uctions retired",
> > +        "BriefDescription": "Fixed Counter: Counts the number of instr=
uctions retired.",
> >          "Counter": "Fixed counter 0",
> >          "EventName": "INST_RETIRED.ANY",
> > -        "PublicDescription": "Fixed Counter: Counts the number of inst=
ructions retired Available PDIST counters: 32",
> > +        "PublicDescription": "Fixed Counter: Counts the number of inst=
ructions retired. Available PDIST counters: 32",
> >          "SampleAfterValue": "2000003",
> >          "UMask": "0x1",
> >          "Unit": "cpu_atom"
> > @@ -1207,6 +1207,42 @@
> >          "UMask": "0x20",
> >          "Unit": "cpu_core"
> >      },
> > +    {
> > +        "BriefDescription": "Counts the number of CLFLUSH, CLWB, and C=
LDEMOTE instructions retired.",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xe0",
> > +        "EventName": "MISC_RETIRED1.CL_INST",
> > +        "SampleAfterValue": "1000003",
> > +        "UMask": "0xff",
> > +        "Unit": "cpu_atom"
> > +    },
> > +    {
> > +        "BriefDescription": "Counts the number of LFENCE instructions =
retired.",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xe0",
> > +        "EventName": "MISC_RETIRED1.LFENCE",
> > +        "SampleAfterValue": "1000003",
> > +        "UMask": "0x2",
> > +        "Unit": "cpu_atom"
> > +    },
> > +    {
> > +        "BriefDescription": "Counts the number of accesses to KeyLocke=
r cache.",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xe1",
> > +        "EventName": "MISC_RETIRED2.KEYLOCKER_ACCESS",
> > +        "SampleAfterValue": "1000003",
> > +        "UMask": "0x10",
> > +        "Unit": "cpu_atom"
> > +    },
> > +    {
> > +        "BriefDescription": "Counts the number of misses to KeyLocker =
cache.",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xe1",
> > +        "EventName": "MISC_RETIRED2.KEYLOCKER_MISS",
> > +        "SampleAfterValue": "1000003",
> > +        "UMask": "0x11",
> > +        "Unit": "cpu_atom"
> > +    },
> >      {
> >          "BriefDescription": "Cycles stalled due to no store buffers av=
ailable. (not including draining form sync).",
> >          "Counter": "0,1,2,3,4,5,6,7",
