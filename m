Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22A333C51A
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 07:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768979416; cv=pass; b=VfexZ4F26EYN/h28QF0zEIzsC4vS7Qc+nyF7muR+1jNqazPS4YgnMWwAauPgsdGwzuO3B2uLxZ1+pwugYBha8yDY/RSDHmOzdu9KkiDTxGNgsFv5tV+pxzH7MkwZrWCVHJIq1BN9WFliemAW67Zl3j9elaCe5XA4TqbMNdg+9Ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768979416; c=relaxed/simple;
	bh=qf2rdxV+2bNdiBdM/cScn2LLwNY/bIbiz/3Fcc5fVRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gI4MPS1YSN2Bho9WxGyesmJA/RKmJyE1YbKojEIWnfCl9JeM517Wq3XewbKeUMbG2/pvE8VYJAGm/hmFwtFJZzYhdZat7EDpx4PUgKteOcSxGS3/Y+N4AN4S/Z9MERRQpsL0ni6/kCK/pnc5ytjCFSQvgSuNx6dV3259kZMZDpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lKmIqXLr; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lKmIqXLr"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a76b39587aso60955ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2026 23:10:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768979414; cv=none;
        d=google.com; s=arc-20240605;
        b=EC9V4fpjL/ZDrfqUuLTjLsJjEH1HCsF6oyxc86YTErU4JZRzz1TKNpOYf+Ow6FpdoV
         FAGNmpgigcPtJcUS3siu/p/lO/IU3+OyU73J5fPZbpOcFo4jUNBhdK72tWa/3ozGQMfv
         j9EJ4PMDMqOcsi0gdnoDbO2Z1YCfwCPS7SZ5VleXygzkNcQ6L9ecasrNWju9R6Cf5QqB
         4/qUiNx5jQsBW7SJp/pyd6Lfe/qNlHbUWeSSeyfOqbxhoo7gzXydlwKCVDI0t96lpYjr
         mXw7cdaFnF/LJFQ6YsSYzWun6o+htaRyVupEjDfz/Bs9uqFlGVbV2zXuWkeDjl8eZWzO
         kJhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hJ81YcHVJUXCUDOSqTEo4fpneXYhzAyyqlg4VRJWSOc=;
        fh=hizxuRUKoUHY8DKTgz1bn7oGqRv16QUVqFE1alBz7C4=;
        b=hesaqj+hND/nLcg1hSu07b6k9wRwOfeLfi4RMCSd9CRe+gBO3rHGIiCCYEpAhq+hdQ
         SKud/SWyZ3P4GYidt4OFP9FrVYkXgeSMcaTUAA3EAwCm/yxD1Kbz8mJDVAOk22pn4NFJ
         Flel05yIlEmVKrw1qXn62IjnRmrzoaXmaxnd64N22q/m44/pYDoa+6FjJ6WnQhz8k9nk
         YDGYZjpRW7ovu/7APGcryTkwPtGckmjOkuB0qA3PyPN1bUooiGPZnL9i0R3aLS1WmOY5
         R62Df9//d7+DuVZ33aQ3OVON6GII/u3xj2ID2Bhak14osTRH9jMFWbFbeQD0QWS34oHk
         ijuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768979414; x=1769584214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJ81YcHVJUXCUDOSqTEo4fpneXYhzAyyqlg4VRJWSOc=;
        b=lKmIqXLrjReJdCpGRuKw+tU1E9xGbzDiOL8DNhUZCoHFVk8biP/+mLGqgEV1wcNZlr
         RdOmD9uPLnpQxGxcK6ZLSIufVKIn6rW91KbpXJqplkyiCJG5DtNpBtdg/MS0X5WiTJE9
         64/pYqNV1FgPd3vjPBwtAipt4e/9mkBkYOjMObm8lEw/QbeWQrF5gcte9sln83K+2D9Y
         07TekfhhdO5iI17eLsZ3673jyUkOgOQ0tDXBuz6rwkR5+hROoGVBAYKSC4n/0EqhDTaM
         rXaL1RW7HwgHDNO1YoC9hPdHY4qLN0jsF6ocoh6bnUAXQJ030f8pfPEOQOSVOqQTn6Rh
         e4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768979414; x=1769584214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hJ81YcHVJUXCUDOSqTEo4fpneXYhzAyyqlg4VRJWSOc=;
        b=UiRbN4CTVODoA5H9EQ8BvCTrqGJNFWcpts7v0EZ+v6FK8z0lt00VFiODVKEsnOv4wn
         BTcxnK589/KeIsyi7Hn72MsctbPz/7ogvFc0mzQUWZgCJvZGgZVXrq+M451Tz96kTjaW
         bImA4VgVTDo+oTsK9V2s0a/NY0QHr18bjfZf4s0V7fxEEm6yULg8sMzNk2G3GlB2vOKR
         ond8Vs02sf6a+2cWv8mOY9bvVMnZuxW2vbyx6RofVhGCXiGI3svRCLXOlpQrma0/i7lj
         q4tvP0Zbj7XYfgeuEIoopaIlcmEzRPdwxwK8206+oXMK+cnvXrSmuqIFyLeSGmokSVvl
         QxDg==
X-Forwarded-Encrypted: i=1; AJvYcCVk1Jpm+gEAdTFePBicylQdYj/a1kPSGd5/2F9L1U2aQBu7xNkLNeeZStlGP92sBwMZglbJI1wXrB39oh8TctqW@vger.kernel.org
X-Gm-Message-State: AOJu0YwpKDOYQahDz5PmQ+NdgpRJrSOePjyhHAK6ZFja0mPCvMOlER3R
	Hy2QAItzWR0t55KwFnQOJJUC6ZxR183UoXPjIv6GTLu2+DfqRK5zS0IAefHhSFphzcYHOQG0eup
	ZMEf89BH7rCsMKYd4NXuSjCe/+oauoPifZdPGwino
