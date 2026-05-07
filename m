Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9673A6EFC;
	Thu,  7 May 2026 10:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778148905; cv=none; b=ZNxJ3ZyIr3UIPX+zAUMLz2m6V2t44DdbzPLTBkN3cTBHTJ7zBcpT80WJHWW0DCskfRnyDXCRTEfenZ1eD92yny/Hk8wb9tY1PrhvhzpntTYhtSFyKr2WSETuj8vxwLu7hdgU7ydJaGlUFUnKmF1IZ3Es7fUyhobvphnju2ve8Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778148905; c=relaxed/simple;
	bh=IHBwWJ/tasIPeaU2FIIM1pe9bcDw/+HjDJbpuMIyt1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDWUqVGnle8LYyPxcN5NbFSHBg9nrsody6V7CKczM8SPyqXykqOO7jU0RNQeqRLTTdfm0Fcuxzh2fQ0lKIjAa6f/e5bYEuvnQprCZeZMBXCeMGLF1HrDeRW7VpRzSjxBBwTBfVM0pryv3xIhW98UrP+a+FYf6muqDOUeTcaRfLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dchbhVkB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dchbhVkB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VNiftqS7fgET61dsxPWuBVOSGCj2rgUc1Iz9hwjBz+o=; b=dchbhVkB1r1i9Nb4lRxNEqY2qQ
	CFIixTHOstyrQ/JDb5RX+Hzh4Qx+wxyxWZ1yfxhBkDAx2rkD6Cq3182VwupG6bW5RtwjcWBC/TNrB
	EsvDEXZo1fDyygMxTOJhP2U9MHWySSkXXcbzaeL1b6JmloqhGLrk6TA4Ubx4mUPC77+9XNS8s79c/
	ttF4EwgUur6lFvdk4XxQA0Xm/T/h6CQcFkAoSFd3hGeswrR3unWG+igkkbfVvfgINIPtIefmlR6JG
	k/f3RiT+Hl3+JNp0Mq2A/sZN9F7n2QG5ZBQgIw31CRdoOQdcI3sPClbuY4/H6e2YA3HEYSlLNk2/3
	DCU+EJdg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKvkh-00000002fNP-097o;
	Thu, 07 May 2026 10:14:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A5DEA301261; Thu, 07 May 2026 12:14:41 +0200 (CEST)
Date: Thu, 7 May 2026 12:14:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH][next] perf/x86: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <20260507101441.GC1174357@noisy.programming.kicks-ass.net>
References: <afJcDg1I5ZU5ZkXf@kspp>
 <20260504083228.GQ3126523@noisy.programming.kicks-ass.net>
 <7aa0f09e-5d35-49e1-916b-7564d074df70@embeddedor.com>
 <20260507081012.GI3126523@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507081012.GI3126523@noisy.programming.kicks-ass.net>

On Thu, May 07, 2026 at 10:10:12AM +0200, Peter Zijlstra wrote:
> On Mon, May 04, 2026 at 01:50:50PM -0600, Gustavo A. R. Silva wrote:
> > >    https://lore.kernel.org/all/20240806113254.GG12673@noisy.programming.kicks-ass.net/
> > 
> > Feel free to apply it.
> 
> Bah, stupid warning :/
> 
> There really is no sane way to tell the compiler that the code is fine
> and it should just STFU already? I mean, it is directly followed by an
> array of the right type to fill that flex thing.
> 
> Anyway, I suppose this all very much relies on the structure not getting
> randomized, so let me stick __no_randomize_layout on it at the very
> least.

Ideally GCC would get fixed to allow something like so:

struct bar;

struct foo {
	...
	struct bar entries[];
};

struct ponies {
	...
	struct foo my_foo __sized_by(my_bars);
	struct bar my_bars[16];
	...
};

Such that the __sized_by() applies to foo::entries and ensures the
member is no longer considered unsized.

But I suspect this needs the whole of the flexarray insanity fixed;
because for some idiotic reason it is allowed for offsetof(struct foo,
entries) != sizeof(struct foo), and if that is the case, then everything
goes sideways in a hurry.

Note that the kernel very much does not rely on that weird behaviour,
since it always allocates sizeof(foo) + count * sizeof(foo::entries[0])
like. So we always have sufficient space at the end of the object.

And then I'm sure fixing flexarray is considered breaking ABI and so
we're left up a creek without no paddles on.

This is a giant shitshow, is what.
