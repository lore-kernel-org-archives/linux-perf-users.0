Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A71262FC1
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Aug 2026 00:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785974460; cv=pass; b=iqi2xNPIuQV5lYLl6URJQyTM+8SqppSoWTJhH5+yYiV5RqiTg3U3pkwkSiPb/hboRzFnmY4GWQN6Gm7pszP9sNsLu4wh04IIMLvQ/iS4Rn9rcYxL5BqxE4X28mGB+rP6dPvOdIB9Yh/+XQ7WNtxg4mrpWscugqpQHxonK8W6nGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785974460; c=relaxed/simple;
	bh=Y/jla8UA8PgBnzZ2vh6ZLM9GsuNao2gxnOBA4FiMY+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T2Pr9kdPlAlxzIRKVLRQ4KHE8RVHZREbxNtbKH3CxfPwuteQGzocFgTFc5+eNgczhqKRcqEZlmofgtoFI+cRRqQ5IhlLr7KuzQexiMMVDtKiYfdyNjfnnnYQ7Y0Gez6GH8+VLHpZY7mCoykeUKEnzDnUd72G/ONNYRZz2Ey2kTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hwYZb3cp; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hwYZb3cp"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c10e86e52so57441cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2026 17:00:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785974453; cv=none;
        d=google.com; s=arc-20260327;
        b=hzAt/duuGz1qnjI8K9Q940WbUpDsJPOvpZC07QCzcztTltOrUxUPX2bTONmLmdYZ/B
         h0080+2xvPZ1ClenmVO4acqUAVseHDNkBGXWoH9v1iE3yGqFuC9tBmnfdG7t+R/rm/Js
         CJcu55xksDYK7PAow1MjHcwgrLZEg4ra/NCDFMWKWbBcgxrIsgU9bqUMidce9ItJI7B/
         KMtl8A1wSWrEwYFX61T0064qddZHM0TAeKjXbBHPqQPyednSfjSmrX01nrmX7a9xgJr4
         DFjK4wdjXEPkAAXj4TGrlEwV/+T9OeoFiqB6u4WbTozDEPT1GzcGNkZQ+lmsBiNi70RZ
         Ja6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eIfGNL2QMNiV3+yGRThFwh1G3awPTdwDalbZtla872Y=;
        fh=MaeSGBu+GKHDAos/dOe53KM+7Mhs1jxVzZPvfug10ZQ=;
        b=C/Co1IvIhZ/GbZvIjNdvk8uev8LDUd4VHbsbv/yKv+ZPxB/l5d1xLhxjzNWnagwfSA
         j/gVNZRlT0+ok8BmISjNn+uDql/1Y7U7j17fAFui5R1LhCW38I39Y/nVKfTR7Nx3bopd
         8JkJsqlpeJpF/scVG0I5QSO+H1WA13EiDZ0LN9mQRdwZDY0b4ygiF9wfqFvAus0Z4yaH
         FTXE1+GLl/J9Dc5OCAsUrN7wRfSV37hPrpc6LasNdxECwCOzF6e7iz2R63FSXdd5p+gP
         fJ6zkmiJOwBr3FewxsitweRpaAC5V/cFFo6tz1M1/glPIbkXVmGf3RkpNTEdjq6785KL
         vnlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785974453; x=1786579253; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eIfGNL2QMNiV3+yGRThFwh1G3awPTdwDalbZtla872Y=;
        b=hwYZb3cpx5RxDPGkne3IKsoxkR084qKuwkYmCfNcdT3tlIN1gThvN6s9FezXNrcATR
         iNYFH7LdiIIJ7SVt6+rHBwxx94Ib2CIE26qaFvivlZ5EW47+sN5krf0giAfrN9p2i99u
         aJGn7VNx+UqYKVeCwyHZsriV9C1qD4AZPZb5rqT8AJkwvzcBWwZWYRL3dadabkC+iICw
         QViHIdIoYmknb1hTJXY4Pv0xOjhAFyiAqgbef0ZGeEpS2T2XwlVqlGGFbfYCdrsH7Z6h
         EEQTaWD7QXTt8zgebAnCbe9M0sv5t3DoRh8+/uebK1ldYVsye9TAgv/fDWnJ3bYcExvO
         YZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785974453; x=1786579253;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eIfGNL2QMNiV3+yGRThFwh1G3awPTdwDalbZtla872Y=;
        b=XaIl1S5aA9suBtS7+EBat6zvzkVtMqTrOczGUSj+mFol+pgFIYjiR6MwYfRhTtsJAm
         qvuntlc/Fn5WYypjJASDR7ioUI0k6DGp+4g8OZp6bW2JumR5LGviisiH6rALxiT3d5mc
         wl48QRWYVgWlNLWCljeP5lKWeGcHN1Q76L8bkKvP/kFlJhpXKpDC0hHibtAGYlKtaEe8
         wZ1xgmcTa8igAFAO+JZ5yIPesWoyry+BIg0v+zPFoIFsH++jOyXKGRKThwkz/XvCTSyD
         qljCTgbKG1dSEWAhZ6WvG3tuyZiEmAL88s9/0Zsvayu41IINIMzNd9HsSFVlsWnU8VK8
         kqVw==
