Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1337213C91F
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Apr 2024 22:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713564205; cv=none; b=s5TEseFcwR+HRM/eJ+Vw8oS8t4Fh8oowXGz1E8QR5Te+vhkgtooXQNBMyTz5JQeWTEoZW9o2K+I2vqt8kWOtsZSHpMcxoC6MTbODJVgFh4xRqA3rydZ0+onaS4SO6dnFtQJxQZDEzzk4q2mYGiLZxYaAfA/U7XgV5sI46RJ/7Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713564205; c=relaxed/simple;
	bh=Q/Zh4Phu3kMJZN8fjVTRc3aiOk1qAnHvnKyLpI/2Y4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=evtCQszNwagmaGx2dy1N78GaOtTEJeNG8qB9A4+2J08VH8A9TOEtUb6eU9u7TzzfGCA1HeIcSU/WzEOlwRv+2lZqnEozJE5rJJ+dbHYq2sIy5IDyNLdhJeadjUb864av3C39auX1BdhW47EYnty1kPCHxJzq9dAiQFPA+20cO+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GuATQqUW; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GuATQqUW"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a5224dfa9adso438015466b.0
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Apr 2024 15:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713564202; x=1714169002; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fPM7E5V6o141sK0f0dMZ+PfvZ9fH+BP0EjEziH4VhA8=;
        b=GuATQqUWiwG1eUfs4DKhOcSeJuMl+U18hqa0DM7T10yr42EjEYFAngxc3rMjZBfDcp
         VyPa0TRuzdxejmQKvSybH0ssnIBaWC/xS6EmkW8PYemSNQ2tpej3YAfPvMpL30ty7zQL
         4f7VQMgUcrU3+CU14FzZfNh4Mtdesg/EqyTUNipPjvX9Etz57rzAXxMsNJQF7ASFUL64
         T88gMWBRkFN6bZpH4K+Mr3eTay7ech0itguD+sqAkzBWGJQntV/aGsRYZDtCvwE+/zwF
         p3J5CcKD7+U2Hp0+kUNTxPDrvCf9PfS6TwBbLRAq7sFna/uvoirA1shCVk+omdqjLwm1
         01hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713564202; x=1714169002;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fPM7E5V6o141sK0f0dMZ+PfvZ9fH+BP0EjEziH4VhA8=;
        b=IhaC7c5a7jzNn0pJV+CKwh2X4QBWE1ABRBf5P8vbtmI/LVs0ywALuL+kIKxCgd+nMT
         FNQPPz87CYJXKr8At0TR0/t20OTYMfqLoFCdpaw7/pEDGDat0G1NEiyn2iaQZz0+kVPo
         1XtY+FSpcBWD1RJ3Jp2uRBByDc/ZvR6Nj/aMeByfkV7PstC7NVh9QrBJZFQzr8XOOdoP
         NC7CuAO0pc3Gp3avHilGTUpoo2VjILbsDlB+g/UTxlapXqUQDZSf/QQcHZjsGGm8BvEw
         zY5O/dXxFcglQT+GHL49dkMA/mbU2RH2hGOA62pnS8aqF2ZXZD4JNUmpF0i3DXw8sFe+
         WdGA==
X-Forwarded-Encrypted: i=1; AJvYcCU7aiYzQtjZdGKyV1RQAv4lWPwQMSwnsQTdPWmYiSXMir2fygsUDERQoVpOm2YyconTJ3DDUQZEMt2RlDE5BW4Afk+2olSIeGre2FMJ+KOekA==
X-Gm-Message-State: AOJu0YxoX7zhSEUiqkQKQ4M/+tUYSBqfVLP+eSEkfiLBXkTBQt2ndUmK
	CoxiQLv1HCyOWTnA0w1/9CoppGeckWIPGqRTVj8mLweiiRFTqyHuFB5yRp0FegRE/JPg1fc8uFw
	Uw+qwe8zrEF3BdyPWsGsumxCfIAYAME+dPbg9
X-Google-Smtp-Source: AGHT+IH6ct4MXT/M9EFtlx7SpDj0we1LDpdCBQKOb3ZdBzAm5rjExj/ulUG+TNKLIMaXMb5ECEpOvDwF5d4LvllnADc=
X-Received: by 2002:a17:906:c34c:b0:a55:6d17:6fbf with SMTP id
 ci12-20020a170906c34c00b00a556d176fbfmr3229721ejb.5.1713564202210; Fri, 19
 Apr 2024 15:03:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com>
 <ZhgX6BStTh05OfEd@google.com> <ZiGGiOspm6N-vIta@google.com> <ZiLCjutwO6XIQp5Z@google.com>
In-Reply-To: <ZiLCjutwO6XIQp5Z@google.com>
From: Mingwei Zhang <mizhang@google.com>
Date: Fri, 19 Apr 2024 15:02:45 -0700
Message-ID: <CAL715WJQuhnNB6M8vAKVicvkp1Jt_K6H9C8rj866+YmbxYXGcg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/41] KVM: x86/pmu: Introduce passthrough vPM
To: Sean Christopherson <seanjc@google.com>
Cc: Xiong Zhang <xiong.y.zhang@linux.intel.com>, pbonzini@redhat.com, 
	peterz@infradead.org, kan.liang@intel.com, zhenyuw@linux.intel.com, 
	dapeng1.mi@linux.intel.com, jmattson@google.com, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhiyuan.lv@intel.com, eranian@google.com, irogers@google.com, 
	samantha.alt@intel.com, like.xu.linux@gmail.com, chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"

