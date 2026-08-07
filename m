Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602EE40A940;
	Fri,  7 Aug 2026 06:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786083555; cv=none; b=tCWnwlSjo3wJDLjPg/Pc0ZgnomsqClHZJusd6+B0Cir5STL489GencqreRyPuNZ25/HFNcWSUDAaTh2VF+ibtgdKPao9W/YLQrhzpBnsdvmNLnZR0q2Q9VRAblpT1xMvdgTlaSgOuWQBbcfhsq76c0dYGIv3J6ehifQBb8nvvBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786083555; c=relaxed/simple;
	bh=QDrHSlFvruw8r/yb5RPpq8rk6ckuo4IjoQhH8ovPqhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqbXY5JZN3WBDLWqBzYk09OZROzhAwaJBlJgqhKbeKxG5jfrD1vJXYolZh3wzMgQ++iN+YAy9SpVcBae0qQH+JpoA3xPjU6FMV1UXz8zF7mTN+9Ryte1s1+nQdUy4AmmXQPDyN8jipDlzYyu5FUy9B9ny19n1ACaIZ+gfqWMtUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0M2YpW7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0M2YpW7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689F51F000E9;
	Fri,  7 Aug 2026 06:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786083554;
	bh=193BBwHr598DUjOt1JWlgmla/r4HIeMu/clqp47i9ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c0M2YpW712XWt/oA+OeHjHiM1QuPbq1cRH6A5WCTU3hEQoekoOkMgWkJRAONEcKcc
	 MwxeAVQq7yJ/9j/YW/W6i72TnVAum5V8HtNZFiQaUTnoUx+8X0w6FCewQQ8MpefqRE
	 sfXuV1KfZ57sFFiTwfC9uHmjEzKitMi1S58zms5IIzew7SOGS70sUqc9mg2nzvisUB
	 Djlik/suTBCxqHVH43hIFeCEzJGfLjy9xoh+TxaXQAu8tJpBsfH3OkCSXIWZdbRJBv
	 EYQ8XjinxuetgE1YKuHd0LGlMy9uXDEw1iUGMYR+d1Ir6PYCE01YHGmF8mmr3YqyxN
	 Zm9gznE08WtBQ==
Date: Thu, 6 Aug 2026 23:19:11 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Jiebin Sun <jiebin.sun@intel.com>
Cc: acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
	irogers@google.com, james.clark@linaro.org, jolsa@kernel.org,
	mark.rutland@arm.com, dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com, tianyou.li@intel.com,
	wangyang.guo@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/9] perf c2c: add a function view
Message-ID: <anV438EFQvwGp-bh@google.com>
References: <20260803035220.172022-1-jiebin.sun@intel.com>
 <anN-livkfPdXq7Uy@google.com>
 <20260806074710.2847155-1-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260806074710.2847155-1-jiebin.sun@intel.com>

Hello,

On Thu, Aug 06, 2026 at 03:47:10PM +0800, Jiebin Sun wrote:
> Hi Namhyung,
> 
> Thanks for reporting this. I reproduced the Python import failure. Although
> the loader reported c2c_fmt_free, checking with `ldd -r` showed four
> unresolved symbols from c2c-function.o: c2c, c2c_fmt_equal, c2c_fmt_free,
> and perf_c2c__browse_cacheline.

Yeah, I noticed that too.

> 
> I considered moving the formatter callbacks to util/ as suggested. However,
> that would still leave c2c, the command's global state, and
> perf_c2c__browse_cacheline(), its existing TUI entry point, unresolved.

Thanks for doing that.  I think you may change the code to take pointers
instead of direct references.

Thanks,
Namhyung

> 
> The issue comes from placing c2c-function.o in libperf-ui.a, which is linked
> into python/perf.so under --whole-archive, while builtin-c2c.o is not part
> of the Python module. Since the browser is specific to the c2c command, v7
> links it directly into perf alongside builtin-c2c.o, under CONFIG_SLANG.
> 
> This is folded into the browser skeleton patch; the other eight patches are
> unchanged. I clean-built every commit and ran `perf test -v 'import perf'`
> at each step. I also verified the full series with and without SLANG.
> 
> The `--stdio` support and function-view test will follow on top of v7.
> 
> Thanks,
> Jiebin
