Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D82B22126D
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Mar 2026 00:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772671822; cv=pass; b=QMV+llPip5j/iG4o2Xmu0BPlrVydoflDm8u+E5R8sF0hTz9ccxNrWxzXqyfRyN7svINHZhGWpSEZ3Oh8bYWKZoakN/pTPA47DBEBGnt3ODpHjfKfDfDiHPGOtTJ1Ra8I7Jv/io4/vAc6PV2vze6fOx9FS1g91MYmd9+H9PG46WA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772671822; c=relaxed/simple;
	bh=EPW1izY+bcZzDd/LKcV5CkVPL7gU1d4s3QkDiUKYZG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rphiPW9u0ikyObYWJXbsLflGErvNmGVpwWUTVgQpXli5Zz1cbl+38pYQnH6nibyqfkZyWxoEJ7pwefD9I8CaBOVtQUZDaBYOubOFcaSTIy4MlSwk+dAygewSbzl4bynXohPS2KeSdXCEetba7xiDo80otKs+pndmISd5xucPm6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2fnrGw/H; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2fnrGw/H"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ae4b40999bso18075ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Mar 2026 16:50:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772671819; cv=none;
        d=google.com; s=arc-20240605;
        b=WoFkM05StAAfnYKRsq28sOUgwHGIJe7fLyoXSa5kfnHRGQce0NI3DisgvavBHrDtt5
         91V5rrnJDWi1BwSs2TcWx4js0rez0JCxsxjMgIWzhZOUsX5T91vCOXlT1WFvfRKOP9sL
         KaKM10uql24faQjuxbjGVYn+AV1r7N9FYCARNOOaCLnBPlYt/UklfiZRaN5r4sBMp88z
         aw/TbNvtnzQG81UN5xADqxM5qLDB8g1S74qvY16ImMzxtQiBzXyjtcICxo4hsY8AkHR8
         mzYjA47neyvYG3WAGDhtX17ou/sRXGr1KoXpgJ1Vv3ex/kekMzXnhf9G3wEdstnzP04B
         M+2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wyKFUMKiVe5UirzrZW8bKhAxytLGFheTjMFLFtT7r4o=;
        fh=JdsPW2uWaRcK9hmcvbOv+CG6Ix+jZbEY9xq2WXzHM4Y=;
        b=b72rm7ZDLRi1GX36A6RJcBkHG0fwYpek4J1LSuU5W5LjI/wcBrtUJW5nrlCLWIVvAm
         dbRCKGlzGwE35CuJtJeN13ejEShVY8gLZYR/KINautvjjsOR7n+Dv/1KU+Go859DML2X
         KywuYf9Qr3y+hqXOKr+Y7Z1vDhELUH70xCSy+KGuDSKJBIz8TiAtcSDH2Ad0w4pcfrRC
         f36LZXnQS/sFdIE5SPwPn/AB7ubNqkg3vGq3MJYfA4twzTLNOgTiTOxpJolGrgOvzJ6D
         rMxhMPlm77HlsfIzlFlsCqZan2/4jYv0+MhPgvoQvD40E6/2rrFMMpTbhYL6ptuRRg3H
         oAxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772671819; x=1773276619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyKFUMKiVe5UirzrZW8bKhAxytLGFheTjMFLFtT7r4o=;
        b=2fnrGw/HDwJUojitT+ZmrLDxVnxtSZ4eZ9OUd4qRdSFf56Ajz6z97p32J4MrqXQcOF
         fFywSpgryIsHt+naur3Hcq/3qCdlNsjuVVLB2rFNmQ2GNaiSkWg5F4ogDRmjidTxpl62
         452a1GSjwsaZzjYrG7YOMDZAIUD5dwIhoSa7X3KjsMNL7l7zrUFo7Ebcybkab1phTo0K
         MgH4BtND5SsKFzPjibYkHBD6qUQYY8McHSR/Khsw3VSiXgObSi/iHIqJG7MPP9Hrm9+Z
         hTNShTTp68Eg8KBVk9/G6gAEiVtsboJvCoB5tV1zOIbZXdTMfjEwLST/qreTELkeP0QF
         SCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772671819; x=1773276619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wyKFUMKiVe5UirzrZW8bKhAxytLGFheTjMFLFtT7r4o=;
        b=An7kYetzIcseaQYRbm68XDY1bGtrIGVnTDAsN9ixQfn6PSI5vJYLtW3kqUFLitCB2U
         ew84TEriQTxkRAnCJr2BzlAWeveFcUd4Uxgb1E1nawcK6y+2fjGlNmvD76rnILM+48SP
         YTkAzn1S1TooSkwVJTdDon5RGHYlg9Xo9HFZ7/Q6tQClHByc7/KsmCsIN8I5zE0e/hFq
         XG76nWlGeoTMayeGXuVzXUcJTR7qzg4/9Y5everKhYGmjIkE+pSKajwpLJCOG0/yWPHL
         1GD+yS5X2i0jlJaR/11bv+9EpKYjQ3KwmuxF6lg9vHCYL1GE/3j4J/nHodUDsLK5HBfY
         im5A==
