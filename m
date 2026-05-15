Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5BC413D7D
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 19:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778873942; cv=pass; b=f6s41upGvHoRKn115yGhjhcUiK+04+Fbe8v8pN6o+RyfyxeJvMoprdyQUM3ejeyxml0f75/KW7qXnIlRWwhyQRkAruTl6bmy1VU0rQjV47bMtwvxubOghNGcIHhYd/IoUtfGACJd9wbEiWAECgHvAvRWbp31+R0Xpc4yl1jo8w4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778873942; c=relaxed/simple;
	bh=WR5bp1LsNTW9M1tofRsvvvdifdyvNdMGPhJIgD2eseI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eRTCg7raVbwLdLvBirrk7ZRQLzNIuDGxpswO705LPWq8/u/+YmCbdbmDkOcs+KrUZLMlqhLQleaMCNgWYtSE6C2BIz5/Xyfw3f48Iu8hywS05hsiiBKiN+Tzno2zAhvIjGC37LfvZDmAs+/F5cjbJYaInZBKMZXFX54BOGVJbXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C7x0juWp; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C7x0juWp"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba180a022dso6465ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 12:39:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778873940; cv=none;
        d=google.com; s=arc-20240605;
        b=jkhLYTgI58mdXK5Iu/HFLyNGHKJvquXZPOLg0ZRoFpXSS8gz6oOxj8LopG6G88TeQT
         C6wlKcLel+2615Z0TDLnMk7oa4kM7rMjjvP/6eF8nZGjSJcngbNzl0KJBf/XKb6aQJQh
         sEvQj7uoRoMmAu8TIS71cJGwlXunrZ3X/DpPqjDVCkDvLnp4ZbkS8K92fVGUJqsyX2bA
         FinVRE+Gkr4/NCzoEBvGu3Q0rdtTzCCJDjLBxRbhgw+eiOfAvFodEy0R1+DQElRuiz97
         nHIGnOzdP+FLXzH6XC6vsRUq1s6WcxaYbczdR7T0ZVS1tRfEWMAzFkdXhr0BZFRycF/v
         vicg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IYpIIZ9l/Mh5nFdtuzxg/eCZabaH9dxjddO1/8L86VA=;
        fh=E3WYJKUQyrdM9AyjUR1+p9k8kffaVm3XkqHL0vHv2Vs=;
        b=L0giWNkMlXGba7AAB1hHfPQnh7cR9hIvwRpk43X6LvqSagMnHIGI9gNLxNA8i+Z4A9
         5RQ7fV9tll4oo0KhNR68Yr2xfXfj6GOoC3n7idlQrdYxOKCLr4sY494UtZrUWqv0qv1O
         XXDT8CiDV2LtP196acyqrOK43SI9BALHQmXb07Hz+635Q0NaP6eO8NSjzlX1TULIfznN
         wvd1fhnxlMpOS9VcWxjQsl6pybEz27a8d4Rv/H05U8PfcAv5NxskBkrl6QhbnPetNeus
         8z0bzo0Uw5kcsPKH6E3FhgkCpLZ2NmgF2gsO4huB/1E11MjPGRwAc6wePRwKVkpZ2/kb
         QIRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778873940; x=1779478740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYpIIZ9l/Mh5nFdtuzxg/eCZabaH9dxjddO1/8L86VA=;
        b=C7x0juWp0p42nOF2zqJ86seZCKZUBkRBy4ta7A/OTFizAdIYgTOQcgqVbSUd8VBJCU
         5gXTyNAQ9lNdHp2krNJnK0ujiAPxwSMeE0493pazG6f5nzjVJ5Dcw6Ic/agSEYHxMz9O
         w1JveCeZbZSTtvIMfrdNLDesG6AjALPff1EV0xyPKMelT5/bmvlefsUJQm/KqMIRoMCf
         JbWYaSpj9W6ouT/J2hzWs4xTnGwNSI87ZmzXz8c8yfBKq+dbSxUzr48OBDf4bLyHAZnV
         GUuwodUW+WKypFLCxEe6fXjkiJ80lphNW8KKJ/Ih/dH4YCnbdvlsfX4Lhow+EYBM4zNj
         6hmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778873940; x=1779478740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IYpIIZ9l/Mh5nFdtuzxg/eCZabaH9dxjddO1/8L86VA=;
        b=pVSwXY3HdRMBM+zA1CzXQgE2VCyFT9YARJm51YUn1DkQGM5c58/tVNy7k7Mfpa7jJm
         krH7o+LY50F20klVu47TdP7ZD4MBiQcwgygpZ03xl5fDn9e5n3oDeyn/NtfSbWz1Nj8x
         7KYNigVtZoXPwLXhJS4dhy9r/Uelra7A7A9J/89tkOPAKOAEN848x7n3fGLXybF1YWBw
         WskHMpfIp5cxF43Yjptz0s6+Y12MjhAaRO3qqGkgDjOSnp9E4Olw7KrvRaaSrwooyXVY
         snnoZzTxGhXe+S/D9S83fBFEbKTFDTcIfXeJxog3lDejGGPrY8DrBW8pAucdGQsM4oIc
         ECmg==
