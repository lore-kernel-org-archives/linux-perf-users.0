Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234483E4C85
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Mar 2026 15:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773761557; cv=pass; b=TlIwbthsN7+uKjUpLB2TqB4fMfHfT6gsLKD7QToeDJFxtyZGBFK7c6359q5gNx/Rvq6lx913ci3ffOsw+znxudVrzJ2V3uMgai5+lOFU5SQO8cuDE52NX28orfgtSa/ovNGm2y7eq779gU0rpyHkDNE/vogiHC26iaJ0enLHmlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773761557; c=relaxed/simple;
	bh=ApEZkM0jYqujC4X9S2HoQoK9lEJKjGaSsk15Iej8Ogw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uzr2agufDKUq0ZwLxIqpJI9oxaBQwOugUF+ZlfoW8/rEL1LOQ/HVVg0GM4JK4Kh6alLpa8jY2sddWoE0V8CO0uiRBBj00RQH9+8Ia1m2Jjls15m2kTImu4O2LR1/+sPoGowoOJjWhr//iMXAzFDUUbAJ+KZ7tnLkOkAJ543au/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J1kmbtSl; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J1kmbtSl"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b052562254so100825ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Mar 2026 08:32:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773761555; cv=none;
        d=google.com; s=arc-20240605;
        b=P3c6XABHgY3vPkvnoXaxeGs+ZBuHLJUf8h9lnT1eo3qRGuZ3eocK8JfKI1jw70XZzC
         nDEKdAZlQkUPjUyaaMEMUsL+YPxc3WmsB+afb7tys4VxXwfU4rNy+TnaR9U3dUmhIGNC
         0b+t0JhYh5tU5rRmgbwqSJ7BNkpp47/H7Tr420mvbR8p55fbb9WU4DvRafGlQ7giPUAO
         kjKZq3Fbr5bUP/haxKzafK8D4kcR8HnCDT+morcW+kh5liAedQattbpStX7opjQ0Lwkm
         mU3O10bCPaabpXEDo5otpdmpPkHwwYmdZN2+YOelr/cTW2ZHD2lm4AOKYDDhdUxedImR
         75EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BhkaLEEGAixAQMrvos9+dLptA5RYw1Pl3uUnTFzQa/M=;
        fh=hxqzQXo4ZcrYXTVx0rXq8QYuP8tzifoG3EoZzkSrL70=;
        b=iCcLkRXkX696hRREOW/jhJFGdBcDuVny7wMgIRRMDLEHGi6q9eCAtMdrwGc81FsKY+
         iB8sJEMl5oSGFhqYwXIZgN/MUtGAr7rJTz55DxPTYjjcr/tOAWneJ9NOgIYvQjNHo6ug
         XlqXKuOmXOaSXNWN1xmudMwCD42aVMUSxHjrUma+GKQN7A+rrPi/o1Jbwwomzbwlu8C0
         w3ghmzLQK30gKlV374+L8609AEHsuuU1+nX2YvsZJrOGZ9TyPSZ66jhcVjjeh4k6Mx9L
         ZQuCukca1i48nC7bB/ySTxWy2flCBTaiUG1Mer+S+A7jEDBo+/FyKsGskT9Pb0LDVGiC
         V0Bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773761555; x=1774366355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhkaLEEGAixAQMrvos9+dLptA5RYw1Pl3uUnTFzQa/M=;
        b=J1kmbtSlA9gr4SX9xWNgAorkqiPgNF01ANyakTlWoXO+b+t9U5itXPwzBr+2dqu6Zv
         EUmFsoLCcgx0OtiNUAA1+MioFPpBSESqY8P3qtY6GDpkxviHhJbf3l1YurFDo3t5U9h7
         eO6pdYUtlB0pTTbLygak0LF1k86mDYoQt9DeEMh+iPMiDXvyApJbAxxMwo4VvtmghQWA
         ShQxfgNLLev+XycVqNPR7RrMQtgh/0TU5PH1lI4/MJFGQQuk8cWnxHSlM+FDVUkmhEx9
         aFpZtpFp5ywxuZDuuC4oTThFkbTvYUsDQQsGrImIbwo3mKWELSPx86uv6YoyQYPCkzIa
         OkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773761555; x=1774366355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BhkaLEEGAixAQMrvos9+dLptA5RYw1Pl3uUnTFzQa/M=;
        b=UjfC0x00yE1sj3XJfUIYIpQ92rJ9K5YgQh+7gBHzzGlursXHvHvjc5442jMMNOgBfy
         BQ6faBOYC3sJfMXrThD5137WMPApMXxLOe2mSK4SSOgt/HtvE7Zl2gH5bn7ecMX8p+/Q
         HMpKDHGmqCToT48JZgMk+ZQ187Q4gHlNf/gH81C5iEXYo06mrMsSnzBLwz81CP01jsjI
         +MJTFUm7UGc1WlDJJDteMfO3NPaBrNm9DfUgUjZ8gWSuO7ndKCAj81CvUoId2RXLJM9N
         3cfqrDZkKGI//SzuGHEyZjOlWaV97ilQaH53UTOOfgvRJM/114E3WGDNL6L6hdGIAwig
         bVMg==
