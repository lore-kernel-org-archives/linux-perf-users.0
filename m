Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D4D3CF66F
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Mar 2026 17:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774372459; cv=pass; b=ffEBx8IWMNB9P6XRxBXNgCfuFuLc97c368zM/h4x01caCKNGM5+Ppzmt9ydniadjrWfyfFwqGhe3N6+7WrTNH8ZfWQwJYRfCDbQpggHy7hcr+RgXIPIPE6rK9/AnN7aFTVkUGalhHu95zTMnaqCf4jKXWow+soJSese21V9cGvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774372459; c=relaxed/simple;
	bh=TPMZ0guEsDu1fBmTTSOoikqO5QOdog97pNpUt2KoWpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SA9EpkpN9EM2RZrEE9rWS28vtc0TgUneXEtLUs/y6oJH1l7svAYLl9IApS8KUPyFdDyn0MUbcQb9G+hADkmvqdmLq7qlchfeJ273Z1d890qsEwnaPhNihcsTsLQ1DA7XnrbhZPAj6TUKG5jHar135LO7qLSB9+PCPQN7/Eq7XCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AIhaGq2n; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AIhaGq2n"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-126ea4e9697so542c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Mar 2026 10:14:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774372457; cv=none;
        d=google.com; s=arc-20240605;
        b=koK0Tc/LtjvdcIk42Y8IvTetZszbVHXHyx0HAzztKm5dlj8bppXYYEeMwRoPtWJQJH
         ybaeGoRa5Cnqn2RdHcYE4O/u0TKKoQd7oLhnmjmBZbZ507sBD06r7+FVc6j1SfJsf0uc
         IkJGYwfY1W4USDRB5OK2SNl6tskvtaPHXmiIKuh8KV8fN+b1iHbKBYUt24cvd4xgAqKu
         yeqpX6mETQQa2Lc+zZhqPTZLHDRXz3EZzPSaNvPHKSp7wriHSFsE0HxctMXQ7I54yXgR
         NvRC2VOcpjcSyeOK3EiXMYG99j52I8majh+2zcKfgyFoQnw4uoTuGFHXmZD3ggNQzh8M
         KBeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y6UGHkZW2dwA/OaJX502PqCak29ZGkb8gxJ7v1DAxKA=;
        fh=4o4vJKE2CDss26Ch8INVOPtgSCPq9HGgUujuRs0NXZc=;
        b=OfLOjlF4yvkLgSnSSJjhBGngHGzGcoITRYpIoq3+PI1CaJKUkt3pMcqUYJUmOMou73
         ltY2mkxp+fHxBV1llPKeskCusZdTCkFJXwgZSehOfvD5d+rTWD3Oj0EHDMgt5i+kMwge
         xOgGC/3w3V3kQhLr32r8nk9BZ/QCyDIaeUOCvS8hgONEc9bBUusoX+J0x6PAAZ3okuqL
         9UqLFX/UoZhIO6HxCZzZhxAdmkUFUhGd4IIS1zFu5gKyKnli7V1PE5ddQtHUp0U/C9rB
         q5fz8wT3ZQuVpzxo/MZsN8F7mm+FBSWzsmXW6OuuWqAt4PpqxT/fKdMsrG1IA0lOhuyg
         nQmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774372457; x=1774977257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6UGHkZW2dwA/OaJX502PqCak29ZGkb8gxJ7v1DAxKA=;
        b=AIhaGq2nd0xG4K1VSbakXExVV7oqzmcCO747U6DuJvF0PIDGgGpY4WguaQh7+hLKcq
         zTXWYTor6zNkB6MiPmFIE1MEEpU08EgEG20myA5CUr6jPGSgx1x3TQZomUjFQc8LD4S/
         z0Niuur7xVDYQ0GdloSTdvWm2zm4DznJAWrNy9v5uUgXQOnxL6d041NF7I8EsthqWn7Y
         xojZTHEvv3v6RkbTpat3Xs+X3xjJGTuNn6fX9mg4JigAV8oXEAjjm+VSoj65tcSmWW+y
         wRHZ1lvHeVHiiHAEfljX51y+MMDK+Or9ej3w4GBa44rU2SMVtkMEs+j3mPcagQfMtiSo
         VwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774372457; x=1774977257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y6UGHkZW2dwA/OaJX502PqCak29ZGkb8gxJ7v1DAxKA=;
        b=Jl8XAfaRmWEtzkHzqSPbCchc92qhZ6JtDl6FgcpOQcyUnMAWPiYB0BsCetPfGKZKDo
         KLc3Kedt4gfBimRInUSL8hnoKdTkq1XDWIemWbw7Kp178uZKS1q+vtppAboup9KcIEx7
         rIzDFqzMnvap/gpQzsK0HtQpHkWK390V6NdUwpGlQfUPB4o4TW0WHRKwRJi1aCN9CLkt
         NyIJm0s3IHu3O0k4za4IaQPKExIlmAaQTV/RWjzeTD2y60y40OsFfQOjNyip8C1fGrE1
         E7sHXkLGOwHdPi+MpuYyJC7V6od4pm2V3wyIhIQzRbTdJu0C76gJOzdzqsvMn38Ct6g1
         Lp3A==