X-Forwarded-Encrypted: i=1; AJvYcCUGZn2P4vWt83HlgWHYpZxV8+wamZz9emAhtp920RnFn4YBamk5GJWW6DN+Iz9zS7BXcLoG1wR96mNd8t4l26wx@vger.kernel.org
X-Gm-Message-State: AOJu0YxyBCr3eoURmv8tomOjQ1Unzdan7rDIuF9dET2B5UdJpDhUVVl2
	VqbNhS3+dXzpZg+AEQ9Yf5HdyvUsrgKU/fFWHY2twdG4smuOpMWLGcTv737VjaVVgBNS9ltAKd7
	3twVFtC7UrDFvifP54Bs8Uypmhy3n1SSXNoozs22K
X-Gm-Gg: ATEYQzx62A3RYIZ2+uGWCgUwOPlePskbngMJsvawc4lkYruw3eGjj4TnDEvkqXHRbhB
	t0aNn2k5jW4U6MjnT/2eNtvfXvP171WmzlZhkK3w/w87pdlAB0IFYCrUDKo+jf4XZy5Ct/viDoU
	nEeZsBlGwcqHQxYH1KiAJJJs51JjPk8i81DxpRoAF8Cv28RguMvdU8zg2I7HEZrnX//TNsLP1sb
	cM80cNf0QyhwbSbBdGSPJzDjaSNCjJPDRkWQFGbz1BPfaWggWMTXAh4b8vjZYsUKCGd5PVVQST/
	GPM3m9sxrhTxC6cW6aNLw4tvQQfB5hViMk5ctA==
X-Received: by 2002:a17:903:230f:b0:2a0:89b0:71d7 with SMTP id
 d9443c01a7336-2ae7653eeb0mr446785ad.13.1772671818825; Wed, 04 Mar 2026
 16:50:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029102136.61364-1-dapeng1.mi@linux.intel.com> <20251029102136.61364-6-dapeng1.mi@linux.intel.com>
In-Reply-To: <20251029102136.61364-6-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 4 Mar 2026 16:50:07 -0800
X-Gm-Features: AaiRm52arpzH9Hf81QU8hz8AH2E67vHqBKuTqJ2ACt6WRKIsRQU-hKpJUotvDxo
Message-ID: <CAP-5=fUjCy7ENFx+n3mRHuDKPBg2E3pYqe-E2OZ9X2wHWHOj1g@mail.gmail.com>
Subject: Re: [Patch v9 05/12] perf/x86/intel: Initialize architectural PEBS
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>, 
	Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 3:24=E2=80=AFAM Dapeng Mi <dapeng1.mi@linux.intel.c=
