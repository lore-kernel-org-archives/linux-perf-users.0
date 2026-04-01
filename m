Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55B33630AD
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 21:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775077437; cv=pass; b=Z6Df2OSiDCu0+EcfAS4lZX2lD9TVrWzk4G8O2fF2Gmmx5XYelP+IqOehQWf1zzT2Yzfa1Ak59P9XWCDBmisTrsVOWS8Sa1W/pE2PmUJqx+r5PeNKwJ5Ql1is6qN2lhoO6IJ54nAt4icHg/vPpZmAOYX/a0729O/YqUFoRV1UT+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775077437; c=relaxed/simple;
	bh=Z1BMpOhF+V9EjXw6M2+vARbBnJ+e3ZSCqJrL03dBjCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kl0TbEbDoCskehZSnHnZgSbg6eEwrd2jA/VYihhlzh+IC2luo4QsXKev2z1Hc/tLuN2QSNFKfRcjf/6ZtYdhT7jkOjs2YdCBrnPf23X4Ofwz/85Z1H7A8jqmJuqBpRYQdE1i1Kxng5CW2mH3PMBroE8htN6nNfo0A9qMbippe/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B0XkeOz2; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B0XkeOz2"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b0c12be0ecso13615ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 14:03:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775077435; cv=none;
        d=google.com; s=arc-20240605;
        b=EvOA3CkRM4peK9i8bdnDwLYQiTm2XJNoO3Y7QAk6NEKEecJgZULXgFXDt0e3b6+yfz
         c+dJlX2+9RLtGeRviYiQiAwDLUzemxcsZq/nzulHSsYWnmVIm+vJdOIMTQtcg2xoKCKE
         zuPG+w2TzRznEt8vhEYhMZYaS50aAMBADLE3lKEzJQ51ijsufzXZPnDpT5QPK7PGwtyz
         iQKG+fN5Tvara8jBljLlMDeecTbVBC0Q8svdOS5Lt29awYhOMtEGZZoy2mLH9otkexgZ
         XhKhZ8Jjpnlz60gYU71/KxKWyTLT8185tWG7dM0Vdh3PEOkQlcoVw/oAD3g3empuffTf
         7ESg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5kwQKpquo4FrJs2lCTTA2M476w3NJeE3gHk+rdBfpL4=;
        fh=c/8rSZ9kEqgMqIwENxtc9j39FUHAv62A/PGgDhHXhZw=;
        b=d75nGDyVeiCwhbxTMh8yp1lq4Hu3KvITF9ZBD56kGT+ZJ90r+XaKw5dQs7hTkPxm5w
         G6lDFt6aQPdQKpk+Hdeh9Xemq1tEy2DG0rU3DbhHRv1JitcEfPMO1s31YDgSaEYcC0zD
         CzZA0YHcxGV58uDpW3lHc3PzzPwir6D4zGajVnhR+ZiPw9bD7t7hXOq48x0HO0rBnAsj
         BqzLeHts6kldgApR8eN0K6Q0wGHRN9phOqO1bUw/M3d3/k1qxEPAwwiykNww2EmCdKlU
         7tcHcYiB7LO0LyVb2iq3TPSc/uK2KmQtUXM78kCYSQUlGysN4RGBZbif2A5MMcd12LjZ
         wORA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775077435; x=1775682235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kwQKpquo4FrJs2lCTTA2M476w3NJeE3gHk+rdBfpL4=;
        b=B0XkeOz2OiOx1oEWfSFY2r8EsIQxqf4BFz2YgH30flFSroZz8xSWONzdWQ9JUOMKik
         ZDSGrkR6RtFHHDWZFA9eAJRUd1Y5ZKTsKeDg9UXMeYZrhxEP5IgLlWNhBskdTe/kIyjp
         RxVUv6b9sW9q7o0skIhuWRbeq0y8w7h67xrpQPrnWgF+pvncjP5G7pqMz28BCOWqINVg
         CixRQWyj1fFgy5NvuVImgMyFViaCBblum80PTuZvR09N4+HnV2jVIly8vwpCob38YNTH
         1Itksgcu6jrz5SW9bKMVXZ0w1AhNRfNHplAPPcOIdG/PGZGZmUsGitpX9u6YhEtoGnPN
         XLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775077435; x=1775682235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5kwQKpquo4FrJs2lCTTA2M476w3NJeE3gHk+rdBfpL4=;
        b=R7XBgRYOYt4cMQ1xODE5uctTwoW3XEE7h6q/0tO6gNuZ2wBAJRI4LgbKCZslLpdi+r
         nZF6sZMc5VDoGSn7K5nyNy16p/UiaPo1qkRFdk/ed2KtPeKZ4+oFLNV10ES6yMROgX3F
         yfQFvqKWpjnYqmB8c+aSp46SKIhGRheXiceGOcsMl/46s1RaZIK65nfoU4j/A+m4XhZC
         LjXwpcZfqZQTeHuM38aqAiScKKOuaCCZuC86JMIRyqWKaxGIGlMNqcWuqPkP/Ggh8Umc
         Lf74wy6AYf/7w6DYTJJohYGbjFwoHYHa4Z/NaMraUW9UuxygLJ1f+j/gX6yIDooy4L5h
         hCqA==
