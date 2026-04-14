Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8621277037
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 21:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776202325; cv=pass; b=cY23nPsLfBvUQ1dm0ot3+BPjxRFtyV0U770V00lDKQ1w/nOfW38Zt8UxPsBp3IpF8u+b0UEwaTC3BjJt22gvQrR2vnJlzc4sqte9NdPwqHwCxMqv5z8uWhiaKs2tzez7HNDSmeqUnr+cSiFFTDuhptOzzmVHKz9zWZTU2I/JQyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776202325; c=relaxed/simple;
	bh=0bMWbNNPknOMlnrZ9ePIa3JmJ4zSpsHKBv9BnylTqfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fEhHoUA2ZGLLHtqx07dbSPnfjhDM9+bIdm9CX82GObKur5SqM4twEhfxkHXXObveMWtVeW6dJNA4CM0D4ybIYHMJHEmN4ufcZ4j/b8yNbVaOkGUks77KvQsO81aL0gauDDglpXj99ggqttXU8uFFcJ+Ip1bx5uLUoWdGbLBeT7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jwbc9VEB; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jwbc9VEB"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-671f1a0d0c5so11727a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 14:32:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776202322; cv=none;
        d=google.com; s=arc-20240605;
        b=AMCY99RbhrtX0Bx2B75/biwxoccNiBPrMcNr60KdxfKovFmMNK8DV6d9PObb4tDxO0
         DuYrCrS27DRMPUabzlOi+8Xz7ErZpY8KPFJHQ/RulRZc2UGPGekmYH32PNlNHpM9A1aC
         7EFdURDiVneFmIbYMCuO4Kz2oErAI7st4KVbHPycGWKCPgjtCwVfZvxLaRDN1eH4gzeF
         Q73gOrGmpBLfLwcw+OpuDKFJFsCWC6UyKnkbCCHp7NfzfRHSIVgoJ+PyvwI7n3/mT0Mu
         ar9iq2PnnhkqDRLP4Jp5N7y8UQ7vBrFYxICKjhkGj/P/yUZfDgKdp9l4NAVaEYLGApBs
         LIeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8c04rmjwJCz23olx6KFxvIUrFknICuWDtkhXScF2mj8=;
        fh=oDxxXJQltY02H3DhGD7FkiTLk/03nM/AThjyArqxSrk=;
        b=ZudIMX+KtiRaAG3wNTgb1Zxn9ITGBB0MErgzZ2YG1JTK6z3np+Q0f4P6th98u+dptm
         gf4xngH5u5n4Y1qCj3lBMj1sh+qGYidrDTB3i+mtlo11KcKHdIlh3Elo94cw/jyJEi2p
         uB7CI2LLTcCGEsLm5L9bvi+6MafhGwmtv+xKwk8IRcmJSYuA0nGvqDFW8Q1CJ5W1MeEw
         cvDfgTNcGwEnkjQPknN5ustEi1UNwaplIN4+6/tKusehwb4nB31pQQn/QMW2ay5Np+pg
         W7+BvkilSvaQu9WVXWcDLVR+WN0lBnoAEWfnlC6A69i1ZceB50De7Ch6+8mAGN2NKYKX
         GsAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776202322; x=1776807122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8c04rmjwJCz23olx6KFxvIUrFknICuWDtkhXScF2mj8=;
        b=jwbc9VEBKCnomLMpeCxBRsw6NmouLBmlWuI5cSdVmx67mzKZp4aiM7bzagcizwZ88K
         NKN5VdYXTmu9Nclvc0ZloL6ylPvOjmT8/6ZhjDnu1FF7VWdKYeD8Mrb77+6uwryAC8c+
         g9qkuqRcWousstSvXSWd6nrocQKXXEqrx9JIGInZCghwEyY2DE5Wv9gANVmZ7yfOfMGG
         n01tCZ04X3F91tqkM1kqCebOOWinMy8+ChsFf8Kiop8cgHaa7QhDy8JjSrbF+vpKmKQp
         E3rN4JkR908NDE61fbTQ1dHRrqGYm9oa+vXkTZk7dyYqY0B+H3OOS+zLmvsGfNWwXZQL
         HJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776202322; x=1776807122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8c04rmjwJCz23olx6KFxvIUrFknICuWDtkhXScF2mj8=;
        b=aMyD0LZyQbGWT9Ayy6pHI3SRKvFuJpdTqnjbmwdzpGtjGS/xQEm+Kky/cMlv4r2DKA
         szP3f4YQxJbPLMJ3EbprU+eX802xIPn+76NY2FHrnaUrp7lUgId4v7GS/VLsPixNSU3W
         tgfJyY0VLWNr1UURW2RHH0zgVft0OPkuOV0egF0LNG6CzhBIG4rukdrhdUBQtE4qG3hS
         Je2msED9fh3tgEkiYtKx7IsoPxdz2nAoP3pl/mvmCwHPHtAUhJGtDSNqaJ1dhDeITkvz
         wg2dtT8mJY6aEJFEQCarLeH7CeSWw40CjPFLngtKQFeYw+tAG2skfO83WnbsBjBVr4kj
         7vWw==
