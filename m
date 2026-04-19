Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA52137E2EF
	for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776611364; cv=pass; b=b7RIacRayB7zL+01/62p9HY8X/qp8SB00S46+Z8gFsWJY0NKkUCsBtZASt2rXjvz969sG4KSKcSzbeHLakRoBwDaAGu6Xfe80tycotzSt2r4QSA+VFMZPNLSC1EYVupXuE/ALjcVFD5DTBOKWxEgc083S7MIfRScQcP1grYANOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776611364; c=relaxed/simple;
	bh=Ao0nihYBq6gxen8PC7TDuoruhfTVU7iutw6p3zp+Nn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WW3NeluRK9LfaRVRKKyybYdQ+2G8tOV1e7gmuAAGJ1Fxjz+Sr2UjWZ1B4vOy8QllQM8FCUp0atlWluhd9f1m7k8tNjWNM+AGJ2iFFYc1l0Zxgg9QfrU/h9pxi/LwaIbNHlqS32iKxeOsBkMEjD0r3CY9LXcmjfHiRxdkmoNfhqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CwkEOl01; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CwkEOl01"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1270fc2bdf2so8779c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 08:09:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776611361; cv=none;
        d=google.com; s=arc-20240605;
        b=X1XFWvsqx8lzY9DnYq63Ohm153wuZkugPF1GvLuBWjKGgvIEQsnzcQZaPsdQ2UZNRp
         GI8L2TX0W9R9h3KPU5uvQciTSDN/FrjGxlW2uJPhSM7n8kGxGYHWZxMFGsWH8vl7EGCL
         l/OfFWWHIaKUFWAKzv6+NzNT/1wuC7GO2BlwL7sdhz09+hehwdZedNanYJB9/SPEQxvP
         yEDhw4JXYDI+/XS6W13trMEbj4G8Cxl3tSwuE4XKSPabSNiNbZEQ72e5/ipKfaUYw5ga
         Yi2S/paSYHcwrJhoEow+4AkzQJOhxI+TrJmfFSFTyUzx1zqVrxiNEBRH/3toEkYPQ8Gy
         +VGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=obbqGjiZLz/Ypsgbt7b8Ynbl8OramoDnvcg92+0TJAM=;
        fh=4Cq9g/Ib/PtmTA5gFQp/YGWX8GwFXmhRVBSv60wUXbI=;
        b=bfqTmdbxs9amWAT1+9MDjGy5uY5s61PNUCBZ07PbUfuCxMOVETRaAxZAbsdTPEN99c
         msMeEl6uXkYIkdub15TG/HeVJYrCrVxI6S531JhKf4H+tWO4+2Wh53xWLMhQp+/DzkAD
         /f8ZqCSXrvln5RK2GwtyS7Awbjv1V+rT0vPiUfCHBY7dbpFx/ELzllfFmnLgrQjpp9oY
         0vhD1XGvB8Q8qSka6Ulp1yO31hfuTYZgiyBi4MMa/TEKYdvZshpZiMbgxkKxDFSddmbm
         1VpOJmigoIK+ORgFqbJthR2R8dFUmflYNJbAgxPbyYOVXrT8Cti+xi9kpK4uwg5PPR0o
         rFiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776611361; x=1777216161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obbqGjiZLz/Ypsgbt7b8Ynbl8OramoDnvcg92+0TJAM=;
        b=CwkEOl01Hex69AmduZ4eJ7RYeBb8pyxf6QNOWEcbqibCURBKhmdVjIw9o80bo3Q0GO
         BZJyw02ofPp22L8OKIlQoukUPBudUQTMV8O4yyAGC0DyWGEF1ZzpcCCqAZniPPvZGKdm
         jAlqqXX5GYbRx9ARZHeSmu3rH3NR8pMpEc7n9hHGiBjOc2siVbgjLy9L2Vs3wgG5Yh08
         1uBNcIBlizqAckm67dUvn3sNdo0jVQ2b5MuitBEK3fd30rqAkJIiYB41774LdiYNyO+q
         2qEinWAkaLTyxLV/b2Al/KTCIKciCcPGAYU2FhSb8f+oLZjR/q3NAIqPj7gVVe6RnJ7G
         hTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776611361; x=1777216161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=obbqGjiZLz/Ypsgbt7b8Ynbl8OramoDnvcg92+0TJAM=;
        b=l3GrF24kZ9RclfyEWV33YZylyDd7U4gRFignW5nNqDZnfHlk/qfy0awYHVepehqFO2
         4q6aX5pgGHXmV5IXQMhOZSym9PRT2X3Qqyefh7TTRlT1yi2m4pnaw7g/RKhFh3oZBosw
         rYyQs1+pVgnSd2mSjZBEO2YkutRYIFi7k2o0q9jYe+PK2xwP4Pn5B4DuD/6c47GjBl30
         1S0kVmfVwBVSniyJvn+mTLi0GGvfHG/NZ8mcX96r/1ErrxRMJLEtU3AFca6piSrZ0w7X
         bSN0f6tPSX2Ta6pDkm5WfgvlRpPfr0yuYjHnsCtitpfKmUrS8KUbxWyyoIpmyiqm/zNT
         rDNQ==
