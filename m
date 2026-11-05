Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793897907;
	b=inPGo1WHMIYXrEP43LoBuApSdT702yZqsLoTvZnoG/0/fDwsFKlcmh1CEIMEV5vvW2Ww
	 sVhxqTmjwAzLj+GlQT+0VyLgACvyaoni/hZ3uVCg73FamH6+PJ0uXuUxk376kqpEe+yfW
	 O6uErIKh4Qv2yrswiKJYvZhY/qBT70okRFBuRpHSXLNGPS0z3ilpoIfa7TC9q6rhJVUpJ
	 DUhCephA53qSnGVibUu9OeaLXi4g8BdfZjuImo0QtP7jwPISDpTLNkztWiNh3ZynQbZ50
	 U199TAx27kZhoXKoBJaFdmBAXmWC7TswNBDZ4MOSZ+Ffbz0GwspUVAaNj2ztytg3gEw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897907;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TI8wWEeGQ/ZqWRYd10U2ka6i7cW6dlytnPcTCd6gW/c=;
	b=bjdIyfiLFiNOpS66M/kWgfWL4vnQG31aZcspsi7rP4gqLKMlTAILydlUSjC+1+r36Fq8
	 yLIGoqQP1HMRiStoqXKGiEccU5Dc0Od1v8IgmXSZu7hTjAsuvsCPQyOG1MS+qJWXGM5QW
	 XrG5HbVewTn8mUzIDxT6QJ4b46bCwJL0vvRHD1CZDiWELoLlgzXyq1UnPQTGnBIg1Yuo1
	 OiETv4pM9yNSB0Hkzr1Sr+/aLlbWTcppjtZtUGmJzyD01Z+9jdvARSKkPbKHA9G5rfzB4
	 hK3ZYurXykxLn4uE6ffppvzUEHY2QI9ktP3qsxhxkdOJdw/xIMQM6KP4rjwygHlSfVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VKSCTGQB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CCF606A329
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 16:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73CCF606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VKSCTGQB
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ed0890476fso11607585ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 08:58:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793897907; cv=none;
        d=google.com; s=arc-20260327;
        b=pqdQqiPDVvAV29Uu7HgsMrBDU1oq6nXMPg0vsO1cg9MPtwszrV3tS/JfHBgCDInnyH
         QzZjZXPCG28fdTv/kp/y0g4mEUC+C7aX+TP5AjHhUhdGuLRIxVLaSHJQzgZzR5PPqG3a
         lzTiIVfNe0wxXI+9cgjWfKCq7j8oX0ZJcz86EwVp/DFLKEs7/yxBSEf7M9nQDw3aXBmB
         X3AqGoWNXGDmsyya5cvVE2QIwN+RxHb/ORGk1TE3ywEn2JUXny5EoEjuaoJ2ycglZ18a
         UGCmGUeYIbl3Ald/tXVWIWNABQwbnZXcnw+JJLYclbMFb5udu4BREjR6fnoq67bMcpj/
         XZIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TI8wWEeGQ/ZqWRYd10U2ka6i7cW6dlytnPcTCd6gW/c=;
        fh=KXR+dE+oUXeXo/MHcFOcUYthc+vwxGVcB0aYvQvDwtE=;
        b=Jax2YTxf8a7dRpoGlLejjZy4vVMxhHJ10JEKio1+OUAEP0SMXFAxWT68Vva5GrePvP
         8l+whG/oEnsmdO+tmPrn+w4w50zuAzoAShIgcnh9Ny5eQwlC2x5GLiKtWBT1ironAE6Z
         JC1YS6WHpvdRr7jz8GnyKyUHM21e46zyv0rIV19xycOkNHctWXicxbL8ulV6bAo5gQCZ
         lkXA6rhUknPDdOT0ChmT1/qNjjbB+S1/xvPTCiVlh9iF7PxeHLVqYlU1vEVGiionyWxl
         YUTmj54iDatO53tCERRneKELwE45Z++wjDLIs/GOAHUKwH2rii4JFM9+gBkNqrzHBcDg
         PH4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793897907; x=1794502707; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TI8wWEeGQ/ZqWRYd10U2ka6i7cW6dlytnPcTCd6gW/c=;
        b=VKSCTGQBlEIj7gjwE2BtPw8Ij2jptN3J7STFMUX2+Y9LkeZRr3W4bf5fM55NfOM8Rf
         f51+6C9QSJ+cYQ6JgOAFojVO9HA4IzZ5ozqvlXZ5PRR3FbxygVBnkVgLn2cNV9u9iKxx
         KTshLKEDaSv7Esp2MxTsN9/D7N731Re5Vaxlh+G9XnamSe3lPq3OhzmHLx4YTHlZYyTB
         znItnN/xX2uTn8oywl+l8SB2d4HzpG1D+uNHojVnWbHNIfJ+Y3gtMWsUt4hj9r0DtwPJ
         2rrbaZnGixMME0wi0WUxC6ugAY+j/TYH6WyGx3HYge2mvA8TBklrhVrddMpwnEmJIYYX
         vQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793897907; x=1794502707;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TI8wWEeGQ/ZqWRYd10U2ka6i7cW6dlytnPcTCd6gW/c=;
        b=HPY7LWLDsxINKOkoWp8zmnIX11mjR9cH3mxxA5eJF79aeukEwXSEXcRdoSUC8nN+HO
         o5o8N+OQFQI4oar9pUcV4tDl/6R3/gcfIl5tIOP/vA4iATFlAaKXee4d4FkbrfJIeoW+
         lH/Fp7QpM3wNwUiTvWwD6owh4ihyy9A3Zce6Y6gJyvxMR+GCGdYiPZOEOSZU4eHw9zSb
         7HQIUILZQljhO2s5QjWoDxMtIYa4ZodrrISYgtZzqRGe8/ZPIuvF90emjYMtI7/JPOqh
         mHQYo1Vw5ULPmE+aRt9D2+Imriucvc0OpC64rj0pwC1clJd9dE9HNx5arE2zKiJOvC4+
         Mukg==
