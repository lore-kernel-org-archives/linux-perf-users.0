Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF5C2FF14C
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Feb 2026 23:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770160138; cv=pass; b=Qa6YD6RniYcS+DEKq6iW1NF2nVjLpkkNpoa3LsK4EwEdWhMRczdVgSWKMNodJdC7dHLYkMi/ZHxIeKhdA+LtVxS5KIVIydO6YEsvcsO3UveaVsV5zQmT2LeBiCsJNWI4OKAFnqVnmNZtPeTiGH+iQR5vBYEA6JDffpFCs23Oans=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770160138; c=relaxed/simple;
	bh=qx0tqvcwUUMob7KNupTP11AK5KZhBZq/wgLokmiVzCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ocLL+79I6ZBDeVtF3fwYrwEIkJNCA490s890wG513NFqCOO+9sT8c/ZCw0xbWBuAPCVZZ+q/LwoKZZBXBJI2aVUfIZK3lg9HqjOp3ZTDo3pDwQnr+IjzmQ4gOwOBdJ6qtsoinNhBHbPcD32I4hT1fe3Wihju0ZIPS/LI9pfgOCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VzbO531z; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VzbO531z"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a8e4ae61a0so11255ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Feb 2026 15:08:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770160135; cv=none;
        d=google.com; s=arc-20240605;
        b=Oq2zzIz8BRyTUsp+41ikjkw0PxbHLziWSLkUS7qWqoUDautZa8ND94n0pK9Upf2uDr
         plUKgqsAX/nWyQMHhedJ3RGLWwvvlnSFG6qsSl0OpM30YL7JkE5/4ojO8a2DEqeHpu91
         Au6Jx6wPZgauxjGJn2mzt67Cp69vf3sReNCGbwoWI096otzbKfOy8pLyLWqZLb8qdDPE
         /XG34ilW6eUIojsidMK22W4jy8IXZIS1o/AhyRa3v8GH/4J4yXxg4uvLAb7nclG1w94d
         G9N4N0Dwi5rUo05w7UZroDszeTzREI0VFwYH+bM1PCH1l66wdmmgNFqiiF01Eakod3l+
         7aQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZqI9Ks2fD6CDcpOhzArtbrdrxy9q4Cz+9xddhASoNPU=;
        fh=+sPVlKwa7ycyBMsN2nwr22t/U5/Mf/C0NiU0CPdgy1g=;
        b=ijh/MzcP0+9WDM2i3nwFVhoqd6+6121W60JGYhOpeDmHLw6xPGsfBsSYfUV5WLpenr
         6icxirsUyrVtqkPtPEmtRQr5+2pjqepJEiL8Zn8Sfk8ymQHTJtMbuXqc/+d0dxgnDRum
         rIz3wBqG9lAtpKvgwyHpFglX3GwcCxygMV5wV8wxlPkOLtwjbEEYSmKv8FzlNqYzoZkt
         CYkopvS8pdzTkuIQPhauBYvNvXCH61zLXDUnn9J0DytpaxwyVaiUbSGqoPvkpgHrbMa3
         EfvtS93TJ/l5K1zJklxEQiWfWQ13QhFKqo4pZLXg+66LG7vHRVME2MhAFv9UDo1m0YjY
         PY2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770160135; x=1770764935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqI9Ks2fD6CDcpOhzArtbrdrxy9q4Cz+9xddhASoNPU=;
        b=VzbO531zmS5bVaZcqLqqR9WSpRQdUNT64Gz52AELSoWUeXI34THmOKftJAtZRwYEc5
         b8/AkpRWzKba7L0mzNIXZpw5DgCe1f0qHP5fQVinLv4TsRZId/eopEcBjFATj50J/y63
         ohfFYIakVmASuAyDUHeVOynfe7Y1vQnzEamlca97N1yOHG07kBDRhx8ZgzZFpTiGHZih
         Rj4lGiTh2QtXKFwGpb9sav9Hm4Wh5vG3khQm0p0vqbNY/euueQmKPW8ZgwK+ud+0AH/r
         Y5jWbKjhP/Ycb8m12esI24o/GZx2U+VgID/E4uMj2jq/ig+AoLK4fog/Hi2MHvtBfwm2
         MmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770160135; x=1770764935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZqI9Ks2fD6CDcpOhzArtbrdrxy9q4Cz+9xddhASoNPU=;
        b=aeeQVYIcSChC7uo5Aa3VQQLLEaVh9tTx/Q/gxY+ptva/5MjIjkHbWfqG1LPkdZIzqs
         nw8Tq49KnyFLEExf97L237882X0vJkbQuOcKXtpExBknwrkAsxfEPC/K8zPRo6IWPaZN
         69K//17J9NQTDqjDaLye+e5fd1YN1UkSF2mwbZKy91lQoEsgzmKg1sW9okD2CMxAdb5w
         biadFm5cQLJX731Y1sZHJYvQa5Mp6CtMYzMCuZXnXF2shkXacDGToPMCpmK7PejHQsvp
         olQvUNRMg1lcrX8allpT3E98JQuDeweha+cW6KnWdQ3ej1yBsmBiW/bOFn5/CMIwVykp
         Bm2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWlZ9AGRcKR+PpIclDCzz441Vhg+bagUZLVvavyEw2uOQaav/ee9C8QxJ3OnLk7XYe9PHH1MF0l7tk7iLzAlxro@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6JbUZQsBvg0Pwn4uYdLfp6O+7VG9uXORzpqJIUrNz2rDPMCDU
	43EF6q+nvR+PSr+6H5KaJw5ceT8RvY282lXzcArYPorawDzTXKaDxkIX0y1Zpn3v202GUtx0gvs
	oACv8+TEhg3M1lgNM3M6WHf9vHFqW7sDVIi5BzB8U
