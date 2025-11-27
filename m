Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F722405E1;
	Thu, 27 Nov 2025 20:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764276829; cv=none; b=sp5+rhJQHHwghYHJxy4VGPAQSPQAxb0xdfV2D2CRFmpcrq6nPPGL/uaFnGCvZtheha3Z8w2Q1Wu/M9SPi72hfSqY5Go3omb1vdInXvHDCwzW9JTevxaBc185/qSAakR7jVB829eM+rz/tBZmj6qKiWg2sBUsrUXUuhanXCL71+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764276829; c=relaxed/simple;
	bh=IuhDOHu2EoOXQfZUVzNRybbvfmwZw/OmbNTp4tl57bM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIA5YGDUeL6fd/gsASHBLBHKtBbHXniu5InJRJWWyhU5ijdYKOlZ2yo3tAS8RMAG87kaoiPdx0CP/IH+pBnTyYcymMjiei0YwZfzh0ChF3ulQHAbwhAgLRkT1lOh28pRTwRpSGt+ahf19hQxmWs1iWl46hv0BcXWRSysF52m7Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZg9tppb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZg9tppb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A635FC4CEF8;
	Thu, 27 Nov 2025 20:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764276828;
	bh=IuhDOHu2EoOXQfZUVzNRybbvfmwZw/OmbNTp4tl57bM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GZg9tppb+CrGzGNrvPQIUhkwAuSgQDaBFaC4iActOjdOsEKpwJm426cQnaBr+t7hT
	 TVcg6QO8TFeL4zGKAaR9XY8OJJJ5iC8fV0R95Gc+ULclbDMdM8PO1QElDptvaS4CrB
	 ZXwnsPAIcdwH7igOHQlDA3zDhZEIFTh4mipX5xTIQMRHEW/aHse9WnuAeJNBxQBo2W
	 WdKF/S4XuLOuL8u7b5/rQf3mQu3TyYIcVgup/UOxkCfYM3S76yYKKTgpy82aBuP2s1
	 ZH0L7mLa5k8hvEjZBkpRwrDq+SqIIGXdS/BUsX45GtJ/kVIaweuAjXik6iS1pMlKVt
	 KJQ25wG2k3w7g==
Date: Thu, 27 Nov 2025 12:53:46 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Tony Jones <tonyj@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1] perf addr2line: Add a libdw implementation
Message-ID: <aSi6Wjm2tkuNQEXD@google.com>
References: <20251122093934.94971-1-irogers@google.com>
 <aSdGq2K6TRMyG009@google.com>
 <CAP-5=fULHMCw=b0PuN07r=aAjoamb+MNSNrHM3nyHPYM2DGkow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fULHMCw=b0PuN07r=aAjoamb+MNSNrHM3nyHPYM2DGkow@mail.gmail.com>

On Thu, Nov 27, 2025 at 03:43:34AM -0800, Ian Rogers wrote:
> On Wed, Nov 26, 2025 at 10:27 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Sat, Nov 22, 2025 at 01:39:34AM -0800, Ian Rogers wrote:
> > > Add an implementation of addr2line that uses libdw. Other addr2line
> > > implementations or, in the case of forking addr2line, slow. Add an
> > > implementation that caches the libdw information in the dso and uses
> > > it to find the file and line number information.
> 
> Thanks James and Namhyung for the reviews! I agree with James' comment
> about a typo in the commit message.
> 
> > My concern is the limit in the open file descriptors in case the data
> > touched a lot of different libraries.  The DSO code has some logic to
> > deal with it but I'm not sure if we can share that since libdw seems to
> > want to own the FD.
> 
> The code opens the FD:
> 
> +               fd = open(dso_name, O_RDONLY);
> +               if (fd < 0)
> +                       return 0;
> +
> +               dwfl = dwfl_begin(&offline_callbacks);
> +               if (!dwfl) {
> +                       close(fd);
> +                       return 0;
> +               }
> 
> It then uses the FD and closes it (the close is hidden in libdw itself):
> 
> +               /*
> +                * If the report is successful, the file descriptor fd
> is consumed
> +                * and closed by the Dwfl. If not, it is not closed.
> +                */
> +               mod = dwfl_report_offline(dwfl, dso_name, dso_name, fd);
> 
> So it is possible we exhaust all the file descriptors if there are
> multiple concurrent calls to libdw__addr2line and every dso has
> missing libdw dwfl data... but because the open/close are close
> together and that 1 FD is say small to the FDs needed for the
> cmd__addr2line, I don't think it is a problem we need to specifically
> handle. Were the FD kept open until the dso was deleted, I'd agree
> with you.

