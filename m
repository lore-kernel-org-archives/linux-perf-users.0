Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCB014A09C
	for <linux-perf-users@vger.kernel.org>; Fri,  2 May 2025 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746198252; cv=none; b=kFnC1i6znQvbuIxuLI7RL4a9HwvOwGQcKRq500XDuJubQaXGDr05sp0EDpWAH7wjRziWuLr/EdrBTJIsF566EwPchB0rSIhUnCgnKLoqF9rAZDKDeAH4h7dHg0/WwXhZN/6h12gb9pargpy19p3XAjX0YI5OH23YxIRJoR3TK7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746198252; c=relaxed/simple;
	bh=ZfdAuZ4luE7ecRrrKYgU2xqiiinSC6V246gx5SGCqOU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NVEhfUynzDQZpQ5sx8Pv15Pep8+r4LogHGs9DriPzCaYUJwX8pZdZvUs3BgCi8RWPxM065x6hpteN/RYp95XSvrk0r7RteDjwUzNn5bpNDsO4feuFzhLdMPlKZ12uMefXm5pFEriaV5BRrNF02qWkH45HLXBUs595zyFCdKghKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dv9A1z3j; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dv9A1z3j"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff854a2541so2102007a91.0
        for <linux-perf-users@vger.kernel.org>; Fri, 02 May 2025 08:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746198251; x=1746803051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FvHi4YFKCbuqsMQKI+TX+enTdCmUmo+3VNuon3agJYk=;
        b=dv9A1z3jizHik41nuxffAzkDLEA/b64VBy1nyJHEQFPWZd1BZRwAMvaPDIG+UiKeCK
         HksGDYnD8e0fkV3K3mqfa46ijcFQg5JgxlgiEM7vc5uxL4i9Rv2wAcUs3wS5QivNdBoT
         +mAufLAiHS+HTbvODNl72H/5BZM3hHF/6PeYKKcHdZGtv1mR13dAl4hMS9wlcV0pL07k
         ocMwfYc3BWRxC51L8ozdvkztMsojw14ZI28HCjSAD9zT1CJ6uYNLGeg9fDRPitmKdcxY
         ptC1cLyYvHZmJPwqwYrsho7YkX0ikU1BDSef9pSZKhWpcWBA20MmS2jQAAo872PiM+Q5
         UZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746198251; x=1746803051;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FvHi4YFKCbuqsMQKI+TX+enTdCmUmo+3VNuon3agJYk=;
        b=Ej4vkEyUHWMg3tAwYju8Q2FLqPtkUvpnY5LLAtL4ax41oVI4PN7zYcfCobOAOmE0Mz
         woFwtX8ouCXL+w0kTY+m9R10qbh138Kb1FRPsILLKmomwEsYCWuEWTwfOGn9RK+ye4E9
         l9u/4RSGz/Br0EBHbWpognDjym5dwNvCg6atYFVJKnngztoFcw/4IHsXfofiKHZSvcEZ
         RzwxdgcTN3FCyODkVy82XerxkI1HBrxX7gnqS76PJSLfDtK3Vwk9aTXITzNp+e5Qocg2
         dSaWAQCDKC6jKCndTNUOVEmETmuWkOoQXVhq+9FJ3qnSDpaG/IPIKoOkATf97jv00ijR
         DwPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgrh40v4SFOZ/eRLJfUMtyjTDaj18XwPMk6OPmTbXTzMdp++seUuN5K2QUnF3cFAzJgQA5+99IvpFtHYdx+OVg@vger.kernel.org
X-Gm-Message-State: AOJu0YzEfYP5F2TC9gGQ++q3oyzkoaFYOPiGhX9dvbLuhn5fIPtA5RnW
	dZJ0gT9kPI3tzgj9SNdNH6Tg6xPF+Mu+zQVucRlb4EFBXIMbPygxLS3c/OadUEPsWo8kykafpZy
	9Qg==
X-Google-Smtp-Source: AGHT+IEq9Ml4E8TtIdCStMt4qKKAbF1zNt+6heIhpZJLGDBHf9KVgBdqXSANU9yLOCS831wxgusg2lp6zCk=
X-Received: from pjbpt18.prod.google.com ([2002:a17:90b:3d12:b0:2fc:11a0:c549])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:56c8:b0:308:1ee5:4247
 with SMTP id 98e67ed59e1d1-30a4e6b457dmr4586669a91.32.1746198250755; Fri, 02
 May 2025 08:04:10 -0700 (PDT)
Date: Fri, 2 May 2025 08:04:09 -0700
In-Reply-To: <701a94eb-feac-4578-850c-5b1f015877af@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250426001355.1026530-1-seanjc@google.com> <701a94eb-feac-4578-850c-5b1f015877af@linux.intel.com>
Message-ID: <aBTe6dpaQs6bmFwh@google.com>
Subject: Re: [PATCH] perf/x86/intel: KVM: Mask PEBS_ENABLE loaded for guest
 with vCPU's value.
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Seth Forshee <sforshee@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 27, 2025, Dapeng Mi wrote:
> On 4/26/2025 8:13 AM, Sean Christopherson wrote:
> Currently we have this Sean's fix, only the guest PEBS event bits of
> IA32_PEBS_ENABLE MSR are enabled in non-root mode, suppose we can simply
> change global_ctrl guest value calculation to this.
>=20
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 09d2d66c9f21..5bc56bb616ec 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4342,9 +4342,12 @@ static struct perf_guest_switch_msr
> *intel_guest_get_msrs(int *nr, void *data)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arr[global_ctrl] =3D (struct p=
erf_guest_switch_msr){
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 .msr =3D MSR_CORE_PERF_GLOBAL_CTRL,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 .host =3D intel_ctrl & ~cpuc->intel_ctrl_guest_mask,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 .guest =3D intel_ctrl & ~cpuc->intel_ctrl_host_mask & ~pebs_ma=
sk,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 .guest =3D intel_ctrl & ~cpuc->intel_ctrl_host_mask,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };

Hmm, that's not as clear cut.  PEBS needs to be disabled because leaving it=
 enabled
will crash the guest.  For the counter itself, unless leaving it enabled br=
eaks
perf and/or degrades the sampling, I don't think there's an obvious right/w=
rong
approach.

E.g. if the host wants to profile host and guest, then keeping the count ru=
nning
while the guest is active might be a good thing.  It's still far, far from
perfect, as a counter that overflows when the guest is active won't generat=
e a
PEBS record, but without digging further, it's not obvious that even that f=
law
is overall worse than always disabling the counter.
