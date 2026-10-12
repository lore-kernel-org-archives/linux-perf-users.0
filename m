Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF7B2EEE7C
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791825153; cv=pass; b=Cemq95n2OZ9tVEXOIRHcu1uoVeceiwSnq+ry0uEngpk5sq8oBZkTQsZGihEHKIhYT9PIl6icbu9Y+olje3YPS8ELI6546lGM0e8DwSFo/Zl4I+b7TOGn9gKBBx9UxjuCpaiu0tDUy82VhUdb9TJi6s1hRNWbkgp349K16wfJMC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791825153; c=relaxed/simple;
	bh=dpW2g/OHhp1bd+k/Wa9Z4WycLX07oh4uMIjONrgblWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jPrRSUpO7dTraNWj5+BeEcRylZAUaWkMnZX7SIi64e+lgaRQb6sIvl6jKxuYfuayOsT/8nrpOh/O0LPMXHVNUneEa39fSnql7ZQNHkPwj6BtOSuuBAG6+2BXpd4PnVama+NbO+0lHkBMvEOa+/wU8O1OHRQZ5CWoAD19afuONGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNtkXBU+; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNtkXBU+"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c34bff61551so192880766b.2
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 10:12:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791825149; cv=none;
        d=google.com; s=arc-20260327;
        b=APmv4PNXhiaOubbVJeWeMgCbdx+rzmPGHjphgmXn52fOt3wkzEU18C2WCl9OubQzFG
         DcrJxW7+wfnFuBom8R9h7wk8XsNI347lEHdVpHXbia4jJij7iLsuacArsxacOSQLS+IX
         0z9TcM+VJnGbxk3c6tMzNkHR/f1Ja4QktoKgYX9Npr9HwGiGG6Q48VIULsldcdB3+mFZ
         Je0rB6WHKUww5bWIVsEku0Um+zAIcboaHMLG9tbpDCMF0hGucaduvH9dP09FgvV24lbV
         UUnPPaJpPebkhxfo7ThFwV1JTH7LOuWX+h49EFWDJylEbkD+Jjm9mMf60q+MrHsxQyGh
         6fmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UhieV+/eJrwJW2//RDtEPeUp5XItWunJ/DM2B+e/f0M=;
        fh=yphOl0Pg4Fa2SYdo5EIXP+oDxw1AgC4cjhCmGSz1ROQ=;
        b=BxwSYK7kb/JiMb4uMp9S1e3mwuR6f4F5UNeFcDrKyV1Xf7OZeVqw2cWPH5Hr2XHi+i
         37A0oCZBS8LnDaK548Ot2A7LHHstkYiYz39w0YUeZZudGhYlgSXxQUMLXLKgDtv/jWAl
         uLHCdrw172tUqAPSecW/KGxw4Sik96OJ89kSnxIQO6zP6oA2Tao6fxAHrm6m9m8xyQi8
         YcXxjh/lg4y9/4Rm4TI7d8SObm+l8P+54RwoVS6M89qB/dBvZEqtejtCPEaJnrxHMpzc
         rn44VG03EnPwkjMVmYi7/guttkmvPmMKIrc/l5c0rtikeNP0ylZqY1K2wDnh8vnWZTsv
         NTyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791825149; x=1792429949; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UhieV+/eJrwJW2//RDtEPeUp5XItWunJ/DM2B+e/f0M=;
        b=LNtkXBU+ki5e5hfXUbOYJgoqmVPmvvlOv6aE8TeGaObQVrMEhK5SMDzl2vxRDv3w9a
         Y9wMRqWUrUzIgVfOB2QeS1wDoxLAVUOmRoz+jmQZ2FJr+w3MAOm2EhDw6RbyRXdE8+sd
         EFFSjzf7S6eyHBu/Eheio/8fEREfXEZSFvjEZ4TJCeXfBVO6s1iEXjBDMbRGtGf9lMhI
         uTRs9DRO+EAWbu993mr/8EBwNvBG2f3wYG4vQXxzFlixvQJSNrsYkgQNH/kDlVbbtugm
         v2p3/8lgQ1Lu1aQtanuQOuwjI6Zru14CSDwomS76o3l499/Be5ER+5B517veqwwcEpiM
         ZJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791825149; x=1792429949;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UhieV+/eJrwJW2//RDtEPeUp5XItWunJ/DM2B+e/f0M=;
        b=G0V9rxi7RRUr+rgntlbRFxOkTNQjJNKTcs/AhnzAljb2dTBl6tYTJb4sR8xaxMD+51
         cDPqCYO7QWZru/Qky6o9f6jBgPltR+kzp3lEZcEfvm/vWK9JwDLtTWeQ4O2gPJP7DrJq
         v7FcI4ooJqlv/OBThQBE5KQ6BUf+ATVraFWfV8mKTGClCi32JWU83b1vLHnVc5oYI25b
         cyu9vEP8ObpQK1ESgUsHtvaqIWuMIh1LOVp2J9N1PgaF5SVBqb5X/mKcnb7xxjVCF3+v
         bXcfrVEKOquTAEQB6XhuvAA2mDKxbebjtNQxVUbUvA8/66zvzzlBCMSDpfOEUaWHt3df
         7O/g==