Oh, I thought libdwfl keeps the FD open until you call dwfl_end().
Are you sure the dwfl function would close the FD?  I've quickly checked
the code, but it doesn't seem to close if you pass an FD manually.

Thanks,
Namhyung

> 
> > Also, have you checked if this generates the exactly same output with
> > other implementations?
> 
> So the code passes `perf test` and I was checking functionality with
> perf annotate, top, etc. What I saw looked good, but it may not have
> been exhaustive. I didn't specifically create a test that compares the
> output of the different addr2line implementations. Such a test would
> be possible, it's not something we've done elsewhere.
> 
> Thanks,
> Ian
> 
> > Thanks,
> > Namhyung
> >
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/Build     |   1 +
> > >  tools/perf/util/dso.c     |   2 +
> > >  tools/perf/util/dso.h     |  11 +++
> > >  tools/perf/util/libdw.c   | 136 ++++++++++++++++++++++++++++++++++++++
> > >  tools/perf/util/libdw.h   |  60 +++++++++++++++++
> > >  tools/perf/util/srcline.c |   5 ++
> > >  6 files changed, 215 insertions(+)
> > >  create mode 100644 tools/perf/util/libdw.c
> > >  create mode 100644 tools/perf/util/libdw.h
> > >
> > > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > > index 1c2a43e1dc68..2bed6274e248 100644
> > > --- a/tools/perf/util/Build
> > > +++ b/tools/perf/util/Build
> > > @@ -224,6 +224,7 @@ perf-util-$(CONFIG_LIBDW) += dwarf-regs-powerpc.o
> > >  perf-util-$(CONFIG_LIBDW) += dwarf-regs-x86.o
> > >  perf-util-$(CONFIG_LIBDW) += debuginfo.o
> > >  perf-util-$(CONFIG_LIBDW) += annotate-data.o
> > > +perf-util-$(CONFIG_LIBDW) += libdw.o
> > >
> > >  perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
> > >  perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind-local.o
> > > diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> > > index 344e689567ee..06980844c014 100644
> > > --- a/tools/perf/util/dso.c
> > > +++ b/tools/perf/util/dso.c
> > > @@ -32,6 +32,7 @@
> > >  #include "string2.h"
> > >  #include "vdso.h"
> > >  #include "annotate-data.h"
> > > +#include "libdw.h"
> > >
> > >  static const char * const debuglink_paths[] = {
> > >       "%.0s%s",
> > > @@ -1605,6 +1606,7 @@ void dso__delete(struct dso *dso)
> > >       auxtrace_cache__free(RC_CHK_ACCESS(dso)->auxtrace_cache);
> > >       dso_cache__free(dso);
> > >       dso__free_a2l(dso);
> > > +     dso__free_a2l_libdw(dso);
> > >       dso__free_symsrc_filename(dso);
> > >       nsinfo__zput(RC_CHK_ACCESS(dso)->nsinfo);
> > >       mutex_destroy(dso__lock(dso));
> > > diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> > > index f8ccb9816b89..4aee23775054 100644
> > > --- a/tools/perf/util/dso.h
> > > +++ b/tools/perf/util/dso.h
> > > @@ -268,6 +268,7 @@ DECLARE_RC_STRUCT(dso) {
> > >       const char       *short_name;
> > >       const char       *long_name;
> > >       void             *a2l;
> > > +     void             *a2l_libdw;
> > >       char             *symsrc_filename;
> > >  #if defined(__powerpc__)
> > >       void            *dwfl;                  /* DWARF debug info */
> > > @@ -334,6 +335,16 @@ static inline void dso__set_a2l(struct dso *dso, void *val)
> > >       RC_CHK_ACCESS(dso)->a2l = val;
> > >  }
> > >
> > > +static inline void *dso__a2l_libdw(const struct dso *dso)
> > > +{
> > > +     return RC_CHK_ACCESS(dso)->a2l_libdw;
> > > +}
> > > +
> > > +static inline void dso__set_a2l_libdw(struct dso *dso, void *val)
> > > +{
> > > +     RC_CHK_ACCESS(dso)->a2l_libdw = val;
> > > +}
> > > +
> > >  static inline unsigned int dso__a2l_fails(const struct dso *dso)
> > >  {
> > >       return RC_CHK_ACCESS(dso)->a2l_fails;
> > > diff --git a/tools/perf/util/libdw.c b/tools/perf/util/libdw.c
> > > new file mode 100644
> > > index 000000000000..c4331fa8e1a3
> > > --- /dev/null
> > > +++ b/tools/perf/util/libdw.c
> > > @@ -0,0 +1,136 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +#include "dso.h"
> > > +#include "libdw.h"
> > > +#include "srcline.h"
> > > +#include "symbol.h"
> > > +#include "dwarf-aux.h"
> > > +#include <fcntl.h>
> > > +#include <unistd.h>
> > > +#include <elfutils/libdwfl.h>
> > > +
> > > +void dso__free_a2l_libdw(struct dso *dso)
> > > +{
> > > +     Dwfl *dwfl = dso__a2l_libdw(dso);
> > > +
> > > +     if (dwfl) {
> > > +             dwfl_end(dwfl);
> > > +             dso__set_a2l_libdw(dso, NULL);
> > > +     }
> > > +}
> > > +
> > > +int libdw__addr2line(const char *dso_name, u64 addr,
> > > +                  char **file, unsigned int *line_nr,
> > > +                  struct dso *dso, bool unwind_inlines,
> > > +                  struct inline_node *node, struct symbol *sym)
> > > +{
> > > +     static const Dwfl_Callbacks offline_callbacks = {
> > > +             .find_debuginfo = dwfl_standard_find_debuginfo,
> > > +             .section_address = dwfl_offline_section_address,
> > > +             .find_elf = dwfl_build_id_find_elf,
> > > +     };
> > > +     Dwfl *dwfl = dso__a2l_libdw(dso);
> > > +     Dwfl_Module *mod;
> > > +     Dwfl_Line *dwline;
> > > +     Dwarf_Addr bias;
> > > +     const char *src;
> > > +     int lineno;
> > > +
> > > +     if (!dwfl) {
> > > +             /*
> > > +              * Initialize Dwfl session.
> > > +              * We need to open the DSO file to report it to libdw.
> > > +              */
> > > +             int fd;
> > > +
> > > +             fd = open(dso_name, O_RDONLY);
> > > +             if (fd < 0)
> > > +                     return 0;
> > > +
> > > +             dwfl = dwfl_begin(&offline_callbacks);
> > > +             if (!dwfl) {
> > > +                     close(fd);
> > > +                     return 0;
> > > +             }
> > > +
> > > +             /*
> > > +              * If the report is successful, the file descriptor fd is consumed
> > > +              * and closed by the Dwfl. If not, it is not closed.
> > > +              */
> > > +             mod = dwfl_report_offline(dwfl, dso_name, dso_name, fd);
> > > +             if (!mod) {
> > > +                     dwfl_end(dwfl);
> > > +                     close(fd);
> > > +                     return 0;
> > > +             }
> > > +
> > > +             dwfl_report_end(dwfl, /*removed=*/NULL, /*arg=*/NULL);
> > > +             dso__set_a2l_libdw(dso, dwfl);
> > > +     } else {
> > > +             /* Dwfl session already initialized, get module for address. */
> > > +             mod = dwfl_addrmodule(dwfl, addr);
> > > +     }
> > > +
> > > +     if (!mod)
> > > +             return 0;
> > > +
> > > +     /* Find source line information for the address. */
> > > +     dwline = dwfl_module_getsrc(mod, addr);
> > > +     if (!dwline)
> > > +             return 0;
> > > +
> > > +     /* Get line information. */
> > > +     src = dwfl_lineinfo(dwline, &addr, &lineno, /*col=*/NULL, /*mtime=*/NULL, /*length=*/NULL);
> > > +
> > > +     if (file)
> > > +             *file = src ? strdup(src) : NULL;
> > > +     if (line_nr)
> > > +             *line_nr = lineno;
> > > +
> > > +     /* Optionally unwind inline function call chain. */
> > > +     if (unwind_inlines && node && src) {
> > > +             Dwarf_Die *cudie = dwfl_module_addrdie(mod, addr, &bias);
> > > +             Dwarf_Die *scopes = NULL;
> > > +             int nscopes;
> > > +
> > > +             if (!cudie)
> > > +                     return 1;
> > > +
> > > +             nscopes = die_get_scopes(cudie, addr, &scopes);
> > > +             if (nscopes > 0) {
> > > +                     int i;
> > > +                     const char *call_file = src;
> > > +                     unsigned int call_line = lineno;
> > > +
> > > +                     for (i = 0; i < nscopes; i++) {
> > > +                             Dwarf_Die *die = &scopes[i];
> > > +                             struct symbol *inline_sym;
> > > +                             char *srcline = NULL;
> > > +                             int tag = dwarf_tag(die);
> > > +
> > > +                             /* We are interested in inlined subroutines. */
> > > +                             if (tag != DW_TAG_inlined_subroutine &&
> > > +                                 tag != DW_TAG_subprogram)
> > > +                                     continue;
> > > +
> > > +                             inline_sym = new_inline_sym(dso, sym, dwarf_diename(die));
> > > +
> > > +                             if (call_file)
> > > +                                     srcline = srcline_from_fileline(call_file, call_line);
> > > +
> > > +                             inline_list__append(inline_sym, srcline, node);
> > > +
> > > +                             /* Update call site for next level. */
> > > +                             if (tag == DW_TAG_inlined_subroutine) {
> > > +                                     call_file = die_get_call_file(die);
> > > +                                     call_line = die_get_call_lineno(die);
> > > +                             } else {
> > > +                                     /* Reached the root subprogram. */
> > > +                                     break;
> > > +                             }
> > > +                     }
> > > +                     free(scopes);
> > > +             }
> > > +     }
> > > +
> > > +     return 1;
> > > +}
> > > diff --git a/tools/perf/util/libdw.h b/tools/perf/util/libdw.h
> > > new file mode 100644
> > > index 000000000000..0f8d7b4a11a5
> > > --- /dev/null
> > > +++ b/tools/perf/util/libdw.h
> > > @@ -0,0 +1,60 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef PERF_LIBDW_H
> > > +#define PERF_LIBDW_H
> > > +
> > > +#include <linux/types.h>
> > > +
> > > +struct dso;
> > > +struct inline_node;
> > > +struct symbol;
> > > +
> > > +#ifdef HAVE_LIBDW_SUPPORT
> > > +/*
> > > + * libdw__addr2line - Convert address to source location using libdw
> > > + * @dso_name: Name of the DSO
> > > + * @addr: Address to resolve
> > > + * @file: Pointer to return filename (caller must free)
> > > + * @line_nr: Pointer to return line number
> > > + * @dso: The dso struct
> > > + * @unwind_inlines: Whether to unwind inline function calls
> > > + * @node: Inline node list to append to
> > > + * @sym: The symbol associated with the address
> > > + *
> > > + * This function initializes a Dwfl context for the DSO if not already present,
> > > + * finds the source line information for the given address, and optionally
> > > + * resolves inline function call chains.
> > > + *
> > > + * Returns 1 on success (found), 0 on failure (not found).
> > > + */
> > > +int libdw__addr2line(const char *dso_name, u64 addr, char **file,
> > > +                  unsigned int *line_nr, struct dso *dso,
> > > +                  bool unwind_inlines, struct inline_node *node,
> > > +                  struct symbol *sym);
> > > +
> > > +/*
> > > + * dso__free_a2l_libdw - Free libdw resources associated with the DSO
> > > + * @dso: The dso to free resources for
> > > + *
> > > + * This function cleans up the Dwfl context used for addr2line lookups.
> > > + */
> > > +void dso__free_a2l_libdw(struct dso *dso);
> > > +
> > > +#else /* HAVE_LIBDW_SUPPORT */
> > > +
> > > +static inline int libdw__addr2line(const char *dso_name __maybe_unused,
> > > +                                u64 addr __maybe_unused, char **file __maybe_unused,
> > > +                                unsigned int *line_nr __maybe_unused,
> > > +                                struct dso *dso __maybe_unused,
> > > +                                bool unwind_inlines __maybe_unused,
> > > +                                struct inline_node *node __maybe_unused,
> > > +                                struct symbol *sym __maybe_unused)
> > > +{
> > > +     return 0;
> > > +}
> > > +
> > > +static inline void dso__free_a2l_libdw(struct dso *dso __maybe_unused)
> > > +{
> > > +}
> > > +#endif /* HAVE_LIBDW_SUPPORT */
> > > +
> > > +#endif /* PERF_LIBDW_H */
> > > diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> > > index 27c0966611ab..4b456c4d4138 100644
> > > --- a/tools/perf/util/srcline.c
> > > +++ b/tools/perf/util/srcline.c
> > > @@ -6,6 +6,7 @@
> > >  #include "libbfd.h"
> > >  #include "llvm.h"
> > >  #include "symbol.h"
> > > +#include "libdw.h"
> > >
> > >  #include <inttypes.h>
> > >  #include <string.h>
> > > @@ -120,6 +121,10 @@ static int addr2line(const char *dso_name, u64 addr, char **file, unsigned int *
> > >  {
> > >       int ret;
> > >
> > > +     ret = libdw__addr2line(dso_name, addr, file, line_nr, dso, unwind_inlines, node, sym);
> > > +     if (ret > 0)
> > > +             return ret;
> > > +
> > >       ret = llvm__addr2line(dso_name, addr, file, line_nr, dso, unwind_inlines, node, sym);
> > >       if (ret > 0)
> > >               return ret;
> > > --
> > > 2.52.0.rc2.455.g230fcf2819-goog
> > >
