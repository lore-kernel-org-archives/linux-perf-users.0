Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792768749;
	b=B7827vfaiamETHXE/xzMAF73EdmlH/0oHq1X+srXyJuxI7cyQmleS3sLcDoSExde+571
	 kYhdz7ectJS1c4Yn+0SAUUf+XSEnEYTo5a166WNF7Z8AmR38LIAlo8aLCAoJ+dkiBGHl1
	 IRM74pOR+lf1DAZq+AhZJ9Ktf8U8L8hzkZquPVCKp11pB1XZoug8MclL4bUbBcyZFC8XX
	 J3Wfig7qN3/OgSRjax33/td8Dzvnbt7+Dimf255wT6+th/zg1heyA4/tuoSzfCa4zWN+g
	 M5j4gekkhgAtAr4UhNXUBj/evp9GRoEjJd3ETAYJnF8BgS2KpqBI1Ug1DyssWJwU5yw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=u6uT+2Bkvv4y7LHLfpq7KqJWTqLIyrtx0un1wUCzN+0=;
	b=p0nKkKHEUV+2ADKU25VI4MdsKExurlV9F4dQPopdpu+3UrJKiSQ1Nzid0iZYQgjICiNS
	 O3HGbrY/c1vD5KYEv4nR+2XJOeGZZyoMaqlLLK3kLm99Im7Tk4eSLa3CP47SKQUZ+B9DF
	 kObSI9ZrmcyFJsc0RGNKfopcTvD8cZfomdLgbMWtJxgSILikYELWGEMzKJZMTjTb9veAY
	 N97f+ibZoUzYPt2WZO1sBwbo9olu0nBQWA+rFXg1r3rxIizLh78ywQ0DuQ3ML5joc7iRD
	 NtT2o75cwX5e+ECKImUeqPNDM8VOKcdvLaekDZYTG+Mcf8FA8nSgqRJaAJq+jIhT05w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="W/iJnW0I";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7EA606A320
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 15:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE7EA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=W/iJnW0I
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c2055573c8cso132504466b.3
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 08:19:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792768747; cv=none;
        d=google.com; s=arc-20260327;
        b=MiSqGMRZU4AlXUrQ0Fwu+utSbv2Q9NfdiGqA5+5X6j/vC9o7JIpbXw0j4GFtFVcH59
         OEWVpRvqNQc+n1Fk662LEe8mQbumNHHmVBPk+gQMfI9dBKdjp+v4hbloUvb4A/11jSWD
         +pBHE0DNJ/jIJ++7WACBWUOcvZuh3ncV57DCb3zrsvvczqe7CqOHSN0L+nU4R49v3Yko
         PeqWc/OTWbxhAjHO1I7uVVJgpNof9yUujf2c7V16TUt/v7DRdBfAAKd85+RDTXz+h7Lg
         TlVppLpUB5RiLLtJxkpMGhQf3lzovAwMXA2/0q//cRk7XxXZDjaSvpzITKEtYAGbZTnh
         0B+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u6uT+2Bkvv4y7LHLfpq7KqJWTqLIyrtx0un1wUCzN+0=;
        fh=0zVHGC//SC94CWFKHtFt4lnskmkXkJNNy7lE0FDd3Ck=;
        b=EJsREWE3hNWuEGl3O1cDPML5+iC5I4rXP5Xj9wHFaG1MneW2UKyPeM3x+KBNVr8QGa
         YO7iilq4NzKEVCQyFc8oGdUTQSmMIT30RHNuF8FHueUTzen42dyMSamNq/iXY0Fq0hal
         uofvqlRMRsT74hibzDbLXh27g7F7LXaATUCzkzMScvZezj9N3s+jfAHqVB974kO6Ieut
         lY4fKa/07/HjQv71gHTN/o/WtaJCQipQG7jxY/xrFNFioBT5DDKSqrvvtwbjN79U0kzX
         gq64vrY9b0Y7KNKNYYepchOwbGPxw2W3f5PDNXov5EERQcttlzSKqLXHzA7ueR4lJxko
         og1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792768747; x=1793373547; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u6uT+2Bkvv4y7LHLfpq7KqJWTqLIyrtx0un1wUCzN+0=;
        b=W/iJnW0IzJNGtz9SIpPe0M2dKqo3PWcrMbT+/M5VrV3vaMXjAqEnTtU8OBRdP6ubuf
         WX6QdSYRGbJkND3jhBoIGCximjOBUJs2zdW5Boqusk3MQMxdPaJcYQSegQeRiMai5dpu
         wvtMBd/Z7OA5OoUXLD2YuNsyen8yGEU7WJfHRulScsnKM6XJ0jnUa3NmWOZrOmMhQlG+
         Wtj4d+0o4NHzPVsjWCkimNoSsMzrrdlubJqdJfC0I1EHulWojdVT35pTVeDXHPJJBgxQ
         qa36+BXG+JOGm5ixarKRTA9j6U/hhE5ssZ7IVulua9CszkVZ68wVN6aZxcj0gYqcuWcb
         qqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792768747; x=1793373547;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u6uT+2Bkvv4y7LHLfpq7KqJWTqLIyrtx0un1wUCzN+0=;
        b=wJP3Zihu8HJ8EECGbxC3/vnimndntBpfVzS3Q8Fglg9XbuO+rXnCyLTSpGMsE2TMt7
         4kRq1JGv5w1u40XI+PFuth06PCnfjh/0MVkb6cPHTbn89rB/yVNdCIWyQO7lYOv0TpBB
         xAVUKg5hNK8LspkhcuxXN+jpOt6vPVRuc1u4N+99ZWRR2IUwuPi/WJz9w7UxEn8u+NzE
         wK7DPY3gelU6WWpABlfTdbFFYJNtwFxNz6S2S92LO2jQ1/JuSHSKsmVSSxkSqROrzAo3
         Lg3dctCMbKYkYD8IBl4/MgVoxACNDtzmNeKMD9mh5xUPG6JRMczYQR9bfd+QMGhw8GBQ
         Uiyg==
