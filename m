Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963CD200BB4
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Feb 2025 06:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738650932; cv=none; b=u+c1kiZz2BgT3vMUcFcNphh0DC8g3FIPvYwYd7i44TYC9Xn16NAKEjRv927qBZayUJFIJ6w1eS4sSKWlg7HCVotJIB1KrvmU2og/pzjLiFBWyDlwKno9zFbUOrW4d7epO7MG751JWoeUTIJS1Sp6DC4AzOpagLB8pKiX1kw5AR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738650932; c=relaxed/simple;
	bh=L4IPFLUZXPgCzGDRwvYzbZVZH31xHwtQ3BWg+rkmdck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TUcmcg2IkSo1whL3s+eeMhJ7PV20QSfE+OcHuIxRGkAHzWpNAxssDAPjZqo3/edj6BDHiH4goEs3jS3mCEqNT8WtLAK3PrBcUhpW06goA1a7SMceiRBe7c0P7NDurtkd+kl7VIy21vEjcvanKW19l5sbuHcGrnq47r3FZSIM3Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=TyGt/mYd; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="TyGt/mYd"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee9a780de4so6704508a91.3
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Feb 2025 22:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738650928; x=1739255728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMHiHPDNCUJ48N5qcuZlI6iRMY6kpg7JJf8A3gbeaKQ=;
        b=TyGt/mYdwBkYF02/SBxoWhiPVXjlUnmcaU9iZ+l1BHQ9uuYAwHlsX78BzEAGQGOA/z
         KCeQS3lg3Io8+F2q3UB4TtvSbd3IFaS9hIgkVeiDBW6ShZRc1+NJT4EVj90/sX+QqgMl
         5mvLwLMZ20fR5UB7ouvnnUM6jTcXPihjUAAo0xdUJAJkSRaxEULp0jdOSg7tma+SdyJE
         SG75ZXJhW5mjJM2/0I6Z+kc3xdqNf+SOZknTI7fvjQUL9Ka9VkhPxu9pGbCYQP3awEf0
         2yIE2xvKyLwb1+F3wLWAydbfvhmF1pRsMWoDKo6j2vynBtHP05WQ9x2vD4j4NxeN+ReW
         Sm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738650928; x=1739255728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMHiHPDNCUJ48N5qcuZlI6iRMY6kpg7JJf8A3gbeaKQ=;
        b=UtZB/3f+Tl7/Bx6H26WCKkWcWjVtuBXg+6MeOMoaHr/X6oSY55GtCbtyC5sxzr7lmG
         /XzpGlEdBuvDPqAa447WakNi5eF5zIxvRS7/XmMydSc/IkO+e5QK8g3Z2skRlIRyY2Ak
         OMQeOzIa6eZ2UQ4mKRuBG5NjUwJiWvchIL3YxNqX9BS8HeXJHWJ2Mj/WXb/80ARs87Fk
         xY3aqx2grQTNMLFgiEHvbi+YaGOAe9Jshorpjq8boIBjCjvMOkxHIm/ujI+sQVyE0v1N
         ZLjJuLmrRcuMwgv7z5mLSjKRREb9615ZM2q7nuwo41HWvQ6ixkuiMyV/nhKUBZJpsbKk
         Sxfw==
X-Forwarded-Encrypted: i=1; AJvYcCXN63RAbKRC7cIua4gEzAnFbkbjA41i0CDN1x5ICpmntfJoNIklkWNZZHRCcIW9POX4XafVUuSxyJkrDpzafHD4@vger.kernel.org
X-Gm-Message-State: AOJu0YwcXZIFpmtsbGMAqx2nxzqSjIoUFOvHF4dDbETkonTCT6E5pAgn
	1ZYjkmuXhoLrh2Hc5A3ekVr53GRHXJSUu6lINpWRCo3bWFWHDh7hPiFjTyXoqb00zCrNCuasAUt
	+6d0SjP6q74spE48xCeNWmk36pVS00KpAJrEfVw==
