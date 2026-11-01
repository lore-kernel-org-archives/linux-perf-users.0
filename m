Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793498312;
	b=FCaVAfR9U9IANGHWZynGZOjjmGeGj+ny1aYm2Sf9epfKzFNGXrUMSnjnbjSRSDadYxzi
	 94yK+coWrKBw9UzjasZr86LIPf5aslJ/FoKxTyyfBk2c/89QxIhN0H+K4ZpISq19aVfq5
	 cskl89GU+Gq7+ZyqjSLN29TtMQg+g9DHJODFT9mwd4uiIBKfX66Br3u0Hz5sjWq5w5LTL
	 jJKL3YC9BePU7N329U6a6Dyn31QYCWegbosz9PvzBmAr1/G057qMi0lLcGW04nHKEU9hI
	 LKL9pCmnuigFZiZp1K++xNdpcedoP0eedo73HD/JPMpnmFbafyn2pTWKrjQYWcLu5Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793498312;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=9vSZLsyhSYt+F+Q2kf88Wa5aKGMcjvWJAR2b3rMf3yY=;
	b=cURcQW07wINZaQqh3QBJ1xVOr4OsnDa5Xt5Sejd6A8h5QBCUqPopS57Bz1KAbdz6dN0J
	 Sg4qNn2EUE2stcEmmR5pegLnpZD0qABbrDR25K0BkgNO0u+QAFClAb5/3sgmanN29nDSj
	 tkcF93k0abo/9jchrYkOQNN1u2KZZsnVhvHumJfDgOObH5HSa68yJZT4wvs0VR99o75BG
	 C2nbzbOFiFh+WMm8vCfvTCr/W4l6ZeqpFAJ9n8FIUQshHrbjOVr6dnlX8j3fJM/DOYaat
	 Zp1fVACbDEkwjGIBvCuU/Ccz/2jKlGLDbhPKeRKTmi/N1cenacvhMrbZW1hMOQg0ldg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IMM65WKV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DE1606A324;
	Sun,  1 Nov 2026 01:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IMM65WKV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F651F000C1;
	Sun,  1 Nov 2026 01:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793498311;
	bh=9vSZLsyhSYt+F+Q2kf88Wa5aKGMcjvWJAR2b3rMf3yY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IMM65WKVDHDB1r8POHrabcAQGRQJK2lcNAvogctKzHGK+3dXwj3uZl+lVlmClWv8d
	 ZdfEtP6RB2g/poXw8dZC38lVgY7DuXMu3SRoLBoiOqLNLEv4YxFyYs4+ho0kljIkPb
	 5+JXNeFcZMpUQCVSrrg5I/wCwB9gzpC+cPzrCwm90QIoivNb6LtHQqXm41LPxU1Sbl
	 gax3KXgDDrTSM0y1tFl2ziX3C5LggtVId2qM6IMgnVXSO8FtKz/uOZorD/vtvL1L/+
	 GHK35OmQIvlDHLCBZTVyoJEgqR8Oro5fQGC1Oxvq9xcayK1micJOyBTeEgGNLnZFQW
	 A6cE1sCAggw6w==
Date: Sat, 31 Oct 2026 18:58:29 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: haghdoost@uber.com, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andriin@fb.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/5] perf script: Add --lazy-load-symbols to load
 symbol names lazily
Message-ID: <auacxQZKtlFa9Pc3@z2>
References: <20261028-perf-symbol-memory-send-v6-0-7e90415f0101@uber.com>
 <20261028-perf-symbol-memory-send-v6-4-7e90415f0101@uber.com>
 <CAP-5=fU9Du9cCge2aTm10ejtwBKX1THQpm=h7EMR=WVQLww6DA@mail.gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU9Du9cCge2aTm10ejtwBKX1THQpm=h7EMR=WVQLww6DA@mail.gmail.com>

