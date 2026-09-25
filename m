Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECA74477F3
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 19:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790365237; cv=pass; b=DhVr1P+dRMdyvn0SGNh5G/GgoVsegnPkBNJA2Vzz2yg55DGTAyC3vsqgekWEbmMQHY5u4x0WcwDlGH87XcyOC797zFeVT6uvrfeZPfgKQMn5VrAp3cijbbRUiu2PCDwA/ILClLwWC8l4Cgxck+9wbxjxvgO2NOgBZHsjW8bzLJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790365237; c=relaxed/simple;
	bh=cSEPaWrxu9J9A6Q6ZKxTTatML/3vuqOsToEKTBJGE+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DZu1eR+aYPT5FA5OM1CTj8rsn+7Jgtcy8TEY0CEaZ7F4JCX/yk/bhn9OCgyvGTK+z8vIjHunT3OEjTLKo6xl6TmWMrGItjkepdCmxXjCccL3khJ654WSsD5SG0+nTetKK4FiH/0VeSCwulXw5UiMvkwH6+FZvZLkgBJWt/Rp2jY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AEi9bH3o; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AEi9bH3o"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-52faa58bff5so63221cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 12:40:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790365235; cv=none;
        d=google.com; s=arc-20260327;
        b=rVu5RCXHcKOR125UBGoDa5H+izuYuDQoSHpXW987JinRMqJNOQdONTmlVm5ZvUls25
         w22FNjZnxVvidN2vzv/L9QTJb2zoe1vmZkZuVFGgS5BpsxlGUpboXKdh7mNpVW4xWWe3
         0igSvB4hxMP3upVGMroOWamNsRJ801ockOAwSkHfAIPAMpxzXr9SOU6WELdNmSekFtcp
         P38gZy8NUkgIpUUNkFTosNKqgQG9RxbDWbX9tAaUr4AjspTCNxbGRH9Nkj5v4XOxKSEB
         OLd1iix2n+uno72Qu215PAf+e6vFIvJT6ITuw+xxM6Xa8p+hCFn3Lsa1/MFuqFBjirJJ
         1+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7w0ggNaiJUtaov8Aw9vNOQm+fzqQlGb0OSXJBvfDhk4=;
        fh=44ui/t1Y5GldsLYX8Q0rkJwtaMe15ffqLnUW45hgiDc=;
        b=LhFFSUDk6g1OK8cu6VI6dUO2CUKmTCf7oIckIc+AhgucTgMLT/u98PkKtehIQpgBjM
         xmbU3i5kOZ7VXPX35xqgZKhI3TEB1/NlxGx1kaTXXgu+5mFEcbBe+KdyxGc6L0FxDcdO
         z4ebMLDCnCYQrplq5Dlt03WUDsu/Lie8XBvWZ5hUuoiBXCpgDO9R/hb/R/Ly1pAw0YT1
         11F1mthfeVZzsXGnRug0zt+44ZCqVnPmUkhUnzNd3vcntdh+nF45qNOBL4seshtqCH9o
         /JEKk2zAX5Y6E2BbSB4Hg1M94rS6AT3kQ9NrjAMw7AxXC+ykyCvQiOawDwqUDxDEuv5X
         0GjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790365235; x=1790970035; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7w0ggNaiJUtaov8Aw9vNOQm+fzqQlGb0OSXJBvfDhk4=;
        b=AEi9bH3oxyHPPEOyHgN0ToCVOd3BT00e2+aaPjnBALdvJ6LcnjOlGx58Elj30y1chA
         55JXz8O/gcMruzEXwzZ/ZKfEI80dfhzRboxchwg7lbJ7XOGmAjABK9onLnD0/oFobmk5
         EYUhnuI5E+USvVi/lYJaKnIqeov5lvgrX4EK4x5xt/6VujvMZskSZmdLoR+Sx417rffc
         TXGK8H6a0F65/8oCcf7EI+dq1ZFDHHtpYClzPRdAKoHuJoxk1gWgNk2XeRcX2SwvxbHp
         g47rS3CaIDMocXdmSWTnwwT+ED5yoIwmPXVLu5XW7ZRzXxhQJXLlVHM+15iXWa2K1VMH
         5Ysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790365235; x=1790970035;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7w0ggNaiJUtaov8Aw9vNOQm+fzqQlGb0OSXJBvfDhk4=;
        b=ZGIxVVo5pluY5EDLduiFfvIf3EQhc9H4LqkN8IHQ6blOsIDyRPmUS9nvkHKjYngoCX
         0hfnnJioRZeQRt6GDgP1uU6elmYANux83SesiJIJErMSSuJzxJ5d/+++Zl9GeSJ7Rzv7
         kYKXVSQjdKxPpeuu38T9SIhEdEPG+DzQjFFMJAvNAcm8jn0o1K1ZkxWUujSu5y6nP90A
         qvrvWvZ8Mr7MDrIEj13GBZC2Tgj+Di1wwKZEXeVO8Va3H3QfWm2nS7+6Ek1jfbIyhjTg
         C9lG+jLlPjliq8q5MOlRGNNymqgHkQrot1YOZfSeD6LhOjGYAXn/wkg9GnJuqUj3kV7U
         slEQ==
