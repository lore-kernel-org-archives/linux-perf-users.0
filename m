Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411041AA781;
	Mon, 11 Nov 2024 17:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731345492; cv=none; b=PTEiPjWoKDHZuFXkIxczdNJ4I5WHNhTD34hpv1Z25ggELauY5UgZCg3chcsBSTYqgTjvZWMRrQj8Uk6xdrfQ6WIqbzrqV6bRqEjsEMBeUwqqto2xnVf/PZRBFy89vDequyKOfcq5uJzplqcLiaFuMmIjM3aHg8Zc4d8j0XoNAMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731345492; c=relaxed/simple;
	bh=rHf271R2KuETkNEiM6Gx5NyfytQwQyRduPp9khGq67c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnS2gP63TCdIUKapqtEZezoean7Pb9sHKDwShnuC32DDHd4me2vlYX2us20dvmupLN8Jy7ClqVBBxROaG9AvIR7hrWjA81QURv1iKMwFv+BxRqoLMiR63sIYCJB9WlniJtsjLt20bhBGjf0yXOS77Ft5EriEktXAkZiAvcvqAQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWuzs81W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWuzs81W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D38DC4AF09;
	Mon, 11 Nov 2024 17:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731345491;
	bh=rHf271R2KuETkNEiM6Gx5NyfytQwQyRduPp9khGq67c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BWuzs81WQ4XALvKxzc7LldTevsLRBizzCSNnGR0LmHVd1Xs6YoOaGgUFpVw2d5G9x
	 14S6MxD1tQ+Zy27NjykeSa/PYlZJRblPAcn8v66OeAqWm4DF3hynKHtXXdhCJbHWNQ
	 Tr10jRbl/bJ7GybwEYqanHLcXayV1YJpwmsZ8ug2bwe+4LLT/GhqM9LWiS+fKQol74
	 JzL5t9yogh1kH8rZCnoFiKuCIlN/KT9XiJp689k1s5hweAEwOmNdScmj7mFLQ/IVid
	 QCBQi+9L43LsfuHJCl48PksgWJoeb+ghmDQvxrmG4sOpNj9W33/LR/2wtMtjAz5DrG
	 s248TwbmkUDFg==
Date: Mon, 11 Nov 2024 14:18:08 -0300
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
Subject: Re: [PATCH 1/3] perf disasm: Introduce symbol__disassemble_objdump()
Message-ID: <ZzI8UKdy4dg2Tf6L@x1>
References: <20241111151734.1018476-1-acme@kernel.org>
 <20241111151734.1018476-2-acme@kernel.org>
 <CAP-5=fXxwf2wJf-JN7p5F_-V7WdDt_s9jk+Mz5YMkH+9gkpJUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXxwf2wJf-JN7p5F_-V7WdDt_s9jk+Mz5YMkH+9gkpJUg@mail.gmail.com>

On Mon, Nov 11, 2024 at 08:15:53AM -0800, Ian Rogers wrote:
> On Mon, Nov 11, 2024 at 7:17 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > With the first disassemble method in perf, the parsing of objdump
> > output, just like we have for llvm and capstone.
> >
> > This paves the way to allow the user to specify what disassemblers are
> > preferred and to also to at some point allow building without the
> > objdump method.
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
> 
> Nit below relating to a pre-existing condition in the code.

<SNIP>

> > +#ifdef HAVE_LIBLLVM_SUPPORT
> > +       err = symbol__disassemble_llvm(symfs_filename, sym, args);
> > +       if (err == 0)
> > +               goto out_remove_tmp;
> > +#endif
> > +#ifdef HAVE_LIBCAPSTONE_SUPPORT
> > +       err = symbol__disassemble_capstone(symfs_filename, sym, args);
> > +       if (err == 0)
> > +               goto out_remove_tmp;
> > +#endif
> > +       err = symbol__disassemble_objdump(symfs_filename, sym, args);

> This sure does read like the symbol will be disassembled 3 times if
> those ifdefs are defined. Is there anyway to make the code look more
> intuitive?

This will end up being rewritten, the end result is a loop where the
list of disassemblers to try is iterated and as soon as one succeeeds
(returns zero), the loop is exited.

- Arnaldo
