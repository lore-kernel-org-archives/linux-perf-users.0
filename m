Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A7A4A2608
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 15:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820296; cv=pass; b=YnWFHjpVuAGRns7nel7llgpOFv3/hhqSSBhqhUi/UM38umP3jHKPbIdqzpRFkEoh3y1RsNnXsdYTsL45LsHDN5IIYQIqWG2FhyuN4oq3TD2OfURwVqgUjEksD7EslV3QTVBaTiRNExwHeQQDV4Wx3hVKMUQj5wyh2w/eHUYW65w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820296; c=relaxed/simple;
	bh=2HkM2JG2ntV4O9L1XnPwIDhp9hlRGoVV+6lp00SUDi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RpChn8wAq8zbZtRD1CRmKwMFxyXUsi4BfgbIICCSv303vGSak7VQSHiUnSbraVpHWULslLaYOH+BpHtUaoh18pYW5PZYGFmrkhHxdT+ieTDM15hHiIpiob4IFpBI4B5MPs+T2OLvWB+W6q4pTjEkNUVeNV2ASX3hYaiJqxtTCBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAwRCGPb; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAwRCGPb"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c315a445752so319727766b.3
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 08:51:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791820293; cv=none;
        d=google.com; s=arc-20260327;
        b=gXQZsOKx375iHxhrkyYiE0S18wul2l8JplmctJbMXEnptU9sj1wpEjURnTcVJ8uc//
         aEuxWH3kfKoCNqqsuz9kqtfVoPgtUleG+C3MrK8X1JNy0jrGCTahjtazQaVPoIr87m+P
         lYOs8wp6BDPa0yU1Rt4lzPA2ExmvPPfZIDxKmx1U9h0e6nnEsQ48CdtYypBY0u1xmR74
         8PY5RoWYppSirBVDYh4f+JzGJu7IlDcs8MEnnhHmjAzc/taasM2aul/MT+U5WSkaXw69
         XsHmh9UCNaI4OVa5ZyAvFT8FG3XLC8Cg82q6PLfxnzw4kgqQi9yCoyKIjFf/kHhWpdgu
         0lAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ktNtTU9JVKl3ZfnOkIWLssk9gxWZSjBCu9lT+n1NcmY=;
        fh=uD4qEw+QBg6dEP1hMb+s3LBr6hPm1a5U1eQlX7eTB8g=;
        b=NM9YQAnPswy8KDwMa3WGdLpOv3abFVKYnnxo+8sYKuJn+5yve5MRy87bVhGiChwDlv
         LVz64pf7kGvdY1uHqEYSTZvYRX75uE6uqTRWT9dQy1CWUXDullZDt9r9j7uGnFpOeNXK
         Qb1DYKoBN03hh5CaDQol2+E9vRln7lPNPpXdxXB7zLB84H3R/O2QjbclJPoEBOeV1fx4
         Rl95MoSwuvGgMaAw7KRuXShb15WhvEb7OMYhW8X+ZxhmXS9YAS2z74Jrb4wpxhnhS7d3
         YZ8T22cPzawWuV4cwCc7EhGGFRKjCkilEBI28/sCI9ENHXwAba39TGkUZ2YxemMUfany
         gIMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791820293; x=1792425093; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ktNtTU9JVKl3ZfnOkIWLssk9gxWZSjBCu9lT+n1NcmY=;
        b=MAwRCGPbF0QPfcfV9LnuZ5kmzcZSsQr/euUjqbBg109DgnrDdDQlH30j26KpRK0iQl
         JL5pmwQXyPs/Ko/IsrXlFrReAPp+f8uvp1M74hwpmJbekZxsVYzxKdiyNYH89O0XQG16
         moK8vjGr+e2SUn+GikOB0h6Ky14moFiRs8W/u42bp6iBR3X4CDJeFCezN3W/hW8Ot3it
         C4A5UUPY+N/kUEzMWp54N+nCDePa7mz0Zqg1yeu8WjACmZK0qu3Ekb3HvR5ufGtDBfkq
         4CMUDTTVZ7LuOkzG6vdpSbswau6RzGI2QPzzob51y7vzH2grxM3ukwG7nYHrHPiux6EM
         yQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791820293; x=1792425093;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ktNtTU9JVKl3ZfnOkIWLssk9gxWZSjBCu9lT+n1NcmY=;
        b=fsw8qB0wDm6jng3+JvhJIUItsDtjbfc9r+kZEG84U0g4A4rtZjWw9uorWDirrMeJMN
         eIkmYnL+dtjdGW+L0LYD58ZQ+m3l585rLFE46++LrDs4MB9tbfG1D+O7IdV5Lf/VKvTt
         oMNlDuh/KNk8TfXvePEdHPKBMFPio50gSTHY4zs0+X8a2/AIx8e2ttmvmGuxN+OAGItD
         37VtOCv5ofIwF3uz03L8XknliESxzkZdmKl2KqF9Yoxmyhn03lWoMWxb/FEm7CyPwE2D
         5GjSW6nBSZqbQZnvIb3D4UmH1uMMsx0D2l5sA6s3KLqHZ7AtOw1jQJl8vgYZaRMVAJRF
         0APg==