X-Forwarded-Encrypted: i=1; AJvYcCW+d6IHPDyzuDhxSRxDgCWOyR+fQz99wPTKq6pHmiJH7Kcd04kPCWfaqRZW4VuKTNacoUlZIiNYgTymUUjcvk+0@vger.kernel.org
X-Gm-Message-State: AOJu0YwGiiaZUjb6LkZyYD5aW0KJ3hu3cUt3vNuDLoXuhywdLLz9S/k7
	JIL43XjNUbCfhQrTORpHeu1jPkr9GrhH1HeLBXnzPci+jnKWJ69ZvyU9IXIt6jPp1zqAAL2JtvS
	QIk8myPnVr59kA3XWIWsLYxYgb7kn9PWL4LNTW5Rjzie9L810ZLlWzu7I7is=
X-Gm-Gg: ATEYQzxysTmDcFvuSjSRvclvYdxsAQ+sltJ2grWdxB9ttajwvEijgw+f1hBhyNL5yvU
	IB4uNg55zww9dn2kT+31E+g4d3LVzyo9fndL/R6eaJ0dwGodiENTS7CZMSLyKGoCLDq8ICt/dRQ
	Ib77UE4bBm8XljzEbCbkOrAYpbsMWRbHOjaBKJGMoccHf/t00RFGj1Bgm9+M0CzAyW4O+0uEMMT
	xV/jgArEGEXDa4ByHl7lvl0RUZ+YRbxJ5/FarfxUx4TXWueRKvzc0+7LpRsoLBDGJtwVJ+2TDV3
	Fs86ANkwPwI4szGfTD9tJ94/KkAufqY7JC92e4s5HWogkU4=
X-Received: by 2002:a17:903:3b83:b0:2b0:7a9b:82f3 with SMTP id
 d9443c01a7336-2b276aeda7cmr506615ad.8.1775077434503; Wed, 01 Apr 2026
 14:03:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205123608.3125691-1-sesse@google.com>
