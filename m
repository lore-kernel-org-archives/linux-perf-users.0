Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5D57E574;
	Fri, 14 Jun 2024 10:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360242; cv=none; b=G3lzhbJjWr5zeeLjTniW9eGPRk0XYLidG+3zqLFGUaLOL5PqlWlsrTDLzLxZ+COlfZUY56UnccV9vkMXtYB5djmKfIPgk0oiBDyr5sReq6taFwgzmfapJ6nPRjLRr2PGQd73MI7EcMf1HYG1Fu/c+rwJau/lq7IkAS1LOL2SvdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360242; c=relaxed/simple;
	bh=5UOI7ykyIyrWv0zV25WvSOXZAgPx774trB7YoT24aP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fi1cdQsjCQVdg943CH0oM2sGYYQhk0Z8LslcuBV+KeuaLW2Fu2BpBtx2mo+jaKT36hEgYYAxWGR6aDGnCTrXksy+uA1Pt9zrgAeltGkaUxcGFdFvoPzTmr111gQj8zXsmdTZ5DL5VF1KUFmiYk7EPahrZKQYogoWZP1iLO71b58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HYUtGoYv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HYUtGoYv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k/WitOts9waE0REDVUa/TgAzlnqg2Mvxo9iE/34dOyo=; b=HYUtGoYvGRE2zm+CNMKLePHJIh
	vlNllM4XgHCgzvNSR6e5AnDk1IlfE2r5F6jRr6acX6KD6hh0r7UvG4UippR3oCzsrYNDfqSpnvYo2
	+Zj38/Z9xOXgi4DhomllOfd/Q1+c0DCEUlmP37JsBcUFZP91x9DK69ZgwyFrQpaj5KUdrb5kczq2s
	izci46WAkikfrc39KsKes/mLwJOBlAPOzcbeQ9xQ+2C89jhHbsPdD4I654fV2rANyJ4hgp9XHzUaC
	n8Zlc/3M1VsQHxywX2/1scV6dJX1j14P2ypXdPkKDdD2n2f+7UaIKRw487pICLDAHen7AvUv/fWSD
	OV4rSkxw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI3zZ-0000000Grmk-1B9w;
	Fri, 14 Jun 2024 10:17:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DFCBD300886; Fri, 14 Jun 2024 12:17:08 +0200 (CEST)
Date: Fri, 14 Jun 2024 12:17:08 +0200
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
Message-ID: <20240614101708.GO8774@noisy.programming.kicks-ass.net>
References: <AS8PR02MB7237F5BFDAA793E15692B3998BFD2@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <202406101010.E1C77AE9D@keescook>
 <20240610200544.GY8774@noisy.programming.kicks-ass.net>
 <202406101438.BC43514F@keescook>
 <20240611075542.GD8774@noisy.programming.kicks-ass.net>
 <202406121148.688240B@keescook>
 <20240612220821.GA18881@noisy.programming.kicks-ass.net>
 <202406121530.D9DB956C8@keescook>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202406121530.D9DB956C8@keescook>

On Wed, Jun 12, 2024 at 04:23:31PM -0700, Kees Cook wrote:
> On Thu, Jun 13, 2024 at 12:08:21AM +0200, Peter Zijlstra wrote:
> > On Wed, Jun 12, 2024 at 12:01:19PM -0700, Kees Cook wrote:
> > > I'm happy to take patches. And for this bikeshed, this would be better
> > > named under the size_*() helpers which are trying to keep size_t
> > > calculations from overflowing (by saturating). i.e.:
> > > 
> > > 	size_add_mult(sizeof(*p), sizeof(*p->member), num)
> > 
> > Fine I suppose, but what if we want something not size_t? Are we waiting
> > for the type system extension?
> 
> Because of C's implicit promotion/truncation, we can't do anything
> sanely with return values of arbitrary type size; we have to capture the
> lvalue type somehow so the checking can happen without C doing silent
> garbage.

So sizeof() returns the native (built-in) size_t, right? If that type
the nooverflow qualifier on, then:

	sizeof(*p) + num*sizeof(p->foo[0])

should all get the nooverflow semantics right? Because size_t is
effectively 'nooverflow unsigned long' the multiplication should promote
'num' to some 'long'.

Now, I've re-read the rules and I don't see qualifiers mentioned, so
can't we state that the overflow/nooverflow qualifiers are to be
preserved on (implicit) promotion and when nooverflow and overflow are
combined the 'safe' nooverflow takes precedence?

I mean, when we're adding qualifiers we can make up rules about them
too, right?

If 'people' don't want to adorn the built-in size_t, we can always do
something like:

#define sizeof(x) ((nooverflow unsigned long)(sizeof(x)))

and 'fix' it ourselves.

> > But none of that is showing me generated asm for the various cases. As
> > such, I don't consider myself informed enough.
> 
> Gotcha. For the compile-time stuff it's all just looking at
> known-at-compile-time sizes. So for something like this, we get a
> __compiletime_warning() emitted:
> 
> 	const char src[] = "Hello there";
> 	char dst[10];
> 
> 	strscpy(dst, src); /* Compiler yells since src is bigger than dst. */
> 
> For run-time checks it's basically just using the regular WARN()
> infrastructure with __builtin_dynamic_object_size(). Here's a simplified
> userspace example with assert():
> 
> https://godbolt.org/z/zMrKnMxn5
> 
> The kernel's FORTIFY_SOURCE is much more complex in how it does the
> checking, how it does the reporting (for helping people figure out what's
> gone weird), etc.

Thanks, I'll go have a look at that.
