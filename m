Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880FF27B353
	for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776613992; cv=none; b=fkOpMqKahmpxJIthfcMuAjpncPLkC6Zf/uwWEbOJovEIf6kPoj7H2ZFKWwlq3Bu3i6IR0XOxIOd7Y5NTCB+vSByG0kH/22eeJxHm+oAImvBip5NBsOboQx4eid+ZzDYserDpuve1g+PNnyUMKpAJkL22NSxgjRZMkDoRm7Fjp/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776613992; c=relaxed/simple;
	bh=W2ps7HWtJIiArRdAAL/3nACtnoo0+3kJ8+QtzDs2/pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRkcyn7jLCgbhyC6WVi/HKXe7qBkGPWfYC/XbVBz9w/8mPXKWMu+7EsB/o5GT8PdryUJ9SMimNTTpehuPgXlxn2u56/QtTxjdZd1p4bCFmg/nisA5aOh23rDNjsWISb5tUCCSiezWIBzwdrLfd9Ufmfw6XgRSkuhRsTHCwRU+Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exwRqyF8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exwRqyF8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE19C2BCC4
	for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 15:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776613992;
	bh=W2ps7HWtJIiArRdAAL/3nACtnoo0+3kJ8+QtzDs2/pc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=exwRqyF800BUlxdKMlZGqkEX9YQ72vHa2Sgze69vPoMaIZDwN23PzTRc3dfl2aQjE
	 9/CU5+mfSgUv9HGffHFGAyaxdR3+R9yBEMVQ0L/3wIKv6BKMAO0wQ6aJYmN6POOSbz
	 3GXjQ+aSqfTS6ZiIkicORSirZAqjE4K5VA5RqoPclKJgPwRM28rPXEM+gJtIi3ar0N
	 lL2Cj4HxhQXh3XUjGGNQ1vaFVtLsoPVZUPuYZ2XJcFXFAfrXoezS7tg8qUkvFtOe4j
	 CHqQLgOZcupWkATTw4NKJ1jCAbfgFlV90jR9tyb6HjhL7MAkXdwA7zCVRO6OL5LYQd
	 CfonkouWb3B9Q==
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43eb05b1875so1273942f8f.3
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 08:53:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+pI9uiEDuPFQMTzkwXBUv5d3RvS6Uokdd6sLhSNcFKDX+rZGp9ZVDP2b7asVrhqTGHS9UZ0deB59vwt51guPWl@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo361yW5PofYqJEVbpmZ/rxMdh4WfuNV+k/T0XGxgpYucKTNsN
	iWfkvDT/WB6zGST2ATqvCSbxVbbbSUZhA0mvge/aOUSTLS7G1bMK7pkdHea9DEVVGLGrgsxQb1K
	Ma9FVw6Nt3lFa9UA0cpgyQpQoOri3K10=
X-Received: by 2002:a5d:584c:0:b0:43d:7403:4b57 with SMTP id
 ffacd0b85a97d-43fe3db3ca7mr15739232f8f.10.1776613990622; Sun, 19 Apr 2026
 08:53:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416124945.121699-1-cp0613@linux.alibaba.com>
In-Reply-To: <20260416124945.121699-1-cp0613@linux.alibaba.com>
From: Guo Ren <guoren@kernel.org>
Date: Sun, 19 Apr 2026 23:52:57 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS+yEPPrpS-mAHPhHmdxrgGpy5ev5t_4kJ9G=-emjLZoA@mail.gmail.com>
X-Gm-Features: AQROBzCp8BQ4zGanAz-DuE3xjxGsT-ZKPPqGeGQV1DtociQY8ZaDmODR5lp3mMg
Message-ID: <CAJF2gTS+yEPPrpS-mAHPhHmdxrgGpy5ev5t_4kJ9G=-emjLZoA@mail.gmail.com>
Subject: Re: [PATCH v2] perf riscv: Add SDT argument parsing for RISC-V
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, irogers@google.com, dapeng1.mi@linux.intel.com, 
	pjw@kernel.org, alex@ghiti.fr, linux-perf-users@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chen,

On Thu, Apr 16, 2026 at 8:50=E2=80=AFPM Chen Pei <cp0613@linux.alibaba.com>=
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
LGTM!

Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren
