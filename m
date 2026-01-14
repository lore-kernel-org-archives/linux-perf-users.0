Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF7A3A63F1
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409518; cv=pass; b=ci9fT/b0OslnJLtZKQ1FVerTPpUQd9N3L4T+itbBdrBpAH7rmtC8FzXZZ0wgR7daorwm9hC+O0VBo3iS3t+J2jZc8G7vJDUc6CchCyXKAnl1g8Hz0bgeKQ/L6WmewVfZDZwnewDYO6rvKMWFnAZ/9KoYjEVMYw94vis/BcXcDXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409518; c=relaxed/simple;
	bh=jWogNs53az+Rs1PuEAxyR/b9r0dN84B0kirZzZTCtew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JS+un+jGBERq5co7E4+s1rkZAUPLncW7FiUruL+qv/IuJ9/Xtp3+mm0VmwAdv1T4qYqKxOCZh+tj2jSf9mrzmRZfboDcw1oksbEPsrFnpR9olamCqYIX0ProjommXvI1KqKNPjrXp0+tUORfKnBYmxJT36zpp1eAdacZaD1xYcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GvZAeLAr; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GvZAeLAr"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a35ae38bdfso81445ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 08:51:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768409516; cv=none;
        d=google.com; s=arc-20240605;
        b=Yr0nbF6wJYrCxwIxIddFgQJO/xO5Yr+tGuwunpeeNl7x67Ra/tYhJXK3Qs06JN/tJQ
         rW5ArOxkDyCceirufxzbZND2/AWXuJ1vSsZEEANRygW4dpdbLmfRwxnVyjcBSRwWuQsq
         OcuqPJYbRwQCc+4K7N56dLmEshZEqRmmFtiqJ6QAIZQ88n1LaHZugK5eHJpYm8jcxXrK
         /SE701H8tizQSQ6+E8FXKA2kfcY1M2P8pg1J7wsGneIBT3Ve4wmNC3UzH0NdWQGsgWxI
         eg3IsHgPR+dPi7MO/SMswE5VbxACNF0hko20oL4XQ48yCX7u88xdtjLJUqaT+29VjAu8
         z7Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kjv1wVcnUYn4H9c+GgiFr/qboEWraopFEvmNwvkz1TM=;
        fh=OxlX7mkbcJuXZ5Odq0D6Yx9L7A6TyA203dZ7jBc4gh0=;
        b=E+8zX8vrcs2ibl7PPrGqLWbed2QRJEhlugdXAoVuE3cHbo03c9cuVWzqe3SOEd8wyp
         Uw/ZagqGllaajWd/EodYqyRWyWavFa5qMX2R++SThWbEFr6ObilyxrujRzmqasPb16ny
         ylJYpJ5ECKcWzYE30jTRkhb+m6rIaz5ifI4cTJrfPQJHc6fUA6GQWN9x7TiJF29u3GhF
         +BjuCUBJn5ez+H5ejrZaStuFcsyOQXl+Px+JjtAcRvWaGJvlgBqgQ0G2ObnDzK7wiNyV
         v9/Z4XPD0aLktHgRQezKfSLCR6mi3j4TgJvx/KAZtyqARKdPOPVcfeIHr6245F4IDgS6
         EBAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768409516; x=1769014316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kjv1wVcnUYn4H9c+GgiFr/qboEWraopFEvmNwvkz1TM=;
        b=GvZAeLArA02GMJu6JNMdirR5dRGVHhPci0vwhDRUaaoonrO+aXhTd9cIxgVjTtTPRr
         b1cz9aWdLCCUf/TEQvP+91zA1uwiLWfSqQsc2RnNlqoWTGyOhIhXpLzLlDsAF33hW4yU
         ThZVy1qCFOynhGBN3ArZjpVlJ4Rivr/Me2l7mp/Z+kaN/82knWfttPiaW60B31+t5tcj
         447l6n4wSuwq9c9mQkcfv0syE7QVOUhJJq06po8nS+j2D4eSGkcgyYpvNCDalaHEB8F+
         K/vkq+HVXJld1u/wcKdnszEjwB8kQOHjG7UMamxAkzD6rkEntf5ZhpxQttliEnzSl4sc
         UigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768409516; x=1769014316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kjv1wVcnUYn4H9c+GgiFr/qboEWraopFEvmNwvkz1TM=;
        b=lMddmdVNE0VLwLffqGwTLKuZNbewAmNRF2vdTfPo97mXxM1QGd7CUEcbQ+OzMpKmCJ
         5PqWBd6EEhGHOe+hOvIj3dFSZ2k3bkXMHMMqxYwfwmgCyCcp+JW54wwbFywc+ebElxdB
         QOv9TxP0pX2lhhjZpZOxHFmHcEXnB4TmCrfGPWQ6rk0Vot6wS/eJc+bbBnYrvnwu3Gx/
         jyJYgwJTye9B187HmcBv1JKH/4G8PuppkeXhLGahbqQbR4yErNTtglAyYha8QMeUAYVW
         kycUXcEcfAexHvK4a6Ue3pKBNakhFhfOAzBAcCB1KzO+7Cg7DmFwqsL446a2PGGAW9Zt
         esig==