X-Forwarded-Encrypted: i=1; AKwUvBw+VuHle7iprR27ZZ/CRgjSxAeFCjDtdojApzmM1UMmoIlYzPwhcpP2SUcAmRWeAtaRBJ4cqaWDd35YbjARduc/@vger.kernel.org
X-Gm-Message-State: AFuF++lozs/1aicn38/CCtZXu8BPhS91hQbaUbKwdq4N183v/ZIFepsE
	kVvM7Xee/FrrI1UguHVlF4wosl21tZO76pqrwUCZbeMgVQ40ooJyjw9QavFxA/VSXv+xX93GBsd
	z8ua/IcS3qqqPEKVIIul0T1OSh4xp1aUGITeCsKx+
X-Gm-Gg: AYBFou2BBEO6bHuVjEx/f+Cvg4hsxA9wC2aD3aPO2rWDqccqFwgvnwfeELAklGrJNqd
	hB+JQHbPsn7n9ncTuGnbmKPyycJDny0IC1lTwDPDCi6KrGD3l1o0etSXOZ15uQi0FZ0AFAErwuQ
	LbH4HsVRVJzeaGCr+M3DsPckypg1UNHbGRRjCDWEKGJ2nKLD/KBYT6T1QcFK/RP5s9k1yry4M3h
	GeBCuRXpYw69p4E5WqFj7kuQL+nzrD/RRXLMIneHiR/Z/zJmHnujIRWXmfcuL1yfbIgAARggfQg
	b2259SEIvhtJu6IGG5s1/YlBSZJCVkSxGYmuA79+5j/2fNj+AS0YMo3ic4FacA/jope09wmIzvu
	Y/XeRMQgWDI95TSLb3dvG
X-Received: by 2002:ac8:5a8e:0:b0:532:8423:1e78 with SMTP id
 d75a77b69052e-53320158245mr2288241cf.10.1790365234077; Fri, 25 Sep 2026
 12:40:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925-perf-symbol-memory-send-v3-0-3e4e234c363b@uber.com> <20260925-perf-symbol-memory-send-v3-3-3e4e234c363b@uber.com>
In-Reply-To: <20260925-perf-symbol-memory-send-v3-3-3e4e234c363b@uber.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Sep 2026 12:40:21 -0700
X-Gm-Features: AclHuK9x629fLWASLEqLzbb_AP5DIooOcwJ0_0bd24zHfXGr_vdmWoYtnhtMltE
Message-ID: <CAP-5=fUumhE1-DT3a-EBYQADy6Az=nViGmz==n1ocqXiXAEQjg@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] perf symbols: Factor out duplicate symbol selection
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

On Fri, Sep 25, 2026 at 12:15=E2=80=AFPM Alireza Haghdoost via B4 Relay
<devnull+haghdoost.uber.com@kernel.org> wrote:
>
> From: Alireza Haghdoost <haghdoost@uber.com>
>
> symbols__fixup_duplicate() chooses between symbols with the same start
> address through choose_best_symbol(), which needs fully constructed
> struct symbol objects. A loader that selects among aliases before
> allocating symbols cannot use it.
>
> Move the policy into symbol__choose_best(), which compares the size,
> name, type and binding of two candidates described by struct
> symbol_candidate, and pass the same description to the
> arch__choose_best_symbol() hook. choose_best_symbol() becomes a wrapper
> that describes two struct symbols. No functional change intended.
>
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
> index 163652f071c6..4b50250d07fa 100644
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

Given you can change this function definition and only change 1 C
file, is there any reason not to make the function static in symbol.c
and move the struct symbol_candidate definition also to symbol.c?

Thanks,
Ian

>
>  enum symbol_tag_include {
>         SYMBOL_TAG_INCLUDE__NONE =3D 0,
>
> --
> Git-157)
>
>
