Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D395555787
	for <linux-perf-users@vger.kernel.org>; Mon, 25 Mar 2024 14:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711377839; cv=none; b=ka07s3DYhYdZMvexokc4UYLZNaJmHqZE6C7AnBUmlfAFouWy3wS7FShmOcLyhrO7f2yN37YoIvQnE7aEZSZg00zfqu11Ou/IQYIg0t8kFsJJAdbHgvUtg05YhnWAHp/chGtmq6rI4GzUYtjT0VUFZFddyBS5Wu/YXu4L0ZEzJCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711377839; c=relaxed/simple;
	bh=uZ7l3DAUH0jzgniBRAaHY7ESRtkZ9e1YZS3wFJnyG+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/5mio68Y2cVlHqyCyOUf3yHcvamJtSrB5vMYuVvwVRYIthQUzjwPdhHvbWoTr5pvIJiuAY/2H5NJs0dBeBLnpqXfmx2RUK98JgEFLcfEn52EUXPKUPd6mxUvLgF1eZvJByYa1Jxxlr1+hWhcFF3isQVIJwDoc9HNKDxTe/T4gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LceYcyWe; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LceYcyWe"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e062f3a47bso255235ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 25 Mar 2024 07:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711377837; x=1711982637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5Tz4JzRaeilAmpXVtwQ7m+zHtt96fktqhxswQN8qjA=;
        b=LceYcyWeN7X8TbGqxUewEVIA6AjqzosLYl8DhBXDoQiVsTpAVmy8KVKr07AjDKlH9J
         4c05kCl/S6EpsV0JTwM+RHBoMOmcuyfCfFbqW7TJ8rvTl5Dn054sCJj1qGZz27pGZmfd
         ShyDYgp6hEF5M8J53D3VXrf1IxrDEqcdIgZGtnz+Z4WTA8FcWNzQx6IgPaEYoP+y8isM
         jMonjIIWJrDc6VgvslH671JvZTGCHRUV6kv16a0WkElpaV1GIifPbO3AjoiOU64QnF2i
         VszIxrTskiwRkQQ1b6wGRHrpxQFjaSeBk09li2AxawVCOj9t0YFvP5gTbjXwBRzeOpC4
         vO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711377837; x=1711982637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5Tz4JzRaeilAmpXVtwQ7m+zHtt96fktqhxswQN8qjA=;
        b=il1vODI/254g6OgrcXZvtx8rzmTH7K33Cf7Oo64TFsSkVyvlYMHMYVM3BrXLk/L5XZ
         VhhbF6fVwI10h0KfibtAq4M1bbdKSZfxTK343/6+nvLGCimGiEx/WOTBsykoffcRi4ra
         5ARtcyrjyIHJ0PhRQkdJ543zk768FzJy0ZZFmSNsp02qergHV+Ym3ZdJqMyHzRj1dWl6
         y/JCovm/QOieiR+SRSM5SIbd0TyPtMfYzBPRIAja+/t50dpdag/XB47i+Y9za7LQh0yS
         /YEgnepogaI2dIeHco8TBJulx8v6lFFEoDsJuF2lVqnIRzk3D6odQ9C2GhCzm+uzJQeS
         hD0w==
X-Gm-Message-State: AOJu0Yxw9U52zLnL8ykoJ26nvIGR+3ReImPAEM0DiU2ToU9iyu9ANIiG
	fUzq/Vf8L2L5rdIeXF041g88fi3NQEbWGFAAQGK78BjTSQKlRsBPyCzMwLJ3Y0QU81O0N1wYcts
	EskD/0xja32xZP+AwE9vN9Si1uu3cyCDI4Pm/
X-Google-Smtp-Source: AGHT+IFcUN7qJyS2RwqfjuGciMj5fXU+3GZkKXkzApjhYvRQ+07rzd+6rFGLZ9TankLm4DnpryomqZ63PRhaO4JJh+I=
X-Received: by 2002:a17:903:228e:b0:1e0:c567:bb4b with SMTP id
 b14-20020a170903228e00b001e0c567bb4bmr126187plh.16.1711377836816; Mon, 25 Mar
 2024 07:43:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711352180.git.sandipan.das@amd.com> <089155f19f7c7e65aeb1caa727a882e2ca9b8b04.1711352180.git.sandipan.das@amd.com>
In-Reply-To: <089155f19f7c7e65aeb1caa727a882e2ca9b8b04.1711352180.git.sandipan.das@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 25 Mar 2024 07:43:46 -0700
Message-ID: <CAP-5=fVFh8rN24JnUUGx2DjYBSY6HCHi00tvC3=HBow3oTpMbw@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf/x86/amd/core: Add ref-cycles event for Zen 4 and later
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, peterz@infradead.org, mingo@kernel.org, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de, bp@alien8.de, 
	eranian@google.com, ravi.bangoria@amd.com, ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 12:48=E2=80=AFAM Sandipan Das <sandipan.das@amd.com=
> wrote:
>
> Add the "ref-cycles" event for AMD processors based on Zen 4 and later
> microarchitectures. The backing event is based on PMCx120 which counts
> cycles not in halt state in P0 frequency (same as MPERF).

This reminds me that we lack smi cost and an smi_cycles metric for
AMD, here is an Intel one:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json?h=3Dperf-tools-=
next#n274
The metric uses APERF but runs with freeze_on_smi set:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/builtin-stat.c?h=3Dperf-tools-next#n2115
so the delta between cycles and aperf is the cycles in SMI. It would
be great if we could get something similar on AMD.

> Signed-off-by: Sandipan Das <sandipan.das@amd.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  arch/x86/events/amd/core.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index afe4a809f2ed..685bfa860d67 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -273,8 +273,23 @@ static const u64 amd_zen2_perfmon_event_map[PERF_COU=
NT_HW_MAX] =3D
>         [PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =3D 0x00a9,
>  };
>
> +static const u64 amd_zen4_perfmon_event_map[PERF_COUNT_HW_MAX] =3D
> +{
> +       [PERF_COUNT_HW_CPU_CYCLES]              =3D 0x0076,
> +       [PERF_COUNT_HW_INSTRUCTIONS]            =3D 0x00c0,
> +       [PERF_COUNT_HW_CACHE_REFERENCES]        =3D 0xff60,
> +       [PERF_COUNT_HW_CACHE_MISSES]            =3D 0x0964,
> +       [PERF_COUNT_HW_BRANCH_INSTRUCTIONS]     =3D 0x00c2,
> +       [PERF_COUNT_HW_BRANCH_MISSES]           =3D 0x00c3,
> +       [PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =3D 0x00a9,
> +       [PERF_COUNT_HW_REF_CPU_CYCLES]          =3D 0x100000120,
> +};
> +
>  static u64 amd_pmu_event_map(int hw_event)
>  {
> +       if (cpu_feature_enabled(X86_FEATURE_ZEN4) || boot_cpu_data.x86 >=
=3D 0x1a)
> +               return amd_zen4_perfmon_event_map[hw_event];
> +
>         if (cpu_feature_enabled(X86_FEATURE_ZEN2) || boot_cpu_data.x86 >=
=3D 0x19)
>                 return amd_zen2_perfmon_event_map[hw_event];
>
> --
> 2.34.1
>