X-Forwarded-Encrypted: i=1; AJvYcCURPlnmcT6bnkTZrCak0Biap7+qmg7zXWRBq6rFtYlX3OhoO5j250DRjtRHZvLjdXq8yMTMEU+e/+5O0TZHUlgg@vger.kernel.org
X-Gm-Message-State: AOJu0YwNjp1JIEmLLt7z/UKsR9KsY6d6ZMvic+HuO2noX6I+Y8kR9ylX
	gIlz1B9hJYr3k7Sq/dbbDQw5Dyot+ePfUrwOdTtHO0w6OlXB/foVqfjQ9XYEBRvFPsPLRhChiPu
	X+4eJNTzjTAlC8bBxLF4g8MaOWLlBERHHSyczDhog
X-Gm-Gg: ATEYQzxUlBozPrp3Kd+4qJWu6yw+QenAJaXx008v9q7RPDJH5G2ms1wsRXtM8s5I195
	LYiCp2PHIiPJhuXqmmHxwifCwCmfWsqdhzeGO5zGuBy3MQZUoAXvWx2hihnrTRhYM67AAV1Ysh4
	enuNvhDzpbLO+n1An1GHuAtf9ixp5AXAYIrZ6tJmP/BvkSom3oaZ8DyN4OUqNF8hMGOvWKGBQPh
	YtnQjH/S1fFuYA9/NaNq0bOJHXF+1FGiUjuzWaYu0o6uGUXntSc6h4T/th8MaZ7tR618XLEsq0Y
	w8BRf/Da
X-Received: by 2002:a17:903:2284:b0:2ae:c566:bd99 with SMTP id
 d9443c01a7336-2b064050a74mr3541605ad.22.1773761554698; Tue, 17 Mar 2026
 08:32:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317110641.39975-1-tmricht@linux.ibm.com>
