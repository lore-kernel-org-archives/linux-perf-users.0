Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EFC4BB5C2
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349677; cv=pass; b=Koju/PhSGWMpx1l5rWO+jBO6LVzfVsGcC2EYuw+34VgtZ7SFxDTVXupFlr2t+lMdPlLhd7MpBZC5KNGU42a0Yy/YftFCuSlHqRfR6kpZ5Hje0VmiC+88f9b1Q78AzoDwHxQg2ErKfnydiHVB30ZoyeYu78aDZm/XqMIqQQXb7Zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349677; c=relaxed/simple;
	bh=BhdfBEozeGSRDvYgw6he9SoGVdQ8qrm+juGnR4QiXlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ss00aPZ9fX/FAchqRdV59RHDT0n7PNmztgD4pybA/9mqMYO3W6HREjXHDIFMASsuZEcgDlEiE7nBh2lYqLfd8dqJPpw5BMH24FQT0Dd51IqbzjX7zQalfsmeeyPL4qCvnw+z39DvU3bpoPECquWSA1UPiqjKQNcShVwHz+Y84AM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z32yI5W8; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z32yI5W8"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-530e8c6fb80so258071cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 08:21:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790349673; cv=none;
        d=google.com; s=arc-20260327;
        b=A9dC1zgkbmEYv/QNHZR7h4DO3BJkzsxEntM6DnZVonN3Tfc1TAorkfLQdyurpRz+41
         4JYiNLfyzz4YWqkMxv97+Fpw63iqqAdpuDNSkCaiAdQd5VQp4mHL/KF/txDDYtvEjxal
         f0QaAxj68jpQo2SyLNyyatv1z1qZxg9kZn5+lCs3KvCuUf87KmtJZl/GCXJprRkQmwEd
         O/1EsK+Awoo7cQfcc3b6WBR+CtIILqsjXAETNiureMM08MzRUe5Uh/GIqdDXShnwH4GA
         hnvQ9iMgG4327PhlJcEEhqiMoHN/gpMtQAKjYB5eFu0AoFDnqddLABWTjzQIhYddIbSM
         6GPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4AQvNYQWEmUAL1IVpAcXwqEvB4Tc2M/RExqLeJl04xg=;
        fh=+v7wgc5DYU+PG4EgoNaONLoZLPJrScJd42gQIE/3tMI=;
        b=C/PBMO/o1VvVmgVfwz47I/hUeTGJixpRggBvX/oYxEBlLN6xajqe6P504JBp6m/NkE
         WSRgePYvzonLK5h0BiBfbjMXPCodwREJ3tqptcZ5PP4CUBwXkQkY3ng1Do6/IvR7VkKe
         oZOYYLZN1uHvafYDy/8aLUP1ny3hJBcO2xndvyetf22FssasCEjIU7q60b/e/bOPhQg9
         iwhHYTKyUYe2dgLs9oGmrgmmWMHzhQi0JtWLzDhCgHe5OV1qxHeGkGBNh25AIdv6otoe
         slFCuFNVFd9CCru5hko45J4lJOpCfhE4ps/uCgUgKN0yzIV+w3dRUjeJFkrilkiMzJFU
         vnTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790349673; x=1790954473; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4AQvNYQWEmUAL1IVpAcXwqEvB4Tc2M/RExqLeJl04xg=;
        b=Z32yI5W8fOKgE+FTr6Sv/N8y/ncMFKzwI/G0LPR+EZOuucib6gp45Q+WIB2akwiYPL
         2bf4n2RBmXvI7R4Y9I+CVKl6UpHyvCob9451qWj2oxx7+Vj/BHIEcGz7nKsTJUCXb1ux
         HXQV7nk7zaHC2XoHKtPKvTxYCLI3Wxi24YVcv5j50LpIh2KDWaxJSQx/PmwqRnExx/Wi
         iO1yiOB7LX1b0pC38QKbJuPLpWixfsYxfx/foy3LTvh53i5zsImmKqzSitGSdIly6Npp
         LvGYB5c/aIEYwO1P/E5q9T13AnoHMVYrZFoUYUDjO24iwHsIN2LOuhalyLyiW2PSb6mn
         TwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790349673; x=1790954473;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4AQvNYQWEmUAL1IVpAcXwqEvB4Tc2M/RExqLeJl04xg=;
        b=y2x4XmPcthXDwa0nVohbym0SVBcLjpUibMaBOzJ9blOmX3VrqIaVzwJvuARdheJa+/
         vOYEtcntJWQHu/8CAwVQ17eONbz/haljRP1wkKYKgpxYAfUvnvWOOjcv192VUFO42GfL
         MfFeWrMoBjPyEgcAhNRUR0Tp+7N3y5+sVin+4ZaDI0sTGD7YUTT252/LGpfobl6/ZIj3
         rZHqKe0C75YwWagRdfqsZlD5ANMk74fLUaJ+2hfomoT4GUEMuOjmkamecevoeUZTkUBX
         PnyI6Wh5Tn6CIwGHgg3eAsvvB2sZ02iYNO8Q9fGX/tohwS7VYCizuePZlz+pU6hkNsJx
         0yog==
