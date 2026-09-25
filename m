Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38A54D0A04
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349557; cv=pass; b=sxorg146ocH7678KW8L83DP91ljBfK2klzfjC0YXcplJQD1jTGPNGUgsxS/w9ZB7oE2+sZUU5oS3Q2/agMU7CmB5S7vW47qj2H/qLagjMgVCr0OqTFTNTDKNCC1V/cMDT7mIsdJhIjAXVJV8Lm3cqqN+R9YrNQuXQKlQuYpkZaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349557; c=relaxed/simple;
	bh=BfpSiMoRMuhz7+ENiUrfdl8trjCkqbUwJbd+UOn+scQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8eFEV3Ot2SPAJg4Hxa1XtD6gtORr2qT7BBFUnt6auXCRF075yomR2QVboSbgDA/SoaWVUYrz98DZQKdXFB+0v2V86ukCvE2IgkreKrZwoiUB7C5bRX2p9pdImiwVG9d+Hrb4FLcF1lFovjOMvOmIV+vQD2qUL35nVTYE97tgBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lUCGMUnz; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lUCGMUnz"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-530e8c6fb80so257311cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 08:19:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790349550; cv=none;
        d=google.com; s=arc-20260327;
        b=rtVJj3N8ApPumTb7a0SMiXlB5cpLQZumxwI2YfiiDkr14scd+wjVxwUsflkfIjLrfk
         ABByp3+oYPJpBdcGHxUiKZte6KowpXGVMnHRN3HTccrf6A50Q4XwGRnpQnan1TN+3tfu
         Sk8dElXzbKnD5HsUFrZ83hMmE/dGQ/z3O7rihOsCq4rheLH310f3LyGUkPC9IEzbR9j3
         f1ezc4sHoHP7UDhUw9CidmxfDL82Kjn903WQbKOQUSJBG2/QiTb7uKJtr1ePWgWYwGFI
         scLfpzimo4QM3kivwJpClEgv2fOAhGggGal3a/3gEh+OMN2bh3TVmMki7IkSq5f/Oqur
         LBBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/ALsqvqm5mzN+veMsZMal3KopdpFJFoLKTSC5y2Sj9g=;
        fh=xuGQD4/iDGNLYborTIcCEKhjXHv4OAspS+wUZU0y8rQ=;
        b=dW6YYHSB/BWcgV6L4+toBjPSlqu6PSMw8nj26oKiU9SiJ0SOxniQ/3vNciKpyBS9AK
         mMdGMLjp3OCYRhHnyCbKzo2FQ3x+f1o42GozxBIv8UHU4lcoCx8ZbONMP/c8047vvHT9
         X0bZL3EuHFPUPUavaWQSE679YOrFpYxsw4djA1R06m4i4i/u0XTSH7kfNP/DCXYhpvwZ
         stu+nGWnCJKtT1kNZrMdJ2wh/vnoBZX0WytQL6IOQ+QVYszxeg9lNHMst/fPaNCP+8Xe
         sW9i22Hsx8TgDWmFOX4k+OrsRuBjvZAummgM5L0LkCRfV/7XegVrASMlaFut2PDbKqS+
         1MWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790349550; x=1790954350; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/ALsqvqm5mzN+veMsZMal3KopdpFJFoLKTSC5y2Sj9g=;
        b=lUCGMUnzz3cyMb0m0D/dhADOIQqOhqzCPwk40IQgSReO0sqOnfKuz44F1qhy6yExt8
         fBnuSz01GmHZMPls/RZMz8gcIKy9Xo4PTwgkusKuPNjZbDV/3GBkaAVJo5OqCT1BO9Bu
         TJrWbt1PTvTFKWtzxc1yiIOUyGtVXZAyPJ2yMGA2N5jZt5QBZ4qZ166zY+F99iXjBXvO
         Cqj9UiV8qsmhRZFIUTklicBhgb4sJoF2EO6G9/kcwi+c3b0G2RFaYmGzCJQDx5o78eEi
         1sBfwQcC3bqb3ZMPQTdQVAa+0qRiWbo8YEwTtYhfRe46pmZ407ayZyVylhZxoAVS1Dtg
         Gg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790349550; x=1790954350;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ALsqvqm5mzN+veMsZMal3KopdpFJFoLKTSC5y2Sj9g=;
        b=AQryW92PtrdpUQJnaWqyKJRrZavdPf3C3So4+3dlxLPQ5Z7XT2Uhz6nqa+v0Gi15OW
         PIBubSNmYCxURQ8Liv48kV55bJJqXaZ/1DQGPtH0zcuPq9Y91/Lq1WIdyWNFtLmlA9r4
         J6ZQQ3fceLkUZ3JJ80zxfRzCEYsROZx5zUDcrXClUU71S7hflMOFco2435wUydKHcSQM
         Q97MltrEJV8otN8+Z0BPyWAmERRee3XwKs6NrX/WjTp6aUHDYyvorQdMQijRjqtR2d8N
         SYGalxrjXwxMqOCzXhDODHwd2X4+DHx6ucJmyYSTo7OvRs6IoWdYDjDkjSfzghppVAZO
         rMiQ==
