Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884C132694D
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Jan 2026 05:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768628539; cv=pass; b=qMtoPC6hd/GWh8PKDJOtvcvo8fwODF+pECb2tR1jZZQPgfghi7TY9PVdxCjgzxM9UX+TG8MIrcap07ozbi6DrkKRRCB176yk3YqooBw9RglwR4QUyas8ZTwi/aMnzsCg6GKH6NIOgQwczdCRvPrGwEcmPvUdKwyQRMK2mqfgE7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768628539; c=relaxed/simple;
	bh=hpEwkEHY3lB+hjYlhO3dVZa76f3GPrFkSdb8i5GQyuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=WM7zZa1SBlT0pktB0SvT2x151nAM/RdAjq4OmmMHqyx3dmwC7UgiXl8S7sSCXhX3PR/ey7YElCy/RZODJw1PxmIJQLCRWk5RjyiGxAL9w4iEGjqKegf6c+huN9YJC+e6t8f1YiawQ6yS+CSMrOB3Sk92VXn5Eul//23453xOpK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ptXbVLJZ; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ptXbVLJZ"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a1462573caso32435ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Jan 2026 21:42:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768628537; cv=none;
        d=google.com; s=arc-20240605;
        b=f6tAZsSerjpYzCAMzQM8gJ39YpyJSmj9bMol6pgS+iN2X2ACBY8Cq/z6qgTfVJFAFH
         OZnmWcxvwMw5DFcO+kOgx6jmhENUvwy4D3QNS8PruhR4tqxkL+2SKefLNbQRad4Db534
         VDTmI86IxtROkvmHrTgS37OsgchXvD/ZBzqXRitC1QPYazpLPYGlAuLHo749LnKC6nr3
         K4pm55idV51ez5Lb8txskRLKnHNvRamJ9cSbUsbbvqJ1zCXEsqOtOiGX9Hhavmf9BIO+
         wj8HKFlCq6240hb+D2Tcq2oRoXjltP97+20iN5GK2+Nl3/KDWrZwYVbjZ4HRhu/vZVWX
         G40Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/HowtbIgjBHPn5b5iQyqGyRztJcPHe75Q5B9Qsb7fQU=;
        fh=cnI6E9m4vSP5noxV5Q38l2yMlV2NdHezo8t6eQoTduo=;
        b=Ie/Q7ch2CmDGkFELOMy7whSSDvSUCaWA8ysbUTXA32g+dZTfXs204ZJsKvWSX3++4N
         owIxuRFwrt9YxiOqjclmUAoDNdN3ZBjdsBKC+f/uUmrhlUdyTuHZntiostkFIF1VuTxU
         KQHTqGBLxMytMurweKpyLw7FE/xJ9vUr7jEO/AVpe0hN+530a9DMZyRANWbX75a6N/fR
         k94WCgiembr8P5Dmdb6UQrGFN2Jt08gYoo0NhJKPlOR93GDmJFUBRoodBVWKS4jk6xBr
         t0NJGICnJkbaXMvlsb5q9GdYwBuPodQn4ObQ5NdjUhZWPYNwt3GaMGWwLtY6IreoIWrE
         PWEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768628537; x=1769233337; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HowtbIgjBHPn5b5iQyqGyRztJcPHe75Q5B9Qsb7fQU=;
        b=ptXbVLJZRkPdg2oH8UlnbgKuTj9EnM/eiANqACHdIQfURnYojNeGcdH0Fx+M2q4+ug
         W0Wsb6gv6wOsMqV4NG4eJBt4exhLbo6ore4d93e2jFcHy8VIEHqe/o/horfNuddCueCK
         yQD0BuRGrqM5eFiIv3ndAGvNgcm42/8cNbBwHWzwoGgoezTQTn4K6azvl47ttRjUxmI6
         4qqC1W0JpMm0+guZw7f0UW8vzJ2z5idZ22V+6JyIl6atCYRp8kkekJNbsenk2oNWXd3E
         n/n+mlcJG1Yk+6NGPtdUHb++Ilhjm8iM+rbFitOoE34FDnPXTFFPlEUrJxtE5P9NNucz
         sPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768628537; x=1769233337;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/HowtbIgjBHPn5b5iQyqGyRztJcPHe75Q5B9Qsb7fQU=;
        b=MZ0U7cdRPpdIFtCaPcmG3XyZv77fq0GyY8de9fH6VoLx8YO5EoqlET9Aep4/mjCLqr
         b3w4Lv64zWCOULPqLeslZC5UKQORGH9NahB2ar99kTOpcHmESk8LfCH185wCcfnhHfgw
         sdyKofio73O0VrHU+L2fXAzKsvuVsEA8v+flUoTKO+MC0TWuB4wJNWEUZG6gHaUsRzxt
         XkWnyd4wG2HJIIeoFi4BdnKgMvfV4r+1pm9eMEJB9DglOJ6ryDjEcQGxaEypzFU6r+Lj
         OmlNB443rCsJs5o8aI8NQdozZGvpLXI3v1UIZMfM5lOn7w5zDR36iYdtY8p6w2bE60Od
         C2HA==
