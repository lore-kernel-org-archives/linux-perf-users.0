Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E96D3BB9F7
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 21:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787000664; cv=pass; b=jKhatDdTP8PQ49GKsSff1O+XVuEWjemrmkyFn/8LWTHkDrm7u5Cf5pKH46xWoWTFi17hmD7HL0iUXvaXctJbDxXFTx1eE8D1kcNDn7okMLBo3UpGYzY8wLx6T674xRhfSxoU0K2d9s6FT9+trbxIx6HnisGtghL3L9rIphKKDtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787000664; c=relaxed/simple;
	bh=PAhYrtdx5NLi9ue+tN+M0wnwk+MU3zyevPugDDdlLkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xbc2lnHve4CK1GX6Weof2ox13RmOq/zim6/B/SAF/T0+ZYlKnRpFOHJz301vTzALs9T5hLaZW7XZKMZGyDGncQvSuotSA8pO1kLEaMMkUMHtxEAfctn7kPt/Nt9AxnIru/Uh48uGDsbnMyzRwMwijKNaJQm3XkP9zSvDvhptRy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ig7UDwhk; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ig7UDwhk"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c15a5b265so81571cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 14:04:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787000660; cv=none;
        d=google.com; s=arc-20260327;
        b=e7T6uIBUnvMOZO4GkbDTcN+uEDNJ3cgz+cp/gnQm+nsdujCHhOQN3f9MqP8WVZuGQL
         iBq8X8m2Kq1n0hEPdp+ZbQQzA0yxrAFxc/F/sV2G7Flh2yVm4xw3PMtFhIeHM0KvN7nY
         kGw3II/Ns4UxYuKulFPRmBgUiJDWdLAprqs9vDbEd/q+DicecBd+JQdstyrvU39G5InQ
         yddm0n43EIEzfSX5w1XjbFEzMpGzKrvhXVBkp7Um1dg6SfXWktYbdDkIm4JvXwah/Mfv
         TlKQV34y8f06lNbw+mJT3mvhvg0uqYOzlYl4JuAKDPqtqjZloaYZlXJX/+Ef/L1cLSuT
         nZPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MFs0YWkwzJt66DrRW5vFjSvfLaQPmpKfDuAqAvyXZvg=;
        fh=VS6EbT00eojF4HfcgEe80LgJY5u/bsNwbh1mU7q/VTQ=;
        b=dXtXh1VkGD4hRnMGNdWW+mIB+ogXzk0DeolYrhZJ8fBA1/B4cRaf6jUtdrJ2+1sXsS
         MWjCSY3jWnFNdRA0PIAhZC1hzyZe3twv0IfZw2ASct7jxNdUOCmRvV8CxoHfZN+1RkOc
         fMjt7v4JHHvwYY1ZtGp365ni7l6zwNPBf9va5gSKcPoxLeStxdTLroCaX2ObQyP6V/7a
         EE1cp2hzD1Dp0pwAwjvOEtPMXkGtd2NSn4xFUrt6BHi6py2EX5nz1zhF6bD6hH7Xnhwt
         /8L6Ci7yIW1OoW3c7G+DZ1qB3Yj0YZz/Wk72KxrmUIixN6GJ6258OdV0FT8eP5Owie1C
         ooUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787000660; x=1787605460; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MFs0YWkwzJt66DrRW5vFjSvfLaQPmpKfDuAqAvyXZvg=;
        b=Ig7UDwhkvEMDUbOa0/7wBZTeTkh7hkobZZBdsdgxegpV05CycmsXd/3KL8ZmaO/56k
         eY0SSw4BG64GPJdKJ1DG8IyxaJCI+S853h54If5qwHmtGqhivDQgTH+9tghLzc8zabb4
         mcRELts220nIIk/RW9rrdC1TKbxe3xegVa1WWfKsl5n24H90cXL4DRk+xbYrtz04yDUM
         jB2xhl5kzmpdOr1C7d4adpfjn0s59hO9kdG9G1mJZo+/gDNyEMANm/DdySSK0opOBjPq
         HyuVRQHtpeVuXD4E/xYzNj6QNR0L9Uq2MYzIQqwLyllL33qoBEmI+k5gtBlP5a3wOcKU
         xG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787000660; x=1787605460;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MFs0YWkwzJt66DrRW5vFjSvfLaQPmpKfDuAqAvyXZvg=;
        b=pLgix/iV/0ER17p8xyViaruquedWn22hfWzj65F2cbnrUYGnUw9gK0IIljK/vN7N5K
         uTbT1amINXIb3SwT1Vi4KcYTCJSGV4FcjAmADx14XlhJeyzr5YhD+EW58SJWo+8+ripc
         RN0PYokqDGve35cECLUzkL8lzcHqB8A9FhZlfHSDGgIiqr1jyyd2TgI2RWiI3WRYmyo2
         iONK7w+im/xymiaSodX0TWH+S6ID3av9LX8KcUd6YKYO8ND42K+mnLyX4075+NaffiYR
         6rYAUg0qxUdlVxDSVnL74YVGUGNfG7jYgV8o3dG0DZUpR+1yNXbB64UzUpVwNUrC9gWW
         Q4Xw==
