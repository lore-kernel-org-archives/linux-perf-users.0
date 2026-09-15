Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EA9449B3D
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 19:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789501379; cv=pass; b=r2YG6oBBOtsvp6EFJQfJ8svezRh4EUxrDaIuiHKaEwjdFrMV4Hx9msyGYC61KYB5n/HGAwTb2rpcIz0lK0urPVrTpRV2Qepky5Cj0dPNYWwz8Qa0YD51Dni28gXVplnvkPlkv/mddoR9XwSnIYZSAdwhNwk1YXcFasSsdx622n0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789501379; c=relaxed/simple;
	bh=vO7okh2vQbhR08LoTBO4HBqEy5EyaQZuhnLsn63yUwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fg1ijw9IcaQBeEWt82DpftDIQwFk6MynZYu6rs+XQyn21aGRVRYpB6T902XlJajYfFtzg9V6aWUTRbm4RNSCFDFtu2PEvTaFFuFCfIum/5U35atjPbbM5HWOfgT4mNCR/VrUppyLkRglXyWsvVAy1nUWCEQgZ8p4hcUGRAciqvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qd65gPYe; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qd65gPYe"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530411c7ee1so67521cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 12:42:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789501376; cv=none;
        d=google.com; s=arc-20260327;
        b=A+iHdtnEIvxYL0UFucbTHwhcnH+mtYS1S58Wg8x5ImxWusNnfQ954Mlel57brfkdla
         1SQxuit0ew7NTQxG7YAxfbrkN12JTbm+ecMsZcrkEUQPe2tZFpnVRWJ6Kr/wP84+D0D8
         CuDZ1CuwLugNr7Z8aByy52KuQ+a7ZB+UPPQjVgBHsWMujuCE8Ireel5jp+cuAcq/ymIL
         4fl2RvFaUJB/PNPdfY2ygKIHkRVFp2jy4wB/UrqAHPu9qVWPgFIgZSzFkHUPNBlu5dcR
         QXMxlXTuP0UDIY6KqSFN+ogexW1LaDRNvhuDD55nEXng7vL5ch6xlE5nunYiuwEYCz3l
         0wEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0glIWluP5FGU2sO8Ta+IsEFm6YUeekCYft6+osOvJ5E=;
        fh=H8pVQ/XfcGejhuFM83sIIlEDwI4NHwVCDWWp9olgrLY=;
        b=scDNea7z44Ac0Dlz2OMaQ9tPZMTWAyGMKpXc/okEhAUjPrgtre2BjjqLb0sisNqA1w
         +TyoAiULoprJTBfjQ+6g4aufPke4wxbCXvLLL6l2fMQ7xTU3T9ECYa0YnagqYVE54DA9
         GRRp1ndo9rKaIg+lXp9E0GQvCwoG62Ujk+flw55EykMa82Kmw3jYgX7rmarKmu0S/W+a
         9CAL1r7M2qiHyP03ltEVcbrWLNyoG8H0s0ygMKdQ9NI8Qv6wUljUs3NpEscrmUWi85GA
         WCYwfqpOui6Eef8Sbdfkav7M8CeqbiEE7+KL0aAfrRhuwTvfgZ9xGxIKkFAizNHliHrM
         kxEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789501376; x=1790106176; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0glIWluP5FGU2sO8Ta+IsEFm6YUeekCYft6+osOvJ5E=;
        b=Qd65gPYeoykvN8CP41ifSf04RLD092Hz5wbcaPEZMK5AYHshY/6nEFdIFyi8DsK2E6
         60u64dof21vvokwONXF121lVYzymEhmy1+yFwguu8rSbVG41PWjYl4PdWWzbPPrr6Q8Q
         nf60Ybd53CTb76R12ntQx2Bai1zs2WDqKO/oCe8+Qi3pJ+LiJZb7+Kj0SyT7POGAjIDI
         SIAp5lE/rWodDBYpciUaKKlnCcD5RSvM0rfCEgTL0rQlbVQhuB+piRjyhTXr1VKNQQW/
         sNA0d6a7h8MAwDvH/k8XsGfxtwphJV0Jy+0/6vCA0Yj7S1Q79T3/h5+WAfu3gz9eN9d3
         Olqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789501376; x=1790106176;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0glIWluP5FGU2sO8Ta+IsEFm6YUeekCYft6+osOvJ5E=;
        b=WMNjn4ELJQ7MT679lyFhj8VLlvzHKwr0SC5fDeCEZRGDILoOkXGEl8xQIGlplHnK4z
         JDUDd/9x3VUQHZKiJSE+b24lSYTZlK9+xLsNnZ3YEZTygHnpBsi2njIkJhLaurdd1R3O
         M/sF6na4J+CQydJEIs5C9Ssgml3LnE1NmxjPFMpDtjZ2/GpzvRkoeowkKtgRQ3MlLP4+
         XGuTW9BuWNHTTgQVqLSMYYNGmZOe+KjceRXQVVj75BAV6GUIlJKQ0AraUhVDKSO2cIAV
         5ycZxt7BQvKpjb+wL2d3L9/03Y6UIeY/VFcADYf1dGo/tLoH+vpeVPAaI6zyO/4oV1bD
         I+sw==