X-Gm-Gg: ASbGncvXMIU1rfVrVwIPxLo1xZ5Cq2HAIOtyDp0wj3c5RxtMi3aj+cSVJKgMHbMP0/Q
	UeNGeWvRJpTT6rpuVBOtqj3SRDss9b6UJw0vzJJqCOhunyfdrjQms/H2/zv9M7YeAk5aWfhjpSp
	I=
X-Google-Smtp-Source: AGHT+IFG/yEpW4K/pBHBk3/3BqLXGkFedpykl/V/VPy5N/H80JyAnUu1lUWvkGlaAAzc1oYTPiZqDlNAWdxjP6mgSAs=
X-Received: by 2002:a05:6a00:2d8e:b0:725:cfa3:bc76 with SMTP id
 d2e1a72fcca58-72fd0bce05cmr36986225b3a.4.1738650928448; Mon, 03 Feb 2025
 22:35:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127-counter_delegation-v3-0-64894d7e16d5@rivosinc.com>
 <20250127-counter_delegation-v3-9-64894d7e16d5@rivosinc.com> <20250128-jubilance-mosaic-e3a81199aec8@spud>
In-Reply-To: <20250128-jubilance-mosaic-e3a81199aec8@spud>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Mon, 3 Feb 2025 22:35:18 -0800
X-Gm-Features: AWEUYZmuaq61PKoOBoJPiVshD43YM3UyPResBSMNdOEGC5qC9mJGFE-MKtc9ZW4
Message-ID: <CAHBxVyFVYwQ=aiB+RBrQNMQiu4K4uzPgyz8Tn=dUjeN8KKd=sw@mail.gmail.com>
Subject: Re: [PATCH v3 09/21] RISC-V: Add Smcntrpmf extension parsing
To: Conor Dooley <conor@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, weilin.wang@intel.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 10:11=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Mon, Jan 27, 2025 at 08:59:50PM -0800, Atish Patra wrote:
> > Smcntrpmf extension allows M-mode to enable privilege mode filtering
> > for cycle/instret counters. However, the cyclecfg/instretcfg CSRs are
> > only available only in Ssccfg only Smcntrpmf is present.
> >
> > That's why, kernel needs to detect presence of Smcntrpmf extension and
> > enable privilege mode filtering for cycle/instret counters.
> >
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/hwcap.h | 1 +
> >  arch/riscv/kernel/cpufeature.c | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hw=
cap.h
> > index 2f5ef1dee7ac..42b34e2f80e8 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -104,6 +104,7 @@
> >  #define RISCV_ISA_EXT_SMCSRIND               95
> >  #define RISCV_ISA_EXT_SSCCFG            96
> >  #define RISCV_ISA_EXT_SMCDELEG          97
> > +#define RISCV_ISA_EXT_SMCNTRPMF         98
> >
> >  #define RISCV_ISA_EXT_XLINUXENVCFG   127
> >
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeat=
ure.c
> > index b584aa2d5bc3..ec068c9130e5 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -394,6 +394,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D=
 {
> >       __RISCV_ISA_EXT_DATA(smmpm, RISCV_ISA_EXT_SMMPM),
> >       __RISCV_ISA_EXT_SUPERSET(smnpm, RISCV_ISA_EXT_SMNPM, riscv_xlinux=
envcfg_exts),
> >       __RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
> > +     __RISCV_ISA_EXT_DATA(smcntrpmf, RISCV_ISA_EXT_SMCNTRPMF),
> >       __RISCV_ISA_EXT_DATA(smcsrind, RISCV_ISA_EXT_SMCSRIND),
>
> Isn't the order here wrong?
>  * 3. Standard supervisor-level extensions (starting with 'S') must be li=
sted
>  *    after standard unprivileged extensions.  If multiple supervisor-lev=
el
>  *    extensions are listed, they must be ordered alphabetically.

Yeah. Fixed it. Thanks for catching.
