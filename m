Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2D54A1DFB;
	Tue, 13 Oct 2026 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916529; cv=none; b=CrqWD0fT3S6vIS/hT9BoqdSfqCF3SNsRGV27rluG0qRglcsw97uivt9h2+4+FsHs2u2SfDXr0FWF6T8xkF8CKunqw/R18BrXvgfnIr9VwrlJrIPDNUfvENFk7ColUD+DZlsaEUONODRZGDJs2DtP8sd3gf90sZa/Qk4KCjJGVQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916529; c=relaxed/simple;
	bh=o4bkfPWTq+VZX0h2ofx+xLsUEl1BSyC/15o6TUAqLs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prMTew1i2Da1Wbfy1JYc3C2JWJzTqJ7glQj45WfI1Gvqx5mQiHtASlCrBkvK7Xt1PoQUXcN4Z7ZjyApVGt23TLKvP2PNRT3+1Px44Y7dmG/hFrqFkr4nsI1rRdTIGyEM12f4WCxgxmS6/Fj8CGpuX6w6Hu7OtSI7zhxbE7QbZNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCkx+Blu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCkx+Blu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3DB1F000FF;
	Tue, 13 Oct 2026 18:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791916528;
	bh=TSfufczw2wfRitYypoeS1SIbbxgdZ15alxWA3QjQSXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OCkx+BluuFnpj4QEEiO1g7m72VgLQQ4H9bU9uBR5LQ1EZdmvV0EqXCUnkFKAMsSyc
	 /MoPafSDrittiXMZe05WbbhhCihn9yP78whDvysY5HSHfOHQqO6iBZQNkwFwbnPyA8
	 JUOb8ZtulYimdbZZk3WrEIi/A5lTtXwwHS4R4bfOY7W7biBzLxM8m8dPVouQTskGS4
	 03YgN03xeraTrtQ5g35DpoiVrGdtfPvls0XBHoIufBxBE8//4A29BG8tpPFyf9Kr9y
	 TzkLniJHUYwY06gnSzoNj54knviJ9qNEYJohuEZ3XauGeFug0Vy4us9eO/T4lYLIME
	 eW1zGK6dYM4lQ==
Date: Tue, 13 Oct 2026 15:35:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3 1/4] perf symbol: Fix symbol loading from libbfd
Message-ID: <as557LTNwiigXk0O@x2>
References: <20261012235938.87912-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012235938.87912-1-namhyung@kernel.org>

On Mon, Oct 12, 2026 at 04:59:34PM -0700, Namhyung Kim wrote:
> The dso__load() should return a positive number (number of symbols
> loaded) when it succeded to load symbols.  But dso__load_bfd_symbols()
> only returns 0 and it's hard to check if it actually loaded symbols or
> not.  Let's return the value of dso__has_symbol() and check it in
> dso__load() so that it can return 1 for success.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/sashiko-outbox-162540@kernel.org
> Fixes: eac9a4342e5447cad ("perf symbols: Try reading the symbol table with libbfd")
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