In-Reply-To: <20251205123608.3125691-1-sesse@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Apr 2026 14:03:42 -0700
X-Gm-Features: AQROBzBxvAufV6l5HY-hUWF6p3YeXgwYnuT5G9vz8Qjo5ZWDVnUTFYByX8-xDVE
Message-ID: <CAP-5=fW7y93ZfSF0Mrt3nB1Jqu4HaKypEUhH88CTyy9-v4JPdA@mail.gmail.com>
Subject: Re: [PATCH] perf probe: Improve C++ support in arguments
To: "Steinar H. Gunderson" <sesse@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 4:36=E2=80=AFAM Steinar H. Gunderson <sesse@google.c=
om> wrote:
>
> For purposes of specifying arguments in tracepoints, C++ classes
> work exactly like structs, and C++ references work almost exactly
> like pointers (they are dereferenced with . instead of ->).
> However, they use different tags in DWARF, which means you cannot
> use them in arguments.
>
> Implement support for both, based on the existing struct and pointer
> support. This allows us to to something like this in Chromium:
>
>   perf probe --exec content_shell --add 'PerformanceMark=3D\
> _ZN5blink15PerformanceMark6CreateEPNS_11ScriptStateERKNS_12\
> AtomicStringEPNS_22PerformanceMarkOptionsERNS_14ExceptionStateE \
> mark_name.string_.impl_.ptr_'
>
> even though mark_name is an class AtomicString&.
>
> We don't support advanced C++ features, such as operator overloading.
> Unfortunately, we also don't support C++-style strings where there
> is a separate length field instead of null-termination. We also cannot
> go past ptr_ in the example above (e.g. add ->length_), due to
> unrelated DWARF issues.
>
> Signed-off-by: Steinar H. Gunderson <sesse@google.com>
> Cc: Ian Rogers <irogers@google.com>

This change makes sense to me, Namhyung?

Thanks,
Ian

> ---
>  tools/perf/util/annotate-data.c |  3 ++-
>  tools/perf/util/dwarf-aux.c     | 13 ++++++++++---
>  tools/perf/util/probe-finder.c  | 24 +++++++++++++++++-------
>  3 files changed, 29 insertions(+), 11 deletions(-)
>
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-d=
ata.c
> index 07cf9c334be0..d97b5fc61e6f 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -459,7 +459,8 @@ static bool is_pointer_type(Dwarf_Die *type_die)
>  {
>         int tag =3D dwarf_tag(type_die);
>
> -       return tag =3D=3D DW_TAG_pointer_type || tag =3D=3D DW_TAG_array_=
type;
> +       return tag =3D=3D DW_TAG_pointer_type || tag =3D=3D DW_TAG_refere=
nce_type ||
> +              tag =3D=3D DW_TAG_array_type;
>  }
>
>  static bool is_compound_type(Dwarf_Die *type_die)
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 9267af204c7d..25bbc840d1a8 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -1112,6 +1112,8 @@ int die_get_typename_from_type(Dwarf_Die *type_die,=
 struct strbuf *buf)