X-Forwarded-Encrypted: i=1; AJvYcCUFxkv0Wxy38C8nrZiu59X+Tu3i/dPpaoTNWtIBl5PxUGETv7UWGp+2dfuIQmeamUORrsjlkjjbFOLhaIIC8VGT@vger.kernel.org
X-Gm-Message-State: AOJu0YyWVAZdSAweGceu55IIOaWBUetLyexrCkoPvkN8b5YCZZ2zQj70
	KT+QyIO9aLYM+o9OOEl9MBo9rNHk/YU0MmmDioU6VrVFaZ3cAl1NTzDnfhz+4IyZ2GHlxX3mDVm
	0EfSphl+rl/Ig5UhNleE7ywcFFxjpyDiHDlNJeaCC
X-Gm-Gg: ATEYQzya684G37JjGAPAHE4sRkfBtMWp7cYGQAmjGdiStVR7ZNKMUHnauaDVNtKsQPh
	5xjQRxPI7A6bQpw0n7gStXIstltb5TzcpCxNVJNQw/kkKTu6EQmmUopiTozFFRJrkH0erg2+t3N
	/UYDQItRIgt7JqcVFOrSHSYkEzb3Z5JrYSbvbr0SEczsizaxGDhpd//0LZ82aE+Gwi8QjuS90ks
	eHhh16tq/mX1fgNjXS4xP+ucxB5Dl8Vf82uIiqomVeFbiyLn9UZZYuM+ryK8GB8uueFc67TPsfT
	xP3I+TYqBtTjGmxRIS9vFf+ikcZu7MM/iydacPrBp0aDC1cz
X-Received: by 2002:a05:7022:322:b0:119:e55a:8087 with SMTP id
 a92af1059eb24-12a9744d747mr7659c88.4.1774372456710; Tue, 24 Mar 2026 10:14:16
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219113850.354271-1-tmricht@linux.ibm.com> <20260302234343.564937-1-irogers@google.com>
In-Reply-To: <20260302234343.564937-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 24 Mar 2026 10:14:01 -0700
X-Gm-Features: AQROBzDcW54RPb4VzSi-SKKYsdcX2A1amDUpzQmAXOKavUNK1r1w-Rf11LVK0Nw
Message-ID: <CAP-5=fW0Bu2313nAuhur+wP5Y2JtBNY+wpPoiKLqNzcSe-R3gA@mail.gmail.com>
Subject: Re: [PATCH v1] perf symbol: Lazily compute idle and use the perf_env
To: tmricht@linux.ibm.com, namhyung@kernel.org, acme@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 3:43=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> Move the idle boolean to a helper symbol__is_idle function. In the
> function lazily compute whether a symbol is an idle function taking
> into consideration the kernel version and architecture of the
> machine. As symbols__insert no longer needs to know if a symbol is for
> the kernel, remove the argument.
>
> This change is inspired by mailing list discussion, particularly from
> Thomas Richter <tmricht@linux.ibm.com> and Heiko Carstens
> <hca@linux.ibm.com>:
> https://lore.kernel.org/lkml/20260219113850.354271-1-tmricht@linux.ibm.co=
m/
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian

> ---
>  tools/perf/builtin-top.c     |   6 +-
>  tools/perf/util/symbol-elf.c |   2 +-
>  tools/perf/util/symbol.c     | 106 ++++++++++++++++++++++-------------
>  tools/perf/util/symbol.h     |  15 +++--
>  4 files changed, 85 insertions(+), 44 deletions(-)
>
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 710604c4f6f6..bc3c8e3b6ec0 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -750,6 +750,7 @@ static void perf_event__process_sample(const struct p=
erf_tool *tool,
>  {
>         struct perf_top *top =3D container_of(tool, struct perf_top, tool=
);
>         struct addr_location al;
> +       struct dso *dso =3D NULL;
>
>         if (!machine && perf_guest) {
>                 static struct intlist *seen;
> @@ -829,7 +830,10 @@ static void perf_event__process_sample(const struct =
perf_tool *tool,
>                 }
>         }
>
> -       if (al.sym =3D=3D NULL || !al.sym->idle) {
> +       if (al.map)
> +               dso =3D map__dso(al.map);
> +
> +       if (al.sym =3D=3D NULL || !symbol__is_idle(al.sym, dso, machine->=
env)) {
>                 struct hists *hists =3D evsel__hists(evsel);
>                 struct hist_entry_iter iter =3D {
>                         .evsel          =3D evsel,
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 76912c62b6a0..6bb46384aa0c 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -1725,7 +1725,7 @@ dso__load_sym_internal(struct dso *dso, struct map =
*map, struct symsrc *syms_ss,
>
>                 arch__sym_update(f, &sym);
>
> -               __symbols__insert(dso__symbols(curr_dso), f, dso__kernel(=
dso));
> +               __symbols__insert(dso__symbols(curr_dso), f);
>                 nr++;
>         }
>         dso__put(curr_dso);
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 8662001e1e25..6155f509ca70 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -25,6 +25,8 @@
>  #include "demangle-ocaml.h"
>  #include "demangle-rust-v0.h"
>  #include "dso.h"
> +#include "dwarf-regs.h"
> +#include "env.h"
>  #include "util.h" // lsdir()
>  #include "debug.h"
>  #include "event.h"
> @@ -51,7 +53,6 @@
>
>  static int dso__load_kernel_sym(struct dso *dso, struct map *map);
>  static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map);
> -static bool symbol__is_idle(const char *name);
>
>  int vmlinux_path__nr_entries;
>  char **vmlinux_path;
> @@ -357,8 +358,7 @@ void symbols__delete(struct rb_root_cached *symbols)
>         }
>  }
>
> -void __symbols__insert(struct rb_root_cached *symbols,
> -                      struct symbol *sym, bool kernel)
> +void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sy=
m)
>  {
>         struct rb_node **p =3D &symbols->rb_root.rb_node;
>         struct rb_node *parent =3D NULL;
> @@ -366,17 +366,6 @@ void __symbols__insert(struct rb_root_cached *symbol=
s,
>         struct symbol *s;
>         bool leftmost =3D true;
>
> -       if (kernel) {
> -               const char *name =3D sym->name;
> -               /*
> -                * ppc64 uses function descriptors and appends a '.' to t=
he
> -                * start of every instruction address. Remove it.
> -                */
> -               if (name[0] =3D=3D '.')
> -                       name++;
> -               sym->idle =3D symbol__is_idle(name);
> -       }
> -
>         while (*p !=3D NULL) {
>                 parent =3D *p;
>                 s =3D rb_entry(parent, struct symbol, rb_node);
> @@ -393,7 +382,7 @@ void __symbols__insert(struct rb_root_cached *symbols=
,
>
>  void symbols__insert(struct rb_root_cached *symbols, struct symbol *sym)
>  {
> -       __symbols__insert(symbols, sym, false);
> +       __symbols__insert(symbols, sym);
>  }
>
>  static struct symbol *symbols__find(struct rb_root_cached *symbols, u64 =
ip)
> @@ -554,7 +543,7 @@ void dso__reset_find_symbol_cache(struct dso *dso)
>
>  void dso__insert_symbol(struct dso *dso, struct symbol *sym)
>  {
> -       __symbols__insert(dso__symbols(dso), sym, dso__kernel(dso));
> +       __symbols__insert(dso__symbols(dso), sym);
>
>         /* update the symbol cache if necessary */
>         if (dso__last_find_result_addr(dso) >=3D sym->start &&
> @@ -716,47 +705,88 @@ int modules__parse(const char *filename, void *arg,
>         return err;
>  }
>
> +static int sym_name_cmp(const void *a, const void *b)
> +{
> +       const char *name =3D a;
> +       const char *const *sym =3D b;
> +
> +       return strcmp(name, *sym);
> +}
> +
>  /*
>   * These are symbols in the kernel image, so make sure that
>   * sym is from a kernel DSO.
>   */
> -static bool symbol__is_idle(const char *name)
> +bool symbol__is_idle(struct symbol *sym, const struct dso *dso, const st=
ruct perf_env *env)
>  {
> -       const char * const idle_symbols[] =3D {
> +       static const char * const idle_symbols[] =3D {
>                 "acpi_idle_do_entry",
>                 "acpi_processor_ffh_cstate_enter",
>                 "arch_cpu_idle",
>                 "cpu_idle",
>                 "cpu_startup_entry",
> -               "idle_cpu",
> -               "intel_idle",
> -               "intel_idle_ibrs",
>                 "default_idle",
> -               "native_safe_halt",
>                 "enter_idle",
>                 "exit_idle",
> -               "mwait_idle",
> -               "mwait_idle_with_hints",
> -               "mwait_idle_with_hints.constprop.0",
> +               "idle_cpu",
> +               "native_safe_halt",
>                 "poll_idle",
> -               "ppc64_runlatch_off",
>                 "pseries_dedicated_idle_sleep",
> -               "psw_idle",
> -               "psw_idle_exit",
> -               NULL
>         };
> -       int i;
> -       static struct strlist *idle_symbols_list;
> +       const char *name =3D sym->name;
> +       uint16_t e_machine =3D env ? env->e_machine : EM_HOST;
> +
> +       if (sym->idle)
> +               return sym->idle =3D=3D SYMBOL_IDLE__IDLE;
> +
> +       if (!dso || dso__kernel(dso) =3D=3D DSO_SPACE__USER) {
> +               sym->idle =3D SYMBOL_IDLE__NOT_IDLE;
> +               return false;
> +       }
>
> -       if (idle_symbols_list)
> -               return strlist__has_entry(idle_symbols_list, name);
> +       /*
> +        * ppc64 uses function descriptors and appends a '.' to the
> +        * start of every instruction address. Remove it.
> +        */
> +       if (name[0] =3D=3D '.')
> +               name++;
> +
> +
> +       if (bsearch(name, idle_symbols, ARRAY_SIZE(idle_symbols),
> +                   sizeof(idle_symbols[0]), sym_name_cmp)) {
> +               sym->idle =3D SYMBOL_IDLE__IDLE;
> +               return true;
> +       }
> +
> +       if (e_machine =3D=3D EM_386 || e_machine =3D=3D EM_X86_64) {
> +               if (strstarts(name, "mwait_idle") ||
> +                   strstarts(name, "intel_idle")) {
> +                       sym->idle =3D SYMBOL_IDLE__IDLE;
> +                       return true;
> +               }
> +       }
> +
> +       if (e_machine =3D=3D EM_PPC64 &&!strcmp(name, "ppc64_runlatch_off=
")) {
> +               sym->idle =3D SYMBOL_IDLE__IDLE;
> +               return true;
> +       }
>
> -       idle_symbols_list =3D strlist__new(NULL, NULL);
> +       if (e_machine =3D=3D EM_S390) {
> +               int major =3D 0, minor =3D 0;
> +               const char *release =3D env && env->os_release
> +                       ? env->os_release : perf_version_string;
>
> -       for (i =3D 0; idle_symbols[i]; i++)
> -               strlist__add(idle_symbols_list, idle_symbols[i]);
> +               sscanf(release, "%d.%d", &major, &minor);
>
> -       return strlist__has_entry(idle_symbols_list, name);
> +               /* Before v6.10, s390 used psw_idle. */
> +               if ((major < 6 || (major =3D=3D 6 && minor < 10)) && strs=
tarts(name, "psw_idle")) {
> +                       sym->idle =3D SYMBOL_IDLE__IDLE;
> +                       return true;
> +               }
> +       }
> +
> +       sym->idle =3D SYMBOL_IDLE__NOT_IDLE;
> +       return false;
>  }
>
>  static int map__process_kallsym_symbol(void *arg, const char *name,
> @@ -785,7 +815,7 @@ static int map__process_kallsym_symbol(void *arg, con=
st char *name,
>          * We will pass the symbols to the filter later, in
>          * map__split_kallsyms, when we have split the maps per module
>          */
> -       __symbols__insert(root, sym, !strchr(name, '['));
> +       __symbols__insert(root, sym);
>
>         return 0;
>  }
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index 3fb5d146d9b1..508dd9f336e9 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -24,6 +24,7 @@ struct dso;
>  struct map;
>  struct maps;
>  struct option;
> +struct perf_env;
>  struct build_id;
>
>  /*
> @@ -41,6 +42,12 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
>                              GElf_Shdr *shp, const char *name, size_t *id=
x);
>  #endif
>
> +enum symbol_idle_kind {
> +       SYMBOL_IDLE__UNKNOWN =3D 0,
> +       SYMBOL_IDLE__NOT_IDLE =3D 1,
> +       SYMBOL_IDLE__IDLE =3D 2,
> +};
> +
>  /**
>   * A symtab entry. When allocated this may be preceded by an annotation =
(see
>   * symbol__annotation) and/or a browser_index (see symbol__browser_index=
).
> @@ -56,8 +63,8 @@ struct symbol {
>         u8              type:4;
>         /** ELF binding type as defined for st_info. E.g. STB_WEAK or STB=
_GLOBAL. */
>         u8              binding:4;
> -       /** Set true for kernel symbols of idle routines. */
> -       u8              idle:1;
> +       /** Cache for symbol__is_idle. */
> +       enum symbol_idle_kind idle:2;
>         /** Resolvable but tools ignore it (e.g. idle routines). */
>         u8              ignore:1;
>         /** Symbol for an inlined function. */
> @@ -184,8 +191,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, stru=
ct symsrc *ss);
>
>  char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_na=
me);
>
> -void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sy=
m,
> -                      bool kernel);
> +void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sy=
m);
>  void symbols__insert(struct rb_root_cached *symbols, struct symbol *sym)=
;
>  void symbols__fixup_duplicate(struct rb_root_cached *symbols);
>  void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsyms=
);
> @@ -269,5 +275,6 @@ enum {
>  };
>
>  int symbol__validate_sym_arguments(void);
> +bool symbol__is_idle(struct symbol *sym, const struct dso *dso, const st=
ruct perf_env *env);
>
>  #endif /* __PERF_SYMBOL */
> --
> 2.53.0.473.g4a7958ca14-goog
>
