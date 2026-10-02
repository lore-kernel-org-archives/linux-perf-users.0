Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3994144BC82
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 22:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790980757; cv=pass; b=KfsTFfOYovlZiiGQv3l8jsyrgDGpv8rvk7Tc5A1fnHkUu+VKgR7eIgTDoDvLRAq8mipzedGCbNJWjaeo/kC3b8V1yq5vjjEnzSJRewBIbi+4IQS/9xLBG0PN+B0WYD8ORcrPxbFgNUuDgE0j/rTvrg7+ETb9K3exPfFYtcRlpyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790980757; c=relaxed/simple;
	bh=azaOmAb1j90tGrRx3zytX57UjJ7OsGmCgdfaY7YaGOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bnKXQBHU4ozACdGRvgKLJAELk5iiUbTD6tiYO+UTs4Sm7Pelmh8BI63A4Myl6rN8AyXO1lmxb9S7lb6Yrm3ou22IIv2BtU9NNWV2m/fW/b9ZDkHLgJ9C/xCLe96aSwRB2aVIKb8GsMy6ej5IoPjJl0G0z6UpN3lyYeVyr/z7FB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UH6mY7h4; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UH6mY7h4"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5337c7b9937so89281cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 15:39:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790980753; cv=none;
        d=google.com; s=arc-20260327;
        b=SWCBM9xB+1IPr77A+wDbHw4NA3somlbMSiQVZRBpZoX3q9mQxCEG71JX8yYnZFxsgY
         K4McUhS++bUJ/AFUYq/Ru79VvZn4o2iG/J3XadrDMLfl+MztbF3B5MAsXnz4WG6oARyd
         4xa8E2LSCheCM4ljlpadK9Rv8oAvv8aJIo1q2iR2attda+XR1lsIX2QjfrSTt65pzYWl
         PdKjO4K52ztJFqBEm4g4UwuXKSlzSt5EDcRUCuGfjAo+FYug74Igfl6cTwovyhn3nXDW
         C1pFcsteFkvhFO0HxK5hriGmFnhmZcTgCCT4Ib/tLJHLRN4WAcpKC6Rdq6nZUPrGnOrc
         odBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8syuwuhZDedeYPPLGnq4FGByMTaWzEVyUkjLSouSWos=;
        fh=3wC+nvILAN8bO8E2+C8EMsp1i3mCLxAWQLgaNOiBSMw=;
        b=Xbooe3NRKTtGOniNxKBSiJSNfuIWDwtJuebMC/tnPuzCWvtch5k+Dn2EVBi+IJ+IPq
         bPNJN3xSRNaJMhryqXzb8RLfnVpWm5DQgDo7t/E4mXBxFUUo83UYm4neGoAE15fsKNcz
         OeiavP/Zvk76aTT9oVjRBaxitkFIt1A6bXUdr35Prwg8PcWZsc+70OOAN61RMN/ttmvP
         RzH/9jHr5sqjE6hGO4e4ZwwuzfAXGWPwXmPF+ajyfMDgOLOvWfJwgeWOJN1WO+zbilbi
         reE90vRuBL6LLzNFZqjjRBHc3WHb4bDzTv0rYmmShdQKUtB7OSBOfZnj4qLGR1P5TJ72
         VjpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790980753; x=1791585553; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8syuwuhZDedeYPPLGnq4FGByMTaWzEVyUkjLSouSWos=;
        b=UH6mY7h4avGFWXPlC3YMeT1i1tzayIhor1pfFe4Uyk5fpxtgARPnUxUC+8XFEbcIyF
         H5tTMOV4Wub7Esce3TrbwhmcRJuGuZPqFN5tT2INSQJpvj+LP/Pvsru9HHm5a/ZY9Hyn
         Z8uVl8S6NOdoAFzr1oOWQ90omZFRD0JHJBn5e9OF+VDNo43eGBM4yeOrbtBGnYf6Gl4L
         5SOUEA10avkidI/OtiBtVrFWHJboBpmUb+ilhWoHaZnEX5dH8JFUjFdDtckiNEyI+jSN
         XWbYV/ifYImev1x1QKCl48sokIADhkEfx7lS/23d6ZSN4issBGFpIaSaK0jypJ6/FDFH
         iV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790980753; x=1791585553;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8syuwuhZDedeYPPLGnq4FGByMTaWzEVyUkjLSouSWos=;
        b=ExI9f5OKzrZBGQkvlVFQkNo50scjI3OJmeCYTicw4/JVYQWVxC5s5JAD68iH1GDAd7
         x/+JtP0JTaVgpUvvqVpmfNuxENuFwQlnogbuepU7uqy8mEDM/LNyK6XNT9uliBvjKxrN
         X78G9JZmgh8mYyYsHrAT3d9Q6FoVLBvf8gHsNw/S1wFJauS+/GulxgImDXzTB7R3WGk4
         L1QibBzNJagepbyM6/Lq3JQFWIhNq+WTkrGavk3RioMuAToPH07a6HF3A7WCGRBzgI10
         8HqioUR5GOHi+RQYXweLJ4v+uBhtbcuMQTHzXFcECCDUer4V5Cfb+JQmApHNZOkCsskU
         mpgg==
X-Forwarded-Encrypted: i=1; AKwUvBy3+CFUN+j8twwSYJfzhPlL8ylSq5PFgXhPxbT9v1SINDX71sviId72YVoFdiL2Jok7/lGAoAvp+y0tX9D+N3dS@vger.kernel.org
X-Gm-Message-State: AFuF++m1fHeLZbnxfRHzIJYoK3BsEvVQOIn8CBNtgKkINWBmblFdKLvv
	lUwCfLal6ngKCecDGjzBM0AktwXTI1v+0R76kl/8Sa8xn2NnxcuCZKpZi5+eQnXuOZckETBZWQ8
	RWaFrO0W8Q291p61yo3YhMow8NgsEYZ+Y9o+V7Ajg
X-Gm-Gg: AYBFou2VXaILq7IU6bgZtV+D+xbO79WaI1YPUldnvHJoMZYh2JgFj7MlVdjgcVYZHVA
	5USc+NmMKf1DQ1iIHOyyI+yWzbHnQZvDf1ud/X5jjIIIJXRQ3D9nfg8OQVBUUCWdyoXoaW1AGjc
	7333B647BWonC3FfqEY6farM5POE76VYfEBBLUviPwyH9qNV0oM2Cz8H4WDxGZBI935VAirkqXL
	mwz+7P+Ax84G8VqFxbcY608GZRWf7jc7PrGchD0I3pTRTImgCctlMFZWzJFAV92lZpHRO0cGMoU
	/FcBgO0mcBkhrGLfWZ6pHHWPXQ4z/06OgdQjZVD9LPxnR3wjz8mC1F5m
X-Received: by 2002:ac8:5c88:0:b0:50f:af60:3496 with SMTP id
 d75a77b69052e-535146449a7mr1090731cf.1.1790980751974; Fri, 02 Oct 2026
 15:39:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002-perf-symbol-memory-send-v4-0-0a592bb2539e@uber.com> <20261002-perf-symbol-memory-send-v4-4-0a592bb2539e@uber.com>
