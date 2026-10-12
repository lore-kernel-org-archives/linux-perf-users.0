Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33DB4C2257
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 17:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826658; cv=pass; b=UWLlKLmCv2eNk60BxJW+spfuhq9n/lHXp29s2rq+7kd2GjsxYk/e8YUJSqnFcLh4UmLDaxJZtEykVKm2mkG+eXPUA6rwNNE9fBT198bDb4Xeo6Wi6k1Q/W8I7YqRGw8JbQ5HcIWQwKl9yOZsKQXXRJfK62qXYjGBiIsi/38zIog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826658; c=relaxed/simple;
	bh=1N5n/3zz0Zjp7sSY6i6LkRUv7L4iz47nLVlNIW4/+SQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q11gygTRb1tAWruc80juHaYOIGzRgM9hnFJ6mfBNqEyUUNQklIqe2ITNKFr15yu+lGbGwkG5vmRthJkIB6Tp5Wscnn5bxsvdx3SKuzYyDBrMyq1M35b/h90gjCp892H4wvmamvKkHZ47WslQ6/PPer2iFqGHoZmPQ8+m+C4ssgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUUSbhQu; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUUSbhQu"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b1aa27963eso1652598a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 10:37:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791826654; cv=none;
        d=google.com; s=arc-20260327;
        b=fvzIE6qwXL0bWeDJQaHTrvvAkvoEsLJbs1yeacCuQFDTIWL2Qy7q207qArZ/d4lsr/
         ycerFbuVWsPed/995vRlu2iwGqG30+f7BbnvHc66VMrw/4p1KivAaINQsv6RerJnqfHv
         ywRmmBVMosatwe28vWa/uaVOkoWMHXU90OZeLg4HSiDcviTClF1jljcEQyt0AXBXTPik
         Z4w2GKuEf/LmUsDTY3VwMNmQ2mCrvfpMI5+FgIs2r8Tlj/Zr++wz/90Ofk11pOz2KyOL
         hxr7bXCvxtY/tOVZqGrQonwEJyUHPZ/4mQV26xdfSowngdqvH6K6dsztxmLeXhtlAG0H
         5LhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6oJugGejJ2qNu0yOjeAxPdT/Eyn7Sp/D3cJTxP3vaC8=;
        fh=YQ+1sxKK2M/1rHMgHq0Hm4xb+LUHDOPgMTe6wC9DEQQ=;
        b=dCOlL5ckoaP4rWN5/o0hoI2TaNiBXmsBCQDU5nkiVC4ijOCcamc1pD7KMuhHzjm7xI
         Zd83h7lBOeJaVUAHgXPUjxXeAUdYLWz0nPuStV4eXs5XJrr/NmcI6fsJhBfk2b+JQHxy
         Lh58aI5mmpvlEJ8jRoP76ZvXtnkkTDmor6QFQ4U0DtUlGJB/rbO+N5a0GCpmOy+kES64
         gjNxzR+3o8TfbvuwJvZ9Nr/EYzxStOdAJ6IoxYwHRyWBy0d0jjUO8n1FPwP3ibYglwao
         hktQqgtkVRwh/soLGZ33uFaReTfuy2bC3R0pB5P9z7+whdZF9uPRXro5lRaEZQwJgslm
         dr5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791826654; x=1792431454; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6oJugGejJ2qNu0yOjeAxPdT/Eyn7Sp/D3cJTxP3vaC8=;
        b=JUUSbhQuZ/p3RWcMjlBJEWP8NcIzr7ZvT6w367GYmbwsEhGYPKiVuEQwLBxaCpedkv
         AQYAo+Cz1qynQISoe9XYwD3+hXhMwzuqpfZM6FUEqC9XznLX663lMai9cb95ySlkb8hG
         x/PbcjV7SQizXVJNYHpkRdjfAzXupMWvccAWTL/+0OWKoBh7rD3SHXQrUnK0DFuSN5/q
         j3Z3O2og+SXu6MsTsMwhvK8XqSvm/iiu9UBD3zELvu6M1USnK3mBEOxm2/TMXM4CBU0M
         SwIz4aSmxdxsoY9w+bmYaVfi9MpSRPq/gOrJrRouZe9wBrjHNhuBbhubBmBPt3GIiZkX
         t1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791826654; x=1792431454;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6oJugGejJ2qNu0yOjeAxPdT/Eyn7Sp/D3cJTxP3vaC8=;
        b=MOo8QmD2UbAQho3W05fvbOSIBonzNqXYZ9d23dzjO6w8F+UzDqR81s5OOOgL7CCDWU
         Bf9c2NOVyYCULkaLGJT+3m4Yg2Bb+saVtUi091c4KQBLparLq95X3TTiBTA5fT3SmwG2
         1IeLXhEa/ueDyarjiVnvSQkwf5h9shN1hWbxblKhzzpC0urTfxiLvTl3arKONXOI3lBj
         ouU6A1dis3ISQ0vJCPiYxyf/2C4PwuvRS0mtYK+lSrkK0YLrA9GYjSVjaM3FhRyEn+Nb
         uZXQYvQNSK2TBf7U9cX7CuaqAXOUhh0Yt/iJiGG9t4+xdw6bt0Z+8YB9gNZeZrTBHakm
         1naw==
