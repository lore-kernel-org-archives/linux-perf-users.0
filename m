Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADD1323417
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 16:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791822071; cv=pass; b=Uq5S7uqdA6T4lsx/5/MIsdXSeRNQL3PjiaBkhiZdOQL0ddp1nVuFhijlqORBMlc3plX4eE5XUrGNv1U+QNm+NLf9iZ/2ZQMENMc9Z+wXTJ/ltxjjm3yLPDIRg3+kR+ieDxzAA0kXZv7VEZ/KMMAso+vERZe/7sFzNtBFIpf6nDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791822071; c=relaxed/simple;
	bh=ZtJuy+UREce1sg1peUoIDUZxf72qfaMwDaVEPJG8eTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s3TulAPI9m1auqKYOxvoAy2KdXvFtveXCTosu/cLtl/glmS5wbF34jYA21KU/UDzGzmytkeFbxolDrJSOdvWjFzgB2uOHd4UNG2kshbIvnaXKu5VZDZQwXLfEnnzrEX/dfc8xs5kp7Bb/sz0PXJ09m/MZ+0LrefTP9MXMpf/ua4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlQe5Rq1; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlQe5Rq1"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c2533d83e3bso328723966b.2
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 09:21:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791822068; cv=none;
        d=google.com; s=arc-20260327;
        b=aLCy0E6NkBmmAlp3SCylx4OODidX0B1+2zfMGxhd+UP83TitDdFAeSCDnoRefPY2AA
         Y1sDsdrZBZYdvAtXMzZVcZjeL9vTqeYgRpllPec4unKb9FSOd6EDlcbD+yApAkFF1qIp
         cq2eFviedyD1Ab49OFVQ3XlIdNeDHpB5cw1VRjrtAbkzd+pjyrQs34iGi0iueMpS+Ndq
         il0rt5uXkynpy9tW1glnUMfwr+WK+C2zF4usK2KO3AJuAOPZV2yib1GTLp7EQ7fx5GcO
         NmKRhnFN8zRInLqdQlvWNqR3Id+Ta6S07xhHzqHkQpUQUF91bFlfnNzsXlS0/2ixfq4E
         49Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rtrJmGwBJ7fFDAdke9R1Vl4DtHEPSg3jl6Ch4LlMUAA=;
        fh=4hcjO894OUYy9DKUxXxQBO8K+3d3VqqXjWj+++Xo1sM=;
        b=dmak7HHqdWRP2oPHCbJD83eGwZvqVp3Wkj9gPTz901afsPzJgRQPsrQDDNRnYIOOMs
         5GweWIyiP5QAw1HuySoODqBXno619xQuaMHGNijvJRv8ja6Mb4JxfSidRx893Zxje1g+
         6Jd71Rp2l5JVhCMSH1HRhCmg7EL3/dqwcQcJuuSGH+qmbiqobmu3r9kHpPRr0GhfGqBL
         9C7aAkcZX1fUcEcQx53vP8egv5a//JzYPVgGDQFWmZj4NsdupzSuDdJSlYp0sgL+ohYl
         3Vlk1z/fp3RYqdhS7w2+I3E4SnilvuPPnUCfvwmnEF3W2vuZ4tPaVStpPP7uycKmUCzG
         4ZEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791822068; x=1792426868; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rtrJmGwBJ7fFDAdke9R1Vl4DtHEPSg3jl6Ch4LlMUAA=;
        b=mlQe5Rq1SzCNDLgbX91+TwnsTuHGb9Q1PNka/WwZ1b4omFf2cviF0DCRzMFQTxS/Cp
         4kvi7eFoR2FXsAiQmzTBclVr20+xw9pf8erRlMoTnC6EOa6Nb0URMMYvwUdnax46HppO
         MJattmjMAg9RomV8fBUTBVcfuqu2tohO/rFrE7PceK0NuWZP3XUib4YiXDwTNVOXJgNf
         XDOD9IhgTmgK0dh1bR8BhZs+rS3AgOjEkgC5LyPj+grjMYHwj5KSZMTg4ASrcWpvAT3f
         4UclTyagrWBXPz1Kz5qTpJwadd/mXeLakp6skbKaqbrPR6JSyJuSxmboPM5QmFYGbWUL
         nGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791822068; x=1792426868;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rtrJmGwBJ7fFDAdke9R1Vl4DtHEPSg3jl6Ch4LlMUAA=;
        b=YhNJhuDKRe7Y2maoOs6uPQPUsZixGBH8B0JlWiGQFTLXyd3XXPvZk8NEtk3BBtg99C
         oOJEtvv7Db77XNrBUbLspnGqT5M/sKyqkj7ueCD0TGNhSfliJPcLJBtRNoyrUXDmxDJw
         zDJJ/lBlRMCWf/tPThOQz3s5K0x2BRp6OD+kVwc7wOQqgf3MBaNeLpY2CleKupq0g8Nl
         XBCtXJrSmnM5sIMR+sDmHCP0rJM4DOdPfA5VY0dOxuBHZy9RNpc4w9b853S6HxUtBM7N
         umP456PbJPvmaA8WIJzpuzXWepT5iyuvuLqVj6BJ+mWazKEGBst6iE0swRxu0a44pRdj
         VKow==