X-Forwarded-Encrypted: i=1; AHgh+Ro7c13H60hy7j1TVzCVm6eho7NsaaKyG3Hrw8k/mRSNK/nHVP+sKU0x9H2chaJT1AKbuCdqcUL3MsDsrpZ0R7a3@vger.kernel.org
X-Gm-Message-State: AOJu0YzDRGhT7S6/elR7QuxkNydM8aDzQV4rzQI4W6wNsQsz9FGXKofa
	JoZ7M62X1X5jn4WFpqa/WlAKe7LcYFKzxKk4HT9LVgQ4b0YL/1IB/KBG1ZeWzVpY+WUjR/mHjwh
	TIzK+O3n+A2+ZAukchdMB+XDKomi5Q1QkARuYjQgD
X-Gm-Gg: AR+sD13VKjuNzr68FHGHEhHgmdzGretevHUxBpG+iX7sEKO2RQ9nn5BU28AqwqXapRF
	S3l7fA1bNQD6VsjsaOS0oM3QzgkeIq2lgFgybVlFhp3mrNc3zOyVIEhhJMxotesCnGJRvlNNNHb
	+1iGKO/o4LeHbDE8ASTNyXYTrD6O5CKTH1JNulAkoCvGXefsfixpOvRYIslgUxVfi5sTH0GQuug
	XzV5wAvIedt16NyFhKlbwRWKonHyiGj4w26gOJjqKrs4RvFP/8yyXmu/CpkpGSAU/Wx75Ze94yA
	bmSe/73ItiUjE/iNANbjhY1+ohKv08XmguLwTq+3kawupNg3oGFUWdLo6v3WtUEI93s7SupnR6A
	=
X-Received: by 2002:a05:622a:1928:b0:516:3f51:81cb with SMTP id
 d75a77b69052e-52dc0b86f81mr4217921cf.13.1787000659643; Mon, 17 Aug 2026
 14:04:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817094623.3288456-1-jiebin.sun@intel.com> <20260817094623.3288456-5-jiebin.sun@intel.com>