X-Forwarded-Encrypted: i=1; AKwUvBz4wqseKQ4/AZWhXOKey7i/cX43VVw9CQ/atQqeJMmYAx2HTbON2fZMt3VP3L3PzeHzW/pLWrvWdkNCO6h6Kly8@vger.kernel.org
X-Gm-Message-State: AFq9FYLnCmrzwLN8QjmnqbjP+snV3+zXZnNzujzrhI3ld3EYIEJKDdr1
	Je5IcTMhJeZUFbTQUH+080huZTdP1D/7Zgp5JbdmI9f/YRagf3O6z9z6p1sBCAr+uQTSIAeuEcu
	eW4EAj29vml189eF9bTnaw7MibNOh8Do=
X-Gm-Gg: AYBFou0UXB0N7nZ0re9ILwfHgCaiM1PP1vnWiestfl8/p1B0PTnj6Xtk/XM/P1Fx/jB
	D4XFb4dQ7EyYO0sUoMnW7jKsYIScsSKAtl/OU8rRa+QKnfFvmDyjIjUhu13xrWvqdf6FMVD7tKc
	wuxa88oZ3cy2kVEv85/nAOssLIUv5fDP1tyLIxph77u8/RbRlgEDInwg2GbdFW+64T6aOdqi7Yw
	qRp2jKwaMFas12FGRY+m6yrly7wXZP8xc2F2yz61AWQHPN0id51Xv9nVd50JX4O3mx7RHgyt87H
	dEFkjeNJqC4RyopJSOKG46qys25UcTUJMrYuTuZDK19mn2N6ufTm0kws6zA9lgB0U7L2gPLw7s5
	unWKOfXU3WXwvgWYJpwFFC1HBnkZDCWmdSQ78BDxoVj7lq63eSMZg
X-Received: by 2002:a17:907:3f10:b0:c2e:204d:9490 with SMTP id
 a640c23a62f3a-c31a704c117mr1087014266b.17.1791826653858; Mon, 12 Oct 2026
 10:37:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011-alpha-perf-tools-regs-v1-1-2a5940e22548@gmail.com>
