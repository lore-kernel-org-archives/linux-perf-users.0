Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39C91C863D;
	Fri, 14 Feb 2025 21:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739568127; cv=none; b=LBcbrGrrC9TlXRRZEWqRYFjM52iGs75M6cETi15ajbxFtHBurNiHxcAVSXbQDZJe2Zh2I6CJIqSXf6W8pebptQOD0xFdih/QF8wYYcIW3evKnZifE+RWDCw55dNYGaOYUQHkr23911J/RivT0Yh0oLK8xnXC2Qz2esMLnv0eNEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739568127; c=relaxed/simple;
	bh=x6l3BHhoXY56a3KnJSS1Oxn7kFVGMOnxm69r6/nTl4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jax1haXcKEC/BaDgl8joEqkYv2HDTdm/HW36PDwOYU5adb09wwMYmVey0HLpuZAhAnUUUpQKI1ecqoGgF6AyYCQeYHcE1wHcACyNAFvpwKS3I4bRwW2itBF4Otp22/C3+qIrRVSV3grGMl1hLq0UUG7rvrxQHr/KN0G3VikHTyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHb/MKrY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHb/MKrY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1F8C4CED1;
	Fri, 14 Feb 2025 21:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739568127;
	bh=x6l3BHhoXY56a3KnJSS1Oxn7kFVGMOnxm69r6/nTl4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kHb/MKrY0FD2JbTJ+6IuzU7cCa0FNGDaIh8pPf7q5O7B7mb43juaIWuVqBCllFyqG
	 iJVsL1ESZArgkg8srrwdBIPWeGVHH7+HHc5HdI5kKfqdAJGNW8sOUH37nAo/Su1048
	 k0R/s8ahhwk5PDU2VuKBlgULW557TkbTgViGjqiGFObOGMTs05OHI2XtKmw4ExjsRq
	 YOQW67SyK5FqXngpilsydIgB4UYTqu0wlIXr/fCFBhHIl8aHqysWOf217FqHABzmkk
	 3K76VjbzHcIt+Qhpg6kgp+5KpYNOuojwxfQ7j7oCSXiLIyLrgT9D4bUcsIGdhRTJNf
	 Fj+FXleNSbGpA==
Date: Fri, 14 Feb 2025 13:22:05 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2] perf tools: Fix compile error on sample->user_regs
Message-ID: <Z6-z_WLufB2OKTJs@google.com>
References: <20250214191641.756664-1-namhyung@kernel.org>
 <CAP-5=fXnx_kzUjVwA7cm-JwpqRDevaj59UdTbKnLOjbNx_OUNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXnx_kzUjVwA7cm-JwpqRDevaj59UdTbKnLOjbNx_OUNQ@mail.gmail.com>

On Fri, Feb 14, 2025 at 11:50:42AM -0800, Ian Rogers wrote:
> On Fri, Feb 14, 2025 at 11:16 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > It's recently changed to allocate dynamically but misses to update some
> > arch-dependent codes to use perf_sample__user_regs().
> >
> > Fixes: dc6d2bc2d893a878 ("perf sample: Make user_regs and intr_regs optional")
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Thanks for this! My tag in case it is useful:
> Reviewed-by: Ian Rogers <irogers@google.com>

Sure, thanks for the review.

> 
> Would be nice to have asan testing to make sure there are arch
> dependent memory leaks, less arch code would be nice.

Right, I need cross-arch or native non-x86 testing.

Thanks,
Namhyung

