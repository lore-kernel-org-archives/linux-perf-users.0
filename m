Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0BAD517
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Aug 2024 15:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772624; cv=none; b=oz7ghJi1Q6Ds4kgVYkI70l288yFODL0ke3MSAmoWh1s5w8PoUh2Up7Yajtr1p9rc/9AnCkvwBmRvqbQUztosTqpysjJT4ODKUvHy1UEpIpTNc4KvXfXJJuFvBQ8P1/7EF9J+ne+upbeVMgasqdt9ccPFR6JH8NxzrLAfMPfWlRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772624; c=relaxed/simple;
	bh=RrvifVylM460xSV6ryQ4sWHiMF2Na1CL/DEMc3KrLmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nvz7MYgJA1DDsJ3fVlikBKPH4aEBzNUE9N5RwF1O94oe0qevETVOmfgVE7VW3YY/iKGHY9czhyKRCt8YjrrFJ+NJwZSIHi2DOb7VwzDimhek/ERvSn4NhFEgG1x4gGv0+8Ip8T7O+45Dq00i/J/0BuZWfBXXqObDIpjKJHnrNJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zCEpO5Cv; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zCEpO5Cv"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20260346ca1so239255ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Aug 2024 08:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724772622; x=1725377422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52lDzClgWIfDwjLe7orO5wLRybHMcHJGueg5E+ukdi8=;
        b=zCEpO5CvFRqPFXdkZuHLCngkjbOAfVLpxbNUqmL8W9uYwLUipqTjVVN2JFozjOhhyB
         pnYS6hVOD1vawdgk/v00y4Rv+R4H8z1IOr/Je/PEwUWcDp3emTHJ+XNB+ezBS6LR+nA4
         oMaD626XSzLuyZRVNiiTJ/t/2lRZ8otzkowhSfXlt6CV7bkfe26gRxxPEuiPQwdXM2xD
         kQVrUI58S91P1xiSVRWTKiCVe7f14DBbs1WZqiv+trqmnpW+Q556Wytwjcg76lfSMB8+
         yNHdJs7693I1XoBcvNJ98zr3qPnRfU15Kvgu5tUaBEkkE2DPIPoD+uor9HOLSFo9RLxY
         ERNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724772622; x=1725377422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52lDzClgWIfDwjLe7orO5wLRybHMcHJGueg5E+ukdi8=;
        b=k4Ii1gdg6ZWq2yPbPRGkzAwfC3+3SeTE3aFaSi4xzjY7zyHIvBiCNdFyIYfEn2JgzV
         TOc081VYub7QVSafTH7y0xcqys9uMpsKBXKDuTy0br9h/yRsEOnjNp9s4zhMfyuAW8nW
         fMTrsubhptZ9kncOReXQi72NIWXzLZifD7nQm0+RLHk4s49lPtaZbL7mIjazTitTpHMk
         51CdL+EOaw/+a9ZTUTljtbJjMDT5OSTpjVXOvrcMKtv/ufXJ0a4DH6qByLszsuD2esGf
         neKRXJaFELlOgwMXHkIhpmovYRUl3x5bhcf2hF2TEkpUAVFKPO78oeCoZ0LCFQRYvcn+
         XBSA==
X-Forwarded-Encrypted: i=1; AJvYcCXmmmFp/yd7qShklNOq8BEY/nDZpjj54Gnb4Y82wkSJdNydgqxwZAGkqQP4q3qDX/8Z3Rs7pKpnQ1s0sxp1Wtum@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu6qEv549T4/bPuk3NvFa5Ads2cUiEVybUoWeKo5Wuh5uYeU/2
	6UX7Ze6e0KkBzfszZL5Yl1dE5+SRAj/cUwFcQ73XeaRoe7JFTZ2TBPN9UmDUGDQBluTeFXOUbl9
	jy18RFgWZ6to1A5fLeYDgH3YqaPyk+PLGH5IZ
X-Google-Smtp-Source: AGHT+IGaDewL8Pg/Wjw0RU5NHRtlyKO6nhTpAU3Lg4rCcydL7fHaObnOyrHHsW4jK9kJ8V5hhAMz5j4P9PyZyYtN7Hc=
X-Received: by 2002:a17:903:247:b0:201:e2db:7be3 with SMTP id
 d9443c01a7336-204e50afb13mr2895225ad.21.1724772621940; Tue, 27 Aug 2024
 08:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827053206.538814-1-kjain@linux.ibm.com>
In-Reply-To: <20240827053206.538814-1-kjain@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 27 Aug 2024 08:30:09 -0700
Message-ID: <CAP-5=fWBjt3pypEwEsbKsuNTqX+ZA7v9WbNJCUgc09xxF=pt1A@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf vendor events power10: Update JSON/events
To: Kajol Jain <kjain@linux.ibm.com>
Cc: acme@kernel.org, namhyung@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, hbathini@linux.ibm.com, 
	disgoel@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 10:33=E2=80=AFPM Kajol Jain <kjain@linux.ibm.com> w=
