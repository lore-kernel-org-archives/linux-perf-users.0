Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921C12417E6
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 05:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756963878; cv=none; b=t8euDc5K17E2uL0n/I0KQlsmhBagvRcueY8ohx+ieNdhBG2SrJedxSyoLaR01AJGDHfT/uVjkwx4r2OTxpqGRYEIKG+0M5+nJqrfTBBHAgLgWMgE/7WUkLJpfjtCDYFuORTy2GSmWoi+soHXOquzxzAra8eI2Lg470h5ecasOYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756963878; c=relaxed/simple;
	bh=vGcbX+I0w1fuEqR/qXTtav6XoGYX3rGtlVX/FK6XFuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qnhzd3WJI9pc5ukJnNmKETx0hktyE6PP+LDKRKsGC3ImQg9agoDZ8ZEMjBPNbKOKdhVwqDUpJZmDFctqu1sR5EBQk5voQrOKGHaaia4F/f9mORtKzhp3N1ZrRnJUkodnoWUnT1NB91I3rrTso8eKjsX5g+l3TCbHXUpTImMYoMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=V1AcFyeG; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="V1AcFyeG"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55f6b0049fbso734918e87.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 22:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1756963875; x=1757568675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUS5HOLhW/VpyZE9onIdkx0oHXwb/D4QXFFEiFH3pRQ=;
        b=V1AcFyeGzS1iy+U1HenPzqA9mkeuvziFn2degKBzdcqowmOCCjGnQp9XUrdWkk54lE
         bzdzaqC+sRHPMQZpc3RUDTxYtsHv/0NNw40ot7r9ZGBEtP8GjQXP5iv696cHhzyy80mN
         t5tcTsTYK43ml5vyR4h3GgNVWJp6qUm/Osfy0SuRSBZfaWOdej+51T7wzciR8IofR4RR
         XeujSl/A04wxcQy6BvF1jCSwqbOii3b66Cuu1ihMYGxc6iGfJwciUNC9L+22E6i5XjaX
         InTrUMZPt6x/LBXCeH6sxLhM4JBcM4DUyVLCO4XJdrsVPc20pGC18XwW5kj9u+3Guy5G
         nx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756963875; x=1757568675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bUS5HOLhW/VpyZE9onIdkx0oHXwb/D4QXFFEiFH3pRQ=;
        b=gdyWpDBX7b1/Wbhk1C1DBaMOmnT/w5HuYEvi5iVL1IiOVxHpRw7eSJm9ZTbCDnTsLU
         Ng9H1TjTh5S12aaPT16VuR8J4hpmPcH6rQZfIdahFGuWL/V3cDBZHrMHEwwnTPM4RuG1
         jbSgKDxpoXcVTRAGkzazOp8H/lz/fPIJ5kvomjVmYshpxgJevfPrTD0vRlDM5zZ0Icq8
         y9E73E5TTwQWLqjxJ1UZ2ubS2DsZt3U/desgacVxhcDlXQC6bbLIBXFVPSKL8Qpd/PQ5
         sVeat7suSbmXIRgAfoFsZ6kp1BXCIbX/0kGq5Qw6GTZ8nglGB7yX0qu3ghcZDh+uVuFg
         H27Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXEfHjwvIgt75EAPQNwgJfqkl92oKWyv4TJ3Wdd6U2HrRb/2hg2bXAPM8JtoDDi6vAikDL4WQ5IGl82XkaXdq/@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7FN3f3mK5U4tR0EBtw+YFM0ujvzfn+CmUZ3iUDW2eiHXPahia
	YEZm2i9yPC30ciPWXoqDBSRzFYAE7ShJmffWpJ/HOlZ+6YJrtYb/8zuQuj50e7e93x0pRiG+16F
	aCjSX66nv+KzhLH5Ms05UTKZ0euTL9y3uz9d9lQJlog==
X-Gm-Gg: ASbGncs2PK3VZUA2BLkKFUF8dofxzs1ElN3jbec8tGa1DpDyJLhzAm7S7hrN2h65f7L
	wq8W6nziS9VKMz4+lEJpmkHmZEfzXS1iMmlHl5eAm1dQBZ44vg5JpKTzfixrAWTFM3t6boCjfid
	ckr5JmQy35dOb5iZhLeXODvvIBeEmBpzouKMffde4ZMZ+Zcx+L+7ptZaE2BJ7e5MF7eeMeohWWg
	xaV6ERIUNKy8PcpOQo=
