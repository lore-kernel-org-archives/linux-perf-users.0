Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F090545009;
	Mon, 10 Jun 2024 21:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718055970; cv=none; b=EqAIOky/9FH0Cow8qsCtcE4UgSLtsF5aA3wik7HdACBIsr68obxEpAtx6mnNVsJeJ8TP6ST+4dl/XG7bsz2TLEuAjh8lpG5MNmB1fSkeuW5MuA8MN8T2Nb4lLGzzCPbzMsn5zntL17Yqs9maBJ7ZDFy1xVwtHaVQhr5FMMolFmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718055970; c=relaxed/simple;
	bh=ThcS+7P7h43Cs6kE0W/MurQBHRtUWuN38hGsgvTeJrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilva4TiwfZjec6GvlkvB/S9hyeDW6KGL+A1PLq5UoyMZ6bgJcQfqQqH6cMPJRd5vqS9u6D8dSulPNYeH44I343NjvwjUiLDeQPRYu+moPoOWCjX1EC5RZ8RY1LMnJPs0j4j6NgQxjvGyznf4qVRSa/sxx3EHmunENsw2egPLSNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFE1krJM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFE1krJM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76623C2BBFC;
	Mon, 10 Jun 2024 21:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718055969;
	bh=ThcS+7P7h43Cs6kE0W/MurQBHRtUWuN38hGsgvTeJrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UFE1krJM0gYQdya4A6dlMkelUJgQvYjswI3DqHAkHfxQLj2YsW/TJ99buQ0eeC7RL
	 w7r4uYZClJnCXW6EE8IwF719t9HHQbuGy7QMfpXhs8PEBU8K5V4ZZyJ0+Xz2rWFxFs
	 /rcUFsBmBUp0CIwiwKjETFKbHsZIqN7ceA3nQMB4X9mbP8EqiaTlmiZswrpkwJP5tx
	 Zbgj37U/tS5h27dxi/uS0c/JVdqLqbRAsrmorev6YRndfY9xlwrynMuENgzgZ/cMX1
	 iVz53DxfpTwR6iipAjaG0YEYcxEaaVOC4lNmTAzdVccM0lnSZkVP8/Hl94/sWU+iEg
	 8U7ZuU1rd5HKA==
Date: Mon, 10 Jun 2024 14:46:09 -0700
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Erick Archer <erick.archer@outlook.com>, Ingo Molnar <mingo@redhat.com>,
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
	"H. Peter Anvin" <hpa@zytor.com>,
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
Message-ID: <202406101438.BC43514F@keescook>
References: <AS8PR02MB7237F5BFDAA793E15692B3998BFD2@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <202406101010.E1C77AE9D@keescook>
 <20240610200544.GY8774@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610200544.GY8774@noisy.programming.kicks-ass.net>

On Mon, Jun 10, 2024 at 10:05:44PM +0200, Peter Zijlstra wrote:
> On Mon, Jun 10, 2024 at 10:28:52AM -0700, Kees Cook wrote:
> > On Sat, Jun 01, 2024 at 06:56:15PM +0200, Erick Archer wrote:
> > > Hi everyone,
> > > 
> > > This is an effort to get rid of all multiplications from allocation
> > > functions in order to prevent integer overflows [1][2].
> > 
> > I didn't actually see these 3 patches in this thread nor via lore.
> 
> He managed to break threading between 0/n and the rest.
> 
> > > In the first patch, the "struct amd_uncore_ctx" can be refactored to
> > > use a flex array for the "events" member. This way, the allocation/
> > > freeing of the memory can be simplified. Then, the struct_size()
> > > helper can be used to do the arithmetic calculation for the memory
> > > to be allocated.
> > 
> > I like this patch because it reduces the allocation from 2 to 1. This
> > isn't what Peter might see as "churn": this is an improvement in resource
> > utilization.
> 
> But then he went and used that struct_size() abomination :/
> 
> > I prefer this style, as it makes things unambiguous ("this will never
> > wrap around") without having to check the associated types and doesn't make
> > the resulting binary code different in the "can never overflow" case.
> > 
> > In this particular case:
> > 
> > int size = sizeof(*box) + numshared * sizeof(struct intel_uncore_extra_reg);
> > 
> > "int numshared" comes from struct intel_uncore_type::num_shared_regs,
> > which is:
> > 
> >         unsigned num_shared_regs:8;
> > 
> > And the struct sizes are:
> > 
> > $ pahole -C intel_uncore_box gcc-boot/vmlinux | grep size:
> >         /* size: 488, cachelines: 8, members: 19 */
> > $ pahole -C intel_uncore_extra_reg gcc-boot/vmlinux | grep size:
> >         /* size: 96, cachelines: 2, members: 5 */
> > 
> > So we have:
> > 
> > s32 size = 488 + u8 * 96
> > 
> > Max size here is 24968 so it can never overflow an s32, so I can see
> > why Peter views this as "churn".
> > 
> > I still think the patch is a coding style improvement, but okay.
> 
> I really detest this thing because it makes what was trivially readable
> into something opaque. Get me that type qualifier that traps on overflow
> and write plain C. All this __builtin_overflow garbage is just that,
> unreadable nonsense.

It's more readable than container_of(), IMO. "give me the struct size
for variable VAR, which has a flexible array MEMBER, when we have COUNT
many of them": struct_size(VAR, MEMBER, COUNT). It's more readable, more
robust, and provides saturation in the face of potential wrap-around.

> > This provides __counted_by coverage, and I think this is important to
> > gain in ever place we can. Given that this is part of a ring buffer
> > implementation that is arbitrarily sized, this is exactly the kind of
> > place I'd like to see __counted_by used. This is a runtime robustness
> > improvement, so I don't see this a "churn" at all.
> 
> Again, mixed in with that other crap. Anyway, remind me wth this
> __counted_by thing actually does?

It provides annotation for the compiler to perform run-time bounds
checking on dynamically sized arrays. i.e. CONFIG_FORTIFY_SOURCE and
CONFIG_UBSAN_BOUNDS can actually reason about annotated flexible arrays
instead of just saying "oh no a flexible array, I give up".

> > Peter, for patches 1 and 3, if you'd prefer not to carry them, I could
> > put them in the hardening tree to keep them out of your way. It seems
> > clear you don't want patch 2 at all.
> 
> I prefer to not have struct_size() anywhere at all. Please just write
> readable code.

That ship has sailed, and it has been keeping things at bay for a while
now. As we make progress on making the compiler able to do this more
naturally, we can work on replacing struct_size(), but it's in use
globally and it's useful both for catching runtime mistakes and for
catching compile-time mistakes (the flexible array has to match the
variable's struct).

-Kees

-- 
Kees Cook
