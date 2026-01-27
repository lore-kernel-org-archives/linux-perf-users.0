Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DB8362139
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 16:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769532902; cv=pass; b=lHWRD2ngB637CzbYL5/fBrzBepi2igCJFFAGGUkFH/+IDZJrlo//fSdHwt6v/AbOZ8FOEJmBu3JSUp09rzYx24oXRESdL05M3768vbSvVrYO1/EOV/DL3Ru4IYFh87rN2cYEgb/GPioXT4yzUf3IsuDo9JmaVuKGmKDLy+ij+M8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769532902; c=relaxed/simple;
	bh=nihNIxZ1kHEtrF5L3VAbwPeXGAMrbcgim0mw/RCkRPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elNR/kHZUl0GaGr5V0SW6EmkvTQDEOYIz1uEmMO+b2qXxTWv+hkjdzBf1e8j8PDNafDrBpkz6rhRj8EcyRHv7ywvHLfsz91XlMsvN+rp4knjsfHRpfYixFYbAW940TwxvqH4x7vw2rjQc8SqcsOZtvC6OIFjIYn0n/Xn+geN8s0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=un7dEK5D; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="un7dEK5D"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a0d06cfa93so89625ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 08:55:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769532899; cv=none;
        d=google.com; s=arc-20240605;
        b=YsmFhvMmAeOvFXWGiIoX7lXrS9kf1XMxfaNVRSY/OtPAQj7FGAn8twZKQcMLbXT+zJ
         cltt/n5dgBkZH4QgCaoMMT129u9zA5QT0HgKPxWhb0ieZE6SNkCA/3egL7sKmFFxhlYl
         biTNW5gdhrD3mJCfsHDY8b1+QCQDVT0S9Ir2xGkKEj+qA5Zy12Nktu/zVgb4eye1BVss
         tsjS/XxXTSubAII5Wj+LFI9oslcwrg0maEdohELpVCiw5Ya21QzGcm3dicCPm6lzPPPK
         xLmNZYpmMsRb1Q8rH6zHeAfxJl0WucsjFEwDZiLYreU/1nDpjgMfokVhYowRbHeBaTTX
         Blxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EoqZJbxGiyM8QC16Ea78T0gDAzuyRWpmVpSIjUw7tIg=;
        fh=O1xDfs+bqn5r75n5Rw/8qEJYHwEKbLw2BT6b86WXNbg=;
        b=Vj2QCmsqZKGKc+svee4kqsOf+2nCf9wDzjqGi6/rU64GfCviQkS9ZQ7krY4exGlvNO
         AdIB46v+ofxVk11kc/8npH+LmDpxHHyZNxInBa/AGRgddmc/hZ4X0K9XIof6t1HsT+xR
         tMeOEg+wQgc2tj7biiY5XMHSmpSh7amCdvymAddmS9T9ro3LdJdsV5P7H0uRDlWI7Na6
         xW197cwVGtCvsvvfZEenYZgfczXltJgO/fz6EkvJULQ562NRyv9QZreEOC0fwmr4LmB0
         Mb+blFhG/K/VLhVA0shGqO9PXauDpEwDLAiAAgCt6pl/g0bPynG4FqEFLcLiUV1cmSue
         VRVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769532899; x=1770137699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoqZJbxGiyM8QC16Ea78T0gDAzuyRWpmVpSIjUw7tIg=;
        b=un7dEK5DhffNM+dkN45Kw6MWMNDimUuEUq9ubYFZY6pOdANWXVjJbi4SFktacm3k6T
         VxSvN7F3LnvPtWPt1F90iPGNpF3th9zfVUYYYkYuAx+GFs9zaW6Xh9mp0IA0Eew4ZO2S
         3eHL9/UclTm0FGD8YA8I2hMWAB2xfHfh0hahAZD5SmZIOxj0YjcEImuIDN0txYxSmRgZ
         SEOx19m7uoGtU/Eh2BsJTxFE8pxDdbD5ykcPpl65g3sIr8jLBAIZMmE/0SyCFFGQxokJ
         s6z0ny1S2qkoaGmXpk6Tyw1euQ53cgk4xfprXE7S1XWG9FLoOtatjB+X0Bhm2cA41qRd
         p2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769532899; x=1770137699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EoqZJbxGiyM8QC16Ea78T0gDAzuyRWpmVpSIjUw7tIg=;
        b=ISI0wqBF+dLEKuI+1IV5IvKHj2ZZx6hhAfIa7NtocdgYiKjGH0jtSj69gG+c5CR+/H
         7zvxhVj1G6PncC6YPRc01yjhUCBgkBd7IKRZj2cZY+dARBOKtCoL4b7OwwLa2BbtW/vH
         1azoesY6JJViSgPbXJvMQg3wnBJdLtUOgzHrUBW3KGTIPbeew4nbOCDMJm2UX0bXALw0
         FRJpRml7NLoA2y4OPJcD852lBl3GIlcs/iNKxeTSyUHS7JsLORIdBfCi1+ZFCvqiWM4T
         JNx4AIbCi0/YZs0PDbMbLOk+nYjOnjXeegkYO9P8WGvOzYx990r9ENebJpBE0EhzY5M+
         ZmdA==
X-Forwarded-Encrypted: i=1; AJvYcCXIW1iYPHbNF4VecXtY75cEKLDIMwsIqYXbY7NcF+Pm2CeVAgmaTfZSwVwQ9a6rLwmBZUCycAzaJe3fFi2Y33YM@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl6kZKIRB89HtwZ33yUTgsEDfLQtw6kHM9wUQucIWPMg31u6yP
	sJWEUesdfN9HsnHhxhyefZ18hPgR7b1qWVhiedc8L+OsXmgBHF+/2+Dd1k8zsJXXB811qgd1k54
	2XPCtJIQnGKTQ2DC3NKGo6Nc0pwP2Mvs5jaG8CrN4
X-Gm-Gg: AZuq6aL+1Hg+IKBp9bziXzYyllJFO6l765RGo1SAoRSzveLNl1GibzUPfyvg7h+bq9C
	vskcFf8fwrO50ne3yLlxcz0g3clverzdhi6oD2+BB2RPQLc401kgHqAPLTNB3rK17RUwuE3yUmi
	Gfc2KidOEpfAPdUpEQhepOYpXj6jWHLNPjK6BbsGHAJhAvqPArqC9Q6EOtlOQ7rnnMRCOOw21ni
	7zeH8M0bZb8Cb+KMIAk8QSuOfS9moT5efckBFz1d69h+1SPFwO5rCZRKR4qXLKiMgunzC47b+iA
	uLjfR44pURw+5J2511H9f4NV
X-Received: by 2002:a17:903:94e:b0:291:6858:ee60 with SMTP id
 d9443c01a7336-2a8708e0198mr2329855ad.4.1769532898820; Tue, 27 Jan 2026
 08:54:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127070259.2720468-1-dapeng1.mi@linux.intel.com> <20260127070259.2720468-4-dapeng1.mi@linux.intel.com>
