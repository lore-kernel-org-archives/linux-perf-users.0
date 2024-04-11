Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFF04653C
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 22:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712876083; cv=none; b=LFSBtNmh1OSLJobpFFkifWP1Ll6MloSzhurdYFoQ6IuCV+GO33IuFAYEdG/YCRFl30DEoCyIMPn4PV/ycCcSVtEYLKP/XDR/09nTTDToaSUqYWiyuuHKn86zk9aJN3L6AIceN3P8WKb/8lOrUNseOwvGExm8/XnSBuHESQON4uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712876083; c=relaxed/simple;
	bh=FFF4qSI6uoBBrGIK3b9FdhqLuckQUcIQtIymnNKbd68=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MxglS3o7zrJpNrmVw87NSTX5JVY3wINBBP8BqEpJES/d4XUj2aoxIPJ0zsAY+xmDGdDfzUZfqbx6yItI1S8ErKZgX5K4xYnxfx1qCER3bz8hyjAPi4rCd6OuqsY8WzFkFsAZ6q6uJeAyCg7YINne6KvRDSXVt6K+PpQMgv7idv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q1/m0iWf; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q1/m0iWf"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6ceade361so624940276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 15:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712876080; x=1713480880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x13dHL4gzEYkC5yKNBRYRVXjtZD/neiLlxBKsx/gpJ8=;
        b=Q1/m0iWf6n48oMA85o7SsuG2KOZVNmp1zhDFJG8KkaBUxRf7ZsKWmjON4/Vlsmqth3
         Y1y1Sgt6LCxttV9P3/hQA+R/n+UbAT3RuuOwYkNKgm1Oc7IxDmy6sHm4RHf0uisV2jeB
         zjCFo+ZL/uWAZnrKdtWOuRbrZxljF/Vaslm5KurmYlAvbowgu4OnTAe4rtoIM1/L2t+p
         ++UYVUtYq4BJWYVcTMrEf5ilrpapvTBEPE0pFstiGA9Tzlj+KPNTbaFLZdIVY50/3CnT
         vhrTyjp9WVxsxK3M7jOlTRGs1mSg8V9Vy8/WjqaLLbi7ydxyZOHoOdOQM4K6mpJ1QytK
         xQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712876080; x=1713480880;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x13dHL4gzEYkC5yKNBRYRVXjtZD/neiLlxBKsx/gpJ8=;
        b=cL3nJGMwT+rrjEDW09FUy7aNi11lh8w0a4DgiO1GVylLr4Z4/psnQCqTBCqLj413So
         JIgIryvj1aMLieoS7S+9iL14xZ1pPsWKkMeHnq1JpTViWdWLtQyl8OxxuAJ6OZ0Qi//D
         Y9BTXLaIuW0KzR6CRLA+rTMAF7Mt96if/JDYU+gytvzCfQm9ShvWQ7hPTkteyynFg7RY
         +09RUuCwvifeIN/IinKG63BmttiRnzU6QYZ80VtoT2+mG84Ms5G8vRD1oabNKGMNonCj
         UITctUGY3IEimvdN5RV8fOri0VYKeI9BSKN32IFWWnPOwFPmlCfUexffyTPFA+vOuf4v
         tPPw==
X-Forwarded-Encrypted: i=1; AJvYcCVsMGVM9/dGpwu4mYEyOaH4b8oT2vqdNXKavOKHrjYvYt869OzeubX8w8I7nf1dvbw/EmWbBdk7fhOGT5uSXa4QqBPp1TcH7Xx00C7H93UFBg==
X-Gm-Message-State: AOJu0YyRWUJkiwpnsFXsWYr7uQNQeeWcojgf5ot3w73HZ+Y1A97ND2BC
	JYe0btydXQObVAwZ7Lta+vv4y7yUua1rxo1Walebu3Aw6L8dbh2lg7dKilg5YoKfngc30YnBMBd
	nWg==