X-Forwarded-Encrypted: i=1; AKwUvBxNekR8vog6clibdOQDGkSdvQ6QqCjU4cz6gT58/AIIHMllwlqpsYoLnCCjDXj7Qb5kicXLLdsUIIsLkG15L1UR@vger.kernel.org
X-Gm-Message-State: APuU4Z//foql8OIBMupp1kSAx8hpXKdwPAHp9PjCNerfbo+WOGJx+q6s
	ly6T8oSdnRis1BZYM8ELTplza+UPyfjHosR43j88Kf8K3ls2GuivMRidicZbcLn/j09n4u+BJZv
	0ij1O/6N8dGOeuDvk9jsaHcAuiIrDH/0=
X-Gm-Gg: AYBFou09OCWKHA5EZ6DqtLdqVsUzkH+k2MAS68Sqh+aNR9r6gRW9nyuTUbBP4t9uv3I
	I/X2tHg7epz1VVtXubxZyxmnSKNrVNwhc0mhuPQCJucUBIsfJs/vjJSsggJaR7Pkps6VFur1/AW
	zHdrOxIDIoeUkL49YgNCSiFx1pb+UvzkoRVSpredJo7wW7AoN+HGQj+XojskY+zjGKSejWXXdej
	A+cTDlXO+nlWMAh0BksBBiTJrje2CzWQWM3KGwNAU9RP0mDeJuFapP4cb+Tofz7Nm0hqsxEtgLf
	M133DCKEb8BSE7LiDF0HTRMDIuJx85D6oP6bozCWY+MadEUpYgu2RkBq5IVCZou2ZZx0YMuZt07
	Wt/0xDfT9vXL/btLvo9IYK3nut6X2B3vw9jBynfivssAGNN0gEODm+hB195vLd2Fnbh0U9e8yA1
	BfsNk8wOOcoLchkHKAisJZSvD5jV82Empqrw==