X-Gm-Gg: AZuq6aIQOcVdRlKSeiJRm4x2i6SGqbr1O34HX/CkeU1gdk5UeqCKYbqnyClKeLeOSg4
	O9I4JcT0S9r/hA/5TMfyAglT49Y03VqadyT/AJEFy5oymHGfyqQUQnuYEwW6R9ln7SjbU2bgJjk
	E63KZETrDdnawQFrw7c8GoW5dNaIESiSaeSYqI0k+xi20FETx6TCHaslJ9WTQrkxaETrqUnyu0C
	sJlHKsAyPiJAL6nH2rLy8HQcaNcDplUGBwjuVKId2jAZdnmhajepJcU6dDczqtwFPo4/IwizKi5
	Iaq6vlcLNgKCzEmawBDPU0Q4Pw==
X-Received: by 2002:a17:902:e543:b0:29f:f71:a3b9 with SMTP id
 d9443c01a7336-2a9357d109fmr455205ad.5.1770160134598; Tue, 03 Feb 2026
 15:08:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203024356.444942-1-dapeng1.mi@linux.intel.com> <20260203024356.444942-4-dapeng1.mi@linux.intel.com>
In-Reply-To: <20260203024356.444942-4-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 3 Feb 2026 15:08:41 -0800
X-Gm-Features: AZwV_Qi4wP4zHn_zyikfi_kOVWOB2ePG72mgbBl28EKmsM8ktSyosxQsfRGgoCM
Message-ID: <CAP-5=fWS0ugSHpUDkiCmk3nrh0eK4KchtYg1cADRjCdent-u=w@mail.gmail.com>
Subject: Re: [Patch v3 3/4] perf regs: Remove __weak attributive
 arch__xxx_reg_mask() functions
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

On Mon, Feb 2, 2026 at 6:48=E2=80=AFPM Dapeng Mi <dapeng1.mi@linux.intel.co=
m> wrote:
>
> Currently, some architecture-specific perf-regs functions, such as
> arch__intr_reg_mask() and arch__user_reg_mask(), are defined with the
> __weak attribute. This approach ensures that only functions matching
> the architecture of the build/run host are compiled and executed,
> reducing build time and binary size.
>
> However, this __weak attribute restricts these functions to be called
> only on the same architecture, preventing cross-architecture
> functionality. For example, a perf.data file captured on x86 cannot be
> parsed on an ARM platform.
>
> To address this limitation, this patch removes the __weak attribute from
> these perf-regs functions. The architecture-specific code is moved from
> the arch/ directory to the util/perf-regs-arch/ directory. The
> appropriate architectural functions are then called based on the EM_HOST.
>
> No functional changes are intended.
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/arch/arm/util/Build                |  2 -
>  tools/perf/arch/arm/util/perf_regs.c          | 13 ---
>  tools/perf/arch/arm64/util/perf_regs.c        | 36 --------
>  tools/perf/arch/csky/Build                    |  1 -
>  tools/perf/arch/csky/util/Build               |  1 -
>  tools/perf/arch/csky/util/perf_regs.c         | 13 ---
>  tools/perf/arch/loongarch/util/Build          |  1 -
>  tools/perf/arch/loongarch/util/perf_regs.c    | 13 ---
>  tools/perf/arch/mips/util/Build               |  1 -
>  tools/perf/arch/mips/util/perf_regs.c         | 13 ---
>  tools/perf/arch/powerpc/util/perf_regs.c      | 47 -----------
>  tools/perf/arch/riscv/include/perf_regs.h     |  7 +-
>  tools/perf/arch/riscv/util/Build              |  1 -
>  tools/perf/arch/riscv/util/perf_regs.c        | 13 ---
>  tools/perf/arch/s390/util/Build               |  1 -
>  tools/perf/arch/s390/util/perf_regs.c         | 13 ---
>  tools/perf/arch/x86/util/perf_regs.c          | 48 -----------
>  tools/perf/util/evsel.c                       |  4 +-
>  tools/perf/util/parse-regs-options.c          |  2 +-
>  .../util/perf-regs-arch/perf_regs_aarch64.c   | 53 +++++++++++-
>  .../perf/util/perf-regs-arch/perf_regs_arm.c  |  7 +-
>  .../perf/util/perf-regs-arch/perf_regs_csky.c |  7 +-
>  .../util/perf-regs-arch/perf_regs_loongarch.c |  7 +-
>  .../perf/util/perf-regs-arch/perf_regs_mips.c |  7 +-
>  .../util/perf-regs-arch/perf_regs_powerpc.c   | 77 ++++++++++++++++-
>  .../util/perf-regs-arch/perf_regs_riscv.c     |  7 +-
>  .../perf/util/perf-regs-arch/perf_regs_s390.c |  7 +-
>  .../perf/util/perf-regs-arch/perf_regs_x86.c  | 60 ++++++++++++-
>  tools/perf/util/perf_regs.c                   | 84 ++++++++++++++++++-
>  tools/perf/util/perf_regs.h                   | 22 ++++-
>  30 files changed, 332 insertions(+), 236 deletions(-)
>  delete mode 100644 tools/perf/arch/arm/util/perf_regs.c
>  delete mode 100644 tools/perf/arch/csky/Build
>  delete mode 100644 tools/perf/arch/csky/util/Build
>  delete mode 100644 tools/perf/arch/csky/util/perf_regs.c
>  delete mode 100644 tools/perf/arch/loongarch/util/perf_regs.c
>  delete mode 100644 tools/perf/arch/mips/util/perf_regs.c
>  delete mode 100644 tools/perf/arch/riscv/util/perf_regs.c
>  delete mode 100644 tools/perf/arch/s390/util/perf_regs.c
>
> diff --git a/tools/perf/arch/arm/util/Build b/tools/perf/arch/arm/util/Bu=
ild
> index 3291f893b943..b94bf3c5279a 100644
> --- a/tools/perf/arch/arm/util/Build
> +++ b/tools/perf/arch/arm/util/Build
> @@ -1,5 +1,3 @@
> -perf-util-y +=3D perf_regs.o
> -
>  perf-util-$(CONFIG_LOCAL_LIBUNWIND)    +=3D unwind-libunwind.o
>
>  perf-util-y +=3D pmu.o auxtrace.o cs-etm.o
> diff --git a/tools/perf/arch/arm/util/perf_regs.c b/tools/perf/arch/arm/u=
til/perf_regs.c
> deleted file mode 100644
> index 03a5bc0cf64c..000000000000
> --- a/tools/perf/arch/arm/util/perf_regs.c
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include "perf_regs.h"
> -#include "../../../util/perf_regs.h"
> -
> -uint64_t arch__intr_reg_mask(void)
> -{
> -       return PERF_REGS_MASK;
> -}
> -
> -uint64_t arch__user_reg_mask(void)
> -{
> -       return PERF_REGS_MASK;
> -}
> diff --git a/tools/perf/arch/arm64/util/perf_regs.c b/tools/perf/arch/arm=
64/util/perf_regs.c
> index 9bb768e1bea1..47f58eaba032 100644
> --- a/tools/perf/arch/arm64/util/perf_regs.c
> +++ b/tools/perf/arch/arm64/util/perf_regs.c
> @@ -103,39 +103,3 @@ int arch_sdt_arg_parse_op(char *old_op, char **new_o=
p)
>
>         return SDT_ARG_VALID;
>  }
> -
> -uint64_t arch__intr_reg_mask(void)
> -{
> -       return PERF_REGS_MASK;
> -}
> -
> -uint64_t arch__user_reg_mask(void)
> -{
> -       struct perf_event_attr attr =3D {
> -               .type                   =3D PERF_TYPE_HARDWARE,
> -               .config                 =3D PERF_COUNT_HW_CPU_CYCLES,
> -               .sample_type            =3D PERF_SAMPLE_REGS_USER,
> -               .disabled               =3D 1,
> -               .exclude_kernel         =3D 1,
> -               .sample_period          =3D 1,
> -               .sample_regs_user       =3D PERF_REGS_MASK
> -       };
> -       int fd;
> -
> -       if (getauxval(AT_HWCAP) & HWCAP_SVE)
> -               attr.sample_regs_user |=3D SMPL_REG_MASK(PERF_REG_ARM64_V=
G);
> -
> -       /*
> -        * Check if the pmu supports perf extended regs, before
> -        * returning the register mask to sample.
> -        */
> -       if (attr.sample_regs_user !=3D PERF_REGS_MASK) {
> -               event_attr_init(&attr);
> -               fd =3D sys_perf_event_open(&attr, 0, -1, -1, 0);
> -               if (fd !=3D -1) {
> -                       close(fd);
> -                       return attr.sample_regs_user;
> -               }
> -       }
> -       return PERF_REGS_MASK;
> -}
> diff --git a/tools/perf/arch/csky/Build b/tools/perf/arch/csky/Build
> deleted file mode 100644
> index e63eabc2c8f4..000000000000
> --- a/tools/perf/arch/csky/Build
> +++ /dev/null
> @@ -1 +0,0 @@
> -perf-util-y +=3D util/
> diff --git a/tools/perf/arch/csky/util/Build b/tools/perf/arch/csky/util/=
Build
> deleted file mode 100644
> index 6b2d0e021b11..000000000000
> --- a/tools/perf/arch/csky/util/Build
> +++ /dev/null
> @@ -1 +0,0 @@
> -perf-util-y +=3D perf_regs.o
> diff --git a/tools/perf/arch/csky/util/perf_regs.c b/tools/perf/arch/csky=
/util/perf_regs.c
> deleted file mode 100644
> index 2cf7a54106e0..000000000000
> --- a/tools/perf/arch/csky/util/perf_regs.c
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include "perf_regs.h"
> -#include "../../util/perf_regs.h"
> -
> -uint64_t arch__intr_reg_mask(void)
> -{
> -       return PERF_REGS_MASK;
> -}
> -
> -uint64_t arch__user_reg_mask(void)
> -{
> -       return PERF_REGS_MASK;
> -}
> diff --git a/tools/perf/arch/loongarch/util/Build b/tools/perf/arch/loong=
arch/util/Build
> index 0aa31986ecb5..0c958c8e0718 100644
> --- a/tools/perf/arch/loongarch/util/Build
> +++ b/tools/perf/arch/loongarch/util/Build
> @@ -1,5 +1,4 @@
>  perf-util-y +=3D header.o
> -perf-util-y +=3D perf_regs.o
>
>  perf-util-$(CONFIG_LOCAL_LIBUNWIND) +=3D unwind-libunwind.o
>  perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> diff --git a/tools/perf/arch/loongarch/util/perf_regs.c b/tools/perf/arch=
/loongarch/util/perf_regs.c
> deleted file mode 100644
> index 03a5bc0cf64c..000000000000
> --- a/tools/perf/arch/loongarch/util/perf_regs.c
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include "perf_regs.h"
> -#include "../../../util/perf_regs.h"
> -
> -uint64_t arch__intr_reg_mask(void)
> -{
> -       return PERF_REGS_MASK;
> -}
> -
> -uint64_t arch__user_reg_mask(void)
> -{
> -       return PERF_REGS_MASK;
> -}
> diff --git a/tools/perf/arch/mips/util/Build b/tools/perf/arch/mips/util/=
Build
> index 691fa2051958..818b808a8247 100644
> --- a/tools/perf/arch/mips/util/Build
> +++ b/tools/perf/arch/mips/util/Build
> @@ -1,2 +1 @@
> -perf-util-y +=3D perf_regs.o
>  perf-util-$(CONFIG_LOCAL_LIBUNWIND) +=3D unwind-libunwind.o
> diff --git a/tools/perf/arch/mips/util/perf_regs.c b/tools/perf/arch/mips=
/util/perf_regs.c
> deleted file mode 100644
> index 2cf7a54106e0..000000000000
> --- a/tools/perf/arch/mips/util/perf_regs.c
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include "perf_regs.h"
> -#include "../../util/perf_regs.h"
> -
> -uint64_t arch__intr_reg_mask(void)
> -{
> -       return PERF_REGS_MASK;
> -}
> -
> -uint64_t arch__user_reg_mask(void)
> -{
> -       return PERF_REGS_MASK;
> -}
> diff --git a/tools/perf/arch/powerpc/util/perf_regs.c b/tools/perf/arch/p=
owerpc/util/perf_regs.c
> index 779073f7e992..93f929fc32e3 100644
> --- a/tools/perf/arch/powerpc/util/perf_regs.c
> +++ b/tools/perf/arch/powerpc/util/perf_regs.c
> @@ -123,50 +123,3 @@ int arch_sdt_arg_parse_op(char *old_op, char **new_o=
p)
>
>         return SDT_ARG_VALID;
>  }
> -
> -uint64_t arch__intr_reg_mask(void)
> -{
> -       struct perf_event_attr attr =3D {
> -               .type                   =3D PERF_TYPE_HARDWARE,
> -               .config                 =3D PERF_COUNT_HW_CPU_CYCLES,
> -               .sample_type            =3D PERF_SAMPLE_REGS_INTR,
> -               .precise_ip             =3D 1,
> -               .disabled               =3D 1,
> -               .exclude_kernel         =3D 1,
> -       };
> -       int fd;
> -       u32 version;
> -       u64 extended_mask =3D 0, mask =3D PERF_REGS_MASK;
> -
> -       /*
> -        * Get the PVR value to set the extended
> -        * mask specific to platform.
> -        */
> -       version =3D (((mfspr(SPRN_PVR)) >>  16) & 0xFFFF);
> -       if (version =3D=3D PVR_POWER9)
> -               extended_mask =3D PERF_REG_PMU_MASK_300;
> -       else if ((version =3D=3D PVR_POWER10) || (version =3D=3D PVR_POWE=
R11))
> -               extended_mask =3D PERF_REG_PMU_MASK_31;
> -       else
> -               return mask;
> -
> -       attr.sample_regs_intr =3D extended_mask;
> -       attr.sample_period =3D 1;
> -       event_attr_init(&attr);
> -
> -       /*
> -        * check if the pmu supports perf extended regs, before
> -        * returning the register mask to sample.
> -        */
> -       fd =3D sys_perf_event_open(&attr, 0, -1, -1, 0);
> -       if (fd !=3D -1) {
> -               close(fd);
> -               mask |=3D extended_mask;
> -       }
> -       return mask;
> -}
> -
> -uint64_t arch__user_reg_mask(void)
> -{
> -       return PERF_REGS_MASK;
> -}
> diff --git a/tools/perf/arch/riscv/include/perf_regs.h b/tools/perf/arch/=
riscv/include/perf_regs.h
> index 89d5bbb8d2b8..af7a1b47bf66 100644
> --- a/tools/perf/arch/riscv/include/perf_regs.h
> +++ b/tools/perf/arch/riscv/include/perf_regs.h
> @@ -10,10 +10,15 @@
>
>  #define PERF_REGS_MASK ((1ULL << PERF_REG_RISCV_MAX) - 1)
>  #define PERF_REGS_MAX  PERF_REG_RISCV_MAX
> +
> +#if defined(__riscv_xlen)
>  #if __riscv_xlen =3D=3D 64
> -#define PERF_SAMPLE_REGS_ABI    PERF_SAMPLE_REGS_ABI_64
> +#define PERF_SAMPLE_REGS_ABI   PERF_SAMPLE_REGS_ABI_64
>  #else
>  #define PERF_SAMPLE_REGS_ABI   PERF_SAMPLE_REGS_ABI_32
>  #endif
> +#else
> +#define PERF_SAMPLE_REGS_ABI   PERF_SAMPLE_REGS_NONE
> +#endif
>
>  #endif /* ARCH_PERF_REGS_H */
> diff --git a/tools/perf/arch/riscv/util/Build b/tools/perf/arch/riscv/uti=
l/Build
> index 628b9ebd418b..da5b12e7f862 100644
> --- a/tools/perf/arch/riscv/util/Build
> +++ b/tools/perf/arch/riscv/util/Build
> @@ -1,4 +1,3 @@
> -perf-util-y +=3D perf_regs.o
>  perf-util-y +=3D header.o
>
>  perf-util-$(CONFIG_LIBTRACEEVENT) +=3D kvm-stat.o
> diff --git a/tools/perf/arch/riscv/util/perf_regs.c b/tools/perf/arch/ris=
cv/util/perf_regs.c
> deleted file mode 100644
> index 2cf7a54106e0..000000000000
> --- a/tools/perf/arch/riscv/util/perf_regs.c
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include "perf_regs.h"
> -#include "../../util/perf_regs.h"
> -
> -uint64_t arch__intr_reg_mask(void)
> -{
> -       return PERF_REGS_MASK;
> -}
> -
> -uint64_t arch__user_reg_mask(void)
> -{
> -       return PERF_REGS_MASK;
> -}
> diff --git a/tools/perf/arch/s390/util/Build b/tools/perf/arch/s390/util/=
Build
> index 5391d26fedd4..3b09c058e0ec 100644
> --- a/tools/perf/arch/s390/util/Build
> +++ b/tools/perf/arch/s390/util/Build
> @@ -1,6 +1,5 @@
>  perf-util-y +=3D header.o
>  perf-util-$(CONFIG_LIBTRACEEVENT) +=3D kvm-stat.o
> -perf-util-y +=3D perf_regs.o
>
>  perf-util-y +=3D machine.o
>  perf-util-y +=3D pmu.o
> diff --git a/tools/perf/arch/s390/util/perf_regs.c b/tools/perf/arch/s390=
/util/perf_regs.c
> deleted file mode 100644
> index 2cf7a54106e0..000000000000
> --- a/tools/perf/arch/s390/util/perf_regs.c
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include "perf_regs.h"
> -#include "../../util/perf_regs.h"
> -
> -uint64_t arch__intr_reg_mask(void)
> -{
> -       return PERF_REGS_MASK;
> -}
> -
> -uint64_t arch__user_reg_mask(void)
> -{
> -       return PERF_REGS_MASK;
> -}
> diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/u=
til/perf_regs.c
> index a7ca4154fdf9..41141cebe226 100644
> --- a/tools/perf/arch/x86/util/perf_regs.c
> +++ b/tools/perf/arch/x86/util/perf_regs.c
> @@ -233,51 +233,3 @@ int arch_sdt_arg_parse_op(char *old_op, char **new_o=
p)
>
>         return SDT_ARG_VALID;
>  }
> -
> -uint64_t arch__intr_reg_mask(void)
> -{
> -       struct perf_event_attr attr =3D {
> -               .type                   =3D PERF_TYPE_HARDWARE,
> -               .config                 =3D PERF_COUNT_HW_CPU_CYCLES,
> -               .sample_type            =3D PERF_SAMPLE_REGS_INTR,
> -               .sample_regs_intr       =3D PERF_REG_EXTENDED_MASK,
> -               .precise_ip             =3D 1,
> -               .disabled               =3D 1,
> -               .exclude_kernel         =3D 1,
> -       };
> -       int fd;
> -       /*
> -        * In an unnamed union, init it here to build on older gcc versio=
ns
> -        */
> -       attr.sample_period =3D 1;
> -
> -       if (perf_pmus__num_core_pmus() > 1) {
> -               struct perf_pmu *pmu =3D NULL;
> -               __u64 type =3D PERF_TYPE_RAW;
> -
> -               /*
> -                * The same register set is supported among different hyb=
rid PMUs.
> -                * Only check the first available one.
> -                */
> -               while ((pmu =3D perf_pmus__scan_core(pmu)) !=3D NULL) {
> -                       type =3D pmu->type;
> -                       break;
> -               }
> -               attr.config |=3D type << PERF_PMU_TYPE_SHIFT;
> -       }
> -
> -       event_attr_init(&attr);
> -
> -       fd =3D sys_perf_event_open(&attr, 0, -1, -1, 0);
> -       if (fd !=3D -1) {
> -               close(fd);
> -               return (PERF_REG_EXTENDED_MASK | PERF_REGS_MASK);
> -       }
> -
> -       return PERF_REGS_MASK;
> -}
> -
> -uint64_t arch__user_reg_mask(void)
> -{
> -       return PERF_REGS_MASK;
> -}
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 5ac1a05601b1..a36528fd41c6 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1055,13 +1055,13 @@ static void __evsel__config_callchain(struct evse=
l *evsel, struct record_opts *o
>                         evsel__set_sample_bit(evsel, REGS_USER);
>                         evsel__set_sample_bit(evsel, STACK_USER);
>                         if (opts->sample_user_regs &&
> -                           DWARF_MINIMAL_REGS(e_machine) !=3D arch__user=
_reg_mask()) {
> +                           DWARF_MINIMAL_REGS(e_machine) !=3D perf_user_=
reg_mask(EM_HOST)) {
>                                 attr->sample_regs_user |=3D DWARF_MINIMAL=
_REGS(e_machine);
>                                 pr_warning("WARNING: The use of --call-gr=
aph=3Ddwarf may require all the user registers, "
>                                            "specifying a subset with --us=
er-regs may render DWARF unwinding unreliable, "
>                                            "so the minimal registers set =
(IP, SP) is explicitly forced.\n");
>                         } else {
> -                               attr->sample_regs_user |=3D arch__user_re=
g_mask();
> +                               attr->sample_regs_user |=3D perf_user_reg=
_mask(EM_HOST);
>                         }
>                         attr->sample_stack_user =3D param->dump_size;
>                         attr->exclude_callchain_user =3D 1;
> diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse=
-regs-options.c
> index b44b47d9059f..c93c2f0c8105 100644
> --- a/tools/perf/util/parse-regs-options.c
> +++ b/tools/perf/util/parse-regs-options.c
> @@ -66,7 +66,7 @@ __parse_regs(const struct option *opt, const char *str,=
 int unset, bool intr)
>         if (*mode)
>                 return -1;
>
> -       mask =3D intr ? arch__intr_reg_mask() : arch__user_reg_mask();
> +       mask =3D intr ? perf_intr_reg_mask(EM_HOST) : perf_user_reg_mask(=
EM_HOST);
>
>         /* str may be NULL in case no arg is passed to -I */
>         if (!str) {
> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_aarch64.c b/tools/p=
erf/util/perf-regs-arch/perf_regs_aarch64.c
> index 9dcda80d310f..666874f625b6 100644
> --- a/tools/perf/util/perf-regs-arch/perf_regs_aarch64.c
> +++ b/tools/perf/util/perf-regs-arch/perf_regs_aarch64.c
> @@ -1,7 +1,58 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <errno.h>
> +#include <regex.h>
> +#include <string.h>
> +#include <sys/auxv.h>
> +#include <linux/kernel.h>
> +#include <linux/zalloc.h>
>
> +#include "../debug.h"
> +#include "../event.h"
>  #include "../perf_regs.h"
> -#include "../../../arch/arm64/include/uapi/asm/perf_regs.h"
> +#include "../../perf-sys.h"
> +#include "../../arch/arm64/include/perf_regs.h"
> +
> +#define SMPL_REG_MASK(b) (1ULL << (b))
> +
> +#ifndef HWCAP_SVE
> +#define HWCAP_SVE      (1 << 22)
> +#endif
> +
> +uint64_t __perf_reg_mask_arm64(bool intr)
> +{
> +       struct perf_event_attr attr =3D {
> +               .type                   =3D PERF_TYPE_HARDWARE,
> +               .config                 =3D PERF_COUNT_HW_CPU_CYCLES,
> +               .sample_type            =3D PERF_SAMPLE_REGS_USER,
> +               .disabled               =3D 1,
> +               .exclude_kernel         =3D 1,
> +               .sample_period          =3D 1,
> +               .sample_regs_user       =3D PERF_REGS_MASK
> +       };
> +       int fd;
> +
> +       if (intr)
> +               return PERF_REGS_MASK;
> +
> +       if (getauxval(AT_HWCAP) & HWCAP_SVE)
> +               attr.sample_regs_user |=3D SMPL_REG_MASK(PERF_REG_ARM64_V=
G);
> +
> +       /*
> +        * Check if the pmu supports perf extended regs, before
> +        * returning the register mask to sample. Open the event
> +        * on the perf process to check this.
> +        */
> +       if (attr.sample_regs_user !=3D PERF_REGS_MASK) {
> +               event_attr_init(&attr);
> +               fd =3D sys_perf_event_open(&attr, /*pid=3D*/0, /*cpu=3D*/=
-1,
> +                                        /*group_fd=3D*/-1, /*flags=3D*/0=
);
> +               if (fd !=3D -1) {
> +                       close(fd);
> +                       return attr.sample_regs_user;
> +               }
> +       }
> +       return PERF_REGS_MASK;
> +}
>
>  const char *__perf_reg_name_arm64(int id)
>  {
> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_arm.c b/tools/perf/=
util/perf-regs-arch/perf_regs_arm.c
> index e29d130a587a..184d6e248dfc 100644
> --- a/tools/perf/util/perf-regs-arch/perf_regs_arm.c
> +++ b/tools/perf/util/perf-regs-arch/perf_regs_arm.c
> @@ -1,7 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0
>
>  #include "../perf_regs.h"
> -#include "../../../arch/arm/include/uapi/asm/perf_regs.h"
> +#include "../../arch/arm/include/perf_regs.h"
> +
> +uint64_t __perf_reg_mask_arm(bool intr __maybe_unused)
> +{
> +       return PERF_REGS_MASK;
> +}
>
>  const char *__perf_reg_name_arm(int id)
>  {
> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_csky.c b/tools/perf=
/util/perf-regs-arch/perf_regs_csky.c
> index 95808f93d45b..16cbd8303acf 100644
> --- a/tools/perf/util/perf-regs-arch/perf_regs_csky.c
> +++ b/tools/perf/util/perf-regs-arch/perf_regs_csky.c
> @@ -9,7 +9,12 @@
>  #include "../perf_regs.h"
>  #undef __CSKYABIV2__
>  #define __CSKYABIV2__ 1  // Always want the V2 register definitions.
> -#include "../../arch/csky/include/uapi/asm/perf_regs.h"
> +#include "../../arch/csky/include/perf_regs.h"
> +
> +uint64_t __perf_reg_mask_csky(bool intr __maybe_unused)
> +{
> +       return PERF_REGS_MASK;
> +}
>
>  const char *__perf_reg_name_csky(int id, uint32_t e_flags)
>  {
> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_loongarch.c b/tools=
/perf/util/perf-regs-arch/perf_regs_loongarch.c
> index 043f97f4e3ac..478ee889afa1 100644
> --- a/tools/perf/util/perf-regs-arch/perf_regs_loongarch.c
> +++ b/tools/perf/util/perf-regs-arch/perf_regs_loongarch.c
> @@ -1,7 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0
>
>  #include "../perf_regs.h"
> -#include "../../../arch/loongarch/include/uapi/asm/perf_regs.h"
> +#include "../../arch/loongarch/include/perf_regs.h"
> +
> +uint64_t __perf_reg_mask_loongarch(bool intr __maybe_unused)
> +{
> +       return PERF_REGS_MASK;
> +}
>
>  const char *__perf_reg_name_loongarch(int id)
>  {
> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_mips.c b/tools/perf=
/util/perf-regs-arch/perf_regs_mips.c
> index 793178fc3c78..c5a475f6ec64 100644
> --- a/tools/perf/util/perf-regs-arch/perf_regs_mips.c
> +++ b/tools/perf/util/perf-regs-arch/perf_regs_mips.c
> @@ -1,7 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0
>
>  #include "../perf_regs.h"
> -#include "../../../arch/mips/include/uapi/asm/perf_regs.h"
> +#include "../../arch/mips/include/perf_regs.h"
> +
> +uint64_t __perf_reg_mask_mips(bool intr __maybe_unused)
> +{
> +       return PERF_REGS_MASK;
> +}
>
>  const char *__perf_reg_name_mips(int id)
>  {
> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_powerpc.c b/tools/p=
erf/util/perf-regs-arch/perf_regs_powerpc.c
> index 08636bb09a3a..f0a547ad809b 100644
> --- a/tools/perf/util/perf-regs-arch/perf_regs_powerpc.c
> +++ b/tools/perf/util/perf-regs-arch/perf_regs_powerpc.c
> @@ -1,7 +1,82 @@
>  // SPDX-License-Identifier: GPL-2.0
>
> +#include <errno.h>
> +#include <string.h>
> +#include <regex.h>
> +#include <linux/zalloc.h>
> +
> +#include "../debug.h"
> +#include "../event.h"
> +#include "../header.h"
>  #include "../perf_regs.h"
> -#include "../../../arch/powerpc/include/uapi/asm/perf_regs.h"
> +#include "../../perf-sys.h"
> +#include "../../arch/powerpc/util/utils_header.h"
> +#include "../../arch/powerpc/include/perf_regs.h"
> +
> +#include <linux/kernel.h>
> +
> +#define PVR_POWER9             0x004E
> +#define PVR_POWER10            0x0080
> +#define PVR_POWER11            0x0082
> +
> +/*
> + * mfspr is a POWERPC specific instruction, ensure it's only
> + * built and called on POWERPC by guarding with __powerpc64__
> + * or __powerpc__.
> + */
> +#if defined(__powerpc64__) && defined(__powerpc__)
> +uint64_t __perf_reg_mask_powerpc(bool intr)
> +{
> +       struct perf_event_attr attr =3D {
> +               .type                   =3D PERF_TYPE_HARDWARE,
> +               .config                 =3D PERF_COUNT_HW_CPU_CYCLES,
> +               .sample_type            =3D PERF_SAMPLE_REGS_INTR,
> +               .precise_ip             =3D 1,
> +               .disabled               =3D 1,
> +               .exclude_kernel         =3D 1,
> +       };
> +       int fd;
> +       u32 version;
> +       u64 extended_mask =3D 0, mask =3D PERF_REGS_MASK;
> +
> +       if (!intr)
> +               return PERF_REGS_MASK;
> +
> +       /*
> +        * Get the PVR value to set the extended
> +        * mask specific to platform.
> +        */
> +       version =3D (((mfspr(SPRN_PVR)) >>  16) & 0xFFFF);
> +       if (version =3D=3D PVR_POWER9)
> +               extended_mask =3D PERF_REG_PMU_MASK_300;
> +       else if ((version =3D=3D PVR_POWER10) || (version =3D=3D PVR_POWE=
R11))
> +               extended_mask =3D PERF_REG_PMU_MASK_31;
> +       else
> +               return mask;
> +
> +       attr.sample_regs_intr =3D extended_mask;
> +       attr.sample_period =3D 1;
> +       event_attr_init(&attr);
> +
> +       /*
> +        * Check if the pmu supports perf extended regs, before
> +        * returning the register mask to sample. Open the event
> +        * on the perf process to check this.
> +        */
> +       fd =3D sys_perf_event_open(&attr, /*pid=3D*/0, /*cpu=3D*/-1,
> +                                /*group_fd=3D*/-1, /*flags=3D*/0);
> +       if (fd !=3D -1) {
> +               close(fd);
> +               mask |=3D extended_mask;
> +       }
> +       return mask;
> +}
> +#else
> +uint64_t __perf_reg_mask_powerpc(bool intr __maybe_unused)
> +{
> +       return PERF_REGS_MASK;
> +}
> +#endif
>
>  const char *__perf_reg_name_powerpc(int id)
>  {
> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_riscv.c b/tools/per=
f/util/perf-regs-arch/perf_regs_riscv.c
> index 337b687c655d..5b5f21fcba8c 100644
> --- a/tools/perf/util/perf-regs-arch/perf_regs_riscv.c
> +++ b/tools/perf/util/perf-regs-arch/perf_regs_riscv.c
> @@ -1,7 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0
>
>  #include "../perf_regs.h"
> -#include "../../../arch/riscv/include/uapi/asm/perf_regs.h"
> +#include "../../arch/riscv/include/perf_regs.h"
> +
> +uint64_t __perf_reg_mask_riscv(bool intr __maybe_unused)
> +{
> +       return PERF_REGS_MASK;
> +}
>
>  const char *__perf_reg_name_riscv(int id)
>  {
> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_s390.c b/tools/perf=
/util/perf-regs-arch/perf_regs_s390.c
> index d69bba881080..c61df24edf0f 100644
> --- a/tools/perf/util/perf-regs-arch/perf_regs_s390.c
> +++ b/tools/perf/util/perf-regs-arch/perf_regs_s390.c
> @@ -1,7 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0
>
>  #include "../perf_regs.h"
> -#include "../../../arch/s390/include/uapi/asm/perf_regs.h"
> +#include "../../arch/s390/include/perf_regs.h"
> +
> +uint64_t __perf_reg_mask_s390(bool intr __maybe_unused)
> +{
> +       return PERF_REGS_MASK;
> +}
>
>  const char *__perf_reg_name_s390(int id)
>  {
> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_x86.c b/tools/perf/=
util/perf-regs-arch/perf_regs_x86.c
> index 708954a9d35d..d573f9a9ca46 100644
> --- a/tools/perf/util/perf-regs-arch/perf_regs_x86.c
> +++ b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
> @@ -1,7 +1,65 @@
>  // SPDX-License-Identifier: GPL-2.0
>
> +#include <errno.h>
> +#include <string.h>
> +#include <regex.h>
> +#include <linux/kernel.h>
> +#include <linux/zalloc.h>
> +
> +#include "../debug.h"
> +#include "../event.h"
> +#include "../pmu.h"
> +#include "../pmus.h"
>  #include "../perf_regs.h"
> -#include "../../../arch/x86/include/uapi/asm/perf_regs.h"
> +#include "../../perf-sys.h"
> +#include "../../arch/x86/include/perf_regs.h"
> +
> +uint64_t __perf_reg_mask_x86(bool intr)
> +{
> +       struct perf_event_attr attr =3D {
> +               .type                   =3D PERF_TYPE_HARDWARE,
> +               .config                 =3D PERF_COUNT_HW_CPU_CYCLES,
> +               .sample_type            =3D PERF_SAMPLE_REGS_INTR,
> +               .sample_regs_intr       =3D PERF_REG_EXTENDED_MASK,
> +               .precise_ip             =3D 1,
> +               .disabled               =3D 1,
> +               .exclude_kernel         =3D 1,
> +       };
> +       int fd;
> +
> +       if (!intr)
> +               return PERF_REGS_MASK;
> +
> +       /*
> +        * In an unnamed union, init it here to build on older gcc versio=
ns
> +        */
> +       attr.sample_period =3D 1;
> +
> +       if (perf_pmus__num_core_pmus() > 1) {
> +               struct perf_pmu *pmu =3D NULL;
> +               __u64 type =3D PERF_TYPE_RAW;
> +
> +               /*
> +                * The same register set is supported among different hyb=
rid PMUs.
> +                * Only check the first available one.
> +                */
> +               while ((pmu =3D perf_pmus__scan_core(pmu)) !=3D NULL) {
> +                       type =3D pmu->type;
> +                       break;
> +               }
> +               attr.config |=3D type << PERF_PMU_TYPE_SHIFT;
> +       }
> +
> +       event_attr_init(&attr);
> +       fd =3D sys_perf_event_open(&attr, /*pid=3D*/0, /*cpu=3D*/-1,
> +                                /*group_fd=3D*/-1, /*flags=3D*/0);
> +       if (fd !=3D -1) {
> +               close(fd);
> +               return (PERF_REG_EXTENDED_MASK | PERF_REGS_MASK);
> +       }
> +
> +       return PERF_REGS_MASK;
> +}
>
>  const char *__perf_reg_name_x86(int id)
>  {
> diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
> index 14b7be30ab20..4d9a286a0e56 100644
> --- a/tools/perf/util/perf_regs.c
> +++ b/tools/perf/util/perf_regs.c
> @@ -13,14 +13,90 @@ int __weak arch_sdt_arg_parse_op(char *old_op __maybe=
_unused,
>         return SDT_ARG_SKIP;
>  }
>
> -uint64_t __weak arch__intr_reg_mask(void)
> +uint64_t perf_intr_reg_mask(uint16_t e_machine)
>  {
> -       return 0;
> +       uint64_t mask =3D 0;
> +
> +       switch (e_machine) {
> +       case EM_ARM:
> +               mask =3D __perf_reg_mask_arm(/*intr=3D*/true);
> +               break;
> +       case EM_AARCH64:
> +               mask =3D __perf_reg_mask_arm64(/*intr=3D*/true);
> +               break;
> +       case EM_CSKY:
> +               mask =3D __perf_reg_mask_csky(/*intr=3D*/true);
> +               break;
> +       case EM_LOONGARCH:
> +               mask =3D __perf_reg_mask_loongarch(/*intr=3D*/true);
> +               break;
> +       case EM_MIPS:
> +               mask =3D __perf_reg_mask_mips(/*intr=3D*/true);
> +               break;
> +       case EM_PPC:
> +       case EM_PPC64:
> +               mask =3D __perf_reg_mask_powerpc(/*intr=3D*/true);
> +               break;
> +       case EM_RISCV:
> +               mask =3D __perf_reg_mask_riscv(/*intr=3D*/true);
> +               break;
> +       case EM_S390:
> +               mask =3D __perf_reg_mask_s390(/*intr=3D*/true);
> +               break;
> +       case EM_386:
> +       case EM_X86_64:
> +               mask =3D __perf_reg_mask_x86(/*intr=3D*/true);
> +               break;
> +       default:
> +               pr_debug("Unknown ELF machine %d, interrupt sampling regi=
ster mask will be empty.\n",
> +                        e_machine);
> +               break;
> +       }
> +
> +       return mask;
>  }
>
> -uint64_t __weak arch__user_reg_mask(void)
> +uint64_t perf_user_reg_mask(uint16_t e_machine)
>  {
> -       return 0;
> +       uint64_t mask =3D 0;
> +
> +       switch (e_machine) {
> +       case EM_ARM:
> +               mask =3D __perf_reg_mask_arm(/*intr=3D*/false);
> +               break;
> +       case EM_AARCH64:
> +               mask =3D __perf_reg_mask_arm64(/*intr=3D*/false);
> +               break;
> +       case EM_CSKY:
> +               mask =3D __perf_reg_mask_csky(/*intr=3D*/false);
> +               break;
> +       case EM_LOONGARCH:
> +               mask =3D __perf_reg_mask_loongarch(/*intr=3D*/false);
> +               break;
> +       case EM_MIPS:
> +               mask =3D __perf_reg_mask_mips(/*intr=3D*/false);
> +               break;
> +       case EM_PPC:
> +       case EM_PPC64:
> +               mask =3D __perf_reg_mask_powerpc(/*intr=3D*/false);
> +               break;
> +       case EM_RISCV:
> +               mask =3D __perf_reg_mask_riscv(/*intr=3D*/false);
> +               break;
> +       case EM_S390:
> +               mask =3D __perf_reg_mask_s390(/*intr=3D*/false);
> +               break;
> +       case EM_386:
> +       case EM_X86_64:
> +               mask =3D __perf_reg_mask_x86(/*intr=3D*/false);
> +               break;
> +       default:
> +               pr_debug("Unknown ELF machine %d, user sampling register =
mask will be empty.\n",
> +                        e_machine);
> +               break;
> +       }
> +
> +       return mask;
>  }
>
>  const char *perf_reg_name(int id, uint16_t e_machine, uint32_t e_flags)
> diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
> index ed7c1b1358fa..2b27139acadb 100644
> --- a/tools/perf/util/perf_regs.h
> +++ b/tools/perf/util/perf_regs.h
> @@ -13,37 +13,55 @@ enum {
>  };
>
>  int arch_sdt_arg_parse_op(char *old_op, char **new_op);
> -uint64_t arch__intr_reg_mask(void);
> -uint64_t arch__user_reg_mask(void);
> +uint64_t perf_intr_reg_mask(uint16_t e_machine);
> +uint64_t perf_user_reg_mask(uint16_t e_machine);
>
>  const char *perf_reg_name(int id, uint16_t e_machine, uint32_t e_flags);
>  int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
>  uint64_t perf_arch_reg_ip(uint16_t e_machine);
>  uint64_t perf_arch_reg_sp(uint16_t e_machine);
> +
> +uint64_t __perf_reg_mask_arm64(bool intr);
>  const char *__perf_reg_name_arm64(int id);
>  uint64_t __perf_reg_ip_arm64(void);
>  uint64_t __perf_reg_sp_arm64(void);
> +
> +uint64_t __perf_reg_mask_arm(bool intr);
>  const char *__perf_reg_name_arm(int id);
>  uint64_t __perf_reg_ip_arm(void);
>  uint64_t __perf_reg_sp_arm(void);
> +
> +uint64_t __perf_reg_mask_csky(bool intr);
>  const char *__perf_reg_name_csky(int id, uint32_t e_flags);
>  uint64_t __perf_reg_ip_csky(void);
>  uint64_t __perf_reg_sp_csky(void);
> +
> +uint64_t __perf_reg_mask_loongarch(bool intr);
>  const char *__perf_reg_name_loongarch(int id);
>  uint64_t __perf_reg_ip_loongarch(void);
>  uint64_t __perf_reg_sp_loongarch(void);
> +
> +uint64_t __perf_reg_mask_mips(bool intr);
>  const char *__perf_reg_name_mips(int id);
>  uint64_t __perf_reg_ip_mips(void);
>  uint64_t __perf_reg_sp_mips(void);
> +
> +uint64_t __perf_reg_mask_powerpc(bool intr);
>  const char *__perf_reg_name_powerpc(int id);
>  uint64_t __perf_reg_ip_powerpc(void);
>  uint64_t __perf_reg_sp_powerpc(void);
> +
> +uint64_t __perf_reg_mask_riscv(bool intr);
>  const char *__perf_reg_name_riscv(int id);
>  uint64_t __perf_reg_ip_riscv(void);
>  uint64_t __perf_reg_sp_riscv(void);
> +
> +uint64_t __perf_reg_mask_s390(bool intr);
>  const char *__perf_reg_name_s390(int id);
>  uint64_t __perf_reg_ip_s390(void);
>  uint64_t __perf_reg_sp_s390(void);
> +
> +uint64_t __perf_reg_mask_x86(bool intr);
>  const char *__perf_reg_name_x86(int id);
>  uint64_t __perf_reg_ip_x86(void);
>  uint64_t __perf_reg_sp_x86(void);
> --
> 2.34.1
>
