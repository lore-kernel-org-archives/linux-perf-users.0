Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA39435C6AA
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 17:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826466; cv=pass; b=l7bmjhdpV21AgdtHZFAnx5OkooWOOXW3unj8SR0fiPhZZSGP0wapeq/HJt27aZSTueTCCFBG4D7IBmVMzno3WRYmgjZ1kKX/ZSsQQzNHKSzLErq7raHC+DB3HrYtDVzvfl5rK6d850yiEioxgG3kqsAEgTfHvw9FGjqpIYPCiyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826466; c=relaxed/simple;
	bh=NAHjeGgZ3zAuGz0muoly9fF6Hx+UWmxL0tmIFC5MVuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXTr085qDp4TwN84upY67Bjz9L0DZkHfGxn+3/fQzdneiiczn2gpDAHHW+dilkOIe4nzBzO4Z8J9M8hrPjoOV3lzpggMRNfaN7bo5QeAA9bWanbPneE2lj3Q54UOKL+1+FXr8dWj1hY1ZGXgHZEw7OmzxwAeTjL3x3FxUhSNJoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1+K5kqK; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1+K5kqK"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c2e5e801487so321994166b.3
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 10:34:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791826463; cv=none;
        d=google.com; s=arc-20260327;
        b=glQ4TuyIOP9TCoSbtkfkF5wVQf7PzhHSxZBxiqG0ZULWgD4MVXGwvLKGejMSkL21yk
         WcbixlJ1YZM0se2UjU5YynUvVe77mDqFljYTVymKFW+awHYi8zXNXgkJ5W4VGR/3Sk+W
         LXM4oupZrvPpvRlCWeWgw2yDJOZ7E0sFoaNuGCkciDUFjiAFvWr4BsqIdejzvdDfcWti
         PQmwr0sLyxfMosi+0W5Ir0Oth2AfV3AQT7wMc6ombQKEFd/sQ1oRbVtn8WPFqJHElJVJ
         cfHzWCKBx6uToZFxpJXUMzvI310UqAhsz99ghGCS6+DYGFxh2O57yN2SN7K8sqFqzGGr
         Eupg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=henkAkl7u761gKlux5gr52zn0ik2NkHxM17QmChnkBo=;
        fh=HIXxeqy0cUg2fKDj4SmnCGV5tdf1X738XpNdcanwPUQ=;
        b=L2xp4ly44fvpY1wso8uKv+73lOOworE5wVsC3Vi8niMvJnmvviHJX41T6SIYa3+LSX
         L676h9g/UdV8pXVnbXh9So7ICQKvoGgVvh+hX8bYf68Ei6ot+VvkbvMB5TdK+4PVwwgo
         BC6CpRjw/bamUoAAHSQbbu625BMTrbaRYGFKAQq8jWgCWaaNu2VrGeb1GTAHIj2buS8x
         qm9y1ILrItKui7SskTMvNNUM08rnnT3hyO+8Z4DZGxWmydSbJCaPAaccmLcXgTENeXAT
         Qn7BDgPddHfDVCeHYwnoxN1P2qhDAFNRzv8m2zVnxZT/V0QAI7Wodl0JEf/qd8/8qRSW
         9umA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791826463; x=1792431263; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=henkAkl7u761gKlux5gr52zn0ik2NkHxM17QmChnkBo=;
        b=G1+K5kqK3xniCRDcPw4xiRznvoC5yg95pry3/lHWF6hA/uJJsFN23nJk5LAG5S6cfD
         vmLU3OiIsJJqHPqKnKE1bD/XduHJA2x42ku3y9X4jxJ16P3IS0YUVo3OCxxPHTfjseu3
         +y6tDhkE040YQny+nRSc25aGi4OTC74hg6RtoRx792EgwskxD8bJsA8zQwVfRSMY9dRv
         VGt7eD1vEfR8lzU9xqWVAmJWuYk7EM5svpogxR7W6lT/kfY/kw9esi1MWUjcMfCBq95Q
         ZpCDvzV6BU29z8ADNSWiZxK+FgQPiZibr3ne1IWn3xGxOIp2LDeZqluIZyqPEw3kEg/P
         MBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791826463; x=1792431263;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=henkAkl7u761gKlux5gr52zn0ik2NkHxM17QmChnkBo=;
        b=w57kiladcMVnC93WLxR79K4TezK2yZfKGeu9fyyDbqqJcs4EGBE8v9jCygV+Sy2Knk
         2+7+UX3XLCj2dvPuDeTZuasXcboPRKMZriqyjhajANlbVI8JdRAvVAykSE7mMq0VEVyT
         Vh1+94qyg+VQU41A9XakThxup+GGuLV3bK3OXXCV1eY8uBn3yHSlbP8EN7K1LtsErBRV
         XD1cbxbuyCazsfnjru/BMgD46pGuDj/UEvdKZRe455yr+hh6ORcD6hPxQ51kKRoXe7CL
         iQwUeeWJpNsN8yJg39gHRH5/QGhf74uajuOql8QPX4OwJgSguywL5iHs7IxAKX4IG3qN
         bHpg==
