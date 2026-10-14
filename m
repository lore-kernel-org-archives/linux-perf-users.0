Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4464D2D6E5A;
	Wed, 14 Oct 2026 22:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792016260; cv=none; b=A8jY6Cru+WbkUxIzY0ysoWt5gxiaigP2acpU96rAeYh+yNoXZeA3+HgFRIwmXUqbq1fKLUznEYR+sMmjIzC7UZqEA8BEUih0Fxw6TX8yM1dX5P3WJ5P5TPwmJXgzLG9Ku/sq0blZWwY2XIiG5+zwJjGKJoyXlAPVSXHqKEV2RiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792016260; c=relaxed/simple;
	bh=6rYEKpuyZg54h/jG43AxiPwkT7iadM87/QZyfSZXIpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLNq24Zan+RNmSYRYqKyTfOpm5OXPhre7fjCgzCTK4vZ6E7zb8gReaecNaDCXJP1Rc7yD3eSTx3C+KvR3Rlj0+reqo7a6kgvCFrrUlBpumyRAqAKC4Iq/MVbmaCDtngmmRT+nHJ2USOIPLfS+2njH5YtVJQJiyEBYZaJin3vdoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAn3E2cp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAn3E2cp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C961F000C4;
	Wed, 14 Oct 2026 22:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792016258;
	bh=9oY1kBKAVCptGWm6qXZuVZLaR35xmMfyPEP9DIKR+qc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OAn3E2cp7LcGIxIGM1/DQrNRFSy6LdmNIdjdDFniK/zrjIn0ZdJF9HJNkh/bYsWDc
	 ucy2uWdGC7+N2L0wYtBsyHcopFPUqQRwtOqo7iyyl/PsL2PUpmteEZcm2SsMC0c+Xb
	 2scUV0umrRrRb6y74rdAMXvr8SIod6wnnMbhf9U00CR7dStVDrexr83tpudmnjQrq8
	 lxoxn0dyP3BuTMLTt82YEwzhjk+sVPNoekL5fH0JT54j+auIH6rahOcjvkIRH4d63c
	 an+XVfOSmvKmq2gG42GX4wjjzgicMbIi3PV4A3gsiaNgmh//DgTikyQfi6jXYtjnvq
	 Y9iYwPc0MyYcA==
Date: Wed, 14 Oct 2026 19:17:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3 1/4] perf symbol: Fix symbol loading from libbfd
Message-ID: <as__f7LjG4GckkBj@x2>
References: <20261012235938.87912-1-namhyung@kernel.org>
 <as557LTNwiigXk0O@x2>
 <as6cV-cm6dgTtzet@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as6cV-cm6dgTtzet@google.com>

On Tue, Oct 13, 2026 at 02:02:15PM -0700, Namhyung Kim wrote:
> On Tue, Oct 13, 2026 at 03:35:24PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, Oct 12, 2026 at 04:59:34PM -0700, Namhyung Kim wrote:
> > > The dso__load() should return a positive number (number of symbols
> > > loaded) when it succeded to load symbols.  But dso__load_bfd_symbols()
> > > only returns 0 and it's hard to check if it actually loaded symbols or
> > > not.  Let's return the value of dso__has_symbol() and check it in
> > > dso__load() so that it can return 1 for success.
> > > 
> > > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > > Closes: https://lore.kernel.org/r/sashiko-outbox-162540@kernel.org
> > > Fixes: eac9a4342e5447cad ("perf symbols: Try reading the symbol table with libbfd")
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > 
> > Thanks, applied to perf-tools-next, for v7.4.
> 
> Thanks Arnaldo!
> 
> As you may know, this is from my other series on cleaning up symtab and
> binary types.  I'd like to land it as well so that I can continue
> working on the related issues.  There are some Sashiko feedback left,
> but I think they are either pre-existing bugs or known issues.

Right, its now at tmp.perf-tools-next, while I test build in my
container set, will push it to perf-tools-next next.

- Arnaldo
