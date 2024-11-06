Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA1D207A1D
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Nov 2024 18:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730916399; cv=none; b=cj02KxwPDm9RS6Fj2X2lWykjyT5glgy5yjkFDYX9lF2Mx8yG8rYKbUrKJR2WLhDjToW+o/jqZGXhbnnSoNTpGPwSyPqKCcAMLqgUU/Sy1sx25//uNTJsB0w05fmkN13E9RFq23rxEUigApXp3BepmhBjPjMczB7L5QXCJsuHP/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730916399; c=relaxed/simple;
	bh=0mrHr0Utt97KBxmJvOpiUOSn74oL94f9WxrcIOaA2Vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JeShIo1PloDznbGgk2f0YTT6JQyVIaHq8Pu0y8r85dwHpnQzM/pVKWc0od+S9F1E2/Kxlc+kkJvXRyBKpudIKvMyBAUqUomB9pFb6bz3rwRHqWBRnqCX45nMQ+DtOxy9jYfsEoX9RQDpODDxPUIG2Cg//Z3EsoiXPCuc1F1kpSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BlKbRYnx; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BlKbRYnx"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4608dddaa35so14501cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Nov 2024 10:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730916396; x=1731521196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hyl3wfbScVxxC47vu5pNhpEby/1fXzJxVEuHqZTyUyY=;
        b=BlKbRYnxLry9wMb5zXcsh8iQqZ98FFQWLJPWAq5bHeHgloswFXCjONLtcNtTxPSxbp
         yPAU8EV6hR+IYRSePKfeLaAPOqD9AAG6WJqi4VWgek0VMtynEgR9v+pO0fsV8jLfY9wk
         YaMRUobOkLNrgX80UgmnmmVTPjmsi9/ctoQsvjsd+SU0kInWmDDFWaNUYOTIIlYzzfhd
         h4IS4XaE7+YbPO9WbMXgCogMNzD6XPC+krwtRfH6tUI6ZzS4bjDGSI7CR6729khbqz9k
         lUQY/a5IvduxvMKzs8l03uUGgsxgbA8rlQShv2b34J98s0da+vdj19Qqi6WmjNHRmEPO
         ao9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730916396; x=1731521196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hyl3wfbScVxxC47vu5pNhpEby/1fXzJxVEuHqZTyUyY=;
        b=pHpG9XtvD++EdOOrfcxy9uCNF6M+7XR09j4e5dNZTqWuXqWPJ6pZZyTeQaWcGB6ln+
         7O8c+MtVtb4yC9ql6kdEsT9OIglX1s2HOiL7clze8pnc/rx++9i1b5Suk0AXdIOzQ6iy
         QK5p5LeZaok6eVKUlPMFCypGQGgwWYWGRSpOuns2M3gD2bcLYBKwQNG3LnuG+OmHAToO
         m/roUneixl+jVi7v9SDrmYUGksoewGMeFONFVkBqiGsNEQ+lTXm5zqEMYBZjNQvibmwF
         4o9l4mjC8BAkFDEddfefum/OSt4scu0Y7f6TqkRxrbZjDrjozvn/ZzDPXo3eOwde6xfQ
         yvYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOnneMuQakEdwNlX4h410PHMMiPneXbTgCtwfXVXYY/kFL+2S2D8IR5SOVHmr6Pp3SCzjkNdQmBfcQ9r0h+CK3@vger.kernel.org
X-Gm-Message-State: AOJu0YyKQRE1IUrnIkPC6Q8/VYrF9IKYpJ9zckGb+YccKrIPY7+jPAME
	kL9X03Z/r6wFvFF2mLxwtGpMAs8rbIztNPiw6KDWjmsgDufQS35DPic0uZ4P7rTdVKB0fWnA8xb
	uMeAqM0vZF28NNxIRF4SBuWlvQx1WXgR4osYL