X-Forwarded-Encrypted: i=1; AKwUvBzo6DAq0Ut5T+vNi6LQhUw2WwS7076hYwIIpVdLO3+SRKhboFKjNidsqFncmAGEKO80Pyt/c7XhonYaxaNJYTTT@vger.kernel.org
X-Gm-Message-State: AFuF++lG2TbOhUz3f/CE4xCpTjO6zFB8e3P7rWjl8u31b9UofKT+gH3T
	NZFMBTAzetUoU97+HAOEtsJOUpMHcx0pEf9Yo/2c1zjP+hqM6tPqC8ABxf93KIY+KiWLt0Bc9Y1
	DZZN1oXRzPEVLknRFhPfUE100c6pXnbSb/tdOeDwV
X-Gm-Gg: AYBFou1u7as03KLA4wgTSvqGkEybIX6brz/DGvqiiw8wR3h7m3QImIwLjinP47vDDRk
	1oQB+FrICu4ZLTauuhzX5ukWDRbimHrH8EyUk44bnDUAFz0ysQ70B7b1l3NNQMZyUl3maJzj557
	hz8sj0FHnPPLrZ5zh7sXWyHUzHJWbSfGtwD4pRrFYFmvCgMhdXOi4QmQ3OtH+UiHHNWhjJyiWC4
	ehByj0l+mxax23xHS/HbGSSUSufG9cexMPS6xKZGY+cb4lq4WPB+Ym+nys5yO8+RsprymZca219
	ZDldg1flXH31qG+q0M8Yd4SL0WJ4P248/e4ZnAD2Axse90TTzKeCJp2LHNiZLvKw8ZM08t2u39m
	X7lvQZEgfHg==
X-Received: by 2002:a05:622a:1486:b0:52f:8389:29e0 with SMTP id
 d75a77b69052e-5324676bdaemr3014131cf.0.1789501375250; Tue, 15 Sep 2026
 12:42:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909-perf-evlist-uncore-cpu-b4-v2-1-dc673a1f4592@sifive.com>
