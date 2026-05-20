Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3495B3EF0D7
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290764; cv=pass; b=ugTwXAeVIkov0h1ePVTsCzP+cGABsM4r0jde7cUsbGLuqDvBFmB+sgX8aGaj/5Y+hrP1nOAQaleKCUcSL1t14pDKqo8ETPYloyGvY3zLMLqufiWeOExN5O0Lg3B+vCdjqslcZI8lVxaG5X/TSzFKU+vVio2+vNdGCXxXphCBEfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290764; c=relaxed/simple;
	bh=tfxETcZ7bbFmY/uAHyh3oU/nmNQy/wA5MYwMD7XULDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IXnxJVILh6/1rp5C6t+kGiMVTE4Ex50Ik3wecSyTJvE3Lkrh4NLVI/uurMS1a7QLSsaahaDaSZGQQRrxgVmOqtdc46NqCJrFb3u1o13cEEudRiR7R91LJIaQ9P610PDFDmgAwc+5OVDNavpWab01LB4rNzw4GvXCfDDvk5Blffk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ltd2wj2U; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ltd2wj2U"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b46da8c48eso4855ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 08:26:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779290762; cv=none;
        d=google.com; s=arc-20240605;
        b=TrHBaUdXJHIMVMtW0d7hkT7xNDb93oJL1oHbtev44D7SexwsvmdaCNxqLese5ByXO3
         lm8tU2PRHMHpjoar2BO7x71LsY8aTrZpAUlCFyAKefOpKeCGFABRBHfVummJnuBlrtKr
         s5ENsXLGtEhQlaEoP09hDzD0h2kB6tp0Ah3TFqSo6dqxRo5c7WLbEOim0HeCHuoa3BDg
         ZGXp5SWQuDlY5ZVRYW7iN9JFFq1ZWHiU/DVy5fawGdK05kvpMjAaEFJnOP5TFvnjQiW4
         qeXTAMOkVbaoAQsq20dENxq4lIBW4kxvgU6tOpTz7c7jDxOMXInYnjCapnPlxiu2N2Cn
         bYqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8PefTSc4iLEYlhheHnaoh74ekYBU5SjriHCT/hG3qzY=;
        fh=wpal3VtkrxfkcVYNiY0kMb4z884+CscTzC97HD/sE+Y=;
        b=HkQIPvkah6uf0MVdnhrzkKGs/G5RS9BU2EWttudg4aCANkR74KFbcodoIymMQ4sUIj
         sd+5eIVa2OGNCR+5fJrcPFZheKesZrnf0/zS6LkDcpH04lpfX6eMx+9AUlVLCDYfKwr2
         MCC5HtWdgCsUOdZ4FLc7ETXCs8g/g0ES54SWHe+hTgmqU+ifgaBySd0c9uERCIPlaJa5
         BhcU00Qw9DltW+wvbyODlzEinACRSGA+BKpH4m64CQMCrEaVI2t0mNJjYoVorgmoOj3N
         uobYTgKPS0WJmG06xshxHefNuzJzeYrdsMRr6hCdwRmf1r8sj4lzamQ2nayttxJR5Zaa
         c2Kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779290762; x=1779895562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PefTSc4iLEYlhheHnaoh74ekYBU5SjriHCT/hG3qzY=;
        b=Ltd2wj2UBPM0xrFUQ5N8I1XtLDEMj4+rsycU/9Vpe2RAu0I2OktMA/70h6WUxQxRL2
         dYmby7+vvTqVfLMAGh1/MuxdvnNg+bAQvhzKc1VC4gwk+IG2QG7OCQoQbSTykF0lSDH9
         /uY34YKE4R2IKjX/Eb/FkdHohYeEtcCK+6Kfase4t0BrUuVX9Soj/k7Rr5imAJe+Ok3U
         NYpEG4LIuHltJXBkGayMegAmMFSUntpDa7ULB4MKKc9+J5qBdptqTV3VPVJev6WHQv29
         QFVxbCPKtqpeVIgm5dZXEEXwgN5Udxyt6Bc0t7m1Zay3TLnwVioUQ5E+cwuHHVRjr6bn
         7gSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779290762; x=1779895562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8PefTSc4iLEYlhheHnaoh74ekYBU5SjriHCT/hG3qzY=;
        b=iguoKcZVgfuZuWma1kncgbtEcdr/RHuRcmAMtcro67uVH21iWA4cPb0ebCsKYtfkNH
         SVGnr0c1k2H//d96ma9T/2SLidcDgFbbRb/z55nfjMrmTht9pN6gBotwFsTCfCPrdQQ2
         Okb8Li0Mu+ia4OxKuRm2JDPBXGk6cwfv1S2ktj1KlFc4d4DrCyQFCLW7wIJ5LuQgXTX9
         GAji0CofLJ6mwHkuuii6CGQVsUYdmyu2EXTljBKkEet2EAnFmdmMaYzHX2qK9x6LjCWh
         Ts/2Fj5j/N6wLyS4fsj2xnXLc5ChRSbAOYB6K+SY1q/KNOjLaN1EhYn5OlX/Iqzl1Ffj
         oWdQ==
