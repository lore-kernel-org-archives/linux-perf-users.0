Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBDA16CD0C;
	Mon, 17 Jun 2024 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718644756; cv=none; b=JWXY/uctcgfuV1vn/fsRj3pGDjGO+k5apLAn09ZeAaQxLRRdL1ToDKeracVRLUz1r93xrNipNy90xH9CrZuw96Fbns5NjCmy5CQOcslxgk5YX1oSnwtQBuZ2QhtSZr206qZHkbTXEitJj7/V+uNIPx+AWaWISDgqluqDod9qy4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718644756; c=relaxed/simple;
	bh=ELiGKN2fHBN+ynIfeSKCNIu1f4FOFyPukTCFTs3BlS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAULSwAr0sO0YoMSvL6d0PAqrK7+E1eanGgvZC9ERg2t4zKNCrWHXFzuRGXUfowCs3go+nJe84bsIFoROYlIRDZ44X/IvB2aMk3y+x+ut5Rrswc8Z69HGn7TZdjfhLQ7aioKkQ/gThSur+SfrcHBcL21YTqzMCQe0ET7jHk2vN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUhmfwiB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUhmfwiB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7A3C2BD10;
	Mon, 17 Jun 2024 17:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718644756;
	bh=ELiGKN2fHBN+ynIfeSKCNIu1f4FOFyPukTCFTs3BlS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WUhmfwiBLTadekoZLK/cJ1hPrtE8wCKxrmUiSi1VKMnPoUkfBxZUhjaKqMVeWPByu
	 CwDmlBvvlnpvj3U8hHr6ZF1ZtwXIK0vgYV6mEH3eKXA4Dy5K70RaMHiCf0TMCtICpo
	 7aquv5NzpLTgD0JOg4u9xUS4l26MoZiOK3087DwODru4hcuvtJOzXoCbgRhdYNJ8kO
	 OgE8g/A+22sSv1+lfM2g8kOsNFSwgnlUDU8dVtBtdaXO/VnVwWQM3e8tUF6vYbIYUL
	 I3lkEL7A7AM2K2/KokNMhtY+ya/piXuq6h5KEP2Phif80DNvDBu08CnGE30u/QP+D5
	 ntPTbG3PeNZ5A==
Date: Mon, 17 Jun 2024 10:19:15 -0700
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Justin Stitt <justinstitt@google.com>
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
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Matthew Wilcox <mawilcox@microsoft.com>, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v4 0/3] Hardening perf subsystem
Message-ID: <202406170957.3269DA2@keescook>
References: <AS8PR02MB7237F5BFDAA793E15692B3998BFD2@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <202406101010.E1C77AE9D@keescook>
 <20240610200544.GY8774@noisy.programming.kicks-ass.net>
 <202406101438.BC43514F@keescook>
 <20240611075542.GD8774@noisy.programming.kicks-ass.net>
 <202406121148.688240B@keescook>
 <20240612220821.GA18881@noisy.programming.kicks-ass.net>
 <202406121530.D9DB956C8@keescook>
 <20240614101708.GO8774@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614101708.GO8774@noisy.programming.kicks-ass.net>

On Fri, Jun 14, 2024 at 12:17:08PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 12, 2024 at 04:23:31PM -0700, Kees Cook wrote:
> > On Thu, Jun 13, 2024 at 12:08:21AM +0200, Peter Zijlstra wrote:
> > > On Wed, Jun 12, 2024 at 12:01:19PM -0700, Kees Cook wrote:
> > > > I'm happy to take patches. And for this bikeshed, this would be better
> > > > named under the size_*() helpers which are trying to keep size_t
> > > > calculations from overflowing (by saturating). i.e.:
> > > > 
> > > > 	size_add_mult(sizeof(*p), sizeof(*p->member), num)
> > > 
> > > Fine I suppose, but what if we want something not size_t? Are we waiting
> > > for the type system extension?
> > 
> > Because of C's implicit promotion/truncation, we can't do anything
> > sanely with return values of arbitrary type size; we have to capture the
> > lvalue type somehow so the checking can happen without C doing silent
> > garbage.
> 
> So sizeof() returns the native (built-in) size_t, right? If that type
> the nooverflow qualifier on, then:
> 
> 	sizeof(*p) + num*sizeof(p->foo[0])
> 
> should all get the nooverflow semantics right? Because size_t is
> effectively 'nooverflow unsigned long' the multiplication should promote
> 'num' to some 'long'.

Hmmm. This is an interesting point. I'll see what Justin has found as
he's been working on limiting the overflow sanitizer to specific types.

It doesn't help this (unfortunately common) code pattern, though:

	int size;

	size = sizeof(*p) + num*sizeof(p->foo[0]);
	p = kmalloc(size, GFP_KERNEL);

But that was going to be a problem either way.

> Now, I've re-read the rules and I don't see qualifiers mentioned, so
> can't we state that the overflow/nooverflow qualifiers are to be
> preserved on (implicit) promotion and when nooverflow and overflow are
> combined the 'safe' nooverflow takes precedence?
> 
> I mean, when we're adding qualifiers we can make up rules about them
> too, right?

Yup, that is the design of the "wraps" attribute (though it is the
reverse: it _allows_ for wrap-around, since we want to the default state
to be mitigation).

> If 'people' don't want to adorn the built-in size_t, we can always do
> something like:
> 
> #define sizeof(x) ((nooverflow unsigned long)(sizeof(x)))
> 
> and 'fix' it ourselves.

Right, though my hope is still we get the result of "nooverflow" by
marking that which was expected to overflow.

-- 
Kees Cook
