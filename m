Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3375F770E1;
	Mon, 10 Jun 2024 10:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718014027; cv=none; b=A04wCXJyiJnxrMIAl38+Op4yh7DF62CvZV3gQ1iCC3BJT1cCsw6ykIQKCUON5hy3WJDyHDiiyCJw6j7RScnYZLUfwMuN9MPOJTY5VrWS0z4OS+ClANB/awV+Ox6zIbuXMtnVOZQ2UlaDtXNc07l8g3zyl72YxInbMR1eqvx/9GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718014027; c=relaxed/simple;
	bh=9r2h/gDx9bml6PDQTuEJkHHD0nrZQKtzsCZEmunU1GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=doyo8dJChCfeHaGIlQw3GdttGIUBE+LhEhEt8AwQnOtZxZvbHjteZQfYqJOeSQNfqqo481m1kF7HFhu9YPy3nPwJxEzG0bcW0wjdDyHQNtliAomdjkWXJH4obCz3iJqoI+QOGjPoac2fb7qyF+ZibxiHZonNHxIqVxO7wcuMe10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aAdP8E17; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aAdP8E17"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=auYCcPsADBP4sRimitJGpg2Zp3/5ESPayXwf7a7EFHk=; b=aAdP8E17Yc/QBnc4hBDUh91z64
	8zXlWfn5Tz9PpHMBvCFEVFKNaCA3uNh8bHlptQz5QSo1HrJJMGVgJj5n7Bo2g8TNz/yFw7Q6u9/rK
	9L/QDYKODcfudXII48jA1Uux8MufMCwQnUGtdRB297/NwhudPPTjfx/9nvoW+G0XKGaLF3RKc3uWe
	6n4UAKWEZXZBENvuHSorHJsKr/fcZhO/ZQcV14FKCnQerK7gIgt2Es+Bl2Wsz2eK6V4GUreEJQvc9
	LXXTP0UsGQv7sOiUZ80SgFBL+0V0d+vQL9uWBgTGe4YfldKxtQj9XJLWF2C3Rbk2UaUatEj5dzYFu
	VEUyEiLw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGbvK-00000008spW-12YQ;
	Mon, 10 Jun 2024 10:06:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8153D300439; Mon, 10 Jun 2024 12:06:45 +0200 (CEST)
Date: Mon, 10 Jun 2024 12:06:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Erick Archer <erick.archer@outlook.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Matthew Wilcox <mawilcox@microsoft.com>, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v4 0/3] Hardening perf subsystem
Message-ID: <20240610100645.GS40213@noisy.programming.kicks-ass.net>
References: <AS8PR02MB7237F5BFDAA793E15692B3998BFD2@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <AS8PR02MB72373C2D08910FBE5FA27BE48BC42@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB72373C2D08910FBE5FA27BE48BC42@AS8PR02MB7237.eurprd02.prod.outlook.com>

On Sat, Jun 08, 2024 at 10:50:44AM +0200, Erick Archer wrote:
> Hi Andrew,
> 
> On Sat, Jun 01, 2024 at 06:56:15PM +0200, Erick Archer wrote:
> > Hi everyone,
> > 
> > This is an effort to get rid of all multiplications from allocation
> > functions in order to prevent integer overflows [1][2].
> > 
> > In the first patch, the "struct amd_uncore_ctx" can be refactored to
> > use a flex array for the "events" member. This way, the allocation/
> > freeing of the memory can be simplified. Then, the struct_size()
> > helper can be used to do the arithmetic calculation for the memory
> > to be allocated.
> > 
> > In the second patch, as the "struct intel_uncore_box" ends in a
> > flexible array, the preferred way in the kernel is to use the
> > struct_size() helper to do the arithmetic instead of the calculation
> > "size + count * size" in the kzalloc_node() function.
> > 
> > In the third patch, as the "struct perf_buffer" also ends in a
> > flexible array, the preferred way in the kernel is to use the
> > struct_size() helper to do the arithmetic instead of the calculation
> > "size + count * size" in the kzalloc_node() functions. At the same
> > time, prepare for the coming implementation by GCC and Clang of the
> > __counted_by attribute.
> > 
> > This time, I have decided to send these three patches in the same serie
> > since all of them has been rejected by the maintainers. I have used
> > the v4 tag since it is the latest iteration in one of the patches.
> > 
> > The reason these patches were rejected is that Peter Zijlstra detest
> > the struct_size() helper [3][4]. However, Kees Cook and I consider that
> > the use of this helper improves readability. But we can all say that it
> > is a matter of preference.
> > 
> > Anyway, leaving aside personal preferences, these patches has the
> > following pros:
> > 
> > - Code robustness improvement (__counted_by coverage).
> > - Code robustness improvement (use of struct_size() to do calculations
> >   on memory allocator functions).
> > - Fewer lines of code.
> > - Follow the recommendations made in "Deprecated Interfaces, Language
> >   Features, Attributes, and Conventions" [5] as the preferred method
> >   of doing things in the kernel.
> > - Widely used in the kernel.
> > - Widely accepted in the kernel.
> > 
> > There are also patches in this subsystem that use the struct_size()
> > helper:
> > 
> > 6566f907bf31 ("Convert intel uncore to struct_size") by Matthew Wilcox
> > dfbc411e0a5e ("perf/x86/rapl: Prefer struct_size() over open coded arithmetic") by me
> > 
> > Therefore, I would like these patches to be applied this time.
> 
> This is my last attemp to get these patches applied. I have decided to
> send this mail to try to unjam this situation. I have folowed all the
> reviewers comments and have no response from the maintainers other than
> "I detest the struct_size() helper".
> 
> Therefore, I would like to know your opinion and that of other people
> about these patches. If the final consensus is that the code has no real
> benefit, I will stop insisting on it ;)

Seriously, I've got plenty patches to look at that actually do
something. This falls well within the 'random changes for changes sake'
and goes waaaaay down the priority list.

If you're addressing an actual issue, state so. Otherwise, go play
somewhere else.