X-Google-Smtp-Source: AGHT+IHpG/4DLLscFeJxg9oiSMyrT9Ei4giIfqBu/oq/vW7+cyJh5b4Qc/vs+psL1BC6wQvPjI60Gtk/quL0fGjGJtU=
X-Received: by 2002:a05:6512:1594:b0:55f:6831:6ef4 with SMTP id
 2adb3069b0e04-55f7089c47amr5218029e87.12.1756963874604; Wed, 03 Sep 2025
 22:31:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822174715.1269138-1-jesse@rivosinc.com> <20250822174715.1269138-5-jesse@rivosinc.com>
In-Reply-To: <20250822174715.1269138-5-jesse@rivosinc.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 4 Sep 2025 11:01:02 +0530
X-Gm-Features: Ac12FXz_-ibvebvqMYm5-3Nr_6futqZOiLsqEgz-5uDfiWQDjH2HOgDMSF197Fg
Message-ID: <CAK9=C2X=SmJeYqZtUNHuDBZRrUpONCm6Z=qVPH8C1ckz=r6hCw@mail.gmail.com>
Subject: Re: [PATCH 4/8] riscv: Introduce support for hardware break/watchpoints
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Oleg Nesterov <oleg@redhat.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Liang Kan <kan.liang@linux.intel.com>, Shuah Khan <shuah@kernel.org>, 
	Himanshu Chauhan <hchauhan@ventanamicro.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Deepak Gupta <debug@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Atish Patra <atishp@rivosinc.com>, Mayuresh Chitale <mchitale@ventanamicro.com>, 
	Evan Green <evan@rivosinc.com>, WangYuli <wangyuli@uniontech.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Nam Cao <namcao@linutronix.de>, 
	Yunhui Cui <cuiyunhui@bytedance.com>, Joel Granados <joel.granados@kernel.org>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Celeste Liu <coelacanthushex@gmail.com>, 
	Chunyan Zhang <zhangchunyan@iscas.ac.cn>, Nylon Chen <nylon.chen@sifive.com>, 
	Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 11:17=E2=80=AFPM Jesse Taube <jesse@rivosinc.com> w=