X-Forwarded-Encrypted: i=1; AKwUvBwv2uoxyAjcgHJM9dyEImq7cL4huAhVK3qbz5TR3d7b28UhJo5SHbgzUgWnwKgeCsIdMLq0BGKQnJiLwhiQdw38@vger.kernel.org
X-Gm-Message-State: AFq9FYJEe7WDfmQxSQVWEits58KfFG/SFcwfjQz70eLJ5quXIErhGBg6
	LidwoUCvUtiiXLK0Wl06MHA6znyZ00IaDimFJnAoOB+npcacApaomOoFkYcVpAEvgcXsgcQDWSi
	osGlnuuNJIicUP7C1tnsqRpdn9cmRbH6U0lT0bBY=
X-Gm-Gg: AYBFou3BGlwEhrEDN4GYuIoVQk/qO74IrSd7ZeTlmOu1cwLSCik6D72nnIf8qkfzEAO
	UzUiVglcxXqiJJEpWVc0AyupGB2hoZyn3uKfanEDQcgUBj2qxjTC7GUIaKb9HPk67xJVNq7aYic
	i4ms/cnEKpy9WsTZmLV3T7g7e1SOA0Ubpk47DXB8Q8GbpBmcNi1Prd0TCS2z4jvDYqAvaEOFaxo
	eRAOQ5G8GcP9QNBkVej3uww6em8WXjaCAW+5jNlaEW3qDXs9DRpHUmEqHaNYAR3auwhDH1QAkzE
	rIOsj6C1dRhD+qEtxSru3/Q47D78Qe4ShTgV7CrVWdhZ+vzoHwBjqEnnkJdiyoLhbpEL0eOP/Pk
	J0wLznn8L1tbhEMzVd0d9GgdShYaY7BuwoW7GbZJ1O0M=
X-Received: by 2002:a17:907:d92:b0:c2e:7daa:2399 with SMTP id
 a640c23a62f3a-c31aa0b59aamr1021227866b.42.1791822068206; Mon, 12 Oct 2026
 09:21:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011-alpha-perf-regs-v3-v1-0-eaa625a39712@gmail.com> <20261011-alpha-perf-regs-v3-v1-2-eaa625a39712@gmail.com>
