Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED12013D2B2;
	Wed, 13 Nov 2024 19:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731526051; cv=none; b=M2Cg/xRdAzn9Bv4VgCqGlHkuzRWazhbqB5rNAq1oxhrGDvv5X/O1CVSJPL2Lufp/dM68GvSul4sG/GC24UQUQNx0g6RK0fHsoPnVC8QBT+8EO3zqRVYliSoJcSAAYDgMiEzYGggWO2VAR/fvnuIwLiWzS70Vo3xnblb2k8aPgY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731526051; c=relaxed/simple;
	bh=rxJJglloanPqMl/DvBWV+aKn5LsVg1OI/BMGuQRFYbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWlnOX0GsbbGlRbhG7+tOLg85zdqXmnOD0bFIIHzI1h5g7xL2WnMSu1/9zRqGCE54LL1OB+Y5GBkPtfRMZyJaMghyi+IBfvCjBrjfmYPCsadXsdNbxBPhd/PZWzvp+LRJk+SB+qXsSs9Qr2PwhxSa42LMb2utFgfPzTrruhNq/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRYeNPlq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRYeNPlq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E9DC4CEC3;
	Wed, 13 Nov 2024 19:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731526050;
	bh=rxJJglloanPqMl/DvBWV+aKn5LsVg1OI/BMGuQRFYbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fRYeNPlq+040r6wIJBXcT/Q3TcdKUy+8jtgjGkxYsRpHC5Ij+RU5BeDxnL/cv0Zta
	 0L1XzhW8HAneftXpaf2jz3gjgL41Ihd3UAnc2CybB8CMSpdNybREr4osbE84k5RORj
	 v/PXXmY9kMru/5aZ85j6uc+JGcLILbgywkNb/FHjVad0DDN3qhnsb6msW5rz5G52nm
	 x6npZgbqShZXr7ZonOxAUp+dDsuhhtqwFzf5EFJF72SZ9+wwpNsHsusuQX3tst3kEH
	 WFYTgBn/eaBw7a4ZgIfGHzPEQjYPRNa/FSCeDHntQ5kyaJVJISXuTdZhovRNr55tMl
	 nr2jolF17qMBQ==
Date: Wed, 13 Nov 2024 16:27:28 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	Arnaldo Melo <acme@redhat.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	"Steinar H. Gunderson" <sesse@google.com>
Subject: Re: [PATCH 2/3] perf disasm: Define stubs for the LLVM and capstone
 disassemblers
Message-ID: <ZzT9oHzYdfLZwmJ_@x1>
References: <20241111151734.1018476-1-acme@kernel.org>
 <20241111151734.1018476-3-acme@kernel.org>
 <B78FB6DF-24E9-4A3C-91C9-535765EC0E2A@ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B78FB6DF-24E9-4A3C-91C9-535765EC0E2A@ibm.com>

On Wed, Nov 13, 2024 at 03:24:08PM +0000, Aditya Bodkhe wrote:
> Hi Arnaldo
> I was testing this change in powerpc setup I see below compilation error
> 
> CC   util/disasm.o
> util/disasm.c: In function ‘symbol__disassemble_capstone’:
> util/disasm.c:1728:9: error: expected declaration specifiers before ‘symbol__disassembler_missing’
>  1728 |     symbol__disassembler_missing("capstone", filename, sym);
>    |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> util/disasm.c:1729:9: error: expected declaration specifiers before ‘return’
>  1729 |     return -1;
>    |     ^~~~~~
> util/disasm.c:1730:1: error: expected declaration specifiers before ‘}’ token
>  1730 | }
> 
> Below patch fixes the issue

Thanks, I've folded your fix into the patch since it is still in the
tmp.perf-tools-next branch, added a note to the patch to give you
and Masami credit, both sent fixes that I had to slightly adjust:

----
perf disasm: Define stubs for the LLVM and capstone disassemblers

This reduces the number of ifdefs in the main symbol__disassemble()
method and paves the way for allowing the user to configure the
disassemblers of preference.

Acked-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Steinar H. Gunderson <sesse@google.com>
Link: https://lore.kernel.org/r/20241111151734.1018476-3-acme@kernel.org
[ Applied fixes from Masami Hiramatsu and Aditya Bodkhe for when capstone devel files are not available ]
Link: https://lore.kernel.org/r/B78FB6DF-24E9-4A3C-91C9-535765EC0E2A@ibm.com
Link: https://lore.kernel.org/r/173145729034.2747044.453926054000880254.stgit@mhiramat.roam.corp.google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
----
 
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index df6c172c9c7f..da22b6ab9ecf 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -1724,7 +1724,8 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
>  }
>  #else // HAVE_LIBCAPSTONE_SUPPORT
>  static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
> -                    struct annotate_args *args)
> +                    struct annotate_args *args __maybe_unused)
> +{
>     symbol__disassembler_missing("capstone", filename, sym);
>     return -1;
>  }
> 
> I tried with tmp.perf-tools-next , I have tested the above patch fixes the compilation error
> 
> Thanks 
> Aditya Bodkhe
> > +
> > +static int symbol__disassemble_capstone_powerpc(char *filename, struct symbol *sym,
> > +						struct annotate_args *args __maybe_unused)
> > +{
> > +	symbol__disassembler_missing("capstone powerpc", filename, sym);
> > +	return -1;
> > +}
> > +#endif // HAVE_LIBCAPSTONE_SUPPORT
> > 
> > static int symbol__disassemble_raw(char *filename, struct symbol *sym,
> > 					struct annotate_args *args)
> > @@ -1983,7 +2003,14 @@ static int symbol__disassemble_llvm(char *filename, struct symbol *sym,
> > 	free(line_storage);
> > 	return ret;
> > }
> > -#endif
> > +#else // HAVE_LIBLLVM_SUPPORT
> > +static int symbol__disassemble_llvm(char *filename, struct symbol *sym,
> > +				    struct annotate_args *args __maybe_unused)
> > +{
> > +	symbol__disassembler_missing("LLVM", filename, sym);
> > +	return -1;
> > +}
> > +#endif // HAVE_LIBLLVM_SUPPORT
> > 
> > /*
> >  * Possibly create a new version of line with tabs expanded. Returns the
> > @@ -2242,24 +2269,21 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
> > 			err = symbol__disassemble_raw(symfs_filename, sym, args);
> > 			if (err == 0)
> > 				goto out_remove_tmp;
> > -#ifdef HAVE_LIBCAPSTONE_SUPPORT
> > +
> > 			err = symbol__disassemble_capstone_powerpc(symfs_filename, sym, args);
> > 			if (err == 0)
> > 				goto out_remove_tmp;
> > -#endif
> > 		}
> > 	}
> > 
> > -#ifdef HAVE_LIBLLVM_SUPPORT
> > 	err = symbol__disassemble_llvm(symfs_filename, sym, args);
> > 	if (err == 0)
> > 		goto out_remove_tmp;
> > -#endif
> > -#ifdef HAVE_LIBCAPSTONE_SUPPORT
> > +
> > 	err = symbol__disassemble_capstone(symfs_filename, sym, args);
> > 	if (err == 0)
> > 		goto out_remove_tmp;
> > -#endif
> > +
> > 	err = symbol__disassemble_objdump(symfs_filename, sym, args);
> > 
> > out_remove_tmp:
> > -- 
> > 2.47.0
> > 
> > 
> 