X-Gm-Message-State: AFq9FYIXX6sCm1kcd3/W3dvZy5JuR88hykm1bagoI+0anzvz9wbpl4Vr
	/e5X7Gixc0zKpbcwNrjluZPboR4+yJWrRR6w706xoiZLu4cKq2qLhrGQmQoUZGqlkI2S2ozebJA
	aK31xULm+7U2LO1umalP/1pUCMU6dBiJ1bKix/1LN3p0O
X-Gm-Gg: AYBFou3fiCz94lLNutqZlGO02tHm6FctmV3opHcw9m0LCt4sQ5l2SxHQ/7Iwea9ueLx
	rqXACmPCbN+GWcmyrKVZ+yFmNKr3aKz6kFME9z2pOPfxFWgzMfkWqr97fK6OMo/8k4OULqIpxMo
	2FxXpsPcsYblgztlx9EhOKwtqRiTfMCY7pgTHmQv4GGo1xjJfs6bp44ApkdDtjV/2p/EfD7tvjX
	xph2DowE9iGpC3HTlon7Puk2Yiu8qgaWBxaia79sqNHBMN1FHm0q+eokevbuYJu0NTnmKuVF6Bk
	vJT7a94TVeZikLm/KK6S04/Ln4K/AFzimW81XJpsRqLmpguJzSBRSAh+hV3zH/hRhVSUoCeWsJu
	6kOD//3qw4Zk9cBGmA1N6aKyqBQG+nzs72ZbHWYvXY/jMmIvicntE
X-Received: by 2002:a17:907:3f21:b0:c26:1649:47ad with SMTP id
 a640c23a62f3a-c46a942fd16mr354947966b.35.1792768746855; Fri, 23 Oct 2026
 08:19:06 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023124157.75524-1-puranjay@kernel.org> <sashiko-outbox-182810@kernel.org>
