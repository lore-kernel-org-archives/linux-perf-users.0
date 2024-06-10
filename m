Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BE214F9CA;
	Mon, 10 Jun 2024 20:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718049969; cv=none; b=rmXfymatjVuwwqTb/kYJW78uYdoP424QOZ0NOsNNjt+VHVgkC+X97YIsYbu7aR2okrP4IbPJJssDVVz6byVY60NWyejRivH9XGfH9/0+OeM5vYoMYlblYgdSq1uwyS9WxlY8p6zsY7KtGgGTSlg43+RQN/38YQ659zAnFKwwjjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718049969; c=relaxed/simple;
	bh=zbr0m3jaUR9OElayeL3+Puu8aP5BQ6bEGe0ASP77bQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqknMBg5lMy5z9G7c5WIMkgSLzoFrreqdoRoDCjfghHDECqq76VuWf9oFQiA8t+VeJwNSHELOj57VyDOXHJGPvQ+sw2ntTWkQaykXiHjJfqgG2IvSBBcdO7AleaVcCCKTAqvTb3lOc19wSy9O/SG1ileBxKoSTGkhDEAkVadaho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iOmHeJ0J; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iOmHeJ0J"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fYZ++efrlLdLgl5+5kduErcCwGNkwJxHYJIyw8lDqdM=; b=iOmHeJ0Jsu8Eo6JoXABlbGd0I0
	bJe+wGiDRyomn+cVqKpgC3q8gDZQQub9Loev8/dZ/XdSZ+MBoea7mS17HbhdVpAlBZE84aGr2xXHw
	zUvtSHQrQOuBekbu1pUQ743nu1a/ALB8evE0HROV8wKgT2CQleyGaXzXwH6znHymn/CI6yriPHJXW
	NAuK3OSAKk9PV2kgr1QR6xuuN3pg71/ZDghzKeRvrOb3msh7K+Dm2jYth7NwdfaksTpGj6nq7hbvA
	4z0ebh713bwfrGtq1LrUWVF3tox2dTC2r25lq4knpgIehmS4xdVoo6fWbRKH5ffXgHhmdURj3I85d
	0fyzIu6A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGlGw-00000001dwA-2wkK;
	Mon, 10 Jun 2024 20:05:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F156A300439; Mon, 10 Jun 2024 22:05:44 +0200 (CEST)
Date: Mon, 10 Jun 2024 22:05:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
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
Message-ID: <20240610200544.GY8774@noisy.programming.kicks-ass.net>
References: <AS8PR02MB7237F5BFDAA793E15692B3998BFD2@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <202406101010.E1C77AE9D@keescook>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202406101010.E1C77AE9D@keescook>

On Mon, Jun 10, 2024 at 10:28:52AM -0700, Kees Cook wrote:
> On Sat, Jun 01, 2024 at 06:56:15PM +0200, Erick Archer wrote:
> > Hi everyone,
> > 
> > This is an effort to get rid of all multiplications from allocation
> > functions in order to prevent integer overflows [1][2].
> 
> I didn't actually see these 3 patches in this thread nor via lore.

He managed to break threading between 0/n and the rest.

> > In the first patch, the "struct amd_uncore_ctx" can be refactored to
> > use a flex array for the "events" member. This way, the allocation/
> > freeing of the memory can be simplified. Then, the struct_size()
> > helper can be used to do the arithmetic calculation for the memory
> > to be allocated.
> 
> I like this patch because it reduces the allocation from 2 to 1. This
> isn't what Peter might see as "churn": this is an improvement in resource
> utilization.

But then he went and used that struct_size() abomination :/

> I prefer this style, as it makes things unambiguous ("this will never
> wrap around") without having to check the associated types and doesn't make
> the resulting binary code different in the "can never overflow" case.
> 
> In this particular case:
> 
> int size = sizeof(*box) + numshared * sizeof(struct intel_uncore_extra_reg);
> 
> "int numshared" comes from struct intel_uncore_type::num_shared_regs,
> which is:
> 
>         unsigned num_shared_regs:8;
> 
> And the struct sizes are:
> 
> $ pahole -C intel_uncore_box gcc-boot/vmlinux | grep size:
>         /* size: 488, cachelines: 8, members: 19 */
> $ pahole -C intel_uncore_extra_reg gcc-boot/vmlinux | grep size:
>         /* size: 96, cachelines: 2, members: 5 */
> 
> So we have:
> 
> s32 size = 488 + u8 * 96
> 
> Max size here is 24968 so it can never overflow an s32, so I can see
> why Peter views this as "churn".
> 
> I still think the patch is a coding style improvement, but okay.

I really detest this thing because it makes what was trivially readable
into something opaque. Get me that type qualifier that traps on overflow
and write plain C. All this __builtin_overflow garbage is just that,
unreadable nonsense.

> This provides __counted_by coverage, and I think this is important to
> gain in ever place we can. Given that this is part of a ring buffer
> implementation that is arbitrarily sized, this is exactly the kind of
> place I'd like to see __counted_by used. This is a runtime robustness
> improvement, so I don't see this a "churn" at all.

Again, mixed in with that other crap. Anyway, remind me wth this
__counted_by thing actually does?

> Peter, for patches 1 and 3, if you'd prefer not to carry them, I could
> put them in the hardening tree to keep them out of your way. It seems
> clear you don't want patch 2 at all.

I prefer to not have struct_size() anywhere at all. Please just write
readable code.

Again, if you really care about that overflow muck, get a useable C type
qualifier or something so we can write readable code.