X-Received: by 2002:a17:902:ce03:b0:2dd:ad74:ac1d with SMTP id
 d9443c01a7336-2ed40c153e2mr2350665ad.24.1793897906699; Thu, 05 Nov 2026
 08:58:26 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023124157.75524-1-puranjay@kernel.org> <CAEf4Bzb2jEjqpZrmtTk_+YCW3_jU8fcVzk26CBZnxkpYJ8kCbQ@mail.gmail.com>
 <317a989b-c79a-41a3-8c0a-7e952bdae6d0@amd.com> <CAEf4BzY4FYFuT2iSU+fEApnKK4LjHe3i0Xpq_kd4rt4iDLK3XA@mail.gmail.com>
 <b7456dbb-16fd-45b4-8742-e9ea3f896317@amd.com>
In-Reply-To: <b7456dbb-16fd-45b4-8742-e9ea3f896317@amd.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Nov 2026 08:58:13 -0800
X-Gm-Features: AclHuK-koNzUnQPSK8rEJ-skoaGaQE4cmeNZ6ApCf89UrOhFAr6C5ZfeUCrAwqk
Message-ID: <CAEf4BzatLECKrRstg-SKZNDRPwTdr-ZoHBf=NYf89V-fhG2PjA@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/amd/lbr: Freeze LBR on PMI only when kernel
 branches are recorded
To: Sandipan Das <sandipan.das@amd.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 10:17=E2=80=AFPM Sandipan Das <sandipan.das@amd.com>=
 wrote:
>
> On 04-11-2026 00:39, Andrii Nakryiko wrote:
> > On Mon, Nov 2, 2026 at 2:08=E2=80=AFAM Sandipan Das <sandipan.das@amd.c=
om> wrote:
> >>
> >> On 30-10-2026 01:42, Andrii Nakryiko wrote:
> >>> On Fri, Oct 23, 2026 at 5:42=E2=80=AFAM Puranjay Mohan <puranjay@kern=
el.org> wrote:
> >>>>
> >>>> On CPUs with X86_FEATURE_AMD_LBR_PMC_FREEZE the LBR is always frozen=
 on
> >>>> PMI, so the branch stack ends before the IP and callchain, which are
> >>>> taken when the NMI is delivered. IBS rejects branch-stack events, so
> >>>> there is no precise alternative.
> >>>>
> >>>> The freeze only keeps the PMI handler's branches out of the stack, w=
hich
> >>>> matters only when branches into the kernel are recorded; without it =
the
> >>>> stack fills with the handler's own branches. A user-only filter does=
 not
