Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AE5366DD4
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Nov 2025 16:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763570021; cv=none; b=dWc4jg9ahI4JY4crw3Z+6Mm13vaQOvL2KrBY0KGTP/vyhXl+ZdlKzp8/agrN+k4Vr1JMxeugIPsjZw+Wb8gcDNyMzLRHUPRP3eKif+ADdW5WKjMzy1xt/MPZWpMH4jMIy+byAn2iGw07oUB/2RFEedIO2qBbcp0eSisVVV1hyOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763570021; c=relaxed/simple;
	bh=YvLlwkR0sFXWx8ICmwu69vlBaWu+uc7QoJgjyewiXZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HBQXKDSOwJOS0ZTS6aclKfT1/lvCfp3Nnwnepds6fkMZ/XlTNhKR0JN//kZrhS7TVoGk7DRO4ZuUJNLPgPKHlaNF/b2APGynei6xWhYCybcXcm9eww0ecK3x+i/Zbvw3VKG4LWtVaPJls5dB2MTcWP2cp5s1n7n+2Tj2yiYR3tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TFX6rq2k; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TFX6rq2k"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-295c64cb951so259745ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Nov 2025 08:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763570019; x=1764174819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZFcdgpmrdvf5S0/a3UfoJ11QunHjJR5yDnx5SLMriE=;
        b=TFX6rq2ktYOylDjlSrjwRUJI0Jnh1whtG6J/TAb6rfYJ4u6ctmeqslnrSps5DNMIOs
         3WcTZNOyt8MH6UJKSJXxiwEREreKyJeL2HkjTS4r9CpJEbRs7LXWI5gCxhN6aKCFO2I7
         U2fGDT+cyg0KmYaSNXvdK5OFETVzPhu+ZmC6A0MlH1xth8nJgIDhPwwSFeaQp0FW1SjZ
         GJNvV+xfjiJsYD6q8PlT0aKLW4f5TxU7JyZVuKRCd5IJ3vg6RqGjzQiFDsHIDiJmo2kT
         TeobsNCm9rW+MLevfmPGvSLFmLXlxr8jagMOMTvq952kCFjb9EwmA6PkhZKJOESKn1Qj
         JmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763570019; x=1764174819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bZFcdgpmrdvf5S0/a3UfoJ11QunHjJR5yDnx5SLMriE=;
        b=RNrRm94sDc/mT88TaUOtllpwOU0rfQ69wAAQFHvi6dXMpZXJI/xozzDFOeJ8UTE4Ql
         DJpeedH3Lio/edimD8/H2nXWguykcwXesOm/2dxTeTvO4SEZ5kwGb6XyHwi7616pmrY7
         EWomDDRrUnYSNPj8s3HHQRXmoj1nyFkflv2OOGX5WuuZVLGMfGJzH9+oHy7ACS12S3nV
         QJBhm0eN5TbTV0qXQMmEnVEaBeHEBUOwFtlvAUU3yRLmtkXktot5/SyZ7ywIvkqTn846
         V0qrgWJbLAqVp+LTgIj4EEwJDEgP2mBWk82hCFR99lNWy9Tn8ws1Z90FQ77o8AMX1tvF
         iUww==
X-Forwarded-Encrypted: i=1; AJvYcCXz7vpjCtj/qhva0RuEYhezhaE+Mo0PB6azsLxTXxsNZM7Zo7llmGHxlQ6qOeij/0KCU5eMW2zgHlCvrBaK40Te@vger.kernel.org
X-Gm-Message-State: AOJu0YxuLKZREUn4nIRGhGh89EDdhusncXLMJnPjrLqb/cSSy+gn/Pjb
	iNxxN3bI4570R4L/hzO7mwSvg0K/jEpimMEvgwOXeMvflvzT9xiVql87dcC2fj1csb8mQY+YF4A
	AvPZpuDo7vPC5CUEXJcWBjDucWltxySf/omZ3LUezE0O/d69al4TgaPaKd50=
X-Gm-Gg: ASbGncs4fReHp3BoGyR71SqMchMpkJqvpukvfNbK5ub25UpvE1AkCAj0bh9TUCNSklA
	eNVhtYXl/B4/MH+Sya1L1eTvYPqBdO48pUVPwrlXu+gsm+K7pdtSwz6AXUbuQ0IbzfoClkNuYC0
	pEqwe/RsPHkzgH0qfSQHoHwlCC74O1z5ObF8fh4UJqCoJxfRSegX94Xi5UkR7QXJQRljnRNU9+/
	eJzwG+jqmOD3ZPhwu9VCZwfN2zGiHTV//Lb7lo/d3g1u2AOVpjDCC/OJWdhDi/izPbhL6SyRe0q
	R5N5uIsIIu1zB7maaYFy+2AyKw==
