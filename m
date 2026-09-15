Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7CA43DED3
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 20:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789505910; cv=pass; b=biGJe1BR1hCXPpERElYKgYjbd8XdR4QkQVm3eEEEdyUhEKPfVnAy46U8XKhQ0RbtX+ildzCQn3RoRRwKW0zGDz75MKr+wzLVV+feVzS44JhBTy7i3CdUiuUBWVQ5evG6cGlmLvp1/N/z3SrYNCbXYWqdUTWUfazwMDDCkFXxRvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789505910; c=relaxed/simple;
	bh=9CZZ1lSexM+A/bEG0bA93Zp2oQQtwi80WQ/8QFBXiY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nknvkHybAFd0PomHFaw6H0figvEykWRDlrWpAhC7YySGWv7I3Pu5UOo89/VOLLFkzykPOv2tSIJBHOrFutQ/Q0g8MMHcT99Fy+ivr8aA2iLjbokVlTo87KqYyKpuR8PchRQ8HbVKAZ1N1E2/na5zOu3ETpq9uSse6M9PP8K6wzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CfTXO/fa; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CfTXO/fa"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5306706e89dso19551cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 13:58:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789505907; cv=none;
        d=google.com; s=arc-20260327;
        b=jXBvKGoy4qPUfifaxBrKN8+kn+fSi4xPkpZCYyPGvl1SzMx94IzhyvCYPKpdgLoUcP
         lLU58RTquAv3WVy/6YPhjsXpK2k3nI0r2FlrHEP/Qo2slgKfZWg01egw1V69GcHSY0MN
         C6M48I7jTT5bL/KWN5jLfpOr8QbQ3vGBXzPRtKZW+GlZmeIWJd1xvzQgImgY31Q6X7Yy
         2z1DMNiQcHBz+mwOLbY1KZA4puQslxFRQCrryZeJXOKyWUdymNLw4gf2JRtRHmDkgSXg
         tqsNtS8woBLLFRHEKNr+GfoEmDxMMb4CXBa8Sk2kAzgiqpiDzhbg4SHfYC45MKknvBbb
         r9vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RD3YV+Ag/O3rxFgnrxZeCoIY4Orb7ZnIAVjQabSeajw=;
        fh=0Vr6L2T++DkALx6DB7kQ8gQWMJa1vU7gtZf+CGTkiR4=;
        b=oKU20cJ2cMqUPSGtuAae8X5TJfn/SDPCHHbLiECrSWlzqk69wvFekMSvVvW5jupNBu
         P75DbKaztMSNuXfDyXZ+0MybqQfGfHRsVMO6Rw0nhZc+ymXVGi1oy1THWa5nFMnu4u/s
         8XRTzRpgVDt1En7OBJUrEr4Osmg6vBc7HAwpNHLqCmOcNgwyUAnAlKYoqBG/RyIYB9cD
         0xvr51PMILYBM8YGnsZWPdc1gvkNio3+TETN5/Fc2e8EfOOO3UUDdpoMf8klOI1p8m0Z
         1wFHualH8m591+Q3NFRj/yiIddD28UL9CHd6BodHfMil1G7XCus/hyTEvMH2hv0URrLo
         HsVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789505907; x=1790110707; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RD3YV+Ag/O3rxFgnrxZeCoIY4Orb7ZnIAVjQabSeajw=;
        b=CfTXO/faH0oHwhIGXFB6xr/Zuv+Lnjy/hyuNoxgWg6WSd6WBBV+DafpKc4bhIoKDiH
         0+o28qtTdQ+V0nF6ow8sQD/YI0iQX3XFlr4yWrMF4BrWPe0FDcPh1hE/N/OvAF4SZ98Q
         0CXWI/7cI276ML3WSoa1oQb7YKfEhqtvKxWKhOwhrbJyk6qKE34sQ3RMfadNqEGaAVAY
         dW/Om/DhrL0sXncmycEsxAMejBMQz34OIsm9hreJLSbqb3vpg0gnRQhSN12S8Qm3R0Yg
         BQoSX22GmnE9qrOjrSYXxkbNKKLDfzgQppCttEWH+TCJQbmvBXLICBN3lCT66cHFEobm
         DtCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789505907; x=1790110707;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RD3YV+Ag/O3rxFgnrxZeCoIY4Orb7ZnIAVjQabSeajw=;
        b=d0bxIRq5wrNglJ3B5MIdvdhApYsoXQpfUErV1VN/iupJ7VDOae+AuCAWMlJrDif7kT
         7SC3veGFHBx5NaMqoyvei+tZr7T+5v25A8lRX8ub2N9mNQ1gVyi/FcNYYq9M5vLjklTF
         LEikus7LZk5oaeu6aErZPkmRyhHl12JHr8R4MwQgxhKrGYaC2Tz96cf2ZPlr70lbEbaI
         OJwjuXKVBnDs1Nt1SrTHSE4yxKmOCGN5lTxhiq72oXMAxCIeVlgC+FrHppvrDfavXzIE
         6vIyQsCzCb/+TmFhRMJDATzYV2Q5/9m8dtHXnaVWPDcG/yBTsTbyAMqjh+5aWg6vkpGt
         VWcQ==
X-Gm-Message-State: AFuF++m2n27zhptxxccTcaro9NVNiOKuzW6N4AWvm/zqhDRFqwQJySSe
	r907J6TGA+NQkTtMMqX8h3/1pl2Eezh6P5U5/V8WGV1iZ2T41SNc3iRloJs0VAvzxKKge4Pa74t
	ZGCXisDlMCkCh3ocsY6/Uz+F5IKcGW4iMAeAJebEQ
X-Gm-Gg: AYBFou1XbpU8NFhE9y7nGjYz1FDws9rWSwxTmvxYXdQWX3upl23HBDOIGaQc/41ggdU
	wi+uWoOhLwLqpisRehKAp5DM6/OEgGgDGOyNCKPl0cbatawbkdovqTiQMyD0nZ22z+YA4oNWoFh
	TNH0lzrYjGjSdKfWA6vubAncO3kfeuFWro7N4ssq9e/h80BxSRk9kMNsJ6RzNaKd8WHLKo0pT3n
	b4p+8eZhFmwDB3f2Mq/RvsY6ymDsuyTfzj2eNd0gfyMZoi1sRRoOSQPLmG9Z/iJW9TFGTgRi5VN
	UCPCLGZHsUCIdrMSN/GEz9UQSwzc4j6jA3fM7uPTptNorqO5Y1qJDyMIa87iEN9kaU/ojtoTuhI
	IpS6lTBH/PQ==
X-Received: by 2002:a05:622a:107:b0:517:5e32:2d14 with SMTP id
 d75a77b69052e-5327e9c6edamr627021cf.10.1789505906274; Tue, 15 Sep 2026
 13:58:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523011904.101720-1-rosenp@gmail.com>
In-Reply-To: <20260523011904.101720-1-rosenp@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Sep 2026 13:58:15 -0700
X-Gm-Features: AcwNN1U-8WxywffkLLYvhkBcpUNKYAH3OsXKdOrHioO2fViCnDS6cwyFq2mKBN0
Message-ID: <CAP-5=fXyyj6w1mR71B6e+j7sV9GA-Gs1ibfp5pCuY6T+W+xWjQ@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/amd/uncore: turn amd_uncore_ctx events into a
 flexible array
To: Rosen Penev <rosenp@gmail.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 6:19=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> The events pointer was kzalloc_node()'d immediately after the parent
> struct allocation, with the count (pmu->num_counters) trivially
> available beforehand.  Move events to the struct tail as a flexible
> array member and fold the two allocations into a single kzalloc_node()
> with struct_size(), dropping the separate kfree(ctx->events) in the
> free path.
>
> Assisted-by: Claude:Opus-4.7
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  arch/x86/events/amd/uncore.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
> index 05cff39968ec..0e265fc1fef8 100644
> --- a/arch/x86/events/amd/uncore.c
> +++ b/arch/x86/events/amd/uncore.c
> @@ -39,11 +39,11 @@ static int pmu_version;
>  struct amd_uncore_ctx {
>         int refcnt;
>         int cpu;
> -       struct perf_event **events;
>         unsigned long active_mask[BITS_TO_LONGS(NUM_COUNTERS_MAX)];
>         int nr_active;
>         struct hrtimer hrtimer;
>         u64 hrtimer_duration;
> +       struct perf_event *events[];

As the number of counters is fixed and events doesn't grow, this makes
sense to me. Dapeng, what do you think?

Thanks,
Ian

>  };
>
>  struct amd_uncore_pmu {
> @@ -488,10 +488,8 @@ static void amd_uncore_ctx_free(struct amd_uncore *u=
ncore, unsigned int cpu)
>                 if (cpu =3D=3D ctx->cpu)
>                         cpumask_clear_cpu(cpu, &pmu->active_mask);
>
> -               if (!--ctx->refcnt) {
> -                       kfree(ctx->events);
> +               if (!--ctx->refcnt)
>                         kfree(ctx);
> -               }
>
>                 *per_cpu_ptr(pmu->ctx, cpu) =3D NULL;
>         }
> @@ -536,18 +534,11 @@ static int amd_uncore_ctx_init(struct amd_uncore *u=
ncore, unsigned int cpu)
>                 /* Allocate context if sibling does not exist */
>                 if (!curr) {
>                         node =3D cpu_to_node(cpu);
> -                       curr =3D kzalloc_node(sizeof(*curr), GFP_KERNEL, =
node);
> +                       curr =3D kzalloc_node(struct_size(curr, events, p=
mu->num_counters), GFP_KERNEL, node);
>                         if (!curr)
>                                 goto fail;
>
>                         curr->cpu =3D cpu;
> -                       curr->events =3D kzalloc_node(sizeof(*curr->event=
s) *
> -                                                   pmu->num_counters,
> -                                                   GFP_KERNEL, node);
> -                       if (!curr->events) {
> -                               kfree(curr);
> -                               goto fail;
> -                       }
>
>                         amd_uncore_init_hrtimer(curr);
>                         curr->hrtimer_duration =3D (u64)update_interval *=
 NSEC_PER_MSEC;
> --
> 2.54.0
>