om> wrote:
>
> arch-PEBS leverages CPUID.23H.4/5 sub-leaves enumerate arch-PEBS
> supported capabilities and counters bitmap. This patch parses these 2
> sub-leaves and initializes arch-PEBS capabilities and corresponding
> structures.
>
> Since IA32_PEBS_ENABLE and MSR_PEBS_DATA_CFG MSRs are no longer existed
> for arch-PEBS, arch-PEBS doesn't need to manipulate these MSRs. Thus add
> a simple pair of __intel_pmu_pebs_enable/disable() callbacks for
> arch-PEBS.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/core.c            | 21 ++++++++---
>  arch/x86/events/intel/core.c      | 60 ++++++++++++++++++++++---------
>  arch/x86/events/intel/ds.c        | 52 ++++++++++++++++++++++-----
>  arch/x86/events/perf_event.h      | 25 +++++++++++--
>  arch/x86/include/asm/perf_event.h |  7 +++-
>  5 files changed, 132 insertions(+), 33 deletions(-)
>
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 74479f9d6eed..f2402ae3ffa0 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -554,14 +554,22 @@ static inline int precise_br_compat(struct perf_eve=
nt *event)
>         return m =3D=3D b;
>  }
>
> -int x86_pmu_max_precise(void)
> +int x86_pmu_max_precise(struct pmu *pmu)
>  {
>         int precise =3D 0;
>
> -       /* Support for constant skid */
>         if (x86_pmu.pebs_active && !x86_pmu.pebs_broken) {
> -               precise++;
> +               /* arch PEBS */
> +               if (x86_pmu.arch_pebs) {
> +                       precise =3D 2;
> +                       if (hybrid(pmu, arch_pebs_cap).pdists)
> +                               precise++;
> +
> +                       return precise;
> +               }
>
> +               /* legacy PEBS - support for constant skid */
> +               precise++;
>                 /* Support for IP fixup */
>                 if (x86_pmu.lbr_nr || x86_pmu.intel_cap.pebs_format >=3D =
2)
>                         precise++;
> @@ -569,13 +577,14 @@ int x86_pmu_max_precise(void)
>                 if (x86_pmu.pebs_prec_dist)
>                         precise++;
>         }
> +
>         return precise;
>  }
>
>  int x86_pmu_hw_config(struct perf_event *event)
>  {
>         if (event->attr.precise_ip) {
> -               int precise =3D x86_pmu_max_precise();
> +               int precise =3D x86_pmu_max_precise(event->pmu);
>
>                 if (event->attr.precise_ip > precise)
>                         return -EOPNOTSUPP;
> @@ -2630,7 +2639,9 @@ static ssize_t max_precise_show(struct device *cdev=
,
>                                   struct device_attribute *attr,
>                                   char *buf)
>  {
> -       return snprintf(buf, PAGE_SIZE, "%d\n", x86_pmu_max_precise());
> +       struct pmu *pmu =3D dev_get_drvdata(cdev);
> +
> +       return snprintf(buf, PAGE_SIZE, "%d\n", x86_pmu_max_precise(pmu))=
;
>  }
>
>  static DEVICE_ATTR_RO(max_precise);
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index c88bcd5d2bc4..9ce27b326923 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -5271,34 +5271,59 @@ static inline bool intel_pmu_broken_perf_cap(void=
)
>         return false;
>  }
>
> +#define counter_mask(_gp, _fixed) ((_gp) | ((u64)(_fixed) << INTEL_PMC_I=
DX_FIXED))
> +
>  static void update_pmu_cap(struct pmu *pmu)
>  {
> -       unsigned int cntr, fixed_cntr, ecx, edx;
> -       union cpuid35_eax eax;
> -       union cpuid35_ebx ebx;
> +       unsigned int eax, ebx, ecx, edx;
> +       union cpuid35_eax eax_0;
> +       union cpuid35_ebx ebx_0;
> +       u64 cntrs_mask =3D 0;
> +       u64 pebs_mask =3D 0;
> +       u64 pdists_mask =3D 0;
>
> -       cpuid(ARCH_PERFMON_EXT_LEAF, &eax.full, &ebx.full, &ecx, &edx);
> +       cpuid(ARCH_PERFMON_EXT_LEAF, &eax_0.full, &ebx_0.full, &ecx, &edx=
);
>
> -       if (ebx.split.umask2)
> +       if (ebx_0.split.umask2)
>                 hybrid(pmu, config_mask) |=3D ARCH_PERFMON_EVENTSEL_UMASK=
2;
> -       if (ebx.split.eq)
> +       if (ebx_0.split.eq)
>                 hybrid(pmu, config_mask) |=3D ARCH_PERFMON_EVENTSEL_EQ;
>
> -       if (eax.split.cntr_subleaf) {
> +       if (eax_0.split.cntr_subleaf) {
>                 cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_NUM_COUNT=
ER_LEAF,
> -                           &cntr, &fixed_cntr, &ecx, &edx);
> -               hybrid(pmu, cntr_mask64) =3D cntr;
> -               hybrid(pmu, fixed_cntr_mask64) =3D fixed_cntr;
> +                           &eax, &ebx, &ecx, &edx);
> +               hybrid(pmu, cntr_mask64) =3D eax;
> +               hybrid(pmu, fixed_cntr_mask64) =3D ebx;
> +               cntrs_mask =3D counter_mask(eax, ebx);
>         }
>
> -       if (eax.split.acr_subleaf) {
> +       if (eax_0.split.acr_subleaf) {
>                 cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_ACR_LEAF,
> -                           &cntr, &fixed_cntr, &ecx, &edx);
> +                           &eax, &ebx, &ecx, &edx);
>                 /* The mask of the counters which can be reloaded */
> -               hybrid(pmu, acr_cntr_mask64) =3D cntr | ((u64)fixed_cntr =
<< INTEL_PMC_IDX_FIXED);
> -
> +               hybrid(pmu, acr_cntr_mask64) =3D counter_mask(eax, ebx);
>                 /* The mask of the counters which can cause a reload of r=
eloadable counters */
> -               hybrid(pmu, acr_cause_mask64) =3D ecx | ((u64)edx << INTE=
L_PMC_IDX_FIXED);
> +               hybrid(pmu, acr_cause_mask64) =3D counter_mask(ecx, edx);
> +       }
> +
> +       /* Bits[5:4] should be set simultaneously if arch-PEBS is support=
ed */
> +       if (eax_0.split.pebs_caps_subleaf && eax_0.split.pebs_cnts_sublea=
f) {
> +               cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_PEBS_CAP_=
LEAF,
> +                           &eax, &ebx, &ecx, &edx);
> +               hybrid(pmu, arch_pebs_cap).caps =3D (u64)ebx << 32;

