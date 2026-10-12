Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC664A8A39
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791821928; cv=pass; b=tIqMKLvi3LAPi5Wy57Ae/SGNua4ZoeIYGYMvjx/W1XpqpENK6yZ5EJVD+3CO2q6c1R63MkeTq4YXxhXUxMnD2j9q6+rtKOlNTcS1CumGnBePpeF0sLR7coNiScXXB4o11TXyBB7dBlmzYUm91NYd5v0dctHtyPxz7ZF1R8cs0bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791821928; c=relaxed/simple;
	bh=qvVpEPzOzLifjD/7DmAg+LNyF2ciqW2crgsJsv4fMNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vGekN6KQ1/W/spb51vuUY7yc8kJzBiBCbOQbAOh7FlzAR8R6sQbYFNj9hXSiz29kG5ijHPoNarmsQ/2fX10yHYeaU6oNtetaxhJuqlbZo8Ks+mPZwhEUAAIchynu8sd0jPSg9TlYMQ5Lq93j3Jql6Y2L6aAqBeYN21anHEl01Xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsPS4BD7; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsPS4BD7"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b1d8944cb0so989684a12.3
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 09:18:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791821924; cv=none;
        d=google.com; s=arc-20260327;
        b=cSaJM7hV838e6InTxqxh0XFxFcr9biimwQtPp/EGAhVIb2LOI6kKxTLrpudctkK3Jw
         XBXWTrhPm8Udu01G1YnPBOOobN7QL3vEvo2u4DIfqP9gZUAL1iJ6JqfGwNBD8oZU3HpC
         wYZStH+jEgayDsMXZlBjHEJQEnKPnlPVsaGlIXhPFY+1FPOG0gf5zSS/Gvpi69ve3toP
         Jm2ufcwfUab7XKPfStUD/lIK3CpGV1xBA9YBqWp2+3bG29jFgb6Ju8nPm2R/05Kdiapk
         NywS+3F2sMfBJhIpceEfebcFEaWvsPmuvIYa0gZPgOrgqnJ9/7X7cFysZS91jf6yvHfD
         IOWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CUeAR5YurRmrLyPWT1WYCY1/iIz0jhnPKKa1Syh0wXc=;
        fh=v6uOCs6lDR+HRej18N39DSM01n/ZV6iN5wjKq10Azt4=;
        b=bUGN/hVTjcYGRZbTqK5mOXds5Z9I33RWyhfwCjoExDb4psb9fT0X+dC6AQ/pSmA5Fr
         H4JA51NgHGpmM7zgoSsTcfaClF08167VWrslF2axtX0DqZPk+JgI2rsnTXcOGbcrIvPo
         u4WqYcPCsTmXxhFCbsuCO2FbG+To15Mz8lpaAFNjq0RwxLOjBJS9roIGeBqBeVpX+Rfe
         RERHn42xdjHBEj3tgCuOjBto9AdL69JQBJy+Zrr/vhOsFymj7hi8Kfd+GVMPVeGE3Emr
         zVx7RYdyAlr6l4DOOGMnnC6pMpQJosgTZgdjJlC2g57LlUbsh5NU+VkL/6XF89ZRoJUW
         YLxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791821924; x=1792426724; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CUeAR5YurRmrLyPWT1WYCY1/iIz0jhnPKKa1Syh0wXc=;
        b=PsPS4BD7m2jkgUCxRdMk0FNY2z5ZY59lAfo1Ryo47UKC1ju9hpMh4jWUN90HEJprgS
         Z+PRQR0N4FHO8/rzWt0K9670/ixmjyEGtvNvyXmSFP75wzZeEH1zaOf+tR32+jDFpJqe
         ZuISWP8RJ2XqbFu/QDyph1iE0p49cMI7cNH2h8l9KfHhfAazx+pHtYvkqaU8J2jyCVaz
         MPWT3vHhzxXm4aYP1+AwRiQnTVbGa2NXDJGCdNej3Mk7bHUkN/cxVzAnTNkZFN9McSQC
         CXN4VzRUuv/vQwGi3HCnNaElw+i0BqDIwIZWS+TlnGoffcIcf4qf/5Yd6Ae5MJNOZL+u
         qX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791821924; x=1792426724;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CUeAR5YurRmrLyPWT1WYCY1/iIz0jhnPKKa1Syh0wXc=;
        b=oFWr6XsXovsBcyPNGzooS7+nXip66h5rHqbEVtGC/FlETfRayEVT7j+1Jt/m8IcA/B
         sIqr3XuZJy1nvBVQatYwOOMBOnD7RmaY9IbLRUNEiGFPMIb59LIZW//ngm4m8Zak+aex
         UkVxf+n402zuWh5j8/JHXs3ckmjWNFAJ7K1oKFN0S8vuSItEQESvI9JLaVbfe+aVtgKh
         Uk8PYy2VOUcJySublPF4b1mSkos31/XUIdk5X7ngIitJR90w3cxOejJWzeaCJJy3QRsB
         WQMZODEXzIvD0SC+GZBNHdXcV3MGHhFdr5WFhDGBq+gKAkBb4Kv9Of3rp3nj4dvT8p0L
         gf5g==