X-Forwarded-Encrypted: i=1; AHgh+RoSjgmo+t198mvPrw3X/khpDto0IvSDqzjONMx1ug1Ut9plGvUuv2KgLSJGMQeXXcInaG6IU3f/DNrjIF2nO9aE@vger.kernel.org
X-Gm-Message-State: AOJu0YxCC9vEwl0MOlmJGMr6Bt1HWPo+JGn7ZpV56wz3gj39aCGb55K5
	HhgcSXhI7oI6lTb9hQ4GJ7Y8EOtyoDic/k1Z675ipgrLfE3KGGse/6ankEdooSVPIGX7FbWtFZT
	hRqYCxB35Z03hYj6Z8Vyd1sMjNrNCut0SQSA/0QSRBVw1n96FE6nSzw8H
X-Gm-Gg: AR+sD11WfAIv2zGiBc+j5Uxf54znW9wnGsCGHH1UnTY5OlkrlPtWcIntweM1qEZegg3
	DQze9Jt0JF+MfLemnrra8P/zAR5lBJzOGOTzjImR0QGdzxY2TAtlG3eAghfdP6zV0zlPWya/fvl
	7DjRKvDuWxhH0S4yN0ZG4NdAi8GbJQOyTU/MT7XRlcNJJ6Oj8W91M/AbkkjCDMx5VbffQLv95jl
	/kO9PhY/Xi1GwRB7ch33l+jrhPq79GHjSZoLh679lLUE5gjY8CBi5gxe6PNh7C0jlhO0JR29ymd
	oP1eRmIvjAMPgscUY7famp18ViTfCJBXiHpuYQOx1yZlcA==
X-Received: by 2002:ac8:5a4e:0:b0:50f:af60:3496 with SMTP id
 d75a77b69052e-52cfe8205ccmr2447431cf.1.1785974452127; Wed, 05 Aug 2026
 17:00:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805151043.237233-1-acme@kernel.org> <20260805151043.237233-2-acme@kernel.org>
