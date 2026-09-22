Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7ED4248DC;
	Tue, 22 Sep 2026 12:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081272; cv=none; b=QHkP+B2WTR9MTL5Y8x3ov9EWggDFJXT0Dd+Am8DG7LGkTicy5D5vCYlYEKprk5n9QUWCm9kltk7YCiK/7N32lEKKQfYhlINnIRw+L6LWQnSjucPzyR8++z8LybYFHlf/RVasXmpgW1L4R+zwc4I6+2SvtO97tKLWoqDHk8/EdyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081272; c=relaxed/simple;
	bh=ShLahNgIqlvswiVllfPnfXpX4lQOwJ7lWebTnqr/7MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFcAlUjHiSXzKhoi1DulwtxVruYQWEDl25J09Kj3wF43/cL+CduV1tkoWdgl7ArkwJT/PPpt3KL+oA27Ver1QNsFZvC5FjkoEUXZ95InflAbbJlhinLeZIbM6IDLy7I8qbxIgHq42G4nKMe6LhT3bdkFt2ZANGWNQYnRirFARaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2JAridb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2JAridb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B88B1F00893;
	Tue, 22 Sep 2026 12:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790081270;
	bh=U9BU4MOHJ5mh/38zwA4tdKQBHdXpHVmQsMlvX6VW6K0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H2JAridbobH9Zc59zKZQkCSiMMAzLFWnvdYiZFtD4puiF2z4+b9/wF1QSC3wc9zjb
	 vZ6/YRfBbduJdzEHfjy/E5ortl+JFMzafjn9B7hwLVrqDOA1XCO/x5U3ZZHWKb5+8p
	 toM44psiY5wnbURG47AZaj59za7eABNgiZ38jYsCkazwwvsSEZYUwlfSn6pk+YszPn
	 CnrSS7qlS4sVc8xa0Igvc7BYcDkqfVQc8tFionmdcKDusW5/c5HYI2i/Nd+O6iXjd3
	 qrzFna6+it++lrbyJlZc9KwqKbRApdMHE7s4ExiuKOtMPABWElFuLVcNNrQ2fHQ4Ro
	 xDKRE2e4Tw0Aw==
Date: Tue, 22 Sep 2026 14:47:40 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH 0/9] perf build: Fix builds with clang and BUILD_NONDISTRO
Message-ID: <arJ47L9UDI6XYpVV@x2>
References: <20260916061218.3061216-1-irogers@google.com>
 <aqrTdAVfVkzltJct@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqrTdAVfVkzltJct@google.com>

On Wed, Sep 16, 2026 at 10:35:48AM -0700, Namhyung Kim wrote:
> On Tue, Sep 15, 2026 at 11:12:09PM -0700, Ian Rogers wrote:
> > Several perf build configurations are broken, and stayed broken because
> > the build test suite doesn't cover them.
> > Ian Rogers (9):
> >   perf libbfd: Fix the clang -Wthread-safety build failure
> >   perf symbol: Fix the build when demangling with libbfd
> >   perf libbfd: Include the headers that are used
> >   perf pmu: Include the headers that are used
> >   perf build: Only pass clang flags to CXX when CXX is clang
> >   perf build: Use the given CC rather than clang in clang builds
> >   perf build: Check the version of the compiler that is used
> >   perf build: Remove leftovers of removed build options
> >   perf test: Add build tests for clang and libbfd demangling
 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
