Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D674B205A;
	Sat, 10 Oct 2026 19:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791658805; cv=none; b=WWi9ygKWbzioDHoPAIcNKcmV9JXfnKkhOXRfQKPOdC6JNXBoZFY9pfUN6YM+7AVnRi4rLLrSBwvr6exunawMkMmuJj2hofGi3quybb9xRaDVexV2/5hAu6sCqpWf1cRME8CixN8BzGi6RN5ryvwGC7SWDoCQOCXx7LJgR6XwvbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791658805; c=relaxed/simple;
	bh=We7Ws7GgfVwgHG/dU/JrvOSiX38qQnvz9Bv5pMjJEGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLGNELfwxrlXyOan5iNjYMaJk377h4OYF6ksO3NbJmT3ZPG3oH2lUVP09yWq4iPInHQ2art/xjPQfJayK7r8iU+Tm+KMu2wHH9hW83te2n8tL0DIFhskZpspyWJFWptHlefz2WzLdP84p8963ziMDOODPPbYCIhdzul9c6c8Vy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BI/14aSD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BI/14aSD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318491F000FF;
	Sat, 10 Oct 2026 19:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791658804;
	bh=p7rPAFjR46L/1frr9rFRB4pQNe6D2dNu88rARccMfWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BI/14aSDZcsgaJMaxoQuzJSzqz+emhQ7wo1JpEqnqmeeUvsVXA+Wd21VFy6TX/Uah
	 3C0ntUsbfl/4oORkTCAOWJozBzW1CGYP28Cic3LItjskhuT7SUco37rrJUclt6fpNc
	 QswCsXyDHqikYuxs+okPR7auBaatW1Y/CuPTqE5wB/K308UrOIPd7EyAPNl4p5sn6N
	 hPYhttaMaAYozD7OVZPE3qx6KnoerplcqODa5QrAKoxTQfiT3uWNN86oVtUzJ3FF+H
	 rzgYGxPSCnoj9d/VD9n4rgNAUeKKiRBUyLfODetFQl+m7VtqthUhtO0Alp6VR4pR8m
	 tyjPoeBWswYpA==
Date: Sat, 10 Oct 2026 12:00:01 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/3] perf symbol: Fix symbol loading from libbfd
Message-ID: <asqLMeHEdlOHOfp9@z2>
References: <20261010182439.9732-1-namhyung@kernel.org>
 <sashiko-outbox-166827@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-166827@kernel.org>

On Sat, Oct 10, 2026 at 06:36:17PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] perf test: pe-file-parsing breaks due to dso__load_bfd_symbols() return value change
> --
> 
> commit 5ad4f779ca47fdb7586a43ebe4942962c3038922
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf symbol: Fix symbol loading from libbfd
> 
> This commit modifies dso__load_bfd_symbols() to return a positive number
> representing the number of loaded symbols instead of 0 on success. The caller
> in dso__load() is also updated to check for this positive return value.
> 
> Closes: https://lore.kernel.org/r/sashiko-outbox-162540@kernel.org
> Fixes: eac9a4342e5447cad ("perf symbols: Try reading the symbol table with libbfd")
> 
> > diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
> > index 33dc6158b2b1f..c2462b54b0e56 100644
> > --- a/tools/perf/util/libbfd.c
> > +++ b/tools/perf/util/libbfd.c
> > @@ -411,7 +411,7 @@ int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
> >  	symbols__fixup_duplicate(dso__symbols(dso));
> >  	dso__set_adjust_symbols(dso, true);
> >  
> > -	err = 0;
> > +	err = dso__has_symbols(dso);
> 
> [Severity: Medium]
> Does this change break the pe-file-parsing perf test?
> 
> Looking at the pe-file-parsing test in tools/perf/tests/pe-file-parsing.c
> inside run_dir(), it still expects the old 0 return value for success:
> 
>     ret = dso__load_bfd_symbols(dso, debugfile);
>     TEST_ASSERT_VAL("Failed to load symbols", ret == 0);
> 
> Since dso__has_symbols() evaluates to a positive number when symbols exist,
> won't this cause the test suite to unconditionally fail when analyzing valid
> PE files?

Oops, completely missed that.  Will update.

Thanks,
Namhyung