X-Forwarded-Encrypted: i=1; AJvYcCX9gHjHJiq8bnEAN+AXiAsId+J1sV4tba7HTEJwDinslPG+yJ0V1S1pXAE/UTcm7xXmxWjzoDZ85FtTUR9qdwDS@vger.kernel.org
X-Gm-Message-State: AOJu0Yx46Za7oFsBoHsV6BTnScwq9FNvcmlzK8X5eKV4HVD6/ecn8/OJ
	8koUBs0T7vvWwnhScTXnIMtkFR/ATat/HmDQvVU0DIfo53WW7RTMp4Bi8LxWaNSDgJFCI7D4zwc
	4qOF3VZ3exSrEyrQCrnquR+fcfNljqz0PIwqe1RQ9
X-Gm-Gg: AY/fxX4mwbCozVLd+YsLpIO/C7KytRZdGM88eyh7MraTiRZsoKBVsidugEurQblUvzB
	6ZXLpds1zjXTKvDOBTzN2c2mJKi/iu4Fm7oXwBtgYWG5TIstuYPmiUGmUF0vvuNEzGSi6rYxU10
	hyPmTjIt/YUXy+RSDQANFAffhtXgPpU11T7zDxiJ8wadLBD7QhO00RohH+xo2GmJRZUydvkaK6H
	UNBrr6AYqnqPfWpckhV+XuwbUUQv15bB/Tqi13yW6ZI1sbdxETe/uCGJFvZB6gH3r15yPSCOePP
	FL7mQ8QzmG96DuTnMDfJESH2dg==
X-Received: by 2002:a17:902:ec85:b0:290:8ecf:e9f9 with SMTP id
 d9443c01a7336-2a59a918840mr2977165ad.7.1768409515777; Wed, 14 Jan 2026
 08:51:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114-james-perf-config-bits-v5-0-0ef97aaf1ac0@linaro.org> <20260114-james-perf-config-bits-v5-2-0ef97aaf1ac0@linaro.org>