X-Forwarded-Encrypted: i=1; AJvYcCWFXuhZBvs75Myck78+/E/Vv+1Keq5U1I8rUUHtTDbhlYMpL0TnsnhbipAu4F+7uFnKOdG927SaVhbgMdBwwr/E@vger.kernel.org
X-Gm-Message-State: AOJu0YzG1KaIxAfkLyogZl6iatJ17a+mkaJF74ofzT/rqoajPiuQh9cm
	/zD1KYFdBeI6Bi5yDpVAIr/19pRYPwz52+m7QX4LkgJZa5zPSU0wpVozXjevWRqX3d8hflQ9p0b
	mgIjL0rNUcJ72sai9X4OS/pCUtzqmsOCtIgZpQyaz
X-Gm-Gg: AY/fxX7iTMzGV7Ql4aBKTb3GVVp7evE5cpLcKI7BvjndsZnHD4rLOD6Pgqm7xQk5ENX
	0QAts+lLgptmwoUGoBrwn/XOJ0KMb8zkTh4L0thfq6Xqwj/rxeV03qzQzgdxNIlbb7+CPCtP1vG
	20PbA5RvBvIs+SQPC3erQid7fOu+9x4byjgS1Lg1kLYZeDnldeE/1LnzTNmVwzuTgUOo3I6RXLG
	+hvye/Q/WClPPMNqJ6FRxSaXIxryZocmKQhGrirJ6fl//XWKapqbntYoIR4TuLRy5/tqrEg
X-Received: by 2002:a17:902:ebca:b0:2a1:3cdc:771f with SMTP id
 d9443c01a7336-2a7289da59dmr1542765ad.20.1768628536490; Fri, 16 Jan 2026
 21:42:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260117052849.2205545-1-irogers@google.com> <20260117052849.2205545-13-irogers@google.com>
In-Reply-To: <20260117052849.2205545-13-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 16 Jan 2026 21:42:04 -0800
X-Gm-Features: AZwV_QiI5bt4CEvuOm6lkwrRgAcIvjR8VNES1ukiClVO4_i6GvLblAZNbyy2a5Q
Message-ID: <CAP-5=fVxwV0rKrHgDN_j-SsHnAvrJK-WgDuvi-KAYkqNO6iTJQ@mail.gmail.com>
Subject: Re: [PATCH v1 12/23] perf dwarf-regs: Add get_dwarf_regnum_for_perf_regnum
 and use for x86 unwinding
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Shimin Guo <shimin.guo@skydio.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dmitry Vyukov <dvyukov@google.com>, 
	=?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>, 
	Chun-Tse Shao <ctshao@google.com>, Aditya Bodkhe <aditya.b1@linux.ibm.com>, 
	Haibo Xu <haibo1.xu@intel.com>, Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Wielaard <mark@klomp.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 9:29=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Add a utility to map a perf register number to a dwarf register number
