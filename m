Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B224FDA5E
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 21:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790631816; cv=pass; b=TIYG3IqZGIZ7tuPZBvSP03IrJ+2KdEoRJLeiLi40kECknqX4vi9CXphV+xDAA46T6+6VdeQB+jU60PmIhTKvwIgxgskPN7etLzJm4GoQgGMZTQuae2VNmxtsJ44fpS74gdmwJsFIOIu+LgN+D9u3NG/pGoFns5ZtlnL2X+BkBw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790631816; c=relaxed/simple;
	bh=uxXHa2WIztnT4HhW7pDRg1DvGrnilnU0CK36R7LnMwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pLFfWXiaFZlV7S+W5UJsgKI4DB0ZNq+iBQryVyEda+lqh5TDjfCXW0tOWJEAi+opK5MQCGpYK+f5/s4aVgTP37sTk1Asn3rixIlo6vlVf6QoJ0AgD/VbVxnE4KKpo9/MLH+1rvz+9uFAAhykG4n4XduhNPNoJvm2JNhVntc09ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VJXiyqwy; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VJXiyqwy"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-53113d72966so51141cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 14:43:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790631813; cv=none;
        d=google.com; s=arc-20260327;
        b=DOn7f8eGu0q1mV+iJm1EMBz8npuKFhg4cl0+qtl5xgED2QQ9RxcxcGgNFlyiu+sl3H
         L/+ODBNQDKLaF3b5Fm2dOQLXc93N336LEeAWyHR3n91FtQJ/0wtfb6/6kjpRzv2SQifR
         FbMPrKFcW7xjSbqMpsL3JdU9LDYnABgeCLo3uw0C4hY08RIOeaqoHvx5ndM5OvuTPRa7
         m1E0CI3Z33W7Yuk0/GUyKvOK+tiSR2M0IeEHMSZcjqi2ZVudFf8zpQM3LhsfnhYHZN20
         vCSz8qR6bMwFWbEH/YQN9/kcZHAzM9lX6NC4m9OG68wLJiREB/c5p6r0YwdmgxlS0+oK
         yFHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zq6u8NSORsqGMSwXt2PUCa3ICMXA5cI5C7VtQ6r/oCY=;
        fh=99DHc7e4QYBJFkKqqCK61Ado7Ij4nB6SIZ0siQvMrqo=;
        b=ERTynR23DYf+u/1qWMcykGpJOQMqMhITdXHEezzQy/h6ehc3LGDGwb62eOhACWLCMm
         uzBFw7+mOMyBUU3ZZU9UQerNShlfTsXWBPOk+9g2UygjhtgNqtEWzEvo/wTPo0rnDEBH
         oC0bT01TNSUNO3kle/H3lydULKjLVZ/ua6X6bsdG1yvO3D4gowGy4rs2MKYI2qlle0OH
         MPTis7MxO4o8QWGhzAXKj9J7j4a150omip1UD3XhCskiOPEarP+44o9IEq+a7beOvr2+
         7T2OLS6FaiFys7mxi95fcaWX57BUrpwDeyLBGQ7oCOc8SXMzKLwWvhfmGrDJvy04MXOP
         SpHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790631813; x=1791236613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zq6u8NSORsqGMSwXt2PUCa3ICMXA5cI5C7VtQ6r/oCY=;
        b=VJXiyqwy+FAksPkGbEJAwQP8WyLKyPML1t2GTpjSuZ5ogWkE9Bw+CPzPZgl3mgaGNU
         I73Gm2p0T9CK+b7mz+u5PHTjlcZxBi3TIqCbiBgNpjd2UJV87VgPL5JONorQ3Oqc7CLD
         thRULVoB+JBAsN2yyvcjNGCgH/RJdP8HVKgciUdy366KDiQvBkf/IP6hO/hH04disejF
         6E2ZBf6Bp4Onegpt7wISUWFdLeGALGYNUKr5xoFkv6zcorqUOoEwdB4PFlzujxOihCw5
         a4Sv2qcRvLDJkmWwZBNyxEj1/TzJzraHixxZhwGevTz7gdScETPIIgwp9CwlrSXhTnDR
         2R3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790631813; x=1791236613;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zq6u8NSORsqGMSwXt2PUCa3ICMXA5cI5C7VtQ6r/oCY=;
        b=Zxql6qAzZFrc26RrBK5OIP/5S5wzC7jU0COHn5+cKUj2uzHEFlLKeKSRig7snr4ZVr
         Qu1REyXSkLzJYK+w/7zYBUT7vGeO7XHraYBmD7oHr/u+FKN0UkSlAdVkCf96GRs68GD5
         iObVnxXkRPxMCF7b0R3bKUq1KqFJu7dhOUqlCwxT8Af10kWrvpwRaS1me7dI4SQV8xEW
         uAmIxrjIEn/sGFZhLndJqXP9OahueroYmRyafiTDx3D25rEH+G+gsyDuUg1wDfy0bc+F
         uJJCs9C1vc7D4fkdOalDNZ0nyZaZOZq7U0UQCb/YibDxBtBvuuQQd62zusW5CKs1g/Et
         /SKA==