In-Reply-To: <20260909-perf-evlist-uncore-cpu-b4-v2-1-dc673a1f4592@sifive.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Sep 2026 12:42:43 -0700
X-Gm-Features: AcwNN1UGZ6n_sZg-onyE6NMfT9OvN_z0Qh3xvwIs8LxoT2UpRZJByUaNFcVFDjA
Message-ID: <CAP-5=fU2UOT8pZFLOifxHo7U4XsPv9YbYnAitjdvxsB=0AYuoQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf evlist: Don't restrict uncore events to PMU CPUs
To: Nia Su <nia.su@sifive.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 7:31=E2=80=AFPM Nia Su <nia.su@sifive.com> wrote:
>
> The PMU CPU map has different semantics for core and uncore PMUs.
>
> For core PMUs, pmu_cpus contains the CPUs on which the event can be
> opened. Intersect the user-requested CPU map with the PMU CPU map to
> reject CPUs unsupported by the PMU.
>
> For uncore PMUs, pmu_cpus is read from the PMU's cpumask sysfs attribute,
> which lists the default CPU to open the event on per socket/die, not the
> set of CPUs it can only be opened on. The user-requested CPU may override
> these defaults, and the driver can redirect the event to the appropriate
> control CPU.
>
> Currently, __perf_evlist__propagate_maps() intersects the user-requested
> CPU map with pmu_cpus for all PMUs. If the user-requested CPU is not in
> pmu_cpus, the intersection becomes empty and the evsel is removed before
> perf_event_open() is called.
>
> Add evsel->is_pmu_uncore, set once from pmu->is_uncore at parse time,
> to skip the intersection for uncore PMUs. Core PMUs, and other
> non-core PMUs such as software events, breakpoints, or tracepoints,
> continue to be restricted to their PMU CPU map.
>
> Fixes: 811082e4b668 ("perf parse-events: Support user CPUs mixed with thr=
eads/processes")
>
> Assisted-by: Claude Sonnet 5
> Signed-off-by: Nia Su <nia.su@sifive.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> Changes in v2:
> - Add a dedicated is_pmu_uncore flag instead of reusing requires_cpu,
>   since it more precisely represents whether the PMU is uncore.
> - Link to v1: https://lore.kernel.org/r/20260904-perf-evlist-uncore-cpu-b=
4-v1-1-604b55c025ee@sifive.com
> ---
>  tools/lib/perf/evlist.c                 | 5 +++--
>  tools/lib/perf/include/internal/evsel.h | 2 ++
>  tools/perf/util/evsel.c                 | 1 +
>  tools/perf/util/parse-events.c          | 1 +
>  4 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 1f210dadd666ff818a23712ab95acaa659ccf8dc..c1c5b0684eedb7a6ab8f3df85=
f326fbd5ef809a2 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -79,8 +79,9 @@ static void __perf_evlist__propagate_maps(struct perf_e=
vlist *evlist,
>                 }
>         }
>
> -       /* Ensure cpus only references valid PMU CPUs. */
> -       if (!perf_cpu_map__has_any_cpu(evsel->cpus) &&
> +       /* Ensure cpus only references valid PMU CPUs, except for uncore =
PMUs. */
> +       if (!evsel->is_pmu_uncore &&
> +           !perf_cpu_map__has_any_cpu(evsel->cpus) &&
>             !perf_cpu_map__is_subset(evsel->pmu_cpus, evsel->cpus)) {
>                 struct perf_cpu_map *tmp =3D perf_cpu_map__intersect(evse=
l->pmu_cpus, evsel->cpus);
>
> diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/inc=
lude/internal/evsel.h
> index b988034f13710ec4d49d942d486c4b9afe21a1f0..35447bed0f9586b538dad40c2=
23e70d50486c5f6 100644
> --- a/tools/lib/perf/include/internal/evsel.h
> +++ b/tools/lib/perf/include/internal/evsel.h
> @@ -128,6 +128,8 @@ struct perf_evsel {
>         bool                     requires_cpu;
>         /** Is the PMU for the event a core one? Effects the handling of =
own_cpus. */
>         bool                     is_pmu_core;
> +       /** Is the PMU for the event an uncore one? */
> +       bool                     is_pmu_uncore;
>         /** Does the evsel on read on the first CPU index such as tool ti=
me events? */
>         bool                     reads_only_on_cpu_idx0;
>         int                      idx;
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index d4cb455f4a7d45ae2f9133709ff3248b54163ce0..5acec3f6345099ef9e46e8161=
4b9df2595925b1c 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -551,6 +551,7 @@ struct evsel *evsel__clone(struct evsel *orig)
>         evsel->core.system_wide =3D orig->core.system_wide;
>         evsel->core.requires_cpu =3D orig->core.requires_cpu;
>         evsel->core.is_pmu_core =3D orig->core.is_pmu_core;
> +       evsel->core.is_pmu_uncore =3D orig->core.is_pmu_uncore;
>
>         if (orig->name) {
>                 evsel->name =3D strdup(orig->name);
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index cc7ad331a49f34536f66724370b8bb94ab65bacd..8302be207c1d6ecf8ae6fd67f=
54d66d08d50e01c 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -269,6 +269,7 @@ __add_event(struct list_head *list, int *idx,
>         evsel->core.pmu_cpus =3D pmu_cpus;
>         evsel->core.requires_cpu =3D pmu ? pmu->is_uncore : false;
>         evsel->core.is_pmu_core =3D is_pmu_core;
> +       evsel->core.is_pmu_uncore =3D pmu ? pmu->is_uncore : false;
>         evsel->core.reads_only_on_cpu_idx0 =3D perf_pmu__reads_only_on_cp=
u_idx0(attr);
>         evsel->pmu =3D pmu;
>         evsel->alternate_hw_config =3D alternate_hw_config;
>
> ---
> base-commit: 73e3f0710014fe6d4ed98cfc02292f6121db7558
> change-id: 20260904-perf-evlist-uncore-cpu-b4-418af0f17c80
>
> --
>