X-Forwarded-Encrypted: i=1; AKwUvBxjhY9diPomudwTJ1ZLl9TEJ+S66dPXnqySyuAq301DO/CxOhD5p5HNaOrBSaQ379TvAtbAwilBQztt5b1uRjJN@vger.kernel.org
X-Gm-Message-State: AFuF++mm1LFIXpNpO7Tohki7F9LOwHwbVYWRbmXtOw+h2n5DgOvCWdN3
	h9BKnjdvD3D78FXkJJZ8yFm6vvjgu5D2bf/VzI66jrUNLZNPfOys7XtqY/TIlnZJnEQWAxoVKaw
	kv2VVKUr5uL9LV+bp2O+mn8eEMqlKBNEfvClTFLhE
X-Gm-Gg: AYBFou0yVTcbjony+9hXBg+s2Vjq240E6+UIF2JzYsWXYzJU8hatHqcq0xq6ctoo9bQ
	wfKeCVSsr3uDHrCrVP4m+HJRIoLFnCjGmYuWOmbNtM22S+dF7EFNoCy52/3u9CZ4ioPPi4t4t9D
	rpkyJGCpmfiVgre5PfBOWnRAMs5fctJIX2bVGVGS92amM4cDE4fcNeASb82/NPDQz98hHYmPiBJ
	90UghsnHYWkqpn6yWkWGBkQNOARj9I60tqGE7AT6U9iO7RlJceNxgKmFDtJ8J1ko3u++H1enHMj
	APm8gUrVqoef61nzYKbz03uDGbIEbov+zEJL+z2eAube0k+gF8ngEUvYhO+xXdRxHLKDFAHPD7D
	cV5mWeYHh/9PCedTpIWiU
X-Received: by 2002:a05:622a:260a:b0:532:d36c:7094 with SMTP id
 d75a77b69052e-5331a7a38e0mr3882811cf.4.1790349669311; Fri, 25 Sep 2026
 08:21:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925150657.1826942-1-acme@kernel.org> <20260925150657.1826942-3-acme@kernel.org>