X-Forwarded-Encrypted: i=1; AKwUvByNcs7aD7Baf+Mge1kD1/rWKXKMUxjC1eDZ/iZWbUk6CQcEd691Q8PDo4dJBelCUgta42e2diUlSJ4mRqOm6VZD@vger.kernel.org
X-Gm-Message-State: AFuF++naNZWBt6W9L6ClgJ5mbcxFr2oFg+zBAC1ajutKa7FCp+HpyGyc
	9tN+1/xFJqxvRM5c5glXaWZ9hjpzNfXOak6ycmsUxPqc4o5fEIgSfU7Xcsf67XTB/JzzT8ZEEel
	7aEoatToYeR1ieAzJBr1gjNdfqbKfOFpyBLlyun8HCq3TpB5ZX08emtAni9U=
X-Gm-Gg: AYBFou22VftyhdavyVLWMLlK23PwGgb9qaZj0Quf+7pEcr2Mu2hQLo/GFepbcjstnb3
	I3/pOgsX2hCROdOHYoOKOLfvkXI2r9qS4LnT4o3VECTHNsQfbDmHoSnVGfJuaLj0QWkc+QJ9C6W
	GIeagqaFEUeI8XeOZNebFRd/LxIzMR2KoIrsaqjFiiOY9Y/To2GTjrPlrOD3ZwYFN9j3ezZ2LMa
	XVrm6c1cvqPYR4Dc4gAZDc2cpc/LSR1tgz1lNH4HwqMbsLfW74FIAZGnCIkbOq7ztTVIWJbo9cz
	IV4BOoZkHXU/eXm2hGgE0urU5k3tYMtVHuMg8yAWjEuBDO/jq8MhkyZbIaCvYhwmH6aBKLp1Fvq
	NbUt7OCGHPPicAmZpmvSd
X-Received: by 2002:ac8:59cf:0:b0:517:5e32:2d14 with SMTP id
 d75a77b69052e-5335a1ee1camr910641cf.10.1790631812598; Mon, 28 Sep 2026
 14:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928010227.1903673-1-michalpl2003@gmail.com> <20260928010227.1903673-4-michalpl2003@gmail.com>
