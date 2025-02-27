Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1921FC8
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Feb 2025 00:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740614599; cv=none; b=CcqXAGnmdTqhY2OWi7s07m160owCNUIAg3asqFN8S315g0UDqq3mbkaNhrrb4wMB+N1Vlq/8hCW8YjMcOeye6nths+XgF+NJdZb8xap4yyrV3IClvh9c99yo9dSIZUWUkiSC/niwmHxsZN3UTiJJoKJiCj3YAPfSQkYR7YNdGFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740614599; c=relaxed/simple;
	bh=KkFjDxRYcbZseqFwc6DwvjKa1AnMTvM0gKC17ZUsX7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b9GD2Wm2HOESRhcchNPJzBLmrA4ldSYAWvGQNeINmCECYmzgKSECt/XiaFLx+4Hawjd9eQ1/DB2KdFX4o9WT6QfHZ3H4wjWzt3oC7zp89kIghLvxMmicOfd5dQu+bBQmvFarjYTa0Rnec8CrtzBKI05unEGdJlpYOmTuC3oaIKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=D+CFDCnp; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="D+CFDCnp"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-222e8d07dc6so7408375ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2025 16:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740614595; x=1741219395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7eluzqqf3VmMNWgnnw6mwWFDCXsND3S4l7FpeN+tcY8=;
        b=D+CFDCnpP1TskNuA9WMYh3QlhpwxOCcH5L32w6Qp8FWOmXvSgqWeBYhiwMQRvfZzJw
         G4SlXLjJz8jeWKbj8LIloP2xbC0EQGhE7HTRfzV+JTbfzmh5uDizimrTqu9srlXO+icR
         ff6z9+7MNMxVe1sgiv5K9HLUAG6E6Nomz02igb+mIZlZbWtk6ovjvNzAT1ZmyAc/jwzn
         zS1NtElP+2AXIvQl67FCEQK1frz5IQIXYTxrZ5qgo+w7RSfuB1spFG8jdDBeQi3a7zes
         WE0sO/4AwHpaVfsyTKlsIywlW3lLggP1F0yu030m53qtlGeZ++0evSA40D16sKit69lE
         vPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740614595; x=1741219395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7eluzqqf3VmMNWgnnw6mwWFDCXsND3S4l7FpeN+tcY8=;
        b=dNiOWS/WxtO79qHTI/THYtfBAOnO3oMbRLRUvY3OK0F+73cNyqVuK6puXYpFT1paZE
         XkDpV82IAxhQd+E5KCX61yiiLgHyX3e1FSFVjg6gkg7LFyK7m8h9skvQuOEoWkW28oWV
         5ZWJT4VZ2PhXvAqxhVvhofQujl2bC5jR+hkxZNf3FkVAhgvjnTYAxCJ3DG+N4k4kKukH
         zzQoC2Yq4lPFINmKAYZ240ADhvAz4mBS+9pOHetnt7IxB6Z97AAMs0bhgBDsVcQ2U3Np
         ivIHtdSb1GbQ3GJ111jgoXDPaiE2wRDyYsGmC1hNnOtzLjuPhEtbzJKeTjD9yG1GGse1
         P/PQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbq/U7rQzcDKeA4X7ONKFO7lqFoAFf6E+q9fNLyGo3L6OgYa4aqeu2SnOEpktXvdYwJlVNfUUuJPsx85MVs9U+@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/1ZpU4TWyn5tBfi9TGJc2V1QsGYqW6mSSlzeOEceHQmK2AFfw
	+45SeAPFnbUsgXbTPWfErBKIUMrpkDGQJqHrbT3A/oh+T38Q8lMntr28tJWluEWWr/gy44C4fXU
	ubVWTj5nqfBCv+APzVzpEyST9v1BEBg+eZxVhNQ==
X-Gm-Gg: ASbGncukH4O7ZebrDGNtY5cMTolRUYVrYqaSTNB848JLPhF4YcBhJHpeCnj1qpxSyhu
	XA0kKJvbnEjpXwstJtSEGSU8bXdOJ+PQP5NzkOsst8yM8k19iibK/vOlrO2wwMVGTsMQFPddlkD
	acXG7QsQ==
X-Google-Smtp-Source: AGHT+IFrt1HFaZ54tMfJQXNhrvI9R+jOmDy/nuxxOKVXc1hJS2IXrvPo+lbSmj1tQY9y14Kf7mMsIhJxPaxk/aVTs/c=
X-Received: by 2002:a17:903:289:b0:21f:3823:482b with SMTP id
 d9443c01a7336-2234b08fc3amr20812385ad.25.1740614594829; Wed, 26 Feb 2025
 16:03:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205-counter_delegation-v4-0-835cfa88e3b1@rivosinc.com>
 <20250205-counter_delegation-v4-8-835cfa88e3b1@rivosinc.com> <bcb10a3a-162b-4a8c-a479-38f4168cea9a@rivosinc.com>
