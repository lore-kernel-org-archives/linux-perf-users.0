Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6192DC789;
	Wed, 24 Jun 2026 23:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782344951; cv=none; b=FarxIF0vamE5sRquXpx6SazDI/b6BqQ+by7SUHv57+zTmg7L5FOo1E/QMxHxWpw5BRC+XkD3NwlGX2xxTlLXEdRHt1iYlwIIXGlNfvrnvRYOQPWYDjJLIkITB+gNSe5PxmjGFuDHcE9WZB3X4BCDPQjra9nfGkkg5lentNEAqmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782344951; c=relaxed/simple;
	bh=Bos8h/wIWKj1hYmc7bqAvuGNsHUMA9l4crdvho3r/jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1c92VCGoFTpeJ49F17tEc1+AOvi9ZVDXGhP1BAFZ9TA/ECB4nTJA9jQSgGDYJfVDoj3mli+riuC3AD5BYkuwU9qP16yAyad4j3In3yl5j2NaUlRfL9TxPgDhvgZTQcmNjqwEoGRVTwCna7D+OntwoVk87HXl96X65oKt/+Rwn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtTqswWc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtTqswWc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28C81F000E9;
	Wed, 24 Jun 2026 23:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782344950;
	bh=QsvrGUB+3uXt6HwwW33islRbZppEIj1dGEWCC13DDa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TtTqswWcitJjt+85IZjWd8XzPxycAbtSzJDRIRdAcNlYofPNdAtubTNlfCkuNrZ8k
	 FYb1riPUFi6s4WXPp2BF5xvsl7ohRif5YQ9QoD08zEhA/4GR6SFQTymNINNaPU+87r
	 dfJld1UzDBpp8Q+SEhFmVkx0knLN9vd38cbA+cC1qnzpz/brlmoI5btKYzW9ntjn59
	 L84YoAJ86OydkQi86JMc79S9EFwKVr6BukB2JICcAAuse/DNTlLaE8ojFjwsa/IfDn
	 iEjR06ApYHJipx2EM2VVvWBZbvY6TMbJIWZ7d5126pHdforbRUvhy/+lf2GT3kzU0K
	 8v3WTCoFtJaZA==
Date: Wed, 24 Jun 2026 16:49:08 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 6/8] perf timechart: Fix memory leaks during record
Message-ID: <ajxs9PNznL1mLUFR@google.com>
References: <20260624205852.3864874-1-namhyung@kernel.org>
 <20260624205852.3864874-7-namhyung@kernel.org>
 <20260624210644.F1FEE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260624210644.F1FEE1F000E9@smtp.kernel.org>

On Wed, Jun 24, 2026 at 09:06:44PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Missing explicit POSIX header inclusion for `free()` (musl compatibility guide violation)
> --
> 
> commit e9f4fbcd6ed720db9d6b0daaf8a565c9bbbd415e
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf timechart: Fix memory leaks during record
> 
> The command line options can be passed without copy as their lifetime is
> limited within the same function.
> 
> > diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
> > index 27d17268395ed..a73f0ab22fd64 100644
> > --- a/tools/perf/builtin-timechart.c
> > +++ b/tools/perf/builtin-timechart.c
> [ ... ]
> > @@ -1891,7 +1892,11 @@ static int timechart__io_record(int argc, const char **argv, const char *output_
> >  	for (i = 0; i < (unsigned int)argc; i++)
> >  		*p++ = argv[i];
> >  
> > -	return cmd_record(rec_argc, rec_argv);
> > +	ret = cmd_record(rec_argc, rec_argv);
> > +
> > +	free(rec_argv);
> > +	free(filter);
> 
> [Severity: Medium]
> Does this code need an explicit inclusion of <stdlib.h> at the top of the
> file?
> 
> The perf subsystem musl compatibility guidelines mention that files using
> POSIX libc functions must explicitly include the relevant headers, as musl
> strictly separates declarations unlike glibc. Could these new free() calls
> cause a build failure on systems using musl libc if the header is omitted?

While it may be a valid concern, the free() function is already used in
many places of the file.  And I didn't get any reports about musl on
this yet.  So I think it's good to go.

Thanks,
Namhyung

