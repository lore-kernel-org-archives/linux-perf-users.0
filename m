Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47CB15D5CA;
	Mon, 17 Jun 2024 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718642064; cv=none; b=V7IPCV/iYFDyxjTQL8fK8m31mW8bUQz2hYLzdnwNu8FrN4XMfiWiSltqoB+Tm1sZe0nwonTr03SHHFYGFcpTQBuZrVhs2qddEJKXJ/YMX/mmX4wDHM8p1b7iQYbp5X8c+p+dR7uYvfI8hvFSrd1qzObiWze6OJAmCFiEqXbjuX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718642064; c=relaxed/simple;
	bh=Kc6npoJ2c6U5oWy4Wj721fvTk0TfMA38JQT4sIU1xD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V3s2JwPZlpikdPdenBMolGd7vf44+iU4aRmiA/USOsC6M13XGdphUOpzBBA+2/fFRyX4Cqpw2JcaXw+yk0qOAq5YIqbeuwjprbvIxstVeRDr8UaSJKbG4KbRG591hpRLTkM+qHzHfKXycwbX/5LakEZE/uxLpVfrsCzKsMi+OLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ID5b0mPe; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ID5b0mPe"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ebe3bac675so41333911fa.1;
        Mon, 17 Jun 2024 09:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718642061; x=1719246861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ogcq2cw4LW99KAx92DCfmRE6i+NEPsTdaF/G7XCqinM=;
        b=ID5b0mPemZdpqct47rkFmsfqNFkpkfKXvAmOL8HTMpsqUwm3ebUMwTuQ5xTuoKhJ/w
         4uuPOjGhMnfCxh/bhRc7iGMj5mbMvW5lvN/FuJzG6qzhoXBWwl8ksq+lPyxPgioYATH8
         JOzSXar1zA6zLZ6ruMDRAUz1m0Srzq18uPlf/8AUcneeydLZH+juGIlus1m4ntazcgc1
         lNvNfvP3ZDBXBuiMR/GWaEGLpGRTGy0WuyAYceEoRtEyrHA/7Gv2rBwqNomVGQrsE7Do
         zbfCRcRKE3JA7X49Gk1acIpdQp+dfHB37e58Nr/5gozBryZkQRJJRLED4wh1/bbIOQI9
         1umw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718642061; x=1719246861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ogcq2cw4LW99KAx92DCfmRE6i+NEPsTdaF/G7XCqinM=;
        b=Zwz82PyxoTVZEDqvw+PHTwEiVyN8trE1Cpdhj3VMixQCoekQXCr8lQGQqmTGJWDsE3
         wuLGB58MC11m+9aehw68+gUDyh7uzDOH3DV134XUfI0Ynkt5cUJ/mOuhY/70Yii7AO3F
         9NEwHBKZ3yLD8fdF2nIBkw6SS/64YDKQr2IsKpo7AM9oVyZNtcVRfkJq6uS6dVc0xw+E
         WWgsundsbxz5fJSNXQKqSBZDMuE08XnTosFb03porVnNXFemBgS+ht6RAVoPlRzI0A84
         2Dcpvvbedc+g2Ur1wdlnUQmCPleFyp6KI0Ko/05VSdG+lHBDb3vEwwp0K5dx5BFfTA17
         WOEw==
X-Forwarded-Encrypted: i=1; AJvYcCVsfODOxCTHI2Mudl315HKvcUlX1bekWklcaKdLYBirW/K+tu4SfwipThynTj0Hp5E+rzTHb8UYLuaZVbaztEqslGpkQfdn66Qux/KORnlK+w==
X-Gm-Message-State: AOJu0YwPLXrAjNjC1q61TRL6WUsbESeuXKjnyBJsCkVvzJ9sZIBuL/Po
	be806p9ejaCcFojxYE4vzbCToJ9h4vxdo0NRvqYPvo+gyUBw5itQLFg0FD9ztZRFxMCDf8Ailla
	3Ov3srJ9X9T4twmo9Y0ehO95odw==
X-Google-Smtp-Source: AGHT+IGivdcE+iPtGE5o0xUHNTlSBmox16QCHyEMdFMr0hg3nXWE6hx+5o4C1UsIaS3/+c5jjJQzaXwXeomAQqT76Rs=
X-Received: by 2002:a2e:9f41:0:b0:2ec:13f9:930c with SMTP id
 38308e7fff4ca-2ec346421f7mr504261fa.5.1718642060507; Mon, 17 Jun 2024
 09:34:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240616085743.1100704-1-xin@zytor.com> <20240616085743.1100704-3-xin@zytor.com>