>         tag =3D dwarf_tag(type_die);
>         if (tag =3D=3D DW_TAG_pointer_type)
>                 tmp =3D "*";
> +       else if (tag =3D=3D DW_TAG_reference_type)
> +               tmp =3D "&";
>         else if (tag =3D=3D DW_TAG_array_type)
>                 tmp =3D "[]";
>         else if (tag =3D=3D DW_TAG_subroutine_type) {
> @@ -1124,6 +1126,8 @@ int die_get_typename_from_type(Dwarf_Die *type_die,=
 struct strbuf *buf)
>                         tmp =3D "union ";
>                 else if (tag =3D=3D DW_TAG_structure_type)
>                         tmp =3D "struct ";
> +               else if (tag =3D=3D DW_TAG_class_type)
> +                       tmp =3D "class ";
>                 else if (tag =3D=3D DW_TAG_enumeration_type)
>                         tmp =3D "enum ";
>                 else if (name =3D=3D NULL)
> @@ -2065,7 +2069,8 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_die,=
 int offset,
>
>         tag =3D dwarf_tag(type_die);
>         /* If it's not a compound type, return the type directly */
> -       if (tag !=3D DW_TAG_structure_type && tag !=3D DW_TAG_union_type)=
 {
> +       if (tag !=3D DW_TAG_structure_type && tag !=3D DW_TAG_class_type =
&&
> +           tag !=3D DW_TAG_union_type) {
>                 Dwarf_Word size;
>
>                 if (dwarf_aggregate_size(type_die, &size) < 0)
> @@ -2080,7 +2085,8 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_die,=
 int offset,
>
>         mb_type =3D *type_die;
>         /* TODO: Handle union types better? */
> -       while (tag =3D=3D DW_TAG_structure_type || tag =3D=3D DW_TAG_unio=
n_type) {
> +       while (tag =3D=3D DW_TAG_structure_type || tag =3D=3D DW_TAG_clas=
s_type ||
> +              tag =3D=3D DW_TAG_union_type) {
>                 member =3D die_find_child(&mb_type, __die_find_member_off=
set_cb,
>                                         (void *)(long)offset, die_mem);
>                 if (member =3D=3D NULL)
> @@ -2091,7 +2097,8 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_die,=
 int offset,
>
>                 tag =3D dwarf_tag(&mb_type);
>
> -               if (tag =3D=3D DW_TAG_structure_type || tag =3D=3D DW_TAG=
_union_type) {
> +               if (tag =3D=3D DW_TAG_structure_type || tag =3D=3D DW_TAG=
_class_type ||
> +                   tag =3D=3D DW_TAG_union_type) {
>                         Dwarf_Word loc;
>
>                         /* Update offset for the start of the member stru=
ct */
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finde=
r.c
> index 5ffd97ee4898..ca4734c75bba 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -360,12 +360,20 @@ static int convert_variable_fields(Dwarf_Die *vr_di=
e, const char *varname,
>                 ref->offset +=3D dwarf_bytesize(&type) * field->index;
>                 ref->user_access =3D user_access;
>                 goto next;
> -       } else if (tag =3D=3D DW_TAG_pointer_type) {
> +       } else if (tag =3D=3D DW_TAG_pointer_type || tag =3D=3D DW_TAG_re=
ference_type) {
>                 /* Check the pointer and dereference */
> -               if (!field->ref) {
> -                       pr_err("Semantic error: %s must be referred by '-=
>'\n",
> -                              field->name);
> -                       return -EINVAL;
> +               if (tag =3D=3D DW_TAG_pointer_type) {
> +                       if (!field->ref) {
> +                               pr_err("Semantic error: %s must be referr=
ed by '->'\n",
> +                                      field->name);
> +                               return -EINVAL;
> +                       }
> +               } else {
> +                       if (field->ref) {
> +                               pr_err("Semantic error: %s must be referr=
ed by '.'\n",
> +                                      field->name);
> +                               return -EINVAL;
> +                       }
>                 }
>                 /* Get the type pointed by this pointer */
>                 if (die_get_real_type(&type, &type) =3D=3D NULL) {
> @@ -374,7 +382,8 @@ static int convert_variable_fields(Dwarf_Die *vr_die,=
 const char *varname,
>                 }
>                 /* Verify it is a data structure  */
>                 tag =3D dwarf_tag(&type);
> -               if (tag !=3D DW_TAG_structure_type && tag !=3D DW_TAG_uni=
on_type) {
> +               if (tag !=3D DW_TAG_structure_type && tag !=3D DW_TAG_uni=
on_type &&
> +                   tag !=3D DW_TAG_class_type) {
>                         pr_warning("%s is not a data structure nor a unio=
n.\n",
>                                    varname);
>                         return -EINVAL;
> @@ -389,7 +398,8 @@ static int convert_variable_fields(Dwarf_Die *vr_die,=
 const char *varname,
>                         *ref_ptr =3D ref;
>         } else {
>                 /* Verify it is a data structure  */
> -               if (tag !=3D DW_TAG_structure_type && tag !=3D DW_TAG_uni=
on_type) {
> +               if (tag !=3D DW_TAG_structure_type && tag !=3D DW_TAG_uni=
on_type &&
> +                   tag !=3D DW_TAG_class_type) {
>                         pr_warning("%s is not a data structure nor a unio=
n.\n",
>                                    varname);
>                         return -EINVAL;
> --
> 2.51.0
>