> for a particular ELF machine type.
>
> Create a generic unwind-libdw initial register initialization routine
> that uses this function and thereby avoids arch specific
> initialization. The unwind-libdw code does:
> 1) compute the maximum dwarf register from the set of sampled user regist=
ers,
> 2) allocates a set of dwarf registers,
> 3) copies the sample registers into the appropriate dwarf registers.
>
> This generic solution is initially implemented for use with x86 as
> only get_dwarf_regnum_for_perf_regnum support for x86 is currently presen=
t.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  .../util/dwarf-regs-arch/dwarf-regs-x86.c     | 95 +++++++++++++++++++
>  tools/perf/util/dwarf-regs.c                  | 55 +++++++++++
>  tools/perf/util/include/dwarf-regs.h          |  8 ++
>  tools/perf/util/unwind-libdw-arch/Build       |  1 -
>  .../util/unwind-libdw-arch/unwind-libdw-x86.c | 54 -----------
>  tools/perf/util/unwind-libdw.c                | 70 ++++++++++++--
>  tools/perf/util/unwind-libdw.h                |  2 +-
>  7 files changed, 222 insertions(+), 63 deletions(-)
>  delete mode 100644 tools/perf/util/unwind-libdw-arch/unwind-libdw-x86.c
>
> diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-x86.c b/tools/per=
f/util/dwarf-regs-arch/dwarf-regs-x86.c
> index f0c42e4d7423..cadef120aeb4 100644
> --- a/tools/perf/util/dwarf-regs-arch/dwarf-regs-x86.c
> +++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-x86.c
> @@ -10,6 +10,7 @@
>  #include <string.h> /* for strcmp */
>  #include <linux/kernel.h> /* for ARRAY_SIZE */
>  #include <dwarf-regs.h>
> +#include "../../../arch/x86/include/uapi/asm/perf_regs.h"
>
>  struct dwarf_regs_idx {
>         const char *name;
> @@ -163,3 +164,97 @@ int __get_dwarf_regnum_x86_64(const char *name)
>  {
>         return get_regnum(x86_64_regidx_table, ARRAY_SIZE(x86_64_regidx_t=
able), name);
>  }
> +
> +int __get_dwarf_regnum_for_perf_regnum_i386(int perf_regnum)
> +{
> +       static const int dwarf_i386_regnums[] =3D {
> +               [PERF_REG_X86_AX] =3D 0,
> +               [PERF_REG_X86_BX] =3D 3,
> +               [PERF_REG_X86_CX] =3D 1,
> +               [PERF_REG_X86_DX] =3D 2,
> +               [PERF_REG_X86_SI] =3D 6,
> +               [PERF_REG_X86_DI] =3D 7,
> +               [PERF_REG_X86_BP] =3D 5,
> +               [PERF_REG_X86_SP] =3D 4,
> +               [PERF_REG_X86_IP] =3D 8,
> +               [PERF_REG_X86_FLAGS] =3D 9,
> +               [PERF_REG_X86_CS] =3D 41,
> +               [PERF_REG_X86_SS] =3D 42,
> +               [PERF_REG_X86_DS] =3D 43,
> +               [PERF_REG_X86_ES] =3D 40,
> +               [PERF_REG_X86_FS] =3D 44,
> +               [PERF_REG_X86_GS] =3D 45,
> +               [PERF_REG_X86_XMM0] =3D 21,
> +               [PERF_REG_X86_XMM1] =3D 22,
> +               [PERF_REG_X86_XMM2] =3D 23,
> +               [PERF_REG_X86_XMM3] =3D 24,
> +               [PERF_REG_X86_XMM4] =3D 25,
> +               [PERF_REG_X86_XMM5] =3D 26,
> +               [PERF_REG_X86_XMM6] =3D 27,
> +               [PERF_REG_X86_XMM7] =3D 28,
> +       };
> +
> +       if (perf_regnum =3D=3D 0)
> +               return 0;
> +
> +       if (perf_regnum <  0 || perf_regnum > (int)ARRAY_SIZE(dwarf_i386_=
regnums) ||
> +           dwarf_i386_regnums[perf_regnum] =3D=3D 0)
> +               return -ENOENT;
> +
> +       return dwarf_i386_regnums[perf_regnum];
> +}
> +
> +int __get_dwarf_regnum_for_perf_regnum_x86_64(int perf_regnum)
> +{
> +       static const int dwarf_x86_64_regnums[] =3D {
> +               [PERF_REG_X86_AX] =3D 0,
> +               [PERF_REG_X86_BX] =3D 3,
> +               [PERF_REG_X86_CX] =3D 2,
> +               [PERF_REG_X86_DX] =3D 1,
> +               [PERF_REG_X86_SI] =3D 4,
> +               [PERF_REG_X86_DI] =3D 5,
> +               [PERF_REG_X86_BP] =3D 6,
> +               [PERF_REG_X86_SP] =3D 7,
> +               [PERF_REG_X86_IP] =3D 16,
> +               [PERF_REG_X86_FLAGS] =3D 49,
> +               [PERF_REG_X86_CS] =3D 51,
> +               [PERF_REG_X86_SS] =3D 52,
> +               [PERF_REG_X86_DS] =3D 53,
> +               [PERF_REG_X86_ES] =3D 50,
> +               [PERF_REG_X86_FS] =3D 54,
> +               [PERF_REG_X86_GS] =3D 55,
> +               [PERF_REG_X86_R8] =3D 8,
> +               [PERF_REG_X86_R9] =3D 9,
> +               [PERF_REG_X86_R10] =3D 10,
> +               [PERF_REG_X86_R11] =3D 11,
> +               [PERF_REG_X86_R12] =3D 12,
> +               [PERF_REG_X86_R13] =3D 13,
> +               [PERF_REG_X86_R14] =3D 14,
> +               [PERF_REG_X86_R15] =3D 15,
> +               [PERF_REG_X86_XMM0] =3D 17,
> +               [PERF_REG_X86_XMM1] =3D 18,
> +               [PERF_REG_X86_XMM2] =3D 19,
> +               [PERF_REG_X86_XMM3] =3D 20,
> +               [PERF_REG_X86_XMM4] =3D 21,
> +               [PERF_REG_X86_XMM5] =3D 22,
> +               [PERF_REG_X86_XMM6] =3D 23,
> +               [PERF_REG_X86_XMM7] =3D 24,
> +               [PERF_REG_X86_XMM8] =3D 25,
> +               [PERF_REG_X86_XMM9] =3D 26,
> +               [PERF_REG_X86_XMM10] =3D 27,
> +               [PERF_REG_X86_XMM11] =3D 28,
> +               [PERF_REG_X86_XMM12] =3D 29,
> +               [PERF_REG_X86_XMM13] =3D 30,
> +               [PERF_REG_X86_XMM14] =3D 31,
> +               [PERF_REG_X86_XMM15] =3D 32,
> +       };
> +
> +       if (perf_regnum =3D=3D 0)
> +               return 0;
> +
> +       if (perf_regnum <  0 || perf_regnum > (int)ARRAY_SIZE(dwarf_x86_6=
4_regnums) ||
> +           dwarf_x86_64_regnums[perf_regnum] =3D=3D 0)
> +               return -ENOENT;
> +
> +       return dwarf_x86_64_regnums[perf_regnum];
> +}
> diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
> index ef249dd589e3..1f7d892612df 100644
> --- a/tools/perf/util/dwarf-regs.c
> +++ b/tools/perf/util/dwarf-regs.c
> @@ -103,3 +103,58 @@ int get_dwarf_regnum(const char *name, unsigned int =
machine, unsigned int flags
>         free(regname);
>         return reg;
>  }
> +
> +static int get_libdw_frame_nregs(unsigned int machine, unsigned int flag=
s __maybe_unused)
> +{
> +       switch (machine) {
> +       case EM_X86_64:
> +               return 17;
> +       case EM_386:
> +               return 9;
> +       case EM_ARM:
> +               return 16;
> +       case EM_AARCH64:
> +               return 97;
> +       case EM_CSKY:
> +               return 38;
> +       case EM_S390:
> +               return 32;
> +       case EM_PPC:
> +       case EM_PPC64:
> +               return 145;
> +       case EM_RISCV:
> +               return 66;
> +       case EM_SPARC:
> +       case EM_SPARCV9:
> +               return 103;
> +       case EM_LOONGARCH:
> +               return 74;
> +       default:
> +               return 0;
> +       }
> +}
> +
> +int get_dwarf_regnum_for_perf_regnum(int perf_regnum, unsigned int machi=
ne,
> +                                    unsigned int flags, bool only_libdw_=
supported)
> +{
> +       int reg;
> +
> +       switch (machine) {
> +       case EM_X86_64:
> +               reg =3D __get_dwarf_regnum_for_perf_regnum_x86_64(perf_re=
gnum);
> +               break;
> +       case EM_386:
> +               reg =3D __get_dwarf_regnum_for_perf_regnum_i386(perf_regn=
um);
> +               break;
> +       default:
> +               pr_err("ELF MACHINE %x is not supported.\n", machine);
> +               return -ENOENT;
> +       }
> +       if (reg >=3D 0 && only_libdw_supported) {
> +               int nregs =3D get_libdw_frame_nregs(machine, flags);
> +
> +               if (reg >=3D nregs)
> +                       reg =3D -ENOENT;
> +       }
> +       return reg;
> +}
> diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/inclu=
de/dwarf-regs.h
> index bb5413b0fee4..00881f1d45d6 100644
> --- a/tools/perf/util/include/dwarf-regs.h
> +++ b/tools/perf/util/include/dwarf-regs.h
> @@ -101,6 +101,8 @@ const char *get_dwarf_regstr(unsigned int n, unsigned=
 int machine, unsigned int
>
>  int __get_dwarf_regnum_i386(const char *name);
>  int __get_dwarf_regnum_x86_64(const char *name);
> +int __get_dwarf_regnum_for_perf_regnum_i386(int perf_regnum);
> +int __get_dwarf_regnum_for_perf_regnum_x86_64(int perf_regnum);
>
>  /*
>   * get_dwarf_regnum - Returns DWARF regnum from register name
> @@ -109,6 +111,12 @@ int __get_dwarf_regnum_x86_64(const char *name);
>   */
>  int get_dwarf_regnum(const char *name, unsigned int machine, unsigned in=
t flags);
>
> +/*
> + * get_dwarf_regnum - Returns DWARF regnum from perf register number.
> + */
> +int get_dwarf_regnum_for_perf_regnum(int perf_regnum, unsigned int machi=
ne, unsigned int flags,
> +                                    bool only_libdw_supported);
> +
>  void get_powerpc_regs(u32 raw_insn, int is_source, struct annotated_op_l=
oc *op_loc);
>
>  #else /* HAVE_LIBDW_SUPPORT */
> diff --git a/tools/perf/util/unwind-libdw-arch/Build b/tools/perf/util/un=
wind-libdw-arch/Build
> index ef17a83a7813..5b5682029953 100644
> --- a/tools/perf/util/unwind-libdw-arch/Build
> +++ b/tools/perf/util/unwind-libdw-arch/Build
> @@ -1,4 +1,3 @@
> -perf-util-y +=3D unwind-libdw-x86.o
>  perf-util-y +=3D unwind-libdw-arm.o
>  perf-util-y +=3D unwind-libdw-arm64.o
>  perf-util-y +=3D unwind-libdw-csky.o
> diff --git a/tools/perf/util/unwind-libdw-arch/unwind-libdw-x86.c b/tools=
/perf/util/unwind-libdw-arch/unwind-libdw-x86.c
> deleted file mode 100644
> index dd27545a4a68..000000000000
> --- a/tools/perf/util/unwind-libdw-arch/unwind-libdw-x86.c
> +++ /dev/null
> @@ -1,54 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <elfutils/libdwfl.h>
> -#include "../arch/x86/include/uapi/asm/perf_regs.h"
> -#include "util/unwind-libdw.h"
> -#include "util/perf_regs.h"
> -#include "util/sample.h"
> -
> -bool libdw_set_initial_registers_x86(Dwfl_Thread *thread, void *arg)
> -{
> -       struct unwind_info *ui =3D arg;
> -       struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
> -       Dwarf_Word dwarf_regs[17];
> -       unsigned nregs;
> -
> -#define REG(r) ({                                              \
> -       Dwarf_Word val =3D 0;                                     \
> -       perf_reg_value(&val, user_regs, PERF_REG_X86_##r);      \
> -       val;                                                    \
> -})
> -
> -       if (user_regs->abi =3D=3D PERF_SAMPLE_REGS_ABI_32) {
> -               dwarf_regs[0] =3D REG(AX);
> -               dwarf_regs[1] =3D REG(CX);
> -               dwarf_regs[2] =3D REG(DX);
> -               dwarf_regs[3] =3D REG(BX);
> -               dwarf_regs[4] =3D REG(SP);
> -               dwarf_regs[5] =3D REG(BP);
> -               dwarf_regs[6] =3D REG(SI);
> -               dwarf_regs[7] =3D REG(DI);
> -               dwarf_regs[8] =3D REG(IP);
> -               nregs =3D 9;
> -       } else {
> -               dwarf_regs[0]  =3D REG(AX);
> -               dwarf_regs[1]  =3D REG(DX);
> -               dwarf_regs[2]  =3D REG(CX);
> -               dwarf_regs[3]  =3D REG(BX);
> -               dwarf_regs[4]  =3D REG(SI);
> -               dwarf_regs[5]  =3D REG(DI);
> -               dwarf_regs[6]  =3D REG(BP);
> -               dwarf_regs[7]  =3D REG(SP);
> -               dwarf_regs[8]  =3D REG(R8);
> -               dwarf_regs[9]  =3D REG(R9);
> -               dwarf_regs[10] =3D REG(R10);
> -               dwarf_regs[11] =3D REG(R11);
> -               dwarf_regs[12] =3D REG(R12);
> -               dwarf_regs[13] =3D REG(R13);
> -               dwarf_regs[14] =3D REG(R14);
> -               dwarf_regs[15] =3D REG(R15);
> -               dwarf_regs[16] =3D REG(IP);
> -               nregs =3D 17;
> -       }
> -
> -       return dwfl_thread_state_registers(thread, 0, nregs, dwarf_regs);
> -}
> diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libd=
w.c
> index c25190cdceb4..055dab921442 100644
> --- a/tools/perf/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw.c
> @@ -6,6 +6,7 @@
>  #include <errno.h>
>  #include "debug.h"
>  #include "dso.h"
> +#include <dwarf-regs.h>
>  #include "unwind.h"
>  #include "unwind-libdw.h"
>  #include "machine.h"
> @@ -225,6 +226,59 @@ static bool memory_read(Dwfl *dwfl __maybe_unused, D=
warf_Addr addr, Dwarf_Word *
>         return true;
>  }
>
> +static bool libdw_set_initial_registers_generic(Dwfl_Thread *thread, voi=
d *arg)
> +{
> +       struct unwind_info *ui =3D arg;
> +       struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
> +       Dwarf_Word *dwarf_regs;
> +       int max_dwarf_reg =3D 0;
> +       bool ret;
> +       uint16_t e_machine =3D ui->e_machine;
> +       int e_flags =3D 0;
> +       uint64_t ip_perf_reg =3D perf_arch_reg_ip(e_machine);
> +       Dwarf_Word val =3D 0;
> +
> +
> +       /*
> +        * For every possible perf register in the bitmap determine the d=
warf
> +        * register and use to compute the max.
> +        */
> +       for (int perf_reg =3D 0; perf_reg < 64; perf_reg++) {
> +               if (user_regs->mask & (1ULL << perf_reg)) {
> +                       int dwarf_reg =3D
> +                               get_dwarf_regnum_for_perf_regnum(perf_reg=
, e_machine,
> +                                                                e_flags,
> +                                                                /*only_l=
ibdw_supported=3D*/true);
> +                       if (dwarf_reg > max_dwarf_reg)
> +                               max_dwarf_reg =3D dwarf_reg;
> +               }
> +       }
> +
> +       dwarf_regs =3D calloc(max_dwarf_reg + 1, sizeof(*dwarf_regs));
> +       if (!dwarf_regs)
> +               return false;
> +
> +       for (int perf_reg =3D 0; perf_reg < 64; perf_reg++) {
> +               if (user_regs->mask & (1ULL << perf_reg)) {
> +                       int dwarf_reg =3D
> +                               get_dwarf_regnum_for_perf_regnum(perf_reg=
, e_machine,
> +                                                                e_flags,
> +                                                                /*only_l=
ibdw_supported=3D*/true);
> +                       if (dwarf_reg >=3D 0) {
> +                               val =3D 0;
> +                               if (perf_reg_value(&val, user_regs, perf_=
reg) =3D=3D 0)
> +                                       dwarf_regs[dwarf_reg] =3D val;
> +                       }
> +               }
> +       }
> +       if (perf_reg_value(&val, user_regs, ip_perf_reg) =3D=3D 0)
> +               dwfl_thread_state_register_pc(thread, val);
> +
> +       ret =3D dwfl_thread_state_registers(thread, 0, max_dwarf_reg + 1,=
 dwarf_regs);

I always forget something. There's possibly a TODO/alternative here
where rather than computing the max dwarf register, copying the
registers and calling dwfl_thread_state_registers, the code could read
the register then call dwfl_thread_state_registers just for that 1
register. The code as it is here is closest to the code as it was
before the change, but removing a memory allocation/free may have some
benefit.

Thanks,
Ian

> +       free(dwarf_regs);
> +       return ret;
> +}
> +
>  #define DEFINE_DWFL_THREAD_CALLBACKS(arch)                           \
>  static const Dwfl_Thread_Callbacks callbacks_##arch =3D {              \
>         .next_thread           =3D next_thread,                        \
> @@ -232,7 +286,12 @@ static const Dwfl_Thread_Callbacks callbacks_##arch =
=3D {              \
>         .set_initial_registers =3D libdw_set_initial_registers_##arch, \
>  }
>
> -DEFINE_DWFL_THREAD_CALLBACKS(x86);
> +static const Dwfl_Thread_Callbacks callbacks_generic =3D {
> +       .next_thread           =3D next_thread,
> +       .memory_read           =3D memory_read,
> +       .set_initial_registers =3D libdw_set_initial_registers_generic,
> +};
> +
>  DEFINE_DWFL_THREAD_CALLBACKS(arm);
>  DEFINE_DWFL_THREAD_CALLBACKS(arm64);
>  DEFINE_DWFL_THREAD_CALLBACKS(csky);
> @@ -257,12 +316,8 @@ static const Dwfl_Thread_Callbacks *get_thread_callb=
acks(const char *arch)
>                 return &callbacks_riscv;
>         else if (!strcmp(arch, "s390"))
>                 return &callbacks_s390;
> -       else if (!strcmp(arch, "x86"))
> -               return &callbacks_x86;
>
> -       pr_err("Fail to get thread callbacks for arch %s, returns NULL\n"=
,
> -              arch);
> -       return NULL;
> +       return &callbacks_generic;
>  }
>
>  static int
> @@ -301,6 +356,7 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *a=
rg,
>                         bool best_effort)
>  {
>         struct machine *machine =3D maps__machine(thread__maps(thread));
> +       uint16_t e_machine =3D thread__e_machine(thread, machine);
>         struct unwind_info *ui, ui_buf =3D {
>                 .sample         =3D data,
>                 .thread         =3D thread,
> @@ -308,9 +364,9 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *a=
rg,
>                 .cb             =3D cb,
>                 .arg            =3D arg,
>                 .max_stack      =3D max_stack,
> +               .e_machine      =3D e_machine,
>                 .best_effort    =3D best_effort
>         };
> -       uint16_t e_machine =3D thread__e_machine(thread, machine);
>         const char *arch =3D perf_env__arch(machine->env);
>         Dwarf_Word ip;
>         int err =3D -EINVAL, i;
> diff --git a/tools/perf/util/unwind-libdw.h b/tools/perf/util/unwind-libd=
w.h
> index 574b29848cce..496e5898e7ef 100644
> --- a/tools/perf/util/unwind-libdw.h
> +++ b/tools/perf/util/unwind-libdw.h
> @@ -9,7 +9,6 @@ struct machine;
>  struct perf_sample;
>  struct thread;
>
> -bool libdw_set_initial_registers_x86(Dwfl_Thread *thread, void *arg);
>  bool libdw_set_initial_registers_arm(Dwfl_Thread *thread, void *arg);
>  bool libdw_set_initial_registers_arm64(Dwfl_Thread *thread, void *arg);
>  bool libdw_set_initial_registers_csky(Dwfl_Thread *thread, void *arg);
> @@ -28,6 +27,7 @@ struct unwind_info {
>         void                    *arg;
>         int                     max_stack;
>         int                     idx;
> +       uint16_t                e_machine;
>         bool                    best_effort;
>         struct unwind_entry     entries[];
>  };
> --
> 2.52.0.457.g6b5491de43-goog
>
