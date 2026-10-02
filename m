Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F363C9EE6
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 22:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790979377; cv=pass; b=j631uPsbusb8Ry4wAxfEYtFiIef8weTGZ47cnaMW32+EQxYNea3zNRv7gIlq2tIPCoAcs3h+sKfftMYrdbbuIW6G/I/PF9Dqg/DeD0Er+5qgeqMIHcBwC+APYGiOvijT37h57T+7aQbyD97MDQ3tLYRZoJkUtsNR7JiVQ/xT63w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790979377; c=relaxed/simple;
	bh=+5zLPRe7jiIR4G9auvQRB7tyTnGsVwR8jZaUb5mior8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVxt2hAh4WCDtJ5gihIQ4wyORic+4hQN46g18CWHIjGkKyyppKdn3YECQyZLr4u8XBmBo7q6u+0mRFedd2HYXve2RSCIHU+r4PfxlnDuK0IOMYRmKaplnFVoaXIq4wHY6JqPiqOVY07NmpDJej2mfj460qhBo4AeEzFHcFNnXLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cmu5+n3X; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cmu5+n3X"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-53113d72966so35491cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 15:16:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790979375; cv=none;
        d=google.com; s=arc-20260327;
        b=Itg0ZzqYIxH+2q59qtPwOtNXSOb3SoaCF0xjWPhmC0lJbdp/h7qjQWQYCUJBT8QtTd
         yHe0CMOLFo38L0CmtGuYdkzRUKcolZW3sLqdL3lG1coO/zDIyJNQNijDr0u2DBu5vmR/
         VoLShfhlZWL1gJAvz6o7DSZi/dJs2HuTUcw1FBIaIbKOS7hgv+DaYurKRL0SSucjq/lG
         me7Sigye1KOJ9A7F3O+iszqa4wUbrv+5GX8kXRc0Yj2aLjcSRSnbZDcDG0mZIBtUJmv7
         C8KdcI2HXcNa2JxWFvvUVZGmA8H1pfBKySpF5pguP8iezPEXSBieFn6oVM5RJXct8aZO
         hVmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=isApfnsinfyGiDWvI6+FZQrTyDCrDfqQP1dy41N8CAk=;
        fh=pbqiEG3xvS7kA4ExpTzXT+zsU7LwlqXJn1j3tCZeCb8=;
        b=j1+NUFHJyJ9i37dy0RGIQu+gIRo7Z/egX2o4tbhfk9sBHLJK80V1neeGAKWP7BjHr+
         xXUKK6wLvbatJgex1eurQoZgGkc6jngjtHTwziqhzGbuSeefr9PKMkA17SgheE2CudKg
         0HNA+2maqShnO6LN1DZueuETUyjvaF1BdBtMimPXCvGBK3cQxsAhlfsLhlaxFsoVCO6y
         4QcWhi3GvUWdvpjhkD1yDy52hAMJZ3EUTC70T+/HgSE5OnV4sZ7jKj+XbrD6BGNl/eOu
         LNRh9XO1xAJVYfY99JMVTanz1JhQdJs4GGF3VZrTjVGwUpEFHdIWtLjPbkeJreFCIWlx
         ekwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790979375; x=1791584175; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=isApfnsinfyGiDWvI6+FZQrTyDCrDfqQP1dy41N8CAk=;
        b=cmu5+n3X6u3LQzICXRFM/zG9hp2GjgMXF/lnzB9pupBkoh5oefWJVCVNjvBALaMjp2
         Z//CfRaCGEfehiO5ZTuhap0/gwBqGpEALkSZrvutKZ54IcuYAFF0fczW2KyUYNiNTjVN
         +MgEdV2w0b3GNn3e2N8k0nU9aNSVKIB1hAFPFutH32JSWJm+lm4Kjr+VS+yU4zP0VA95
         XPRist7KTb6No+GC+741uOeQFKx2bo3Z0k7M2ondLLTUU5cZg5kx3x8vpf64awtkD1I0
         lEkSaQr7GiRNw7dZr2/BIxqKbsLO0zQ9OXXxH63zZDkxYTCKjjuzGAvpYPxUCGGgELwq
         R/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790979375; x=1791584175;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=isApfnsinfyGiDWvI6+FZQrTyDCrDfqQP1dy41N8CAk=;
        b=1IS0lC4Jd5oF4m3DxP78z+cnQwQJvfxYzoR7QVcl+2cijLcxwMRHgs2QC4actUdLgO
         5L8Yee+X4FAoIqTfyszWvrDkNH6+fCLQrLuUmfkq1h3ZLs/J2LwZUBFHhjeWRm96APXU
         YIpZORjweABXqqvY5f1fT9hLB/H8mnCx77ykhQXLYztP25TXPsAfB49SG8z08QqVCHjj
         IHQjhQf9K9BmIwxZ2qA+el9HSsDoTSkGqlAM0Adar8Z82F+IVffdqfD6+LIXxYLLNrjJ
         lVmsumCZBSdYD8lQpkmxP+Apxyti3GTAWn1eM/WC4/X07qzNGck+xt/g9tQBdWuI8oJ9
         gyXg==
