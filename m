Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1359A1FB3
	for <linux-perf-users@vger.kernel.org>; Sun, 24 Aug 2025 14:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756047176; cv=none; b=C9w9HHhtCaefl10u+8B5iCXKKpz5jqyKiUGjtrcZbULcKezRi9tcAIC4hiUqr3CWFcDJWc9TF8HiF4HXD1pAaooLuoN6TqyTXCaR3hE78N8JNiQ6Sq4fwPirFiAjXtHauFgJzDpk1UkcamfHh1zJMzVkcJJlfeou00wl7St1OUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756047176; c=relaxed/simple;
	bh=rP7iqqaTnXOvb/spjo5Ebmkavm0PyuDdwoBDFL1mzcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fmDCkJIQsuANi0SUT+INXdhEoWryKrz+qKYoSMXSz47rjFe9O8muKQoaXJmZAP1cFptqRtL661RUlfhFwWlsQQRk8wy06ebTeO9QnJiGd5JUtklgpnOakkwrDofa44hAVF0oNCHpBUS9/dQ9Hq1LAw0ND1cdaOFZ5Zz79yT3EXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=CUF8Cukh; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="CUF8Cukh"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-335360f9b6aso32292901fa.0
        for <linux-perf-users@vger.kernel.org>; Sun, 24 Aug 2025 07:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1756047172; x=1756651972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4yiekTKoDQWzy0n8EP+AHR0dj1abTnBc4Ihn4r+6Vw=;
        b=CUF8CukhxJ/c4YryRQ0qi0Dz9CTRoEUHgQMMMnx2h81CMAUEhj3sCO1DglDaydMNED
         0QERMl02DgKfp4KEjdlOL+SwvyMYXf/TK1pVLzQsnYPNEEYBsi6vvG7yyR3QMkmsxIiN
         R66Iqn75Wj2zAc43LakU4smCTBCB75CSSAAgWEcW+eDiDCr9smVDfolzNxOnWm0r2c9j
         Lkcluh+1rwz549oYyW9tZks3q8YH86awMf6qoK000vtdm5kEby/FPWhm35tdy6rHjhq6
         m5OcIj4AJAep7rN9D+D8zfc3fxZT/jmFndW1TQdUJkC83MO4jJRfcc/ldWuwVc9L7q43
         MA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756047172; x=1756651972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4yiekTKoDQWzy0n8EP+AHR0dj1abTnBc4Ihn4r+6Vw=;
        b=GLRH5b5VK/Voglrg+NqOnIViHPk7umsFx7hshrd5T5MayZ5NP6Aa6+hYbnJxe0FLGE
         CvXjQYWN+KDuWs64AKWtUIJNTlU+n6WiIQYXIZsfoT07MoGcWstVCGyr0Sbo8+lFYpoQ
         xHj0j2aPRgYS7GlLBhEj45IZUFNH+RWnPFvAyFOuCfCavnQtXZLO/8QdTnglwbFHN2gf
         muWgMvEAnKspKIkbbuQPTYla1FG3ZFcYR4aBJFRyPCBQYC30uWzP8K8TuyV5K1Jw/g4e
         /K5F5kua9YdBAKlcuuQMxCozmYGH+fVM39/mT9+egMQqpb2Yz3nOEQd5sIXoK/aKC9L6
         o8FA==
X-Forwarded-Encrypted: i=1; AJvYcCVFgwTlXo1bC46SlJEOmmPasxjj/J18AsLnTbAQYA6FT5VO5jnk2LTf64sEGxRxruT8gB8JwAM21kXJd9Gpwunu@vger.kernel.org
X-Gm-Message-State: AOJu0YzS402CZhU5wi+oO56nu7cM0XEY3l0mkDklVnx5lhxe38tIgEwX
	90PDuKkKsGFuj1HbHL7sttjO4woNjXkGCyklSbXcS0U4U2PVjISm6qdrLMGNOFx4ICgPBWMbY0t
	WPRYNsDjJB4k39OejGVErdwUFJKCLMQ8g43ki1a5tTg==
