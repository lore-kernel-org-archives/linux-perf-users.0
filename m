Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6268017556B
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Apr 2024 16:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494173; cv=none; b=srhvwluYZnGr5yctjakHI47BrYBoESpDDzgwcEtnX7qsiwtfkhUUU/TalDKyqltf+qlWPpBFnkopcwepwWTzU5N03Na21hzwWBpEAf2+i0nKvCCsaK1bFbXpWvz9vCa3EGwhoSDmxspR7gX80Sw83rxW4/wbTmgwqF/NBHFVSZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494173; c=relaxed/simple;
	bh=L1w1/51e9DaD4SOZkZNtb26qg3oa8sZRGBr0x071Hsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KTYhfw/uDE8lryC2bSGy/rou+5k6ismF3wxIuoh/o+UN0v7cjRJZISGZtaXLLlzzVVXTa3zWqK319iez78vJq76vFtA3PYTRbtcdNPfS/9nV1NFTWntdbIBx+cQvjoHbkZl+wVP0ARQWbO4ij/inIxfqKJyvpmhzlJxv29etX/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eNw5lnTr; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eNw5lnTr"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-439b1c72676so500821cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Apr 2024 09:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714494170; x=1715098970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Pr68tC7zaGFrL1IgvXTGlK5jZYArtgYfkp+AHywlPE=;
        b=eNw5lnTr7AcRKNCMMTOyj/NhOwlwUTlR4VN829d8WFhMFoAXEbkERV5hYUaYG/CheX
         PSqpQ5IM3WD5jQ/BBce34mMy1FnBkn+sBZmQt/vcVoPokjIuIZhCSa2/k2+PyY4WtwE/
         q88yqgJgMjj9s4QGiqepThsIgrQ9gcuvCVxce2y15HnlG0g0Fc1IXOFKIRiSvOVMGnH4
         s85+E8JH1o4ZuP2ej7+mreTn6Lhew++mDbL9n3hfpfdJ9vP04oaM0Cv1IvzFQA9WH+Cb
         dEaNolCGLj9hbWhYlqVwMg+WblUl78ValJT8G143LbAutmhweWo4LsmAhoGCHW7fLJJq
         jcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714494170; x=1715098970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Pr68tC7zaGFrL1IgvXTGlK5jZYArtgYfkp+AHywlPE=;
        b=vpTEB03i0baxEWP5ei6wBjTtMZU+xaSbOlD+aDRQebIAhrFr0YdLAz8wH2sRfKbfiy
         HuJmcZ6Ov20h+MM2DozDCiey7Nu39AzwQL9L1fO+w/Vn5RpgVrQDO7lJynjWuNQEtryV
         f3vQlceYcluN6q3uUTJw77Zi9NQGbX6PPMdovMTe9NL1QMEWnwAe1E54l2zbQEOCFdnA
         oEzNreuQ3WjA2QH/XTcWEV/tZ88uKlg3lGom731oi3I0N9CKWBfsu/lFpeC07AebyWMf
         gCBpnFYCTxSCiwTcWrjd+mPdPr2xay3lFAcdnb8j1LMR1mMVC2qof82dX4SExNzq0ITi
         qIvw==
X-Gm-Message-State: AOJu0YyFbd4eThjen2Q+Aah1DWok0q1pBdlnjmi4JXe6nVXwuqsohA6k
	LotyVRscT3MMBqQSHWYgbi7HQnOuaPruC7GW0Ftdi70DCZ0HR6bvTvioxALtUY/TH6+neu4bFB7
	GDDhGd05ZN0r45ldz1oElWk71HeczolPC6jZe
X-Google-Smtp-Source: AGHT+IFCF3vKEt4TJM9yBhBKm8gDP3afbD+7AEIwxVWJPwwXoyno5TCahTqki5z+L/9mDdkcURdaQ6z7k5li08Xz++I=
X-Received: by 2002:a05:622a:4e8b:b0:437:b572:6d with SMTP id
 dj11-20020a05622a4e8b00b00437b572006dmr328934qtb.21.1714494170121; Tue, 30
 Apr 2024 09:22:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430133221.250811-1-james.clark@arm.com>