rote:
>
> From: Himanshu Chauhan <hchauhan@ventanamicro.com>
>
> RISC-V hardware breakpoint framework is built on top of perf subsystem an=
d uses
> SBI debug trigger extension to install/uninstall/update/enable/disable ha=
rdware
> triggers as specified in Sdtrig ISA extension.
>
> Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
> RFC -> V1:
>  - Add dbtr_mode to rv_init_mcontrol(6)_trigger
>  - Add select HAVE_MIXED_BREAKPOINTS_REGS
>  - Add TDATA1_MCTRL_SZ and TDATA1_MCTRL6_SZ
>  - Capitalize F in Fallback comment
>  - Fix in_callback code to allow multiple breakpoints
>  - Move perf_bp_event above setup_singlestep to save the correct state
>  - Use sbi_err_map_linux_errno for arch_smp_teardown/setup_sbi_shmem
> V1 -> V2:
>  - No change
> ---
>  arch/riscv/Kconfig                     |   2 +
>  arch/riscv/include/asm/hw_breakpoint.h |  59 +++
>  arch/riscv/include/asm/kdebug.h        |   3 +-
>  arch/riscv/include/asm/sbi.h           |   4 +-
>  arch/riscv/kernel/Makefile             |   1 +
>  arch/riscv/kernel/hw_breakpoint.c      | 614 +++++++++++++++++++++++++
>  arch/riscv/kernel/traps.c              |   6 +
>  7 files changed, 687 insertions(+), 2 deletions(-)
>  create mode 100644 arch/riscv/include/asm/hw_breakpoint.h
>  create mode 100644 arch/riscv/kernel/hw_breakpoint.c
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index bbec87b79309..fd8b62cdc6f5 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -163,6 +163,7 @@ config RISCV
>         select HAVE_FUNCTION_ERROR_INJECTION
>         select HAVE_GCC_PLUGINS
>         select HAVE_GENERIC_VDSO if MMU && 64BIT
> +       select HAVE_HW_BREAKPOINT if PERF_EVENTS && RISCV_SBI
>         select HAVE_IRQ_TIME_ACCOUNTING
>         select HAVE_KERNEL_BZIP2 if !XIP_KERNEL && !EFI_ZBOOT
>         select HAVE_KERNEL_GZIP if !XIP_KERNEL && !EFI_ZBOOT
> @@ -176,6 +177,7 @@ config RISCV
>         select HAVE_KRETPROBES if !XIP_KERNEL
>         # https://github.com/ClangBuiltLinux/linux/issues/1881
>         select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if !LD_IS_LLD
> +       select HAVE_MIXED_BREAKPOINTS_REGS
>         select HAVE_MOVE_PMD
>         select HAVE_MOVE_PUD
>         select HAVE_PAGE_SIZE_4KB
> diff --git a/arch/riscv/include/asm/hw_breakpoint.h b/arch/riscv/include/=
asm/hw_breakpoint.h
> new file mode 100644
> index 000000000000..cde6688b91d2
> --- /dev/null
> +++ b/arch/riscv/include/asm/hw_breakpoint.h
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2024 Ventana Micro Systems Inc.
> + */
> +
> +#ifndef __RISCV_HW_BREAKPOINT_H
> +#define __RISCV_HW_BREAKPOINT_H
> +
> +struct task_struct;
> +
> +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> +
> +#include <uapi/linux/hw_breakpoint.h>
> +
> +#if __riscv_xlen =3D=3D 64
> +#define cpu_to_le cpu_to_le64
> +#define le_to_cpu le64_to_cpu
> +#elif __riscv_xlen =3D=3D 32
> +#define cpu_to_le cpu_to_le32
> +#define le_to_cpu le32_to_cpu
> +#else
> +#error "Unexpected __riscv_xlen"
> +#endif
> +
> +struct arch_hw_breakpoint {
> +       unsigned long address;
> +       unsigned long len;
> +
> +       /* Callback info */
> +       unsigned long next_addr;
> +       bool in_callback;
> +
> +       /* Trigger configuration data */
> +       unsigned long tdata1;
> +       unsigned long tdata2;
> +       unsigned long tdata3;
> +};
> +
> +/* Maximum number of hardware breakpoints supported */
> +#define RV_MAX_TRIGGERS 32
> +
> +struct perf_event_attr;
> +struct notifier_block;
> +struct perf_event;
> +struct pt_regs;
> +
> +int hw_breakpoint_slots(int type);
> +int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
> +int hw_breakpoint_arch_parse(struct perf_event *bp,
> +                            const struct perf_event_attr *attr,
> +                            struct arch_hw_breakpoint *hw);
> +int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
> +                                   unsigned long val, void *data);
> +int arch_install_hw_breakpoint(struct perf_event *bp);
> +void arch_uninstall_hw_breakpoint(struct perf_event *bp);
> +void hw_breakpoint_pmu_read(struct perf_event *bp);
> +
> +#endif /* CONFIG_HAVE_HW_BREAKPOINT */
> +#endif /* __RISCV_HW_BREAKPOINT_H */
> diff --git a/arch/riscv/include/asm/kdebug.h b/arch/riscv/include/asm/kde=
bug.h
> index 85ac00411f6e..53e989781aa1 100644
> --- a/arch/riscv/include/asm/kdebug.h
> +++ b/arch/riscv/include/asm/kdebug.h
> @@ -6,7 +6,8 @@
>  enum die_val {
>         DIE_UNUSED,
>         DIE_TRAP,
> -       DIE_OOPS
> +       DIE_OOPS,
> +       DIE_DEBUG
>  };
>
>  #endif
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index be2ca8e8a49e..64fa7a82aa45 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -282,7 +282,9 @@ struct sbi_sta_struct {
>         u8 pad[47];
>  } __packed;
>
> -#define SBI_SHMEM_DISABLE              -1
> +#define SBI_SHMEM_DISABLE      (-1UL)
> +#define SBI_SHMEM_LO(pa)       ((unsigned long)lower_32_bits(pa))
> +#define SBI_SHMEM_HI(pa)       ((unsigned long)upper_32_bits(pa))

These definitions of SBI_SHMEM_LO() and SBI_SHMEM_HI() are
broken for RV64 platforms where a good amount of RAM is beyond
first 4GB.

This should be:

#ifdef CONFIG_32BIT
#define SBI_SHMEM_LO(pa)       ((unsigned long)lower_32_bits(pa))
#define SBI_SHMEM_HI(pa)       ((unsigned long)upper_32_bits(pa))
#else
#define SBI_SHMEM_LO(pa)       ((unsigned long)pa)
#define SBI_SHMEM_HI(pa)       0UL
#endif

Regards,
Anup