In-Reply-To: <bcb10a3a-162b-4a8c-a479-38f4168cea9a@rivosinc.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Wed, 26 Feb 2025 16:03:04 -0800
X-Gm-Features: AQ5f1Jpty0qq-pYufASOZ8Op-YJ_VW5jRuImaN1P7f7dzUah8vHjK9-7awdIFLs
Message-ID: <CAHBxVyHZ+iw9dC=4xzbW-UdEELdpr-E=FtExGOMnPzUKSRwFvg@mail.gmail.com>
Subject: Re: [PATCH v4 08/21] RISC-V: Add Sscfg extension CSR definition
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, weilin.wang@intel.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 1:30=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@rivo=
sinc.com> wrote:
>
>
>
> On 06/02/2025 08:23, Atish Patra wrote:
> > From: Kaiwen Xue <kaiwenx@rivosinc.com>
> >
> > This adds the scountinhibit CSR definition and S-mode accessible hpmeve=
nt
> > bits defined by smcdeleg/ssccfg. scountinhibit allows S-mode to start/s=
top
> > counters directly from S-mode without invoking SBI calls to M-mode. It =
is
> > also used to figure out the counters delegated to S-mode by the M-mode =
as
> > well.
> >
> > Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/csr.h | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.=
h
> > index 2ad2d492e6b4..42b7f4f7ec0f 100644
> > --- a/arch/riscv/include/asm/csr.h
> > +++ b/arch/riscv/include/asm/csr.h
> > @@ -224,6 +224,31 @@
> >  #define SMSTATEEN0_HSENVCFG          (_ULL(1) << SMSTATEEN0_HSENVCFG_S=
HIFT)
> >  #define SMSTATEEN0_SSTATEEN0_SHIFT   63
> >  #define SMSTATEEN0_SSTATEEN0         (_ULL(1) << SMSTATEEN0_SSTATEEN0_=
SHIFT)
> > +/* HPMEVENT bits. These are accessible in S-mode via Smcdeleg/Ssccfg *=
/
> > +#ifdef CONFIG_64BIT
> > +#define HPMEVENT_OF                  (_UL(1) << 63)
> > +#define HPMEVENT_MINH                        (_UL(1) << 62)
> > +#define HPMEVENT_SINH                        (_UL(1) << 61)
> > +#define HPMEVENT_UINH                        (_UL(1) << 60)
> > +#define HPMEVENT_VSINH                       (_UL(1) << 59)
> > +#define HPMEVENT_VUINH                       (_UL(1) << 58)
> > +#else
> > +#define HPMEVENTH_OF                 (_ULL(1) << 31)
> > +#define HPMEVENTH_MINH                       (_ULL(1) << 30)
> > +#define HPMEVENTH_SINH                       (_ULL(1) << 29)
> > +#define HPMEVENTH_UINH                       (_ULL(1) << 28)
> > +#define HPMEVENTH_VSINH                      (_ULL(1) << 27)
> > +#define HPMEVENTH_VUINH                      (_ULL(1) << 26)
>
> Hi Atish,
>
> Could you use BIT_UL/BIT_ULL() ? With that fixed,
>

Done.

> Reviewed-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
>

Thanks!

> Thanks,
>
> Cl=C3=A9ment
>
> > +
> > +#define HPMEVENT_OF                  (HPMEVENTH_OF << 32)
> > +#define HPMEVENT_MINH                        (HPMEVENTH_MINH << 32)
> > +#define HPMEVENT_SINH                        (HPMEVENTH_SINH << 32)
> > +#define HPMEVENT_UINH                        (HPMEVENTH_UINH << 32)
> > +#define HPMEVENT_VSINH                       (HPMEVENTH_VSINH << 32)
> > +#define HPMEVENT_VUINH                       (HPMEVENTH_VUINH << 32)
> > +#endif
> > +
> > +#define SISELECT_SSCCFG_BASE         0x40
> >
> >  /* mseccfg bits */
> >  #define MSECCFG_PMM                  ENVCFG_PMM
> > @@ -305,6 +330,7 @@
> >  #define CSR_SCOUNTEREN               0x106
> >  #define CSR_SENVCFG          0x10a
> >  #define CSR_SSTATEEN0                0x10c
> > +#define CSR_SCOUNTINHIBIT    0x120
> >  #define CSR_SSCRATCH         0x140
> >  #define CSR_SEPC             0x141
> >  #define CSR_SCAUSE           0x142
> >
>