X-Gm-Gg: ASbGncszAg0A1wbjmGaDAiu/87mgEPJyNw8c8Xbe/QwVCiET72AHZewUcgR/KunG8H9
	tN0KCYwOs/4Sw+MI8tpR9ngoJK+DntorPm1G7BVUTX/3CQNXXWklq4EWexjwsfRGQ1ThnjVOFSi
	vjGEm7E+zGG7LTWIKbZYb5jYTm4hi9oglHO7HSa81xVjclnvs1NXvyqJ1vlx1IDMi3r9MYEz12J
	6r6zijx
X-Google-Smtp-Source: AGHT+IFlSfUi4X6ijV1KcvD3fMurgoahKrmOlnW8+1Y3fiDNHAUbP2L2C6YPP0B/jkjhjtlByXtWu2+fBdmkpiWV1lU=
X-Received: by 2002:a05:651c:41d0:b0:336:1526:7fe7 with SMTP id
 38308e7fff4ca-33615268269mr22774361fa.3.1756047171837; Sun, 24 Aug 2025
 07:52:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822174715.1269138-1-jesse@rivosinc.com> <20250822174715.1269138-2-jesse@rivosinc.com>
In-Reply-To: <20250822174715.1269138-2-jesse@rivosinc.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Sun, 24 Aug 2025 20:22:39 +0530
X-Gm-Features: Ac12FXzI74g5Ug6WVcpL48bMqkkwTTrbHCPnUoKm2gxXKtW2DUam5Q_iJxl4QsU
Message-ID: <CAK9=C2VEiQsoy_G+kzVkZGVMcAJ-ioHcGQrRxpjuSh9aw66p0g@mail.gmail.com>
Subject: Re: [PATCH 1/8] riscv: Add insn.c, consolidate instruction decoding
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
> Various parts of the kernel decode and read instruction from memory.
> Functions like get_insn, GET_INSN_LENGTH and riscv_insn_is_c are defined
> in multiple places. Consolidate these functions into the insn.h and the
> newly added insn.c.
>
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
> RFC -> V1:
>  - No change
> V2 -> V1:
>  - No change
> ---
>  arch/riscv/include/asm/bug.h         |  12 ---
>  arch/riscv/include/asm/insn.h        | 131 ++++++++++++++++++++++-
>  arch/riscv/kernel/Makefile           |   1 +
>  arch/riscv/kernel/insn.c             | 151 +++++++++++++++++++++++++++
>  arch/riscv/kernel/kgdb.c             | 102 +-----------------
>  arch/riscv/kernel/probes/kprobes.c   |   1 +
>  arch/riscv/kernel/traps.c            |   5 +-
>  arch/riscv/kernel/traps_misaligned.c |  93 ++++-------------
>  8 files changed, 309 insertions(+), 187 deletions(-)
>  create mode 100644 arch/riscv/kernel/insn.c
>
> diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
> index 1aaea81fb141..a2777eb67ad1 100644
> --- a/arch/riscv/include/asm/bug.h
> +++ b/arch/riscv/include/asm/bug.h
> @@ -12,21 +12,9 @@
>
>  #include <asm/asm.h>
>
> -#define __INSN_LENGTH_MASK  _UL(0x3)
> -#define __INSN_LENGTH_32    _UL(0x3)
> -#define __COMPRESSED_INSN_MASK _UL(0xffff)
> -
>  #define __BUG_INSN_32  _UL(0x00100073) /* ebreak */
>  #define __BUG_INSN_16  _UL(0x9002) /* c.ebreak */
>
> -#define GET_INSN_LENGTH(insn)                                          \
> -({                                                                     \
> -       unsigned long __len;                                            \
> -       __len =3D ((insn & __INSN_LENGTH_MASK) =3D=3D __INSN_LENGTH_32) ?=
     \
> -               4UL : 2UL;                                              \
> -       __len;                                                          \
> -})
> -
>  typedef u32 bug_insn_t;
>
>  #ifdef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
> diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.=
h
> index 09fde95a5e8f..ba74e5b8262c 100644
> --- a/arch/riscv/include/asm/insn.h
> +++ b/arch/riscv/include/asm/insn.h
> @@ -64,6 +64,7 @@
>  #define RVG_RS2_OPOFF          20
>  #define RVG_RD_OPOFF           7
>  #define RVG_RS1_MASK           GENMASK(4, 0)
> +#define RVG_RS2_MASK           GENMASK(4, 0)
>  #define RVG_RD_MASK            GENMASK(4, 0)
>
>  /* The bit field of immediate value in RVC J instruction */
> @@ -121,17 +122,27 @@
>  #define RVC_C0_RS1_OPOFF       7
>  #define RVC_C0_RS2_OPOFF       2
>  #define RVC_C0_RD_OPOFF                2
> +#define RVC_C0_RS1_MASK                GENMASK(2, 0)
> +#define RVC_C0_RS2_MASK                GENMASK(2, 0)
> +#define RVC_C0_RD_MASK         GENMASK(2, 0)
> +#define RVC_C0_REG_OFFSET      8
>
>  /* The register offset in RVC op=3DC1 instruction */
>  #define RVC_C1_RS1_OPOFF       7
>  #define RVC_C1_RS2_OPOFF       2
>  #define RVC_C1_RD_OPOFF                7
> +#define RVC_C1_RS1_MASK                GENMASK(2, 0)
> +#define RVC_C1_RS2_MASK                GENMASK(2, 0)
> +#define RVC_C1_RD_MASK         GENMASK(2, 0)
> +#define RVC_C1_REG_OFFSET      8
>
>  /* The register offset in RVC op=3DC2 instruction */
>  #define RVC_C2_RS1_OPOFF       7
>  #define RVC_C2_RS2_OPOFF       2
>  #define RVC_C2_RD_OPOFF                7
>  #define RVC_C2_RS1_MASK                GENMASK(4, 0)
> +#define RVC_C2_RS2_MASK                GENMASK(4, 0)
> +#define RVC_C2_RD_MASK         GENMASK(4, 0)
>
>  /* parts of opcode for RVG*/
>  #define RVG_OPCODE_FENCE       0x0f
> @@ -226,12 +237,26 @@
>  #define RVC_MASK_C_EBREAK      0xffff
>  #define RVG_MASK_EBREAK                0xffffffff
>  #define RVG_MASK_SRET          0xffffffff
> +#define RVC_MASK_C             GENMASK(15, 0)
>
>  #define __INSN_LENGTH_MASK     _UL(0x3)
>  #define __INSN_LENGTH_GE_32    _UL(0x3)
>  #define __INSN_OPCODE_MASK     _UL(0x7F)
>  #define __INSN_BRANCH_OPCODE   _UL(RVG_OPCODE_BRANCH)
>
> +#define GET_INSN_LENGTH(insn)                                          \
> +({                                                                     \
> +       unsigned long __len;                                            \
> +       __len =3D ((insn & __INSN_LENGTH_MASK) =3D=3D __INSN_LENGTH_GE_32=
) ?  \
> +               4UL : 2UL;                                              \
> +       __len;                                                          \
> +})
> +
> +static __always_inline bool riscv_insn_is_c(u32 code)
> +{
> +       return (code & (__INSN_LENGTH_MASK)) !=3D (__INSN_LENGTH_GE_32);
> +}
> +
>  #define __RISCV_INSN_FUNCS(name, mask, val)                            \
>  static __always_inline bool riscv_insn_is_##name(u32 code)             \
>  {                                                                      \
> @@ -260,7 +285,7 @@ __RISCV_INSN_FUNCS(c_bnez, RVC_MASK_C_BNEZ, RVC_MATCH=
_C_BNEZ)
>  __RISCV_INSN_FUNCS(c_ebreak, RVC_MASK_C_EBREAK, RVC_MATCH_C_EBREAK)
>  __RISCV_INSN_FUNCS(ebreak, RVG_MASK_EBREAK, RVG_MATCH_EBREAK)
>  __RISCV_INSN_FUNCS(sret, RVG_MASK_SRET, RVG_MATCH_SRET)
> -__RISCV_INSN_FUNCS(fence, RVG_MASK_FENCE, RVG_MATCH_FENCE);
> +__RISCV_INSN_FUNCS(fence, RVG_MASK_FENCE, RVG_MATCH_FENCE)
>
>  /* special case to catch _any_ system instruction */
>  static __always_inline bool riscv_insn_is_system(u32 code)
> @@ -295,6 +320,10 @@ static __always_inline bool riscv_insn_is_c_jalr(u32=
 code)
>         ({typeof(x) x_ =3D (x); \
>         (RV_X(x_, RVG_RS1_OPOFF, RVG_RS1_MASK)); })
>
> +#define RV_EXTRACT_RS2_REG(x) \
> +       ({typeof(x) x_ =3D (x); \
> +       (RV_X(x_, RVG_RS2_OPOFF, RVG_RS2_MASK)); })
> +
>  #define RV_EXTRACT_RD_REG(x) \
>         ({typeof(x) x_ =3D (x); \
>         (RV_X(x_, RVG_RD_OPOFF, RVG_RD_MASK)); })
> @@ -322,9 +351,41 @@ static __always_inline bool riscv_insn_is_c_jalr(u32=
 code)
>         (RV_X(x_, RV_B_IMM_11_OPOFF, RV_B_IMM_11_MASK) << RV_B_IMM_11_OFF=
) | \
>         (RV_IMM_SIGN(x_) << RV_B_IMM_SIGN_OFF); })
>
> +#define RVC_EXTRACT_C0_RS1_REG(x) \
> +       ({typeof(x) x_ =3D (x); \
> +       (RVC_X(x_, RVC_C0_RS1_OPOFF, RVC_C0_RS1_MASK)); })
> +
> +#define RVC_EXTRACT_C0_RS2_REG(x) \
> +       ({typeof(x) x_ =3D (x); \
> +       (RVC_X(x_, RVC_C0_RS2_OPOFF, RVC_C0_RS2_MASK)); })
> +
> +#define RVC_EXTRACT_C0_RD_REG(x) \
> +       ({typeof(x) x_ =3D (x); \
> +       (RVC_X(x_, RVC_C0_RD_OPOFF, RVC_C0_RD_MASK)); })
> +
> +#define RVC_EXTRACT_C1_RS1_REG(x) \
> +       ({typeof(x) x_ =3D (x); \
> +       (RVC_X(x_, RVC_C1_RS1_OPOFF, RVC_C1_RS1_MASK)); })
> +
> +#define RVC_EXTRACT_C1_RS2_REG(x) \
> +       ({typeof(x) x_ =3D (x); \
> +       (RVC_X(x_, RVC_C1_RS2_OPOFF, RVC_C1_RS2_MASK)); })
> +
> +#define RVC_EXTRACT_C1_RD_REG(x) \
> +       ({typeof(x) x_ =3D (x); \
> +       (RVC_X(x_, RVC_C1_RD_OPOFF, RVC_C1_RD_MASK)); })
> +
>  #define RVC_EXTRACT_C2_RS1_REG(x) \
>         ({typeof(x) x_ =3D (x); \
> -       (RV_X(x_, RVC_C2_RS1_OPOFF, RVC_C2_RS1_MASK)); })
> +       (RVC_X(x_, RVC_C2_RS1_OPOFF, RVC_C2_RS1_MASK)); })
> +
> +#define RVC_EXTRACT_C2_RS2_REG(x) \
> +       ({typeof(x) x_ =3D (x); \
> +       (RVC_X(x_, RVC_C2_RS2_OPOFF, RVC_C2_RS2_MASK)); })
> +
> +#define RVC_EXTRACT_C2_RD_REG(x) \
> +       ({typeof(x) x_ =3D (x); \
> +       (RVC_X(x_, RVC_C2_RD_OPOFF, RVC_C2_RD_MASK)); })
>
>  #define RVC_EXTRACT_JTYPE_IMM(x) \
>         ({typeof(x) x_ =3D (x); \
> @@ -354,6 +415,66 @@ static __always_inline bool riscv_insn_is_c_jalr(u32=
 code)
>
>  #define RVV_EXRACT_VL_VS_WIDTH(x) RVFDQ_EXTRACT_FL_FS_WIDTH(x)
>
> +/*
> + * Get the rs1 register number from RV or RVC instruction.
> + *
> + * @insn: instruction to process
> + * Return: rs1 register
> + */
> +static inline unsigned int riscv_insn_extract_rs1_reg(u32 insn)
> +{
> +       switch (RVC_INSN_OPCODE_MASK & insn) {
> +       case RVC_OPCODE_C0:
> +               return RVC_EXTRACT_C0_RS1_REG(insn) + RVC_C0_REG_OFFSET;
> +       case RVC_OPCODE_C1:
> +               return RVC_EXTRACT_C1_RS1_REG(insn) + RVC_C1_REG_OFFSET;
> +       case RVC_OPCODE_C2:
> +               return RVC_EXTRACT_C2_RS1_REG(insn);
> +       default:
> +               return RV_EXTRACT_RS1_REG(insn);
> +       }
> +}
> +
> +/*
> + * Get the rs2 register number from RV or RVC instruction.
> + *
> + * @insn: instruction to process
> + * Return: rs2 register
> + */
> +static inline unsigned int riscv_insn_extract_rs2_reg(u32 insn)
> +{
> +       switch (RVC_INSN_OPCODE_MASK & insn) {
> +       case RVC_OPCODE_C0:
> +               return RVC_EXTRACT_C0_RS2_REG(insn) + RVC_C0_REG_OFFSET;
> +       case RVC_OPCODE_C1:
> +               return RVC_EXTRACT_C1_RS2_REG(insn) + RVC_C1_REG_OFFSET;
> +       case RVC_OPCODE_C2:
> +               return RVC_EXTRACT_C2_RS2_REG(insn);
> +       default:
> +               return RV_EXTRACT_RS2_REG(insn);
> +       }
> +}
> +
> +/*
> + * Get the rd register number from RV or RVC instruction.
> + *
> + * @insn: instruction to process
> + * Return: rd register
> + */
> +static inline unsigned int riscv_insn_extract_rd_reg(u32 insn)
> +{
> +       switch (RVC_INSN_OPCODE_MASK & insn) {
> +       case RVC_OPCODE_C0:
> +               return RVC_EXTRACT_C0_RD_REG(insn) + RVC_C0_REG_OFFSET;
> +       case RVC_OPCODE_C1:
> +               return RVC_EXTRACT_C1_RD_REG(insn) + RVC_C1_REG_OFFSET;
> +       case RVC_OPCODE_C2:
> +               return RVC_EXTRACT_C2_RD_REG(insn);
> +       default:
> +               return RV_EXTRACT_RD_REG(insn);
> +       }
> +}
> +
>  /*
>   * Get the immediate from a J-type instruction.
>   *
> @@ -428,4 +549,10 @@ static inline void riscv_insn_insert_utype_itype_imm=
(u32 *utype_insn, u32 *itype
>         *utype_insn |=3D (imm & RV_U_IMM_31_12_MASK) + ((imm & BIT(11)) <=
< 1);
>         *itype_insn |=3D ((imm & RV_I_IMM_11_0_MASK) << RV_I_IMM_11_0_OPO=
FF);
>  }
> +
> +#include <asm/ptrace.h>
> +
> +int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn);
> +unsigned long get_step_address(struct pt_regs *regs, u32 code);
> +
>  #endif /* _ASM_RISCV_INSN_H */
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index f7480c9c6f8d..4f719b09e5ad 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -51,6 +51,7 @@ obj-$(CONFIG_RISCV_ALTERNATIVE) +=3D alternative.o
>  obj-y  +=3D cpu.o
>  obj-y  +=3D cpufeature.o
>  obj-y  +=3D entry.o
> +obj-y  +=3D insn.o
>  obj-y  +=3D irq.o
>  obj-y  +=3D process.o
>  obj-y  +=3D ptrace.o
> diff --git a/arch/riscv/kernel/insn.c b/arch/riscv/kernel/insn.c
> new file mode 100644
> index 000000000000..dd2a6ef9fd25
> --- /dev/null
> +++ b/arch/riscv/kernel/insn.c
> @@ -0,0 +1,151 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2025 Rivos, Inc
> + */
> +#include <asm/insn.h>
> +#include <asm/ptrace.h>
> +#include <asm/uaccess.h>
> +
> +#define __read_insn(regs, insn, insn_addr, type)       \
> +({                                                     \
> +       int __ret;                                      \
> +                                                       \
> +       if (user_mode(regs)) {                          \
> +               __ret =3D get_user(insn, (type __user *) insn_addr); \
> +       } else {                                        \
> +               insn =3D *(type *)insn_addr;              \
> +               __ret =3D 0;                              \
> +       }                                               \
> +                                                       \
> +       __ret;                                          \
> +})
> +
> +/*
> + * Update a set of two instructions (U-type + I-type) with an immediate =
value.
> + *
> + * Used for example in auipc+jalrs pairs the U-type instructions contain=
s
> + * a 20bit upper immediate representing bits[31:12], while the I-type
> + * instruction contains a 12bit immediate representing bits[11:0].
> + *
> + * This also takes into account that both separate immediates are
> + * considered as signed values, so if the I-type immediate becomes
> + * negative (BIT(11) set) the U-type part gets adjusted.
> + *
> + * @regs: pointer to the utype instruction of the pair
> + * @epc: pointer to the itype instruction of the pair
> + * @r_insn: the immediate to insert into the two instructions
> + * Return: combined immediate
> + */
> +int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn)
> +{
> +       ulong insn =3D 0;
> +
> +       if (epc & 0x2) {
> +               ulong tmp =3D 0;
> +
> +               if (__read_insn(regs, insn, epc, u16))
> +                       return -EFAULT;
> +               /* __get_user() uses regular "lw" which sign extend the l=
oaded
> +                * value make sure to clear higher order bits in case we =
"or" it
> +                * below with the upper 16 bits half.
> +                */
> +               insn &=3D RVC_MASK_C;
> +               if (riscv_insn_is_c(insn)) {
> +                       *r_insn =3D insn;
> +                       return 0;
> +               }
> +               epc +=3D sizeof(u16);
> +               if (__read_insn(regs, tmp, epc, u16))
> +                       return -EFAULT;
> +               *r_insn =3D (tmp << 16) | insn;
> +
> +               return 0;
> +       } else {
> +               if (__read_insn(regs, insn, epc, u32))
> +                       return -EFAULT;
> +               if (!riscv_insn_is_c(insn)) {
> +                       *r_insn =3D insn;
> +                       return 0;
> +               }
> +               insn &=3D RVC_MASK_C;
> +               *r_insn =3D insn;
> +
> +               return 0;
> +       }
> +}
> +
> +/* Calculate the new address for after a step */
> +unsigned long get_step_address(struct pt_regs *regs, u32 code)
> +{
> +       unsigned long pc =3D regs->epc;
> +       unsigned int rs1_num, rs2_num;
> +
> +       if ((code & __INSN_LENGTH_MASK) !=3D __INSN_LENGTH_GE_32) {
> +               if (riscv_insn_is_c_jalr(code) ||
> +                   riscv_insn_is_c_jr(code)) {
> +                       rs1_num =3D riscv_insn_extract_rs1_reg(code);
> +                       return regs_get_register(regs, rs1_num);
> +               } else if (riscv_insn_is_c_j(code) ||
> +                          riscv_insn_is_c_jal(code)) {
> +                       return RVC_EXTRACT_JTYPE_IMM(code) + pc;
> +               } else if (riscv_insn_is_c_beqz(code)) {
> +                       rs1_num =3D riscv_insn_extract_rs1_reg(code);
> +                       if (!rs1_num || regs_get_register(regs, rs1_num) =
=3D=3D 0)
> +                               return RVC_EXTRACT_BTYPE_IMM(code) + pc;
> +                       else
> +                               return pc + 2;
> +               } else if (riscv_insn_is_c_bnez(code)) {
> +                       rs1_num =3D riscv_insn_extract_rs1_reg(RVC_C1_RS1=
_OPOFF);
> +                       if (rs1_num && regs_get_register(regs, rs1_num) !=
=3D 0)
> +                               return RVC_EXTRACT_BTYPE_IMM(code) + pc;
> +                       else
> +                               return pc + 2;
> +               } else {
> +                       return pc + 2;
> +               }
> +       } else {
> +               if ((code & __INSN_OPCODE_MASK) =3D=3D __INSN_BRANCH_OPCO=
DE) {
> +                       bool result =3D false;
> +                       long imm =3D RV_EXTRACT_BTYPE_IMM(code);
> +                       unsigned long rs1_val =3D 0, rs2_val =3D 0;
> +
> +                       rs1_num =3D riscv_insn_extract_rs1_reg(code);
> +                       rs2_num =3D riscv_insn_extract_rs2_reg(code);
> +                       if (rs1_num)
> +                               rs1_val =3D regs_get_register(regs, rs1_n=
um);
> +                       if (rs2_num)
> +                               rs2_val =3D regs_get_register(regs, rs2_n=
um);
> +
> +                       if (riscv_insn_is_beq(code))
> +                               result =3D (rs1_val =3D=3D rs2_val) ? tru=
e : false;
> +                       else if (riscv_insn_is_bne(code))
> +                               result =3D (rs1_val !=3D rs2_val) ? true =
: false;
> +                       else if (riscv_insn_is_blt(code))
> +                               result =3D
> +                                   ((long)rs1_val <
> +                                    (long)rs2_val) ? true : false;
> +                       else if (riscv_insn_is_bge(code))
> +                               result =3D
> +                                   ((long)rs1_val >=3D
> +                                    (long)rs2_val) ? true : false;
> +                       else if (riscv_insn_is_bltu(code))
> +                               result =3D (rs1_val < rs2_val) ? true : f=
alse;
> +                       else if (riscv_insn_is_bgeu(code))
> +                               result =3D (rs1_val >=3D rs2_val) ? true =
: false;
> +                       if (result)
> +                               return imm + pc;
> +                       else
> +                               return pc + 4;
> +               } else if (riscv_insn_is_jal(code)) {
> +                       return RV_EXTRACT_JTYPE_IMM(code) + pc;
> +               } else if (riscv_insn_is_jalr(code)) {
> +                       rs1_num =3D riscv_insn_extract_rs1_reg(code);
> +                       return RV_EXTRACT_ITYPE_IMM(code) +
> +                              (rs1_num ? regs_get_register(regs, rs1_num=
) : 0);
> +               } else if (riscv_insn_is_sret(code)) {
> +                       return pc;
> +               } else {
> +                       return pc + 4;
> +               }
> +       }
> +}
> diff --git a/arch/riscv/kernel/kgdb.c b/arch/riscv/kernel/kgdb.c
> index 9f3db3503dab..aafc1424fc81 100644
> --- a/arch/riscv/kernel/kgdb.c
> +++ b/arch/riscv/kernel/kgdb.c
> @@ -23,111 +23,19 @@ enum {
>  static unsigned long stepped_address;
>  static unsigned int stepped_opcode;
>
> -static int decode_register_index(unsigned long opcode, int offset)
> -{
> -       return (opcode >> offset) & 0x1F;
> -}
> -
> -static int decode_register_index_short(unsigned long opcode, int offset)
> -{
> -       return ((opcode >> offset) & 0x7) + 8;
> -}
> -
> -/* Calculate the new address for after a step */
> -static int get_step_address(struct pt_regs *regs, unsigned long *next_ad=
dr)
> -{
> -       unsigned long pc =3D regs->epc;
> -       unsigned long *regs_ptr =3D (unsigned long *)regs;
> -       unsigned int rs1_num, rs2_num;
> -       int op_code;
> -
> -       if (get_kernel_nofault(op_code, (void *)pc))
> -               return -EINVAL;
> -       if ((op_code & __INSN_LENGTH_MASK) !=3D __INSN_LENGTH_GE_32) {
> -               if (riscv_insn_is_c_jalr(op_code) ||
> -                   riscv_insn_is_c_jr(op_code)) {
> -                       rs1_num =3D decode_register_index(op_code, RVC_C2=
_RS1_OPOFF);
> -                       *next_addr =3D regs_ptr[rs1_num];
> -               } else if (riscv_insn_is_c_j(op_code) ||
> -                          riscv_insn_is_c_jal(op_code)) {
> -                       *next_addr =3D RVC_EXTRACT_JTYPE_IMM(op_code) + p=
c;
> -               } else if (riscv_insn_is_c_beqz(op_code)) {
> -                       rs1_num =3D decode_register_index_short(op_code,
> -                                                             RVC_C1_RS1_=
OPOFF);
> -                       if (!rs1_num || regs_ptr[rs1_num] =3D=3D 0)
> -                               *next_addr =3D RVC_EXTRACT_BTYPE_IMM(op_c=
ode) + pc;
> -                       else
> -                               *next_addr =3D pc + 2;
> -               } else if (riscv_insn_is_c_bnez(op_code)) {
> -                       rs1_num =3D
> -                           decode_register_index_short(op_code, RVC_C1_R=
S1_OPOFF);
> -                       if (rs1_num && regs_ptr[rs1_num] !=3D 0)
> -                               *next_addr =3D RVC_EXTRACT_BTYPE_IMM(op_c=
ode) + pc;
> -                       else
> -                               *next_addr =3D pc + 2;
> -               } else {
> -                       *next_addr =3D pc + 2;
> -               }
> -       } else {
> -               if ((op_code & __INSN_OPCODE_MASK) =3D=3D __INSN_BRANCH_O=
PCODE) {
> -                       bool result =3D false;
> -                       long imm =3D RV_EXTRACT_BTYPE_IMM(op_code);
> -                       unsigned long rs1_val =3D 0, rs2_val =3D 0;
> -
> -                       rs1_num =3D decode_register_index(op_code, RVG_RS=
1_OPOFF);
> -                       rs2_num =3D decode_register_index(op_code, RVG_RS=
2_OPOFF);
> -                       if (rs1_num)
> -                               rs1_val =3D regs_ptr[rs1_num];
> -                       if (rs2_num)
> -                               rs2_val =3D regs_ptr[rs2_num];
> -
> -                       if (riscv_insn_is_beq(op_code))
> -                               result =3D (rs1_val =3D=3D rs2_val) ? tru=
e : false;
> -                       else if (riscv_insn_is_bne(op_code))
> -                               result =3D (rs1_val !=3D rs2_val) ? true =
: false;
> -                       else if (riscv_insn_is_blt(op_code))
> -                               result =3D
> -                                   ((long)rs1_val <
> -                                    (long)rs2_val) ? true : false;
> -                       else if (riscv_insn_is_bge(op_code))
> -                               result =3D
> -                                   ((long)rs1_val >=3D
> -                                    (long)rs2_val) ? true : false;
> -                       else if (riscv_insn_is_bltu(op_code))
> -                               result =3D (rs1_val < rs2_val) ? true : f=
alse;
> -                       else if (riscv_insn_is_bgeu(op_code))
> -                               result =3D (rs1_val >=3D rs2_val) ? true =
: false;
> -                       if (result)
> -                               *next_addr =3D imm + pc;
> -                       else
> -                               *next_addr =3D pc + 4;
> -               } else if (riscv_insn_is_jal(op_code)) {
> -                       *next_addr =3D RV_EXTRACT_JTYPE_IMM(op_code) + pc=
;
> -               } else if (riscv_insn_is_jalr(op_code)) {
> -                       rs1_num =3D decode_register_index(op_code, RVG_RS=
1_OPOFF);
> -                       if (rs1_num)
> -                               *next_addr =3D ((unsigned long *)regs)[rs=
1_num];
> -                       *next_addr +=3D RV_EXTRACT_ITYPE_IMM(op_code);
> -               } else if (riscv_insn_is_sret(op_code)) {
> -                       *next_addr =3D pc;
> -               } else {
> -                       *next_addr =3D pc + 4;
> -               }
> -       }
> -       return 0;
> -}
> -
>  static int do_single_step(struct pt_regs *regs)
>  {
>         /* Determine where the target instruction will send us to */
> -       unsigned long addr =3D 0;
> -       int error =3D get_step_address(regs, &addr);
> +       unsigned long addr, insn;
> +       int error =3D get_insn(regs, regs->epc, &insn);
>
>         if (error)
>                 return error;
>
> +       addr =3D get_step_address(regs, insn);
> +
>         /* Store the op code in the stepped address */
> -       error =3D get_kernel_nofault(stepped_opcode, (void *)addr);
> +       error =3D get_insn(regs, addr, stepped_opcode);

This line gives following compile error:

     arch/riscv/kernel/kgdb.c: In function 'do_single_step':
     arch/riscv/kernel/kgdb.c:38:38: error: passing argument 3 of
'get_insn' makes pointer from integer without a cast
[-Wint-conversion]
        38 |         error =3D get_insn(regs, addr, stepped_opcode);
           |                                      ^~~~~~~~~~~~~~
           |                                      |
           |                                      unsigned int
     In file included from arch/riscv/kernel/kgdb.c:14:
     ./arch/riscv/include/asm/insn.h:555:54: note: expected 'ulong *'
{aka 'long unsigned int *'} but argument is of type 'unsigned int'
       555 | int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn);
           |                                               ~~~~~~~^~~~~~

If you are touching some source then at least compile test it.

Regards,
Anup
