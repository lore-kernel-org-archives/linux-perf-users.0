Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E171CD20
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Mar 2024 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473148; cv=none; b=PmaEiLH7hs79rQXvwg8s7RmzdCIoTfDMia1RUktjmSw+2GI/ljGiRqinGZMd4UOS74I1CRHqP7zPOO386N6Td4UipTfquDmtediV4kBhCtOAHNpzaA8Z0byP7/xq87ezBCC0uZIiRn3m0g9sslFP0ZEzZKYeIF18norvhZOYg+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473148; c=relaxed/simple;
	bh=Nn+jyV1CmuYPaPVKf9/XdKNUA2nxqqM2/aFrXcKaPXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KYFW7eCgPQ88P13w3iT5b73uv11jM5XicK0V7rwF7doYdUIjAOrxfONbfzzFMFADiYEWHXX5nEQNtIa3xeUwNdPziCRRkGY8SaKFJQDC02UJtpx9xOrfzvzCW4QQquEYTpyu3Ts2c2Go2yMoPD6YVwljs+8ussGbnYdBjq57Loo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XoxIJqrR; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XoxIJqrR"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-428405a0205so12151cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 26 Mar 2024 10:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711473146; x=1712077946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVwkIf3DHeuSOL+zi67l5mYb/1ILopcRWhEA+naqBfs=;
        b=XoxIJqrRuWWnxwN6d2MB6d01ElMv4Qy8mcf1SHQwrmzhfqhnrgwxF051vNW7jA2rPI
         rLRNpVyfZcmfqhKCx9QuOvzubfG9tqtJCVQZp8bYos/4IkOcdnh6vVRp21/ghNzBFr+g
         jdG1+iwMu138Idyh+3Swc/0yHOT3NpLUJFoRSPY6E0V1dvU/f4/dgyzKIAy+BUUtO4Sv
         tVU/2zAMkLrYuTnEYnpVYZJeTy/lS2f19gk4+bF71F0Z534gAFu6l+YYBa0T9na34OUr
         wNYPYFUa2PrO8Tx47FB/FeE9xmRZ2FsDxbn7/yPE1BTOmOPHTmutCbJ2M6DMhNY+SReB
         l/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711473146; x=1712077946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVwkIf3DHeuSOL+zi67l5mYb/1ILopcRWhEA+naqBfs=;
        b=JEGZk1A4RkjiC2Tf4ZEXOMN1rQKFZz/6DZkurKKHJ2aaoliNMcYfDcX2ph4FGBn7Q4
         OqjaqJEFTTDAa2Aem0pwKJSoE9HtC2wqxpYLR8v9G+2PjV3ct5P5OBdje17zVNNrOozb
         kn/QSdZbH5enzdH9voNo94qO4MudvLFM5m9y/KM+WFBdKotcaaYHWDW16d7iHf6y3s0u
         jrs2KYDaicTNB82xhKNhjm4G0kBWBVjH3L/uxiLTZcz1nkVu+gsql5nB8lMOVh+p2ArP
         v7haL+Wxzy+kTJfr0gZC8kd7Oc1hlLdEfj/GAvhBjLRLvnHR3nDKEREytqm1KL4ZTI58
         6N/A==
X-Gm-Message-State: AOJu0YzUksZx+PNPEZ3/63ZRb/uSWoiwCvQ10dDGFVoDdlOQ3mYyn1cz
	GzBpL59TgY64zf5AAnenhlmPkMwkmoeSJJwJnrobB2HOnTi7BKVL05jaQD/N4W2qk4drQjxXGhR
	1crh0baD7kVFsiXGmPSX167LbQxacdoQFw49M
X-Google-Smtp-Source: AGHT+IEA9aoUQEsX3Z6tTEAiIMkoSxoEBu5q775kQlVQLkZKLZwOi6kHFgmq1HAv48XmKy8R2nPPNprN8GGZPs5nuL8=
X-Received: by 2002:a05:622a:428f:b0:431:39b7:3217 with SMTP id
 cr15-20020a05622a428f00b0043139b73217mr245656qtb.20.1711473145613; Tue, 26
 Mar 2024 10:12:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711352180.git.sandipan.das@amd.com> <089155f19f7c7e65aeb1caa727a882e2ca9b8b04.1711352180.git.sandipan.das@amd.com>
 <CAP-5=fVFh8rN24JnUUGx2DjYBSY6HCHi00tvC3=HBow3oTpMbw@mail.gmail.com> <3de9ea09-5a30-4469-95b6-c752e3a485ab@amd.com>