In-Reply-To: <20260805151043.237233-2-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Aug 2026 17:00:40 -0700
X-Gm-Features: AUfX_mye7_qd3ktH7qMn_G5YUoW6OZVWyWjdW-Tpg9m07Gd8uRk9AMHfVJL-otg
Message-ID: <CAP-5=fXKQAxrukBh2CazptHvoZdFhaOhLkZC6fXmgPf2fLD9Sw@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf c2c: Fix error masking, OOM, and unchecked
 caller errors in hpp_list__parse()
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	sashiko-bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 8:11=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> hpp_list__parse() has three bugs:
>
> 1. The PARSE_LIST macro resets ret =3D 0 at the start of each invocation,
>    so an error from output parsing is silently overwritten when the sort
>    parsing block runs.  The function returns success with partially
>    initialized state.
>
> 2. When the caller passes a non-NULL output_ or sort_ string, but
>    strdup() returns NULL due to OOM, NULL is passed to PARSE_LIST which
>    treats it as empty input (the "if (!_list) break" branch).  No error
>    is returned.
>
> 3. When the called _fn function fails and returns something other than
>    -ESRCH or -EINVAL (-ENOMEM, for instance) it was not bailing out of
>    the strtok loop.
>
> Fix them by checking strdup() return values before proceeding and adding
> a cleanup label so that ret from each PARSE_LIST call is checked before
> the next runs, preserving the first error.
>
> The early exits now skip perf_hpp__setup_output_field(), which means
> c2c_hists__reinit() can return a non-zero value in cases that previously
> always succeeded silently.  Both callers discarded its return:
> resort_cl_cb() continued into hists__collapse_resort() on a broken list,
> and perf_c2c__report() proceeded with uninitialised hists.  Fix the full
> chain: check and propagate the error in resort_cl_cb() -- hists__iterate_=
cb()
> already stops iteration and returns the callback error -- and check both
> c2c_hists__reinit() and hists__iterate_cb() in perf_c2c__report().
>
> Also turn PARSE_LIST into a function, using a switch to catch other
> errors, converting the called functions to return an appropriate errno
> instead of -1 on failure.
>
> Also make the two callers that iterate sort_dimension__add() and
> output_field_add() handle the newly propagated errors: setup_sort_list()
> and setup_output_list() only checked for -EINVAL and -ESRCH, so an
> -ENOMEM from a failed allocation was silently overwritten by the next
> loop iteration.  Break out of the loop and propagate any other error.
>
> The hpp_list__parse() fixes were developed with AI assistance from
> Claude:claude-sonnet-4.6, and the setup_sort_list()/setup_output_list()
> caller fixes with AI assistance from Opencode:mimo-v2.5-free and
> Opencode:DeepSeek-V4-Flash-free.
>
> Fixes: 2d388bd0c9d3 ("perf c2c report: Add stdio output support")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Assisted-by: Claude:claude-sonnet-4.6
> Assisted-by: Opencode:mimo-v2.5-free
> Assisted-by: Opencode:DeepSeek-V4-Flash-free
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-c2c.c | 85 ++++++++++++++++++++++++++++------------
>  tools/perf/util/sort.c   | 76 +++++++++++++++++++++++------------
>  2 files changed, 112 insertions(+), 49 deletions(-)
>
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index c9584dbedf77afe8..160b82694d391c50 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -12,11 +12,14 @@
>   */
>  #include <errno.h>
>  #include <inttypes.h>
> +#include <stdlib.h>
> +#include <string.h>
>
>  #include <asm/bug.h>
>  #include <linux/compiler.h>
>  #include <linux/err.h>
>  #include <linux/kernel.h>
> +#include <linux/string.h>
>  #include <linux/stringify.h>
>  #include <linux/zalloc.h>
>  #include <sys/param.h>
> @@ -2063,26 +2066,38 @@ static int c2c_hists__init_sort(struct perf_hpp_l=
ist *hpp_list, char *name, stru
>         return 0;
>  }
>
> -#define PARSE_LIST(_list, _fn)                                          =
       \