In-Reply-To: <20260928010227.1903673-4-michalpl2003@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 28 Sep 2026 14:43:21 -0700
X-Gm-Features: AclHuK9fVr94fSWHmMdmC0x4TwWwZQ06SsleQuOajbCBbXd937esFBpLzMS7qJM
Message-ID: <CAP-5=fVe=VxnxypQYNt1h-s+3=Me8D_fpBL3LD1Eeb1cGvUc3g@mail.gmail.com>
Subject: Re: [PATCH 3/5] perf symbol: Grow the Rust demangle buffer geometrically
To: Michal Pluta <michalpl2003@gmail.com>
Cc: acme@kernel.org, namhyung@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 27, 2026 at 6:02=E2=80=AFPM Michal Pluta <michalpl2003@gmail.co=
m> wrote:
>
> When a demangled Rust name doesn't fit in the provided buffer,
> dso__demangle_sym() adds 32 bytes to it and formats the name again from
> the start.  The number of attempts grows with the length of the output,
> so the total work is quadratic.  Names with deeply nested generic types
> need many attempts, leading to noticeable slowdowns in larger programs.
>
> Double the buffer instead, reaching the maximum buffer limit exactly
> rather than stopping 32 bytes early.  The demangled names are
> unchanged.
>
> Add a test for a symbol whose expansion exceeds the bound.
>
> Signed-off-by: Michal Pluta <michalpl2003@gmail.com>
> ---
>  tools/perf/tests/demangle-rust-v0-test.c | 12 ++++++++++++
>  tools/perf/util/symbol.c                 | 10 ++++++++--
>  2 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/demangle-rust-v0-test.c b/tools/perf/tests/=
demangle-rust-v0-test.c
> index ee4ddb61174b..d1e0636d73bc 100644
> --- a/tools/perf/tests/demangle-rust-v0-test.c
> +++ b/tools/perf/tests/demangle-rust-v0-test.c
> @@ -69,6 +69,18 @@ static int test__demangle_rust(struct test_suite *test=
 __maybe_unused, int subte
>                 free(buf);
>         }
>
> +       /*
> +        * A symbol with more lifetimes bound than fit in the largest buf=
fer
> +        * must fail to demangle rather than give a truncated name.
> +        */
> +       buf =3D dso__demangle_sym(/*dso=3D*/NULL, /*kmodule=3D*/0, "_RINv=
C1a1fFGZZZZZZ_EuE");
> +       if (buf) {
> +               pr_debug("FAILED: symbol larger than the buffer limit dem=
angled to %zu bytes\n",
> +                        strlen(buf));
> +               ret =3D TEST_FAIL;
> +               free(buf);
> +       }
> +
>         return ret;
>  }
>
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 3cb42805a82f..1a52bc2980a0 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -2737,29 +2737,35 @@ char *cxx_demangle_sym(const char *str __maybe_un=
used, bool params __maybe_unuse
>  }
>  #endif /* !HAVE_CXA_DEMANGLE_SUPPORT */
>
> +/* Buffer limit for a demangled Rust symbol name. */
> +#define RUST_DEMANGLE_MAX_LEN (1024 * 1024)
> +
>  char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_na=
me)
>  {
>         struct demangle rust_demangle =3D {
>                 .style =3D DemangleStyleUnknown,
>         };
>         char *demangled =3D NULL;
> +       size_t buf_len;

It seems changing the scope of this variable is unnecessary.

>
>         /*
>          * We need to figure out if the object was created from C++ sourc=
es
>          * DWARF DW_compile_unit has this, but we don't always have acces=
s
>          * to it...
>          */
>         if (!want_demangle((dso && dso__kernel(dso)) || kmodule))
>                 return demangled;
>
>         rust_demangle_demangle(elf_name, &rust_demangle);
>         if (rust_demangle_is_known(&rust_demangle)) {
>                 /* A rust mangled name. */
>                 if (rust_demangle.mangled_len =3D=3D 0)
>                         return demangled;
>
> -               for (size_t buf_len =3D roundup_pow_of_two(rust_demangle.=
mangled_len * 2);
> -                    buf_len < 1024 * 1024; buf_len +=3D 32) {
> +               for (buf_len =3D min_t(size_t, roundup_pow_of_two(rust_de=
mangle.mangled_len * 2),
> +                                    RUST_DEMANGLE_MAX_LEN);
> +                    buf_len <=3D RUST_DEMANGLE_MAX_LEN;
> +                    buf_len *=3D 2) {

Thanks for digging into this problem and exploring a fix! Previously,
we guessed the demangled length was twice the mangled length, then
added 32 bytes for each retry. These were numbers I pulled out of thin
air, so I'm glad you've found them to be wrong :-). Could we estimate
the initial demangled size better? Could you get data from Bevy and
Typst? I'm a little concerned that a demangled symbol of say just over
2KB might require 4KB with this change, instead of 2KB + 32bytes.

Thanks!
Ian

>                         char *tmp =3D realloc(demangled, buf_len);
>
>                         if (!tmp)
> --
> 2.43.0
>