X-Forwarded-Encrypted: i=1; AKwUvBwBpD7bqTRn1myGxpDYbvOlRqXiroeaZJE8Vgmxr/IKS50ln79zoX67Tgf5eO8+yGsG2R56F/cntQd0HsipidgM@vger.kernel.org
X-Gm-Message-State: AFq9FYIalZU0fw3lGXUvH1Ec/wPTF0BeeuS0C8fPWjjbAqpCaGJAL4Pg
	mzb82UEZfWhttI5fTXSlp3wzWl7wYRi5sjGVJqXY9gnN3thS2CFVgm68WQKGTCDTnvce2Q9v8eL
	LakckoIutVuM8czCc1TMbFgJQVxrDEug=
X-Gm-Gg: AYBFou0Kf94/CwSrXmPOiBa1KhoANytkXnWbR0rGaijAyo5aJkGhlY89fdz9/IugBVN
	IDnV2jcWYvTRS1jfl56Wsv5URoZiFosf4jlokLT69dsHw/soL03xqJ1sBBaZXs8Xg+7iO4k2Hf5
	dDKTfb3C+Vsk3TeatikjNYYYaA2ylyopTH/UkfrlKD8yLdYyBK8E1vfDmf5ZYIY6kmgExhm9IA3
	BrqJOSuubs+Xcx3nffbM3DL/MES7r4Xcu/zopC6CZxGBjNfQE0NsiHX+5Ps+6WMQX+tiMImaZOi
	6D1NjizjUhFIMl1MpJIYCiwLmO7yYIaBWu3Uz1XshRtg++zr/UuU5Hr7fhnkxZDvzX0WFB+FCZT
	ApdGukja/9NhrhdByklpewVVwH/5yHT6V98bWoLyJ8A==
X-Received: by 2002:a17:907:2d24:b0:c2d:bcf7:37f9 with SMTP id
 a640c23a62f3a-c31aa07a9d9mr992370766b.26.1791825149332; Mon, 12 Oct 2026
 10:12:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011-alpha-perf-regs-v3-v1-0-eaa625a39712@gmail.com> <20261011-alpha-perf-regs-v3-v1-3-eaa625a39712@gmail.com>
In-Reply-To: <20261011-alpha-perf-regs-v3-v1-3-eaa625a39712@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 12 Oct 2026 19:12:17 +0200
X-Gm-Features: AclHuK_IfbO80biMKT5u2j2yFp2FuPhLw89IvxvMZVpINwN-IiFIyIRGdYMzWGo
Message-ID: <CA+=Fv5RW+ju5weuhDMLjEFcWvg0G0RnWXiqTr-0HmCnWhcaQUA@mail.gmail.com>
Subject: Re: [PATCH 3/4] alpha: use user_stack_pointer() in KSTK_ESP() and dump_elf_thread()
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
> Both open-code the same PCB lookup.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  arch/alpha/include/asm/processor.h | 3 +--
>  arch/alpha/kernel/process.c        | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/alpha/include/asm/processor.h b/arch/alpha/include/asm/=
processor.h
> index c461a26d47b3..73251cd671e0 100644
> --- a/arch/alpha/include/asm/processor.h
> +++ b/arch/alpha/include/asm/processor.h
> @@ -43,8 +43,7 @@ unsigned long __get_wchan(struct task_struct *p);
>
>  #define KSTK_EIP(tsk) (task_pt_regs(tsk)->pc)
>
> -#define KSTK_ESP(tsk) \
> -  ((tsk) =3D=3D current ? rdusp() : task_thread_info(tsk)->pcb.usp)
> +#define KSTK_ESP(tsk) user_stack_pointer(task_pt_regs(tsk))
>
>  #define cpu_relax()    barrier()
>
> diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
> index 06522451f018..7861c9e767b7 100644
> --- a/arch/alpha/kernel/process.c
> +++ b/arch/alpha/kernel/process.c
> @@ -318,7 +318,7 @@ dump_elf_thread(elf_greg_t *dest, struct pt_regs *pt,=
 struct thread_info *ti)
>         dest[27] =3D pt->r27;
>         dest[28] =3D pt->r28;
>         dest[29] =3D pt->gp;
> -       dest[30] =3D ti =3D=3D current_thread_info() ? rdusp() : ti->pcb.=
usp;
> +       dest[30] =3D user_stack_pointer(pt);
>         dest[31] =3D pt->pc;
>
>         /* Once upon a time this was the PS value.  Which is stupid
>
> --
> 2.55.0
>

Looks good to me.

Tested-by: Magnus Lindholm <linmag7@gmail.com>
Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
