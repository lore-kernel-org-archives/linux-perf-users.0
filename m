Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0E9212F86
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2025 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737648943; cv=none; b=DjG2GHuyEHRFIYQaxESmMeFfzj9bcGoKlPsFUfrjEzbbvaZnE8gnKEmpyVIscfdlD+NbkW1QfOJ4Tk5FkTqwxi13jfZXeRT0x5AgbIe66iSmfsYr9n8d4y+ZN5jUT8rYNkIf9EL9lfxTHvOgFts6pA03GWCUtLTcvgj0kf+hyVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737648943; c=relaxed/simple;
	bh=sWb3Cyv6I+HWgEBC2YhkQ8AmThJXOM6FiiGW3+jYoWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=duW6/KBrvV8TrZvp8FvxS4tRkYdoLQJssQcL0momLAuOIKfppOyRPGpHJbbrpp1MtyrBj6cZF1gklQtRxRfmJoYLhID/3xsy/RDqC60f8LChowlPLNNy/86ksZ94uz/HQ6GVmYEkIk94o6AlVAF9A0LOdm48CwPyUGIxov0rHZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=inXpg9iA; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="inXpg9iA"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso138505ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2025 08:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737648941; x=1738253741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oX5waazhkl6YZTYhr5knhySaY3YOmwCWsekYmWtNjQg=;
        b=inXpg9iAen9Z0wB/qBaXcQuEqVf5hZpAleA/8ahhtwyE6Wccc8fVPGk5U2B6slu+xQ
         MI9J/gc9uMFWUdVQnScegNyXfZTUibHwQbfHazhKFsS4bmzjoyYxLjQ5FhS9j+i3Ci7T
         p5HiYmm53SYt1ZJOQTF+YzLnGwijxG6VHNEWWqC36cbxgB8b39mMnPvTfa2UiTptstzv
         r4J/6GVCpMrnMx8BBmbBOg36D0kIQw8seL2zPqvy64CVWVxsbpui67RT/bxU4HXdJTr6
         MLI4OUq5TYUMScgW9af+eVt/GaGD/rmTifpko9WcbPDo2B00dk0bW+gGX+5l1RaHxqo9
         IP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737648941; x=1738253741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oX5waazhkl6YZTYhr5knhySaY3YOmwCWsekYmWtNjQg=;
        b=s8DAKR3BCPm5x2vn8vylcRjgCB9haaGRdaFhgUHVsVHV49/mJfbm/KM3cWjqGdaymB
         1OtqjJi0trG/oePDlVDsVjUDBPU+3Zs7iHOODl8+kbarZ9QS4wkaJjgdnZNk8hBqrxBq
         M/yCBoR6QSGsOnfZTON0JnwwY97YawUDfplgY0hImewe6fR2sAbioQ/PM6fLNYmaBeF4
         hXBkqF2YukNaHtj90M8TEb5IQjYB+GME0hQLVoOjQmc1ZQWFsvBRKCH5vxKpThmiL4LD
         mR+beuAwYKa1aiiXgkz+x+sFQHj2+V6VaXZWDgOsYw6A2lYH+VB/PRwESc4vvWm9P0eJ
         T1qA==
X-Forwarded-Encrypted: i=1; AJvYcCUqIH5ege0yxR9k7Wi9/crv1eG7TTaafP/jtI7w/w/rikRwTp7JVzg/ap9KYTBHt90kNYu/+tVIyvPJj4U2mrft@vger.kernel.org
X-Gm-Message-State: AOJu0YyqQNpGpRXauZeo42gJ86O+nN6UXJ4ugATrXlvqIHREawTisQc5
	sXxYXvYxoD8bca0N17lctJzj1Dt29ktAw6f3dF7z/UfG1pySt8L3JYzFBthl1UOULXO2WQYMNsm
	MG0Y2O9sm/YwvTUBU12pjKmCin1KusyZ3dOsZ
X-Gm-Gg: ASbGnct5OG5nIRY7eeRyf05q3QZ6Kw8tPWebvxYTJdWA1DuK+5OGfVgBhp32ycFo4rg
	aRxOsJMqTvQf5DplAgpJENGOGi4DfRyjdpmBN4QEMZegTxsdAnWr7FhA/b1k5fte141p0qFx9iK
	VOB28RtEM32xmz+Q==
X-Google-Smtp-Source: AGHT+IE4dRIHwDklupjhcoOBGPvWlDevfd1aF/gxc4PDN4ZI7ZrVMfPmXLgWCZvRbgAPyCHAmBh67ZLvfsRMB8ReA2Y=
X-Received: by 2002:a05:6e02:1f81:b0:3cf:ade6:7ffb with SMTP id
 e9e14a558f8ab-3cfbc926b4bmr4384345ab.28.1737648940674; Thu, 23 Jan 2025
 08:15:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com> <20250123140721.2496639-18-dapeng1.mi@linux.intel.com>