In-Reply-To: <20240616085743.1100704-3-xin@zytor.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Mon, 17 Jun 2024 12:34:09 -0400
Message-ID: <CAMzpN2jQrgaPR2R_=sBRmjGvbpX1ZSCrr9zJ+TM9N1ymg5_OiA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] x86/cpufeatures: Generate a feature mask header
 based on build config
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, will@kernel.org, 
	peterz@infradead.org, akpm@linux-foundation.org, acme@kernel.org, 
	namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 16, 2024 at 4:58=E2=80=AFAM Xin Li (Intel) <xin@zytor.com> wrot=
e:
>
> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
>
> Introduce an AWK script to auto-generate a header with required and
> disabled feature masks based on <asm/cpufeatures.h> and current build
> config. Thus for any CPU feature with a build config, e.g., X86_FRED,
> simply add
>
> config X86_DISABLED_FEATURE_FRED
>         def_bool y
>         depends on !X86_FRED
>
> to arch/x86/Kconfig.cpufeatures, instead of adding a conditional CPU
> feature disable flag, e.g., DISABLE_FRED.
>
> Lastly the generated required and disabled feature masks will be added
> to their corresponding feature masks for this particular compile-time
> configuration.
>
> [ Xin: build integration improvements ]
>
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> ---
>
> Change since v1:
> * Remove code generating unused macros {REQUIRED,DISABLED}_FEATURE(x)
>   to tell if a CPU feature, e.g., X86_FEATURE_FRED, is a required or
>   disabled feature for this particular compile-time configuration.
> ---
>  arch/x86/Makefile                  | 17 +++++-
>  arch/x86/boot/cpucheck.c           |  3 +-
>  arch/x86/boot/cpuflags.c           |  1 -
>  arch/x86/boot/mkcpustr.c           |  3 +-
>  arch/x86/include/asm/Kbuild        |  1 +
>  arch/x86/include/asm/cpufeature.h  |  1 +
>  arch/x86/include/asm/cpufeatures.h |  8 ---
>  arch/x86/kernel/verify_cpu.S       |  1 +
>  arch/x86/tools/featuremasks.awk    | 90 ++++++++++++++++++++++++++++++
>  9 files changed, 111 insertions(+), 14 deletions(-)
>  create mode 100755 arch/x86/tools/featuremasks.awk
>
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 801fd85c3ef6..211c0820b150 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -261,9 +261,22 @@ archscripts: scripts_basic
>         $(Q)$(MAKE) $(build)=3Darch/x86/tools relocs
>
>  ###
> -# Syscall table generation
> +# Feature masks header and syscall table generation
>
> -archheaders:
> +out :=3D arch/x86/include/generated/asm
> +featuremasks_hdr :=3D featuremasks.h
> +featuremasks_awk :=3D $(srctree)/arch/x86/tools/featuremasks.awk
> +cpufeatures_hdr :=3D $(srctree)/arch/x86/include/asm/cpufeatures.h
> +quiet_cmd_gen_featuremasks =3D GEN     $@
> +      cmd_gen_featuremasks =3D $(AWK) -f $(featuremasks_awk) $(cpufeatur=
es_hdr) $(KCONFIG_CONFIG) > $@
> +
> +$(out)/$(featuremasks_hdr): $(featuremasks_awk) $(cpufeatures_hdr) $(KCO=
NFIG_CONFIG) FORCE
> +       $(shell mkdir -p $(out))
> +       $(call if_changed,gen_featuremasks)
> +
> +targets +=3D $(out)/$(featuremasks_hdr)
> +
> +archheaders: $(out)/$(featuremasks_hdr)
>         $(Q)$(MAKE) $(build)=3Darch/x86/entry/syscalls all
>
>  ###
> diff --git a/arch/x86/boot/cpucheck.c b/arch/x86/boot/cpucheck.c
> index 0aae4d4ed615..8d03a741d1b2 100644
> --- a/arch/x86/boot/cpucheck.c
> +++ b/arch/x86/boot/cpucheck.c
> @@ -22,10 +22,11 @@
>  # include "boot.h"
>  #endif
>  #include <linux/types.h>
> +#include <asm/featuremasks.h>
>  #include <asm/intel-family.h>
>  #include <asm/processor-flags.h>
> -#include <asm/required-features.h>
>  #include <asm/msr-index.h>
> +
>  #include "string.h"
>  #include "msr.h"
>
> diff --git a/arch/x86/boot/cpuflags.c b/arch/x86/boot/cpuflags.c
> index d75237ba7ce9..0cabdacb2a2f 100644
> --- a/arch/x86/boot/cpuflags.c
> +++ b/arch/x86/boot/cpuflags.c
> @@ -3,7 +3,6 @@
>  #include "bitops.h"
>
>  #include <asm/processor-flags.h>
> -#include <asm/required-features.h>
>  #include <asm/msr-index.h>
>  #include "cpuflags.h"
>
> diff --git a/arch/x86/boot/mkcpustr.c b/arch/x86/boot/mkcpustr.c
> index da0ccc5de538..b90110109675 100644
> --- a/arch/x86/boot/mkcpustr.c
> +++ b/arch/x86/boot/mkcpustr.c
> @@ -12,8 +12,6 @@
>
>  #include <stdio.h>
>
> -#include "../include/asm/required-features.h"
> -#include "../include/asm/disabled-features.h"
>  #include "../include/asm/cpufeatures.h"
>  #include "../include/asm/vmxfeatures.h"
>  #include "../kernel/cpu/capflags.c"
> @@ -23,6 +21,7 @@ int main(void)
>         int i, j;
>         const char *str;
>
> +       printf("#include <asm/featuremasks.h>\n\n");
>         printf("static const char x86_cap_strs[] =3D\n");
>
>         for (i =3D 0; i < NCAPINTS; i++) {
> diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
> index a192bdea69e2..29c3481f40fc 100644
> --- a/arch/x86/include/asm/Kbuild
> +++ b/arch/x86/include/asm/Kbuild
> @@ -8,6 +8,7 @@ generated-y +=3D syscalls_x32.h
>  generated-y +=3D unistd_32_ia32.h
>  generated-y +=3D unistd_64_x32.h
>  generated-y +=3D xen-hypercalls.h
> +generated-y +=3D featuremasks.h
>
>  generic-y +=3D early_ioremap.h
>  generic-y +=3D mcs_spinlock.h
> diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpu=
feature.h
> index 0b9611da6c53..8332f596ba3c 100644
> --- a/arch/x86/include/asm/cpufeature.h
> +++ b/arch/x86/include/asm/cpufeature.h
> @@ -9,6 +9,7 @@
>  #include <asm/asm.h>
>  #include <linux/bitops.h>
>  #include <asm/alternative.h>
> +#include <asm/featuremasks.h>
>
>  enum cpuid_leafs
>  {
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cp=
ufeatures.h
> index 3c7434329661..05503448b94d 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -2,14 +2,6 @@
>  #ifndef _ASM_X86_CPUFEATURES_H
>  #define _ASM_X86_CPUFEATURES_H
>
> -#ifndef _ASM_X86_REQUIRED_FEATURES_H
> -#include <asm/required-features.h>
> -#endif
> -
> -#ifndef _ASM_X86_DISABLED_FEATURES_H
> -#include <asm/disabled-features.h>
> -#endif
> -
>  /*
>   * Defines x86 CPU feature bits
>   */
> diff --git a/arch/x86/kernel/verify_cpu.S b/arch/x86/kernel/verify_cpu.S
> index 1258a5872d12..3205cbb47b9c 100644
> --- a/arch/x86/kernel/verify_cpu.S
> +++ b/arch/x86/kernel/verify_cpu.S
> @@ -29,6 +29,7 @@
>   */
>
>  #include <asm/cpufeatures.h>
> +#include <asm/featuremasks.h>
>  #include <asm/msr-index.h>
>
>  SYM_FUNC_START_LOCAL(verify_cpu)
> diff --git a/arch/x86/tools/featuremasks.awk b/arch/x86/tools/featuremask=
s.awk
> new file mode 100755
> index 000000000000..c96e6cf43161
> --- /dev/null
> +++ b/arch/x86/tools/featuremasks.awk
> @@ -0,0 +1,90 @@
> +#!/usr/bin/awk
> +#
> +# Convert cpufeatures.h to a list of compile-time masks
> +# Note: this blithly assumes that each word has at least one
> +# feature defined in it; if not, something else is wrong!
> +#
> +
> +BEGIN {
> +       printf "#ifndef _ASM_X86_FEATUREMASKS_H\n";
> +       printf "#define _ASM_X86_FEATUREMASKS_H\n\n";
> +
> +       file =3D 0
> +}
> +
> +BEGINFILE {
> +       switch (++file) {
> +       case 1:                 # cpufeatures.h
> +               FPAT =3D "#[ \t]*[a-z]+|[A-Za-z0-9_]+|[^ \t]";
> +               break;
> +       case 2:                 # .config
> +               FPAT =3D "CONFIG_[A-Z0-9_]+|is not set|[yn]";
> +               break;
> +       }
> +}
> +
> +file =3D=3D 1 && $1 ~ /^#[ \t]*define$/ && $2 ~ /^X86_FEATURE_/ &&
> +$3 =3D=3D "(" && $5 =3D=3D "*" && $7 =3D=3D "+" && $9 =3D=3D ")" {
> +       nfeat =3D $4 * $6 + $8;
> +       feat =3D $2;
> +       sub(/^X86_FEATURE_/, "", feat);
> +       feats[nfeat] =3D feat;
> +}
> +file =3D=3D 1 && $1 ~ /^#[ \t]*define$/ && $2 =3D=3D "NCAPINTS" {
> +       ncapints =3D strtonum($3);
> +}
> +
> +file =3D=3D 2 && $1 ~ /^CONFIG_X86_[A-Z]*_FEATURE_/ {
> +       on =3D ($2 =3D=3D "y");
> +       printf "/* %s =3D %s (%d) */\n", $1, $2, on;

This looks like extra debugging output that doesn't need to be in the
final release.

> +       if (split($1, fs, "CONFIG_X86_|_FEATURE_") =3D=3D 3) {
> +               printf "/* %s %s =3D %d */\n", fs[2], fs[3], on;

Same.

> +               featstat[fs[2], fs[3]] =3D on;
> +       }
> +}
> +
> +END {
> +       sets[1] =3D "REQUIRED";
> +       sets[2] =3D "DISABLED";
> +
> +       for (ns in sets) {
> +               s =3D sets[ns];
> +
> +               printf "/*\n";
> +               printf " * %s features:\n", s;
> +               printf " *\n";
> +               fstr =3D "";
> +               for (i =3D 0; i < ncapints; i++) {
> +                       mask =3D 0;
> +                       for (j =3D 0; j < 32; j++) {
> +                               nfeat =3D i*32 + j;
> +                               feat =3D feats[nfeat];
> +                               if (feat) {
> +                                       st =3D !!featstat[s, feat];
> +                                       if (st) {
> +                                               nfstr =3D fstr " " feat;
> +                                               if (length(nfstr) > 72) {
> +                                                       printf " *   %s\n=
", fstr;
> +                                                       nfstr =3D " " fea=
t;
> +                                               }
> +                                               fstr =3D nfstr;
> +                                       }
> +                                       mask +=3D st * (2 ^ j);
> +                               }
> +                       }
> +                       masks[i] =3D mask;
> +               }
> +               printf " *   %s\n */\n\n", fstr;
> +
> +               for (i =3D 0; i < ncapints; i++) {
> +                       printf "#define %s_MASK%-3d 0x%08x\n", s, i, mask=
s[i];
> +               }
> +
> +               printf "#define %s_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS =
!=3D %d)\n\n", s, ncapints;
> +       }
> +
> +       printf "#define SSE_MASK\t\\\n";
> +       printf "\t(REQUIRED_MASK0 & ((1<<(X86_FEATURE_XMM & 31)) | (1<<(X=
86_FEATURE_XMM2 & 31))))\n\n";

This could be moved to verify_cpu.S, since that is the only place it is use=
d.

> +       printf "#endif /* _ASM_X86_FEATUREMASKS_H */\n";
> +}
> --
> 2.45.1
>
>

You could also generate {REQUIRED|DISABLED}_MASK_BIT_SET() in this
script, so that they are always in sync with NCAPINTS.

Brian Gerst