X-Forwarded-Encrypted: i=1; AKwUvBwOSdLYGKtxIPPXaZvjp65Cc7jVshxFIf1htLtzy/kr1g1W/9miLjiOTPqGUUun120/CoQwnI3pOEdXw70R7qoT@vger.kernel.org
X-Gm-Message-State: AFq9FYIZ2+LYnOJHkOi8fTEoDXCfAt4pTYq3EieUkFIxH0wXbcGvbtOd
	jnlViHhVyvr+GbQXEzT2yHGy9QkPGcVZB7kvxCTnKwad1ANFRUpsPC6ZlrrclpqqG5/iBR07j/H
	NI4RvECpKDutwd5BILy8eK8KMGU2DQe0=
X-Gm-Gg: AYBFou328QxPAj+nvPleh53Bo9626te/34Wibxx9dbqEzTjaNJxwQyFcF0M+0UIDDQq
	2LUtka/wmlOBJQISqeQj1lLgOhYkh1rwPWusdkARwjekljcL2JWN3UfAuAATk2CTWpVdbSB9k6b
	ymj0s5ukZ6WebkSMvJuRzBYz5uKiEv+dz5XkDyX0wPMD9cszgf9+ZrRuSVEC3ildnFpg9exj95V
	FNHrTQF8tJPzXNQZJ4kYADptxp8kFefL1/zB92xX+gTXUH89aoZjUv08xrb/whRpZlvtdyqWbXi
	zdtUumtWFsj3bL0/m+VF7pHremYFI1Ltl6gEPgsN5nuiqBGv2jbnDGOPAkDNifgSHa9soSrtnPZ
	aur5sN/BujqnCBaQVPeOHr0glGBA9NOrUtgdDZv3wvQ==
X-Received: by 2002:a17:907:9690:b0:c31:82aa:dd60 with SMTP id
 a640c23a62f3a-c31a9d0a5e7mr975742866b.15.1791820293222; Mon, 12 Oct 2026
 08:51:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011-alpha-perf-regs-v3-v1-0-eaa625a39712@gmail.com>
In-Reply-To: <20261011-alpha-perf-regs-v3-v1-0-eaa625a39712@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 12 Oct 2026 17:51:21 +0200
X-Gm-Features: AclHuK-xhWPZl4E0ja-mmL2ZAsaPkLiMeX7H21n80nyvvKlwLIZYd2jJw2alGQQ
Message-ID: <CA+=Fv5Rf-DKCTSnex2_Y9o+VU+mbHhMNzLJyBQ1+9hTjHufXAA@mail.gmail.com>
Subject: Re: [PATCH 0/4] alpha: perf register sampling and user stack dumps
To: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Sun, Oct 11, 2026 at 10:16=E2=80=AFPM Matt Turner <mattst88@gmail.com> w=
rote:
>
> This lets perf sample registers and dump the user stack on alpha, which
> perf record --call-graph dwarf needs to unwind user space.
>
> r9-r15 are not in pt_regs, so they cannot be sampled. An unwinder
> therefore cannot get past a first frame that uses $15 as its frame
> pointer (-O0 code or alloca).
>
> The perf tool side is a separate patch for perf-tools-next. libdw also
> needs alpha unwinding support, which I am sending to elfutils-devel.
>
> ---
> Matt Turner (4):
>       alpha: fix stale user_stack_pointer()
>       alpha: stop storing the user stack pointer in pt_regs
>       alpha: use user_stack_pointer() in KSTK_ESP() and dump_elf_thread()
>       alpha: add HAVE_PERF_REGS and HAVE_PERF_USER_STACK_DUMP support
>
>  .../features/perf/perf-regs/arch-support.txt       |  2 +-
>  .../features/perf/perf-stackdump/arch-support.txt  |  2 +-
>  arch/alpha/Kconfig                                 |  2 +
>  arch/alpha/include/asm/processor.h                 |  3 +-
>  arch/alpha/include/asm/ptrace.h                    |  7 +--
>  arch/alpha/include/uapi/asm/perf_regs.h            | 45 ++++++++++++++++=
+
>  arch/alpha/include/uapi/asm/ptrace.h               |  2 +-
>  arch/alpha/kernel/Makefile                         |  1 +
>  arch/alpha/kernel/asm-offsets.c                    |  1 -
>  arch/alpha/kernel/entry.S                          |  5 --
>  arch/alpha/kernel/perf_regs.c                      | 56 ++++++++++++++++=
++++++
>  arch/alpha/kernel/process.c                        |  2 +-
>  arch/alpha/kernel/ptrace.c                         | 12 +++++
>  arch/alpha/kernel/traps.c                          |  8 ----
>  14 files changed, 122 insertions(+), 26 deletions(-)
> ---
> base-commit: 8f5dbfb93440d1aba216a1a34369a65654b94be9
> change-id: 20261001-alpha-perf-regs-v3-7e23508c1ca2
>
> Best regards,
> --
> Matt Turner <mattst88@gmail.com>
>

The four kernel patches apply cleanly on my for-next branch. I built and
booted the series on my ES40 (EV67/Tsunami), and tested software-clock,
page-fault and hardware-cycle sampling, register masks and user stack
dumps across all three online CPUs. The targeted tests passed.

I have a few review comments(I'll respond to the individual patches).
The separate perf patch records and decodes the samples, but
I cannot yet confirm DWARF unwinding: the installed elfutils 0.195 lacks
the required Alpha support. Could you point me to that patch as well?

Thanks,
Magnus
