Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5981833C539;
	Wed,  7 Jan 2026 18:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767809901; cv=none; b=J63BONA9eKKbV4z1lhP0CzhOERf4GIz/xExp7b7EQq7kiLBI/lxBfxghDFtB1TSaEQK5WEpH54vq2hHRHXyTsYa0yn9v5oF0HO54D5Jt8Oi+2987PjFKSBiSJCKM8v2ndAVjiwygwHsbdgyCDHh6q345Xjo9vycoUw0eRRP4nRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767809901; c=relaxed/simple;
	bh=s27ccQFbApbt2q5ImZlGXA0T8FPFBDdt+ES6BeIF8vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRHV6gymMItjNkAzBM72iegxxTgre26OKPdzIJdTPNKA787LfCscwXnLJ6kImru6p4dQ5aSdsTuHo61Y+diwD3hMzXfXCzWvzIP1zwIN1JKUBb7X4Ga0oQ4P7Q1M9Ht4UtCJ855w4JtRPMxz9wqxA+B8BahdOuvl10ITFrB7AVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0mG8/Nw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0mG8/Nw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED219C4CEF1;
	Wed,  7 Jan 2026 18:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767809901;
	bh=s27ccQFbApbt2q5ImZlGXA0T8FPFBDdt+ES6BeIF8vU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o0mG8/Nwy67GgnHYsqslR0XuIgiZ/l7XbXDcrCMMJP/NISmz953u12IaiV4MpF3Yk
	 gmI5BGxdDGoXFnwJL1BDu4y2aOtUOY1IyRgU3/PcHPzuAYvWQE74srH1Oka/P4B8Ea
	 bpCJuidzFFbYgXZWxrHPCjHi/yhj6r4P/zUeP+smtBhDxutrJJehNzP20oo9FHg71Z
	 fD0QcwqMkUfLOTwfTp2gopqqYn/P+fSaSbuHX6voiThV7kVS4SQLjtvZFs85M5ahz4
	 9YJs7fBOIFK+sQXYC1Y0+IIL2sUllKIXaBNBYMatDDV1NAZOivAPPe93d4h19wcRE4
	 gDX6AtB8sl7hg==
Date: Wed, 7 Jan 2026 10:18:17 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] perf symbol: remove Rust symbol workarounds
Message-ID: <aV6jaaBftvR0Dl0b@google.com>
References: <20260105150106.567830-1-gary@kernel.org>
 <aVvdt90YmhJz3i5i@x1>
 <aV4TkNE_hAyByISq@google.com>
 <aV5h4I5rRl61vFFu@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aV5h4I5rRl61vFFu@x1>

On Wed, Jan 07, 2026 at 10:38:40AM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Jan 07, 2026 at 12:04:32AM -0800, Namhyung Kim wrote:
> > On Mon, Jan 05, 2026 at 12:50:15PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Mon, Jan 05, 2026 at 03:00:57PM +0000, Gary Guo wrote:
> > > > Due to an off-by-one error introduced in commit 73bbb94466fd ("kallsyms:
> > > > support "big" kernel symbols"), long symbols (which are currently only
> > > > produced by Rust) can have their symbol type being wrongly parsed by
> > > > kernel/kallsyms.c.
>  
> > > Looks sane, applied to perf-tools-next,
>    
> > I'm afraid there may be some outdated kernels which don't have the fix
> > yet.  Maybe make sense to wait some more time for them to disappear?
> 
> Right, I took it more as it seems to be just a blip in time, something
> that came and went quickly and that most likely will not cause problems,
> i.e. just a handful of extra symbols in the lookup data structures in
> those particular kernels and a new 'perf test' tool with these reverts,
> if run on those particular kernels would then fail for that particular
> test case, for a known reason.
> 
> So with the above rationale you still feel strongly about having it
> applied?

No, it's good to go.  Thanks for the explanation!

Namhyung

