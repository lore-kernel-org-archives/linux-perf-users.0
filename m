Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40783BE178
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 20:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787000041; cv=pass; b=TGrYgK1qU9bIFwXHWn7FqdOvwTxDmMUAdP1N22tS3BMgdSkFGbCPXyjUBq083Y/FPGzyT2ZZv8NxwalcBoPhsmu/i0Qf2zivRREfP88yiKl/FJC/B2O4TdTBO1YaoVySzbu+uVAo5nmdpfaHxGUDLY4+F12QWq5VxmaF570mrTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787000041; c=relaxed/simple;
	bh=nzI74IjtTqIvQMGf8+iEjRpnNyNuVvPxTKh/xKa3mzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W8loZww6xdvPzVX4NG0Ilm+aYFJdDed6FUpJsyhu812q/QzvxcNOCNO3kehzaP78C/QQvbk8fxw0Usq1ZgLCL+FZP5XcdC1sPBJf9RGziu3Ei4oEt6XSPg+uJ4klbdafFg8/9FwGXYo3OcG5Um2TyrjsQuAiHBFzJM8o5vqK2V0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ixHdXXV2; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ixHdXXV2"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c10ed63c0so21421cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 13:53:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787000038; cv=none;
        d=google.com; s=arc-20260327;
        b=HBGr9LrLm6j2gkG/rF7eE7gG7FnC3r7HU2l+1viAX7exMoPd+GTmD9Lxsr2aPdiKi0
         dJGMx8hI61608c+CP55xDbS/HhSaEwEL6rxOHDeTLksN5WN58qsHp54jRNCjaTIFPyGm
         FhdC1+kzvpJqJ/1PNyu9FpBSs1zDy8UTyfCCLi8Co9R6Cxks8N4XE9nZeh+PdMEoYrVF
         1BIgrzPy5iyZqx6rX+LOYA9Xr4MnOBtIRuQZRFqipfzHRLYYnEoxr6dfuhSKJJj4KUDa
         JLcwnny+iMmyI3fsgYDzVCzFxEN0vsN6tb3+wZeXG/2dHMKGxrP9tog3rDYPuV96HZK3
         Fn/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vqXzCnGfiNe64H1ql06/VrOvBe66rQOUiBtnTGNertQ=;
        fh=e6R3ARQlmWGgJkpBTSJ3qpYGGWgDzypoDkO25/gE+R0=;
        b=dwLtaX7CVvkfjbZBO8PQhpXiECbKD7BSbNSNjR+8HeLW8QCIflHVMyQnYYFPaIMDQy
         GDXAheXEEt6+Xq34n9hBieJUoDq/ZG3Z89Tcn82b8uwZLloHjvGjQDK3GCXyRuEn5zE2
         2ofkB38BkAWm+kZHfStp6pSlv7TwfLIyYcm8vvvTGApnt+fR6ZZ4r32PEsul99hLxBSl
         Vl8yYkAZIvlyyvgECRX1jdcDYtBboVrO5ZnkrRjeuEYCBwKJgu+9CXkVhBdGRV80jfSk
         Q19Ld9ARK9L+M1li5sf+voY+M9DYfcRuicDbHUx0tmA2jZrFG3lde2XZ5O5i/53cSQCr
         oOVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787000038; x=1787604838; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vqXzCnGfiNe64H1ql06/VrOvBe66rQOUiBtnTGNertQ=;
        b=ixHdXXV2H7QP7dw+1mq+7bps2VNTNw7q0ETxcbZe8m5iV0aqV6SYZILplgrXLWfLBd
         eZqBDnrWmtHPNl9bABEgbvbdxTpGY8SCRnjze4GZWA4RJer9Y3za2nopw7AdJSYJcZus
         kFhL1jvFURfD+QQbnIGGA6KARLkdABa5nI0bwG3vJEOsJzGd8MZCXpILdaqFrUhKBFkZ
         oUjYZuK9Gmwof6EV57MaYe4jl/AFJ95+qQ5nB3RnlTw56sPnYK5i7vgvHtsTvjgi2yJI
         BgZ9JePmBYBn1Pfplus0GZJMaz/AlCZm8kkrJMykLvrxAzcWvEIWtcfwx+nZI3B0kKlD
         3iGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787000038; x=1787604838;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vqXzCnGfiNe64H1ql06/VrOvBe66rQOUiBtnTGNertQ=;
        b=OgP1E/x8zKkU58VUfmHn1Qvds4tnRRSqbXI9OoaMW8uYCibLa0g+j0/le9MLrZ9KTl
         MXmU+ExZTimb9M6srY0kg3sNwysMLHPCBlB+lMaVF7UA+o1V6LMWzM5/p3MSJ0h5dA2n
         meFdHvlt+YdRL8MgjaV8mjwh26GLHZtXvSaPDtfrr2VY7lr+4SRj3u39qFgdkun6Frud
         cwTkKX1bOBKSnk1OOA/DM1YBVvqbTzQNp2jOBnwq0gWmGHnYHN4sa7ukPIFTy4IbJsZb
         ITjr7VJOa7BsIEhApIkt71PWjBqflQuCALE2tux39DyPmeXOJqVK2BP1Zz6MFze0Pc2z
         WEjw==
X-Forwarded-Encrypted: i=1; AHgh+Ro6Wf0isdOI52PNrVSIfMN3lJiqvaz3muzhABqvmtABpLUQR/3z9ULQITR9bTMxCpiEN5utok1E0v/dp25bTYex@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+jUcYoe7lo6oXrflRL4KPjUuoHiBRcH54CZwVgeKctHANXvf5
	kqXm6/n/Nq/BBYGb1lb4xP5puNtKAhPBykmFRMklYSPBTIu6oK+d0wnGgiATvcgOP6SjJIrc2rq
	1LteGIci2txVTG0clRfLP33u8hTz9j70sLZeXKI4N
X-Gm-Gg: AR+sD106NVbAnhXqWfCrIqBUyUgvMAwa8jiEzf4TmPb0r5c7u2ujzQT76GbjblWmV2h
	wKOiuKGGUq1trzQA7Hgt/vA7olehAf7cvdd8O8617mOlJ/5DzhSPHvOQMV6TNLX3FLt2Vpwr4e2
	I76x/q6ABPM0DIpFwiwGJjrBJCSqvNNuWdD2DODU95AS/0y90dUAKE4fTu/aZy0LpvVRnXLAplU
	A8o/aA4YaasZDk5arvvEcTC2fAgVa5mV1fUnIhlivQ8ddAseuVIeioVzHQzF33zALaJD9iWsvRz
	TUPTSHqJ5aHB0nX4GO3EQ/U1ksM5/zqiB43wqjbHU9CpqM5mJhC79dEjq2CDl1xc79xpVrdl47o
	=
X-Received: by 2002:a05:622a:590e:b0:50d:edb1:6bd1 with SMTP id
 d75a77b69052e-52dc0b88cddmr4722011cf.13.1787000037775; Mon, 17 Aug 2026
 13:53:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817094623.3288456-1-jiebin.sun@intel.com> <20260817094623.3288456-3-jiebin.sun@intel.com>
In-Reply-To: <20260817094623.3288456-3-jiebin.sun@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Aug 2026 13:53:46 -0700
X-Gm-Features: AcwNN1Vcy6ojrpr_F1vKFCwa1D200G4gP3hf2N7McRWlxlLGkMqCLNL_oz7YJ7Q
Message-ID: <CAP-5=fXbrgF1+bhYLxvr+JPQhs_9YrMkSjOx6QrncPj0CKABXA@mail.gmail.com>
Subject: Re: [PATCH v9 2/9] perf c2c: add function view model skeleton
To: Jiebin Sun <jiebin.sun@intel.com>
Cc: namhyung@kernel.org, acme@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	mark.rutland@arm.com, dapeng1.mi@linux.intel.com, thomas.falcon@intel.com, 
	tianyou.li@intel.com, wangyang.guo@intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 2:40=E2=80=AFAM Jiebin Sun <jiebin.sun@intel.com> w=
