Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3202D318B97;
	Wed,  7 Jan 2026 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767810164; cv=none; b=qhY+Bn9KQyPvM7qC6rYzq1KKiH4OJwjuhiPgeJk6qIOUW8BIfRt4bH27c3njqVYGURcYJ+3AG25TuFdhS6Wq4zUsitJicICuZ6MGnhyP0jCwI4yS03mKll5wnSTuvuGBXOfXftgeP6ZSh1upHyDQ92lDiAbuPKdvThgcv3XjMnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767810164; c=relaxed/simple;
	bh=kyXRX7sJLQIHiX/nVw4ynG4DW6ryJVlegWE4ytCco7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4Nmt66jTtzWvRH9FSbgQZBw+qI3T136qCbL3XTXpIshHRnERKPLSd5EfC7HPLcMrcN0gMvVIwKhL7fj1GrUmXyb+4cypBYjbRoQd0ZXUSgltLlTh0FwmRzO+PJivHl58Wq+Hx6uKchObyM6bheImRzUZcg67qp1kN/qp2UteS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIn4pD98; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIn4pD98"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADAF4C4CEF1;
	Wed,  7 Jan 2026 18:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767810163;
	bh=kyXRX7sJLQIHiX/nVw4ynG4DW6ryJVlegWE4ytCco7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MIn4pD98YCnEwRO+5LVO0DRReALNgp1am925yhO26whqNm8Kuad1kMK16SBiKY/uV
	 WwDyBWd3qO4KN79gPTLm6W7sN5dgXvx7rrGSu/ecBgNpa4U4eaoa0vvcwxydr+3t0c
	 WMFh0vyjFe+SL2/VqbA11WYMwTihDFafO7JUqdTdh2k9phu7Y03VGrUQZEQM0p3698
	 VWtgFG90i5aJEqMY9xRc2tbAXGfvCzzMqbt0vYmajE2mOyK+AGGHZARuaawY/1fyYH
	 wVEiX+RLqGi6yxAekIzKUHW/MB5bioXp/BCLLzFdf1Q6urO7Uu3gAGdcSRt+sCIC/a
	 J1ADTZqRUKO4w==
Date: Wed, 7 Jan 2026 10:22:40 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Gary Guo <gary@garyguo.net>,
	Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <aV6kcMzcwF0tLpgt@google.com>
References: <20260105150106.567830-1-gary@kernel.org>
 <aVvdt90YmhJz3i5i@x1>
 <aV4TkNE_hAyByISq@google.com>
 <CANiq72kUVvMznfFtcjks=0iJ7HE2uvCSyD-Xu5NV=_9ZykVXhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kUVvMznfFtcjks=0iJ7HE2uvCSyD-Xu5NV=_9ZykVXhg@mail.gmail.com>

Hello,

On Wed, Jan 07, 2026 at 12:59:48PM +0100, Miguel Ojeda wrote:
> On Wed, Jan 7, 2026 at 9:04 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > I'm afraid there may be some outdated kernels which don't have the fix
> > yet.  Maybe make sense to wait some more time for them to disappear?
> 
> Hmm... Do you mean that someone would use a new perf with an old
> kernel? Is that supported etc.?

Yep, perf userspace can be released separate with the kernel and it's
recommended to run the latest version regardless of kernel versions.
So from the tools perspective, it should support any kernels.

> 
> In any case, the fix is getting backported all the way to 6.1.y, i.e.
> all the supported LTSs:
> 
>     761e965d2c61 ("kallsyms: Fix wrong "big" kernel symbol type read
> from procfs")
>     d5fe0c115bbc ("kallsyms: Fix wrong "big" kernel symbol type read
> from procfs")
>     d46ef2bf91ef ("kallsyms: Fix wrong "big" kernel symbol type read
> from procfs")
> 
> And the one in this thread could in principle be backported too to
> 6.18.y now that the fix is there, no?

Thanks for your work!  I think it should be fine once the backports land
to distro kernels.

Namhyung