X-Forwarded-Encrypted: i=1; AKwUvBy8fEDuDCN6g9eszMxizCyUQhuJTTZgsUfI8Mg9ilL/SK6g9y/KJzrtIpEXQjkIvRfmayJW7KI5TZ3GCstHFH0b@vger.kernel.org
X-Gm-Message-State: AFq9FYK8P+3lWJckc1hqZcQkiyG4aYVfWEtwj2ezXefiuWgH0/ZdhQnX
	6AFFLLB4NietZ4WFMeF/IMGO5aKgL6avSUtXzvvtc9OpCxwDSlKhFeMQmMvlvE5cGo0MRcAC5pk
	i9xYdnHRO56lj5UaTU445q3aW+jby9kQ=
X-Gm-Gg: AYBFou2+N7DUTgn9cbKfHwmjnScsWMrePd7IbFf1/zhErqT2gQhbWjd6VT+5K4e6Is5
	Z+ji/8gvQz1IT5/4stQG4tbq3AgOnwqjyq1VDhWj+O35ng4zQkTDYb7yjaGA12lzwwgvwT5rMjm
	UQxOQuhoUlFuL+SPyF64AF70tv2XVBpPIiO+bdo29Y0zSWBPdadaRzJpVQC74kSccPoXksxrI6G
	0b/UlNlBgjr+NkbYQXyasgcVwgZd4e+7zyVfge1QsML+1ih/I0VhrsSZMGiAMWUVA1NQdBPDL/b
	JQ2GgqZxqOd09L3/Mlj3jb99NPyUs2FpZMNplWspNow/O0tBx0WxcVGiPxPNYsN8yMEMz6Z5zMH
	gs5vHpDitkSWQUZIYuRKnEkSMlVYvOmFPEH274h8Igw==
X-Received: by 2002:a17:907:1997:b0:c2d:c98f:4824 with SMTP id
 a640c23a62f3a-c31aa057064mr966455366b.30.1791826462665; Mon, 12 Oct 2026
 10:34:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011-alpha-perf-regs-v3-v1-0-eaa625a39712@gmail.com> <20261011-alpha-perf-regs-v3-v1-4-eaa625a39712@gmail.com>