nit: It seems strange to use a u64 for caps but only use the top 32
bits. Did you intend to use the low 32-bits for eax?

Thanks,
Ian

> +
> +               cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_PEBS_COUN=
TER_LEAF,
> +                           &eax, &ebx, &ecx, &edx);
> +               pebs_mask   =3D counter_mask(eax, ecx);
> +               pdists_mask =3D counter_mask(ebx, edx);
> +               hybrid(pmu, arch_pebs_cap).counters =3D pebs_mask;
> +               hybrid(pmu, arch_pebs_cap).pdists =3D pdists_mask;
> +
> +               if (WARN_ON((pebs_mask | pdists_mask) & ~cntrs_mask))
> +                       x86_pmu.arch_pebs =3D 0;
> +       } else {
> +               WARN_ON(x86_pmu.arch_pebs =3D=3D 1);
> +               x86_pmu.arch_pebs =3D 0;
>         }
>
>         if (!intel_pmu_broken_perf_cap()) {
> @@ -6252,7 +6277,7 @@ tsx_is_visible(struct kobject *kobj, struct attribu=
te *attr, int i)
>  static umode_t
>  pebs_is_visible(struct kobject *kobj, struct attribute *attr, int i)
>  {
> -       return x86_pmu.ds_pebs ? attr->mode : 0;
> +       return intel_pmu_has_pebs() ? attr->mode : 0;
>  }
>
>  static umode_t
> @@ -7728,6 +7753,9 @@ __init int intel_pmu_init(void)
>         if (!is_hybrid() && boot_cpu_has(X86_FEATURE_ARCH_PERFMON_EXT))
>                 update_pmu_cap(NULL);
>
> +       if (x86_pmu.arch_pebs)
> +               pr_cont("Architectural PEBS, ");
> +
>         intel_pmu_check_counters_mask(&x86_pmu.cntr_mask64,
>                                       &x86_pmu.fixed_cntr_mask64,
>                                       &x86_pmu.intel_ctrl);
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index c0b7ac1c7594..26e485eca0a0 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1531,6 +1531,15 @@ static inline void intel_pmu_drain_large_pebs(stru=
ct cpu_hw_events *cpuc)
>                 intel_pmu_drain_pebs_buffer();
>  }
>
> +static void __intel_pmu_pebs_enable(struct perf_event *event)
> +{
> +       struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> +       struct hw_perf_event *hwc =3D &event->hw;
> +
> +       hwc->config &=3D ~ARCH_PERFMON_EVENTSEL_INT;
> +       cpuc->pebs_enabled |=3D 1ULL << hwc->idx;
> +}
> +
>  void intel_pmu_pebs_enable(struct perf_event *event)
>  {
>         struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> @@ -1539,9 +1548,7 @@ void intel_pmu_pebs_enable(struct perf_event *event=
)
>         struct debug_store *ds =3D cpuc->ds;
>         unsigned int idx =3D hwc->idx;
>
> -       hwc->config &=3D ~ARCH_PERFMON_EVENTSEL_INT;
> -
> -       cpuc->pebs_enabled |=3D 1ULL << hwc->idx;
> +       __intel_pmu_pebs_enable(event);
>
>         if ((event->hw.flags & PERF_X86_EVENT_PEBS_LDLAT) && (x86_pmu.ver=
sion < 5))
>                 cpuc->pebs_enabled |=3D 1ULL << (hwc->idx + 32);
> @@ -1603,14 +1610,22 @@ void intel_pmu_pebs_del(struct perf_event *event)
>         pebs_update_state(needed_cb, cpuc, event, false);
>  }
>
> -void intel_pmu_pebs_disable(struct perf_event *event)
> +static void __intel_pmu_pebs_disable(struct perf_event *event)
>  {
>         struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
>         struct hw_perf_event *hwc =3D &event->hw;
>
>         intel_pmu_drain_large_pebs(cpuc);
> -
>         cpuc->pebs_enabled &=3D ~(1ULL << hwc->idx);
> +       hwc->config |=3D ARCH_PERFMON_EVENTSEL_INT;
> +}
> +
> +void intel_pmu_pebs_disable(struct perf_event *event)
> +{
> +       struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> +       struct hw_perf_event *hwc =3D &event->hw;
> +
> +       __intel_pmu_pebs_disable(event);
>
>         if ((event->hw.flags & PERF_X86_EVENT_PEBS_LDLAT) &&
>             (x86_pmu.version < 5))
> @@ -1622,8 +1637,6 @@ void intel_pmu_pebs_disable(struct perf_event *even=
t)
>
>         if (cpuc->enabled)
>                 wrmsrq(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
> -
> -       hwc->config |=3D ARCH_PERFMON_EVENTSEL_INT;
>  }
>
>  void intel_pmu_pebs_enable_all(void)
> @@ -2669,11 +2682,26 @@ static void intel_pmu_drain_pebs_icl(struct pt_re=
gs *iregs, struct perf_sample_d
>         }
>  }
>
> +static void __init intel_arch_pebs_init(void)
> +{
> +       /*
> +        * Current hybrid platforms always both support arch-PEBS or not
> +        * on all kinds of cores. So directly set x86_pmu.arch_pebs flag
> +        * if boot cpu supports arch-PEBS.
> +        */
> +       x86_pmu.arch_pebs =3D 1;
> +       x86_pmu.pebs_buffer_size =3D PEBS_BUFFER_SIZE;
> +       x86_pmu.pebs_capable =3D ~0ULL;
> +
> +       x86_pmu.pebs_enable =3D __intel_pmu_pebs_enable;
> +       x86_pmu.pebs_disable =3D __intel_pmu_pebs_disable;
> +}
> +
>  /*
>   * PEBS probe and setup
>   */
>
> -void __init intel_pebs_init(void)
> +static void __init intel_ds_pebs_init(void)
>  {
>         /*
>          * No support for 32bit formats
> @@ -2788,6 +2816,14 @@ void __init intel_pebs_init(void)
>         }
>  }
>
> +void __init intel_pebs_init(void)
> +{
> +       if (x86_pmu.intel_cap.pebs_format =3D=3D 0xf)
> +               intel_arch_pebs_init();
> +       else
> +               intel_ds_pebs_init();
> +}
> +
>  void perf_restore_debug_store(void)
>  {
>         struct debug_store *ds =3D __this_cpu_read(cpu_hw_events.ds);
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index 285779c73479..ca5289980b52 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -708,6 +708,12 @@ enum hybrid_pmu_type {
>         hybrid_big_small_tiny   =3D hybrid_big   | hybrid_small_tiny,
>  };
>
> +struct arch_pebs_cap {
> +       u64 caps;
> +       u64 counters;
> +       u64 pdists;
> +};
> +
>  struct x86_hybrid_pmu {
>         struct pmu                      pmu;
>         const char                      *name;
> @@ -752,6 +758,8 @@ struct x86_hybrid_pmu {
>                                         mid_ack         :1,
>                                         enabled_ack     :1;
>
> +       struct arch_pebs_cap            arch_pebs_cap;
> +
>         u64                             pebs_data_source[PERF_PEBS_DATA_S=
OURCE_MAX];
>  };
>
> @@ -906,7 +914,7 @@ struct x86_pmu {
>         union perf_capabilities intel_cap;
>
>         /*
> -        * Intel DebugStore bits
> +        * Intel DebugStore and PEBS bits
>          */
>         unsigned int    bts                     :1,
>                         bts_active              :1,
> @@ -917,7 +925,8 @@ struct x86_pmu {
>                         pebs_no_tlb             :1,
>                         pebs_no_isolation       :1,
>                         pebs_block              :1,
> -                       pebs_ept                :1;
> +                       pebs_ept                :1,
> +                       arch_pebs               :1;
>         int             pebs_record_size;
>         int             pebs_buffer_size;
>         u64             pebs_events_mask;
> @@ -929,6 +938,11 @@ struct x86_pmu {
>         u64             rtm_abort_event;
>         u64             pebs_capable;
>
> +       /*
> +        * Intel Architectural PEBS
> +        */
> +       struct arch_pebs_cap arch_pebs_cap;
> +
>         /*
>          * Intel LBR
>          */
> @@ -1216,7 +1230,7 @@ int x86_reserve_hardware(void);
>
>  void x86_release_hardware(void);
>
> -int x86_pmu_max_precise(void);
> +int x86_pmu_max_precise(struct pmu *pmu);
>
>  void hw_perf_lbr_event_destroy(struct perf_event *event);
>
> @@ -1791,6 +1805,11 @@ static inline int intel_pmu_max_num_pebs(struct pm=
u *pmu)
>         return fls((u32)hybrid(pmu, pebs_events_mask));
>  }
>
> +static inline bool intel_pmu_has_pebs(void)
> +{
> +       return x86_pmu.ds_pebs || x86_pmu.arch_pebs;
> +}
> +
>  #else /* CONFIG_CPU_SUP_INTEL */
>
>  static inline void reserve_ds_buffers(void)
> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/per=
f_event.h
> index 49a4d442f3fc..0dfa06722bab 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -200,6 +200,8 @@ union cpuid10_edx {
>  #define ARCH_PERFMON_EXT_LEAF                  0x00000023
>  #define ARCH_PERFMON_NUM_COUNTER_LEAF          0x1
>  #define ARCH_PERFMON_ACR_LEAF                  0x2
> +#define ARCH_PERFMON_PEBS_CAP_LEAF             0x4
> +#define ARCH_PERFMON_PEBS_COUNTER_LEAF         0x5
>
>  union cpuid35_eax {
>         struct {
> @@ -210,7 +212,10 @@ union cpuid35_eax {
>                 unsigned int    acr_subleaf:1;
>                 /* Events Sub-Leaf */
>                 unsigned int    events_subleaf:1;
> -               unsigned int    reserved:28;
> +               /* arch-PEBS Sub-Leaves */
> +               unsigned int    pebs_caps_subleaf:1;
> +               unsigned int    pebs_cnts_subleaf:1;
> +               unsigned int    reserved:26;
>         } split;
>         unsigned int            full;
>  };
> --
> 2.34.1
>