X-Google-Smtp-Source: AGHT+IHK0CVTzxvtaSfgeCCOWslR47PYRFT6AfCBn4tuqL+zi+z8txXS2jNwvNSzqY7aXMQQm8+XOumuB8p4q/W3I/I=
X-Received: by 2002:a05:7022:e25:b0:119:e56b:c1de with SMTP id
 a92af1059eb24-11c8dda980bmr112210c88.9.1763570018870; Wed, 19 Nov 2025
 08:33:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118063641.517066-1-namhyung@kernel.org>
In-Reply-To: <20251118063641.517066-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 19 Nov 2025 08:33:27 -0800
X-Gm-Features: AWmQ_bmC68uis_qvPbfD18xThgKbqF6g5L4omo-vIOQ81TfJL0KatCk3LoukJfQ
Message-ID: <CAP-5=fUEiPncL3Xe9WoDqWBTTxqw7dXxudx7-8muzppmz6JEXA@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf list: Print matching PMU events for --unit
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 10:36=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> When --unit option is used, pmu_glob is set to the argument.  It should
> match with event PMU and display the matching ones only.  But it also
> shows raw events and metrics after that.
>
>   $ perf list --unit tool
>   List of pre-defined events (to be used in -e or -M):
>
>   tool:
>     core_wide
>          [1 if not SMT,if SMT are events being gathered on all SMT thread=
s 1 otherwise 0. Unit: tool]
>     duration_time
>          [Wall clock interval time in nanoseconds. Unit: tool]
>     has_pmem
>          [1 if persistent memory installed otherwise 0. Unit: tool]
>     num_cores
>          [Number of cores. A core consists of 1 or more thread,with each =
thread being associated with a logical Linux CPU. Unit: tool]
>     num_cpus
>          [Number of logical Linux CPUs. There may be multiple such CPUs o=
n a core. Unit: tool]
>     ...
>     rNNN                                               [Raw event descrip=
tor]
>     cpu/event=3D0..255,pc,edge,.../modifier              [Raw event descr=
iptor]
>          [(see 'man perf-list' or 'man perf-record' on how to encode it)]
>     breakpoint//modifier                               [Raw event descrip=
tor]
>     cstate_core/event=3D0..0xffffffffffffffff/modifier   [Raw event descr=
iptor]
>     cstate_pkg/event=3D0..0xffffffffffffffff/modifier    [Raw event descr=
iptor]
>     drm_i915//modifier                                 [Raw event descrip=
tor]
>     hwmon_acpitz//modifier                             [Raw event descrip=
tor]
>     hwmon_ac//modifier                                 [Raw event descrip=
tor]
>     hwmon_bat0//modifier                               [Raw event descrip=
tor]
>     hwmon_coretemp//modifier                           [Raw event descrip=
tor]
>     ...
>
>   Metric Groups:
>
>   Backend: [Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet]
>     tma_core_bound
>          [This metric represents fraction of slots where Core non-memory =
issues were of a bottleneck]
>     tma_info_core_ilp
>          [Instruction-Level-Parallelism (average number of uops executed =
when there is execution) per thread (logical-processor)]
>     tma_info_memory_l2mpki
>          [L2 cache true misses per kilo instruction for retired demand lo=
ads]
>     ...
>
> This change makes it print the tool PMU events only.

Perhaps this can be used to simplify tests like:
https://lore.kernel.org/lkml/20251109005959.2540616-2-irogers@google.com/

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-list.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index 16400366f8276a7a..28bf1fc7f5eeff8f 100644
> --- a/tools/perf/builtin-list.c
> +++ b/tools/perf/builtin-list.c
> @@ -130,7 +130,7 @@ static void default_print_event(void *ps, const char =
*topic,
>         if (deprecated && !print_state->deprecated)
>                 return;
>
> -       if (print_state->pmu_glob && pmu_name && !strglobmatch(pmu_name, =
print_state->pmu_glob))
> +       if (print_state->pmu_glob && (!pmu_name || !strglobmatch(pmu_name=
, print_state->pmu_glob)))
>                 return;
>
>         if (print_state->exclude_abi && pmu_type < PERF_TYPE_MAX && pmu_t=
ype !=3D PERF_TYPE_RAW)
> @@ -612,8 +612,10 @@ int cmd_list(int argc, const char **argv)
>         print_cb.print_start(ps);
>
>         if (argc =3D=3D 0) {
> -               default_ps.metrics =3D true;
> -               default_ps.metricgroups =3D true;
> +               if (!unit_name) {
> +                       default_ps.metrics =3D true;
> +                       default_ps.metricgroups =3D true;
> +               }
>                 print_events(&print_cb, ps);
>                 goto out;
>         }
> --
> 2.52.0.rc1.455.g30608eb744-goog
>