X-Forwarded-Encrypted: i=1; AFNElJ/+xxHNETTb0i8qjZ3Zyaw81M8KUc0ydOPCpicxnBIC1xv+G8Kv3KemYDmneb1tiJektyrbxAArut6+ld1h/V2C@vger.kernel.org
X-Gm-Message-State: AOJu0YytIMtcybw3nKPJI1yA1NtcweO8fK000ehDgJ16E1pSmv1RtWIq
	iCeuGdVATIBmibI2uB9TIZCzBoqUFcDz5MQo+j9HRZlh6hHZ/UHDdk2SBFXpMzNmwiDT1KOPhk0
	K1lQe3PRWiqq4UgyWBM0QgyC7AXv5TySk2mLHNBhx
X-Gm-Gg: Acq92OGyXQbmhFMk3C/n3yw8C3HMlEh5yxmSVPsKXjZHyEtx5lZmciyj7cm8ELhcFHX
	rOnS/AUjUavec3JKcjwLcur1mhqq5jqtArn5UVKF5QPGl5rS9u7+uMph0HQzmHQ2X3/T9mbFG8D
	obGylc88qDM9nwiE0hUZeJnzE1eEIdumbptSoxvWvlI9LrMNqKpIhAxwNb0k/WRXmogdORlnS6p
	8+Ljh7U0a7KTeyLyjOIV7r7HLPFje0jaJWxN3hqMp3oGeM5E/EQlY4j6XUFXK+y8brY7xSboPJZ
	XpJRoDkFAiLcyh/iqaU=
X-Received: by 2002:a17:902:d502:b0:2bd:bbe:e3a3 with SMTP id
 d9443c01a7336-2bda0d8369amr548535ad.10.1778873939803; Fri, 15 May 2026
 12:38:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413024805.1316480-1-irogers@google.com> <20260513233151.572332-1-irogers@google.com>
 <20260513233151.572332-5-irogers@google.com> <agdyluuau3wPQOtX@x1>
In-Reply-To: <agdyluuau3wPQOtX@x1>
From: Ian Rogers <irogers@google.com>
Date: Fri, 15 May 2026 12:38:48 -0700
X-Gm-Features: AVHnY4Lb9u9dPRlfZ_lWNCr7BMoBHYS17-9qKyqj0HY7xDzks8g3D3teRStrsVs
Message-ID: <CAP-5=fUeGOSH1LO1oSbWnpmXfv_RzxfFE+YCQ07PC19gLHDEsA@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] perf unwind-libunwind: Make libunwind register
 reading cross platform
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, namhyung@kernel.org, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Li Guan <guanli.oerv@isrc.iscas.ac.cn>, 
	9erthalion6@gmail.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	andrew.jones@oss.qualcomm.com, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	howardchu95@gmail.com, john.g.garry@oracle.com, jolsa@kernel.org, 
	leo.yan@linux.dev, libunwind-devel@nongnu.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
	mingo@redhat.com, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	shimin.guo@skydio.com, tglozar@redhat.com, tmricht@linux.ibm.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 12:23=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, May 13, 2026 at 04:31:48PM -0700, Ian Rogers wrote:
> > --- /dev/null
> > +++ b/tools/perf/util/libunwind-arch/libunwind-ppc32.c
> > @@ -0,0 +1,31 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +#include "libunwind-arch.h"
> > +#include "../debug.h"
> > +#include "../../../arch/powerpc/include/uapi/asm/perf_regs.h"
> > +#include <linux/compiler.h>
> > +#include <errno.h>
> > +
> > +#ifdef HAVE_LIBUNWIND_PPC32_SUPPORT
> > +#include <libunwind-ppc32.h>
> > +#endif
> > +
> > +int __get_perf_regnum_for_unw_regnum_ppc32(int unw_regnum __maybe_unus=
ed)
> > +{
> > +#ifndef HAVE_LIBUNWIND_PPC32_SUPPORT
> > +     return -EINVAL;
> > +#else
> > +     switch (unw_regnum) {
> > +     case UNW_PPC32_R0 ... UNW_PPC32_R31:
> > +             return unw_regnum - UNW_PPC32_R0 + PERF_REG_POWERPC_R0;
> > +     case UNW_PPC32_LR:
> > +             return PERF_REG_POWERPC_LINK;
> > +     case UNW_PPC32_CTR:
> > +             return PERF_REG_POWERPC_CTR;
> > +     case UNW_PPC32_XER:
> > +             return PERF_REG_POWERPC_XER;
> > +     default:
> > +             pr_err("unwind: invalid reg id %d\n", unw_regnum);
> > +             return -EINVAL;
> > +     }
> > +#endif // HAVE_LIBUNWIND_PPC32_SUPPORT
>
> To address this local sashiko comment:
>
> ------------------------------------------------------------
> Is the instruction pointer (NIP) intentionally omitted from this switch
> statement?
>
> When libunwind attempts to read the instruction pointer, will access_reg(=
)
> hit the default case here and return -EINVAL, causing stack unwinding
> to fail on 32-bit PowerPC architectures?
> For comparison, the 64-bit implementation in libunwind-ppc64.c correctly
> maps UNW_PPC64_NIP to PERF_REG_POWERPC_NIP.
> ------------------------------------------------------------
>
> I ammended this patch with:
>
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ vim tools/perf/util/libunwind-ar=
ch/libunwind-ppc32.c
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ git diff
> diff --git a/tools/perf/util/libunwind-arch/libunwind-ppc32.c b/tools/per=
f/util/libunwind-arch/libunwind-ppc32.c
> index bcdeed34d0a81b8d..976a160304073582 100644
> --- a/tools/perf/util/libunwind-arch/libunwind-ppc32.c
> +++ b/tools/perf/util/libunwind-arch/libunwind-ppc32.c
> @@ -23,6 +23,8 @@ int __get_perf_regnum_for_unw_regnum_ppc32(int unw_regn=
um __maybe_unused)
>                 return PERF_REG_POWERPC_CTR;
>         case UNW_PPC32_XER:
>                 return PERF_REG_POWERPC_XER;
> +       case UNW_PPC32_NIP:
> +               return PERF_REG_POWERPC_NIP;
>         default:
>                 pr_err("unwind: invalid reg id %d\n", unw_regnum);
>                 return -EINVAL;
> =E2=AC=A2 [acme@toolbx perf-tools-next]$
>
> Ok? It was the only issue found in this patch.

Looks good, the NIP is in the original code that I copied, so I don't
understand how I lost this, but good catch!

Thanks,
Ian

> - Arnaldo