X-Forwarded-Encrypted: i=1; AFNElJ+H+B/9XS30KC8KUKC2iOrnKYZ+VfNqI8QrIK2UHhnvxE9BsGCXV6OYhfGu8L4SODQc9ScuJ0A2h4DOguj192C0@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpeyr36LMzB5gh2rQrzO5jGVnr1oN83gWuZzfU21ej+llgDwKo
	+wfU5KgK/8g0qjfi75NiNjymzGu14iVnitqiE9138jGWCfnQC/wYGjqisRq/eNsYjAG59/xOlvC
	mAllO+OMrSw1Rl6BFEmf4tqFEECVGp9yaK0tH7P/u
X-Gm-Gg: Acq92OEHzCPGmNZ92AvuaHwbqW2FKz1Enj1qyOCaqAoXTc459ai8s55f/f8VI18iiLX
	yyH7wpbexwqsL9/7xulJqO24myJ48ksZKNXNg5wZ47tQPIu+O++qafkqIWYVgTH8o+upaJVLMcQ
	/2Qc1d6nBQ+Q87UcSHIaVmb/ffJlsLII4q+6JcOEIalSXPc1tPYVWULFa60jpc49cD+/vNuikxo
	oCkqG5HLqtSNO/B4ZEU3rhpRe4Mh5tuLkSdFFmBOJT8HQ8G9vr+V/y+Xwk5ZBLDXdFgLNw/WJS8
	aRFvlkJMTx70Xucuo+i77cY9LCFwqOatiW1G44XizbPQTrvC
X-Received: by 2002:a17:903:1a2d:b0:2b8:e82d:ff7c with SMTP id
 d9443c01a7336-2bdb32c3f0cmr9316015ad.9.1779290762016; Wed, 20 May 2026
 08:26:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520134004.30573-1-cp0613@linux.alibaba.com>
In-Reply-To: <20260520134004.30573-1-cp0613@linux.alibaba.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 20 May 2026 08:25:50 -0700
X-Gm-Features: AVHnY4KtZnOAHpZqJftZ9HaF6hdfCe1raaXuZ_951WO0YLw8CS266uo-KDA5RoI
Message-ID: <CAP-5=fWApAYb33pSnfW+gRmY7TsPUcfAP1UnBCJW5UpFudpr5A@mail.gmail.com>
Subject: Re: [PATCH v3] perf riscv: Add SDT argument parsing for RISC-V
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, dapeng1.mi@linux.intel.com, pjw@kernel.org, 
	alex@ghiti.fr, guoren@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 6:40=E2=80=AFAM Chen Pei <cp0613@linux.alibaba.com>=
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
> Reviewed-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>
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
> Changes in v3:
>  - Add two Reviewed-by tags.
>  - No actual update, just to re-trigger sashiko's review.

The Sashiko review is green, I think this can be merged.
https://sashiko.dev/#/patchset/20260520134004.30573-1-cp0613%40linux.alibab=
a.com

Thanks,
Ian

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