> >>>> record them, and parts without the feature are never frozen (see com=
mit
> >>>> 598c2fafc06f ("perf/x86/amd/lbr: Use freeze based on availability"))=
.
> >>>>
> >>>> Freeze unless the value written to LBR_SELECT, which is shared by al=
l
> >>>> events on the CPU, suppresses branches into the kernel.
> >>>>
> >>>> With perf record -e ex_ret_brn_tkn:u -j any,u on a Zen 5 part runnin=
g
> >>>> CPython, the function of the sampled IP differs from the function of
> >>>> LBR[0].to in 84.3% of samples with the freeze and in 0.1% without it=
.
> >>>>
> >>>> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> >>>> ---
> >>>>  arch/x86/events/amd/lbr.c | 9 +++++++--
> >>>>  1 file changed, 7 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
> >>>> index a55646fcb8465..7ec50380ac81d 100644
> >>>> --- a/arch/x86/events/amd/lbr.c
> >>>> +++ b/arch/x86/events/amd/lbr.c
> >>>> @@ -392,7 +392,7 @@ void amd_pmu_lbr_sched_task(struct perf_event_pm=
u_context *pmu_ctx,
> >>>>  void amd_pmu_lbr_enable_all(void)
> >>>>  {
> >>>>         struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> >>>> -       u64 lbr_select, dbg_ctl, dbg_extn_cfg;
> >>>> +       u64 lbr_select =3D 0, dbg_ctl, dbg_extn_cfg;
> >>>>
> >>>>         if (!cpuc->lbr_users || !x86_pmu.lbr_nr)
> >>>>                 return;
> >>>> @@ -405,7 +405,12 @@ void amd_pmu_lbr_enable_all(void)
> >>>>
> >>>>         if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
> >>>>                 rdmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
> >>>> -               wrmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl | DEBUGCTLMSR_F=
REEZE_LBRS_ON_PMI);
> >>>> +               /* Freeze unless the filter suppresses branches into=
 the kernel */
> >>>> +               if (lbr_select & LBR_KERNEL)
> >>>
> >>> On Intel CPU side, we reset this FREEZE bit in
> >>> __intel_pmu_lbr_enable() if is_lbr_call_stack_bit_set(), with the
> >>> comment "LBR callstack does not work well with FREEZE_LBRS_ON_PMI.".
> >>> So this is not *exactly* what Intel side of things is doing, and I'm
> >>> not sure I fully understand the differences, so hopefully someone mor=
e
> >>> knowledgeable can help.
> >>>
> >>> But what Puranjay is trying to do here is to at least make a
> >>> user-mode-only LBR and IP + callstack to be coherent (for PGO data
> >>> collection, which we then use for user space app compilation), by
> >>> disabling freezing for LBR.
> >>>
> >>> It doesn't seem like there is anything we can do on AMD hardware for
> >>> when we want kernel-side LBR and precise IP to be in sync,
> >>> unfortunately, but at least for user-space only case it would allow u=
s
> >>> to not plain disable freezing altogether at kernel boot time.
> >>>
> >>> Does this approach make sense?
> >>>
> >>
> >> Yes, the intent to keep the LBR and IP coherent is clear. However, my
> >> concern is that this may end up dropping the branches preceding the
> >> hotspots since a CPU might keep executing in userspace until the PMI
> >> handler runs. I'm not sure about the effect that this is going to have
> >> on PGO but what if we rely on a mechanism (UAPI + tool flags) to let
> >> users explicitly request freeze?
> >>
> >> If there is an use-case where freeze helps, then the facility can be
> >> explicitly requested.
> >
> > heh, it's actually the other way, freezing **hurts** consistency
> > here... should API requested freeze *opt-out*? because freezing, if
> > supported by CPU, currently, is the default behavior not requiring
> > opt-in. Or are you proposing to not enable freeze (even if
> > cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE) is true), and then
> > make user space request freezing with the new UAPI config flag?
> >
>
> The latter. The default will be freeze disabled irrespective of the
> CPUID feature bit.
>

sounds good, thanks! I'll ask Puranjay to make these changes for the
next revision

> > I'm not against expanding UAPI, but it feels like a very quirky little
> > thing which also stems from AMD-only limitation of not supporting
> > precise IP capture with LBR enabled
> >
>
> I agree but it can live as an AMD-only flag in perf_event_attr.config2
> or something similar and advertised through x86_pmu.format_attrs.
>
> >
> > BTW, the alternative that internal customers actually requested
> > initially instead of this was to completely disable freezing at start
> > up through the kernel command line. Which seems like the worst
> > outcome.
> >
> > Thoughts? This all seems unfortunately messy, but hopefully we can
> > figure out some non-intrusive but workable solution.
> >
> >>
> >>>
> >>>> +                       dbg_ctl &=3D ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI=
;
> >>>> +               else
> >>>> +                       dbg_ctl |=3D DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
> >>>> +               wrmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
> >>>>         }
> >>>>
> >>>>         rdmsrq(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
> >>>>
> >>>> base-commit: 0f443787a7f6ae907975742680aac2600483eaf1
> >>>> --
> >>>> 2.53.0-Meta
> >>>>
> >>
>
