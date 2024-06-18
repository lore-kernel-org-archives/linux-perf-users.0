Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2501AB8F2;
	Tue, 18 Jun 2024 08:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718699328; cv=none; b=FmwkC7D6h0ULzgLfR3ke6oODBb3k+THAAirs8Z/3RUDUnjxZ6eceIgLHzIAHJkINxS32zE4b2e+x2BxQFHoQ9ah8zAbj7iVlQvhgrk1I/tNwlXzhcY17O3fhb4zhg5Yv2zMke5tJS11IKhVIbxtAgpA9DIe2Nf5KofT4lwZOaX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718699328; c=relaxed/simple;
	bh=BdSJQOWhhnbvbjhJs7yzyr7yzcdDh4L6lLxL6lQDSEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MF7H9P3ZEubNCENYcNhHXvW6C4kuC1lhgBh8bfTCcgTovhMtcc/Bh5f4TMwkGzNBMJyppNy1fnfO7mZvzZMSxO1T8sezFaZr6Asslvb2Em9iSsR4IeWvg5GUQ65mtve8dqeBddsDSV5rvbvFCiKALlWBEIdzDLvKrb/CpO3PPC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d+IDEF4l; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d+IDEF4l"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=J/cBIU1B1ZzX5KCj0SQv24mrW9j+05d7us3cvGVoDXQ=; b=d+IDEF4lBi26tNltBxJT/32itv
	XiKQ2wxAmFp2q0v4pih1+WFvQF5w1FvLLd3HjYMEYMpDau68yCCVQEibqpgaNZU+6pt9tjLsabKvp
	qm8VglynG9YDyta0slbCiRo2OFI1oL+jAU1Gxn6F86p/ALAk+/8DHmHePyu6CMkj2ZJaTAX3kXB2s
	y+syK8kRDNvJhaJCMru9vgNn+l73TV/M9Yo7aplYSCTqKsbIeWRj3Wd8OGLIizm57v2hG9Sr8GSwI
	FphfiOdYlc5xhSaSegzEfWRlIz8JPJ9XSXquTE2N/wxe/UQjp0/6KH+OfnSrxBNwhieDv3Bfvxtop
	e018SnsQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJUCf-00000002z9Y-2a71;
	Tue, 18 Jun 2024 08:28:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 10CC0300886; Tue, 18 Jun 2024 10:28:29 +0200 (CEST)
Date: Tue, 18 Jun 2024 10:28:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Justin Stitt <justinstitt@google.com>,
	Erick Archer <erick.archer@outlook.com>,
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
Message-ID: <20240618082828.GD31592@noisy.programming.kicks-ass.net>
References: <AS8PR02MB7237F5BFDAA793E15692B3998BFD2@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <202406101010.E1C77AE9D@keescook>
 <20240610200544.GY8774@noisy.programming.kicks-ass.net>
 <202406101438.BC43514F@keescook>
 <20240611075542.GD8774@noisy.programming.kicks-ass.net>
 <202406121148.688240B@keescook>
 <20240612220821.GA18881@noisy.programming.kicks-ass.net>
 <202406121530.D9DB956C8@keescook>
 <20240614101708.GO8774@noisy.programming.kicks-ass.net>
 <202406170957.3269DA2@keescook>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202406170957.3269DA2@keescook>

On Mon, Jun 17, 2024 at 10:19:15AM -0700, Kees Cook wrote:
> On Fri, Jun 14, 2024 at 12:17:08PM +0200, Peter Zijlstra wrote:
> > On Wed, Jun 12, 2024 at 04:23:31PM -0700, Kees Cook wrote:
> > > On Thu, Jun 13, 2024 at 12:08:21AM +0200, Peter Zijlstra wrote:
> > > > On Wed, Jun 12, 2024 at 12:01:19PM -0700, Kees Cook wrote:
> > > > > I'm happy to take patches. And for this bikeshed, this would be better
> > > > > named under the size_*() helpers which are trying to keep size_t
> > > > > calculations from overflowing (by saturating). i.e.:
> > > > > 
> > > > > 	size_add_mult(sizeof(*p), sizeof(*p->member), num)
> > > > 
> > > > Fine I suppose, but what if we want something not size_t? Are we waiting
> > > > for the type system extension?
> > > 
> > > Because of C's implicit promotion/truncation, we can't do anything
> > > sanely with return values of arbitrary type size; we have to capture the
> > > lvalue type somehow so the checking can happen without C doing silent
> > > garbage.
> > 
> > So sizeof() returns the native (built-in) size_t, right? If that type
> > the nooverflow qualifier on, then:
> > 
> > 	sizeof(*p) + num*sizeof(p->foo[0])
> > 
> > should all get the nooverflow semantics right? Because size_t is
> > effectively 'nooverflow unsigned long' the multiplication should promote
> > 'num' to some 'long'.
> 
> Hmmm. This is an interesting point. I'll see what Justin has found as
> he's been working on limiting the overflow sanitizer to specific types.
> 
> It doesn't help this (unfortunately common) code pattern, though:
> 
> 	int size;
> 
> 	size = sizeof(*p) + num*sizeof(p->foo[0]);
> 	p = kmalloc(size, GFP_KERNEL);
> 
> But that was going to be a problem either way.

Well, you can add a warning on implicitly casting away nooverflow.

New qualifier, we get to make up the rules etc.. it probably means we
need to change the signature of the allocator functions to take a
'nooverflow' type, otherwise those will trigger this new warning, but
that should not be a problem.

> > Now, I've re-read the rules and I don't see qualifiers mentioned, so
> > can't we state that the overflow/nooverflow qualifiers are to be
> > preserved on (implicit) promotion and when nooverflow and overflow are
> > combined the 'safe' nooverflow takes precedence?
> > 
> > I mean, when we're adding qualifiers we can make up rules about them
> > too, right?
> 
> Yup, that is the design of the "wraps" attribute (though it is the
> reverse: it _allows_ for wrap-around, since we want to the default state
> to be mitigation).

Yeah, I feel strongly about that (just mailed you in the other
sub-thread) that this is the wrong way around.

> > If 'people' don't want to adorn the built-in size_t, we can always do
> > something like:
> > 
> > #define sizeof(x) ((nooverflow unsigned long)(sizeof(x)))
> > 
> > and 'fix' it ourselves.
> 
> Right, though my hope is still we get the result of "nooverflow" by
> marking that which was expected to overflow.

You cannot sell that as a proper language extension because it will
break world+dog.