In-Reply-To: <20260317110641.39975-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 17 Mar 2026 08:32:23 -0700
X-Gm-Features: AaiRm51sDcxb0oBkf_9EcnaMRntY3oFxYJD4ORK821DJdA0cyvTGiNKYUS_CPhs
Message-ID: <CAP-5=fWL=ium-_+aXe1TfTADuThv1T43hh2RWb+MV2pyZSf8tg@mail.gmail.com>
Subject: Re: [PATCH v3] perf record: Add support for arch_sdt_arg_parse_op()
 on s390
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	dapeng1.mi@linux.intel.com, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 4:06=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> commit e5e66adfe45a6 ("perf regs: Remove __weak attributive arch_sdt_arg_=
parse_op() function")
> removes arch_sdt_arg_parse_op() functions and s390 support is lost.
> The following warning is printed:

Apologies again for this breakage.

>   Unknown ELF machine 22, standard arguments parse will be skipped.
>
> ELF machine 22 is the EM_S390 host. This happens with command
>   # ./perf record -v -- stress-ng -t 1s --matrix 0
> on a z/VM system when the event is not specified.
>
> Add s390 specific __perf_sdt_arg_parse_op_s390() function to support
> -architecture calls to arch_sdt_arg_parse_op() for s390.
> The warning disappears.
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Tested-by: Jan Polensky <japo@linux.ibm.com>
> ---
>  .../perf/util/perf-regs-arch/perf_regs_s390.c | 89 +++++++++++++++++++
>  tools/perf/util/perf_regs.c                   |  3 +
>  tools/perf/util/perf_regs.h                   |  1 +
>  3 files changed, 93 insertions(+)
>
> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_s390.c b/tools/perf=
/util/perf-regs-arch/perf_regs_s390.c
> index c61df24edf0f..2aa70eb23311 100644
> --- a/tools/perf/util/perf-regs-arch/perf_regs_s390.c
> +++ b/tools/perf/util/perf-regs-arch/perf_regs_s390.c
> @@ -1,7 +1,13 @@
>  // SPDX-License-Identifier: GPL-2.0
>
> +#include <errno.h>
> +#include <regex.h>
>  #include "../perf_regs.h"
>  #include "../../arch/s390/include/perf_regs.h"
> +#include "debug.h"
> +
> +#include <linux/zalloc.h>
> +#include <linux/kernel.h>
>
>  uint64_t __perf_reg_mask_s390(bool intr __maybe_unused)
>  {
> @@ -95,3 +101,86 @@ uint64_t __perf_reg_sp_s390(void)
>  {
>         return PERF_REG_S390_R15;
>  }
> +
> +/* %rXX */
> +#define SDT_OP_REGEX1  "^%(r([0-9]|1[0-5]))$"
> +/* -###(%rXX) */
> +#define SDT_OP_REGEX2  "^([+-]?[0-9]+)\\(%(r[0-9]|r1[0-5])\\)$"
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
> +       initialized =3D 1;
> +
> +       ret =3D regcomp(&sdt_op_regex2, SDT_OP_REGEX2, REG_EXTENDED);
> +       if (ret)
> +               goto free_regex1;

Sashiko's review:
https://sashiko.dev/#/patchset/20260317110641.39975-1-tmricht%40linux.ibm.c=
om
notes that here 'initialized' will still be 1, should it be made 0 again?

It triggers an ENOMEM, so I doubt this will be very useful, but it may
make the code read better.

> +       initialized =3D 2;
> +
> +       return 0;
> +
> +free_regex1:
> +       regfree(&sdt_op_regex1);
> +error:
> +       pr_debug4("Regex compilation error, initialized %d\n", initialize=
d);
> +       return ret;
> +}
> +
> +/*
> + * Parse OP and convert it into uprobe format, which is, +/-NUM(%gprREG)=
.
> + * Possible variants of OP are:
> + *     Format          Example
> + *     -------------------------
> + *     NUM(%rREG)      48(%r1)
> + *     -NUM(%rREG)     -48(%r1)
> + *     %rREG           %r1
> + */
> +int __perf_sdt_arg_parse_op_s390(char *old_op, char **new_op)
> +{
> +       int ret, new_len;
> +       regmatch_t rm[6];
> +       unsigned long i;
> +
> +       *new_op =3D NULL;
> +       ret =3D sdt_init_op_regex();
> +       if (ret)
> +               return -EINVAL;
> +
> +       if (!regexec(&sdt_op_regex1, old_op, 3, rm, 0)) {
> +               /* Extract %rX */
> +               new_len =3D 2;    /* % NULL */
> +               new_len +=3D (int)(rm[1].rm_eo - rm[1].rm_so);
> +               *new_op =3D zalloc(new_len);
> +               if (!*new_op)
> +                       return -ENOMEM;
> +
> +               scnprintf(*new_op, new_len, "%.*s",
> +                         (int)(rm[1].rm_eo - rm[1].rm_so), old_op + rm[1=
].rm_so);

Sashiko notes this is probably more of an issue:

The allocation size accounts for a % character, but the scnprintf format
string "%.*s" seems to omit it.

Will this output r1 instead of %r1?

> +       } else if (!regexec(&sdt_op_regex2, old_op, ARRAY_SIZE(rm), rm, 0=
)) {
> +               /* Extract #(%rX) */
> +               new_len =3D 4;    /* (%)NULL */
> +               for (i =3D 1; i < ARRAY_SIZE(rm) && rm[i].rm_so !=3D -1; =
++i)
> +                       new_len +=3D (int)(rm[i].rm_eo - rm[i].rm_so);
> +               *new_op =3D zalloc(new_len);
> +               if (!*new_op)
> +                       return -ENOMEM;
> +
> +               scnprintf(*new_op, new_len, "%.*s(%.*s)",
> +                         (int)(rm[1].rm_eo - rm[1].rm_so), old_op + rm[1=
].rm_so,
> +                         (int)(rm[2].rm_eo - rm[2].rm_so), old_op + rm[2=
].rm_so);


Similarly, does this scnprintf format string "%.*s(%.*s)" need a %% charact=
er
to produce the correct uprobe format? As written, it appears it will output
48(r1) instead of 48(%r1).

Thanks,
Ian

> +       } else {
> +               pr_debug4("Skipping unsupported SDT argument: %s\n", old_=
op);
> +               return SDT_ARG_SKIP;
> +       }
> +
> +       return SDT_ARG_VALID;
> +}
> diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
> index 5b8f34beb24e..f52b0e1f7fc7 100644
> --- a/tools/perf/util/perf_regs.c
> +++ b/tools/perf/util/perf_regs.c
> @@ -23,6 +23,9 @@ int perf_sdt_arg_parse_op(uint16_t e_machine, char *old=
_op, char **new_op)
>         case EM_X86_64:
>                 ret =3D __perf_sdt_arg_parse_op_x86(old_op, new_op);
>                 break;
> +       case EM_S390:
> +               ret =3D __perf_sdt_arg_parse_op_s390(old_op, new_op);
> +               break;
>         default:
>                 pr_debug("Unknown ELF machine %d, standard arguments pars=
e will be skipped.\n",
>                          e_machine);
> diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
> index 7c04700bf837..573f0d1dfe04 100644
> --- a/tools/perf/util/perf_regs.h
> +++ b/tools/perf/util/perf_regs.h
> @@ -62,6 +62,7 @@ uint64_t __perf_reg_mask_s390(bool intr);
>  const char *__perf_reg_name_s390(int id);
>  uint64_t __perf_reg_ip_s390(void);
>  uint64_t __perf_reg_sp_s390(void);
> +int __perf_sdt_arg_parse_op_s390(char *old_op, char **new_op);
>
>  int __perf_sdt_arg_parse_op_x86(char *old_op, char **new_op);
>  uint64_t __perf_reg_mask_x86(bool intr);
> --
> 2.53.0
>