X-Forwarded-Encrypted: i=1; AFNElJ/cy5lYCu7x3DBMTzmz3T6yI8ZgHJ4kFhsCdoSNMGi0gtwIpt4sw/HbqmXpt1Ch/FwwQfOq2Zn7bJSVQujpKA5b@vger.kernel.org
X-Gm-Message-State: AOJu0YzbFxx8dvO+NszczYR5L7Fod7ezzQk8J1ijwa0iyBJV2i6a0Jia
	YDrU53hxVyWg8jGKiZ9naOF8wMjdPsS4mHfR8U7wXQjLgUf7M6uNuU0qspi+NJTAVvseJDc48bR
	k23f6TgW7+riZxYD5FnDG2zFYQj/GTO3ghcbuhe2z
X-Gm-Gg: AeBDietyzeKBdabtiXH4OSy1Hhnmi/uQqA8jTR8ssFGb2tvfqAp6xTwsdfanQiYka5J
	UVzi7EcnxsNu+ShA2WCkfQ32juOFnmR3set5YEag7+YfPFMw/vGxEFk4oKwrd2IfH86+6z3EbXn
	OB+Xm/GpQRsCS+E37d/o27YRQB2CC0AlxMWoNZExhe0b5soxRD/PhQGa9HmVSPRJDvDY6ZKEQpt
	osxEKSAVV1yrLHon9mDnh9+dhosXvP8qNvGUgNRa7a23Xu3S25JfgqLTwhCpjg/dyS3bHV+1hDA
	R11fZh/wcQV0srCXHUBo/3dcLRTXlg==
X-Received: by 2002:a05:701a:c971:b0:12c:8392:d1ee with SMTP id
 a92af1059eb24-12c8392d2d0mr86845c88.6.1776611360026; Sun, 19 Apr 2026
 08:09:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416124945.121699-1-cp0613@linux.alibaba.com>
In-Reply-To: <20260416124945.121699-1-cp0613@linux.alibaba.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 19 Apr 2026 08:09:07 -0700
X-Gm-Features: AQROBzCMCLhdDeYuAe5tl925RzNcwTQBo-MiPANwNdzAB1OR6F-MmqWkkdz12AA
Message-ID: <CAP-5=fWUovz+a8o4j=1iZqPTKvtSDnCAqh+6WFsE3QKLJUfesw@mail.gmail.com>
Subject: Re: [PATCH v2] perf riscv: Add SDT argument parsing for RISC-V
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, dapeng1.mi@linux.intel.com, pjw@kernel.org, 
	alex@ghiti.fr, guoren@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 5:50=E2=80=AFAM Chen Pei <cp0613@linux.alibaba.com>=
 wrote:
>
> Implement __perf_sdt_arg_parse_op_riscv() to convert RISC-V GCC-generated
> SDT probe operands into uprobe-compatible format, and register it in the
> perf_sdt_arg_parse_op() dispatcher for EM_RISCV.
>
> RISC-V GCC uses the 'nor' constraint for SDT arguments, producing operand=
s
> in the following formats:
>
>   Format       Example      Uprobe format
>   -----------  -----------  -------------
>   register     a0           %a0
>   memory (+)   8(a0)        +8(%a0)
>   memory (-)   -20(s0)      -20(%s0)
>   constant     99           (skip, not supported by uprobe)
>
> Key differences from other architectures:
>  - Register names use ABI aliases (a0-a7, t0-t6, s0-s11, sp, ra, etc.)
>    without any '%' prefix, unlike x86 (%rax) or arm64 (x0).
>  - Memory operands use OFFSET(REG) syntax where OFFSET may be negative,
>    unlike arm64's [sp, NUM] or powerpc's NUM(%rREG).
>
> Two regexes are used:
>  - SDT_OP_REGEX1: matches RISC-V ABI register names saved in pt_regs
>  - SDT_OP_REGEX2: matches [-]NUM(REG) memory operands
>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Thanks, unfortunately there was a sashiko timeout and so we lack that revie=
w:
https://sashiko.dev/#/patchset/20260416124945.121699-1-cp0613%40linux.aliba=
ba.com
Everything looks good and fits the existing format.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>
> Tested on RISC-V QEMU(rv64gc) with GCC-generated SDT probes.
> Requires systemtap-sdt-dev (provides <sys/sdt.h>) on the target system.
>
>   # cat sdt_test.c
>   #include <sys/sdt.h>
>   #include <stdio.h>
>   void my_func(int a, long b) {
>       DTRACE_PROBE2(myapp, my_probe, a, b);
>       printf("a=3D%d b=3D%ld\n", a, b);
>   }
>   int main() { my_func(42, -100); return 0; }
>
>   # gcc -O0 -Wl,--build-id -o sdt_test_O0 sdt_test.c  # stack args: -20(s=
0)
>   # gcc -O2 -Wl,--build-id -o sdt_test_O2 sdt_test.c  # reg args:   a0
>   # perf buildid-cache --add sdt_test_O0
>   # perf buildid-cache --add sdt_test_O2
>   # find ~/.debug -name "probes" | xargs cat
>   p:sdt_myapp/my_probe .../sdt_test_O0:0x530 arg1=3D-20(%s0):s32 arg2=3D-=
32(%s0):s64
>   p:sdt_myapp/my_probe .../sdt_test_O2:0x538 arg1=3D%a0:s32 arg2=3D%a1:s6=
4
>
> Changes in v2:
>  - Remove 'zero' (x0) from register regexes.
>  - Fix sdt_init_op_regex() to return -ret on error.
>
>  .../util/perf-regs-arch/perf_regs_riscv.c     | 128 ++++++++++++++++++
>  tools/perf/util/perf_regs.c                   |   3 +
>  tools/perf/util/perf_regs.h                   |   1 +
>  3 files changed, 132 insertions(+)
>
> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_riscv.c b/tools/per=
f/util/perf-regs-arch/perf_regs_riscv.c
> index 5b5f21fcba8c..bf769304c97c 100644
> --- a/tools/perf/util/perf-regs-arch/perf_regs_riscv.c
> +++ b/tools/perf/util/perf-regs-arch/perf_regs_riscv.c
> @@ -1,8 +1,136 @@
>  // SPDX-License-Identifier: GPL-2.0
>
> +#include <errno.h>
> +#include <regex.h>
> +#include <string.h>
> +#include <linux/kernel.h>
> +#include <linux/zalloc.h>
> +
> +#include "../debug.h"
>  #include "../perf_regs.h"
>  #include "../../arch/riscv/include/perf_regs.h"
>
> +/*
> + * RISC-V SDT argument formats (GCC 'nor' constraint):
> + *
> + * Register:  REG        e.g. a0, t1, s0, sp
> + * Memory:    NUM(REG)   e.g. 8(a0), -20(s0)
> + * Constant:  NUM        e.g. 99  (not supported by uprobe, skip)
> + *
> + * Note: 'zero' (x0) is hardwired to 0 and not in pt_regs; skip it.
> + *
> + * Uprobe target format:
> + *   Register: %REG       e.g. %a0
> + *   Memory:   +NUM(%REG) or -NUM(%REG)
> + */
> +
> +/* RISC-V register ABI names: ra, sp, gp, tp, t0-t6, s0-s11, a0-a7 */
> +#define SDT_OP_REGEX1  "^(ra|sp|gp|tp|t[0-6]|s[0-9]|s1[01]|a[0-7])$"
> +
> +/* RISC-V memory operand: [-]NUM(REG) */
> +#define SDT_OP_REGEX2  "^(\\-)?([0-9]+)\\((ra|sp|gp|tp|t[0-6]|s[0-9]|s1[=
01]|a[0-7])\\)$"
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
> +       return -ret;
> +}
> +
> +/*
> + * Parse OP and convert it into uprobe format.
> + * Possible variants of OP (RISC-V, GCC 'nor' constraint):
> + *
> + *   Format         Example       Uprobe
> + *   ----------------------------------------
> + *   REG            a0            %a0
> + *   NUM(REG)       8(a0)         +8(%a0)
> + *   -NUM(REG)      -20(s0)       -20(%s0)
> + *   NUM            99            (skip, constant not supported)
> + */
> +int __perf_sdt_arg_parse_op_riscv(char *old_op, char **new_op)
> +{
> +       int ret, new_len;
> +       regmatch_t rm[4];
> +       char prefix;
> +
> +       /*
> +        * Constant argument: pure integer with no trailing '(' (e.g. "99=
", "-1").
> +        * uprobe does not support immediate values, so skip them.
> +        * Memory operands like "8(a0)" or "-20(s0)" contain '(' so are N=
OT
> +        * treated as constants here; they will be matched by REGEX2 belo=
w.
> +        */
> +       if (strchr(old_op, '(') =3D=3D NULL &&
> +           ((*old_op >=3D '0' && *old_op <=3D '9') ||
> +            (*old_op =3D=3D '-' && old_op[1] >=3D '0' && old_op[1] <=3D =
'9'))) {
> +               pr_debug4("Skipping unsupported SDT argument: %s\n", old_=
op);
> +               return SDT_ARG_SKIP;
> +       }
> +
> +       ret =3D sdt_init_op_regex();
> +       if (ret < 0)
> +               return ret;
> +
> +       if (!regexec(&sdt_op_regex1, old_op, 2, rm, 0)) {
> +               /* REG --> %REG */
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
> +       } else if (!regexec(&sdt_op_regex2, old_op, 4, rm, 0)) {
> +               /*
> +                * NUM(REG) or -NUM(REG) --> +NUM(%REG) or -NUM(%REG)
> +                * rm[1]: optional '-'
> +                * rm[2]: decimal offset
> +                * rm[3]: register name
> +                */
> +               prefix =3D (rm[1].rm_so =3D=3D -1) ? '+' : '-';
> +
> +               new_len =3D 5;    /* sign ( % ) NULL */
> +               new_len +=3D (int)(rm[2].rm_eo - rm[2].rm_so);
> +               new_len +=3D (int)(rm[3].rm_eo - rm[3].rm_so);
> +
> +               *new_op =3D zalloc(new_len);
> +               if (!*new_op)
> +                       return -ENOMEM;
> +
> +               scnprintf(*new_op, new_len, "%c%.*s(%%%.*s)", prefix,
> +                       (int)(rm[2].rm_eo - rm[2].rm_so), old_op + rm[2].=
rm_so,
> +                       (int)(rm[3].rm_eo - rm[3].rm_so), old_op + rm[3].=
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
>  uint64_t __perf_reg_mask_riscv(bool intr __maybe_unused)
>  {
>         return PERF_REGS_MASK;
> diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
> index 5b8f34beb24e..57a1d227d1b2 100644
> --- a/tools/perf/util/perf_regs.c
> +++ b/tools/perf/util/perf_regs.c
> @@ -19,6 +19,9 @@ int perf_sdt_arg_parse_op(uint16_t e_machine, char *old=
_op, char **new_op)
>         case EM_PPC64:
>                 ret =3D __perf_sdt_arg_parse_op_powerpc(old_op, new_op);
>                 break;
> +       case EM_RISCV:
> +               ret =3D __perf_sdt_arg_parse_op_riscv(old_op, new_op);
> +               break;
>         case EM_386:
>         case EM_X86_64:
>                 ret =3D __perf_sdt_arg_parse_op_x86(old_op, new_op);
> diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
> index 7c04700bf837..e0b51b514ee0 100644
> --- a/tools/perf/util/perf_regs.h
> +++ b/tools/perf/util/perf_regs.h
> @@ -53,6 +53,7 @@ const char *__perf_reg_name_powerpc(int id);
>  uint64_t __perf_reg_ip_powerpc(void);
>  uint64_t __perf_reg_sp_powerpc(void);
>
> +int __perf_sdt_arg_parse_op_riscv(char *old_op, char **new_op);
>  uint64_t __perf_reg_mask_riscv(bool intr);
>  const char *__perf_reg_name_riscv(int id);
>  uint64_t __perf_reg_ip_riscv(void);
> --
> 2.50.1
>
>
