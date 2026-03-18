Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE4213D638
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Mar 2026 16:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773852370; cv=pass; b=M4slUXw2T2k+iejwEkOb9zAHdpyPPQZbYK8JqXd5tgu8TOELkpKWn1ZZ3q6/tfilJ3UI1UtG/l2e9JmX68HwTU4WTR2VHpy9iZl5BrAkQWWFYP9ZIFBOrnePnZKD5d8DYTVHEc/qfpLo0NWG13686X6hP6+P8Mhdau/6YqMBqR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773852370; c=relaxed/simple;
	bh=Q4n9jfZEAODE1uo4fvDs2z8RWAST35w1xfTU2vLeq+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=llpTeB2Y/fBRdluUclQFMWvIZmJXkDEu0eOykOKrtVtk/NTxrDUn0Yd+2FJiEGhKoKZeuo2J7LQmwm3sT74UeeK6486k3V+1kjKrfcJTVXj4CNFfqskYzUq4aOm2+PREQL249tCMCu2nbmif/yATWCwy/BH1/AaOpAf/lGhILww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pBqA4G3W; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pBqA4G3W"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2aeab6ff148so107635ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Mar 2026 09:46:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773852366; cv=none;
        d=google.com; s=arc-20240605;
        b=lBfWyJmqEKFZ5UYbVGG+IZwBVi3OwYQHx4MNihYwO9t8rDYREEqeLui2bdavTv7oxD
         KeWL6To522FYmjIavGYoWeXJwbWYHDuCV4uVa2BY9zJ2/rXW9UzYkhR35eq5seBlizhI
         CF3Z1Nzg03OjN1YDOkR6JOBuhHFUgrEhJQOqIGMXyXavkAMMavhrtEEL30kEwcnO6kH0
         Wdp7VKWB1vDlNOiLomoYwPE3JGMYBpM6rkxFpK5DTYL7ocFSgQBoGKagcaea5Ju5/ckB
         TUtThXJhmkH/vVsodmHjQAZYD1n9Hw77GEqfkHscAxjH4VqKupy+VrrRbHM/bQzG1kpp
         +Arw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7h9KC5mHA+CbPkZHaMGK+FJap31XVl4YArpJmwoyUIc=;
        fh=HC2J0xo+N8nQIYHzZsqEkAxEvYWk8hsclSNwXOQWi6c=;
        b=KQauj724neaIxD3At0RtQFdsnilQtCd9A/6NAc7Ktjtlh7IeboZzjnukZhtAX1qS+s
         CRSYQXh01Qw80jOqupeEJItKK0vBNakDT7B0th/5YHjeStWN9CsYJJTP776qJSSFf+su
         X4E/48Os/iqxfR1fhw8zjg6mqjCk8UNkZamYxcQRrB10kS1Ympuzl3oCfFnhWoDTBURm
         sMlfxyw3cOuELJ9kODU1yb3rWSXpmrwS0+SJqwXNMhsGuH8kODqJIjFzY5HRAO862EXz
         TKolSJCxEk3BHenz0Nz4g9FKWOpym51LbNJ3T/4Uqg3Llzh4eqcj6RXKNreh3pj5/Jmx
         z9jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773852366; x=1774457166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7h9KC5mHA+CbPkZHaMGK+FJap31XVl4YArpJmwoyUIc=;
        b=pBqA4G3WJkDXRdlvtxYGecRm6715w2U3T9x0RYcoUxonwyEI7S+untbP3XLiudYMZ5
         GHRjg6Gq/IFWDM/CZOMRDppKdMsZsU5L5IaRwzeDgGQmjOFJW0FTh5eLYjsU6bX4GHoo
         loEvtstqaMdiaZ+VUgch+Jl/qKRuZhCk0V6wkUymjUFuVcPw5s+/9oMhsl1uSB3+Sk1w
         im4qg/ASdcmzKJ8Zccoi3Ae0uDRKuxNhHcay89wT1QM/YTdJhVm0G/XyJeRUEx/ScmGw
         eUDpJcOLricHGkKiI6CncXfjbsnC4AXINYy6bQK6ryEoZx2IhkEgRsQlgLmdbF9Idd89
         9WxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773852366; x=1774457166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7h9KC5mHA+CbPkZHaMGK+FJap31XVl4YArpJmwoyUIc=;
        b=Dkq3No/3ixKJ4e7IhB5uB6JPxqGLm2je77vYJNjG1AZSuBFUTuZMZWYs/Fgtz4wEUC
         j8glZTdJ/gvJjei+eTQhLv/L56fKxC0KGIynxFCSevXFi5b/iQFzRCUZ68L1ASXc1h9p
         R/I7OeNVZitgQcgkDTE0rtplXr0xWDprfnI0fZlP+hFUKSHQR0MO/tCLXmdupBPMdw/u
         XykSoUtJAIcp+nkHI9T2WaehZ0okIIBqCKqipT8XpFAs6fRFoPKUJ2em10qeFDnxSg1B
         BTN/dHbEI2nf0KpbXWItSa6b6x32O7z+XIMZKIvz1eAB8SvvJClxJ48IAkYjIs799h4P
         069A==