X-Forwarded-Encrypted: i=1; AKwUvBxRFfQFdCAeTCr0pQlVaT7g/KrT05XPsviZlsTNsCelBeJRVhWxoZz2GYeCMKiGD59/+KPzSxxhxKJd9lLrD7vr@vger.kernel.org
X-Gm-Message-State: AFuF++lSVgDlnGIuiF6J/74/LNlmRkMWxRyMuu5av4xz8ZDcygfOjJ9D
	+tto6+GC4qbU1JzpFm2BK1P+KNEa1KWbgn2DLqjR0JQrFi0Nxs61ZGL0R2kh98HHkLisavNx0bs
	01nUj+/RTkBuIPwiDXU7xc7cEJP7JqT5al8ODYOMf
X-Gm-Gg: AYBFou3yV4RNCFdM+4Jfw52oaQ9NlNoIY7XTOEH8pSLsgGiNHmwrCxMlJzo8rG23T9E
	r2galqKlkAJX+M0ccOjjV8KF1Or0pMOmnPbIZKaqd6PauK4jSt46gSHdl35sbRkhnx5H5PkDbys
	YFeXe9RgXAhpIuiPV4UVuYLea0P1qovn4Lmq4TNvYTGPEoCfOP6Znk2J+1Gw/SFs0Sqk9a6Xq8K
	fjMJ5LQ0fa1KifuXwMQvY3tnHC479Sv4ehNUBGMaUqcaxjWs1Jnw2J9okhjvdXEQcZwph5hhH99
	2t/NhW7AIIwm0ueljZEGupbEJ22ZaMLkWK1UQZCLqFUAy9VIQV0wXtE=
X-Received: by 2002:a05:622a:488d:b0:533:9746:9a86 with SMTP id
 d75a77b69052e-5351470cf21mr800001cf.5.1790979373951; Fri, 02 Oct 2026
 15:16:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002-perf-symbol-memory-send-v4-0-0a592bb2539e@uber.com> <20261002-perf-symbol-memory-send-v4-3-0a592bb2539e@uber.com>
In-Reply-To: <20261002-perf-symbol-memory-send-v4-3-0a592bb2539e@uber.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 2 Oct 2026 15:16:02 -0700
X-Gm-Features: AclHuK93t0jOehP9Jo976D8MsudkDaiRH5lfDWH-ham0dGq_flZBPKh1NXGy0Ew
Message-ID: <CAP-5=fW_gTX3oXi5_tzsFo2VYxhcsuuoTBxFAzkP-yPsroAoOw@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] perf symbols: Factor out duplicate symbol selection
To: haghdoost@uber.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andriin@fb.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 11:46=E2=80=AFAM Alireza Haghdoost via B4 Relay
<devnull+haghdoost.uber.com@kernel.org> wrote:
>
> From: Alireza Haghdoost <haghdoost@uber.com>
>
> symbols__fixup_duplicate() chooses between symbols with the same start
> address through choose_best_symbol(), which needs fully constructed
> struct symbol objects. The lazy symbol loader added later in this series
> selects among aliases from its index entries, before any struct symbol
> exists, so it cannot use it.
>
> This patch moves the policy into symbol__choose_best(), which compares
> the size, name, type and binding of two candidates described by struct
> symbol_candidate, and passes the same description to the
> arch__choose_best_symbol() hook. choose_best_symbol() becomes a wrapper
> that describes two struct symbols. No functional change intended.
>
> symbol__choose_best() is not static so that the lazy loader can call it.
> struct symbol_candidate stays in symbol.h because powerpc overrides the
> weak arch__choose_best_symbol(), which takes it.

Could we have symbol__choose_best() that takes struct symbol
arguments? The struct symbol_candidate doesn't appear to add anything
other than a cache of symbol values, and these could be as well cached
in local variables.

Thanks,
Ian

> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>
> ---
>  tools/perf/arch/powerpc/util/sym-handling.c |  6 ++--
>  tools/perf/util/symbol.c                    | 43 +++++++++++++++++++++--=
------
>  tools/perf/util/symbol.h                    | 14 +++++++++-
>  3 files changed, 47 insertions(+), 16 deletions(-)
>
> diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arc=
h/powerpc/util/sym-handling.c
> index 947bfad7aa59..c263cbfefba5 100644
> --- a/tools/perf/arch/powerpc/util/sym-handling.c
> +++ b/tools/perf/arch/powerpc/util/sym-handling.c
> @@ -10,10 +10,10 @@
>  #include "probe-event.h"
>  #include "probe-file.h"
>
> -int arch__choose_best_symbol(struct symbol *syma,
> -                            struct symbol *symb __maybe_unused)
> +int arch__choose_best_symbol(const struct symbol_candidate *syma,
> +                            const struct symbol_candidate *symb __maybe_=
unused)
>  {
> -       char *sym =3D syma->name;
> +       const char *sym =3D syma->name;
>
>  #if !defined(_CALL_ELF) || _CALL_ELF !=3D 2
>         /* Skip over any initial dot */
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 5d98888d068c..f590b69f9f01 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -145,8 +145,8 @@ int __weak arch__compare_symbol_names_n(const char *n=
amea, const char *nameb,
>         return strncmp(namea, nameb, n);
>  }
>
> -int __weak arch__choose_best_symbol(struct symbol *syma,
> -                                   struct symbol *symb __maybe_unused)
> +int __weak arch__choose_best_symbol(const struct symbol_candidate *syma,
> +                                   const struct symbol_candidate *symb _=
_maybe_unused)
>  {
>         /* Avoid "SyS" kernel syscall aliases */
>         if (strlen(syma->name) >=3D 3 && !strncmp(syma->name, "SyS", 3))
> @@ -157,38 +157,39 @@ int __weak arch__choose_best_symbol(struct symbol *=
syma,
>         return SYMBOL_A;
>  }
>
> -static int choose_best_symbol(struct symbol *syma, struct symbol *symb)
> +int symbol__choose_best(const struct symbol_candidate *syma,
> +                       const struct symbol_candidate *symb)
>  {
>         s64 a;
>         s64 b;
>         size_t na, nb;
>
>         /* Prefer a symbol with non zero length */
> -       a =3D syma->end - syma->start;
> -       b =3D symb->end - symb->start;
> +       a =3D syma->size;
> +       b =3D symb->size;
>         if ((b =3D=3D 0) && (a > 0))
>                 return SYMBOL_A;
>         else if ((a =3D=3D 0) && (b > 0))
>                 return SYMBOL_B;
>
> -       if (symbol__type(syma) !=3D symbol__type(symb)) {
> -               if (symbol__type(syma) =3D=3D STT_NOTYPE)
> +       if (syma->type !=3D symb->type) {
> +               if (syma->type =3D=3D STT_NOTYPE)
>                         return SYMBOL_B;
> -               if (symbol__type(symb) =3D=3D STT_NOTYPE)
> +               if (symb->type =3D=3D STT_NOTYPE)
>                         return SYMBOL_A;
>         }
>
>         /* Prefer a non weak symbol over a weak one */
> -       a =3D symbol__binding(syma) =3D=3D STB_WEAK;
> -       b =3D symbol__binding(symb) =3D=3D STB_WEAK;
> +       a =3D syma->binding =3D=3D STB_WEAK;
> +       b =3D symb->binding =3D=3D STB_WEAK;
>         if (b && !a)
>                 return SYMBOL_A;
>         if (a && !b)
>                 return SYMBOL_B;
>
>         /* Prefer a global symbol over a non global one */
> -       a =3D symbol__binding(syma) =3D=3D STB_GLOBAL;
> -       b =3D symbol__binding(symb) =3D=3D STB_GLOBAL;
> +       a =3D syma->binding =3D=3D STB_GLOBAL;
> +       b =3D symb->binding =3D=3D STB_GLOBAL;
>         if (a && !b)
>                 return SYMBOL_A;
>         if (b && !a)
> @@ -213,6 +214,24 @@ static int choose_best_symbol(struct symbol *syma, s=
truct symbol *symb)
>         return arch__choose_best_symbol(syma, symb);
>  }
>
> +static int choose_best_symbol(struct symbol *syma, struct symbol *symb)
> +{
> +       struct symbol_candidate a =3D {
> +               .size =3D syma->end - syma->start,
> +               .name =3D syma->name,
> +               .type =3D symbol__type(syma),
> +               .binding =3D symbol__binding(syma),
> +       };
> +       struct symbol_candidate b =3D {
> +               .size =3D symb->end - symb->start,
> +               .name =3D symb->name,
> +               .type =3D symbol__type(symb),
> +               .binding =3D symbol__binding(symb),
> +       };
> +
> +       return symbol__choose_best(&a, &b);
> +}
> +
>  void symbols__fixup_duplicate(struct rb_root_cached *symbols)
>  {
>         struct rb_node *nd;
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index 46b1649c64fc..b9fa722a9a14 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -299,10 +299,22 @@ const char *arch__normalize_symbol_name(const char =
*name);
>  #define SYMBOL_A 0
>  #define SYMBOL_B 1
>
> +/* Attributes used to choose between symbols that share a start address.=
 */
> +struct symbol_candidate {
> +       u64             size;
> +       const char      *name;
> +       u8              type;
> +       u8              binding;
> +};
> +
> +int symbol__choose_best(const struct symbol_candidate *a,
> +                       const struct symbol_candidate *b);
> +
>  int arch__compare_symbol_names(const char *namea, const char *nameb);
>  int arch__compare_symbol_names_n(const char *namea, const char *nameb,
>                                  unsigned int n);
> -int arch__choose_best_symbol(struct symbol *syma, struct symbol *symb);
> +int arch__choose_best_symbol(const struct symbol_candidate *a,
> +                            const struct symbol_candidate *b);
>
>  enum symbol_tag_include {
>         SYMBOL_TAG_INCLUDE__NONE =3D 0,
>
> --
> Git-157)
>
>
