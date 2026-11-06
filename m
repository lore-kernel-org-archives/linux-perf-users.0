Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793927280;
	b=q9upY1zKI+mlqFNusc68Ip25vlyjxI0Lh9RBqILgo66NZQhZgWH2eCG01OYVFzaZyWiE
	 SjrxDY9HTVLBv2IJ37VTQvOYF4isw9GbpC1wXIOinT1aHbYfmQTaCgJX4QOK88KarEkxT
	 NzENmfAnRHqlol4kuhDzhHwLia6DNVAGmnNxnY6kuuF5UMqbCG5v2nfsUscx87vDBE0Tg
	 S9+VHnFVip2+udApHeorPR0lr6jusK0qKXhHkh+t581notnANNl/b5uyXU7If0gDaD3lW
	 +8D5x97kuJQDWxTeMYrJkXpcjCY4lgKgmXcV7Y3dr8n4XB3IBCEGR8m4LS0LaUN68VA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793927280;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=J/1JpT4AeHIXufQr21xGFXOTd5qh7JEpsPrJdFj6gzM=;
	b=FXqX+6owMhhIFtw4sYF9LognzVYHzNToL15xxvZxCTI1SOfdnQqb0xttAiVRjoTLaImM
	 8dAj6oByeMnXoQ6XPkPwtnoLGdLxo3zlMA8sLPZI30Xl3wux+9ABofFqIbQipTAxtm9D7
	 h+d5+Z0gBc7gxBO5RYRfKMKv6Lr9mj54Ty9gg2MNyPj4Gu/NazbPapdEO4XCHUcSyk6Hj
	 uC5f4Yxmym1bryAiFpLQBrPEAmqn7mlSwfMFxijLX7FApv6nb4e3knS4qUnxKVUexYnys
	 bIoAEIXG5ZxyKwYHW5DBpITS8fHEoopkKr6w8JqBNGto3QcfFHY9e/ZaorY6EA7pLvw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H9c9AaBI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3CA606A31B
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 01:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D3CA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H9c9AaBI
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b09a65c76dso99730a91.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 17:07:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793927279; cv=none;
        d=google.com; s=arc-20260327;
        b=dfwWhg8rudAGltY8SGR6+nC5PAAxG4ij3IXsxhQibjYsoghGYYRNXDxwQDvKRAjiZL
         SYyC3qOC+hFpBiurN7YrA5gyBruSsjtr9WjqFtTEp8P/zN52NdQBOaV1akuSAiWvNtxz
         4ET55y5InnApiImSvjAP8agiNbqKw/iAav4osUHoTbqx+5KCkUEFjrTQkLwW7bvFOhQE
         br4btHbPCo4h4cxGxtAZyBYpteyjzzpiBItcoak3J6NadeYLg0tzwgJ+ibvE0fEMfdGV
         5rTB4TleUNC7iFI62gmVs82HuM91Tlc0CuiSmO90LRoM0D8JFrTCZIlk5RG7pCSWSurI
         roNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J/1JpT4AeHIXufQr21xGFXOTd5qh7JEpsPrJdFj6gzM=;
        fh=6r7e0FWgd7MHSJnhKCklu8N6pr4aprWznfQDNsNOKdU=;
        b=X1HnDEVreS/eepvWGCodvVOV59eWtj2jBgiaAWL3qqklcURfrzdf12ULn7PbD3R3KJ
         1vgwsV3zg53BF55mft4uFB2NulK3GxKCMHBSulkB9UF+nr1AO3MMFY50erxHkygsPlPt
         LO4lEYBgG31msAH3aVGOElTAlGIyTRTIRgw062DziP3EAciDwl32aKdttdVpRV49Sldd
         PbTt2kI9kh2rheXytt4clIkjlZ8PkhL48dhXb4kG/UYJGWqDyTCpBcEtlWXIKS0pfWU8
         Fy6m2nWHNYkbaUFJ9x/4DQjI6okfkiF+aZrz/RTZZfLGgQb/rzBSiaG4YF2NWJVJZsBC
         Cswg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793927279; x=1794532079; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J/1JpT4AeHIXufQr21xGFXOTd5qh7JEpsPrJdFj6gzM=;
        b=H9c9AaBI4BP/Sux5Fenz/Aa0hmi2qUKpKS+ANoSIfUNFDjCIgGAEjE4tKUDlRxeyqI
         DsvxbVdPj+L+dniml81hk2g428r99XRf7uCWXgIRrxadd8s8XaFj4bfdOX7IgyKjomKu
         0bg31Sl3y995y/SLm1hI2ixmwHG/habZvg0Bj9x3TNx7gMBlBZwBwAx3X2Lux7ihWaKE
         oGw0IIcVa5UMfvvSAGENnrXfN6wSTqKVKq9izyDWRYF0vRxWIO5Ks2RgDL39NQkzXcdJ
         G40esENK0wboUjpaZwKAml+ubdIA8PC65bRJZt5JTu2WisCYj1E5YJSs9hqpeGqvAgFl
         N/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793927279; x=1794532079;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J/1JpT4AeHIXufQr21xGFXOTd5qh7JEpsPrJdFj6gzM=;
        b=ACKh9jR0lxVS2r4trg+7rTu8phAhzW1bRkm+DEIhVHelBUsqBm6loDZL9s1qFExT+q
         5I/BXVPdtbYi10a5a5pxh8c3qGUw/TDyOq59tWRIIF3er+JvrgYekhthGXANvdxT2xvf
         cIkyD3SUHcqc/RT1xmf1G/myAb25nKQpomvEIcNJAL69jRLfO7RsnDRUcSdLSGtFeHSF
         sg9rFPI1ugrovQKhDC93Qrob4avegvI23PuZwkp3E36AfdxIT8gJ5hOpfs3VeCm+3xH4
         YGWiVo08QOYdTk44VAmR1+1QfR/JtDE9QZzTWBDGVRDXNlDkDvBm4GIFLCNah/gKUifG
         eRMg==
X-Forwarded-Encrypted: i=1; AKwUvBw2RFuR7dorEP8lX9NLBJeMINiQyMBh0lz1U/had4mI6HrA/PpmiycZVGSx44VCVijcbPMMkS65WvMdtPrcL+lU@vger.kernel.org
X-Gm-Message-State: APuU4Z9ctiKcfIZHnRaz/9Z+j0dqvn+en5QEMDBbXFV5R0JtIf8Ir9JO
	fbVUqoVJJg4cjt4BKwJzt4fN7mAfWfY/6VpROYT0tahtdUHASkpOEUh5CSxucD+pITcDnfNXdc6
	TtN+7SoblMzukxaIvgOseeWEVuv08IPA=
X-Gm-Gg: AYBFou2DoNq76QisGgoQ2tKcVpetKCdbUMwEzRb27QXJ58Z0eu/I8sWe11A4YgHY8/I
	tIby2OFfsoGoZN4z00z8x8qnrIx2gdbaWTf1Fox3CG9pP5EDK8erK0W5SalVREw+JpcBN/L013c
	9ep8aI151NKkGLbqVoSYg7lQLggrR4o94srjQyHvz7IQUFs7iEoSUXmqD5cileTCDJ0dpgt9O6M
	z8LmBatrO8mdueGbE7KhPCUdSoApGSHEVJuaS787Yhi8HhLviM9zpLSFSdHyl9P4lrxWJPQRjpL
	iHtstMGVunnVffCzNK3lGOB8aa8pRbz9qeBnPsWGlRRHvkx25lynKcSbM1ltGC4TAL4v2ZPNNXh
	nOa23PN9XNI2TbnOMlCqen/rYtWuvXJRTkQ+3wZ2bAtUnCekZK34UErqh78RBSt0NJMMhICd+BP
	k+ConsOhHeAe5lBvpcDEbCTHUWum/ywgLqNA==
X-Received: by 2002:a17:90b:17c8:b0:3ac:a6a5:5743 with SMTP id
 98e67ed59e1d1-3b0db6dc994mr771600a91.32.1793927279404; Thu, 05 Nov 2026
 17:07:59 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <b7456dbb-16fd-45b4-8742-e9ea3f896317@amd.com> <20261105170340.165507-1-puranjay@kernel.org>
In-Reply-To: <20261105170340.165507-1-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Nov 2026 17:07:46 -0800
X-Gm-Features: AclHuK9Caj2NrmiF75209ADFsbCwcojotURSdM5MLJwUqdt_6QPw47LD1jWKGrM
Message-ID: <CAEf4BzZeVd4boXX4Hy1sKAM=dUPS7dvdmrOPybGrrZV+bU7eAA@mail.gmail.com>
Subject: Re: [PATCH RFC] perf/x86/amd/lbr: Don't freeze the LBR on PMI for
 user-only filters
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Sandipan Das <sandipan.das@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 9:03=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org>=
 wrote:
>
> On CPUs with X86_FEATURE_AMD_LBR_PMC_FREEZE the LBR is always frozen on
> PMI, so the branch stack ends before the IP and callchain, which are
> taken when the NMI is delivered. IBS rejects branch-stack events, so
> there is no precise alternative.
>
> The freeze only keeps the PMI handler's branches out of the stack, which
> matters only if branches into the kernel are recorded. Skip it when
> LBR_SELECT suppresses them, and add a freeze format bit (config2:0) to
> request it anyway.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
> Thanks both. A user-only default with an explicit request works for me,
> with one exception I would like to keep: when branches into the kernel
> are recorded the freeze has to stay. On a Zen 5 part with the freeze
> cleared and a user+kernel filter, every entry in every sample was a
> branch taken by amd_pmu_v2_handle_irq() or amd_pmu_lbr_read(), so users
> recording kernel branches would regress with a "never freeze" default.
>
> This RFC does the following:
>  - LBR_SELECT suppresses kernel branches: no freeze, unless the new
>    AMD-only freeze format bit (config2:0, advertised through the format
>    attributes) is set.
>  - Otherwise: freeze as today.
>
> That needs no tool changes for the user-only case and gives an explicit
> way to request the freeze. This version is only compile tested; I will
> retest on a Zen 5 part if the approach is acceptable.
>
>  arch/x86/events/amd/core.c | 14 ++++++++++++++
>  arch/x86/events/amd/lbr.c  | 21 ++++++++++++++++++---
>  2 files changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 49b6b8fce5664..d63649c756a58 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -1404,8 +1404,22 @@ static struct attribute_group group_events_amd_brs=
 =3D {
>
>  #endif /* CONFIG_PERF_EVENTS_AMD_BRS */
>
> +PMU_FORMAT_ATTR(freeze, "config2:0");
> +
> +static struct attribute *amd_pmu_lbr_format_attrs[] =3D {
> +       &format_attr_freeze.attr,
> +       NULL,
> +};
> +
> +static struct attribute_group group_format_amd_lbr =3D {
> +       .name       =3D "format",
> +       .attrs      =3D amd_pmu_lbr_format_attrs,
> +       .is_visible =3D amd_branches_is_visible,
> +};
> +
>  static const struct attribute_group *amd_attr_update[] =3D {
>         &group_caps_amd_branches,
> +       &group_format_amd_lbr,
>  #ifdef CONFIG_PERF_EVENTS_AMD_BRS
>         &group_events_amd_brs,
>  #endif
> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
> index a55646fcb8465..f45e2c53566af 100644
> --- a/arch/x86/events/amd/lbr.c
> +++ b/arch/x86/events/amd/lbr.c
> @@ -10,6 +10,12 @@
>  /* LBR Branch Select valid bits */
>  #define LBR_SELECT_MASK                0x1ff
>
> +/* attr.config2: freeze the LBR on PMI */
> +#define LBR_CFG2_FREEZE                BIT_ULL(0)
> +
> +/* Software only, masked out before writing LBR_SELECT */
> +#define LBR_FREEZE             BIT_ULL(63)
> +
>  /*
>   * LBR Branch Select filter bits which when set, ensures that the
>   * corresponding type of branches are not recorded
> @@ -307,6 +313,9 @@ static int amd_pmu_lbr_setup_filter(struct perf_event=
 *event)
>         /* Filter bits operate in suppress mode */
>         reg->config =3D mask ^ LBR_SELECT_MASK;
>
> +       if (event->attr.config2 & LBR_CFG2_FREEZE)
> +               reg->config |=3D LBR_FREEZE;
> +
>         return 0;
>  }
>
> @@ -392,20 +401,26 @@ void amd_pmu_lbr_sched_task(struct perf_event_pmu_c=
ontext *pmu_ctx,
>  void amd_pmu_lbr_enable_all(void)
>  {
>         struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> -       u64 lbr_select, dbg_ctl, dbg_extn_cfg;
> +       u64 lbr_cfg =3D 0, lbr_select =3D 0, dbg_ctl, dbg_extn_cfg;
>
>         if (!cpuc->lbr_users || !x86_pmu.lbr_nr)
>                 return;
>
>         /* Set hardware branch filter */
>         if (cpuc->lbr_select) {
> -               lbr_select =3D cpuc->lbr_sel->config & LBR_SELECT_MASK;
> +               lbr_cfg =3D cpuc->lbr_sel->config;
> +               lbr_select =3D lbr_cfg & LBR_SELECT_MASK;
>                 wrmsrq(MSR_AMD64_LBR_SELECT, lbr_select);
>         }
>
>         if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
>                 rdmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
> -               wrmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl | DEBUGCTLMSR_FREEZE=
_LBRS_ON_PMI);
> +               /* Skip the freeze if kernel branches are suppressed, unl=
ess asked */
> +               if ((lbr_select & LBR_KERNEL) && !(lbr_cfg & LBR_FREEZE))

heh, so we basically either

a) opt-in freeze with *new config*, but do it *only for non-kernel LBR*

or

b) opt-out freeze *only for non-kernel LBR* _unconditionally_, but
without adding any new config

In both cases we have a behavior that makes sense in practice, but a)
adds some new config, while b) doesn't add anything. End result is the
same, just more configuration and need to change user space code to
opt-out the freeze.

Is a) worth it, or we should stick to b) and keep it simple, Sandipan?

> +                       dbg_ctl &=3D ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
> +               else
> +                       dbg_ctl |=3D DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
> +               wrmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
>         }
>
>         rdmsrq(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
>
> base-commit: 0f443787a7f6ae907975742680aac2600483eaf1
> --
> 2.53.0-Meta
>