rote:
>
> Update JSON/events for power10 platform with additional events.
>
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>

For the series:
Reviewed-by: Ian Rogers <irogers@google.com>

Just to note, the moving of events in patches 2 and 3 is necessary as
the filename sets the "topic" in perf list. I'm not sure the whole
"topic" thing makes total sense and we may want to revisit it at some
date. For example, AMD generally put the topic into the event name,
the PMU gives a strong hint of "topic", etc.

Thanks,
Ian

> ---
>  .../arch/powerpc/power10/datasource.json      | 25 +++++++++++++++++++
>  .../arch/powerpc/power10/frontend.json        | 10 ++++++++
>  .../pmu-events/arch/powerpc/power10/pmc.json  |  5 ++++
>  3 files changed, 40 insertions(+)
>
> diff --git a/tools/perf/pmu-events/arch/powerpc/power10/datasource.json b=
/tools/perf/pmu-events/arch/powerpc/power10/datasource.json
> index 0eeaaf1a95b8..283284745d9c 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power10/datasource.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power10/datasource.json
> @@ -14,6 +14,31 @@
>      "EventName": "PM_DATA_FROM_MEMORY",
>      "BriefDescription": "The processor's data cache was reloaded from lo=
cal, remote, or distant memory due to a demand miss."
>    },
> +  {
> +    "EventCode": "0x0000004080",
> +    "EventName": "PM_INST_FROM_L1",
> +    "BriefDescription": "An instruction fetch hit in the L1. Each fetch =
group contains 8 instructions. The same line can hit 4 times if 32 sequenti=
al instructions are fetched."
> +  },
> +  {
> +    "EventCode": "0x000000026080",
> +    "EventName": "PM_L2_LD_MISS",
> +    "BriefDescription": "All successful D-Side Load dispatches for this =
thread that missed in the L2. Since the event happens in a 2:1 clock domain=
 and is time-sliced across all 4 threads, the event count should be multipl=
ied by 2."
> +  },
> +  {
> +    "EventCode": "0x000000026880",
> +    "EventName": "PM_L2_ST_MISS",
> +    "BriefDescription": "All successful D-Side Store dispatches for this=
 thread that missed in the L2. Since the event happens in a 2:1 clock domai=
n and is time-sliced across all 4 threads, the event count should be multip=
lied by 2."
> +  },
> +  {
> +    "EventCode": "0x010000046880",
> +    "EventName": "PM_L2_ST_HIT",
> +    "BriefDescription": "All successful D-side store dispatches for this=
 thread that were L2 hits. Since the event happens in a 2:1 clock domain an=
d is time-sliced across all 4 threads, the event count should be multiplied=
 by 2."
> +  },
> +  {
> +    "EventCode": "0x000000036880",
> +    "EventName": "PM_L2_INST_MISS",
> +    "BriefDescription": "All successful instruction (demand and prefetch=
) dispatches for this thread that missed in the L2. Since the event happens=
 in a 2:1 clock domain and is time-sliced across all 4 threads, the event c=
ount should be multiplied by 2."
> +  },
>    {
>      "EventCode": "0x000300000000C040",
>      "EventName": "PM_INST_FROM_L2",
> diff --git a/tools/perf/pmu-events/arch/powerpc/power10/frontend.json b/t=
ools/perf/pmu-events/arch/powerpc/power10/frontend.json
> index 53660c279286..456971f60814 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power10/frontend.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power10/frontend.json
> @@ -93,5 +93,15 @@
>      "EventCode": "0x400FC",
>      "EventName": "PM_ITLB_MISS",
>      "BriefDescription": "Instruction TLB reload (after a miss), all page=
 sizes. Includes only demand misses."
> +  },
> +  {
> +    "EventCode": "0x00000040B8",
> +    "EventName": "PM_PRED_BR_TKN_COND_DIR",
> +    "BriefDescription": "A conditional branch finished with correctly pr=
edicted direction. Resolved taken."
> +  },
> +  {
> +    "EventCode": "0x00000048B8",
> +    "EventName": "PM_PRED_BR_NTKN_COND_DIR",
> +    "BriefDescription": "A conditional branch finished with correctly pr=
edicted direction. Resolved not taken."
>    }
>  ]
> diff --git a/tools/perf/pmu-events/arch/powerpc/power10/pmc.json b/tools/=
perf/pmu-events/arch/powerpc/power10/pmc.json
> index 0e0253d0e757..04732698d9b2 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power10/pmc.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power10/pmc.json
> @@ -104,6 +104,11 @@
>      "EventName": "PM_RUN_CYC",
>      "BriefDescription": "Processor cycles gated by the run latch."
>    },
> +  {
> +    "EventCode": "0x200F8",
> +    "EventName": "PM_EXT_INT",
> +    "BriefDescription": "Cycles an external interrupt was active."
> +  },
>    {
>      "EventCode": "0x30010",
>      "EventName": "PM_PMC2_OVERFLOW",
> --
> 2.43.5
>