In-Reply-To: <20240430133221.250811-1-james.clark@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 30 Apr 2024 09:22:38 -0700
Message-ID: <CAP-5=fX2NMSE1ThznMnNo0ne7FuaxMuDGEaCieWGxZotB8XODg@mail.gmail.com>
Subject: Re: [PATCH] perf cs-etm: Improve version detection and error reporting
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, coresight@lists.linaro.org, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 6:32=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
> When the config validation functions are warning about ETMv3, they do it
> based on "not ETMv4". If the drivers aren't all loaded or the hardware
> doesn't support Coresight it will appear as "not ETMv4" and then Perf
> will print the error message "... not supported in ETMv3 ..." which is
> wrong and confusing.
>
> cs_etm_is_etmv4() is also misnamed because it also returns true for
> ETE because ETE has a superset of the ETMv4 metadata files. Although
> this was always done in the correct order so it wasn't a bug.
>
> Improve all this by making a single get version function which also
> handles not present as a separate case. Change the ETMv3 error message
> to only print when ETMv3 is detected, and add a new error message for
> the not present case.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/arch/arm/util/cs-etm.c | 64 +++++++++++++++++++++++--------
>  1 file changed, 48 insertions(+), 16 deletions(-)
>
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util=
/cs-etm.c
> index 07be32d99805..2763c6758b91 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -66,9 +66,25 @@ static const char * const metadata_ete_ro[] =3D {
>         [CS_ETE_TS_SOURCE]              =3D "ts_source",
>  };
>
> -static bool cs_etm_is_etmv4(struct auxtrace_record *itr, int cpu);
> +enum cs_etm_version { CS_NOT_PRESENT, CS_ETMV3, CS_ETMV4, CS_ETE };
> +
> +static bool cs_etm_pmu_file_present(struct auxtrace_record *itr, int cpu=
,
> +                                      const char *file);
>  static bool cs_etm_is_ete(struct auxtrace_record *itr, int cpu);
>
> +static enum cs_etm_version cs_etm_get_version(struct auxtrace_record *it=
r,
> +                                             int cpu)

