Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E394731CA4A;
	Wed,  7 Jan 2026 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767793125; cv=none; b=LjULpKkygLQfffaNZacw84zlzeqoqbZoMhAvREX9gIT48aeMSvMD3YPb6P3tz2ZbfTuwg4PN1VXfIYlCRQwwruDWVn2cEdhWpaJbOGm54I8M6SQPkFTxQ9IbiwWhxawl5z+WmfFZhD2OZTb0GfoZ9EsOSGXbijrvmtwIPwSm518=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767793125; c=relaxed/simple;
	bh=mTrnNA/p4+H7qnKbRE+S5WNMbMQr6Yojr/HkPmFJaFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqwdo+vHiojtEylUwQvzzzE9hbEvnMSM3k1P72EHrAdcnSHM0F+/U/x04H9Ob4ADQlgZ1WbH+sWc+LF1hA6rzc/T9q86HbTzyt38LHsezWrL4TmmdeO8h2JOTBXVhPDdj+Do87vR9kLYsRLZawLL+Ao8CLG2SAj87NZlxExT9TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOtCjpW7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOtCjpW7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBE8C4CEF7;
	Wed,  7 Jan 2026 13:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767793124;
	bh=mTrnNA/p4+H7qnKbRE+S5WNMbMQr6Yojr/HkPmFJaFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oOtCjpW7/Hhf5iQnWnNmprZZlaW89j14U9IFbxeCztIW6qgRyGPjwmNLEHjcwKWyK
	 AmbktgR5VrtDKcpxaIEqgS6RsGvjTJWP+rTIihstYR0iLNq7grt+wXTW8VnQInPR50
	 0lusdEnOkR7yJW6UrHEVSMlA/D4ESTgEUwWqLw5mF9WjG5tO7+DoX4qOLd6132mF+D
	 O8tovP4Q5oLKQ8JacWtmALFgIfplwYKjXir+JzyFndgrui/ZA0RV9HGUTMjfR1U2sl
	 sTqKVXAM5UzuWcPhTfL0eCPD1dPjRkMYu+5Llbeu1aNybKArpfpzBj435NATdpNvar
	 2w4TuvI0Lpp1A==
Date: Wed, 7 Jan 2026 10:38:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
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
Message-ID: <aV5h4I5rRl61vFFu@x1>
References: <20260105150106.567830-1-gary@kernel.org>
 <aVvdt90YmhJz3i5i@x1>
 <aV4TkNE_hAyByISq@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV4TkNE_hAyByISq@google.com>

On Wed, Jan 07, 2026 at 12:04:32AM -0800, Namhyung Kim wrote:
> On Mon, Jan 05, 2026 at 12:50:15PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, Jan 05, 2026 at 03:00:57PM +0000, Gary Guo wrote:
> > > Due to an off-by-one error introduced in commit 73bbb94466fd ("kallsyms:
> > > support "big" kernel symbols"), long symbols (which are currently only
> > > produced by Rust) can have their symbol type being wrongly parsed by
> > > kernel/kallsyms.c.
 
> > Looks sane, applied to perf-tools-next,
   
> I'm afraid there may be some outdated kernels which don't have the fix
> yet.  Maybe make sense to wait some more time for them to disappear?

Right, I took it more as it seems to be just a blip in time, something
that came and went quickly and that most likely will not cause problems,
i.e. just a handful of extra symbols in the lookup data structures in
those particular kernels and a new 'perf test' tool with these reverts,
if run on those particular kernels would then fail for that particular
test case, for a known reason.

So with the above rationale you still feel strongly about having it
applied?

- Arnaldo