rote:
>
> Add the initial common model for the c2c function view: model state and
> small helpers shared by the hierarchy construction and formatting added
> in later patches.
>
> Build the model from util/ so it remains independent of the TUI and
> command-private symbols.
>
> Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Falcon <thomas.falcon@intel.com>
> Reviewed-by: Tianyou Li <tianyou.li@intel.com>
> Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
> ---
>  tools/perf/util/Build          |  1 +
>  tools/perf/util/c2c-function.c | 66 ++++++++++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
>  create mode 100644 tools/perf/util/c2c-function.c
>
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 1dfd92cbe3b7..b26a0b1ddfa3 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -12,6 +12,7 @@ perf-util-y +=3D block-info.o
>  perf-util-y +=3D block-range.o
>  perf-util-y +=3D build-id.o
>  perf-util-y +=3D c2c.o
> +perf-util-y +=3D c2c-function.o
>  perf-util-y +=3D cacheline.o
>  perf-util-$(CONFIG_LIBCAPSTONE) +=3D capstone.o
>  perf-util-y +=3D config.o
> diff --git a/tools/perf/util/c2c-function.c b/tools/perf/util/c2c-functio=
n.c
> new file mode 100644
> index 000000000000..ca82425a28dc
> --- /dev/null
> +++ b/tools/perf/util/c2c-function.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * C2C function model - function-level cacheline sharing analysis
> + *
> + * Displays a 3-level hierarchy showing which functions share cachelines=
:
> + *   Level 1: Read-side functions sorted by Cycles % (estimated load cyc=
les)
> + *   Level 2: Functions sampled writing the shared lines read by level 1
> + *   Level 3: The specific cachelines where the two functions contend
> + *
> + * Builds the hierarchy from the existing cacheline histograms
> + * (c2c_hist_entry->hists), reusing the shared c2c data structures.
> + */
> +
> +#include <errno.h>
> +#include <inttypes.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <tools/libc_compat.h> /* reallocarray */
> +#include <linux/list.h>
> +#include <linux/rbtree.h>
> +#include <linux/zalloc.h>
> +
> +#include "addr_location.h"
> +#include "c2c.h"
> +#include "cacheline.h"
> +#include "hist.h"
> +#include "map.h"
> +#include "mem-events.h"
> +#include "mem-info.h"
> +#include "sort.h"
> +#include "symbol.h"
> +#include "thread.h"

nit: the number of #includes is somewhat generous here. I presume
later patches will require these includes. To avoid everything
depending on everything else it would be nice to use forward
declarations when possible. For example, if the only reason for
including the header file was to use a struct's name where it is
passed as a pointer in a function declaration, ie in header files
prefer:

  struct map;
  int foo(struct map *m);

over

  #include "map.h"
  int foo(struct map *m);

> +
> +struct c2c_function_model {
> +       struct c2c_hists        function_hists;
> +       /* Total estimated cycles across all level-1 entries. */
> +       u64                     total_cycles;
> +       /* Source cacheline histograms; not owned here. */
> +       struct c2c_hists        *cl_hists;
> +       /* --coalesce field list, used to require iaddr. */
> +       const char              *cl_sort;
> +       /* Do not cap long symbol names. */
> +       bool                     symbol_full;
> +};
> +
> +static struct c2c_function_model c2c_ext __maybe_unused;
> +
> +static inline __maybe_unused u64 c2c_hitm_count(const struct c2c_stats *=
stats)
> +{
> +       return stats->tot_hitm;
> +}
> +
> +static inline __maybe_unused bool symbol_name_equal(struct symbol *a, st=
ruct symbol *b)
> +{
> +       /* Two unknown symbols compare equal, matching cmp_null() in util=
/sort.c. */
> +       if (!a || !b)
> +               return a =3D=3D b;
> +       return arch__compare_symbol_names(a->name, b->name) =3D=3D 0;

Sashiko rightly flagged this as not being cross-platform compatible,
but this is a pre-existing issue that looks relatively easy to clean
up but only really impacts PowerPC and so is hard for me to test. I'll
try to do it anyway.

Thanks,
Ian

> +}
> +
> +static inline __maybe_unused u64 hist_entry__iaddr(struct hist_entry *he=
)
> +{
> +       if (he->mem_info)
> +               return mem_info__iaddr(he->mem_info)->addr;
> +       return he->ip;
> +}
> --
> 2.52.0
>