On Fri, Oct 30, 2026 at 08:55:55AM -0700, Ian Rogers wrote:
> On Wed, Oct 28, 2026 at 4:42 PM Alireza Haghdoost via B4 Relay
> <devnull+haghdoost.uber.com@kernel.org> wrote:
> >
> > From: Alireza Haghdoost <haghdoost@uber.com>
> >
> > This patch adds the --lazy-load-symbols option to perf script. With this
> > option, perf reads the name of a userspace ELF symbol only when a lookup
> > returns the symbol. Eager loading remains the default.
> >
> > perf script loads the ELF symbol table of every DSO that appears in a
> > sample and keeps each symbol, with its demangled name, until exit. Most
> > of those symbols are never sampled, and their names take most of the
> > memory. On a large profile this makes symbol loading the main memory
> > cost of perf script, and in a memory-constrained cgroup an OOM kill.
> >
> > With the option, the loader still creates every symbol, so end fixup,
> > duplicate selection, PLT synthesis and IFUNC marking work as before. But
> > it keeps the file offset of each name instead of copying and demangling
> > the name.
> >
> > The name pointer and the offset share a union in struct symbol, and
> > SYMBOL_FLAG_LAZY_NAME says which one it holds. The dso__find_symbol*()
> > functions, dso__first_symbol() and dso__last_symbol() load the name of
> > the symbol they return, and code that walks the symbols of a DSO gets
> > them with dso__named_symbols(), which loads every name. So does
> > dso__sort_by_name() before it builds the name-sorted array. A symbol
> > whose name cannot be read is named "[unknown]" instead of being deleted,
> > since address lookups search the symbol tree without the DSO lock. Address
> > lookups return NULL for it, so perf script prints it as an address
> > without a symbol.
> >
> > During loading, perf reads only the names that it needs:
> >
> > - the names of aliases that duplicate selection can tell apart only by
> >   name,
> > - the names of IFUNC symbols, which PLT synthesis uses to name the
> >   IRELATIVE slots.
> >
> > The loader also skips a .dynsym entry that copies a lazy .symtab symbol.
> > Duplicate selection would drop the entry, but only after it reads both
> > names, and most exported symbols are such copies.
> >
> > Other names are read with pread() from the file that dso__get_filename()
> > returns for dso__symtab_type(). The file is open only while perf reads
> > the names, so no descriptor stays open per DSO.
> >
> > The kernel, modules, PPC64 .opd and .gnu_debugdata, whose symbol table
> > is a temporary file, still load names eagerly.
> >
> > On a perf script run over a 45,073-sample callchain profile of a large
> > C++ service, where eager loading creates about 1M symbols, lazy loading
> > reduces max RSS from 341 MiB to 154 MiB and time from 3.2 to 1.5
> > seconds, with identical output.
> >
> > Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>
> > ---
> >  tools/perf/Documentation/perf-script.txt |   7 +
> >  tools/perf/builtin-script.c              |   2 +
> >  tools/perf/ui/browsers/map.c             |   2 +-
> >  tools/perf/util/dso.c                    |   2 +-
> >  tools/perf/util/dso.h                    |   3 +-
> >  tools/perf/util/symbol-elf.c             | 251 +++++++++++++++++++++++++++++--
> >  tools/perf/util/symbol-minimal.c         |   6 +
> >  tools/perf/util/symbol.c                 | 113 +++++++++++++-
> >  tools/perf/util/symbol.h                 |  29 +++-
> >  tools/perf/util/symbol_conf.h            |   1 +
> >  10 files changed, 393 insertions(+), 23 deletions(-)
> >
> > diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> > index f0228e784ced..57b3533e6c2a 100644
> > --- a/tools/perf/Documentation/perf-script.txt
> > +++ b/tools/perf/Documentation/perf-script.txt
> > @@ -343,6 +343,13 @@ include::itrace.txt[]
> >
> >          Default: 127
> >
> > +--lazy-load-symbols::
> > +       Read and demangle userspace ELF symbol names only when perf needs
> > +       them. By default, perf reads every symbol name from each binary
> > +       referenced by a sample. This option reduces memory use and usually
> > +       improves performance when samples reference only a small fraction
> > +       of a large binary's symbols.
> > +
> 
> Won't it also improve performance if you say link against a library
> but then only use a portion of that library's contents? I'm thinking
> this option should really be the default, requiring people to opt out.
> I may even be tempted to hide this flag so that we have the option
> later of just always using lazy loading. Since the flag isn't a huge
> cost in the code, and non-lazy loading is needed in other contexts,
> perhaps we can make the lazy loading the default behavior and have the
> flag here be say, "--eager-loading" ?