X-Forwarded-Encrypted: i=1; AFNElJ+pDm3Tkq0sbxihTTwG91ovtC2/kGbTcq6QCxSDTnska+Qd/rYTwPj9GXn3RMkrR2XVzKI7FfPS31CCFGBQwSWD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw25ST3OhUUSwAN1YpNgCEh3MgR/9YH/3DSu9y8eTmu42X8zANO
	QNM3JnkiH+zcOBbyRmiiWUhkDow7dnHjj4Q3gBdSkbSV/+Gb9tZStMhLxco4hDaxD0hiOn9kezP
	YhdHQNxizqM1P5444PvdZiE2F/hDwBg6s91F6ydfq
X-Gm-Gg: AeBDietGKjcKhsrOdB9neZjD0UlGzd9mWpY305+PqUvE9rORd/W9PXleeKkWMJwSQuE
	4ZDD8xu9vx3YNSIhcqeZyKEAhxoP7xrp1IUKPunfRZ/4B5KohQlrgJZKHzFLTXOZlVKSIiuzBga
	1rhgvuNCX8LR4ky4qYygAN4rr6kArxU/dHi+6yv+jV4BdOdzRNYzOCn220bialbXXmMTU6owZDk
	2yYiOPC/3qIHZZoaWfKkMt5GzCvQnf/bnPgYLIaU2UEWOq9TDtEwmzTH1VyXFHbdQ+DTalErAaV
	lBq+DOUccxHunoshvcvm5lK2xx8Q
X-Received: by 2002:aa7:c606:0:b0:66b:99df:42e2 with SMTP id
 4fb4d7f45d1cf-67229aa19e2mr13192a12.10.1776202321602; Tue, 14 Apr 2026
 14:32:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414191425.2697918-1-seanjc@google.com> <20260414191425.2697918-3-seanjc@google.com>