In-Reply-To: <20260127070259.2720468-4-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 27 Jan 2026 08:54:47 -0800
X-Gm-Features: AZwV_QjQK2UL4a6GggSJc5VtmWg4tjgQHMP67eBZAqC_BYj0oWpDnEbqBx5PWDg
Message-ID: <CAP-5=fUT3zyVW96Gd4j6jvRhM1OrMvP=-qDp_cLRMgXmoujfgQ@mail.gmail.com>
Subject: Re: [Patch v2 3/3] perf regs: Remove __weak attributive
 arch_sdt_arg_parse_op() function
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>, 
	Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 11:06=E2=80=AFPM Dapeng Mi <dapeng1.mi@linux.intel.=
com> wrote:
>
> In line with the previous patch, the __weak arch_sdt_arg_parse_op()
> function is removed. Architectural-specific implementations in the arch/
> directory are now converted into sub-functions within the
> util/perf-regs-arch/ directory. The perf_sdt_arg_parse_op() function
> will call these sub-functions based on the EM_HOST.
>
> This change enables cross-architecture calls to arch_sdt_arg_parse_op().
>
> No functional changes are intended.
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  tools/perf/arch/arm64/util/Build              |   1 -
>  tools/perf/arch/arm64/util/perf_regs.c        | 105 --------
>  tools/perf/arch/powerpc/util/Build            |   1 -
>  tools/perf/arch/powerpc/util/perf_regs.c      | 125 ----------
>  tools/perf/arch/x86/util/Build                |   1 -
>  tools/perf/arch/x86/util/perf_regs.c          | 235 ------------------
>  .../util/perf-regs-arch/perf_regs_aarch64.c   |  86 +++++++
>  .../util/perf-regs-arch/perf_regs_powerpc.c   | 106 ++++++++
>  .../perf/util/perf-regs-arch/perf_regs_x86.c  | 221 ++++++++++++++++
>  tools/perf/util/perf_regs.c                   |  23 +-
>  tools/perf/util/perf_regs.h                   |   5 +-
>  tools/perf/util/probe-file.c                  |   3 +-
>  12 files changed, 439 insertions(+), 473 deletions(-)
>  delete mode 100644 tools/perf/arch/arm64/util/perf_regs.c
>  delete mode 100644 tools/perf/arch/powerpc/util/perf_regs.c
>  delete mode 100644 tools/perf/arch/x86/util/perf_regs.c
>
> diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/uti=
l/Build
> index 0177af19cc00..bc12c35d06c8 100644
> --- a/tools/perf/arch/arm64/util/Build
> +++ b/tools/perf/arch/arm64/util/Build
> @@ -8,6 +8,5 @@ perf-util-y +=3D header.o
>  perf-util-y +=3D hisi-ptt.o
>  perf-util-y +=3D machine.o
>  perf-util-y +=3D mem-events.o
> -perf-util-y +=3D perf_regs.o
>  perf-util-y +=3D pmu.o
>  perf-util-y +=3D tsc.o
> diff --git a/tools/perf/arch/arm64/util/perf_regs.c b/tools/perf/arch/arm=
64/util/perf_regs.c
> deleted file mode 100644
> index 47f58eaba032..000000000000
> --- a/tools/perf/arch/arm64/util/perf_regs.c
> +++ /dev/null
> @@ -1,105 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <errno.h>
> -#include <regex.h>
> -#include <string.h>
> -#include <sys/auxv.h>
> -#include <linux/kernel.h>
> -#include <linux/zalloc.h>
> -
> -#include "perf_regs.h"
> -#include "../../../perf-sys.h"
> -#include "../../../util/debug.h"
> -#include "../../../util/event.h"
> -#include "../../../util/perf_regs.h"
> -
> -#define SMPL_REG_MASK(b) (1ULL << (b))
> -
> -#ifndef HWCAP_SVE
> -#define HWCAP_SVE      (1 << 22)
> -#endif
> -
> -/* %xNUM */
> -#define SDT_OP_REGEX1  "^(x[1-2]?[0-9]|3[0-1])$"
> -
> -/* [sp], [sp, NUM] */
> -#define SDT_OP_REGEX2  "^\\[sp(, )?([0-9]+)?\\]$"
> -
> -static regex_t sdt_op_regex1, sdt_op_regex2;
> -
> -static int sdt_init_op_regex(void)
> -{
> -       static int initialized;
> -       int ret =3D 0;
> -
> -       if (initialized)
> -               return 0;
> -
> -       ret =3D regcomp(&sdt_op_regex1, SDT_OP_REGEX1, REG_EXTENDED);
> -       if (ret)
> -               goto error;
> -
> -       ret =3D regcomp(&sdt_op_regex2, SDT_OP_REGEX2, REG_EXTENDED);
> -       if (ret)
> -               goto free_regex1;
> -
> -       initialized =3D 1;
> -       return 0;
> -
> -free_regex1:
> -       regfree(&sdt_op_regex1);
> -error:
> -       pr_debug4("Regex compilation error.\n");
> -       return ret;
> -}
> -
> -/*
> - * SDT marker arguments on Arm64 uses %xREG or [sp, NUM], currently
> - * support these two formats.
> - */
> -int arch_sdt_arg_parse_op(char *old_op, char **new_op)
> -{
> -       int ret, new_len;
> -       regmatch_t rm[5];
> -
> -       ret =3D sdt_init_op_regex();
> -       if (ret < 0)
> -               return ret;
> -
> -       if (!regexec(&sdt_op_regex1, old_op, 3, rm, 0)) {
> -               /* Extract xNUM */
> -               new_len =3D 2;    /* % NULL */
> -               new_len +=3D (int)(rm[1].rm_eo - rm[1].rm_so);
> -
> -               *new_op =3D zalloc(new_len);
> -               if (!*new_op)
> -                       return -ENOMEM;
> -
> -               scnprintf(*new_op, new_len, "%%%.*s",
> -                       (int)(rm[1].rm_eo - rm[1].rm_so), old_op + rm[1].=
rm_so);
> -       } else if (!regexec(&sdt_op_regex2, old_op, 5, rm, 0)) {
> -               /* [sp], [sp, NUM] or [sp,NUM] */
> -               new_len =3D 7;    /* + ( % s p ) NULL */
> -
> -               /* If the argument is [sp], need to fill offset '0' */
> -               if (rm[2].rm_so =3D=3D -1)
> -                       new_len +=3D 1;
> -               else
> -                       new_len +=3D (int)(rm[2].rm_eo - rm[2].rm_so);
> -
> -               *new_op =3D zalloc(new_len);
> -               if (!*new_op)
> -                       return -ENOMEM;
> -
> -               if (rm[2].rm_so =3D=3D -1)
> -                       scnprintf(*new_op, new_len, "+0(%%sp)");
> -               else
> -                       scnprintf(*new_op, new_len, "+%.*s(%%sp)",
> -                                 (int)(rm[2].rm_eo - rm[2].rm_so),
> -                                 old_op + rm[2].rm_so);
> -       } else {
> -               pr_debug4("Skipping unsupported SDT argument: %s\n", old_=
op);
> -               return SDT_ARG_SKIP;
> -       }
> -
> -       return SDT_ARG_VALID;
> -}
> diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc=
/util/Build
> index 5fd28ec713a4..43c3e7c450a3 100644
> --- a/tools/perf/arch/powerpc/util/Build
> +++ b/tools/perf/arch/powerpc/util/Build
> @@ -1,6 +1,5 @@
>  perf-util-y +=3D header.o
>  perf-util-$(CONFIG_LIBTRACEEVENT) +=3D kvm-stat.o
> -perf-util-y +=3D perf_regs.o
>  perf-util-y +=3D mem-events.o
>  perf-util-y +=3D pmu.o
>  perf-util-y +=3D sym-handling.o
> diff --git a/tools/perf/arch/powerpc/util/perf_regs.c b/tools/perf/arch/p=
owerpc/util/perf_regs.c
> deleted file mode 100644
> index 93f929fc32e3..000000000000
> --- a/tools/perf/arch/powerpc/util/perf_regs.c
> +++ /dev/null
> @@ -1,125 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <errno.h>
> -#include <string.h>
> -#include <regex.h>
> -#include <linux/zalloc.h>
> -
> -#include "perf_regs.h"
> -#include "../../../util/perf_regs.h"
> -#include "../../../util/debug.h"
> -#include "../../../util/event.h"
> -#include "../../../util/header.h"
> -#include "../../../perf-sys.h"
> -#include "utils_header.h"
> -
> -#include <linux/kernel.h>
> -
> -#define PVR_POWER9             0x004E
> -#define PVR_POWER10            0x0080
> -#define PVR_POWER11            0x0082
> -
> -/* REG or %rREG */
> -#define SDT_OP_REGEX1  "^(%r)?([1-2]?[0-9]|3[0-1])$"
> -
> -/* -NUM(REG) or NUM(REG) or -NUM(%rREG) or NUM(%rREG) */
> -#define SDT_OP_REGEX2  "^(\\-)?([0-9]+)\\((%r)?([1-2]?[0-9]|3[0-1])\\)$"
> -
> -static regex_t sdt_op_regex1, sdt_op_regex2;
> -
> -static int sdt_init_op_regex(void)
> -{
> -       static int initialized;
> -       int ret =3D 0;
> -
> -       if (initialized)
> -               return 0;
> -
> -       ret =3D regcomp(&sdt_op_regex1, SDT_OP_REGEX1, REG_EXTENDED);
> -       if (ret)
> -               goto error;
> -
> -       ret =3D regcomp(&sdt_op_regex2, SDT_OP_REGEX2, REG_EXTENDED);
> -       if (ret)
> -               goto free_regex1;
> -
> -       initialized =3D 1;
> -       return 0;
> -
> -free_regex1:
> -       regfree(&sdt_op_regex1);
> -error:
> -       pr_debug4("Regex compilation error.\n");
> -       return ret;
> -}
> -
> -/*
> - * Parse OP and convert it into uprobe format, which is, +/-NUM(%gprREG)=
.
> - * Possible variants of OP are:
> - *     Format          Example
> - *     -------------------------
> - *     NUM(REG)        48(18)
> - *     -NUM(REG)       -48(18)
> - *     NUM(%rREG)      48(%r18)
> - *     -NUM(%rREG)     -48(%r18)
> - *     REG             18
> - *     %rREG           %r18
> - *     iNUM            i0
> - *     i-NUM           i-1
> - *
> - * SDT marker arguments on Powerpc uses %rREG form with -mregnames flag
> - * and REG form with -mno-regnames. Here REG is general purpose register=
,
> - * which is in 0 to 31 range.
> - */
> -int arch_sdt_arg_parse_op(char *old_op, char **new_op)
> -{
> -       int ret, new_len;
> -       regmatch_t rm[5];
> -       char prefix;
> -
> -       /* Constant argument. Uprobe does not support it */
> -       if (old_op[0] =3D=3D 'i') {
> -               pr_debug4("Skipping unsupported SDT argument: %s\n", old_=
op);
> -               return SDT_ARG_SKIP;
> -       }
> -
> -       ret =3D sdt_init_op_regex();
> -       if (ret < 0)
> -               return ret;
> -
> -       if (!regexec(&sdt_op_regex1, old_op, 3, rm, 0)) {
> -               /* REG or %rREG --> %gprREG */
> -
> -               new_len =3D 5;    /* % g p r NULL */
> -               new_len +=3D (int)(rm[2].rm_eo - rm[2].rm_so);
> -
> -               *new_op =3D zalloc(new_len);
> -               if (!*new_op)
> -                       return -ENOMEM;
> -
> -               scnprintf(*new_op, new_len, "%%gpr%.*s",
> -                       (int)(rm[2].rm_eo - rm[2].rm_so), old_op + rm[2].=
rm_so);
> -       } else if (!regexec(&sdt_op_regex2, old_op, 5, rm, 0)) {
> -               /*
> -                * -NUM(REG) or NUM(REG) or -NUM(%rREG) or NUM(%rREG) -->
> -                *      +/-NUM(%gprREG)
> -                */
> -               prefix =3D (rm[1].rm_so =3D=3D -1) ? '+' : '-';
> -
> -               new_len =3D 8;    /* +/- ( % g p r ) NULL */
> -               new_len +=3D (int)(rm[2].rm_eo - rm[2].rm_so);
> -               new_len +=3D (int)(rm[4].rm_eo - rm[4].rm_so);
> -
> -               *new_op =3D zalloc(new_len);
> -               if (!*new_op)
> -                       return -ENOMEM;
> -
> -               scnprintf(*new_op, new_len, "%c%.*s(%%gpr%.*s)", prefix,
> -                       (int)(rm[2].rm_eo - rm[2].rm_so), old_op + rm[2].=
rm_so,
> -                       (int)(rm[4].rm_eo - rm[4].rm_so), old_op + rm[4].=
rm_so);
> -       } else {
> -               pr_debug4("Skipping unsupported SDT argument: %s\n", old_=
op);
> -               return SDT_ARG_SKIP;
> -       }
> -
> -       return SDT_ARG_VALID;
> -}
> diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Bu=
ild
> index fad256252bb9..b7b401cfbd45 100644
> --- a/tools/perf/arch/x86/util/Build
> +++ b/tools/perf/arch/x86/util/Build
> @@ -2,7 +2,6 @@ perf-util-y +=3D header.o
>  perf-util-y +=3D tsc.o
>  perf-util-y +=3D pmu.o
>  perf-util-$(CONFIG_LIBTRACEEVENT) +=3D kvm-stat.o
> -perf-util-y +=3D perf_regs.o
>  perf-util-y +=3D topdown.o
>  perf-util-y +=3D machine.o
>  perf-util-y +=3D event.o
> diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/u=
til/perf_regs.c
> deleted file mode 100644
> index 41141cebe226..000000000000
> --- a/tools/perf/arch/x86/util/perf_regs.c
> +++ /dev/null
> @@ -1,235 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <errno.h>
> -#include <string.h>
> -#include <regex.h>
> -#include <linux/kernel.h>
> -#include <linux/zalloc.h>
> -
> -#include "perf_regs.h"
> -#include "../../../perf-sys.h"
> -#include "../../../util/perf_regs.h"
> -#include "../../../util/debug.h"
> -#include "../../../util/event.h"
> -#include "../../../util/pmu.h"
> -#include "../../../util/pmus.h"
> -
> -struct sdt_name_reg {
> -       const char *sdt_name;
> -       const char *uprobe_name;
> -};
> -#define SDT_NAME_REG(n, m) {.sdt_name =3D "%" #n, .uprobe_name =3D "%" #=
m}
> -#define SDT_NAME_REG_END {.sdt_name =3D NULL, .uprobe_name =3D NULL}
> -
> -static const struct sdt_name_reg sdt_reg_tbl[] =3D {
> -       SDT_NAME_REG(eax, ax),
> -       SDT_NAME_REG(rax, ax),
> -       SDT_NAME_REG(al,  ax),
> -       SDT_NAME_REG(ah,  ax),
> -       SDT_NAME_REG(ebx, bx),
> -       SDT_NAME_REG(rbx, bx),
> -       SDT_NAME_REG(bl,  bx),
> -       SDT_NAME_REG(bh,  bx),
> -       SDT_NAME_REG(ecx, cx),
> -       SDT_NAME_REG(rcx, cx),
> -       SDT_NAME_REG(cl,  cx),
> -       SDT_NAME_REG(ch,  cx),
> -       SDT_NAME_REG(edx, dx),
> -       SDT_NAME_REG(rdx, dx),
> -       SDT_NAME_REG(dl,  dx),
> -       SDT_NAME_REG(dh,  dx),
> -       SDT_NAME_REG(esi, si),
> -       SDT_NAME_REG(rsi, si),
> -       SDT_NAME_REG(sil, si),
> -       SDT_NAME_REG(edi, di),
> -       SDT_NAME_REG(rdi, di),
> -       SDT_NAME_REG(dil, di),
> -       SDT_NAME_REG(ebp, bp),
> -       SDT_NAME_REG(rbp, bp),
> -       SDT_NAME_REG(bpl, bp),
> -       SDT_NAME_REG(rsp, sp),
> -       SDT_NAME_REG(esp, sp),
> -       SDT_NAME_REG(spl, sp),
> -
> -       /* rNN registers */
> -       SDT_NAME_REG(r8b,  r8),
> -       SDT_NAME_REG(r8w,  r8),
> -       SDT_NAME_REG(r8d,  r8),
> -       SDT_NAME_REG(r9b,  r9),
> -       SDT_NAME_REG(r9w,  r9),
> -       SDT_NAME_REG(r9d,  r9),
> -       SDT_NAME_REG(r10b, r10),
> -       SDT_NAME_REG(r10w, r10),
> -       SDT_NAME_REG(r10d, r10),
> -       SDT_NAME_REG(r11b, r11),
> -       SDT_NAME_REG(r11w, r11),
> -       SDT_NAME_REG(r11d, r11),
> -       SDT_NAME_REG(r12b, r12),
> -       SDT_NAME_REG(r12w, r12),
> -       SDT_NAME_REG(r12d, r12),
> -       SDT_NAME_REG(r13b, r13),
> -       SDT_NAME_REG(r13w, r13),
> -       SDT_NAME_REG(r13d, r13),
> -       SDT_NAME_REG(r14b, r14),
> -       SDT_NAME_REG(r14w, r14),
> -       SDT_NAME_REG(r14d, r14),
> -       SDT_NAME_REG(r15b, r15),
> -       SDT_NAME_REG(r15w, r15),
> -       SDT_NAME_REG(r15d, r15),
> -       SDT_NAME_REG_END,
> -};
> -
> -/*
> - * Perf only supports OP which is in  +/-NUM(REG)  form.
> - * Here plus-minus sign, NUM and parenthesis are optional,
> - * only REG is mandatory.
> - *
> - * SDT events also supports indirect addressing mode with a
> - * symbol as offset, scaled mode and constants in OP. But
> - * perf does not support them yet. Below are few examples.
> - *
> - * OP with scaled mode:
> - *     (%rax,%rsi,8)
> - *     10(%ras,%rsi,8)
> - *
> - * OP with indirect addressing mode:
> - *     check_action(%rip)
> - *     mp_+52(%rip)
> - *     44+mp_(%rip)
> - *
> - * OP with constant values:
> - *     $0
> - *     $123
> - *     $-1
> - */
> -#define SDT_OP_REGEX  "^([+\\-]?)([0-9]*)(\\(?)(%[a-z][a-z0-9]+)(\\)?)$"
> -
> -static regex_t sdt_op_regex;
> -
> -static int sdt_init_op_regex(void)
> -{
> -       static int initialized;
> -       int ret =3D 0;
> -
> -       if (initialized)
> -               return 0;
> -
> -       ret =3D regcomp(&sdt_op_regex, SDT_OP_REGEX, REG_EXTENDED);
> -       if (ret < 0) {
> -               pr_debug4("Regex compilation error.\n");
> -               return ret;
> -       }
> -
> -       initialized =3D 1;
> -       return 0;
> -}
> -
> -/*
> - * Max x86 register name length is 5(ex: %r15d). So, 6th char
> - * should always contain NULL. This helps to find register name
> - * length using strlen, instead of maintaining one more variable.
> - */
> -#define SDT_REG_NAME_SIZE  6
> -
> -/*
> - * The uprobe parser does not support all gas register names;
> - * so, we have to replace them (ex. for x86_64: %rax -> %ax).
> - * Note: If register does not require renaming, just copy
> - * paste as it is, but don't leave it empty.
> - */
> -static void sdt_rename_register(char *sdt_reg, int sdt_len, char *uprobe=
_reg)
> -{
> -       int i =3D 0;
> -
> -       for (i =3D 0; sdt_reg_tbl[i].sdt_name !=3D NULL; i++) {
> -               if (!strncmp(sdt_reg_tbl[i].sdt_name, sdt_reg, sdt_len)) =
{
> -                       strcpy(uprobe_reg, sdt_reg_tbl[i].uprobe_name);
> -                       return;
> -               }
> -       }
> -
> -       strncpy(uprobe_reg, sdt_reg, sdt_len);
> -}
> -
> -int arch_sdt_arg_parse_op(char *old_op, char **new_op)
> -{
> -       char new_reg[SDT_REG_NAME_SIZE] =3D {0};
> -       int new_len =3D 0, ret;
> -       /*
> -        * rm[0]:  +/-NUM(REG)
> -        * rm[1]:  +/-
> -        * rm[2]:  NUM
> -        * rm[3]:  (
> -        * rm[4]:  REG
> -        * rm[5]:  )
> -        */
> -       regmatch_t rm[6];
> -       /*
> -        * Max prefix length is 2 as it may contains sign(+/-)
> -        * and displacement 0 (Both sign and displacement 0 are
> -        * optional so it may be empty). Use one more character
> -        * to hold last NULL so that strlen can be used to find
> -        * prefix length, instead of maintaining one more variable.
> -        */
> -       char prefix[3] =3D {0};
> -
> -       ret =3D sdt_init_op_regex();
> -       if (ret < 0)
> -               return ret;
> -
> -       /*
> -        * If unsupported OR does not match with regex OR
> -        * register name too long, skip it.
> -        */
> -       if (strchr(old_op, ',') || strchr(old_op, '$') ||
> -           regexec(&sdt_op_regex, old_op, 6, rm, 0)   ||
> -           rm[4].rm_eo - rm[4].rm_so > SDT_REG_NAME_SIZE) {
> -               pr_debug4("Skipping unsupported SDT argument: %s\n", old_=
op);
> -               return SDT_ARG_SKIP;
> -       }
> -
> -       /*
> -        * Prepare prefix.
> -        * If SDT OP has parenthesis but does not provide
> -        * displacement, add 0 for displacement.
> -        *     SDT         Uprobe     Prefix
> -        *     -----------------------------
> -        *     +24(%rdi)   +24(%di)   +
> -        *     24(%rdi)    +24(%di)   +
> -        *     %rdi        %di
> -        *     (%rdi)      +0(%di)    +0
> -        *     -80(%rbx)   -80(%bx)   -
> -        */
> -       if (rm[3].rm_so !=3D rm[3].rm_eo) {
> -               if (rm[1].rm_so !=3D rm[1].rm_eo)
> -                       prefix[0] =3D *(old_op + rm[1].rm_so);
> -               else if (rm[2].rm_so !=3D rm[2].rm_eo)
> -                       prefix[0] =3D '+';
> -               else
> -                       scnprintf(prefix, sizeof(prefix), "+0");
> -       }
> -
> -       /* Rename register */
> -       sdt_rename_register(old_op + rm[4].rm_so, rm[4].rm_eo - rm[4].rm_=
so,
> -                           new_reg);
> -
> -       /* Prepare final OP which should be valid for uprobe_events */
> -       new_len =3D strlen(prefix)              +
> -                 (rm[2].rm_eo - rm[2].rm_so) +
> -                 (rm[3].rm_eo - rm[3].rm_so) +
> -                 strlen(new_reg)             +
> -                 (rm[5].rm_eo - rm[5].rm_so) +
> -                 1;                                    /* NULL */
> -
> -       *new_op =3D zalloc(new_len);
> -       if (!*new_op)
> -               return -ENOMEM;
> -
> -       scnprintf(*new_op, new_len, "%.*s%.*s%.*s%.*s%.*s",
> -                 strlen(prefix), prefix,
> -                 (int)(rm[2].rm_eo - rm[2].rm_so), old_op + rm[2].rm_so,
> -                 (int)(rm[3].rm_eo - rm[3].rm_so), old_op + rm[3].rm_so,
> -                 strlen(new_reg), new_reg,
> -                 (int)(rm[5].rm_eo - rm[5].rm_so), old_op + rm[5].rm_so)=
;
> -
> -       return SDT_ARG_VALID;
> -}
> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_aarch64.c b/tools/p=
erf/util/perf-regs-arch/perf_regs_aarch64.c
> index 21a432671f04..1b536c60ceb4 100644
> --- a/tools/perf/util/perf-regs-arch/perf_regs_aarch64.c
> +++ b/tools/perf/util/perf-regs-arch/perf_regs_aarch64.c
> @@ -18,6 +18,92 @@
>  #define HWCAP_SVE      (1 << 22)
>  #endif
>
> +/* %xNUM */
> +#define SDT_OP_REGEX1  "^(x[1-2]?[0-9]|3[0-1])$"
> +
> +/* [sp], [sp, NUM] */
> +#define SDT_OP_REGEX2  "^\\[sp(, )?([0-9]+)?\\]$"
> +
> +static regex_t sdt_op_regex1, sdt_op_regex2;
> +
> +static int sdt_init_op_regex(void)
> +{
> +       static int initialized;
> +       int ret =3D 0;
> +
> +       if (initialized)
> +               return 0;
> +
> +       ret =3D regcomp(&sdt_op_regex1, SDT_OP_REGEX1, REG_EXTENDED);
> +       if (ret)
> +               goto error;
> +
> +       ret =3D regcomp(&sdt_op_regex2, SDT_OP_REGEX2, REG_EXTENDED);
> +       if (ret)
> +               goto free_regex1;
> +
> +       initialized =3D 1;
> +       return 0;
> +
> +free_regex1:
> +       regfree(&sdt_op_regex1);
> +error:
> +       pr_debug4("Regex compilation error.\n");
> +       return ret;
> +}
> +
> +/*
> + * SDT marker arguments on Arm64 uses %xREG or [sp, NUM], currently
> + * support these two formats.
> + */
> +int __perf_sdt_arg_parse_op_arm64(char *old_op, char **new_op)
> +{
> +       int ret, new_len;
> +       regmatch_t rm[5];
> +
> +       ret =3D sdt_init_op_regex();
> +       if (ret < 0)
> +               return ret;
> +
> +       if (!regexec(&sdt_op_regex1, old_op, 3, rm, 0)) {
> +               /* Extract xNUM */
> +               new_len =3D 2;    /* % NULL */
> +               new_len +=3D (int)(rm[1].rm_eo - rm[1].rm_so);
> +
> +               *new_op =3D zalloc(new_len);
> +               if (!*new_op)
> +                       return -ENOMEM;
> +
> +               scnprintf(*new_op, new_len, "%%%.*s",
> +                       (int)(rm[1].rm_eo - rm[1].rm_so), old_op + rm[1].=
rm_so);
> +       } else if (!regexec(&sdt_op_regex2, old_op, 5, rm, 0)) {
> +               /* [sp], [sp, NUM] or [sp,NUM] */
> +               new_len =3D 7;    /* + ( % s p ) NULL */
> +
> +               /* If the argument is [sp], need to fill offset '0' */
> +               if (rm[2].rm_so =3D=3D -1)
> +                       new_len +=3D 1;
> +               else
> +                       new_len +=3D (int)(rm[2].rm_eo - rm[2].rm_so);
> +
> +               *new_op =3D zalloc(new_len);
> +               if (!*new_op)
> +                       return -ENOMEM;
> +
> +               if (rm[2].rm_so =3D=3D -1)
> +                       scnprintf(*new_op, new_len, "+0(%%sp)");
> +               else
> +                       scnprintf(*new_op, new_len, "+%.*s(%%sp)",
> +                                 (int)(rm[2].rm_eo - rm[2].rm_so),
> +                                 old_op + rm[2].rm_so);
> +       } else {
> +               pr_debug4("Skipping unsupported SDT argument: %s\n", old_=
op);
> +               return SDT_ARG_SKIP;
> +       }
> +
> +       return SDT_ARG_VALID;
> +}
> +
>  uint64_t __perf_reg_mask_arm64(bool intr)
>  {
>         struct perf_event_attr attr =3D {
> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_powerpc.c b/tools/p=
erf/util/perf-regs-arch/perf_regs_powerpc.c
> index 5211cc0c4e81..eb21a214990f 100644
> --- a/tools/perf/util/perf-regs-arch/perf_regs_powerpc.c
> +++ b/tools/perf/util/perf-regs-arch/perf_regs_powerpc.c
> @@ -19,6 +19,112 @@
>  #define PVR_POWER10            0x0080
>  #define PVR_POWER11            0x0082
>
> +/* REG or %rREG */
> +#define SDT_OP_REGEX1  "^(%r)?([1-2]?[0-9]|3[0-1])$"
> +
> +/* -NUM(REG) or NUM(REG) or -NUM(%rREG) or NUM(%rREG) */
> +#define SDT_OP_REGEX2  "^(\\-)?([0-9]+)\\((%r)?([1-2]?[0-9]|3[0-1])\\)$"
> +
> +static regex_t sdt_op_regex1, sdt_op_regex2;
> +
> +static int sdt_init_op_regex(void)
> +{
> +       static int initialized;
> +       int ret =3D 0;
> +
> +       if (initialized)
> +               return 0;
> +
> +       ret =3D regcomp(&sdt_op_regex1, SDT_OP_REGEX1, REG_EXTENDED);
> +       if (ret)
> +               goto error;
> +
> +       ret =3D regcomp(&sdt_op_regex2, SDT_OP_REGEX2, REG_EXTENDED);
> +       if (ret)
> +               goto free_regex1;
> +
> +       initialized =3D 1;
> +       return 0;
> +
> +free_regex1:
> +       regfree(&sdt_op_regex1);
> +error:
> +       pr_debug4("Regex compilation error.\n");
> +       return ret;
> +}
> +
> +/*
> + * Parse OP and convert it into uprobe format, which is, +/-NUM(%gprREG)=
.
> + * Possible variants of OP are:
> + *     Format          Example
> + *     -------------------------
> + *     NUM(REG)        48(18)
> + *     -NUM(REG)       -48(18)
> + *     NUM(%rREG)      48(%r18)
> + *     -NUM(%rREG)     -48(%r18)
> + *     REG             18
> + *     %rREG           %r18
> + *     iNUM            i0
> + *     i-NUM           i-1
> + *
> + * SDT marker arguments on Powerpc uses %rREG form with -mregnames flag
> + * and REG form with -mno-regnames. Here REG is general purpose register=
,
> + * which is in 0 to 31 range.

This powerpc comment looks a lot like ...

> + */
> +int __perf_sdt_arg_parse_op_powerpc(char *old_op, char **new_op)
> +{
> +       int ret, new_len;
> +       regmatch_t rm[5];
> +       char prefix;
> +
> +       /* Constant argument. Uprobe does not support it */
> +       if (old_op[0] =3D=3D 'i') {
> +               pr_debug4("Skipping unsupported SDT argument: %s\n", old_=
op);
> +               return SDT_ARG_SKIP;
> +       }
> +
> +       ret =3D sdt_init_op_regex();
> +       if (ret < 0)
> +               return ret;
> +
> +       if (!regexec(&sdt_op_regex1, old_op, 3, rm, 0)) {
> +               /* REG or %rREG --> %gprREG */
> +
> +               new_len =3D 5;    /* % g p r NULL */
> +               new_len +=3D (int)(rm[2].rm_eo - rm[2].rm_so);
> +
> +               *new_op =3D zalloc(new_len);
> +               if (!*new_op)
> +                       return -ENOMEM;
> +
> +               scnprintf(*new_op, new_len, "%%gpr%.*s",
> +                       (int)(rm[2].rm_eo - rm[2].rm_so), old_op + rm[2].=
rm_so);
> +       } else if (!regexec(&sdt_op_regex2, old_op, 5, rm, 0)) {
> +               /*
> +                * -NUM(REG) or NUM(REG) or -NUM(%rREG) or NUM(%rREG) -->
> +                *      +/-NUM(%gprREG)
> +                */
> +               prefix =3D (rm[1].rm_so =3D=3D -1) ? '+' : '-';
> +
> +               new_len =3D 8;    /* +/- ( % g p r ) NULL */
> +               new_len +=3D (int)(rm[2].rm_eo - rm[2].rm_so);
> +               new_len +=3D (int)(rm[4].rm_eo - rm[4].rm_so);
> +
> +               *new_op =3D zalloc(new_len);
> +               if (!*new_op)
> +                       return -ENOMEM;
> +
> +               scnprintf(*new_op, new_len, "%c%.*s(%%gpr%.*s)", prefix,
> +                       (int)(rm[2].rm_eo - rm[2].rm_so), old_op + rm[2].=
rm_so,
> +                       (int)(rm[4].rm_eo - rm[4].rm_so), old_op + rm[4].=
rm_so);
> +       } else {
> +               pr_debug4("Skipping unsupported SDT argument: %s\n", old_=
op);
> +               return SDT_ARG_SKIP;
> +       }
> +
> +       return SDT_ARG_VALID;
> +}
> +
>  #if defined(__powerpc64__) && defined(__powerpc__)
>  uint64_t __perf_reg_mask_powerpc(bool intr)
>  {
> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_x86.c b/tools/perf/=
util/perf-regs-arch/perf_regs_x86.c
> index d319106dc7b2..47de64d45168 100644
> --- a/tools/perf/util/perf-regs-arch/perf_regs_x86.c
> +++ b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
> @@ -14,6 +14,227 @@
>  #include "../../perf-sys.h"
>  #include "../../arch/x86/include/perf_regs.h"
>
> +struct sdt_name_reg {
> +       const char *sdt_name;
> +       const char *uprobe_name;
> +};
> +#define SDT_NAME_REG(n, m) {.sdt_name =3D "%" #n, .uprobe_name =3D "%" #=
m}
> +#define SDT_NAME_REG_END {.sdt_name =3D NULL, .uprobe_name =3D NULL}
> +
> +static const struct sdt_name_reg sdt_reg_tbl[] =3D {
> +       SDT_NAME_REG(eax, ax),
> +       SDT_NAME_REG(rax, ax),
> +       SDT_NAME_REG(al,  ax),
> +       SDT_NAME_REG(ah,  ax),
> +       SDT_NAME_REG(ebx, bx),
> +       SDT_NAME_REG(rbx, bx),
> +       SDT_NAME_REG(bl,  bx),
> +       SDT_NAME_REG(bh,  bx),
> +       SDT_NAME_REG(ecx, cx),
> +       SDT_NAME_REG(rcx, cx),
> +       SDT_NAME_REG(cl,  cx),
> +       SDT_NAME_REG(ch,  cx),
> +       SDT_NAME_REG(edx, dx),
> +       SDT_NAME_REG(rdx, dx),
> +       SDT_NAME_REG(dl,  dx),
> +       SDT_NAME_REG(dh,  dx),
> +       SDT_NAME_REG(esi, si),
> +       SDT_NAME_REG(rsi, si),
> +       SDT_NAME_REG(sil, si),
> +       SDT_NAME_REG(edi, di),
> +       SDT_NAME_REG(rdi, di),
> +       SDT_NAME_REG(dil, di),
> +       SDT_NAME_REG(ebp, bp),
> +       SDT_NAME_REG(rbp, bp),
> +       SDT_NAME_REG(bpl, bp),
> +       SDT_NAME_REG(rsp, sp),
> +       SDT_NAME_REG(esp, sp),
> +       SDT_NAME_REG(spl, sp),
> +
> +       /* rNN registers */
> +       SDT_NAME_REG(r8b,  r8),
> +       SDT_NAME_REG(r8w,  r8),
> +       SDT_NAME_REG(r8d,  r8),
> +       SDT_NAME_REG(r9b,  r9),
> +       SDT_NAME_REG(r9w,  r9),
> +       SDT_NAME_REG(r9d,  r9),
> +       SDT_NAME_REG(r10b, r10),
> +       SDT_NAME_REG(r10w, r10),
> +       SDT_NAME_REG(r10d, r10),
> +       SDT_NAME_REG(r11b, r11),
> +       SDT_NAME_REG(r11w, r11),
> +       SDT_NAME_REG(r11d, r11),
> +       SDT_NAME_REG(r12b, r12),
> +       SDT_NAME_REG(r12w, r12),
> +       SDT_NAME_REG(r12d, r12),
> +       SDT_NAME_REG(r13b, r13),
> +       SDT_NAME_REG(r13w, r13),
> +       SDT_NAME_REG(r13d, r13),
> +       SDT_NAME_REG(r14b, r14),
> +       SDT_NAME_REG(r14w, r14),
> +       SDT_NAME_REG(r14d, r14),
> +       SDT_NAME_REG(r15b, r15),
> +       SDT_NAME_REG(r15w, r15),
> +       SDT_NAME_REG(r15d, r15),
> +       SDT_NAME_REG_END,
> +};
> +
> +/*
> + * Perf only supports OP which is in  +/-NUM(REG)  form.
> + * Here plus-minus sign, NUM and parenthesis are optional,
> + * only REG is mandatory.
> + *
> + * SDT events also supports indirect addressing mode with a
> + * symbol as offset, scaled mode and constants in OP. But
> + * perf does not support them yet. Below are few examples.
> + *
> + * OP with scaled mode:
> + *     (%rax,%rsi,8)
> + *     10(%ras,%rsi,8)
> + *
> + * OP with indirect addressing mode:
> + *     check_action(%rip)
> + *     mp_+52(%rip)
> + *     44+mp_(%rip)
> + *
> + * OP with constant values:
> + *     $0
> + *     $123
> + *     $-1
> + */
> +#define SDT_OP_REGEX  "^([+\\-]?)([0-9]*)(\\(?)(%[a-z][a-z0-9]+)(\\)?)$"
> +
> +static regex_t sdt_op_regex;
> +
> +static int sdt_init_op_regex(void)
> +{
> +       static int initialized;
> +       int ret =3D 0;
> +
> +       if (initialized)
> +               return 0;
> +
> +       ret =3D regcomp(&sdt_op_regex, SDT_OP_REGEX, REG_EXTENDED);
> +       if (ret < 0) {
> +               pr_debug4("Regex compilation error.\n");
> +               return ret;
> +       }
> +
> +       initialized =3D 1;
> +       return 0;
> +}
> +
> +/*
> + * Max x86 register name length is 5(ex: %r15d). So, 6th char
> + * should always contain NULL. This helps to find register name
> + * length using strlen, instead of maintaining one more variable.
> + */
> +#define SDT_REG_NAME_SIZE  6
> +
> +/*
> + * The uprobe parser does not support all gas register names;
> + * so, we have to replace them (ex. for x86_64: %rax -> %ax).
> + * Note: If register does not require renaming, just copy
> + * paste as it is, but don't leave it empty.
> + */
> +static void sdt_rename_register(char *sdt_reg, int sdt_len, char *uprobe=
_reg)
> +{
> +       int i =3D 0;
> +
> +       for (i =3D 0; sdt_reg_tbl[i].sdt_name !=3D NULL; i++) {
> +               if (!strncmp(sdt_reg_tbl[i].sdt_name, sdt_reg, sdt_len)) =
{
> +                       strcpy(uprobe_reg, sdt_reg_tbl[i].uprobe_name);
> +                       return;
> +               }
> +       }
> +
> +       strncpy(uprobe_reg, sdt_reg, sdt_len);
> +}
> +
> +int __perf_sdt_arg_parse_op_x86(char *old_op, char **new_op)
> +{
> +       char new_reg[SDT_REG_NAME_SIZE] =3D {0};
> +       int new_len =3D 0, ret;
> +       /*
> +        * rm[0]:  +/-NUM(REG)
> +        * rm[1]:  +/-
> +        * rm[2]:  NUM
> +        * rm[3]:  (
> +        * rm[4]:  REG
> +        * rm[5]:  )
> +        */
> +       regmatch_t rm[6];
> +       /*
> +        * Max prefix length is 2 as it may contains sign(+/-)
> +        * and displacement 0 (Both sign and displacement 0 are
> +        * optional so it may be empty). Use one more character
> +        * to hold last NULL so that strlen can be used to find
> +        * prefix length, instead of maintaining one more variable.
> +        */
> +       char prefix[3] =3D {0};
> +
> +       ret =3D sdt_init_op_regex();
> +       if (ret < 0)
> +               return ret;
> +
> +       /*
> +        * If unsupported OR does not match with regex OR
> +        * register name too long, skip it.
> +        */
> +       if (strchr(old_op, ',') || strchr(old_op, '$') ||
> +           regexec(&sdt_op_regex, old_op, 6, rm, 0)   ||
> +           rm[4].rm_eo - rm[4].rm_so > SDT_REG_NAME_SIZE) {
> +               pr_debug4("Skipping unsupported SDT argument: %s\n", old_=
op);
> +               return SDT_ARG_SKIP;
> +       }
> +
> +       /*
> +        * Prepare prefix.
> +        * If SDT OP has parenthesis but does not provide
> +        * displacement, add 0 for displacement.
> +        *     SDT         Uprobe     Prefix
> +        *     -----------------------------
> +        *     +24(%rdi)   +24(%di)   +
> +        *     24(%rdi)    +24(%di)   +
> +        *     %rdi        %di
> +        *     (%rdi)      +0(%di)    +0
> +        *     -80(%rbx)   -80(%bx)   -
> +        */

... this x86 comment. I wonder if we had standard functions like
sdt_reg_name or uprobe_reg_name, similar to  perf_reg_name, and maybe
that perf_reg_name was the default when an ELF machine isn't
implemented, whether we could make this code shared and support more
than just arm64, powerpc and x86.

Again this is likely follow up clean up.

> +       if (rm[3].rm_so !=3D rm[3].rm_eo) {
> +               if (rm[1].rm_so !=3D rm[1].rm_eo)
> +                       prefix[0] =3D *(old_op + rm[1].rm_so);
> +               else if (rm[2].rm_so !=3D rm[2].rm_eo)
> +                       prefix[0] =3D '+';
> +               else
> +                       scnprintf(prefix, sizeof(prefix), "+0");
> +       }
> +
> +       /* Rename register */
> +       sdt_rename_register(old_op + rm[4].rm_so, rm[4].rm_eo - rm[4].rm_=
so,
> +                           new_reg);
> +
> +       /* Prepare final OP which should be valid for uprobe_events */
> +       new_len =3D strlen(prefix)              +
> +                 (rm[2].rm_eo - rm[2].rm_so) +
> +                 (rm[3].rm_eo - rm[3].rm_so) +
> +                 strlen(new_reg)             +
> +                 (rm[5].rm_eo - rm[5].rm_so) +
> +                 1;                                    /* NULL */
> +
> +       *new_op =3D zalloc(new_len);
> +       if (!*new_op)
> +               return -ENOMEM;
> +
> +       scnprintf(*new_op, new_len, "%.*s%.*s%.*s%.*s%.*s",
> +                 strlen(prefix), prefix,
> +                 (int)(rm[2].rm_eo - rm[2].rm_so), old_op + rm[2].rm_so,
> +                 (int)(rm[3].rm_eo - rm[3].rm_so), old_op + rm[3].rm_so,
> +                 strlen(new_reg), new_reg,
> +                 (int)(rm[5].rm_eo - rm[5].rm_so), old_op + rm[5].rm_so)=
;
> +
> +       return SDT_ARG_VALID;
> +}
> +
>  uint64_t __perf_reg_mask_x86(bool intr)
>  {
>         struct perf_event_attr attr =3D {
> diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
> index 900929cff4b5..4082e8da9633 100644
> --- a/tools/perf/util/perf_regs.c
> +++ b/tools/perf/util/perf_regs.c
> @@ -7,10 +7,27 @@
>  #include "debug.h"
>  #include "dwarf-regs.h"
>
> -int __weak arch_sdt_arg_parse_op(char *old_op __maybe_unused,
> -                                char **new_op __maybe_unused)
> +int perf_sdt_arg_parse_op(uint16_t e_machine, char *old_op, char **new_o=
p)
>  {
> -       return SDT_ARG_SKIP;
> +       int ret =3D SDT_ARG_SKIP;
> +
> +       switch (e_machine) {
> +       case EM_AARCH64:
> +               ret =3D __perf_sdt_arg_parse_op_arm64(old_op, new_op);
> +               break;
> +       case EM_PPC:
> +       case EM_PPC64:
> +               ret =3D __perf_sdt_arg_parse_op_powerpc(old_op, new_op);
> +               break;
> +       case EM_386:
> +       case EM_X86_64:
> +               ret =3D __perf_sdt_arg_parse_op_x86(old_op, new_op);
> +               break;
> +       default:

I think there should be at least a debug warning here.

Thanks!
Ian

> +               break;
> +       }
> +
> +       return ret;
>  }
>
>  uint64_t perf_intr_reg_mask(uint16_t e_machine)
> diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
> index 8531584bc1b1..77c0b517b94a 100644
> --- a/tools/perf/util/perf_regs.h
> +++ b/tools/perf/util/perf_regs.h
> @@ -12,7 +12,7 @@ enum {
>         SDT_ARG_SKIP,
>  };
>
> -int arch_sdt_arg_parse_op(char *old_op, char **new_op);
> +int perf_sdt_arg_parse_op(uint16_t e_machine, char *old_op, char **new_o=
p);
>  uint64_t perf_intr_reg_mask(uint16_t e_machine);
>  uint64_t perf_user_reg_mask(uint16_t e_machine);
>
> @@ -21,6 +21,7 @@ int perf_reg_value(u64 *valp, struct regs_dump *regs, i=
nt id);
>  uint64_t perf_arch_reg_ip(uint16_t e_machine);
>  uint64_t perf_arch_reg_sp(uint16_t e_machine);
>
> +int __perf_sdt_arg_parse_op_arm64(char *old_op, char **new_op);
>  uint64_t __perf_reg_mask_arm64(bool intr);
>  const char *__perf_reg_name_arm64(int id);
>  uint64_t __perf_reg_ip_arm64(void);
> @@ -46,6 +47,7 @@ const char *__perf_reg_name_mips(int id);
>  uint64_t __perf_reg_ip_mips(void);
>  uint64_t __perf_reg_sp_mips(void);
>
> +int __perf_sdt_arg_parse_op_powerpc(char *old_op, char **new_op);
>  uint64_t __perf_reg_mask_powerpc(bool intr);
>  const char *__perf_reg_name_powerpc(int id);
>  uint64_t __perf_reg_ip_powerpc(void);
> @@ -61,6 +63,7 @@ const char *__perf_reg_name_s390(int id);
>  uint64_t __perf_reg_ip_s390(void);
>  uint64_t __perf_reg_sp_s390(void);
>
> +int __perf_sdt_arg_parse_op_x86(char *old_op, char **new_op);
>  uint64_t __perf_reg_mask_x86(bool intr);
>  const char *__perf_reg_name_x86(int id);
>  uint64_t __perf_reg_ip_x86(void);
> diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
> index 5069fb61f48c..f78c3bc3d601 100644
> --- a/tools/perf/util/probe-file.c
> +++ b/tools/perf/util/probe-file.c
> @@ -28,6 +28,7 @@
>  #include "session.h"
>  #include "perf_regs.h"
>  #include "string2.h"
> +#include "dwarf-regs.h"
>
>  /* 4096 - 2 ('\n' + '\0') */
>  #define MAX_CMDLEN 4094
> @@ -784,7 +785,7 @@ static int synthesize_sdt_probe_arg(struct strbuf *bu=
f, int i, const char *arg)
>                 op =3D desc;
>         }
>
> -       ret =3D arch_sdt_arg_parse_op(op, &new_op);
> +       ret =3D perf_sdt_arg_parse_op(EM_HOST, op, &new_op);
>
>         if (ret < 0)
>                 goto error;
> --
> 2.34.1
>