X-Gm-Gg: ASbGncuVYIgtGSBT6ifQffXgC/YrF60QtgCh0FVbP0pQhEkacqBqI943BIyvi00UT/m
	QpbTnkfhNRP9ktJvyfZePAblD9ZH36eQSsnjjv0FoYKfsyMGAZJWwsZ/tu2G+qH4=
X-Google-Smtp-Source: AGHT+IGPoYgJc3j2I/YyO9JGYGQOsQ8SsLdn/7zJeCUSZOOROyDTSPgqGhTTkb+38xDwFmXDF9UiUMEXOvqvXZcRFTA=
X-Received: by 2002:a05:622a:5b91:b0:461:6bb5:99ba with SMTP id
 d75a77b69052e-462fa56542dmr839001cf.5.1730916395754; Wed, 06 Nov 2024
 10:06:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106085441.3945502-1-xu.yang_2@nxp.com>
In-Reply-To: <20241106085441.3945502-1-xu.yang_2@nxp.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 6 Nov 2024 10:06:24 -0800
Message-ID: <CAP-5=fVN93EJN9FqMmF6h2meiLbU_OWJ2=Vt0EVdZds6nZSKpA@mail.gmail.com>
Subject: Re: [PATCH] perf jevents: fix breakage when do perf stat on system metric
To: Xu Yang <xu.yang_2@nxp.com>, john.g.garry@oracle.com
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	sandipan.das@amd.com, bgray@linux.ibm.com, linux-perf-users@vger.kernel.org, 
	imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 12:55=E2=80=AFAM Xu Yang <xu.yang_2@nxp.com> wrote:
>
> When do perf stat on sys metric, perf tool output nothing now:
> $ perf stat -a -M imx95_ddr_read.all -I 1000
> $
>
> This command runs on an arm64 machine and the Soc has one DDR hw pmu
> except one armv8_cortex_a55 pmu. Their maps show as follows:
>
> const struct pmu_events_map pmu_events_map[] =3D {
> {
>         .arch =3D "arm64",
>         .cpuid =3D "0x00000000410fd050",
>         .event_table =3D {
>                 .pmus =3D pmu_events__arm_cortex_a55,
>                 .num_pmus =3D ARRAY_SIZE(pmu_events__arm_cortex_a55)
>         },
>         .metric_table =3D {
>                 .pmus =3D NULL,
>                 .num_pmus =3D 0
>         }
> },
>
> static const struct pmu_sys_events pmu_sys_event_tables[] =3D {
> {
>         .event_table =3D {
>                 .pmus =3D pmu_events__freescale_imx95_sys,
>                 .num_pmus =3D ARRAY_SIZE(pmu_events__freescale_imx95_sys)
>         },
>         .metric_table =3D {
>                 .pmus =3D pmu_metrics__freescale_imx95_sys,
>                 .num_pmus =3D ARRAY_SIZE(pmu_metrics__freescale_imx95_sys=
)
>         },
>         .name =3D "pmu_events__freescale_imx95_sys",
> },
>
> Currently, pmu_metrics_table__find() will return NULL when only do perf
> stat on sys metric. Then parse_groups() will never be called to parse
> sys metric_name, finally perf tool will exit directly. This should be a
> common problem. To fix the issue, this will keep the logic before commit
> f20c15d13f01 ("perf pmu-events: Remember the perf_events_map for a PMU")
> to return a empty metric table rather than a NULL pointer. This should
> be fine since the removed part just check if the table match provided
> metric_name. Without these code, the code in parse_groups() will also
> check the validity of metrci_name too.

So we carry this code for ARM:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/arch/arm64/util/pmu.c?h=3Dperf-tools-next#n21

On x86 and other architectures the PMU is always passed as NULL (the
effect of this change):
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/pmu.c?h=3Dperf-tools-next#n843

The blame shows me as the author, but that's because I factored event
and metric tables to be separate things. When I did that I brought
over ARM's event table logic to the metric table.

Why do we pass a PMU to this code anyway?
So on x86 the cpuid will give a different string for
heterogeneous/hybrid/BIG.little parts. On ARM you get a different
CPUID depending on which logical CPU you ask the question of. The CPUs
associated with a PMU are used to look up the CPUID string.

This whole thing is spaghetti code (fwiw, I dislike the whole arch
directory plus weak symbols thing that is a by design breakage of at
least cross platform work - hopefully the maintainers will review [1]
so we can delete a sizeable chunk of it) and the ARM situation looks
sub-optimal. We really need to scan a plurality of metric tables for
the heterogeneous parts on ARM. We're passing a PMU rather than just a
CPU, I think passing a CPU would be more intention revealing.

Then there's the pleasure of system metrics, which are only loosely in
my mental model of things as John Garry did the heavy lifting for
these.

So the problems I see:
1) ARM needs multiple metric tables to be parsed in the metric group
logic as the invariant of 1 CPUID 1 table doesn't hold on ARM.
2) The lack of a metric table causes an early exit from the metric parsing =
code:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/metricgroup.c?h=3Dperf-tools-next#n1700
However, the system metrics pattern conceptually match PMU names and
aren't tied to CPUIDs. The iteration logic still uses the metric table
though:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/metricgroup.c?h=3Dperf-tools-next#n1283
3) Crufty spaghetti from the use of arch/weak that means we aren't
testing the same code paths leading to divergence and rot.