In-Reply-To: <20261011-alpha-perf-regs-v3-v1-4-eaa625a39712@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 12 Oct 2026 19:34:11 +0200
X-Gm-Features: AclHuK-PwSMImsJT1HaG65lEZ2a3K4FcOsF41-r_kcaxLM87kRjslrSwrNkGcrQ
Message-ID: <CA+=Fv5S8-Zk8-LUpZnWiBfTGSQXthepmRc_-a9O+pEPmVW0mRA@mail.gmail.com>
Subject: Re: [PATCH 4/4] alpha: add HAVE_PERF_REGS and HAVE_PERF_USER_STACK_DUMP
 support
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
> Let perf sample registers and dump the user stack, which is what the
> perf tool needs for --call-graph dwarf.
>
> The register indices follow the hardware numbering, so r0-r30 map
> directly to DWARF register numbers, with pc after them. r9-r15
> are callee-saved and live in switch_stack rather than pt_regs, so they
> cannot be sampled. Without r15 an unwinder cannot recover the CFA of a
> first frame that uses $15 as its frame pointer.
>
> sp is not in pt_regs either: for user frames it comes from
> user_stack_pointer(), and for kernel frames (PERF_SAMPLE_REGS_INTR) it
> is the end of the trap frame, as in stacktrace.c.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  .../features/perf/perf-regs/arch-support.txt       |  2 +-
>  .../features/perf/perf-stackdump/arch-support.txt  |  2 +-
>  arch/alpha/Kconfig                                 |  2 +
>  arch/alpha/include/uapi/asm/perf_regs.h            | 45 ++++++++++++++++=
+
>  arch/alpha/kernel/Makefile                         |  1 +
>  arch/alpha/kernel/perf_regs.c                      | 56 ++++++++++++++++=
++++++
>  6 files changed, 106 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/features/perf/perf-regs/arch-support.txt b/Doc=
umentation/features/perf/perf-regs/arch-support.txt
> index 4c9a5a012075..7d736d678fd4 100644
> --- a/Documentation/features/perf/perf-regs/arch-support.txt
> +++ b/Documentation/features/perf/perf-regs/arch-support.txt
> @@ -6,7 +6,7 @@
>      -----------------------
>      |         arch |status|
>      -----------------------
> -    |       alpha: | TODO |
> +    |       alpha: |  ok  |
>      |         arc: | TODO |
>      |         arm: |  ok  |
>      |       arm64: |  ok  |
> diff --git a/Documentation/features/perf/perf-stackdump/arch-support.txt =
b/Documentation/features/perf/perf-stackdump/arch-support.txt
> index dd362b5cb638..17b84ea7769d 100644
> --- a/Documentation/features/perf/perf-stackdump/arch-support.txt
> +++ b/Documentation/features/perf/perf-stackdump/arch-support.txt
> @@ -6,7 +6,7 @@
>      -----------------------
>      |         arch |status|
>      -----------------------
> -    |       alpha: | TODO |
> +    |       alpha: |  ok  |
>      |         arc: | TODO |
>      |         arm: |  ok  |
>      |       arm64: |  ok  |
> diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
> index b2c359b947f6..8fafbfabd1e5 100644
> --- a/arch/alpha/Kconfig
> +++ b/arch/alpha/Kconfig
> @@ -41,6 +41,8 @@ config ALPHA
>         select HAVE_PAGE_SIZE_8KB
>         select HAVE_PCSPKR_PLATFORM
>         select HAVE_PERF_EVENTS
> +       select HAVE_PERF_REGS
> +       select HAVE_PERF_USER_STACK_DUMP
>         select NEED_DMA_MAP_STATE
>         select NEED_SG_DMA_LENGTH
>         select GENERIC_IRQ_PROBE
> diff --git a/arch/alpha/include/uapi/asm/perf_regs.h b/arch/alpha/include=
/uapi/asm/perf_regs.h
> new file mode 100644
> index 000000000000..da96a31b12fb
> --- /dev/null
> +++ b/arch/alpha/include/uapi/asm/perf_regs.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_ASM_ALPHA_PERF_REGS_H
> +#define _UAPI_ASM_ALPHA_PERF_REGS_H
> +
> +/*
> + * Indices 0-30 match the hardware (and DWARF) register numbers.
> + * r9-r15 are not saved in pt_regs and cannot be sampled.
> + */
> +enum perf_event_alpha_regs {
> +       PERF_REG_ALPHA_R0,
> +       PERF_REG_ALPHA_R1,
> +       PERF_REG_ALPHA_R2,
> +       PERF_REG_ALPHA_R3,
> +       PERF_REG_ALPHA_R4,
> +       PERF_REG_ALPHA_R5,
> +       PERF_REG_ALPHA_R6,
> +       PERF_REG_ALPHA_R7,
> +       PERF_REG_ALPHA_R8,
> +       PERF_REG_ALPHA_R9,
> +       PERF_REG_ALPHA_R10,
> +       PERF_REG_ALPHA_R11,
> +       PERF_REG_ALPHA_R12,
> +       PERF_REG_ALPHA_R13,
> +       PERF_REG_ALPHA_R14,
> +       PERF_REG_ALPHA_R15,
> +       PERF_REG_ALPHA_R16,
> +       PERF_REG_ALPHA_R17,
> +       PERF_REG_ALPHA_R18,
> +       PERF_REG_ALPHA_R19,
> +       PERF_REG_ALPHA_R20,
> +       PERF_REG_ALPHA_R21,
> +       PERF_REG_ALPHA_R22,
> +       PERF_REG_ALPHA_R23,
> +       PERF_REG_ALPHA_R24,
> +       PERF_REG_ALPHA_R25,
> +       PERF_REG_ALPHA_R26,
> +       PERF_REG_ALPHA_R27,
> +       PERF_REG_ALPHA_R28,
> +       PERF_REG_ALPHA_GP,
> +       PERF_REG_ALPHA_SP,
> +       PERF_REG_ALPHA_PC,
> +       PERF_REG_ALPHA_MAX,
> +};
> +
> +#endif /* _UAPI_ASM_ALPHA_PERF_REGS_H */
> diff --git a/arch/alpha/kernel/Makefile b/arch/alpha/kernel/Makefile
> index 4ea5c189e60e..0c04b89676ed 100644
> --- a/arch/alpha/kernel/Makefile
> +++ b/arch/alpha/kernel/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_PCI)     +=3D pci.o pci_iommu.o pci-sysfs.=
o
>  obj-$(CONFIG_SRM_ENV)  +=3D srm_env.o
>  obj-$(CONFIG_MODULES)  +=3D module.o
>  obj-$(CONFIG_PERF_EVENTS) +=3D perf_event.o
> +obj-$(CONFIG_HAVE_PERF_REGS) +=3D perf_regs.o
>  obj-$(CONFIG_RTC_DRV_ALPHA) +=3D rtc.o
>  obj-$(CONFIG_AUDIT)    +=3D audit.o
>
> diff --git a/arch/alpha/kernel/perf_regs.c b/arch/alpha/kernel/perf_regs.=
c
> new file mode 100644
> index 000000000000..10afe4e205e9
> --- /dev/null
> +++ b/arch/alpha/kernel/perf_regs.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bits.h>
> +#include <linux/perf_event.h>
> +#include <asm/perf_regs.h>
> +
> +#define REG(idx, field) \
> +       [PERF_REG_ALPHA_##idx] =3D offsetof(struct pt_regs, field)
> +
> +#define REG_RESERVED   (~GENMASK_ULL(PERF_REG_ALPHA_MAX - 1, 0) | \
> +                        GENMASK_ULL(PERF_REG_ALPHA_R15, PERF_REG_ALPHA_R=
9))
> +
> +static const unsigned int pt_regs_offset[PERF_REG_ALPHA_MAX] =3D {
> +       REG(R0, r0),    REG(R1, r1),    REG(R2, r2),    REG(R3, r3),
> +       REG(R4, r4),    REG(R5, r5),    REG(R6, r6),    REG(R7, r7),
> +       REG(R8, r8),    REG(R16, r16),  REG(R17, r17),  REG(R18, r18),
> +       REG(R19, r19),  REG(R20, r20),  REG(R21, r21),  REG(R22, r22),
> +       REG(R23, r23),  REG(R24, r24),  REG(R25, r25),  REG(R26, r26),
> +       REG(R27, r27),  REG(R28, r28),  REG(GP, gp),    REG(PC, pc),
> +};
> +
> +u64 perf_reg_value(struct pt_regs *regs, int idx)
> +{
> +       if (idx =3D=3D PERF_REG_ALPHA_SP) {
> +               if (user_mode(regs))
> +                       return user_stack_pointer(regs);
> +               /* Same kernel sp approximation as stacktrace.c. */
> +               return (unsigned long)(regs + 1);
> +       }
> +

Tested on my ES40: register masks, SP/PC sampling and user stack dumps
passed with software-clock, page-fault and hardware-cycle events.

For context-switch events, however, regs points to the per-CPU
__perf_regs[0], not an on-stack trap frame. This therefore returns
a per-CPU address as SP.

I reproduced this with:

  perf record -e context-switches -c 1 -Isp,pc -- sleep 1

The sample reported SP=3D0xfffffc00045b4310 and PC=3D0. The missing PC
predates this patch, but the incorrect SP is newly exposed here.

One limitation I noticed: for context-switch events, regs points to
the per-CPU synthetic frame, so regs + 1 reports its address rather
than a kernel SP. Alpha already lacks perf_arch_fetch_caller_regs(),
so perhaps synthetic-event register capture is better handled as a
follow-up. Could we document that limitation here?


> +       if (WARN_ON_ONCE((u32)idx >=3D PERF_REG_ALPHA_MAX ||
> +                        BIT_ULL(idx) & REG_RESERVED))
> +               return 0;
> +
> +       return *(unsigned long *)((void *)regs + pt_regs_offset[idx]);
> +}
> +
> +int perf_reg_validate(u64 mask)
> +{
> +       if (!mask || mask & REG_RESERVED)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
> +u64 perf_reg_abi(struct task_struct *task)
> +{
> +       return PERF_SAMPLE_REGS_ABI_64;
> +}
> +
> +void perf_get_regs_user(struct perf_regs *regs_user,
> +                       struct pt_regs *regs)
> +{
> +       regs_user->regs =3D task_pt_regs(current);
> +       regs_user->abi =3D perf_reg_abi(current);
> +}
>
> --
> 2.55.0
>

Tested-by: Magnus Lindholm <linmag7@gmail.com>