In-Reply-To: <20250123140721.2496639-18-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 23 Jan 2025 08:15:28 -0800
X-Gm-Features: AWEUYZlcE9eGXBebq67xpO-gd2iY0iu5DHB6Jt50eGLf7g9NgQKCPf7nb1pAQ-Y
Message-ID: <CAP-5=fV-+3dU1CtUAYazv5L6VfNwDxv1C9Q=tQXzve9nqpaqrw@mail.gmail.com>
Subject: Re: [PATCH 17/20] perf tools: Support to show SSP register
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 10:21=E2=80=AFPM Dapeng Mi <dapeng1.mi@linux.intel.=
com> wrote:
>
> Add SSP register support.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  tools/arch/x86/include/uapi/asm/perf_regs.h    | 4 +++-
>  tools/perf/arch/x86/util/perf_regs.c           | 2 ++
>  tools/perf/util/intel-pt.c                     | 2 +-
>  tools/perf/util/perf-regs-arch/perf_regs_x86.c | 2 ++
>  4 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/tools/arch/x86/include/uapi/asm/perf_regs.h b/tools/arch/x86=
/include/uapi/asm/perf_regs.h
> index 7c9d2bb3833b..158e353070c3 100644
> --- a/tools/arch/x86/include/uapi/asm/perf_regs.h
> +++ b/tools/arch/x86/include/uapi/asm/perf_regs.h
> @@ -27,9 +27,11 @@ enum perf_event_x86_regs {
>         PERF_REG_X86_R13,
>         PERF_REG_X86_R14,
>         PERF_REG_X86_R15,
> +       PERF_REG_X86_SSP,

nit: Would it be worth a comment here? SSP may not be apparent to
everyone. Perhaps something like:
```
/* Shadow stack pointer (SSP) present on Clearwater Forest and newer models=
. */
```
>         /* These are the limits for the GPRs. */
>         PERF_REG_X86_32_MAX =3D PERF_REG_X86_GS + 1,
> -       PERF_REG_X86_64_MAX =3D PERF_REG_X86_R15 + 1,
> +       PERF_REG_X86_64_MAX =3D PERF_REG_X86_SSP + 1,
> +       PERF_REG_INTEL_PT_MAX =3D PERF_REG_X86_R15 + 1,

nit: It's a little peculiar to me the "+1" here - but that's
pre-existing. Perhaps comments above here too:
```
/* The MAX_REG_X86_64 used generally, for PEBS, etc. */
PERF_REG_X86_64_MAX =3D PERF_REG_X86_SSP + 1,
/* The MAX_REG_INTEL_PT ignores the SSP register. */
PERF_REG_INTEL_PT_MAX =3D PERF_REG_X86_R15 + 1,
```
Otherwise:
Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>
>         /* These all need two bits set because they are 128bit */
>         PERF_REG_X86_XMM0  =3D 32,
> diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/u=
til/perf_regs.c
> index 12fd93f04802..9f492568f3b4 100644
> --- a/tools/perf/arch/x86/util/perf_regs.c
> +++ b/tools/perf/arch/x86/util/perf_regs.c
> @@ -36,6 +36,8 @@ static const struct sample_reg sample_reg_masks[] =3D {
>         SMPL_REG(R14, PERF_REG_X86_R14),
>         SMPL_REG(R15, PERF_REG_X86_R15),
>  #endif
> +       SMPL_REG(SSP, PERF_REG_X86_SSP),
> +
>         SMPL_REG2(XMM0, PERF_REG_X86_XMM0),
>         SMPL_REG2(XMM1, PERF_REG_X86_XMM1),
>         SMPL_REG2(XMM2, PERF_REG_X86_XMM2),
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index 30be6dfe09eb..86196275c1e7 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -2139,7 +2139,7 @@ static u64 *intel_pt_add_gp_regs(struct regs_dump *=
intr_regs, u64 *pos,
>         u32 bit;
>         int i;
>
> -       for (i =3D 0, bit =3D 1; i < PERF_REG_X86_64_MAX; i++, bit <<=3D =
1) {
> +       for (i =3D 0, bit =3D 1; i < PERF_REG_INTEL_PT_MAX; i++, bit <<=
=3D 1) {
>                 /* Get the PEBS gp_regs array index */
>                 int n =3D pebs_gp_regs[i] - 1;
>
> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_x86.c b/tools/perf/=
util/perf-regs-arch/perf_regs_x86.c
> index 708954a9d35d..9a909f02bc04 100644
> --- a/tools/perf/util/perf-regs-arch/perf_regs_x86.c
> +++ b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
> @@ -54,6 +54,8 @@ const char *__perf_reg_name_x86(int id)
>                 return "R14";
>         case PERF_REG_X86_R15:
>                 return "R15";
> +       case PERF_REG_X86_SSP:
> +               return "ssp";
>
>  #define XMM(x) \
>         case PERF_REG_X86_XMM ## x:     \
> --
> 2.40.1
>
