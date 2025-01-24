Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE931ACE12;
	Fri, 24 Jan 2025 16:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737737275; cv=none; b=DVp7unOSJ1JtgRpyH+riHUCg6e7C4aiTF72f9xr1cw3MZQQ/tLeiUvOo42RdHlKNqj7BjGRuwveQkaizIFRCDDFtimnRA+fPEALOnSDorLa2g/AJvE7ARVkJoQ2JeFsdyoZJyKUUF2awRPP9T+Gz7uBKszGPNbaoK7VaVx3eCSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737737275; c=relaxed/simple;
	bh=bNqZ4+ItrUuElCv/vSiC9ONDNWCJu2oO44CS2/EWYdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLHKZVolI/ka8hvypjBDEH3+3njtYWHktG1Sm1TlGQJPVb7+2f3EvxhGJfZLZTVOI+aLjqOGzv4FwbS0nAKaBpb2Mp60+RW+ysfzV9OaaTkxfUbp83AcKfFYYcYBGn+hjQzTJaS06+SH2nPKn7AT7hAD/hZe+xxfeYmSSsxiYck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dP0PfN4U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dP0PfN4U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5E6C4CED2;
	Fri, 24 Jan 2025 16:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737737275;
	bh=bNqZ4+ItrUuElCv/vSiC9ONDNWCJu2oO44CS2/EWYdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dP0PfN4UoewMqc2BRSI5aTRHCyTbertPjY829spBAmQAD2udIypBehz16Naao8ikj
	 NKck8+7XV4VDWLChVsy3CgmDJxPPkjmpkRS1KAv3k7Cq+GKOlXqZlqFBExrZ4yqKzk
	 R4L8tfDOw1bDH/WT6nnTPUnBoyl7TKbsQP62brBBMVRJJpn4biuIE7I2zFPzG5CEOS
	 5e6Ui5tzYCpUeUfP4Z+5vnGuASJIb3++QEtMzpefI23Girb/FlHY9gfCXf0TEJwSuK
	 y2TxOg0u5QYd27LqZ5S0wDaWflTq8HTqVVmQ0PygtxLaAg/hKqb19/zVsESbJj6QJA
	 4FTesoGhFwjLQ==
Date: Fri, 24 Jan 2025 08:47:52 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v4 05/39] x86/asm: Avoid emitting DWARF CFI for non-VDSO
Message-ID: <20250124164752.hmwq6mctc6nf7uni@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <0c6c20d81164ba1dd375465f31bd51a8e1af164d.1737511963.git.jpoimboe@kernel.org>
 <e5008073-f779-492b-807f-d14c39ec0ba3@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e5008073-f779-492b-807f-d14c39ec0ba3@linux.ibm.com>

On Fri, Jan 24, 2025 at 05:08:57PM +0100, Jens Remus wrote:
> On 22.01.2025 03:30, Josh Poimboeuf wrote:
> > -#ifndef BUILD_VDSO
> > -	/*
> > -	 * Emit CFI data in .debug_frame sections, not .eh_frame sections.
> > -	 * The latter we currently just discard since we don't do DWARF
> > -	 * unwinding at runtime.  So only the offline DWARF information is
> > -	 * useful to anyone.  Note we should not use this directive if we
> > -	 * ever decide to enable DWARF unwinding at runtime.
> > -	 */
> > -	.cfi_sections .debug_frame
> > -#else
> > -	 /*
> > -	  * For the vDSO, emit both runtime unwind information and debug
> > -	  * symbols for the .dbg file.
> > -	  */
> > -	.cfi_sections .eh_frame, .debug_frame
> > -#endif
> > +#else /* !BUILD_VDSO */
> > +
> 
> Did you remove ".cfi_sections .debug_frame" on purpose from the
> !BUILD_VDSO path compared to V3?

Yes, since non-VDSO assembly files won't be emitting any .cfi, there's
no .debug_frame to output anyway.

> Presumably to not only not emit DWARF CFI from assembler, but any
> source?

This only impacts assembly files, notice the __ASSEMBLY__ check at the
top of the file.

-- 
Josh