X-Forwarded-Encrypted: i=1; AJvYcCW46j7X5Vy+T8msk39JnzEMfuWAXpCfcX64xDlfMuol5XIRtCXShjXMXF5twgT8f5ceuoaMhk6GY7lnYXAz8356@vger.kernel.org
X-Gm-Message-State: AOJu0YyUac6UdL4suhpmdQQjvn2EsJgBQR9W70B+9T7ISQYiH0iv0paV
	yFHEn7SDESljAk/KlwaQBxaVrUXY9w1U/Jd/UJ4F3zpZFsyuIGqVAJoO4901k0SfIW3rkH/VXpz
	5drIYMQT6cPmmlZ4PNYEpa6J4I/O4V3dIFXD8BiC3
X-Gm-Gg: ATEYQzxBSkoHkGhEP3YGQRIIXK/4eO4JWDpc+a4GZr+iKzXJnll+JCnBeG+/qpb0O6g
	TgIwTKC9jawTRK2/aHVRg0TROGGqC90hLxuNkdacPkJcV8vUqcEZ8j+5KvZ5NT8XdxzK27KOQP3
	So1iwq4OzeXHWXdEnhutDyfBf0BcsccwTq6MQI6uHsHTa0ygNCAVsAT0L3LSRxFSxSrhDJONl7h
	KLypYAHv6L2+hSNf1/fBJlCyNiEYDKkyqIkA7iL+ho0nCZbinLvRLffEBlZKtvTbogjWrJ5X7O8
	qwRElajQ
X-Received: by 2002:a17:902:e842:b0:2a7:87c2:fcde with SMTP id
 d9443c01a7336-2b06f8883fcmr3321175ad.15.1773852365387; Wed, 18 Mar 2026
 09:46:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318113416.2287472-1-tmricht@linux.ibm.com>
In-Reply-To: <20260318113416.2287472-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Mar 2026 09:45:53 -0700
X-Gm-Features: AaiRm53GC4iacG1vFNkmqVI2i4dw_Y9i8i-2ZL7WbfewzUDPVNuuzk42Zh4o4S0
Message-ID: <CAP-5=fWV1LemkYe7684CNmWTEBFe-U=CgSgG90-x4c3=KC3vpA@mail.gmail.com>
Subject: Re: [PATCH v4] perf record: Add support for arch_sdt_arg_parse_op()
 on s390
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	dapeng1.mi@linux.intel.com, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 4:34=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> V4: Add comments from Ian and Sashiko:
>     Reset variable initialized to zero on error
>     Rework regular expression and reduce to one case.
> V3: Add comments from Ian
>     Print register expression without leading 'r' (wrong).
> V2: Add comments from Sumanth Koirkkar

nit: these need to be placed after a line of "---" so that git mailbox
won't include it in the commit message.

> commit e5e66adfe45a6 ("perf regs: Remove __weak attributive arch_sdt_arg_=
parse_op() function")
> removes arch_sdt_arg_parse_op() functions and reveals missing s390 suppor=
t.
> The following warning is printed:
>
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

Reviewed-by: Ian Rogers <irogers@google.com>

> ---
>  .../perf/util/perf-regs-arch/perf_regs_s390.c | 77 +++++++++++++++++++
>  tools/perf/util/perf_regs.c                   |  3 +
>  tools/perf/util/perf_regs.h                   |  1 +
>  3 files changed, 81 insertions(+)
>
> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_s390.c b/tools/perf=
/util/perf-regs-arch/perf_regs_s390.c
> index c61df24edf0f..9d34549be477 100644
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
> @@ -95,3 +101,74 @@ uint64_t __perf_reg_sp_s390(void)
>  {
>         return PERF_REG_S390_R15;
>  }
> +
> +/* %rXX */
> +#define SDT_OP_REGEX1  "^(%r([0-9]|1[0-5]))$"
> +/* +-###(%rXX) */
> +#define SDT_OP_REGEX2  "^([+-]?[0-9]+\\(%r([0-9]|1[0-5])\\))$"
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
> +       initialized =3D 2;
> +
> +       return 0;
> +
> +free_regex1:
> +       regfree(&sdt_op_regex1);
> +error:
> +       pr_debug4("Regex compilation error, initialized %d\n", initialize=
d);
> +       initialized =3D 0;
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

nit: Sashiko notes this comment may be stale:
https://sashiko.dev/#/patchset/20260318113416.2287472-1-tmricht%40linux.ibm=
.com

This isn't a bug, but the comment mentions converting the OP into the
+/-NUM(%gprREG) format. Is this a leftover copy-paste from the PowerPC
implementation?

The actual s390 implementation correctly parses and outputs the %rREG forma=
t
as shown in the examples.

Thanks,
Ian

> +int __perf_sdt_arg_parse_op_s390(char *old_op, char **new_op)
> +{
> +       int ret, new_len;
> +       regmatch_t rm[6];
> +
> +       *new_op =3D NULL;
> +       ret =3D sdt_init_op_regex();
> +       if (ret)
> +               return -EINVAL;
> +
> +       if (!regexec(&sdt_op_regex1, old_op, ARRAY_SIZE(rm), rm, 0) ||
> +           !regexec(&sdt_op_regex2, old_op, ARRAY_SIZE(rm), rm, 0)) {
> +               new_len =3D 1;    /* NULL byte */
> +               new_len +=3D (int)(rm[1].rm_eo - rm[1].rm_so);
> +               *new_op =3D zalloc(new_len);
> +               if (!*new_op)
> +                       return -ENOMEM;
> +
> +               scnprintf(*new_op, new_len, "%.*s",
> +                         (int)(rm[1].rm_eo - rm[1].rm_so), old_op + rm[1=
].rm_so);
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