In-Reply-To: <20260817094623.3288456-5-jiebin.sun@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Aug 2026 14:04:06 -0700
X-Gm-Features: AcwNN1W6JPUdoJLK-e1TzdEkU6bM0FwqOG92zFnKDf4Z78H81oOFWV7Kms8f6SQ
Message-ID: <CAP-5=fUDH2mimHTKU+kgwxTq_wqoxwmoTbak43VaCkfPg=XEGw@mail.gmail.com>
Subject: Re: [PATCH v9 4/9] perf c2c: add HPP list parsing for function view columns
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
> Add the parser that builds the function view's local HPP output and
> sort lists from field strings. This includes dimension lookup, comparator
> wrappers, c2c_fmt allocation, and the initialization entry points used by
> the hierarchy builder.
>
> The generic perf_hpp__setup_output_field() registers formats on the globa=
l
> perf_hpp_list. Using it here would leave the function view's local list
> without output columns and modify the cacheline view's list instead. Add
> c2c_function_hists__setup_output_field() to append sort keys to the local
> output list.
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

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/c2c-function.c | 269 ++++++++++++++++++++++++++++++++-
>  1 file changed, 266 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/c2c-function.c b/tools/perf/util/c2c-functio=
n.c
> index 7fce415c0f07..d27544016660 100644
> --- a/tools/perf/util/c2c-function.c
> +++ b/tools/perf/util/c2c-function.c
> @@ -23,6 +23,7 @@
>  #include "addr_location.h"
>  #include "c2c.h"
>  #include "cacheline.h"
> +#include "debug.h"
>  #include "hist.h"
>  #include "map.h"
>  #include "mem-events.h"
> @@ -132,8 +133,8 @@ static int c2c_width(struct perf_hpp_fmt *fmt,
>                          dim->width;
>  }
>
> -static int __maybe_unused c2c_header(struct perf_hpp_fmt *fmt, struct pe=
rf_hpp *hpp,
> -                                    struct hists *hists, int line, int *=
span)
> +static int c2c_header(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
> +                     struct hists *hists, int line, int *span)
>  {
>         struct c2c_fmt *c2c_fmt;
>         struct c2c_dimension *dim;
> @@ -411,9 +412,271 @@ static struct c2c_dimension dim_symbol_view =3D {
>         .width          =3D SYMBOL_WIDTH,
>  };
>
> -static struct c2c_dimension *function_view_dimensions[] __maybe_unused =
=3D {
> +static struct c2c_dimension *function_view_dimensions[] =3D {
>         &dim_cycles_percent,
>         &dim_total_stores,
>         &dim_symbol_view,
>         NULL,
>  };
> +
> +static struct c2c_dimension *get_function_dimension(const char *name)
> +{
> +       unsigned int i;
> +
> +       for (i =3D 0; function_view_dimensions[i]; i++) {
> +               struct c2c_dimension *dim =3D function_view_dimensions[i]=
;
> +
> +               if (!strcmp(dim->name, name))
> +                       return dim;
> +       }
> +
> +       return NULL;
> +}
> +
> +/* Wrappers so sort_entry-backed dimensions sort/collapse via their se. =
*/
> +static int64_t c2c_se_cmp(struct perf_hpp_fmt *fmt,
> +                         struct hist_entry *a, struct hist_entry *b)
> +{
> +       struct c2c_fmt *c2c_fmt =3D container_of(fmt, struct c2c_fmt, fmt=
);
> +       struct c2c_dimension *dim =3D c2c_fmt->dim;
> +
> +       return dim->se->se_cmp(a, b);
> +}
> +
> +static int64_t c2c_se_collapse(struct perf_hpp_fmt *fmt,
> +                              struct hist_entry *a, struct hist_entry *b=
)
> +{
> +       struct c2c_fmt *c2c_fmt =3D container_of(fmt, struct c2c_fmt, fmt=
);
> +       struct c2c_dimension *dim =3D c2c_fmt->dim;
> +       int64_t (*collapse_fn)(struct hist_entry *a, struct hist_entry *b=
);
> +
> +       collapse_fn =3D dim->se->se_collapse ?: dim->se->se_cmp;
> +       return collapse_fn(a, b);
> +}
> +
> +static int64_t c2c_se_sort(struct perf_hpp_fmt *fmt,
> +                          struct hist_entry *a, struct hist_entry *b)
> +{
> +       struct c2c_fmt *c2c_fmt =3D container_of(fmt, struct c2c_fmt, fmt=
);
> +       struct c2c_dimension *dim =3D c2c_fmt->dim;
> +       int64_t (*sort_fn)(struct hist_entry *a, struct hist_entry *b);
> +
> +       sort_fn =3D dim->se->se_sort ?: dim->se->se_cmp;
> +       return sort_fn(a, b);
> +}
> +
> +/*
> + * Build the c2c_fmt for @name. Returns:
> + *   0        and *fmtp set     on success;
> + *   -ENOENT  and *fmtp =3D NULL   if @name is not a function-view dimen=
sion;
> + *   -ENOMEM                     if allocation failed (distinct from -EN=
OENT so
> + *                               the caller does not misreport it as an
> + *                               "invalid field").
> + */
> +static int get_function_format(const char *name, struct c2c_fmt **fmtp)
> +{
> +       struct c2c_dimension *dim =3D get_function_dimension(name);
> +       struct c2c_fmt *c2c_fmt;
> +       struct perf_hpp_fmt *fmt;
> +
> +       *fmtp =3D NULL;
> +
> +       if (!dim)
> +               return -ENOENT;
> +
> +       c2c_fmt =3D zalloc(sizeof(*c2c_fmt));
> +       if (!c2c_fmt)
> +               return -ENOMEM;
> +
> +       fmt =3D &c2c_fmt->fmt;
> +
> +       c2c_fmt->dim =3D dim;
> +       INIT_LIST_HEAD(&fmt->list);
> +       INIT_LIST_HEAD(&fmt->sort_list);
> +
> +       fmt->cmp        =3D dim->se ? c2c_se_cmp : dim->cmp;
> +       fmt->sort       =3D dim->se ? c2c_se_sort : dim->cmp;
> +       fmt->color      =3D dim->color;
> +       fmt->entry      =3D dim->entry;
> +       fmt->header     =3D c2c_header;
> +       fmt->width      =3D c2c_width;
> +       fmt->collapse   =3D dim->se ? c2c_se_collapse : dim->cmp;
> +       fmt->equal      =3D c2c_fmt_equal;
> +       fmt->free       =3D c2c_fmt_free;
> +
> +       *fmtp =3D c2c_fmt;
> +       return 0;
> +}
> +
> +static int
> +c2c_function_hists__init_output(struct perf_hpp_list *hpp_list, char *na=
me,
> +                               struct perf_env *env __maybe_unused)
> +{
> +       struct c2c_fmt *c2c_fmt;
> +       int ret;
> +
> +       ret =3D get_function_format(name, &c2c_fmt);
> +       if (ret =3D=3D -ENOMEM)
> +               return ret;
> +       /* The function view only accepts its own dimensions. */
> +       if (ret =3D=3D -ENOENT)
> +               return -EINVAL;
> +
> +       /*
> +        * Mark symbol-backed columns so hists__has(hists, sym) is correc=
t.
> +        * Only dim_symbol_view carries a sort_entry (.se); the function
> +        * view's field strings are fixed and always include symbol_view,=
 so
> +        * this single check is sufficient (unlike the user-configurable
> +        * cacheline view, which must also test dim_iaddr).
> +        */
> +       if (c2c_fmt->dim->se =3D=3D &sort_sym)
> +               hpp_list->sym =3D 1;
> +
> +       perf_hpp_list__column_register(hpp_list, &c2c_fmt->fmt);
> +       return 0;
> +}
> +
> +static int
> +c2c_function_hists__init_sort(struct perf_hpp_list *hpp_list, char *name=
,
> +                             struct perf_env *env __maybe_unused)
> +{
> +       struct c2c_fmt *c2c_fmt;
> +       int ret;
> +
> +       ret =3D get_function_format(name, &c2c_fmt);
> +       if (ret =3D=3D -ENOMEM)
> +               return ret;
> +       /* The function view only accepts its own dimensions. */
> +       if (ret =3D=3D -ENOENT)
> +               return -EINVAL;
> +
> +       /* Mark symbol-backed sort keys so hists__has(hists, sym) is corr=
ect. */
> +       if (c2c_fmt->dim->se =3D=3D &sort_sym)
> +               hpp_list->sym =3D 1;
> +
> +       perf_hpp_list__register_sort_field(hpp_list, &c2c_fmt->fmt);
> +       return 0;
> +}
> +
> +typedef int (*hpp_list_add_fn)(struct perf_hpp_list *hpp_list, char *nam=
e,
> +                              struct perf_env *env);
> +
> +static int function_hpp_list__add_tokens(struct perf_hpp_list *hpp_list,=
 char *list,
> +                                        struct perf_env *env, hpp_list_a=
dd_fn add)
> +{
> +       char *tok, *tmp;
> +       int ret;
> +
> +       if (!list)
> +               return 0;
> +
> +       for (tok =3D strtok_r(list, ", ", &tmp); tok; tok =3D strtok_r(NU=
LL, ", ", &tmp)) {
> +               ret =3D add(hpp_list, tok, env);
> +               if (ret) {
> +                       if (ret =3D=3D -EINVAL || ret =3D=3D -ESRCH)
> +                               pr_err("Invalid c2c function-view field: =
%s\n", tok);
> +                       return ret;
> +               }
> +       }
> +       return 0;
> +}
> +
> +/*
> + * Append the function view's sort keys to its own output fields, mirror=
ing
> + * perf_hpp__setup_output_field() but on the local @list. The shared hel=
per
> + * registers onto the global perf_hpp_list, which would leave this local=
 list
> + * without output columns, so the function view keeps its own copy here.
> + */
> +static void c2c_function_hists__setup_output_field(struct perf_hpp_list =
*list)
> +{
> +       struct perf_hpp_fmt *fmt;
> +
> +       perf_hpp_list__for_each_sort_list(list, fmt) {
> +               struct perf_hpp_fmt *pos;
> +
> +               if (!fmt->entry && !fmt->color)
> +                       continue;
> +
> +               perf_hpp_list__for_each_format(list, pos) {
> +                       if (c2c_fmt_equal(fmt, pos))
> +                               goto next;
> +               }
> +
> +               perf_hpp_list__column_register(list, fmt);
> +next:
> +               continue;
> +       }
> +}
> +
> +static int
> +function_hpp_list__parse(struct perf_hpp_list *hpp_list,
> +                        const char *output_str,
> +                        const char *sort_str,
> +                        struct perf_env *env)
> +{
> +       char *output =3D output_str ? strdup(output_str) : NULL;
> +       char *sort   =3D sort_str   ? strdup(sort_str)   : NULL;
> +       int ret =3D 0;
> +
> +       if ((output_str && !output) || (sort_str && !sort)) {
> +               ret =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       ret =3D function_hpp_list__add_tokens(hpp_list, output, env,
> +                                           c2c_function_hists__init_outp=
ut);
> +       if (ret)
> +               goto out;
> +
> +       ret =3D function_hpp_list__add_tokens(hpp_list, sort, env,
> +                                           c2c_function_hists__init_sort=
);
> +       if (ret)
> +               goto out;
> +
> +       c2c_function_hists__setup_output_field(hpp_list);
> +out:
> +       if (ret)
> +               perf_hpp__reset_output_field(hpp_list);
> +       free(output);
> +       free(sort);
> +       return ret;
> +}
> +
> +static int __maybe_unused
> +c2c_function_hists__init(struct c2c_hists *hists,
> +                        const char *sort,
> +                        int nr_header_lines,
> +                        struct perf_env *env)
> +{
> +       __hists__init(&hists->hists, &hists->list);
> +
> +       perf_hpp_list__init(&hists->list);
> +
> +       hists->list.nr_header_lines =3D nr_header_lines;
> +
> +       return function_hpp_list__parse(&hists->list, /*output=3D*/NULL, =
sort, env);
> +}
> +
> +static int __maybe_unused
> +c2c_function_hists__reinit(struct c2c_hists *c2c_hists,
> +                          const char *output,
> +                          const char *sort,
> +                          struct perf_env *env)
> +{
> +       int nr_header_lines =3D c2c_hists->list.nr_header_lines;
> +
> +       perf_hpp__reset_output_field(&c2c_hists->list);
> +
> +       /* Clear stale state flags so a different output/sort set starts =
fresh. */
> +       c2c_hists->list.need_collapse =3D 0;
> +       c2c_hists->list.parent =3D 0;
> +       c2c_hists->list.sym =3D 0;
> +       c2c_hists->list.dso =3D 0;
> +       c2c_hists->list.socket =3D 0;
> +       c2c_hists->list.thread =3D 0;
> +       c2c_hists->list.comm =3D 0;
> +       c2c_hists->list.comm_nodigit =3D 0;
> +       c2c_hists->list.nr_header_lines =3D nr_header_lines;
> +
> +       return function_hpp_list__parse(&c2c_hists->list, output, sort, e=
nv);
> +}
> --
> 2.52.0
>
