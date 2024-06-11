Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6845172798;
	Tue, 11 Jun 2024 07:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718092573; cv=none; b=NQcxr0hRBnvxMsVjCe0C0U/jJqoDuBpo1CNKsykKBPEZq6H75yJqEvbMf5oP7yH2MmFmLTFlCykGfwdXjE2TI090qoedvgikZ4P9dshQrFlhD248kjbpqecw4f1XZ3FhZt+IpWVHkEM8FflgI2QLJ8z23W+jW3q5CKrRgJvP27E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718092573; c=relaxed/simple;
	bh=onq0LibBzl0SGv/vrIqLQZvTBuzX3tSL82kn87S2vEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uS2gB6dh2frFZcYSGnXuBLaaNxksjYhUKbmOfB9vedsaJMp3Nrt/N+KmITgT5N3DCLcwFKPMkrG/04zY4tKiJzFx57zyuPcwRFSwMrVvsJuNqhndUgirwozS3LNfZXzKKCjyFat6sCXjL3pChDd77F1eke9bk7qzXcySp9+aZPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VhDrpQ49; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VhDrpQ49"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TLcNdhigD/3gcWPOQBhYy4GWZxU41lowHmx6XYIrLQ4=; b=VhDrpQ497BR5J+mZwqbqb2QNiG
	RcHgVBpOq5EAJwvUz/EReo6oK6UA5f12P17TmmGsRaAHxhlN/3GDLIhdsq3B5kmzjCuvqhYgyXb9G
	7cMJIFsf1EP8QT/NXRGPQWz4k4s2nLmcqoWtP8M6izp18ePXgtf+LK8yjU/C/DMOwrbn4rp4lHBk8
	n6EWE4PsglyTkXrf37/GTq4Ju9pkpAe9RHsn1LyZyh86vB/UuwhkTz2NUeDZs9YDqlmF099O2bms2
	zG+WjYEspDBieVr0aMg3BSVawImYV6141ckdskT9Jd2/gXQi7t6sNrff6Sfw5JH+SfoJzeJuWXNN/
	v21YQxNQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGwM0-000000020Of-1xlj;
	Tue, 11 Jun 2024 07:55:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1B99F302792; Tue, 11 Jun 2024 09:55:43 +0200 (CEST)
Date: Tue, 11 Jun 2024 09:55:42 +0200
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
Message-ID: <20240611075542.GD8774@noisy.programming.kicks-ass.net>
References: <AS8PR02MB7237F5BFDAA793E15692B3998BFD2@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <202406101010.E1C77AE9D@keescook>
 <20240610200544.GY8774@noisy.programming.kicks-ass.net>
 <202406101438.BC43514F@keescook>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202406101438.BC43514F@keescook>

On Mon, Jun 10, 2024 at 02:46:09PM -0700, Kees Cook wrote:

> > I really detest this thing because it makes what was trivially readable
> > into something opaque. Get me that type qualifier that traps on overflow
> > and write plain C. All this __builtin_overflow garbage is just that,
> > unreadable nonsense.
> 
> It's more readable than container_of(), 

Yeah, no. container_of() is absolutely trivial and very readable.
container_of_const() a lot less so.

(one static_assert() removed)

#define container_of(ptr, type, member) ({                              \
        void *__mptr = (void *)(ptr);                                   \
        ((type *)(__mptr - offsetof(type, member))); })

Which is very clear indeed in what it does. Compare with:

#define struct_size(p, member, count)                                   \
        __builtin_choose_expr(__is_constexpr(count),                    \
                sizeof(*(p)) + flex_array_size(p, member, count),       \
                size_add(sizeof(*(p)), flex_array_size(p, member, count)))

And I still have no idea :-(

> IMO. "give me the struct size
> for variable VAR, which has a flexible array MEMBER, when we have COUNT
> many of them": struct_size(VAR, MEMBER, COUNT). It's more readable, more
> robust, and provides saturation in the face of potential wrap-around.

I'm sure you know what it does. Thing is, I don't care because I can
trivially write it myself and not have to care and I'll have forgotten
all about it the moment I sent this email.

It just doesn't make sense to wrap something as utterly trivial as:

	size = sizeof(*p) + num*sizeof(p->foo);

We're going to have to agree to disagree on this.

Note how I naturally get the order wrong?

[[ There is the whole FMA angle to this, that is, fundamentally this is a
multiply-accumulate, but the problem there is the same that I noted,
there is no fixed order, a+b*c and a*b+c are both very common
definitions -- although I lean towards the latter being the correct one,
given the order in the naming. I suppose this is a long winded way of
saying that:

#define struct_size(p, member, num) \
	mult_add_no_overflow(num, sizeof(p->member), sizeof(*p))

would be *FAR* more readable. And then I still think struct_size() is
less readable than its expansion. ]]

> > > This provides __counted_by coverage, and I think this is important to
> > > gain in ever place we can. Given that this is part of a ring buffer
> > > implementation that is arbitrarily sized, this is exactly the kind of
> > > place I'd like to see __counted_by used. This is a runtime robustness
> > > improvement, so I don't see this a "churn" at all.
> > 
> > Again, mixed in with that other crap. Anyway, remind me wth this
> > __counted_by thing actually does?
> 
> It provides annotation for the compiler to perform run-time bounds
> checking on dynamically sized arrays. i.e. CONFIG_FORTIFY_SOURCE and
> CONFIG_UBSAN_BOUNDS can actually reason about annotated flexible arrays
> instead of just saying "oh no a flexible array, I give up".

Some day I'll have to look at this FORTIFY_SOURCE and see what it
actually does I suppose :/

> > > Peter, for patches 1 and 3, if you'd prefer not to carry them, I could
> > > put them in the hardening tree to keep them out of your way. It seems
> > > clear you don't want patch 2 at all.
> > 
> > I prefer to not have struct_size() anywhere at all. Please just write
> > readable code.
> 
> That ship has sailed, and it has been keeping things at bay for a while
> now. As we make progress on making the compiler able to do this more
> naturally, we can work on replacing struct_size(), but it's in use
> globally and it's useful both for catching runtime mistakes and for
> catching compile-time mistakes (the flexible array has to match the
> variable's struct).

I coulnd't quickly find a single instance in the code I care about. So
nothing is sailing afaict.

