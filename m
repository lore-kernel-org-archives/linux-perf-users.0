Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3833BBE3
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 21:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712872268; cv=none; b=Ys6WOjbnPUyTazCGtrKDs34NHGrcIRDqoWIxffZioBSzBNKprOgbSuf/SC9nKq3+ZYWRN3JH7Op19wXcPV6ZcP6cWNU485C06TzC06+JLu5DrMsrhc3lm6FNkqnJjHXEQn/DGeinl9XGtQxNZd1KibKwsO/+mvpL7NkbevSZdrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712872268; c=relaxed/simple;
	bh=YZXEpyh6Qyq3q3FDmQZ6QZBghTPhxupbBA0DdIJPUxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bLoyky2D7FZDTwD7+aoo0EVjwJlr429b9y+t7qtaNrHfgrXhMQIMuR8yOt1alTxJggA7nHtFjc3XlReOLMBN6swE3PLNinnTSXOM8Rv757sE1kDzbT5G071BgMLDI45iSzKBXkx091EChEz3UfF5u3ErmS84L6g384NnqPvAY8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W2e4b+eN; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W2e4b+eN"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e2e851794so1754a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 14:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712872265; x=1713477065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsXvjDmIL1pHPsNVexDlNKp4aRG773Sm1Z73SBHfIoM=;
        b=W2e4b+eNp58B2CBjyD/DQyuOj/KlsxwqmI7xblF4gyxvTasO5jeYhj42DQ9gS5/Or+
         U9odyJxo066eU+ZQeNXMOFaSnpkits3Dq21fYMFuABZKh8W+ckjYwe1pg357lmauFb3J
         RCWX2qfvH1+yeiWy/46aPWm9/2y7g6WDWRod0UwWOuIyUYuLvf7u39Y9iIpJcRubnpJf
         H5WQGd+Nu3mGYEb3LulnDnOw3Waij4U0fzr+28/AY8MDYW6Hg12oKQaANziaMwOS09GA
         TlDY6+bfd2lwAJ/uHY6VIYAKRKrbeoVyGp3uR6OYwd+dC1qMKCYE78VpMNB7yKCCHVWZ
         sjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712872265; x=1713477065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zsXvjDmIL1pHPsNVexDlNKp4aRG773Sm1Z73SBHfIoM=;
        b=HuGiynsZ8t2EvwLOOmRN6uTFQnMRXshPIwUBZkJkhmIcoVSaUkLVBR5nP9Oa+f2AtW
         SmPCT4Mob5vQqHOzQdlk891oS1ftWUzNGJzOuuQ2XixmNaQn5LULd5DIFC7aKR/ySK1i
         z6RVm/MZh6UmKYewC1NteqjG7mXh/N0EImPwNLjvJF25cxfgFUQWY3zj4tT32Buezxzd
         VlfcHA8EJckDBLDnZJgiFjbuZfWZ7I7ooziyX8yHYdiuElcl7QpjCC1trnQVqyjohQBv
         1k7xmnqFj+wiLd/c7FBkkhEFqPn/IMx+bmEdwS+lhi/z6DvCtzkguKiORzRcMMRsX2kA
         cPmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJVSba8rjmgOK/Bfra0yzo4CTmKeKBbI9StHLXvF7PdGv6fAiZtewbjdToS6VMSdnAU2yYP3r3V369ad9HUGpuYUg14vMVHxOd+0huyHV0/A==
X-Gm-Message-State: AOJu0YwpBAJoB6kbbfnyjPprKN3Gfp30+270eP0tfGIIVg7frblt4Ia9
	sHwZUSLpOiuLxWwVmjsAH3P/n7B9tMMe//pNJbtI/tP6iDi6SHuIKPm/xhbagf4eVcae8i63U6H
	A4j27RNcVdIOEhONLeyJ7drjkJjuDY/KeZljP
X-Google-Smtp-Source: AGHT+IEwRZrcr/j8pOatkp+XSXulPkLq0p7ib0FXY5P6SbmHDgiAj3ftjjPDeO4k0bc1iL0DvbcFvsXHHlPYxag9zH8=
X-Received: by 2002:a05:6402:2917:b0:56f:ce8d:8f9 with SMTP id
 ee23-20020a056402291700b0056fce8d08f9mr14121edb.3.1712872264859; Thu, 11 Apr
 2024 14:51:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com>
 <20240126085444.324918-19-xiong.y.zhang@linux.intel.com> <ZhhUyk2uAXqG7GEd@google.com>
In-Reply-To: <ZhhUyk2uAXqG7GEd@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 11 Apr 2024 14:50:50 -0700
Message-ID: <CALMp9eR6-7va0XUbEYFNVtGdEzmWbAr9pXhLgSL=f9dJyAso7Q@mail.gmail.com>
Subject: Re: [RFC PATCH 18/41] KVM: x86/pmu: Intercept full-width GP counter
 MSRs by checking with perf capabilities
To: Sean Christopherson <seanjc@google.com>
Cc: Xiong Zhang <xiong.y.zhang@linux.intel.com>, pbonzini@redhat.com, 
	peterz@infradead.org, mizhang@google.com, kan.liang@intel.com, 
	zhenyuw@linux.intel.com, dapeng1.mi@linux.intel.com, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhiyuan.lv@intel.com, eranian@google.com, irogers@google.com, 
	samantha.alt@intel.com, like.xu.linux@gmail.com, chao.gao@intel.com, 
	Xiong Zhang <xiong.y.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 2:23=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, Jan 26, 2024, Xiong Zhang wrote:
> > From: Mingwei Zhang <mizhang@google.com>
> >
> > Intercept full-width GP counter MSRs in passthrough PMU if guest does n=
ot
> > have the capability to write in full-width. In addition, opportunistica=
lly
> > add a warning if non-full-width counter MSRs are also intercepted, in w=
hich
> > case it is a clear mistake.
> >
> > Co-developed-by: Xiong Zhang <xiong.y.zhang@intel.com>
> > Signed-off-by: Xiong Zhang <xiong.y.zhang@intel.com>
> > Signed-off-by: Mingwei Zhang <mizhang@google.com>
> > ---
> >  arch/x86/kvm/vmx/pmu_intel.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.=
c
> > index 7f6cabb2c378..49df154fbb5b 100644
> > --- a/arch/x86/kvm/vmx/pmu_intel.c
> > +++ b/arch/x86/kvm/vmx/pmu_intel.c
> > @@ -429,6 +429,13 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu=
, struct msr_data *msr_info)
> >       default:
> >               if ((pmc =3D get_gp_pmc(pmu, msr, MSR_IA32_PERFCTR0)) ||
> >                   (pmc =3D get_gp_pmc(pmu, msr, MSR_IA32_PMC0))) {
> > +                     if (is_passthrough_pmu_enabled(vcpu) &&
> > +                         !(msr & MSR_PMC_FULL_WIDTH_BIT) &&
> > +                         !msr_info->host_initiated) {
> > +                             pr_warn_once("passthrough PMU never inter=
cepts non-full-width PMU counters\n");
> > +                             return 1;
>
> This is broken, KVM must be prepared to handle WRMSR (and RDMSR and RDPMC=
) that
> come in through the emulator.

Don't tell me that we are still supporting CPUs that don't have
"unrestricted guest"! Sigh.