In-Reply-To: <20260414191425.2697918-3-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 14 Apr 2026 14:31:49 -0700
X-Gm-Features: AQROBzAC-9qtV_u0_YI9YPgxTE2VIB9LQd99hMrKGKTMLu_9aTuwTBwGQJttTtI
Message-ID: <CALMp9eRxd=-xotnr9rLYhHtVK6G5oGAbXByXgpt078G8mWQEqg@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf/x86/intel: Don't context switch DS_AREA (and
 PEBS config) if PEBS is unused
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Stephane Eranian <eranian@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 12:14=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> When filling the list of MSRs to be loaded by KVM on VM-Enter and VM-Exit=
,
> insert DS_AREA and (conditionally) MSR_PEBS_DATA_CFG into the list if and
> only if PEBS will be active in the guest, i.e. only if a PEBS record may =
be
> generated while running the guest.  As shown by the !x86_pmu.pebs_ept pat=
h,
> it's perfectly safe to run with the host's DS_AREA, so long as PEBS-enabl=
ed
> counters are disabled via PERF_GLOBAL_CTRL.
>
> Omitting DS_AREA and MSR_PEBS_DATA_CFG when PEBS is unused saves two MSR
> writes per MSR on each VMX transition, i.e. eliminates two/four pointless
> MSR writes on each VMX roundtrip when PEBS isn't being used by the guest.
>
> Fixes: c59a1f106f5c ("KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR emulation fo=
r extended PEBS")
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Mingwei Zhang <mizhang@google.com>
> Cc: Stephane Eranian <eranian@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/events/intel/core.c | 41 ++++++++++++++++++++++++------------
>  1 file changed, 27 insertions(+), 14 deletions(-)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 002d809f82ef..20a153aa33cb 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -5037,23 +5037,14 @@ static struct perf_guest_switch_msr *intel_guest_=
get_msrs(int *nr, void *data)
>                 return arr;
>         }
>
> +       /*
> +        * If the guest won't use PEBS or the CPU doesn't support PEBS in=
 the
> +        * guest, then there's nothing more to do as disabling PMCs via
> +        * PERF_GLOBAL_CTRL is sufficient on CPUs with guest/host isolati=
on.
> +        */
>         if (!kvm_pmu || !x86_pmu.pebs_ept)
>                 return arr;
>
> -       arr[(*nr)++] =3D (struct perf_guest_switch_msr){
> -               .msr =3D MSR_IA32_DS_AREA,
> -               .host =3D (unsigned long)cpuc->ds,
> -               .guest =3D kvm_pmu->ds_area,
> -       };
> -
> -       if (x86_pmu.intel_cap.pebs_baseline) {
> -               arr[(*nr)++] =3D (struct perf_guest_switch_msr){
> -                       .msr =3D MSR_PEBS_DATA_CFG,
> -                       .host =3D cpuc->active_pebs_data_cfg,
> -                       .guest =3D kvm_pmu->pebs_data_cfg,
> -               };
> -       }
> -
>         /*
>          * Disable counters where the guest PMC is different than the hos=
t PMC
>          * being used on behalf of the guest, as the PEBS record includes
> @@ -5065,6 +5056,28 @@ static struct perf_guest_switch_msr *intel_guest_g=
et_msrs(int *nr, void *data)
>         if (pebs_mask & ~cpuc->intel_ctrl_guest_mask)
>                 guest_pebs_mask =3D 0;
>
> +       /*
> +        * Context switch DS_AREA and PEBS_DATA_CFG if and only if PEBS w=
ill be
> +        * active in the guest; if no records will be generated while the=
 guest
> +        * is running, then running with host values is safe (see above).
> +        */
> +       if (!guest_pebs_mask)
> +               return arr;

I think this has an unintended side effect. If DS_AREA and
PEBS_DATA_CFG were previously listed (because pebs_guest_mask was
previously non-zero), KVM will leave the stale entries in the MSR-load
lists.

KVM only clears MSR-load list entries for enumerated MSRs with
matching guest and host values.

> +       arr[(*nr)++] =3D (struct perf_guest_switch_msr){
> +               .msr =3D MSR_IA32_DS_AREA,
> +               .host =3D (unsigned long)cpuc->ds,
> +               .guest =3D kvm_pmu->ds_area,
> +       };
> +
> +       if (x86_pmu.intel_cap.pebs_baseline) {
> +               arr[(*nr)++] =3D (struct perf_guest_switch_msr){
> +                       .msr =3D MSR_PEBS_DATA_CFG,
> +                       .host =3D cpuc->active_pebs_data_cfg,
> +                       .guest =3D kvm_pmu->pebs_data_cfg,
> +               };
> +       }
> +
>         /*
>          * Do NOT mess with PEBS_ENABLED.  As above, disabling counters v=
ia
>          * PERF_GLOBAL_CTRL is sufficient, and loading a stale PEBS_ENABL=
ED,
> --
> 2.54.0.rc0.605.g598a273b03-goog
>