In-Reply-To: <20261011-alpha-perf-regs-v3-v1-2-eaa625a39712@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 12 Oct 2026 18:20:56 +0200
X-Gm-Features: AclHuK8ctq3ag-qDSt__fyD9TouOLhL0ONKOVT2c6PAyBUOuhZ4oNrOZClMtffw
Message-ID: <CA+=Fv5R05SLcLkHRfVhqLbjWfp29gpR=R8JDktjOKkYw83Xwig@mail.gmail.com>
Subject: Re: [PATCH 2/4] alpha: stop storing the user stack pointer in pt_regs
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
> Nothing reads pt_regs->usp now that user_stack_pointer() uses the PCB.
> Drop the stores, which saves a PAL_rdusp call on every syscall, and
> give the field back its old name.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  arch/alpha/include/uapi/asm/ptrace.h | 2 +-
>  arch/alpha/kernel/asm-offsets.c      | 1 -
>  arch/alpha/kernel/entry.S            | 5 -----
>  arch/alpha/kernel/traps.c            | 8 --------
>  4 files changed, 1 insertion(+), 15 deletions(-)
>
> diff --git a/arch/alpha/include/uapi/asm/ptrace.h b/arch/alpha/include/ua=
pi/asm/ptrace.h
> index 9d86b2a1526e..72ed913a910f 100644
> --- a/arch/alpha/include/uapi/asm/ptrace.h
> +++ b/arch/alpha/include/uapi/asm/ptrace.h
> @@ -43,7 +43,7 @@ struct pt_regs {
>         unsigned long trap_a1;
>         unsigned long trap_a2;
>  /* This makes the stack 16-byte aligned as GCC expects */
> -       unsigned long usp;
> +       unsigned long __pad0;
>  /* These are saved by PAL-code: */
>         unsigned long ps;
>         unsigned long pc;
> diff --git a/arch/alpha/kernel/asm-offsets.c b/arch/alpha/kernel/asm-offs=
ets.c
> index c89792c86044..22ed3c975b1c 100644
> --- a/arch/alpha/kernel/asm-offsets.c
> +++ b/arch/alpha/kernel/asm-offsets.c
> @@ -30,7 +30,6 @@ static void __used foo(void)
>
>         DEFINE(HAE_CACHE, offsetof(struct alpha_machine_vector, hae_cache=
));
>         DEFINE(HAE_REG, offsetof(struct alpha_machine_vector, hae_registe=
r));
> -       DEFINE(PT_REGS_USP, offsetof(struct pt_regs, usp));
>
>         DEFINE(TI_FLAGS,        offsetof(struct thread_info, flags));
>         DEFINE(TI_SYSCALL_WORK, offsetof(struct thread_info, syscall_work=
));
> diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
> index bfa116d455fb..790389a15c3c 100644
> --- a/arch/alpha/kernel/entry.S
> +++ b/arch/alpha/kernel/entry.S
> @@ -476,11 +476,6 @@ entSys:
>         ldq     $1, 0($sp)      /* syscall nr from saved r0 */
>         stq     $1, 8($sp)      /* regs->r1 =3D shadow syscall nr */
>
> -       mov     $0, $8
> -       call_pal PAL_rdusp
> -       stq     $0, PT_REGS_USP($sp)
> -       mov     $8, $0
> -
>         lda     $8, 0x3fff
>         bic     $sp, $8, $8
>
> diff --git a/arch/alpha/kernel/traps.c b/arch/alpha/kernel/traps.c
> index cfaef96c4ce8..5882c65b7ef1 100644
> --- a/arch/alpha/kernel/traps.c
> +++ b/arch/alpha/kernel/traps.c
> @@ -30,12 +30,6 @@
>
>  #include "proto.h"
>
> -static __always_inline void alpha_snapshot_usp(struct pt_regs *regs)
> -{
> -       if (user_mode(regs))
> -               regs->usp =3D rdusp();
> -}
> -
>  void
>  dik_show_regs(struct pt_regs *regs, unsigned long *r9_15)
>  {
> @@ -186,7 +180,6 @@ do_entArith(unsigned long summary, unsigned long writ=
e_mask,
>  {
>         long si_code =3D FPE_FLTINV;
>
> -       alpha_snapshot_usp(regs);
>         if (summary & 1) {
>                 /* Software-completion summary bit is set, so try to
>                    emulate the instruction.  If the processor supports
> @@ -208,7 +201,6 @@ do_entIF(unsigned long type, struct pt_regs *regs)
>  {
>         int signo, code;
>
> -       alpha_snapshot_usp(regs);
>         if (type =3D=3D 3) { /* FEN fault */
>                 /* Irritating users can call PAL_clrfen to disable the
>                    FPU for the process.  The kernel will then trap in
>
> --
> 2.55.0
>

Looks good to me, I see the __pad0 is back again in pt_regs
brings back memories from tracking down the stack alignment
issues a while back.

Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