X-Gm-Gg: AZuq6aIhZ/f9PlCFImPfn5tGwXf8wNR9/u9aT0G3G6ZMjuWAA/2Jpt9G2pkKYrysU7C
	X0XfoRziW4W77XWd7bebjyeDc1OWezSSID6tchCt5wvNZQkaqkRCi28zqWbhsPYrwTY8Nuyap9e
	9VmwUSk7FCx92bssBF0PNYRKkZa+0biYL2gW45UqtBB3sVz2XUM6FttJ2JyfTrnh/CRY2vldTLv
	4TSbA8d+BvdH5XrEIA1M62GkA4uecs6holl+UKji2Z1e7xxY58yngM/hDUugfUTCgRVbjEHw8Uu
	DjwS6gM=
X-Received: by 2002:a17:902:e746:b0:290:8ecf:e9f9 with SMTP id
 d9443c01a7336-2a7a2443b58mr1503495ad.7.1768979413636; Tue, 20 Jan 2026
 23:10:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260117052849.2205545-1-irogers@google.com> <20260117052849.2205545-9-irogers@google.com>
 <aW_OV72q5rAVrgRE@x1> <8c1fefd6-4f4c-42a7-9007-5c9df3975080@linux.intel.com>
In-Reply-To: <8c1fefd6-4f4c-42a7-9007-5c9df3975080@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 20 Jan 2026 23:10:01 -0800
X-Gm-Features: AZwV_Qg0iOIpO5Pzoy2b7YabxBnL-fqXhU8D44tCtQG-FBoEqke8sFeoam8z8tY
Message-ID: <CAP-5=fXUw=LLXX6Pzrab37TTrVrMdHJim1QOnvbP9gXsRQZFUg@mail.gmail.com>
Subject: Re: [PATCH v1 08/23] perf perf_regs: Switch from arch string to int e_machine
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Guo Ren <guoren@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Shimin Guo <shimin.guo@skydio.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Howard Chu <howardchu95@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Dmitry Vyukov <dvyukov@google.com>, 
	=?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>, 
	Chun-Tse Shao <ctshao@google.com>, Aditya Bodkhe <aditya.b1@linux.ibm.com>, 
	Haibo Xu <haibo1.xu@intel.com>, Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Wielaard <mark@klomp.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 10:58=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel=
.com> wrote:
>
>
> On 1/21/2026 2:49 AM, Arnaldo Carvalho de Melo wrote:
> > On Fri, Jan 16, 2026 at 09:28:34PM -0800, Ian Rogers wrote:
> >> The arch string requires multiple strcmp to identify things like the
> >> IP and SP. Switch to passing in an e_machine that in the bulk of cases
> >> is computed using a current thread load. The e_machine also allows
> >> identification of 32-bit vs 64-bit processes.
> >>
> >> Signed-off-by: Ian Rogers <irogers@google.com>
> >> ---
> >>  tools/perf/builtin-script.c                   |  17 ++-
> >>  tools/perf/util/evsel.c                       |  14 ++-
> >>  tools/perf/util/perf_regs.c                   | 105 +++++++++++------=
-
> > [ Include dwarf-regs.h to get conditional defines for EM_CSKY and EM_LO=
ONGARCH, not available in old distros ]
> >
> > - Arnaldo
>
> Seems the change would introduce the below building error.
>
> util/perf_regs.c: In function =E2=80=98perf_reg_name=E2=80=99:
> util/perf_regs.c:48:14: error: =E2=80=98EM_LOONGARCH=E2=80=99 undeclared =
(first use in this
> function)
>    48 |         case EM_LOONGARCH:
>       |              ^~~~~~~~~~~~
> util/perf_regs.c:48:14: note: each undeclared identifier is reported only
> once for each function it appears in
> util/perf_regs.c: In function =E2=80=98perf_arch_reg_ip=E2=80=99:
> util/perf_regs.c:114:14: error: =E2=80=98EM_LOONGARCH=E2=80=99 undeclared=
 (first use in
> this function)
>   114 |         case EM_LOONGARCH:
>       |              ^~~~~~~~~~~~
> util/perf_regs.c: In function =E2=80=98perf_arch_reg_sp=E2=80=99:
> util/perf_regs.c:143:14: error: =E2=80=98EM_LOONGARCH=E2=80=99 undeclared=
 (first use in
> this function)
>   143 |         case EM_LOONGARCH:
>       |              ^~~~~~~~~~~~
>
> It looks EM_LOONGARCH is not defined in the <elf.h> header file, not sure
> which one is better, include  dwarf-regs.h suggested by Arnaldo or direct
> add the define,
>
> diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
> index b58d59b84fb1..ce839df19fa3 100644
> --- a/tools/perf/util/perf_regs.c
> +++ b/tools/perf/util/perf_regs.c
> @@ -6,6 +6,10 @@
>  #include "util/sample.h"
>  #include "debug.h"
>
> +#ifndef EM_LOONGARCH
> +#define EM_LOONGARCH           258
> +#endif

Or #include <dwarf-regs.h> which I think is the fix Arnaldo is
carrying at the moment.

Thanks,
Ian

> +
>  int __weak arch_sdt_arg_parse_op(char *old_op __maybe_unused,
>                                  char **new_op __maybe_unused)
>  {
>
>
> >