In-Reply-To: <20261011-alpha-perf-tools-regs-v1-1-2a5940e22548@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 12 Oct 2026 19:37:22 +0200
X-Gm-Features: AclHuK9g9AjouZu8VFnD7j552Sv2MfVOhv4e0ioBX4Vimz9VINM2CAtbUgrfDCc
Message-ID: <CA+=Fv5SDnzQQDzyhaQ37kWJMjTOHP0NHuAS6kJHwT8_Zqyjd-w@mail.gmail.com>
Subject: Re: [PATCH] perf regs: Add alpha support
To: Matt Turner <mattst88@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Sun, Oct 11, 2026 at 10:37=E2=80=AFPM Matt Turner <mattst88@gmail.com> w=
rote:
>
> Add the alpha perf register tables so that -I/--user-regs and
> --call-graph dwarf work.
>
> r9-r15 cannot be sampled and are left out of the mask. Perf register
> numbers 0-30 are the DWARF numbers. The pc is DWARF 64, the column GCC
> uses as the alternate return address column on alpha, so libdw's
> frame_nregs is 65.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
> This depends on the kernel side, "alpha: add HAVE_PERF_REGS and
> HAVE_PERF_USER_STACK_DUMP support", posted as part of:
>
> https://lore.kernel.org/r/20261011-alpha-perf-regs-v3-v1-0-3354d135d972@g=
mail.com
>
> --call-graph dwarf also needs libdw alpha unwinding support (abi_cfi
> and frame_nregs), which I am sending to elfutils-devel separately.
> Without it, libdw rejects the thread and perf reports the error;
> -I/--user-regs work regardless.
> ---
>  tools/arch/alpha/include/uapi/asm/perf_regs.h      | 45 ++++++++++++++++=
++++++
>  tools/perf/arch/alpha/include/perf_regs.h          | 16 ++++++++
>  tools/perf/check-headers.sh                        |  1 +
>  tools/perf/util/dwarf-regs-arch/Build              |  1 +
>  tools/perf/util/dwarf-regs-arch/dwarf-regs-alpha.c | 14 +++++++
>  tools/perf/util/dwarf-regs.c                       |  5 +++
>  tools/perf/util/include/dwarf-regs.h               |  2 +
>  tools/perf/util/perf-regs-arch/Build               |  1 +
>  tools/perf/util/perf-regs-arch/perf_regs_alpha.c   | 34 ++++++++++++++++
>  tools/perf/util/perf_regs.c                        | 13 +++++++
>  tools/perf/util/perf_regs.h                        |  5 +++
>  11 files changed, 137 insertions(+)
>
> diff --git a/tools/arch/alpha/include/uapi/asm/perf_regs.h b/tools/arch/a=
lpha/include/uapi/asm/perf_regs.h
> new file mode 100644
> index 000000000000..da96a31b12fb
> --- /dev/null
> +++ b/tools/arch/alpha/include/uapi/asm/perf_regs.h
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
> diff --git a/tools/perf/arch/alpha/include/perf_regs.h b/tools/perf/arch/=
alpha/include/perf_regs.h
> new file mode 100644
> index 000000000000..409f3a08af9b
> --- /dev/null
> +++ b/tools/perf/arch/alpha/include/perf_regs.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef ARCH_PERF_REGS_H
> +#define ARCH_PERF_REGS_H
> +
> +#include <stdlib.h>
> +#include <linux/types.h>
> +#include <linux/bits.h>
> +#include "../../../../arch/alpha/include/uapi/asm/perf_regs.h"
> +
> +#define PERF_REGS_MAX PERF_REG_ALPHA_MAX
> +
> +/* The kernel rejects r9-r15. */
> +#define PERF_REGS_MASK (GENMASK_ULL(PERF_REG_ALPHA_MAX - 1, 0) & \
> +                       ~GENMASK_ULL(PERF_REG_ALPHA_R15, PERF_REG_ALPHA_R=
9))
> +
> +#endif /* ARCH_PERF_REGS_H */
> diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> index 531c0e0e84df..9baf83f79e23 100755
> --- a/tools/perf/check-headers.sh
> +++ b/tools/perf/check-headers.sh
> @@ -36,6 +36,7 @@ declare -a FILES=3D(
>    "arch/x86/include/asm/msr-index.h"
>    "arch/x86/lib/x86-opcode-map.txt"
>    "arch/x86/tools/gen-insn-attr-x86.awk"
> +  "arch/alpha/include/uapi/asm/perf_regs.h"
>    "arch/arm/include/uapi/asm/perf_regs.h"
>    "arch/arm64/include/uapi/asm/perf_regs.h"
>    "arch/loongarch/include/uapi/asm/perf_regs.h"
> diff --git a/tools/perf/util/dwarf-regs-arch/Build b/tools/perf/util/dwar=
f-regs-arch/Build
> index ceb68ae86fd8..026b7b5ca895 100644
> --- a/tools/perf/util/dwarf-regs-arch/Build
> +++ b/tools/perf/util/dwarf-regs-arch/Build
> @@ -1,3 +1,4 @@
> +perf-util-$(CONFIG_LIBDW) +=3D dwarf-regs-alpha.o
>  perf-util-$(CONFIG_LIBDW) +=3D dwarf-regs-arm64.o
>  perf-util-$(CONFIG_LIBDW) +=3D dwarf-regs-arm.o
>  perf-util-$(CONFIG_LIBDW) +=3D dwarf-regs-csky.o
> diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-alpha.c b/tools/p=
erf/util/dwarf-regs-arch/dwarf-regs-alpha.c
> new file mode 100644
> index 000000000000..50fd17096597
> --- /dev/null
> +++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-alpha.c
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <errno.h>
> +#include <dwarf-regs.h>
> +#include "../../../arch/alpha/include/uapi/asm/perf_regs.h"
> +
> +int __get_dwarf_regnum_for_perf_regnum_alpha(int perf_regnum)
> +{
> +       if (perf_regnum >=3D PERF_REG_ALPHA_R0 && perf_regnum <=3D PERF_R=
EG_ALPHA_SP)
> +               return perf_regnum;
> +       if (perf_regnum =3D=3D PERF_REG_ALPHA_PC)
> +               return 64;
> +
> +       return -ENOENT;
> +}
> diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
> index 09aca6304002..3fd71787c658 100644
> --- a/tools/perf/util/dwarf-regs.c
> +++ b/tools/perf/util/dwarf-regs.c
> @@ -185,6 +185,8 @@ static int get_libdw_frame_nregs(unsigned int machine=
, unsigned int flags __mayb
>                 return 74;
>         case EM_MIPS:
>                 return 71;
> +       case EM_ALPHA:
> +               return 65;
>         default:
>                 return 0;
>         }
> @@ -228,6 +230,9 @@ int get_dwarf_regnum_for_perf_regnum(int perf_regnum,=
 unsigned int machine,
>         case EM_MIPS:
>                 reg =3D __get_dwarf_regnum_for_perf_regnum_mips(perf_regn=
um);
>                 break;
> +       case EM_ALPHA:
> +               reg =3D __get_dwarf_regnum_for_perf_regnum_alpha(perf_reg=
num);
> +               break;
>         default:
>                 pr_err("ELF MACHINE %x is not supported.\n", machine);
>                 return -ENOENT;
> diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/inclu=
de/dwarf-regs.h
> index 1da915c2683a..8d1a981ab8aa 100644
> --- a/tools/perf/util/include/dwarf-regs.h
> +++ b/tools/perf/util/include/dwarf-regs.h
> @@ -105,6 +105,8 @@ int __get_dwarf_regnum_x86_64(const char *name);
>  int __get_dwarf_regnum_for_perf_regnum_i386(int perf_regnum);
>  int __get_dwarf_regnum_for_perf_regnum_x86_64(int perf_regnum, int abi);
>
> +int __get_dwarf_regnum_for_perf_regnum_alpha(int perf_regnum);
> +
>  int __get_dwarf_regnum_arm64(const char *name);
>  int __get_dwarf_regnum_for_perf_regnum_arm(int perf_regnum);
>  int __get_dwarf_regnum_for_perf_regnum_arm64(int perf_regnum);
> diff --git a/tools/perf/util/perf-regs-arch/Build b/tools/perf/util/perf-=
regs-arch/Build
> index be95402aa540..1fbc299775f7 100644
> --- a/tools/perf/util/perf-regs-arch/Build
> +++ b/tools/perf/util/perf-regs-arch/Build
> @@ -1,4 +1,5 @@
>  perf-util-y +=3D perf_regs_aarch64.o
> +perf-util-y +=3D perf_regs_alpha.o
>  perf-util-y +=3D perf_regs_arm.o
>  perf-util-y +=3D perf_regs_csky.o
>  perf-util-y +=3D perf_regs_loongarch.o
> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_alpha.c b/tools/per=
f/util/perf-regs-arch/perf_regs_alpha.c
> new file mode 100644
> index 000000000000..cb9c8a1cd74b
> --- /dev/null
> +++ b/tools/perf/util/perf-regs-arch/perf_regs_alpha.c
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "../perf_regs.h"
> +#include "../../arch/alpha/include/perf_regs.h"
> +
> +static const char * const alpha_reg_names[PERF_REG_ALPHA_MAX] =3D {
> +       "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
> +       "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15",
> +       "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
> +       "r24", "r25", "r26", "r27", "r28", "gp", "sp", "pc",
> +};
> +
> +uint64_t __perf_reg_mask_alpha(bool intr __maybe_unused)
> +{
> +       return PERF_REGS_MASK;
> +}
> +
> +const char *__perf_reg_name_alpha(int id)
> +{
> +       if (id < 0 || id >=3D PERF_REG_ALPHA_MAX)
> +               return NULL;
> +
> +       return alpha_reg_names[id];
> +}
> +
> +uint64_t __perf_reg_ip_alpha(void)
> +{
> +       return PERF_REG_ALPHA_PC;
> +}
> +
> +uint64_t __perf_reg_sp_alpha(void)
> +{
> +       return PERF_REG_ALPHA_SP;
> +}
> diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
> index c8242b7e1db5..6eb5824f5521 100644
> --- a/tools/perf/util/perf_regs.c
> +++ b/tools/perf/util/perf_regs.c
> @@ -43,6 +43,9 @@ uint64_t perf_intr_reg_mask(uint16_t e_machine, int *ab=
i /*inout*/)
>         uint64_t mask =3D 0;
>
>         switch (e_machine) {
> +       case EM_ALPHA:
> +               mask =3D __perf_reg_mask_alpha(/*intr=3D*/true);
> +               break;
>         case EM_ARM:
>                 mask =3D __perf_reg_mask_arm(/*intr=3D*/true);
>                 break;
> @@ -86,6 +89,9 @@ uint64_t perf_user_reg_mask(uint16_t e_machine, int *ab=
i /*inout*/)
>         uint64_t mask =3D 0;
>
>         switch (e_machine) {
> +       case EM_ALPHA:
> +               mask =3D __perf_reg_mask_alpha(/*intr=3D*/false);
> +               break;
>         case EM_ARM:
>                 mask =3D __perf_reg_mask_arm(/*intr=3D*/false);
>                 break;
> @@ -129,6 +135,9 @@ const char *perf_reg_name(int id, uint16_t e_machine,=
 uint32_t e_flags, int abi)
>         const char *reg_name =3D NULL;
>
>         switch (e_machine) {
> +       case EM_ALPHA:
> +               reg_name =3D __perf_reg_name_alpha(id);
> +               break;
>         case EM_ARM:
>                 reg_name =3D __perf_reg_name_arm(id);
>                 break;
> @@ -198,6 +207,8 @@ int perf_reg_value(u64 *valp, struct regs_dump *regs,=
 int id)
>  uint64_t perf_arch_reg_ip(uint16_t e_machine)
>  {
>         switch (e_machine) {
> +       case EM_ALPHA:
> +               return __perf_reg_ip_alpha();
>         case EM_ARM:
>                 return __perf_reg_ip_arm();
>         case EM_AARCH64:
> @@ -227,6 +238,8 @@ uint64_t perf_arch_reg_ip(uint16_t e_machine)
>  uint64_t perf_arch_reg_sp(uint16_t e_machine)
>  {
>         switch (e_machine) {
> +       case EM_ALPHA:
> +               return __perf_reg_sp_alpha();
>         case EM_ARM:
>                 return __perf_reg_sp_arm();
>         case EM_AARCH64:
> diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
> index c9f461b6f11f..4134e4eed802 100644
> --- a/tools/perf/util/perf_regs.h
> +++ b/tools/perf/util/perf_regs.h
> @@ -34,6 +34,11 @@ const char *__perf_reg_name_arm64(int id);
>  uint64_t __perf_reg_ip_arm64(void);
>  uint64_t __perf_reg_sp_arm64(void);
>
> +uint64_t __perf_reg_mask_alpha(bool intr);
> +const char *__perf_reg_name_alpha(int id);
> +uint64_t __perf_reg_ip_alpha(void);
> +uint64_t __perf_reg_sp_alpha(void);
> +
>  uint64_t __perf_reg_mask_arm(bool intr);
>  const char *__perf_reg_name_arm(int id);
>  uint64_t __perf_reg_ip_arm(void);
>
> ---
> base-commit: bc01105ed65d15787b2eb93ac26e8624a2139e35
> change-id: 20261001-alpha-perf-tools-regs-c206a84dec7f
>
> Best regards,
> --
> Matt Turner <mattst88@gmail.com>
>

Thanks for doing this!

Register selection, recording, decoding and user stack dumps tested
on my ES40. End-to-end DWARF unwinding remains unverified because the
installed elfutils 0.195 lacks Alpha unwinding support.

Tested-by: Magnus Lindholm <linmag7@gmail.com>