nit: perhaps use "struct perf_cpu" rather than "int cpu" for a little
bit of type safety. Fwiw, most of the tool uses an index into a CPU
map but then have labelled that index "cpu" which is confusing
particularly in the uncore case, whilst a perf_cpu is never an index.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> +{
> +       if (cs_etm_is_ete(itr, cpu))
> +               return CS_ETE;
> +       else if (cs_etm_pmu_file_present(itr, cpu, metadata_etmv4_ro[CS_E=
TMV4_TRCIDR0]))
> +               return CS_ETMV4;
> +       else if (cs_etm_pmu_file_present(itr, cpu, metadata_etmv3_ro[CS_E=
TM_ETMCCER]))
> +               return CS_ETMV3;
> +
> +       return CS_NOT_PRESENT;
> +}
> +
>  static int cs_etm_validate_context_id(struct auxtrace_record *itr,
>                                       struct evsel *evsel, int cpu)
>  {
> @@ -87,7 +103,7 @@ static int cs_etm_validate_context_id(struct auxtrace_=
record *itr,
>                 return 0;
>
>         /* Not supported in etmv3 */
> -       if (!cs_etm_is_etmv4(itr, cpu)) {
> +       if (cs_etm_get_version(itr, cpu) =3D=3D CS_ETMV3) {
>                 pr_err("%s: contextid not supported in ETMv3, disable wit=
h %s/contextid=3D0/\n",
>                        CORESIGHT_ETM_PMU_NAME, CORESIGHT_ETM_PMU_NAME);
>                 return -EINVAL;
> @@ -154,7 +170,7 @@ static int cs_etm_validate_timestamp(struct auxtrace_=
record *itr,
>               perf_pmu__format_bits(cs_etm_pmu, "timestamp")))
>                 return 0;
>
> -       if (!cs_etm_is_etmv4(itr, cpu)) {
> +       if (cs_etm_get_version(itr, cpu) =3D=3D CS_ETMV3) {
>                 pr_err("%s: timestamp not supported in ETMv3, disable wit=
h %s/timestamp=3D0/\n",
>                        CORESIGHT_ETM_PMU_NAME, CORESIGHT_ETM_PMU_NAME);
>                 return -EINVAL;
> @@ -218,6 +234,11 @@ static int cs_etm_validate_config(struct auxtrace_re=
cord *itr,
>         }
>
>         perf_cpu_map__for_each_cpu_skip_any(cpu, idx, intersect_cpus) {
> +               if (cs_etm_get_version(itr, cpu.cpu) =3D=3D CS_NOT_PRESEN=
T) {
> +                       pr_err("%s: Not found on CPU %d. Check hardware a=
nd firmware support and that all Coresight drivers are loaded\n",
> +                              CORESIGHT_ETM_PMU_NAME, cpu.cpu);
> +                       return -EINVAL;
> +               }
>                 err =3D cs_etm_validate_context_id(itr, evsel, cpu.cpu);
>                 if (err)
>                         break;
> @@ -548,13 +569,13 @@ cs_etm_info_priv_size(struct auxtrace_record *itr _=
_maybe_unused,
>                 /* Event can be "any" CPU so count all online CPUs. */
>                 intersect_cpus =3D perf_cpu_map__new_online_cpus();
>         }
> +       /* Count number of each type of ETM. Don't count if that CPU has =
CS_NOT_PRESENT. */
>         perf_cpu_map__for_each_cpu_skip_any(cpu, idx, intersect_cpus) {
> -               if (cs_etm_is_ete(itr, cpu.cpu))
> -                       ete++;
> -               else if (cs_etm_is_etmv4(itr, cpu.cpu))
> -                       etmv4++;
> -               else
> -                       etmv3++;
> +               enum cs_etm_version v =3D cs_etm_get_version(itr, cpu.cpu=
);
> +
> +               ete   +=3D v =3D=3D CS_ETE;
> +               etmv4 +=3D v =3D=3D CS_ETMV4;
> +               etmv3 +=3D v =3D=3D CS_ETMV3;
>         }
>         perf_cpu_map__put(intersect_cpus);
>
> @@ -564,7 +585,8 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __m=
aybe_unused,
>                (etmv3 * CS_ETMV3_PRIV_SIZE));
>  }
>
> -static bool cs_etm_is_etmv4(struct auxtrace_record *itr, int cpu)
> +static bool cs_etm_pmu_file_present(struct auxtrace_record *itr, int cpu=
,
> +                                      const char *file)
>  {
>         bool ret =3D false;
>         char path[PATH_MAX];
> @@ -574,9 +596,7 @@ static bool cs_etm_is_etmv4(struct auxtrace_record *i=
tr, int cpu)
>                         container_of(itr, struct cs_etm_recording, itr);
>         struct perf_pmu *cs_etm_pmu =3D ptr->cs_etm_pmu;
>
> -       /* Take any of the RO files for ETMv4 and see if it present */
> -       snprintf(path, PATH_MAX, "cpu%d/%s",
> -                cpu, metadata_etmv4_ro[CS_ETMV4_TRCIDR0]);
> +       snprintf(path, PATH_MAX, "cpu%d/%s", cpu, file);
>         scan =3D perf_pmu__scan_file(cs_etm_pmu, path, "%x", &val);
>
>         /* The file was read successfully, we have a winner */
> @@ -735,21 +755,26 @@ static void cs_etm_get_metadata(int cpu, u32 *offse=
t,
>         struct perf_pmu *cs_etm_pmu =3D ptr->cs_etm_pmu;
>
>         /* first see what kind of tracer this cpu is affined to */
> -       if (cs_etm_is_ete(itr, cpu)) {
> +       switch (cs_etm_get_version(itr, cpu)) {
> +       case CS_ETE:
>                 magic =3D __perf_cs_ete_magic;
>                 cs_etm_save_ete_header(&info->priv[*offset], itr, cpu);
>
>                 /* How much space was used */
>                 increment =3D CS_ETE_PRIV_MAX;
>                 nr_trc_params =3D CS_ETE_PRIV_MAX - CS_ETM_COMMON_BLK_MAX=
_V1;
> -       } else if (cs_etm_is_etmv4(itr, cpu)) {
> +               break;
> +
> +       case CS_ETMV4:
>                 magic =3D __perf_cs_etmv4_magic;
>                 cs_etm_save_etmv4_header(&info->priv[*offset], itr, cpu);
>
>                 /* How much space was used */
>                 increment =3D CS_ETMV4_PRIV_MAX;
>                 nr_trc_params =3D CS_ETMV4_PRIV_MAX - CS_ETMV4_TRCCONFIGR=
;
> -       } else {
> +               break;
> +
> +       case CS_ETMV3:
>                 magic =3D __perf_cs_etmv3_magic;
>                 /* Get configuration register */
>                 info->priv[*offset + CS_ETM_ETMCR] =3D cs_etm_get_config(=
itr);
> @@ -767,6 +792,13 @@ static void cs_etm_get_metadata(int cpu, u32 *offset=
,
>                 /* How much space was used */
>                 increment =3D CS_ETM_PRIV_MAX;
>                 nr_trc_params =3D CS_ETM_PRIV_MAX - CS_ETM_ETMCR;
> +               break;
> +
> +       default:
> +       case CS_NOT_PRESENT:
> +               /* Unreachable, CPUs already validated in cs_etm_validate=
_config() */
> +               assert(true);
> +               return;
>         }
>
>         /* Build generic header portion */
> --
> 2.34.1
>