X-Forwarded-Encrypted: i=1; AKwUvByaJVxAPVPpl8MwQoQYPVuDtij/WRy41NXk7sG2ltiyhhDSGA7F+eJTM1ixfWz4SxfXLyLH5bnibNlfZdvpcaWT@vger.kernel.org
X-Gm-Message-State: AFq9FYJRTc6LC8C/2vg8dg2uv7QFw0UFuliRJWQCOvvIlYv1uNdpLXzJ
	/TWhSOaf0T8Sr7YwHDmz6YkmptF4fJFY3eymHYzhqDRRf8fkjt5kOPrV4nKPFcKR/QiJo+oL2J5
	pOPheMonjoJ5K9FiAO9vlByv4grDTWjiV/Q1xd8E=
X-Gm-Gg: AYBFou1SLqzv+HUBJkZfCk1pFGY9XnLhHgBl+29UOLnpryYar83xjPVcUAS6HEbN9iU
	XKOJhcyFK+3WNf8EwGxe+t9KJC5bpKxpDY+PVEPBCDZ4DqAVq6qIzL7Vp7Crz+cg+LhZ/SuqC0V
	S4d7FJEdhI6ZYdbgdkWQE6nfBL+RLjrpmI9xJkEFRJyLtoF4+nym/B1clFycgh2X47ghuQ/u7YF
	foIG4870uQtMijWFyq1lutgm14eQdjJxr06lfTPS2PVTdzVIfJQuMBfBawWsoXFXDX2qIeRUVPg
	ehCAk5lNnG4k9l3TV7CMci6fFcFk1HFw3A75ICDgYYzhovxqHndxuPmu7VKzoQy8k0qy+zhc8uc
	hm8SuB/DUpa3LevQNj8aG5s4yvBEsD/ZB8M3LULeBNQ==
X-Received: by 2002:a17:906:dc8e:b0:c2e:4488:b8a3 with SMTP id
 a640c23a62f3a-c31aa0850bamr1000531266b.33.1791821923522; Mon, 12 Oct 2026
 09:18:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011-alpha-perf-regs-v3-v1-0-eaa625a39712@gmail.com> <20261011-alpha-perf-regs-v3-v1-1-eaa625a39712@gmail.com>
In-Reply-To: <20261011-alpha-perf-regs-v3-v1-1-eaa625a39712@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 12 Oct 2026 18:18:32 +0200
X-Gm-Features: AclHuK-nN_rEqA6xqbO4CkyZX0-XsUGhkKaJX3rrOmarOEgQAl1ktERcvGizgjc
Message-ID: <CA+=Fv5RoxY0Bav9Q-E4FpEofokfB26ePOwPPWUmEDp6_sO5S3Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] alpha: fix stale user_stack_pointer()
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
> PALcode keeps the user stack pointer in the PCB, not the trap frame, so
> pt_regs->usp is only valid where entry code stores it: entSys,
> do_entArith() and do_entIF(). Interrupts, page faults and unaligned
> traps leave it stale, and ptrace and /proc/<pid>/syscall read it
> through user_stack_pointer().
>
> A user-mode pt_regs is at the top of its task's stack, so find the
> thread_info from it and use rdusp() for current or pcb.usp otherwise,
> as KSTK_ESP() and the regset code already do.
>
> Fixes: 8a2857bc2b30 ("alpha: enable regset-based ptrace and core dumps")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  arch/alpha/include/asm/ptrace.h |  7 +------
>  arch/alpha/kernel/ptrace.c      | 12 ++++++++++++
>  2 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/arch/alpha/include/asm/ptrace.h b/arch/alpha/include/asm/ptr=
ace.h
> index 430e8dc27ff7..45d1229344b6 100644
> --- a/arch/alpha/include/asm/ptrace.h
> +++ b/arch/alpha/include/asm/ptrace.h
> @@ -26,12 +26,7 @@ static inline unsigned long regs_return_value(struct p=
t_regs *regs)
>         return regs->r0;
>  }
>
> -/* Helpers for working with the user stack pointer */
> -static inline unsigned long user_stack_pointer(struct pt_regs *regs)
> -{
> -       /* Valid for user-mode regs */
> -       return regs->usp;
> -}
> +unsigned long user_stack_pointer(struct pt_regs *regs);
>
>  static __always_inline bool regs_irqs_disabled(struct pt_regs *regs)
>  {
> diff --git a/arch/alpha/kernel/ptrace.c b/arch/alpha/kernel/ptrace.c
> index e1d8c2f69688..dba7e9905cfa 100644
> --- a/arch/alpha/kernel/ptrace.c
> +++ b/arch/alpha/kernel/ptrace.c
> @@ -440,6 +440,18 @@ ptrace_cancel_bpt(struct task_struct * child)
>         return (nsaved !=3D 0);
>  }
>
> +/*
> + * PALcode keeps the user stack pointer in the PCB, not the trap frame.
> + * A user-mode pt_regs sits at the top of its task's stack, so the
> + * thread_info is at the base.
> + */
> +unsigned long user_stack_pointer(struct pt_regs *regs)
> +{
> +       struct thread_info *ti =3D (void *)((unsigned long)regs & -THREAD=
_SIZE);
> +
> +       return ti =3D=3D current_thread_info() ? rdusp() : ti->pcb.usp;
> +}
> +
>  void user_enable_single_step(struct task_struct *child)
>  {
>         /* Mark single stepping.  */
>
> --
> 2.55.0
>

Nice work!

Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