> -       do {                                                             =
       \
> -               char *tmp, *tok;                                         =
       \
> -               ret =3D 0;                                               =
         \
> -                                                                        =
       \
> -               if (!_list)                                              =
       \
> -                       break;                                           =
       \
> -                                                                        =
       \
> -               for (tok =3D strtok_r((char *)_list, ", ", &tmp);        =
         \
> -                               tok; tok =3D strtok_r(NULL, ", ", &tmp)) =
{        \
> -                       ret =3D _fn(hpp_list, tok, env);                 =
         \
> -                       if (ret =3D=3D -EINVAL) {                        =
           \
> -                               pr_err("Invalid --fields key: `%s'", tok)=
;      \
> -                               break;                                   =
       \
> -                       } else if (ret =3D=3D -ESRCH) {                  =
           \
> -                               pr_err("Unknown --fields key: `%s'", tok)=
;      \
> -                               break;                                   =
       \
> -                       }                                                =
       \
> -               }                                                        =
       \
> -       } while (0)
> +static int __hpp_list__parse(struct perf_hpp_list *hpp_list, char *_list=
, struct perf_env *env,
> +                            int (*_fn)(struct perf_hpp_list *hpp_list, c=
har *name, struct perf_env *env))
> +{
> +       char *tmp, *tok;
> +       int ret =3D 0;
> +
> +       if (!_list)
> +               return 0;
> +
> +       for (tok =3D strtok_r(_list, ", ", &tmp); tok; tok =3D strtok_r(N=
ULL, ", ", &tmp)) {
> +               ret =3D _fn(hpp_list, tok, env);
> +               switch (ret) {
> +               case 0:
> +                       continue;
> +               case -EINVAL:
> +                       pr_err("Invalid --fields key: `%s'", tok);
> +                       goto out;
> +               case -ESRCH:
> +                       pr_err("Unknown --fields key: `%s'", tok);
> +                       goto out;
> +               default: {
> +                       char buf[STRERR_BUFSIZE];
> +
> +                       pr_err("%s for --fields key: `%s'",
> +                              str_error_r(-ret, buf, sizeof(buf)), tok);
> +                       goto out;
> +               }
> +               }
> +       }
> +out:
> +       return ret;
> +}
>
>  static int hpp_list__parse(struct perf_hpp_list *hpp_list,
>                            const char *output_,
> @@ -2093,8 +2108,18 @@ static int hpp_list__parse(struct perf_hpp_list *h=
pp_list,
>         char *sort   =3D sort_   ? strdup(sort_) : NULL;
>         int ret;
>
> -       PARSE_LIST(output, c2c_hists__init_output);
> -       PARSE_LIST(sort,   c2c_hists__init_sort);
> +       /* strdup() returns NULL on OOM, don't silently treat as empty */
> +       if ((output_ && !output) || (sort_ && !sort)) {
> +               ret =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       ret =3D __hpp_list__parse(hpp_list, output, env, c2c_hists__init_=
output);
> +       if (ret)
> +               goto out;
> +       ret =3D __hpp_list__parse(hpp_list, sort, env, c2c_hists__init_so=
rt);
> +       if (ret)
> +               goto out;
>
>         /* copy sort keys to output fields */
>         perf_hpp__setup_output_field(hpp_list);
> @@ -2111,6 +2136,7 @@ static int hpp_list__parse(struct perf_hpp_list *hp=
p_list,
>         perf_hpp__append_sort_keys(&hists->list);
>  #endif
>
> +out:
>         free(output);
>         free(sort);
>         return ret;
> @@ -2281,6 +2307,7 @@ static int resort_cl_cb(struct hist_entry *he, void=
 *arg)
>         struct c2c_hist_entry *c2c_he;
>         struct c2c_hists *c2c_hists;
>         bool display =3D he__display(he, &c2c.shared_clines_stats);
> +       int ret;
>
>         c2c_he =3D container_of(he, struct c2c_hist_entry, he);
>         c2c_hists =3D c2c_he->hists;
> @@ -2291,7 +2318,9 @@ static int resort_cl_cb(struct hist_entry *he, void=
 *arg)
>                 c2c_he->cacheline_idx =3D idx++;
>                 calc_width(c2c_he);
>
> -               c2c_hists__reinit(c2c_hists, c2c.cl_output, c2c.cl_resort=
, env);
> +               ret =3D c2c_hists__reinit(c2c_hists, c2c.cl_output, c2c.c=
l_resort, env);
> +               if (ret)
> +                       return ret;
>
>                 hists__collapse_resort(&c2c_hists->hists, NULL);
>                 hists__output_resort_cb(&c2c_hists->hists, NULL, filter_c=
b);
> @@ -3356,13 +3385,19 @@ static int perf_c2c__report(int argc, const char =
**argv)
>         else if (c2c.display =3D=3D DISPLAY_SNP_PEER)
>                 sort_str =3D "tot_peer";
>
> -       c2c_hists__reinit(&c2c.hists, output_str, sort_str, perf_session_=
_env(session));
> +       err =3D c2c_hists__reinit(&c2c.hists, output_str, sort_str, perf_=
session__env(session));
> +       if (err) {
> +               pr_err("Failed to reinitialize hists\n");
> +               goto out_mem2node;
> +       }
>
>         ui_progress__init(&prog, c2c.hists.hists.nr_entries, "Sorting..."=
);
>
>         hists__collapse_resort(&c2c.hists.hists, NULL);
>         hists__output_resort_cb(&c2c.hists.hists, &prog, resort_shared_cl=
_cb);
> -       hists__iterate_cb(&c2c.hists.hists, resort_cl_cb, perf_session__e=
nv(session));
> +       err =3D hists__iterate_cb(&c2c.hists.hists, resort_cl_cb, perf_se=
ssion__env(session));
> +       if (err)
> +               goto out_mem2node;
>
>         ui_progress__finish();
>
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index dcf9189786f8aeba..58638ec9ae0ede7f 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -3105,7 +3105,7 @@ static int __sort_dimension__add_hpp_sort(struct so=
rt_dimension *sd,
>         struct hpp_sort_entry *hse =3D __sort_dimension__alloc_hpp(sd, le=
vel);
>
>         if (hse =3D=3D NULL)
> -               return -1;
> +               return -ENOMEM;
>
>         perf_hpp_list__register_sort_field(list, &hse->hpp);
>         return 0;
> @@ -3118,7 +3118,7 @@ static int __sort_dimension__add_hpp_output(struct =
sort_dimension *sd,
>         struct hpp_sort_entry *hse =3D __sort_dimension__alloc_hpp(sd, le=
vel);
>
>         if (hse =3D=3D NULL)
> -               return -1;
> +               return -ENOMEM;
>
>         perf_hpp_list__column_register(list, &hse->hpp);
>         return 0;
> @@ -3742,14 +3742,18 @@ static int __sort_dimension__add(struct sort_dime=
nsion *sd,
>                                  struct perf_hpp_list *list,
>                                  int level)
>  {
> +       int ret;
> +
>         if (sd->taken)
>                 return 0;
>
> -       if (__sort_dimension__add_hpp_sort(sd, list, level) < 0)
> -               return -1;
> +       ret =3D __sort_dimension__add_hpp_sort(sd, list, level);
> +       if (ret < 0)
> +               return ret;
>
> -       if (__sort_dimension__update(sd, list) < 0)
> -               return -1;
> +       ret =3D __sort_dimension__update(sd, list);
> +       if (ret < 0)
> +               return ret;
>
>         sd->taken =3D 1;
>
> @@ -3767,7 +3771,7 @@ static int __hpp_dimension__add(struct hpp_dimensio=
n *hd,
>
>         fmt =3D __hpp_dimension__alloc_hpp(hd, level);
>         if (!fmt)
> -               return -1;
> +               return -ENOMEM;
>
>         hd->taken =3D 1;
>         hd->was_taken =3D 1;
> @@ -3779,14 +3783,18 @@ static int __sort_dimension__add_output(struct pe=
rf_hpp_list *list,
>                                         struct sort_dimension *sd,
>                                         int level)
>  {
> +       int ret;
> +
>         if (sd->taken)
>                 return 0;
>
> -       if (__sort_dimension__add_hpp_output(sd, list, level) < 0)
> -               return -1;
> +       ret =3D __sort_dimension__add_hpp_output(sd, list, level);
> +       if (ret < 0)
> +               return ret;
>
> -       if (__sort_dimension__update(sd, list) < 0)
> -               return -1;
> +       ret =3D __sort_dimension__update(sd, list);
> +       if (ret < 0)
> +               return ret;
>
>         sd->taken =3D 1;
>         return 0;
> @@ -3803,7 +3811,7 @@ static int __hpp_dimension__add_output(struct perf_=
hpp_list *list,
>
>         fmt =3D __hpp_dimension__alloc_hpp(hd, level);
>         if (!fmt)
> -               return -1;
> +               return -ENOMEM;
>
>         hd->taken =3D 1;
>         perf_hpp_list__column_register(list, fmt);
> @@ -3869,8 +3877,7 @@ int sort_dimension__add(struct perf_hpp_list *list,=
 const char *tok,
>                                     strlen(tok)))
>                         return -EINVAL;
>
> -               __sort_dimension__add(sd, list, level);
> -               return 0;
> +               return __sort_dimension__add(sd, list, level);
>         }
>
>         for (i =3D 0; i < ARRAY_SIZE(memory_sort_dimensions); i++) {
> @@ -3882,8 +3889,7 @@ int sort_dimension__add(struct perf_hpp_list *list,=
 const char *tok,
>                 if (sort__mode !=3D SORT_MODE__MEMORY)
>                         return -EINVAL;
>
> -               __sort_dimension__add(sd, list, level);
> -               return 0;
> +               return __sort_dimension__add(sd, list, level);
>         }
>
>         for (i =3D 0; i < ARRAY_SIZE(hpp_sort_dimensions); i++) {
> @@ -3973,15 +3979,25 @@ static int setup_sort_list(struct perf_hpp_list *=
list, char *str,
>                         }
>
>                         ret =3D sort_dimension__add(list, tok, evlist, en=
v, level);
> -                       if (ret =3D=3D -EINVAL) {
> +                       switch (ret) {
> +                       case 0:
> +                               break;
> +                       case -EINVAL:
>                                 if (!cacheline_size() && !strncasecmp(tok=
, "dcacheline", strlen(tok)))
>                                         ui__error("The \"dcacheline\" --s=
ort key needs to know the cacheline size and it couldn't be determined on t=
his system");
>                                 else
>                                         ui__error("Invalid --sort key: `%=
s'", tok);
> -                               break;
> -                       } else if (ret =3D=3D -ESRCH) {
> +                               goto out;
> +                       case -ESRCH:
>                                 ui__error("Unknown --sort key: `%s'", tok=
);
> -                               break;
> +                               goto out;
> +                       default: {
> +                               char buf[STRERR_BUFSIZE];
> +
> +                               ui__error("%s for --sort key: `%s'",
> +                                         str_error_r(-ret, buf, sizeof(b=
uf)), tok);
> +                               goto out;
> +                       }
>                         }
>                         prev_level =3D level;
>                 }
> @@ -3989,6 +4005,7 @@ static int setup_sort_list(struct perf_hpp_list *li=
st, char *str,
>                 level =3D next_level;
>         } while (tmp);
>
> +out:
>         return ret;
>  }
>
> @@ -4315,15 +4332,26 @@ static int setup_output_list(struct perf_hpp_list=
 *list, char *str)
>         for (tok =3D strtok_r(str, ", ", &tmp);
>                         tok; tok =3D strtok_r(NULL, ", ", &tmp)) {
>                 ret =3D output_field_add(list, tok, &level);
> -               if (ret =3D=3D -EINVAL) {
> -                       ui__error("Invalid --fields key: `%s'", tok);
> +               switch (ret) {
> +               case 0:
>                         break;
> -               } else if (ret =3D=3D -ESRCH) {
> +               case -EINVAL:
> +                       ui__error("Invalid --fields key: `%s'", tok);
> +                       goto out;
> +               case -ESRCH:
>                         ui__error("Unknown --fields key: `%s'", tok);
> -                       break;
> +                       goto out;
> +               default: {
> +                       char buf[STRERR_BUFSIZE];
> +
> +                       ui__error("%s for --fields key: `%s'",
> +                                 str_error_r(-ret, buf, sizeof(buf)), to=
k);
> +                       goto out;
> +               }
>                 }
>         }
>
> +out:
>         return ret;
>  }
>
> --
> 2.55.0
>