In-Reply-To: <sashiko-outbox-182810@kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 23 Oct 2026 16:18:52 +0100
X-Gm-Features: AclHuK_Rbmo7Ro6pTjXlkfAHO3a3wIhqADp6mC6QJTt3bJ2PjzxSLO5fGQVAMg0
Message-ID: <CANk7y0jNvokRcBSFvg3UwYhAS1MkEa_KwH0FfJSD62-xLKPEYQ@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/amd/lbr: Freeze LBR on PMI only when kernel
 branches are recorded
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 2:01=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] perf/x86/amd/lbr: cleared lbr_select in amd_pmu_lbr_del() forc=
es PMI freeze
> --
>
> commit 2fc471183ee73ff1339b34a8c3b4d4e03264c10b
> Author: Puranjay Mohan <puranjay@kernel.org>
>
> perf/x86/amd/lbr: Freeze LBR on PMI only when kernel branches are recorde=
d
>
> This commit skips setting DEBUGCTLMSR_FREEZE_LBRS_ON_PMI on CPUs with
> X86_FEATURE_AMD_LBR_PMC_FREEZE when LBR_SELECT suppresses branches into t=
he
> kernel.
>
> > diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
> > index a55646fcb8465..7ec50380ac81d 100644
> > --- a/arch/x86/events/amd/lbr.c
> > +++ b/arch/x86/events/amd/lbr.c
> > @@ -392,7 +392,7 @@ void amd_pmu_lbr_sched_task(struct perf_event_pmu_c=
ontext *pmu_ctx,
> >  void amd_pmu_lbr_enable_all(void)
> >  {
> >       struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> > -     u64 lbr_select, dbg_ctl, dbg_extn_cfg;
> > +     u64 lbr_select =3D 0, dbg_ctl, dbg_extn_cfg;
> >
> >       if (!cpuc->lbr_users || !x86_pmu.lbr_nr)
> >               return;
> > @@ -405,7 +405,12 @@ void amd_pmu_lbr_enable_all(void)
> >
> >       if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
> >               rdmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
> > -             wrmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl | DEBUGCTLMSR_FREEZE=
_LBRS_ON_PMI);
> > +             /* Freeze unless the filter suppresses branches into the =
kernel */
> > +             if (lbr_select & LBR_KERNEL)
> > +                     dbg_ctl &=3D ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
> > +             else
> > +                     dbg_ctl |=3D DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
> > +             wrmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
> >       }
>
> [Severity: Medium]
> Can DEBUGCTLMSR_FREEZE_LBRS_ON_PMI still be set for user-only branch-stac=
k
> events when more than one branch-stack event is scheduled on the same CPU=
?
>
> When two user-only branch-stack events are added via amd_pmu_lbr_add(),
> cpuc->lbr_users is incremented to 2 and cpuc->lbr_select is set to 1.
>
> If one of those events is subsequently removed or scheduled out via
> x86_pmu_del() -> amd_pmu_del_event() -> amd_pmu_lbr_del(), cpuc->lbr_sele=
ct
> is unconditionally cleared even though another branch-stack event remains
> active:
>
> arch/x86/events/amd/lbr.c:amd_pmu_lbr_del() {
>         if (!x86_pmu.lbr_nr)
>                 return;
>
>         if (has_branch_stack(event))
>                 cpuc->lbr_select =3D 0;
>
>         cpuc->lbr_users--;
> }
>
> When amd_pmu_lbr_enable_all() then runs with cpuc->lbr_users =3D=3D 1 and
> cpuc->lbr_select =3D=3D 0:
>
>         if (cpuc->lbr_select) {
>                 lbr_select =3D cpuc->lbr_sel->config & LBR_SELECT_MASK;
>                 wrmsrq(MSR_AMD64_LBR_SELECT, lbr_select);
>         }
>
> the if (cpuc->lbr_select) block is skipped, leaving the local lbr_select =
at
> 0 (and also leaving MSR_AMD64_LBR_SELECT zeroed after a context switch ca=
lls
> amd_pmu_lbr_sched_task() -> amd_pmu_lbr_reset()).
>
> Wouldn't (lbr_select & LBR_KERNEL) then evaluate to false and re-enable
> DEBUGCTLMSR_FREEZE_LBRS_ON_PMI despite the remaining active event
> suppressing kernel branches?

The behaviour is real, but it is not a regression: it is what
amd_pmu_lbr_del() does today. It clears lbr_select while other
branch-stack events remain, so LBR_SELECT is not reprogrammed.
amd_pmu_lbr_reset() on sched-in can also leave it zeroed, which
allows kernel branches. Clearing the freeze in that state would let
the PMI handler's own branches into the LBR, so it has to stay set,
as it does without this patch.

Restoring the benefit means tracking the shared filter properly in
lbr_del(), which is a separate change.