X-Forwarded-Encrypted: i=1; AKwUvByGi2TFilYdix9Ufhaj430uh9EAp1zImcHKYhoOn3OOE5m+j7XutV5UAwrp2yDxTrM76kYCFm0UM/X/tuOftsJy@vger.kernel.org
X-Gm-Message-State: AFuF++kKtn83S9X1/PGAiGv9R4Jd0TZt2RS0fteHfz3pNHcrbEYXoib/
	CsALhkly0shi/MIf2aXnjF2rxzGFOJWw39qnA5ekyebwTbYhncaRQcX32++IGZT472rM+GDOQmd
	z2fYKVGCDrecscP5cjb0/S99RPJYYuh+ETBj0aqEE
X-Gm-Gg: AYBFou2ZSWeubxfJYNteXJnw3GYQubfAxm0ApiuhE54v05gbIFgbsIj0gfEy06xY62n
	+Ydhtn5ybDUiRUFrCh27qzYgDg3+MFr3ZMl9qhjNHLfNxL1zlHd4nSVFTQcpSbJ8WZauOzzogS4
	ybuLUaJ5Wq2yxwS2NgWYRhPXFxr7Px0vkivPsBjSR+d/mywUMZzEi4x7+UXVGcSJ0/rprqagVa2
	//i0Dnac/gbfY1fdORkI58k9Y4Q0z4p3ZDHLe4pwZaPmnkx0kEQN90e8klSJxr3Ey/IdfKNHE/O
	cPxJImIJ5AbXWRJKoebpjDsiE8c3QsmhmalAbHVk7PxAgb2OhLMtLNAFMae9HeWGtdd4oaqEzJ/
	9bNn74ZfT+Q==
X-Received: by 2002:a05:622a:4d03:b0:531:475:4ce6 with SMTP id
 d75a77b69052e-5331a828ed9mr4694441cf.9.1790349548780; Fri, 25 Sep 2026
 08:19:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925150657.1826942-1-acme@kernel.org> <20260925150657.1826942-2-acme@kernel.org>
