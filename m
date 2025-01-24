Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25A41ADC64;
	Fri, 24 Jan 2025 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737737015; cv=none; b=kchzqiI+XXfl+L+AO5G0SbmbWGIl5XQONs+5Lh2KAbMJFTcfaA1gPAjFPz6oUxkgLPFFfwSFV9Kz2JOK2BqRVGMzdfJdPM3rkL+ovluhqCNRjHVg05JafPqjwQA7iPw4vlBwx/lW1qyvEYebas8TtUxhYbsX3hvwOi6a9G7d3/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737737015; c=relaxed/simple;
	bh=FYp0R4sSE5OSs+rTqnkOS6h7k4YrDx4FhQcGy4xc5uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWwja3DiM6i3Nxi8MvWLqH/3jdc1d37uemftxALHKg+gkcM7C6jOlK+wu2ogUtHIS4urM+ViVTe9z9Pn2m7pSFosTOdploIbG1dDi5CUM+6K6/C4A+T9Ll8sajdCq6lTMqKdIGDl5M6EZwOLfQysdLmc0cPQD/+jJNXnTzobbgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i44Rmt0W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i44Rmt0W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01AB5C4CEDD;
	Fri, 24 Jan 2025 16:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737737015;
	bh=FYp0R4sSE5OSs+rTqnkOS6h7k4YrDx4FhQcGy4xc5uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i44Rmt0WfwPH+FVDwxhDuD6zzTEGkNmzFRPG5H/ZWhHYvOZ7jbBkxJA90uWYDLJR2
	 A1nHk6RD1bxxtyF/DIgYiZdUetWzjBuSLbt7ZSI5HKY/lc5Q6dX9CayNCQkV2emBWT
	 cndQuT2DDhDVbCBm22D+Fvdx8VbZN+6dm6yb1PkSt8f2nifhNgl/y6YOZmSjnKnnHL
	 QNKwgszcjhWwA29oGn9TtNRiZpO0htrCMcD0XXJ2/NeykV713T0dW1VLJKTYFtEi0g
	 qFQ5n21cqp9eDccUnq8Zcp4iE/WajCUlpRerka+tEYPGOu/f+Hpx1xRfBu8GLzebxH
	 izHP0YuF0HKmA==
Date: Fri, 24 Jan 2025 08:43:32 -0800
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
Subject: Re: [PATCH v4 09/39] x86/vdso: Enable sframe generation in VDSO
Message-ID: <20250124164332.gqgzimfix3vk4bsw@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <c93fbd53f01c2c86f747af27040ac11f16dee032.1737511963.git.jpoimboe@kernel.org>
 <cde90a82-6bdd-4a12-872a-7b39edf3eac8@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cde90a82-6bdd-4a12-872a-7b39edf3eac8@linux.ibm.com>

On Fri, Jan 24, 2025 at 05:00:27PM +0100, Jens Remus wrote:
> On 22.01.2025 03:31, Josh Poimboeuf wrote:
> > diff --git a/arch/x86/include/asm/dwarf2.h b/arch/x86/include/asm/dwarf2.h
> > index b195b3c8677e..1c354f648505 100644
> > --- a/arch/x86/include/asm/dwarf2.h
> > +++ b/arch/x86/include/asm/dwarf2.h
> > @@ -12,8 +12,11 @@
> >   	 * For the vDSO, emit both runtime unwind information and debug
> >   	 * symbols for the .dbg file.
> >   	 */
> > -
> 
> Nit: Deleted blank line you introduced in "[PATCH v4 05/39] x86/asm:
> Avoid emitting DWARF CFI for non-VDSO".

Indeed.

> > +#ifdef __x86_64__
> 
> #if defined(__x86_64__) && defined(CONFIG_AS_SFRAME)
> 
> AFAIK the kernel has a minimum binutils requirement of 2.25 [1]
> and assembler option "--gsframe" as well as directive
> ".cfi_sections .sframe" were introduced with 2.40.

True, I'll change it to just '#ifdef CONFIG_AS_SFRAME' since that's what
really matters (and 32-bit doesn't support it anyway).

> > +	.cfi_sections .eh_frame, .debug_frame, .sframe
> > +#else
> >   	.cfi_sections .eh_frame, .debug_frame
> > +#endif
> >   #define CFI_STARTPROC		.cfi_startproc
> >   #define CFI_ENDPROC		.cfi_endproc

-- 
Josh
