Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB221494BB;
	Mon, 11 Nov 2024 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731345643; cv=none; b=IghBn4N9PzJevDEfcuq2CLx/5xzFK5L8Rx92+rwT7wkDhxgs5QMamzo3nSP4QpaaFQrBT7ryPnPA4pInSZDr9Y6BkVMi2jx1soM2Co0KJw3Y0F8MsXvYS66QYdRQBeE6ljqf2HzvsiR0i+2usJxvNh84akLnWQxjDguQfMT2gQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731345643; c=relaxed/simple;
	bh=4DUEL+rSYYf12R/CibCoObq0XtvCmhT0tDmdT/qglEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLkD+e4YWJ9M49CMEQaXoqMbPHWEONImdP7IxcMwh9FoCb44JS7V4vxK2JqJEiPNsu4LspWZ4E8809SEoCSCOVvwXLI9ocuMOPG1frcTBf6lbnon4c3HlHI8oKHk3AoKNkzcQ0YrqAHY9hQPKHlKDYT8csdDE74b4Cv0nxj1wK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVdEaWdE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVdEaWdE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A4DC4CECF;
	Mon, 11 Nov 2024 17:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731345643;
	bh=4DUEL+rSYYf12R/CibCoObq0XtvCmhT0tDmdT/qglEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iVdEaWdEeYjHfusoUr5YhUM0yBBW/7hqVXpoxHYgsyuUpyQPs0idY/y6ETChcfbh6
	 j4F8alVA7XOlwSW+isG8qjUNn92+P8qxAZsLR/PmGPB0Bq/0HO7Rr9fZLZfBxeT3HQ
	 oz76tQmemCWLptg3ZKvr0d29xbqxLR7Ho4krXDZ7XKG9/CTnSRXce0RSOllWsJefYH
	 LdQVoGCeFDNKfPiaVq0B2KXlPbf9rH/3QQUVX225P+IkUYDT+b49+Y/jDARBZqeoFH
	 bIvkuJPVEdgF075nvNVxBTuS7rJijy1Fqx61DYHBxno8CqQDFo/l4MB39QPj1R8Vaq
	 FHSpmpYH+BMBQ==
Date: Mon, 11 Nov 2024 14:20:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	"Steinar H. Gunderson" <sesse@google.com>
Subject: Re: [PATCH 2/3] perf disasm: Define stubs for the LLVM and capstone
 disassemblers
Message-ID: <ZzI85r8c0mlw9ATr@x1>
References: <20241111151734.1018476-1-acme@kernel.org>
 <20241111151734.1018476-3-acme@kernel.org>
 <CAP-5=fWWy8hAT+p3uO5S1sOhJhvP-tOf8fZ4xCC1DkY9Wd18ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWWy8hAT+p3uO5S1sOhJhvP-tOf8fZ4xCC1DkY9Wd18ag@mail.gmail.com>

On Mon, Nov 11, 2024 at 08:23:49AM -0800, Ian Rogers wrote:
> On Mon, Nov 11, 2024 at 7:18 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > This reduces the number of ifdefs in the main symbol__disassemble()
> > method and paves the way for allowing the user to configure the
> > disassemblers of preference.
> >
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Steinar H. Gunderson <sesse@google.com>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks

> Style nit below.
> 
> > ---
> >  tools/perf/util/disasm.c | 40 ++++++++++++++++++++++++++++++++--------
> >  1 file changed, 32 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> > index 36cf61602c17fe69..83df1da20a7b16cd 100644
> > --- a/tools/perf/util/disasm.c
> > +++ b/tools/perf/util/disasm.c
> > @@ -1422,6 +1422,13 @@ read_symbol(const char *filename, struct map *map, struct symbol *sym,
> >         free(buf);
> >         return NULL;
> >  }
> > +#else // defined(HAVE_LIBCAPSTONE_SUPPORT) || defined(HAVE_LIBLLVM_SUPPORT)
> > +static void symbol__disassembler_missing(const char *disassembler, const char *filename,
> > +                                        struct symbol *sym)
> > +{
> > +       pr_debug("The %s disassembler isn't linked in for %s in %s\n",
> > +                disassembler, sym->name, filename);
> > +}
> 
> I can see why you're doing this but it seems overkill to have a
> function just for the sake of 1 pr_debug. The #ifdefs make this look
> like it could be doing more. Perhaps the style:

Well, I wrote it like that, then had to cut'n't paste that thing to use
it, ended up with two callers, three when we make objdump a build time
selection, unsure if we will end up with more disassemblers.

- Arnaldo

> ```
> static int symbol__disassemble_capstone(char *filename, struct symbol
> *sym, struct annotate_args *args)
> {
> #ifndef HAVE_LIBCAPSTONE_SUPPORT
>     pr_debug("The capstone disassembler isn't linked in for %s in
> %s\n", sym->name, filename);
>     return -1;
> #else
>     ...
> #endif
> }
> ```
> Would be preferable as the #ifdef's scope is more limited, you don't
> need to hunt around for 1 of 3 functions, etc.
> 
> Thanks,
> Ian
> 
> >  #endif
> >
> >  #ifdef HAVE_LIBCAPSTONE_SUPPORT
> > @@ -1715,7 +1722,20 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
> >         count = -1;
> >         goto out;
> >  }
> > -#endif
> > +#else // HAVE_LIBCAPSTONE_SUPPORT
> > +static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
> > +                                       struct annotate_args *args)
> > +       symbol__disassembler_missing("capstone", filename, sym);
> > +       return -1;
> > +}
> > +
> > +static int symbol__disassemble_capstone_powerpc(char *filename, struct symbol *sym,
> > +                                               struct annotate_args *args __maybe_unused)
> > +{
> > +       symbol__disassembler_missing("capstone powerpc", filename, sym);
> > +       return -1;
> > +}
> > +#endif // HAVE_LIBCAPSTONE_SUPPORT
> >
> >  static int symbol__disassemble_raw(char *filename, struct symbol *sym,
> >                                         struct annotate_args *args)
> > @@ -1983,7 +2003,14 @@ static int symbol__disassemble_llvm(char *filename, struct symbol *sym,
> >         free(line_storage);
> >         return ret;
> >  }
> > -#endif
> > +#else // HAVE_LIBLLVM_SUPPORT
> > +static int symbol__disassemble_llvm(char *filename, struct symbol *sym,
> > +                                   struct annotate_args *args __maybe_unused)
> > +{
> > +       symbol__disassembler_missing("LLVM", filename, sym);
> > +       return -1;
> > +}
> > +#endif // HAVE_LIBLLVM_SUPPORT
> >
> >  /*
> >   * Possibly create a new version of line with tabs expanded. Returns the
> > @@ -2242,24 +2269,21 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
> >                         err = symbol__disassemble_raw(symfs_filename, sym, args);
> >                         if (err == 0)
> >                                 goto out_remove_tmp;
> > -#ifdef HAVE_LIBCAPSTONE_SUPPORT
> > +
> >                         err = symbol__disassemble_capstone_powerpc(symfs_filename, sym, args);
> >                         if (err == 0)
> >                                 goto out_remove_tmp;
> > -#endif
> >                 }
> >         }
> >
> > -#ifdef HAVE_LIBLLVM_SUPPORT
> >         err = symbol__disassemble_llvm(symfs_filename, sym, args);
> >         if (err == 0)
> >                 goto out_remove_tmp;
> > -#endif
> > -#ifdef HAVE_LIBCAPSTONE_SUPPORT
> > +
> >         err = symbol__disassemble_capstone(symfs_filename, sym, args);
> >         if (err == 0)
> >                 goto out_remove_tmp;
> > -#endif
> > +
> >         err = symbol__disassemble_objdump(symfs_filename, sym, args);
> >
> >  out_remove_tmp:
> > --
> > 2.47.0
> >