Agreed on making it default.  I'm not sure what's the case that needs
eager loading.  We can change the code to load all symbols just before
it (oh, it seems the patch already handles the cases) then no option
would be needed. :)

> 
> >  --ns::
> >         Use 9 decimal places when displaying time (i.e. show the nanoseconds)
> >
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index b6691ebb1b4e..88aaf9cfd132 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -4287,6 +4287,8 @@ int cmd_script(int argc, const char **argv)
> >                      "Set the maximum stack depth when parsing the callchain, "
> >                      "anything beyond the specified depth will be ignored. "
> >                      "Default: kernel.perf_event_max_stack or " __stringify(PERF_MAX_STACK_DEPTH)),
> > +       OPT_BOOLEAN(0, "lazy-load-symbols", &symbol_conf.lazy_load_symbols,
> > +                   "Read symbol names only when they are needed"),
> >         OPT_BOOLEAN(0, "reltime", &reltime, "Show time stamps relative to start"),
> >         OPT_BOOLEAN(0, "deltatime", &deltatime, "Show time stamps relative to previous event"),
> >         OPT_BOOLEAN('I', "show-info", &show_full_info,
> > diff --git a/tools/perf/ui/browsers/map.c b/tools/perf/ui/browsers/map.c
> > index 075a575cdc5d..ef8f75699a07 100644
> > --- a/tools/perf/ui/browsers/map.c
> > +++ b/tools/perf/ui/browsers/map.c
> > @@ -108,7 +108,7 @@ int map__browse(struct map *map)
> >  {
> >         struct map_browser mb = {
> >                 .b = {
> > -                       .entries = dso__symbols(map__dso(map)),
> > +                       .entries = dso__named_symbols(map__dso(map)),
> >                         .refresh = ui_browser__rb_tree_refresh,
> >                         .seek    = ui_browser__rb_tree_seek,
> >                         .write   = map_browser__write,
> > diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> > index ce98613868e7..f41abf442476 100644
> > --- a/tools/perf/util/dso.c
> > +++ b/tools/perf/util/dso.c
> > @@ -2013,7 +2013,7 @@ size_t dso__fprintf(struct dso *dso, FILE *fp)
> >         ret += fprintf(fp, "%sloaded, ", dso__loaded(dso) ? "" : "NOT ");
> >         ret += dso__fprintf_buildid(dso, fp);
> >         ret += fprintf(fp, ")\n");
> > -       for (nd = rb_first_cached(dso__symbols(dso)); nd; nd = rb_next(nd)) {
> > +       for (nd = rb_first_cached(dso__named_symbols(dso)); nd; nd = rb_next(nd)) {
> >                 struct symbol *pos = rb_entry(nd, struct symbol, rb_node);
> >                 ret += symbol__fprintf(pos, fp);
> >         }
> > diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> > index 3329f417810c..4a60c883cc37 100644
> > --- a/tools/perf/util/dso.h
> > +++ b/tools/perf/util/dso.h
> > @@ -369,7 +369,7 @@ int dso_id__cmp(const struct dso_id *a, const struct dso_id *b);
> >   * @n: the 'struct rb_node *' to use as a temporary storage
> >   */
> >  #define dso__for_each_symbol(dso, pos, n)      \
> > -       symbols__for_each_entry(dso__symbols(dso), pos, n)
> > +       symbols__for_each_entry(dso__named_symbols(dso), pos, n)
> >
> >  static inline void *dso__a2l(const struct dso *dso)
> >  {
> > @@ -831,6 +831,7 @@ char *dso__filename_with_chroot(const struct dso *dso, const char *filename);
> >  bool dso__sorted_by_name(const struct dso *dso);
> >  void dso__set_sorted_by_name(struct dso *dso);
> >  void dso__sort_by_name(struct dso *dso);
> > +struct rb_root_cached *dso__named_symbols(struct dso *dso);
> >
> >  int dso__swap_init(struct dso *dso, unsigned char eidata);
> >
> > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> > index 1e2716c6af45..bce6c6aef20c 100644
> > --- a/tools/perf/util/symbol-elf.c
> > +++ b/tools/perf/util/symbol-elf.c
> > @@ -17,6 +17,7 @@
> >  #include "machine.h"
> >  #include "vdso.h"
> >  #include "debug.h"
> > +#include "namespaces.h"
> >  #include "util/copyfile.h"
> >  #include <linux/ctype.h>
> >  #include <linux/kernel.h>
> > @@ -348,7 +349,7 @@ static bool get_ifunc_name(Elf *elf, struct dso *dso, GElf_Ehdr *ehdr,
> >
> >         addr -= phdr.p_vaddr - phdr.p_offset;
> >
> > -       sym = dso__find_symbol_nocache(dso, addr);
> > +       sym = symbols__find(dso__symbols(dso), addr);
> >
> >         /* Expecting the address to be an IFUNC or IFUNC alias */
> >         if (!sym || sym->start != addr ||
> > @@ -629,7 +630,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
> >          * by symbols__fixup_end() to overlap .plt. Truncate it before adding
> >          * a symbol for .plt header.
> >          */
> > -       f = dso__find_symbol_nocache(dso, shdr_plt.sh_offset);
> > +       f = symbols__find(dso__symbols(dso), shdr_plt.sh_offset);
> >         if (f && f->start < shdr_plt.sh_offset && f->end > shdr_plt.sh_offset)
> >                 f->end = shdr_plt.sh_offset;
> >
> > @@ -1516,6 +1517,190 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
> >         return 0;
> >  }
> >
> > +static DEFINE_MUTEX(lazy_names_lock);
> 
> I'm curious if this is global just to avoid the expense of a mutex per
> symbol or it needs to be global? We have
> tools/perf/util/sharded_mutex.h as a way of doing a cheaper per object
> mutex, but perhaps the dso__lock works?

Probably.  dso__load() already takes the dso lock.

> 
> > +
> > +static char *read_name_at(int fd, u64 off)
> > +{
> > +       char small[256], *buf = NULL, *tmp;
> > +       size_t size = sizeof(small);
> > +       ssize_t n = pread(fd, small, size, off);
> > +
> > +       if (n > 0 && memchr(small, '\0', n))
> > +               return strdup(small);
> > +
> > +       while (n == (ssize_t)size) {
> > +               size *= 2;
> > +               tmp = realloc(buf, size);
> > +               if (!tmp)
> > +                       break;
> > +               buf = tmp;
> > +               n = pread(fd, buf, size, off);
> > +               if (n > 0 && memchr(buf, '\0', n))
> > +                       return buf;
> > +       }
> > +       free(buf);
> > +       return NULL;
> > +}
> > +
> > +static int load_symbol_names(struct dso *dso, int fd, struct symbol **syms, size_t nr)
> > +{
> > +       int err = 0;
> > +
> > +       for (size_t i = 0; i < nr; i++) {
> > +               char *name, *demangled;
> > +
> > +               if (!symbol__has_lazy_name(syms[i]))
> > +                       continue;

Nit: I'm hesitate to argue about naming, but it seems a bit confusing.
Why does it skip to load when it doesn't have a (lazy) name?  Probably
symbol__needs_lazy_name() would be a little better...?

Thanks,
Namhyung


> > +               name = read_name_at(fd, syms[i]->name_off);
> > +               if (!name) {
> > +                       pr_debug("%s: cannot read the symbol name at %#" PRIx64 "\n",
> > +                                dso__long_name(dso), syms[i]->name_off);
> > +                       err = -1;
> > +                       continue;
> > +               }
> > +               demangled = dso__demangle_sym(dso, /*kmodule=*/0, name);
> > +               if (demangled) {
> > +                       free(name);
> > +                       name = demangled;
> > +               }
> > +               symbol__set_lazy_name(syms[i], name);
> > +       }
> > +       return err;
> > +}