X-Google-Smtp-Source: AGHT+IFixyNI36LFe7Hw4/TMC13l5axHf3yR8MsrIgRSI6ngxDbATajr0w1q+zCA6CWz8k4CawvbbxVBV0k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:1386:0:b0:dcb:abcc:62be with SMTP id
 128-20020a251386000000b00dcbabcc62bemr238926ybt.6.1712876080655; Thu, 11 Apr
 2024 15:54:40 -0700 (PDT)
Date: Thu, 11 Apr 2024 15:54:39 -0700
In-Reply-To: <CALMp9eTQr8ndf48uHHDem2ZkycdhAuVqz18+V1reEEfv0sx8qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com>
 <20240126085444.324918-29-xiong.y.zhang@linux.intel.com> <ZhhcAT7XiLHK3ZNQ@google.com>
 <CALMp9eTQr8ndf48uHHDem2ZkycdhAuVqz18+V1reEEfv0sx8qg@mail.gmail.com>
Message-ID: <ZhhqL2HKmcW9DAIY@google.com>
Subject: Re: [RFC PATCH 28/41] KVM: x86/pmu: Switch IA32_PERF_GLOBAL_CTRL at
 VM boundary
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Xiong Zhang <xiong.y.zhang@linux.intel.com>, pbonzini@redhat.com, 
	peterz@infradead.org, mizhang@google.com, kan.liang@intel.com, 
	zhenyuw@linux.intel.com, dapeng1.mi@linux.intel.com, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhiyuan.lv@intel.com, eranian@google.com, irogers@google.com, 
	samantha.alt@intel.com, like.xu.linux@gmail.com, chao.gao@intel.com, 
	Xiong Zhang <xiong.y.zhang@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024, Jim Mattson wrote:
> On Thu, Apr 11, 2024 at 2:54=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Fri, Jan 26, 2024, Xiong Zhang wrote:
> > > +static void save_perf_global_ctrl_in_passthrough_pmu(struct vcpu_vmx=
 *vmx)
> > > +{
> > > +     struct kvm_pmu *pmu =3D vcpu_to_pmu(&vmx->vcpu);
> > > +     int i;
> > > +
> > > +     if (vm_exit_controls_get(vmx) & VM_EXIT_SAVE_IA32_PERF_GLOBAL_C=
TRL) {
> > > +             pmu->global_ctrl =3D vmcs_read64(GUEST_IA32_PERF_GLOBAL=
_CTRL);
> > > +     } else {
> > > +             i =3D vmx_find_loadstore_msr_slot(&vmx->msr_autostore.g=
uest,
> > > +                                             MSR_CORE_PERF_GLOBAL_CT=
RL);
> > > +             if (i < 0)
> > > +                     return;
> > > +             pmu->global_ctrl =3D vmx->msr_autostore.guest.val[i].va=
lue;
> >
> > As before, NAK to using the MSR load/store lists unless there's a *real=
ly* good
> > reason I'm missing.
>=20
> The VM-exit control, "save IA32_PERF_GLOBAL_CTL," first appears in
> Sapphire Rapids. I think that's a compelling reason.

Well that's annoying.  When was PMU v4 introduced?  E.g. if it came in ICX,=
 I'd
be sorely tempted to make VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL a hard require=
ment.

And has someone confirmed that the CPU saves into the MSR store list before
processing VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL?

Assuming we don't make VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL a hard requiremen=
t,
this code should be cleaned up and simplified.  It should be impossible to =
get
to this point with a passthrough PMU and no slot for saving guest GLOBAL_CT=
RL.

E.g. this could simply be:

	if (cpu_has_save_perf_global_ctrl())
		pmu->global_ctrl =3D vmcs_read64(GUEST_IA32_PERF_GLOBAL_CTRL);
	else
		pmu->global_ctrl =3D *pmu->__global_ctrl;

where vmx_set_perf_global_ctrl() sets __global_ctrl to:

	pmu->__global_ctrl =3D &vmx->msr_autostore.guest.val[i].value;

KVM could store 'i', i.e. the slot, but in the end it's 4 bytes per vCPU (a=
ssuming
64-bit kernel, and an int to store the slot).

Oh, by the by, vmx_set_perf_global_ctrl() is buggy, as it neglects to *remo=
ve*
PERF_GLOBAL_CTRL from the lists if userspace sets CPUID multiple times.