In-Reply-To: <20260925150657.1826942-3-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Sep 2026 08:20:58 -0700
X-Gm-Features: AclHuK9iV1la3sMHmQ0H9rX55LlJK38t52cDodEsYfAtl_J8x0nPn4SCUw_CZJE
Message-ID: <CAP-5=fU=Bp9x32W5Xo+Qa6vvC0OR0u9FAc0A4Y=rKV=kytcjsA@mail.gmail.com>
Subject: Re: [PATCH 2/6] perf dwarf-aux: Add die_same_file() and die_get_type_die()
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
> dwarf_dieoffset() is relative to the file the DIE is in, so an offset
> saved by die_collect_vars()/die_collect_global_vars() is only
> meaningful in that file: add die_same_file(), comparing the Dwarf each
> DIE's CU belongs to, and die_get_type_die(), resolving the offset in it
> with the saved tag as a sanity check.  Resolving the offset in the main
> file instead parses whatever is at it when it came from the dwz common
> file.
>
> dwarf_cu_getdwarf() is new in elfutils 0.160, so the libdw feature test
> probes for it and Makefile.config says 0.160.
>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/build/feature/test-libdw.c | 10 +++++-
>  tools/perf/Makefile.config       |  2 +-
>  tools/perf/util/dwarf-aux.c      | 56 ++++++++++++++++++++++++++++++--
>  tools/perf/util/dwarf-aux.h      | 13 ++++++++
>  4 files changed, 77 insertions(+), 4 deletions(-)
>
> diff --git a/tools/build/feature/test-libdw.c b/tools/build/feature/test-=
libdw.c
> index aabd63ca76b4d7e6..46f75cde59471079 100644
> --- a/tools/build/feature/test-libdw.c
> +++ b/tools/build/feature/test-libdw.c
> @@ -49,8 +49,16 @@ int test_elfutils(void)
>         return 0;
>  }
>
> +/* Needs elfutils 0.160: taking its address fails the probe, not the lin=
k. */
> +int test_libdw_cu_getdwarf(void)
> +{
> +       void *sym =3D (void *)dwarf_cu_getdwarf;
> +
> +       return sym =3D=3D NULL;
> +}
> +
>  int main(void)
>  {
>         return test_libdw() + test_libdw_unwind() + test_libdw_getlocatio=
ns() +
> -              test_libdw_getcfi() + test_elfutils();
> +              test_libdw_getcfi() + test_libdw_cu_getdwarf() + test_elfu=
tils();
>  }
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index dca62e155fb5570a..b288ae0191acf7ef 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -477,7 +477,7 @@ else
>    else
>      ifneq ($(feature-libdw), 1)
>        ifndef NO_LIBDW
> -        $(warning No libdw.h found or old libdw.h found or elfutils is o=
lder than 0.157, disables dwarf support. Please install new elfutils-devel/=
libdw-dev)
> +        $(warning No libdw.h found or old libdw.h found or elfutils is o=
lder than 0.160, disables dwarf support. Please install new elfutils-devel/=
libdw-dev)
>          NO_LIBDW :=3D 1
>        endif
>      endif # Dwarf support
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 2c135ebb1551fca4..54f8b5ec74a2fe70 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -1677,6 +1677,15 @@ Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc=
_die, Dwarf_Addr addr,
>         return result;
>  }
>
> +/*
> + * Whether two DIEs live in the same debug file: dwarf_dieoffset() is
> + * relative to the file the DIE is in.
> + */
> +bool die_same_file(Dwarf_Die *die_a, Dwarf_Die *die_b)
> +{
> +       return dwarf_cu_getdwarf(die_a->cu) =3D=3D dwarf_cu_getdwarf(die_=
b->cu);
> +}
> +
>  static int __die_collect_vars_cb(Dwarf_Die *die_mem, void *arg)
>  {
>         struct die_var_type **var_types =3D arg;
> @@ -1721,6 +1730,8 @@ static int __die_collect_vars_cb(Dwarf_Die *die_mem=
, void *arg)
>                         vt->is_reg_var_addr =3D true;
>
>                 vt->die_off =3D dwarf_dieoffset(&type_die);
> +               vt->die_tag =3D dwarf_tag(&type_die);
> +               vt->from_alt =3D !die_same_file(die_mem, &type_die);
>                 vt->addr =3D start;
>                 vt->end =3D end;
>                 vt->has_range =3D (end !=3D 0 || start !=3D 0);
> @@ -1740,7 +1751,8 @@ static int __die_collect_vars_cb(Dwarf_Die *die_mem=
, void *arg)
>   *
>   * Save all variables and parameters in the @sc_die and save them to @va=
r_types.
>   * The @var_types is a singly-linked list containing type and location i=
nfo.
> - * Actual type can be retrieved using dwarf_offdie() with 'die_off' late=
r.
> + * Actual type can be retrieved using die_get_type_die() with 'die_off',
> + * 'die_tag' and 'from_alt' later.
>   *
>   * Callers should free @var_types.
>   */
> @@ -1786,6 +1798,8 @@ static int __die_collect_global_vars_cb(Dwarf_Die *=
die_mem, void *arg)
>                 return DIE_FIND_CB_END;
>
>         vt->die_off =3D dwarf_dieoffset(&type_die);
> +       vt->die_tag =3D dwarf_tag(&type_die);
> +       vt->from_alt =3D !die_same_file(die_mem, &type_die);
>         vt->addr =3D ops->number;
>         vt->end =3D 0;
>         vt->has_range =3D false;
> @@ -1797,6 +1811,43 @@ static int __die_collect_global_vars_cb(Dwarf_Die =
*die_mem, void *arg)
>         return DIE_FIND_CB_SIBLING;
>  }
>
> +/**
> + * die_get_type_die - Get a type DIE saved by die_collect_vars()
> + * @dbg: the main debug info
> + * @die_off: offset of the type DIE, from dwarf_dieoffset()
> + * @die_tag: tag that DIE had when the offset was saved
> + * @from_alt: whether the type DIE is in the dwz alt file
> + * @die_mem: where to store the resulting DIE
> + *
> + * Resolve @die_off in the file it was recorded as belonging to, with no
> + * fallback; @die_tag is a sanity check.
> + */
> +Dwarf_Die *die_get_type_die(Dwarf *dbg, u64 die_off, int die_tag, bool f=
rom_alt,
> +                           Dwarf_Die *die_mem)
> +{
> +       Dwarf *target =3D dbg;
> +       Dwarf_Die die;
> +
> +       if (from_alt) {
> +               /* No fallback: an alt offset here parses whatever is at =
it. */
> +               target =3D dwarf_getalt(dbg);
> +               if (target =3D=3D NULL) {
> +                       pr_debug("DWARF: no alt (dwz) debug file to resol=
ve the type DIE at offset 0x%lx in\n",
> +                                (unsigned long)die_off);
> +                       return NULL;
> +               }
> +       }
> +
> +       if (dwarf_offdie(target, die_off, &die) && dwarf_tag(&die) =3D=3D=
 die_tag) {
> +               *die_mem =3D die;
> +               return die_mem;
> +       }
> +
> +       pr_debug("DWARF: no DIE with tag %d at offset 0x%lx in the %s deb=
ug file\n",
> +                die_tag, (unsigned long)die_off, from_alt ? "alt" : "mai=
n");
> +       return NULL;
> +}
> +
>  /**
>   * die_collect_global_vars - Save all global variables
>   * @cu_die: a CU DIE
> @@ -1804,7 +1855,8 @@ static int __die_collect_global_vars_cb(Dwarf_Die *=
die_mem, void *arg)
>   *
>   * Save all global variables in the @cu_die and save them to @var_types.
>   * The @var_types is a singly-linked list containing type and location i=
nfo.
> - * Actual type can be retrieved using dwarf_offdie() with 'die_off' late=
r.
> + * Actual type can be retrieved using die_get_type_die() with 'die_off',
> + * 'die_tag' and 'from_alt' later.
>   *
>   * Callers should free @var_types.
>   */
> diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
> index 9b662db710220522..6f9145510adcb841 100644
> --- a/tools/perf/util/dwarf-aux.h
> +++ b/tools/perf/util/dwarf-aux.h
> @@ -152,6 +152,8 @@ int die_get_scopes(Dwarf_Die *cu_die, Dwarf_Addr pc, =
Dwarf_Die **scopes);
>  struct die_var_type {
>         struct die_var_type *next;
>         u64 die_off;
> +       int die_tag;
> +       bool from_alt;  /* die_off is relative to the alt (dwz) file */
>         u64 addr;
>         u64 end;        /* end address of location range */
>         int reg;
> @@ -183,6 +185,17 @@ Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_d=
ie, Dwarf_Addr addr,
>  /* Save all variables and parameters in this scope */
>  void die_collect_vars(Dwarf_Die *sc_die, struct die_var_type **var_types=
);
>
> +/*
> + * Get the type DIE saved by die_collect_vars()/die_collect_global_vars(=
):
> + * @from_alt says which file the offset must be resolved in, @die_tag is
> + * a sanity check.
> + */
> +Dwarf_Die *die_get_type_die(Dwarf *dbg, u64 die_off, int die_tag, bool f=
rom_alt,
> +                           Dwarf_Die *die_mem);
> +
> +/* Whether two DIEs live in the same debug file */
> +bool die_same_file(Dwarf_Die *die_a, Dwarf_Die *die_b);
> +
>  /* Save all global variables in this CU */
>  void die_collect_global_vars(Dwarf_Die *cu_die, struct die_var_type **va=
r_types);
>
> --
> 2.53.0
>