> Currently, at a feature level, I mentally bin things into two rough categories
> in KVM:
>
>  1. Virtualized - Guest state is loaded into hardware, or hardware supports
>                   running with both host and guest state (e.g. TSC scaling), and
>                   the guest has full read/write access to its state while running.
>
>  2. Emulated    - Guest state is never loaded into hardware, and instead the
>                   feature/state is emulated in software.
>
> There is no "Passthrough" because that's (mostly) covered by my Virtualized
> definition.   And because I also think of passthrough as being about *assets*,
> not about the features themselves.

Sure. In fact, "virtualized" works for me as well. My mind is aligned with this.

>
> They are far from perfect definitions, e.g. individual assets can be passed through,
> virtualized by hardware, or emulated in software.  But for the most part, I think
> classifying features as virtualized vs. emulated works well, as it helps reason
> about the expected behavior and performance of a feature.
>
> E.g. for some virtualized features, certain assets may need to be explicitly passed
> through, e.g. access to x2APIC MSRs for APICv.  But APICv itself still falls
> into the virtualized category, e.g. the "real" APIC state isn't passed through
> to the guest.
>
> If KVM didn't already have a PMU implementation to deal with, this wouldn't be
> an issue, e.g. we'd just add "enable_pmu" and I'd mentally bin it into the
> virtualized category.  But we need to distinguish between the two PMU models,
> and using "enable_virtualized_pmu" would be comically confusing for users. :-)
>
> And because this is user visible, I would like to come up with a name that (some)
> KVM users will already be familiar with, i.e. will have some chance of intuitively
> understand without having to go read docs.
>
> Which is why I proposed "mediated"; what we are proposing for the PMU is similar
> to the "mediated device" concepts in VFIO.  And I also think "mediated" is a good
> fit in general, e.g. this becomes my third classification:
>
>  3. Mediated    - Guest is context switched at VM-Enter/VM-Exit, i.e. is loaded
>                   into hardware, but the guest does NOT have full read/write access
>                   to the feature.
>
> But my main motiviation for using "mediated" really is that I hope that it will
> help KVM users grok the basic gist of the design without having to read and
> understand KVM documentation, because there is already existing terminology in
> the broader KVM space.

Understand this part. Mediated is the fact that KVM sits in between,
but I feel we can find a better name :)
>
> > We intercept the control plan in current design, but the only thing
> > we do is the event filtering. No fancy code change to emulate the control
> > registers. So, it is still a passthrough logic.
>
> It's not though.  Passthrough very specifically means the guest has unfettered
> access to some asset, and/or KVM does no filtering/adjustments whatseover.
>
> "Direct" is similar, e.g. KVM's uses "direct" in MMU context to refer to addresses
> that don't require KVM to intervene and translate.  E.g. entire MMUs can be direct,
> but individual shadow pages can also be direct (no corresponding guest PTE to
> translate).

Oh, isn't "direct" a perfect word for this? Look, our new design does
not require KVM to translate the encodings into events and into
encoding again (in "perf subsystem") before entering HW. It is really
"direct" in this sense, no?

Neither does KVM do any translation of the event encodings across
micro-architectures. So, it is really _direct_ from this perspective
as well.

On the other hand, "direct" means straightforward, indicating
passthrough, but not always, in which KVM retains the power of
control.

>
> For this flavor of PMU, it's not full passthrough or direct.  Some assets are
> passed through, e.g. PMCs, but others are not.
>
> > In some (rare) business cases, I think maybe we could fully passthrough
> > the control plan as well. For instance, sole-tenant machine, or
> > full-machine VM + full offload. In case if there is a cpu errata, KVM
> > can force vmexit and dynamically intercept the selectors on all vcpus
> > with filters checked. It is not supported in current RFC, but maybe
> > doable in later versions.
>
> Heh, that's an argument for using something other than "passthrough", because if
> we ever do support such a use case, we'd end up with enable_fully_passthrough_pmu,
> or in the spirit of KVM shortlogs, really_passthrough_pmu :-)

Full passthrough is possible and the naming of "really_passthrough"
and others can all be alive under the "direct PMU".

>
> Though I think even then I would vote for "enable_dedicated_pmu", or something
> along those lines, purely to avoid overloading "passthrough", i.e. to try to use
> passhtrough strictly when talking about assets, not features.  And because unless
> we can also passthrough LVTPC, it still wouldn't be a complete passthrough of the
> PMU as KVM would be emulating PMIs.

I agree to avoid "passthrough". Dedicated is also a fine word. It
indicates the PMU is dedicated to serve the KVM guests. But the scope
might be a little narrow. This is just my opinion. Maybe it is because
my mind has been stuck with "direct" :)

Thanks.

-Mingwei