In-Reply-To: <3de9ea09-5a30-4469-95b6-c752e3a485ab@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 26 Mar 2024 10:12:11 -0700
Message-ID: <CAP-5=fU3B9-Umb4WrvGEGpwHdu+f3ix+paFv4H3v-sxH39HyhA@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf/x86/amd/core: Add ref-cycles event for Zen 4 and later
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, peterz@infradead.org, mingo@kernel.org, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de, bp@alien8.de, 
	eranian@google.com, ravi.bangoria@amd.com, ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 11:16=E2=80=AFPM Sandipan Das <sandipan.das@amd.com=
> wrote:
>
> On 3/25/2024 8:13 PM, Ian Rogers wrote:
> > On Mon, Mar 25, 2024 at 12:48=E2=80=AFAM Sandipan Das <sandipan.das@amd=
.com> wrote:
> >>
> >> Add the "ref-cycles" event for AMD processors based on Zen 4 and later
> >> microarchitectures. The backing event is based on PMCx120 which counts
> >> cycles not in halt state in P0 frequency (same as MPERF).
> >
> > This reminds me that we lack smi cost and an smi_cycles metric for
> > AMD, here is an Intel one:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json?h=3Dperf-to=
ols-next#n274
> > The metric uses APERF but runs with freeze_on_smi set:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/builtin-stat.c?h=3Dperf-tools-next#n2115
> > so the delta between cycles and aperf is the cycles in SMI. It would
> > be great if we could get something similar on AMD.
> >
>
> Thanks for the suggestion. I found PMCx02B ("ls_smi_rx" in perf JSONs) in
> the AMD PPRs which counts the number of SMIs received but there's no way
> to know how many cycles were spent in System Management Mode. I also coul=
d
> not find an equivalent for the Freeze on SMI feature.

Thanks Sandipan, I found similar. Fwiw on Intel I'd written this in
the new (out for review) python format stuff:
https://lore.kernel.org/lkml/20240314055919.1979781-4-irogers@google.com/

Ian

> >> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
> >
> > Thanks,
> > Ian
> >
> >> ---
> >>  arch/x86/events/amd/core.c | 15 +++++++++++++++
> >>  1 file changed, 15 insertions(+)
> >>
> >> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> >> index afe4a809f2ed..685bfa860d67 100644
> >> --- a/arch/x86/events/amd/core.c
> >> +++ b/arch/x86/events/amd/core.c
> >> @@ -273,8 +273,23 @@ static const u64 amd_zen2_perfmon_event_map[PERF_=
COUNT_HW_MAX] =3D
> >>         [PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =3D 0x00a9,
> >>  };
> >>
> >> +static const u64 amd_zen4_perfmon_event_map[PERF_COUNT_HW_MAX] =3D
> >> +{
> >> +       [PERF_COUNT_HW_CPU_CYCLES]              =3D 0x0076,
> >> +       [PERF_COUNT_HW_INSTRUCTIONS]            =3D 0x00c0,
> >> +       [PERF_COUNT_HW_CACHE_REFERENCES]        =3D 0xff60,
> >> +       [PERF_COUNT_HW_CACHE_MISSES]            =3D 0x0964,
> >> +       [PERF_COUNT_HW_BRANCH_INSTRUCTIONS]     =3D 0x00c2,
> >> +       [PERF_COUNT_HW_BRANCH_MISSES]           =3D 0x00c3,
> >> +       [PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =3D 0x00a9,
> >> +       [PERF_COUNT_HW_REF_CPU_CYCLES]          =3D 0x100000120,
> >> +};
> >> +
> >>  static u64 amd_pmu_event_map(int hw_event)
> >>  {
> >> +       if (cpu_feature_enabled(X86_FEATURE_ZEN4) || boot_cpu_data.x86=
 >=3D 0x1a)
> >> +               return amd_zen4_perfmon_event_map[hw_event];
> >> +
> >>         if (cpu_feature_enabled(X86_FEATURE_ZEN2) || boot_cpu_data.x86=
 >=3D 0x19)
> >>                 return amd_zen2_perfmon_event_map[hw_event];
> >>
> >> --
> >> 2.34.1
> >>
>