In-Reply-To: <20260114-james-perf-config-bits-v5-2-0ef97aaf1ac0@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 14 Jan 2026 08:51:44 -0800
X-Gm-Features: AZwV_QgNKI19hlQFGQLMSXvqf0jhHCIRBL8Kn4OmCTj3y6VKnMxjSZb2KJMrP80
Message-ID: <CAP-5=fUuFAj_wtJ+PMq8iS3gs5Z8XErYdcBeYnEMU_wSb3UAkw@mail.gmail.com>
Subject: Re: [PATCH v5 02/14] perf evsel: Refactor evsel__set_config_if_unset()
 arguments
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 7:57=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> Make the evsel argument first to match the other evsel__* functions
> and remove the redundant pmu argument, which can be accessed via evsel.
>
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/arch/arm/util/cs-etm.c    | 9 +++------
>  tools/perf/arch/arm64/util/arm-spe.c | 2 +-
>  tools/perf/arch/x86/util/intel-pt.c  | 3 +--
>  tools/perf/util/evsel.h              | 4 ++--
>  tools/perf/util/pmu.c                | 6 +++---
>  5 files changed, 10 insertions(+), 14 deletions(-)
>
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util=
/cs-etm.c
> index ea891d12f8f4..c28208361d91 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -441,10 +441,8 @@ static int cs_etm_recording_options(struct auxtrace_=
record *itr,
>          * when a context switch happened.
>          */
>         if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
> -               evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
> -                                          "timestamp", 1);
> -               evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
> -                                          "contextid", 1);
> +               evsel__set_config_if_unset(cs_etm_evsel, "timestamp", 1);
> +               evsel__set_config_if_unset(cs_etm_evsel, "contextid", 1);
>         }
>
>         /*
> @@ -453,8 +451,7 @@ static int cs_etm_recording_options(struct auxtrace_r=
ecord *itr,
>          * timestamp tracing.
>          */
>         if (opts->sample_time_set)
> -               evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
> -                                          "timestamp", 1);
> +               evsel__set_config_if_unset(cs_etm_evsel, "timestamp", 1);
>
>         /* Add dummy event to keep tracking */
>         err =3D parse_event(evlist, "dummy:u");
> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64=
/util/arm-spe.c
> index d5ec1408d0ae..51014f8bff97 100644
> --- a/tools/perf/arch/arm64/util/arm-spe.c
> +++ b/tools/perf/arch/arm64/util/arm-spe.c
> @@ -274,7 +274,7 @@ static void arm_spe_setup_evsel(struct evsel *evsel, =
struct perf_cpu_map *cpus)
>          */
>         if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
>                 evsel__set_sample_bit(evsel, CPU);
> -               evsel__set_config_if_unset(evsel->pmu, evsel, "ts_enable"=
, 1);
> +               evsel__set_config_if_unset(evsel, "ts_enable", 1);
>         }
>
>         /*
> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/ut=
il/intel-pt.c
> index b394ad9cc635..c131a727774f 100644
> --- a/tools/perf/arch/x86/util/intel-pt.c
> +++ b/tools/perf/arch/x86/util/intel-pt.c
> @@ -664,8 +664,7 @@ static int intel_pt_recording_options(struct auxtrace=
_record *itr,
>                 return 0;
>
>         if (opts->auxtrace_sample_mode)
> -               evsel__set_config_if_unset(intel_pt_pmu, intel_pt_evsel,
> -                                          "psb_period", 0);
> +               evsel__set_config_if_unset(intel_pt_evsel, "psb_period", =
0);
>
>         err =3D intel_pt_validate_config(intel_pt_pmu, intel_pt_evsel);
>         if (err)
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index a08130ff2e47..2cf87bc67df7 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -575,8 +575,8 @@ void evsel__uniquify_counter(struct evsel *counter);
>         ((((src) >> (pos)) & ((1ull << (size)) - 1)) << (63 - ((pos) + (s=
ize) - 1)))
>
>  u64 evsel__bitfield_swap_branch_flags(u64 value);
> -void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evse=
l,
> -                               const char *config_name, u64 val);
> +void evsel__set_config_if_unset(struct evsel *evsel, const char *config_=
name,
> +                               u64 val);
>
>  bool evsel__is_offcpu_event(struct evsel *evsel);
>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 956ea273c2c7..e87c12946d71 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1382,8 +1382,8 @@ bool evsel__is_aux_event(const struct evsel *evsel)
>   * something to true, pass 1 for val rather than a pre shifted value.
>   */
>  #define field_prep(_mask, _val) (((_val) << (ffsll(_mask) - 1)) & (_mask=
))
> -void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evse=
l,
> -                               const char *config_name, u64 val)
> +void evsel__set_config_if_unset(struct evsel *evsel, const char *config_=
name,
> +                               u64 val)
>  {
>         u64 user_bits =3D 0, bits;
>         struct evsel_config_term *term =3D evsel__get_config_term(evsel, =
CFG_CHG);
> @@ -1391,7 +1391,7 @@ void evsel__set_config_if_unset(struct perf_pmu *pm=
u, struct evsel *evsel,
>         if (term)
>                 user_bits =3D term->val.cfg_chg;
>
> -       bits =3D perf_pmu__format_bits(pmu, config_name);
> +       bits =3D perf_pmu__format_bits(evsel->pmu, config_name);
>
>         /* Do nothing if the user changed the value */
>         if (bits & user_bits)
>
> --
> 2.34.1
>