In-Reply-To: <20261002-perf-symbol-memory-send-v4-4-0a592bb2539e@uber.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 2 Oct 2026 15:39:00 -0700
X-Gm-Features: AclHuK9V5DParUP_3EGe5FP4d_ITp42UFE8oRpPrVTJIalNfyn0Cl13mZbVvy1k
Message-ID: <CAP-5=fUMvUU=kGkGej4FSTYAMjO_ygZ5uQ4pdb+5NwivdjMwkA@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] perf script: Add --lazy-load-symbols for lazy
 symbol loading
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
> perf script eagerly materializes eligible symbols from every DSO
> encountered in samples and keeps them in an rb-tree until exit.
> Most of those symbols are never sampled. On a large profile this
> turns symbol loading into the main memory cost of perf script, and in a
> memory-constrained cgroup into an OOM kill.
>
> This patch adds --lazy-load-symbols for userspace ELF DSOs. It builds a
> compact address-sorted index and materializes ordinary struct symbols on
> demand. Names are read and demangled from the exact ELF source through
> the existing DSO data cache; resolved symbols are then inserted into the
> DSO's existing rb-tree.
>
> struct symbol is unchanged. Each index entry holds only the address range=
,
> binding, type and the ELF string-table offset of the name. When a sample
> hits an entry, perf reads and demangles the name and creates a normal
> struct symbol with the name embedded, so code outside the loader never
> sees an unresolved name.
>
> On a 120-second cgroup profile of a production database service (54k
> samples across 11 DSOs), lazy mode reduces peak RssAnon from 314 MiB to
> 80 MiB and wall time from 4.49 to 3.75 seconds, with identical output.
> Memory optimizations usually cost time; this one does not because lazy
> loading skips many unnecessary calloc() calls and demangling operations.
>
> Lazy loading is most effective when samples reference only a small
> fraction of the available symbols, such as profiles spanning many large
> DSOs. It still builds an index proportional to the total symbol count.
> Eager loading remains available for dense symbol coverage or cases
> requiring its broader ELF and architecture support.
>
> This does not claim full parity with the eager loader. Lazy loading
> supports the common userspace ELF symtab/dynsym case; .gnu_debugdata and
> PPC64 .opd continue through the eager loader.
>
> To match eager loading, perf first completes zero-sized symbol ranges
> and selects among same-address aliases in .symtab. It then adds .dynsym
> and repeats those steps on the combined index, preserving symbols found
> only in .dynsym. A .dynsym entry that duplicates a .symtab entry is
> omitted because eager duplicate selection would discard it; this
> prevents binaries that export most of .symtab through .dynsym from
> nearly doubling the index during construction.
>
> Lazy loading uses the same duplicate and IFUNC selection as eager
> loading and clips ranges that cross .plt before synthesizing PLT
> symbols. PLT synthesis itself is unchanged. For nested ranges, lookups
> return the innermost symbol containing the address.
>
> Lazy lookups hold the DSO lock while searching the index and inserting
> symbols, but release it before reading names because the DSO data cache
> takes its global lock before DSO locks. Reads from one index are
> serialized because cache-page lookups are otherwise lockless. Before
> building the existing name-sorted symbol array, perf materializes the
> entire lazy index and detaches it from the DSO. A detached index remains
> alive until its last reader finishes, ensuring that no symbols are added
> after the name-sorted array is built.
>
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>
> ---
>  tools/perf/Documentation/perf-script.txt |   9 +
>  tools/perf/builtin-script.c              |   2 +
>  tools/perf/util/dso.c                    |  24 +
>  tools/perf/util/dso.h                    |  59 ++
>  tools/perf/util/map.c                    |   7 +-
>  tools/perf/util/symbol-elf.c             | 926 +++++++++++++++++++++++++=
++++++
>  tools/perf/util/symbol-minimal.c         |   9 +
>  tools/perf/util/symbol.c                 |   9 +
>  tools/perf/util/symbol_conf.h            |   1 +
>  9 files changed, 1045 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Docume=
ntation/perf-script.txt
> index f0228e784ced..7ef4642803da 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -343,6 +343,15 @@ include::itrace.txt[]
>
>          Default: 127
>
> +--lazy-load-symbols::
> +       Resolve symbols lazily instead of eagerly loading the full
> +       symbol table of every DSO that appears in a sample. This sharply
> +       reduces memory (and usually time) for profiles of large binaries
> +       where only a small fraction of the symbol table is referenced. Th=
is
> +       applies only to userspace ELF DSOs; kernel DSOs, modules, PPC64 D=
SOs
> +       with an .opd section and DSOs whose symbols come from .gnu_debugd=
ata
> +       always load eagerly.
> +
>  --ns::
>         Use 9 decimal places when displaying time (i.e. show the nanoseco=
nds)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index b6691ebb1b4e..404f5a080d45 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -4287,6 +4287,8 @@ int cmd_script(int argc, const char **argv)
>                      "Set the maximum stack depth when parsing the callch=
ain, "
>                      "anything beyond the specified depth will be ignored=
. "
>                      "Default: kernel.perf_event_max_stack or " __stringi=
fy(PERF_MAX_STACK_DEPTH)),
> +       OPT_BOOLEAN(0, "lazy-load-symbols", &symbol_conf.lazy_load_symbol=
s,
> +                   "Resolve symbols lazily instead of loading full symta=
bs"),
>         OPT_BOOLEAN(0, "reltime", &reltime, "Show time stamps relative to=
 start"),
>         OPT_BOOLEAN(0, "deltatime", &deltatime, "Show time stamps relativ=
e to previous event"),
>         OPT_BOOLEAN('I', "show-info", &show_full_info,
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 5c4872810ada..d6d2d2ce4157 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -1721,6 +1721,29 @@ void dso__set_sorted_by_name(struct dso *dso)
>         RC_CHK_ACCESS(dso)->sorted_by_name =3D true;
>  }
>
> +struct dso_ondemand *dso_ondemand__new(void)
> +{
> +       struct dso_ondemand *od =3D zalloc(sizeof(*od));
> +
> +       if (od)
> +               mutex_init(&od->read_lock);
> +       return od;
> +}
> +
> +void dso_ondemand__free(struct dso_ondemand *od)
> +{
> +       if (!od)
> +               return;
> +       mutex_destroy(&od->read_lock);
> +       free(od->sorted);
> +       free(od->outer);
> +       if (od->data_dso) {
> +               dso__data_close(od->data_dso);
> +               dso__put(od->data_dso);
> +       }
> +       free(od);
> +}
> +
>  struct dso *dso__new_id(const char *name, const struct dso_id *id)
>  {
>         RC_STRUCT(dso) *dso =3D zalloc(sizeof(*dso) + strlen(name) + 1);
> @@ -1803,6 +1826,7 @@ void dso__delete(struct dso *dso)
>
>         dso__data_close(dso);
>         auxtrace_cache__free(RC_CHK_ACCESS(dso)->auxtrace_cache);
> +       dso_ondemand__free(RC_CHK_ACCESS(dso)->ondemand);
>         dso_cache__free(dso);
>         zfree(&RC_CHK_ACCESS(dso)->data.path);
>         dso__free_a2l(dso);
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index 7bcd5ec0c312..6bc43d97278f 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -283,6 +283,43 @@ struct dso_bpf_prog {
>         struct perf_env *env;
>  };
>
> +struct sym_idx {
> +       u64     start;
> +       u64     end;
> +       u32     name_off;
> +       u8      binding;
> +       u8      type;
> +       u8      flags;
> +};
> +
> +#define SYM_IDX_FLAG_IFUNC_ALIAS       (1 << 0)
> +#define SYM_IDX_FLAG_MATERIALIZED      (1 << 1)
> +#define SYM_IDX_FLAG_DYNSTR            (1 << 2)
> +
> +#define SYM_IDX_NONE                   UINT32_MAX
> +
> +struct sym_idx_strtab {
> +       u64     offset;
> +       u64     size;
> +};
> +
> +struct dso_ondemand {
> +       struct dso              *data_dso;

Could you add kernel doc for dso_ondemand? I believe it is keeping
state while resolving symbols, but the name makes it sound more
persistent.

> +       /* Indexed by whether SYM_IDX_FLAG_DYNSTR is set. */
> +       struct sym_idx_strtab   strtab[2];
> +       struct sym_idx          *sorted;
> +       /*
> +        * Only allocated if some ranges overlap: for each entry, the nea=
rest
> +        * earlier entry that ends after it, or SYM_IDX_NONE.
> +        */
> +       u32                     *outer;
> +       u32                     nr_sorted;
> +       /* Lookups reading a name without the DSO lock; see sym_idx_ref. =
*/
> +       u32                     nr_readers;
> +       /* The DSO data cache looks up pages without a lock. */
> +       struct mutex            read_lock;
> +};
> +
>  struct auxtrace_cache;
>
>  DECLARE_RC_STRUCT(dso) {
> @@ -314,6 +351,7 @@ DECLARE_RC_STRUCT(dso) {
>         char             *symsrc_filename;
>         struct nsinfo   *nsinfo;
>         struct auxtrace_cache *auxtrace_cache;
> +       struct dso_ondemand *ondemand;
>         union { /* Tool specific area */
>                 void     *priv;
>                 u64      db_id;
> @@ -473,6 +511,16 @@ static inline void dso__set_auxtrace_cache(struct ds=
o *dso, struct auxtrace_cach
>         RC_CHK_ACCESS(dso)->auxtrace_cache =3D cache;
>  }
>
> +static inline struct dso_ondemand *dso__ondemand(struct dso *dso)
> +{
> +       return RC_CHK_ACCESS(dso)->ondemand;
> +}
> +
> +static inline void dso__set_ondemand(struct dso *dso, struct dso_ondeman=
d *od)
> +{
> +       RC_CHK_ACCESS(dso)->ondemand =3D od;
> +}
> +
>  static inline struct dso_bpf_prog *dso__bpf_prog(struct dso *dso)
>  {
>         return &RC_CHK_ACCESS(dso)->bpf_prog;
> @@ -849,6 +897,17 @@ char *dso__get_filename(struct dso *dso, const char =
*root_dir, bool *decomp,
>  void dso__put_filename(struct dso *dso, char *filename, bool decomp);
>  bool is_kernel_module(const char *pathname, int cpumode);
>  bool dso__needs_decompress(struct dso *dso);
> +struct symbol *dso__find_symbol_ondemand(struct dso *dso, u64 addr)
> +       LOCKS_EXCLUDED(dso__lock(dso));
> +void dso__materialize_symbols_ondemand(struct dso *dso)
> +       LOCKS_EXCLUDED(dso__lock(dso));
> +const char *dso__read_ondemand_symbol_name(struct dso *data_dso,
> +                                          u64 strtab_offset, u64 strtab_=
size,
> +                                          u64 name_off, char *buf,
> +                                          size_t buflen, char **to_free,
> +                                          unsigned int *nr_reads);
> +struct dso_ondemand *dso_ondemand__new(void);
> +void dso_ondemand__free(struct dso_ondemand *od);
>  int dso__decompress_kmodule_fd(struct dso *dso, const char *name);
>  int dso__decompress_kmodule_path(struct dso *dso, const char *name,
>                                  char *pathname, size_t len);
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 41cdddc987ee..ee46a31d4067 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -382,10 +382,15 @@ int map__load(struct map *map)
>
>  struct symbol *map__find_symbol(struct map *map, u64 addr)
>  {
> +       struct dso *dso;
> +
>         if (map__load(map) < 0)
>                 return NULL;
>
> -       return dso__find_symbol(map__dso(map), addr);
> +       dso =3D map__dso(map);
> +       if (symbol_conf.lazy_load_symbols)
> +               return dso__find_symbol_ondemand(dso, addr);
> +       return dso__find_symbol(dso, addr);

Why not do this logic in dso__find_symbol?

>  }
>
>  struct symbol *map__find_symbol_by_name_idx(struct map *map, const char =
*name, size_t *idx)
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index e955c3feddcd..27218803969a 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -2,6 +2,7 @@
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <errno.h>
> +#include <stdint.h>
>  #include <stdlib.h>
>  #include <string.h>
>  #include <unistd.h>
> @@ -12,6 +13,7 @@
>  #include "libbfd.h"
>  #include "map.h"
>  #include "maps.h"
> +#include "namespaces.h"
>  #include "symbol.h"
>  #include "symsrc.h"
>  #include "machine.h"
> @@ -593,6 +595,8 @@ static int dso__synthesize_plt_got_symbols(struct dso=
 *dso, Elf *elf,
>         return err;
>  }
>
> +static void dso__clip_ondemand_symbols_at(struct dso *dso, u64 addr);
> +
>  /*
>   * We need to check if we have a .dynsym, so that we can handle the
>   * .plt, synthesizing its symbols, that aren't on the symtabs (be it
> @@ -623,6 +627,13 @@ int dso__synthesize_plt_symbols(struct dso *dso, str=
uct symsrc *ss)
>         if (!elf_section_by_name(elf, &ehdr, &shdr_plt, ".plt", NULL))
>                 return 0;
>
> +       /*
> +        * Zero-sized or oversized ELF symbols can have been extended acr=
oss
> +        * .plt. Clip the index first so lookups cannot attribute PLT add=
resses
> +        * to a preceding symbol before the synthesized PLT symbols are a=
dded.
> +        */
> +       dso__clip_ondemand_symbols_at(dso, shdr_plt.sh_offset);
> +
>         /*
>          * A symbol from a previous section (e.g. .init) can have been ex=
panded
>          * by symbols__fixup_end() to overlap .plt. Truncate it before ad=
ding
> @@ -1515,6 +1526,898 @@ static int dso__process_kernel_symbol(struct dso =
*dso, struct map *map,
>         return 0;
>  }
>
> +static int cmp_sym_idx(const void *a, const void *b)
> +{
> +       const struct sym_idx *sa =3D a, *sb =3D b;
> +
> +       if (sa->start !=3D sb->start)
> +               return sa->start < sb->start ? -1 : 1;
> +       /*
> +        * qsort is not stable. While sorting, name_off holds the entry's
> +        * position, preserving eager's insertion order for equal-start
> +        * aliases. sym_idx__sort() restores the name offsets afterwards.
> +        */
> +       if (sa->name_off !=3D sb->name_off)
> +               return sa->name_off < sb->name_off ? -1 : 1;
> +       return 0;
> +}
> +
> +static int sym_idx__sort(struct sym_idx *entries, u32 nr)
> +{
> +       u32 *name_offs, i;
> +
> +       if (!nr)
> +               return 0;
> +       name_offs =3D malloc(nr * sizeof(*name_offs));
> +       if (!name_offs)
> +               return -ENOMEM;
> +       for (i =3D 0; i < nr; i++) {
> +               name_offs[i] =3D entries[i].name_off;
> +               entries[i].name_off =3D i;
> +       }
> +       qsort(entries, nr, sizeof(*entries), cmp_sym_idx);
> +       for (i =3D 0; i < nr; i++)
> +               entries[i].name_off =3D name_offs[entries[i].name_off];
> +       free(name_offs);
> +       return 0;
> +}
> +
> +/* Return the first entry whose start is not less than @addr. */
> +static u32 sym_idx__lower_bound(const struct sym_idx *sorted, u32 nr, u6=
4 addr)
> +{
> +       u32 lo =3D 0, hi =3D nr;
> +
> +       while (lo < hi) {
> +               u32 mid =3D lo + (hi - lo) / 2;
> +
> +               if (sorted[mid].start < addr)
> +                       lo =3D mid + 1;
> +               else
> +                       hi =3D mid;
> +       }
> +       return lo;
> +}
> +
> +/* Return the number of entries starting at or before @addr. */
> +static u32 sym_idx__upper_bound(const struct dso_ondemand *od, u64 addr)
> +{
> +       u32 lo =3D 0, hi =3D od->nr_sorted;
> +
> +       while (lo < hi) {
> +               u32 mid =3D lo + (hi - lo) / 2;
> +
> +               if (od->sorted[mid].start <=3D addr)
> +                       lo =3D mid + 1;
> +               else
> +                       hi =3D mid;
> +       }
> +       return lo;
> +}

Would the upper and lower bound only matter if symbols were
duplicated? I'm wondering if we can use bsearch?

> +
> +/*
> + * Return the innermost entry containing @addr, i.e. the last-starting o=
ne.
> + * Only the last entry starting at or before @addr can contain it unless
> + * ranges overlap. An earlier entry containing @addr ends after every en=
try
> + * that does not, so following the outer links, each to the nearest earl=
ier
> + * entry that ends later, reaches the innermost one first.
> + */
> +static u32 sym_idx__find(const struct dso_ondemand *od, u64 addr)
> +{
> +       u32 pos =3D sym_idx__upper_bound(od, addr);
> +
> +       if (!pos)
> +               return SYM_IDX_NONE;
> +       pos--;
> +       while (pos !=3D SYM_IDX_NONE && od->sorted[pos].end <=3D addr)
> +               pos =3D od->outer ? od->outer[pos] : SYM_IDX_NONE;
> +       return pos;
> +}
> +
> +/*
> + * Allocate the outer links if any ranges overlap, and (re)compute them =
if
> + * they exist. Recomputing in place cannot fail.
> + */
> +static int dso_ondemand__link_overlaps(struct dso_ondemand *od)
> +{
> +       u32 i, j;
> +
> +       if (!od->outer) {
> +               for (i =3D 0; i + 1 < od->nr_sorted; i++) {
> +                       if (od->sorted[i].end > od->sorted[i + 1].start)
> +                               break;
> +               }
> +               if (i + 1 >=3D od->nr_sorted)
> +                       return 0;
> +               od->outer =3D malloc(od->nr_sorted * sizeof(*od->outer));
> +               if (!od->outer)
> +                       return -ENOMEM;
> +       }
> +       for (i =3D 0; i < od->nr_sorted; i++) {
> +               j =3D i ? i - 1 : SYM_IDX_NONE;
> +               while (j !=3D SYM_IDX_NONE && od->sorted[j].end <=3D od->=
sorted[i].end)
> +                       j =3D od->outer[j];
> +               od->outer[i] =3D j;
> +       }
> +       return 0;
> +}
> +
> +static struct symbol *symbols__find_start(struct rb_root_cached *symbols=
, u64 start)
> +{
> +       struct rb_node *n =3D symbols->rb_root.rb_node;
> +
> +       while (n) {
> +               struct symbol *s =3D rb_entry(n, struct symbol, rb_node);
> +
> +               if (start < s->start)
> +                       n =3D n->rb_left;
> +               else if (start > s->start)
> +                       n =3D n->rb_right;
> +               else
> +                       return s;
> +       }
> +       return NULL;
> +}
> +
> +static void dso__clip_ondemand_symbols_at(struct dso *dso, u64 addr)
> +{
> +       struct dso_ondemand *od =3D dso__ondemand(dso);
> +       u32 lo, i;
> +
> +       if (!od)
> +               return;
> +
> +       lo =3D sym_idx__lower_bound(od->sorted, od->nr_sorted, addr);
> +       for (i =3D 0; i < lo; i++) {
> +               struct sym_idx *idx =3D &od->sorted[i];
> +               struct symbol *sym;
> +
> +               if (idx->end <=3D addr)
> +                       continue;
> +               idx->end =3D addr;
> +               if (!(idx->flags & SYM_IDX_FLAG_MATERIALIZED))
> +                       continue;
> +               sym =3D symbols__find_start(dso__symbols(dso), idx->start=
);
> +               if (sym && sym->end > addr)
> +                       sym->end =3D addr;
> +       }
> +       if (od->outer)
> +               dso_ondemand__link_overlaps(od);
> +}
> +
> +static bool ondemand_sym_ok(Elf *elf, Elf_Data *secstrs,
> +                           const GElf_Sym *sym, u32 sh_link,
> +                           uint16_t e_machine)
> +{
> +       Elf_Scn *sym_sec;
> +       GElf_Shdr sym_shdr;
> +       int is_label =3D elf_sym__is_label(sym);
> +       const char *name;
> +
> +       if (!is_label && !elf_sym__filter((GElf_Sym *)sym))
> +               return false;
> +
> +       if (sym->st_shndx =3D=3D SHN_ABS)
> +               return false;
> +
> +       sym_sec =3D elf_getscn(elf, sym->st_shndx);
> +       if (!sym_sec)
> +               return false;
> +       if (!gelf_getshdr(sym_sec, &sym_shdr))
> +               return false;
> +       if (!(sym_shdr.sh_flags & SHF_ALLOC))
> +               return false;
> +
> +       if (is_label && (!secstrs || !elf_sec__filter(&sym_shdr, secstrs)=
))
> +               return false;
> +
> +       name =3D elf_strptr(elf, sh_link, sym->st_name);
> +       if (!name)
> +               return false;
> +
> +       /*
> +        * Reject ARM/AArch64/RISC-V "mapping symbols" ($a/$d/$t/$x), as
> +        * the eager loop does.  They are zero-size STT_NOTYPE labels in
> +        * allocated sections that would otherwise be indexed and fill
> +        * forward over real functions, misattributing everything after
> +        * them.
> +        */
> +       if (e_machine =3D=3D EM_ARM || e_machine =3D=3D EM_AARCH64) {
> +               if (name[0] =3D=3D '$' && strchr("adtx", name[1]) &&
> +                   (name[2] =3D=3D '\0' || name[2] =3D=3D '.'))
> +                       return false;
> +       }
> +       if (e_machine =3D=3D EM_RISCV) {
> +               if (name[0] =3D=3D '$' && strchr("dx", name[1]))
> +                       return false;
> +       }
> +
> +       return true;
> +}
> +
> +static const char *sym_idx__elf_name(Elf *elf, const size_t *strndx,
> +                                    const struct sym_idx *idx)
> +{
> +       return elf_strptr(elf, strndx[!!(idx->flags & SYM_IDX_FLAG_DYNSTR=
)],
> +                         idx->name_off);
> +}
> +
> +static void sym_idx__candidate(const struct sym_idx *idx, const char *na=
me,
> +                              struct symbol_candidate *c)
> +{
> +       c->size =3D idx->end - idx->start;
> +       c->name =3D name;
> +       c->type =3D idx->type;
> +       c->binding =3D idx->binding;
> +}
> +
> +/*
> + * Keep one entry per start address, choosing among aliases and marking =
IFUNC
> + * aliases with the same policy as symbols__fixup_duplicate(). Returns t=
he new
> + * entry count.
> + */
> +static u32 sym_idx__dedup_aliases(struct dso *dso, Elf *elf,
> +                                 const size_t *strndx,
> +                                 struct sym_idx *sorted, u32 count)
> +{
> +       u32 i, j, k, out =3D 0;
> +
> +       for (i =3D 0; i < count; i =3D j) {
> +               struct symbol_candidate best, cand;
> +               char *best_demangled =3D NULL, *demangled;
> +               const char *name;
> +               u32 best_idx =3D i;
> +               bool ifunc_alias;
> +
> +               j =3D i + 1;
> +               while (j < count && sorted[j].start =3D=3D sorted[i].star=
t)
> +                       j++;
> +               if (j =3D=3D i + 1) {
> +                       sorted[out++] =3D sorted[i];
> +                       continue;
> +               }
> +
> +               name =3D sym_idx__elf_name(elf, strndx, &sorted[i]);
> +               if (name) {
> +                       best_demangled =3D dso__demangle_sym(dso, 0, name=
);
> +                       if (best_demangled)
> +                               name =3D best_demangled;
> +               }
> +               sym_idx__candidate(&sorted[i], name, &best);
> +               ifunc_alias =3D sorted[i].flags & SYM_IDX_FLAG_IFUNC_ALIA=
S;
> +
> +               for (k =3D i + 1; k < j; k++) {
> +                       name =3D sym_idx__elf_name(elf, strndx, &sorted[k=
]);
> +                       if (!best.name || !name)
> +                               continue;
> +
> +                       demangled =3D dso__demangle_sym(dso, 0, name);
> +                       if (demangled)
> +                               name =3D demangled;
> +                       sym_idx__candidate(&sorted[k], name, &cand);
> +
> +                       if (symbol__choose_best(&best, &cand) =3D=3D SYMB=
OL_B) {
> +                               ifunc_alias =3D (sorted[k].flags & SYM_ID=
X_FLAG_IFUNC_ALIAS) ||
> +                                             best.type =3D=3D STT_GNU_IF=
UNC;
> +                               free(best_demangled);
> +                               best_demangled =3D demangled;
> +                               best =3D cand;
> +                               best_idx =3D k;
> +                       } else {
> +                               ifunc_alias |=3D cand.type =3D=3D STT_GNU=
_IFUNC;
> +                               free(demangled);
> +                       }
> +               }
> +               free(best_demangled);
> +
> +               sorted[out] =3D sorted[best_idx];
> +               sorted[out].flags &=3D ~SYM_IDX_FLAG_IFUNC_ALIAS;
> +               if (ifunc_alias)
> +                       sorted[out].flags |=3D SYM_IDX_FLAG_IFUNC_ALIAS;
> +               out++;
> +       }
> +       return out;
> +}
> +
> +/*
> + * Whether .dynsym entry @idx is a copy of the .symtab entry at its star=
t, so
> + * that symbols__fixup_duplicate() keeps the .symtab entry. Dropping cop=
ies
> + * here keeps a .dynsym that exports most of .symtab from doubling the
> + * index while it is built. The "SyS" check excludes the names on which
> + * arch__choose_best_symbol() does not keep the first of two equal symbo=
ls.
> + */
> +static bool sym_idx__dynsym_copy(Elf *elf, const size_t *strndx,
> +                                const struct sym_idx *symtab, u32 nr,
> +                                const struct sym_idx *idx)
> +{
> +       u32 pos =3D sym_idx__lower_bound(symtab, nr, idx->start);
> +       const struct sym_idx *orig =3D &symtab[pos];
> +       const char *name, *orig_name;
> +
> +       if (symbol_conf.allow_aliases || pos =3D=3D nr ||
> +           orig->start !=3D idx->start || orig->end !=3D idx->end ||
> +           idx->end =3D=3D idx->start || orig->type !=3D idx->type ||
> +           orig->binding !=3D idx->binding)
> +               return false;
> +       name =3D sym_idx__elf_name(elf, strndx, idx);
> +       orig_name =3D sym_idx__elf_name(elf, strndx, orig);
> +       return name && orig_name && !strcmp(name, orig_name) &&
> +              !strstr(name, "SyS");
> +}
> +
> +/*
> + * Fill @idx from @sym if the eager loader would load it, with end set t=
o
> + * start + size. @symtab holds the fixed up .symtab entries when loading
> + * .dynsym.
> + */
> +static bool sym_idx__from_sym(struct symsrc *syms_ss,
> +                             struct symsrc *runtime_ss, Elf_Data *secstr=
s,
> +                             bool dynsym, const struct sym_idx *symtab,
> +                             u32 nr, const size_t *strndx,
> +                             const GElf_Sym *sym, struct sym_idx *idx)
> +{
> +       Elf *elf =3D syms_ss->elf;
> +       GElf_Shdr shdr =3D dynsym ? syms_ss->dynshdr : syms_ss->symshdr;
> +       u16 e_machine =3D syms_ss->ehdr.e_machine;
> +       u64 adjusted =3D sym->st_value;
> +       GElf_Phdr phdr;
> +
> +       if (!ondemand_sym_ok(elf, secstrs, sym, shdr.sh_link, e_machine))
> +               return false;
> +
> +       if (e_machine =3D=3D EM_ARM && GELF_ST_TYPE(sym->st_info) =3D=3D =
STT_FUNC &&
> +           (adjusted & 1))
> +               --adjusted;

Worth a comment that this is stripping of the thumb/not-thumb indicator bit=
.

Thanks,
Ian

> +
> +       if (elf_read_program_header(runtime_ss->elf, adjusted, &phdr) =3D=
=3D 0) {
> +               adjusted -=3D phdr.p_vaddr - phdr.p_offset;
> +       } else {
> +               Elf_Scn *sym_sec =3D elf_getscn(elf, sym->st_shndx);
> +               GElf_Shdr sym_shdr;
> +
> +               if (sym_sec && gelf_getshdr(sym_sec, &sym_shdr)) {
> +                       /*
> +                        * A NOBITS section in a debuginfo file has an in=
valid
> +                        * sh_offset; use the runtime section.
> +                        */
> +                       if (sym_shdr.sh_type =3D=3D SHT_NOBITS) {
> +                               sym_sec =3D elf_getscn(runtime_ss->elf,
> +                                                    sym->st_shndx);
> +                               if (!sym_sec || !gelf_getshdr(sym_sec, &s=
ym_shdr))
> +                                       return false;
> +                       }
> +                       adjusted -=3D sym_shdr.sh_addr - sym_shdr.sh_offs=
et;
> +               }
> +       }
> +
> +       *idx =3D (struct sym_idx) {
> +               .start =3D adjusted,
> +               .end =3D adjusted + sym->st_size,
> +               .name_off =3D sym->st_name,
> +               .binding =3D GELF_ST_BIND(sym->st_info),
> +               .type =3D GELF_ST_TYPE(sym->st_info),
> +               .flags =3D dynsym ? SYM_IDX_FLAG_DYNSTR : 0,
> +       };
> +       return !dynsym || !sym_idx__dynsym_copy(elf, strndx, symtab, nr, =
idx);
> +}
> +
> +/*
> + * Append the eligible symbols of .dynsym or .symtab to *@entries and re=
cord
> + * the table's string table in @strtab and @strndx, indexed by @dynsym.
> + */
> +static int sym_idx__add_table(struct symsrc *syms_ss, struct symsrc *run=
time_ss,
> +                             bool dynsym, struct sym_idx **entries, u32 =
*nr,
> +                             struct sym_idx_strtab *strtab, size_t *strn=
dx)
> +{
> +       Elf *elf =3D syms_ss->elf;
> +       GElf_Ehdr *ehdr =3D &syms_ss->ehdr;
> +       GElf_Shdr shdr =3D dynsym ? syms_ss->dynshdr : syms_ss->symshdr;
> +       GElf_Shdr strshdr;
> +       Elf_Scn *strscn, *sec_strndx;
> +       Elf_Data *syms, *secstrs =3D NULL;
> +       struct sym_idx *tmp, idx;
> +       size_t i, bytes;
> +       u64 nr_entries;
> +       u32 count =3D 0, j;
> +       GElf_Sym sym;
> +
> +       syms =3D elf_getdata(dynsym ? syms_ss->dynsym : syms_ss->symtab, =
NULL);
> +       if (!syms)
> +               return -1;
> +
> +       if (!shdr.sh_entsize)
> +               return 0;
> +
> +       nr_entries =3D shdr.sh_size / shdr.sh_entsize;
> +       if (nr_entries > UINT32_MAX)
> +               return -EOVERFLOW;
> +
> +       strscn =3D elf_getscn(elf, shdr.sh_link);
> +       if (!strscn || !gelf_getshdr(strscn, &strshdr))
> +               return -1;
> +       strndx[dynsym] =3D shdr.sh_link;
> +
> +       sec_strndx =3D elf_getscn(elf, ehdr->e_shstrndx);
> +       if (sec_strndx)
> +               secstrs =3D elf_getdata(sec_strndx, NULL);
> +
> +       for (i =3D 0; i < nr_entries; i++) {
> +               if (gelf_getsym(syms, i, &sym) &&
> +                   sym_idx__from_sym(syms_ss, runtime_ss, secstrs, dynsy=
m,
> +                                     *entries, *nr, strndx, &sym, &idx))
> +                       count++;
> +       }
> +
> +       if (!count)
> +               return 0;
> +       if (count > UINT32_MAX - *nr ||
> +           check_mul_overflow((size_t)(*nr + count), sizeof(**entries), =
&bytes))
> +               return -EOVERFLOW;
> +       tmp =3D realloc(*entries, bytes);
> +       if (!tmp)
> +               return -1;
> +       *entries =3D tmp;
> +
> +       /*
> +        * The file may change between the two passes; never fill more en=
tries
> +        * than the first pass counted.
> +        */
> +       j =3D *nr;
> +       for (i =3D 0; i < nr_entries && j < *nr + count; i++) {
> +               if (!gelf_getsym(syms, i, &sym) ||
> +                   !sym_idx__from_sym(syms_ss, runtime_ss, secstrs, dyns=
ym,
> +                                      *entries, *nr, strndx, &sym, &idx)=
)
> +                       continue;
> +               tmp[j++] =3D idx;
> +       }
> +       *nr =3D j;
> +       strtab[dynsym].offset =3D strshdr.sh_offset;
> +       strtab[dynsym].size =3D strshdr.sh_size;
> +       return 0;
> +}
> +
> +/*
> + * Do what the eager loader does after inserting a table's symbols:
> + * symbols__fixup_end() extends zero-size symbols to the next start, the=
n
> + * symbols__fixup_duplicate() drops aliases.
> + */
> +static int sym_idx__fixup(struct dso *dso, Elf *elf, const size_t *strnd=
x,
> +                         struct sym_idx *entries, u32 *nr)
> +{
> +       int err =3D sym_idx__sort(entries, *nr);
> +       u32 i;
> +
> +       if (err)
> +               return err;
> +       for (i =3D 0; i < *nr; i++) {
> +               if (entries[i].end !=3D entries[i].start)
> +                       continue;
> +               if (i + 1 < *nr)
> +                       entries[i].end =3D entries[i + 1].start;
> +               else
> +                       entries[i].end =3D roundup(entries[i].start, 4096=
) + 4096;
> +       }
> +       if (!symbol_conf.allow_aliases)
> +               *nr =3D sym_idx__dedup_aliases(dso, elf, strndx, entries,=
 *nr);
> +       return 0;
> +}
> +
> +static struct symbol *sym_idx__new_symbol(struct dso *dso,
> +                                         const struct sym_idx *idx,
> +                                         const char *name)
> +{
> +       char *demangled =3D dso__demangle_sym(dso, 0, name);
> +       struct symbol *sym;
> +
> +       sym =3D symbol__new(idx->start, idx->end - idx->start, idx->bindi=
ng,
> +                         idx->type, demangled ?: name);
> +       free(demangled);
> +       if (sym && (idx->flags & SYM_IDX_FLAG_IFUNC_ALIAS))
> +               symbol__set_ifunc_alias(sym, true);
> +       return sym;
> +}
> +
> +/*
> + * PLT synthesis names IRELATIVE slots after the IFUNC they resolve to, =
which
> + * it looks up in the rb-tree while dso__load() holds the DSO lock.
> + * Materialize IFUNCs now, with names from the ELF image, so that it fin=
ds
> + * them without reading names.
> + */
> +static void sym_idx__materialize_ifuncs(struct dso *dso, Elf *elf,
> +                                       const size_t *strndx)
> +{
> +       struct dso_ondemand *od =3D dso__ondemand(dso);
> +       u32 i;
> +
> +       for (i =3D 0; i < od->nr_sorted; i++) {
> +               struct sym_idx *idx =3D &od->sorted[i];
> +               const char *name;
> +               struct symbol *sym;
> +
> +               if (idx->type !=3D STT_GNU_IFUNC &&
> +                   !(idx->flags & SYM_IDX_FLAG_IFUNC_ALIAS))
> +                       continue;
> +               name =3D sym_idx__elf_name(elf, strndx, idx);
> +               sym =3D name ? sym_idx__new_symbol(dso, idx, name) : NULL=
;
> +               if (!sym)
> +                       continue;
> +               __symbols__insert(dso__symbols(dso), sym);
> +               idx->flags |=3D SYM_IDX_FLAG_MATERIALIZED;
> +       }
> +}
> +
> +/*
> + * Check that @path can be reopened to read names. This runs under the D=
SO
> + * lock, so it opens the file directly: the DSO data cache takes its glo=
bal
> + * lock before DSO locks.
> + */
> +static bool dso_ondemand__source_readable(const struct dso_ondemand *od,
> +                                         const char *path)
> +{
> +       const struct sym_idx *idx =3D &od->sorted[0];
> +       const struct sym_idx_strtab *strtab;
> +       u64 off;
> +       u8 probe;
> +       bool ok;
> +       int fd;
> +
> +       strtab =3D &od->strtab[!!(idx->flags & SYM_IDX_FLAG_DYNSTR)];
> +       if (idx->name_off >=3D strtab->size ||
> +           check_add_overflow(strtab->offset, (u64)idx->name_off, &off) =
||
> +           off > INT64_MAX)
> +               return false;
> +
> +       fd =3D open(path, O_RDONLY | O_CLOEXEC);
> +       if (fd < 0)
> +               return false;
> +       ok =3D pread(fd, &probe, 1, off) =3D=3D 1;
> +       close(fd);
> +       return ok;
> +}
> +
> +/*
> + * Index the symbols of .symtab, if @dynsym is zero, and .dynsym. Like
> + * dso__load_sym(), fix up .symtab first and then both tables together.
> + */
> +static int dso__build_ondemand_index(struct dso *dso, struct symsrc *sym=
s_ss,
> +                                    struct symsrc *runtime_ss,
> +                                    int dynsym)
> +{
> +       struct sym_idx_strtab strtab[2] =3D {};
> +       struct sym_idx *entries =3D NULL, *shrunk;
> +       struct dso_ondemand *od;
> +       size_t strndx[2] =3D {};
> +       u32 nr =3D 0, prev;
> +       bool in_host_ns;
> +       int i, err =3D 0;
> +
> +       /*
> +        * GNU debugdata is backed by a temporary decompressed fd rather =
than a
> +        * reopenable source path. Keep using the eager loader for that c=
ase,
> +        * including the runtime .dynsym that dso__load_sym() then loads =
with
> +        * the runtime file as @syms_ss, so that both are fixed up togeth=
er.
> +        */
> +       if (dso__symtab_type(dso) =3D=3D DSO_BINARY_TYPE__GNU_DEBUGDATA)
> +               return 0;
> +
> +       for (i =3D dynsym; i < 2; i++) {
> +               if (!(i ? syms_ss->dynsym : syms_ss->symtab))
> +                       continue;
> +               prev =3D nr;
> +               err =3D sym_idx__add_table(syms_ss, runtime_ss, i, &entri=
es, &nr,
> +                                        strtab, strndx);
> +               if (!err && nr > prev)
> +                       err =3D sym_idx__fixup(dso, syms_ss->elf, strndx,=
 entries, &nr);
> +               if (err)
> +                       goto out_free;
> +       }
> +       if (!nr)
> +               goto out_free;
> +
> +       shrunk =3D realloc(entries, nr * sizeof(*entries));
> +       if (shrunk)
> +               entries =3D shrunk;
> +
> +       od =3D dso_ondemand__new();
> +       if (!od) {
> +               err =3D -1;
> +               goto out_free;
> +       }
> +       od->sorted =3D entries;
> +       od->nr_sorted =3D nr;
> +       memcpy(od->strtab, strtab, sizeof(strtab));
> +       entries =3D NULL;
> +       if (dso_ondemand__link_overlaps(od)) {
> +               err =3D -1;
> +               goto out_free_od;
> +       }
> +
> +       /*
> +        * dso__load() has just opened build-id cache files from outside =
the
> +        * mount namespace of the DSO, so read names from them there too.
> +        * Other sources were opened in the namespace we are in now.
> +        */
> +       in_host_ns =3D syms_ss->type =3D=3D DSO_BINARY_TYPE__BUILD_ID_CAC=
HE ||
> +                    syms_ss->type =3D=3D DSO_BINARY_TYPE__BUILD_ID_CACHE=
_DEBUGINFO;
> +       if (!in_host_ns && !dso_ondemand__source_readable(od, syms_ss->na=
me))
> +               goto out_free_od;
> +       od->data_dso =3D dso__new(syms_ss->name);
> +       if (!od->data_dso ||
> +           dso__data_set_path(od->data_dso, syms_ss->name) < 0)
> +               goto out_free_od;
> +       dso__set_binary_type(od->data_dso, DSO_BINARY_TYPE__SYSTEM_PATH_D=
SO);
> +       if (!in_host_ns)
> +               dso__set_nsinfo(od->data_dso, nsinfo__get(dso__nsinfo(dso=
)));
> +
> +       dso__set_ondemand(dso, od);
> +       sym_idx__materialize_ifuncs(dso, syms_ss->elf, strndx);
> +
> +       pr_debug("%s: on-demand index: %u symbols (%zu bytes)\n",
> +                dso__long_name(dso), nr,
> +                nr * (sizeof(*od->sorted) + (od->outer ? sizeof(*od->out=
er) : 0)));
> +       return 1;
> +
> +out_free_od:
> +       dso_ondemand__free(od);
> +       return err;
> +out_free:
> +       free(entries);
> +       return err;
> +}
> +
> +const char *dso__read_ondemand_symbol_name(struct dso *data_dso,
> +                                          u64 strtab_offset, u64 strtab_=
size,
> +                                          u64 name_off, char *buf,
> +                                          size_t buflen, char **to_free,
> +                                          unsigned int *nr_reads)
> +{
> +       ssize_t n;
> +       u64 remain;
> +       u64 file_off;
> +       size_t cap, want;
> +
> +       *to_free =3D NULL;
> +
> +       if (name_off >=3D strtab_size)
> +               return NULL;
> +       if (check_add_overflow(strtab_offset, name_off, &file_off))
> +               return NULL;
> +       remain =3D strtab_size - name_off;
> +       if (nr_reads)
> +               *nr_reads =3D 0;
> +
> +       want =3D min((u64)(buflen - 1), remain);
> +       if (nr_reads)
> +               (*nr_reads)++;
> +       n =3D dso__data_read_offset(data_dso, NULL, file_off, (u8 *)buf, =
want);
> +       if (n <=3D 0)
> +               return NULL;
> +       buf[n] =3D '\0';
> +       if (memchr(buf, '\0', n))
> +               return buf;
> +       if ((size_t)n < want)
> +               return NULL;
> +
> +       cap =3D 4096;
> +       for (;;) {
> +               char *tmp;
> +
> +               want =3D cap;
> +               if (want > remain)
> +                       want =3D remain;
> +               if (want =3D=3D 0)
> +                       break;
> +
> +               tmp =3D *to_free ? realloc(*to_free, want + 1) : malloc(w=
ant + 1);
> +               if (!tmp) {
> +                       free(*to_free);
> +                       *to_free =3D NULL;
> +                       return NULL;
> +               }
> +               *to_free =3D tmp;
> +
> +               if (nr_reads)
> +                       (*nr_reads)++;
> +               n =3D dso__data_read_offset(data_dso, NULL, file_off,
> +                                         (u8 *)*to_free, want);
> +               if (n <=3D 0) {
> +                       free(*to_free);
> +                       *to_free =3D NULL;
> +                       return NULL;
> +               }
> +               (*to_free)[n] =3D '\0';
> +
> +               if (memchr(*to_free, '\0', n))
> +                       return *to_free;
> +               if ((size_t)n < want)
> +                       break;
> +
> +               if (want >=3D remain || (u64)n >=3D remain)
> +                       break;
> +
> +               if (cap > SIZE_MAX / 2)
> +                       break;
> +               cap *=3D 2;
> +       }
> +
> +       free(*to_free);
> +       *to_free =3D NULL;
> +       return NULL;
> +}
> +
> +/*
> + * A snapshot of an index entry, so that its name can be read without th=
e DSO
> + * lock: name reads go through the DSO data cache, which takes its globa=
l lock
> + * and then the lock of the DSO it opens. The index, and its data source=
, stay
> + * allocated until the last reader is done, even once detached from the =
DSO.
> + */
> +struct sym_idx_ref {
> +       struct dso_ondemand     *od;
> +       struct sym_idx_strtab   strtab;
> +       struct sym_idx          entry;
> +       u32                     pos;
> +};
> +
> +static void dso_ondemand__get_ref(struct dso_ondemand *od, u32 pos,
> +                                 struct sym_idx_ref *ref)
> +{
> +       ref->od =3D od;
> +       ref->entry =3D od->sorted[pos];
> +       ref->strtab =3D od->strtab[!!(ref->entry.flags & SYM_IDX_FLAG_DYN=
STR)];
> +       ref->pos =3D pos;
> +       od->nr_readers++;
> +}
> +
> +/* Return the index to free if @ref was the last reader of a detached on=
e. */
> +static struct dso_ondemand *dso_ondemand__put_ref(struct dso *dso,
> +                                                 const struct sym_idx_re=
f *ref)
> +       EXCLUSIVE_LOCKS_REQUIRED(dso__lock(dso))
> +{
> +       struct dso_ondemand *od =3D ref->od;
> +
> +       if (--od->nr_readers || dso__ondemand(dso) =3D=3D od)
> +               return NULL;
> +       return od;
> +}
> +
> +static struct symbol *sym_idx_ref__read(struct dso *dso,
> +                                       const struct sym_idx_ref *ref)
> +       LOCKS_EXCLUDED(dso__lock(dso))
> +{
> +       char namebuf[1024];
> +       char *name_heap;
> +       const char *name;
> +       struct symbol *sym;
> +
> +       mutex_lock(&ref->od->read_lock);
> +       name =3D dso__read_ondemand_symbol_name(ref->od->data_dso, ref->s=
trtab.offset,
> +                                             ref->strtab.size,
> +                                             ref->entry.name_off, namebu=
f,
> +                                             sizeof(namebuf), &name_heap=
, NULL);
> +       mutex_unlock(&ref->od->read_lock);
> +       if (!name)
> +               return NULL;
> +       sym =3D sym_idx__new_symbol(dso, &ref->entry, name);
> +       free(name_heap);
> +       return sym;
> +}
> +
> +/*
> + * Insert @sym, read for @ref, unless the entry or the whole index was
> + * materialized meanwhile. Return the symbol the tree now has for the en=
try.
> + */
> +static struct symbol *dso_ondemand__insert(struct dso *dso,
> +                                          const struct sym_idx_ref *ref,
> +                                          struct symbol *sym)
> +       EXCLUSIVE_LOCKS_REQUIRED(dso__lock(dso))
> +{
> +       struct sym_idx *idx =3D &ref->od->sorted[ref->pos];
> +
> +       if (dso__ondemand(dso) !=3D ref->od ||
> +           idx->flags & SYM_IDX_FLAG_MATERIALIZED) {
> +               if (sym)
> +                       symbol__delete(sym);
> +               return symbols__find_start(dso__symbols(dso), ref->entry.=
start);
> +       }
> +       if (sym) {
> +               __symbols__insert(dso__symbols(dso), sym);
> +               idx->flags |=3D SYM_IDX_FLAG_MATERIALIZED;
> +       }
> +       return sym;
> +}
> +
> +static bool dso_ondemand__next_ref(struct dso *dso, u32 *pos,
> +                                  struct sym_idx_ref *ref)
> +       EXCLUSIVE_LOCKS_REQUIRED(dso__lock(dso))
> +{
> +       struct dso_ondemand *od =3D dso__ondemand(dso);
> +
> +       if (!od)
> +               return false;
> +       while (*pos < od->nr_sorted &&
> +              (od->sorted[*pos].flags & SYM_IDX_FLAG_MATERIALIZED))
> +               (*pos)++;
> +       if (*pos >=3D od->nr_sorted)
> +               return false;
> +       dso_ondemand__get_ref(od, (*pos)++, ref);
> +       return true;
> +}
> +
> +void dso__materialize_symbols_ondemand(struct dso *dso)
> +{
> +       struct dso_ondemand *od;
> +       struct sym_idx_ref ref;
> +       u32 pos =3D 0, nr_failed =3D 0;
> +       bool more;
> +
> +       if (!symbol_conf.lazy_load_symbols)
> +               return;
> +
> +       for (;;) {
> +               struct symbol *sym;
> +
> +               mutex_lock(dso__lock(dso));
> +               more =3D dso_ondemand__next_ref(dso, &pos, &ref);
> +               mutex_unlock(dso__lock(dso));
> +               if (!more)
> +                       break;
> +
> +               sym =3D sym_idx_ref__read(dso, &ref);
> +               if (!sym)
> +                       nr_failed++;
> +               mutex_lock(dso__lock(dso));
> +               dso_ondemand__insert(dso, &ref, sym);
> +               od =3D dso_ondemand__put_ref(dso, &ref);
> +               mutex_unlock(dso__lock(dso));
> +               dso_ondemand__free(od);
> +       }
> +
> +       /*
> +        * Detach the index before the caller builds the name-sorted arra=
y, so
> +        * that a DSO with that array never changes again.
> +        */
> +       mutex_lock(dso__lock(dso));
> +       od =3D dso__ondemand(dso);
> +       dso__set_ondemand(dso, NULL);
> +       if (od && od->nr_readers)
> +               od =3D NULL;
> +       mutex_unlock(dso__lock(dso));
> +
> +       if (nr_failed)
> +               pr_debug("%s: cannot read %u lazily loaded symbol names\n=
",
> +                        dso__long_name(dso), nr_failed);
> +       dso_ondemand__free(od);
> +}
> +
> +struct symbol *dso__find_symbol_ondemand(struct dso *dso, u64 addr)
> +{
> +       struct dso_ondemand *od;
> +       struct sym_idx_ref ref;
> +       struct symbol *sym;
> +       u32 pos;
> +
> +       mutex_lock(dso__lock(dso));
> +       od =3D dso__ondemand(dso);
> +       pos =3D od ? sym_idx__find(od, addr) : SYM_IDX_NONE;
> +       if (pos =3D=3D SYM_IDX_NONE) {
> +               /* Synthesized PLT symbols, or a fully materialized DSO. =
*/
> +               sym =3D dso__find_symbol(dso, addr);
> +       } else if (od->sorted[pos].flags & SYM_IDX_FLAG_MATERIALIZED) {
> +               sym =3D symbols__find_start(dso__symbols(dso), od->sorted=
[pos].start);
> +       } else {
> +               dso_ondemand__get_ref(od, pos, &ref);
> +               mutex_unlock(dso__lock(dso));
> +               sym =3D sym_idx_ref__read(dso, &ref);
> +               mutex_lock(dso__lock(dso));
> +               sym =3D dso_ondemand__insert(dso, &ref, sym);
> +               od =3D dso_ondemand__put_ref(dso, &ref);
> +               mutex_unlock(dso__lock(dso));
> +               dso_ondemand__free(od);
> +               return sym;
> +       }
> +       mutex_unlock(dso__lock(dso));
> +       return sym;
> +}
> +
>  static int
>  dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *=
syms_ss,
>                        struct symsrc *runtime_ss, int kmodule, int dynsym=
)
> @@ -1626,6 +2529,29 @@ dso__load_sym_internal(struct dso *dso, struct map=
 *map, struct symsrc *syms_ss,
>         if (kmodule && adjust_kernel_syms)
>                 max_text_sh_offset =3D max_text_section(runtime_ss->elf, =
&runtime_ss->ehdr);
>
> +       /*
> +        * PPC64 ELFv1 function symbols need the eager loop's .opd descri=
ptor
> +        * translation. For symtabs, the selected and runtime sources can=
 differ.
> +        */
> +       if (symbol_conf.lazy_load_symbols && !dso__kernel(dso) && !kmodul=
e &&
> +           !syms_ss->opdsec && (dynsym || !runtime_ss->opdsec)) {
> +               int oret =3D 0;
> +
> +               /*
> +                * The index covers .symtab and .dynsym. If .symtab was
> +                * loaded eagerly, load .dynsym eagerly too.
> +                */
> +               if (!dynsym || !syms_ss->symtab)
> +                       oret =3D dso__build_ondemand_index(dso, syms_ss,
> +                                                        runtime_ss, dyns=
ym);
> +
> +               if (oret < 0)
> +                       return oret;
> +               /* If no index was built, load the DSO eagerly. */
> +               if (dso__ondemand(dso))
> +                       return 1;
> +       }
> +
>         curr_dso =3D dso__get(dso);
>         elf_symtab__for_each_symbol(syms, nr_syms, idx, sym) {
>                 struct symbol *f;
> diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-mi=
nimal.c
> index 0a71d1463952..848f4c37f881 100644
> --- a/tools/perf/util/symbol-minimal.c
> +++ b/tools/perf/util/symbol-minimal.c
> @@ -373,6 +373,15 @@ void symbol__elf_init(void)
>  {
>  }
>
> +struct symbol *dso__find_symbol_ondemand(struct dso *dso, u64 addr)
> +{
> +       return dso__find_symbol(dso, addr);
> +}
> +
> +void dso__materialize_symbols_ondemand(struct dso *dso __maybe_unused)
> +{
> +}
> +
>  bool filename__has_section(const char *filename __maybe_unused, const ch=
ar *sec __maybe_unused)
>  {
>         return false;
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index f590b69f9f01..c1b8387df6e3 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -690,6 +690,7 @@ struct symbol *dso__find_symbol_by_name(struct dso *d=
so, const char *name, size_
>
>  void dso__sort_by_name(struct dso *dso)
>  {
> +       dso__materialize_symbols_ondemand(dso);
>         mutex_lock(dso__lock(dso));
>         if (!dso__sorted_by_name(dso)) {
>                 size_t len =3D 0;
> @@ -1940,11 +1941,19 @@ int dso__load(struct dso *dso, struct map *map)
>                 }
>
>  #ifdef HAVE_LIBBFD_SUPPORT
> +#ifdef HAVE_LIBELF_SUPPORT
> +               if (is_reg && !symbol_conf.lazy_load_symbols)
> +#else
>                 if (is_reg)
> +#endif
>                         bfdrc =3D dso__load_bfd_symbols(dso, name);
>  #endif
>                 if (is_reg && bfdrc < 0)
>                         sirc =3D symsrc__init(ss, dso, name, symtab_type)=
;
> +#if defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBELF_SUPPORT)
> +               if (is_reg && symbol_conf.lazy_load_symbols && sirc < 0)
> +                       bfdrc =3D dso__load_bfd_symbols(dso, name);
> +#endif
>
>                 if (nsexit)
>                         nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
> diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.=
h
> index 37d35f42dcc1..434b6c51288b 100644
> --- a/tools/perf/util/symbol_conf.h
> +++ b/tools/perf/util/symbol_conf.h
> @@ -77,6 +77,7 @@ struct symbol_conf {
>                         no_buildid_mmap2,
>                         guest_code,
>                         lazy_load_kernel_maps,
> +                       lazy_load_symbols,
>                         keep_exited_threads,
>                         annotate_data_member,
>                         annotate_data_sample,
>
> --
> Git-157)
>
>