In-Reply-To: <20260925150657.1826942-2-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Sep 2026 08:18:55 -0700
X-Gm-Features: AclHuK-seQpw-2YxFwtwTKniZ_ikqHuOG23hBi3iBbgvt26gBMVSs5fj_-JBUB0
Message-ID: <CAP-5=fUsMK7m5_VFh4xPDx=Dy3GK5bSGKYYzxWqm_LTn86svfQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] perf dwarf-aux: Bound the type chases for broken
 debug info
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 8:07=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> A DIE parsed at an offset that is not the start of a DIE can have a
> DW_AT_type that refers back to itself, making the typedef/qualifier
> chases in die_get_real_type(), die_get_pointer_type() and
> die_get_typename_from_type() spin forever; 'perf report -s type' did
> that on the dwz compressed debug info of zlib-ng (libz.so.1).
>
> No sane typedef/qualifier chain is 32 DIEs long, so give up on the type
> with a pr_debug instead of hanging.
>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/dwarf-aux.c | 84 ++++++++++++++++++++++++++++---------
>  1 file changed, 64 insertions(+), 20 deletions(-)
>
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 1560e721479a1ac2..2c135ebb1551fca4 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -267,16 +267,27 @@ Dwarf_Die *die_get_type(Dwarf_Die *vr_die, Dwarf_Di=
e *die_mem)
>                 return NULL;
>  }
>
> +/*
> + * A DIE parsed at an offset that is not the start of a DIE can refer
> + * back to itself via DW_AT_type: bound these chases.
> + */
> +#define MAX_TYPE_CHASE 32
> +
>  /* Get a type die, but skip qualifiers */
>  Dwarf_Die *__die_get_real_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem)
>  {
> -       int tag;
> +       int tag, chase =3D 0;
>
>         do {
>                 vr_die =3D die_get_type(vr_die, die_mem);
>                 if (!vr_die)
> -                       break;
> +                       return NULL;
>                 tag =3D dwarf_tag(vr_die);
> +               if (++chase > MAX_TYPE_CHASE) {
> +                       pr_debug("DWARF: qualifier chase limit reached at=
 DIE 0x%lx\n",
> +                                (unsigned long)dwarf_dieoffset(vr_die));
> +                       return NULL;
> +               }
>         } while (tag =3D=3D DW_TAG_const_type ||
>                  tag =3D=3D DW_TAG_restrict_type ||
>                  tag =3D=3D DW_TAG_volatile_type ||
> @@ -297,8 +308,15 @@ Dwarf_Die *__die_get_real_type(Dwarf_Die *vr_die, Dw=
arf_Die *die_mem)
>   */
>  Dwarf_Die *die_get_real_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem)
>  {
> +       int chase =3D 0;
> +
>         do {
>                 vr_die =3D __die_get_real_type(vr_die, die_mem);
> +               if (++chase > MAX_TYPE_CHASE) {
> +                       pr_debug("DWARF: typedef chase limit reached at D=
IE 0x%lx\n",
> +                                vr_die ? (unsigned long)dwarf_dieoffset(=
vr_die) : 0);
> +                       return NULL;
> +               }
>         } while (vr_die && dwarf_tag(vr_die) =3D=3D DW_TAG_typedef);
>
>         return vr_die;
> @@ -315,7 +333,7 @@ Dwarf_Die *die_get_real_type(Dwarf_Die *vr_die, Dwarf=
_Die *die_mem)
>   */
>  Dwarf_Die *die_get_pointer_type(Dwarf_Die *type_die, Dwarf_Die *die_mem)
>  {
> -       int tag;
> +       int tag, chase =3D 0;
>
>         do {
>                 tag =3D dwarf_tag(type_die);
> @@ -325,6 +343,11 @@ Dwarf_Die *die_get_pointer_type(Dwarf_Die *type_die,=
 Dwarf_Die *die_mem)
>                     tag !=3D DW_TAG_restrict_type && tag !=3D DW_TAG_vola=
tile_type &&
>                     tag !=3D DW_TAG_shared_type)
>                         return NULL;
> +               if (++chase > MAX_TYPE_CHASE) {
> +                       pr_debug("DWARF: pointer type chase limit reached=
 at DIE 0x%lx\n",
> +                                (unsigned long)dwarf_dieoffset(type_die)=
);
> +                       return NULL;
> +               }
>                 type_die =3D die_get_type(type_die, die_mem);
>         } while (type_die);
>
> @@ -1119,17 +1142,25 @@ Dwarf_Die *die_find_member(Dwarf_Die *st_die, con=
st char *name,
>                               die_mem);
>  }
>
> -/**
> - * die_get_typename_from_type - Get the name of given type DIE
> - * @type_die: a type DIE
> - * @buf: a strbuf for result type name
> - *
> - * Get the name of @type_die and stores it to @buf. Return 0 if succeede=
d.
> - * and Return -ENOENT if failed to find type name.
> - * Note that the result will stores typedef name if possible, and stores
> - * "*(function_type)" if the type is a function pointer.
> +/*
> + * The name follows DW_AT_type, so a self-referring DIE makes this
> + * recurse forever: bound it like the chases above.
>   */
> -int die_get_typename_from_type(Dwarf_Die *type_die, struct strbuf *buf)
> +static int __die_get_typename_from_type(Dwarf_Die *type_die, struct strb=
uf *buf,
> +                                       int depth);
> +
> +static int __die_get_typename(Dwarf_Die *vr_die, struct strbuf *buf, int=
 depth)
> +{
> +       Dwarf_Die type;
> +
> +       if (__die_get_real_type(vr_die, &type) =3D=3D NULL)
> +               return -ENOENT;
> +
> +       return __die_get_typename_from_type(&type, buf, depth);
> +}
> +
> +static int __die_get_typename_from_type(Dwarf_Die *type_die, struct strb=
uf *buf,
> +                                       int depth)
>  {
>         int tag, ret;
>         const char *tmp =3D "";
> @@ -1156,7 +1187,12 @@ int die_get_typename_from_type(Dwarf_Die *type_die=
, struct strbuf *buf)
>                 /* Write a base name */
>                 return strbuf_addf(buf, "%s%s", tmp, name ?: "");
>         }
> -       ret =3D die_get_typename(type_die, buf);
> +       if (depth >=3D MAX_TYPE_CHASE) {
> +               pr_debug("DWARF: type name recursion limit reached at DIE=
 0x%lx\n",
> +                        (unsigned long)dwarf_dieoffset(type_die));
> +               return -ENOENT;
> +       }
> +       ret =3D __die_get_typename(type_die, buf, depth + 1);
>         if (ret < 0) {
>                 /* void pointer has no type attribute */
>                 if (tag =3D=3D DW_TAG_pointer_type && ret =3D=3D -ENOENT)
> @@ -1167,6 +1203,19 @@ int die_get_typename_from_type(Dwarf_Die *type_die=
, struct strbuf *buf)
>         return strbuf_addstr(buf, tmp);
>  }
>
> +/**
> + * die_get_typename_from_type - Get the name of a type DIE
> + * @type_die: a type DIE
> + * @buf: a strbuf for the result type name
> + *
> + * Stores the typedef name if possible, "*(function_type)" for function
> + * pointers.  Returns 0 or -ENOENT.
> + */
> +int die_get_typename_from_type(Dwarf_Die *type_die, struct strbuf *buf)
> +{
> +       return __die_get_typename_from_type(type_die, buf, 0);
> +}
> +
>  /**
>   * die_get_typename - Get the name of given variable DIE
>   * @vr_die: a variable DIE
> @@ -1179,12 +1228,7 @@ int die_get_typename_from_type(Dwarf_Die *type_die=
, struct strbuf *buf)
>   */
>  int die_get_typename(Dwarf_Die *vr_die, struct strbuf *buf)
>  {
> -       Dwarf_Die type;
> -
> -       if (__die_get_real_type(vr_die, &type) =3D=3D NULL)
> -               return -ENOENT;
> -
> -       return die_get_typename_from_type(&type, buf);
> +       return __die_get_typename(vr_die, buf, 0);
>  }
>
>  /**
> --
> 2.53.0
>