I'll try to pull something together. But for the sake of expediently
addressing your issue:
Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian


[1] https://lore.kernel.org/lkml/20241017002520.59124-1-irogers@google.com/



> Fixes: f20c15d13f01 ("perf pmu-events: Remember the perf_events_map for a=
 PMU")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> ---
>  tools/perf/pmu-events/empty-pmu-events.c | 12 +-----------
>  tools/perf/pmu-events/jevents.py         | 12 +-----------
>  2 files changed, 2 insertions(+), 22 deletions(-)
>
> diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-ev=
ents/empty-pmu-events.c
> index 2b7516946ded..b8719dab264d 100644
> --- a/tools/perf/pmu-events/empty-pmu-events.c
> +++ b/tools/perf/pmu-events/empty-pmu-events.c
> @@ -585,17 +585,7 @@ const struct pmu_metrics_table *perf_pmu__find_metri=
cs_table(struct perf_pmu *pm
>          if (!map)
>                  return NULL;
>
> -        if (!pmu)
> -                return &map->metric_table;
> -
> -        for (size_t i =3D 0; i < map->metric_table.num_pmus; i++) {
> -                const struct pmu_table_entry *table_pmu =3D &map->metric=
_table.pmus[i];
> -                const char *pmu_name =3D &big_c_string[table_pmu->pmu_na=
me.offset];
> -
> -                if (pmu__name_match(pmu, pmu_name))
> -                           return &map->metric_table;
> -        }
> -        return NULL;
> +       return &map->metric_table;
>  }
>
>  const struct pmu_events_table *find_core_events_table(const char *arch, =
const char *cpuid)
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 6e71b09dbc2a..70f4fd5395fb 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -1101,17 +1101,7 @@ const struct pmu_metrics_table *perf_pmu__find_met=
rics_table(struct perf_pmu *pm
>          if (!map)
>                  return NULL;
>
> -        if (!pmu)
> -                return &map->metric_table;
> -
> -        for (size_t i =3D 0; i < map->metric_table.num_pmus; i++) {
> -                const struct pmu_table_entry *table_pmu =3D &map->metric=
_table.pmus[i];
> -                const char *pmu_name =3D &big_c_string[table_pmu->pmu_na=
me.offset];
> -
> -                if (pmu__name_match(pmu, pmu_name))
> -                           return &map->metric_table;
> -        }
> -        return NULL;
> +       return &map->metric_table;
>  }
>
>  const struct pmu_events_table *find_core_events_table(const char *arch, =
const char *cpuid)
> --
> 2.34.1
>
