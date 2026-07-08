Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493473998BE;
	Wed,  8 Jul 2026 23:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783554197; cv=none; b=J4SaNcc9oqVXLEEhJ4AsxdRvgqqgpMwg+wQh4w5sBdnR2D+EHaW9uppVeb6TejUpgSJe7EgeWvGifkioKIjBUD9dtcVHN1jDFItNUIocvG6hNzKQRB6B4IUQbrLq7hg+tGTp0rdn1nKgC8j3AHPvoHS324ZiNAYMa0QRByG9NKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783554197; c=relaxed/simple;
	bh=dKV40IkxDFvmXmyaFKNM4Wn+2KdWPEgXVAwjkUlxr70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obv0nX5B+Cx1YYk1twR8yIB93AVAcqUUS8Otp532x5i9dqqJ7Iq/l7M4QvPb6/YIp7vubJVXh/M+Xn4TO+nygQiem7YlCTbMnjWhGgnFOnGc+17WDrY39TxlSW5L+7oB41r6Vg6OLFXn7S7bCC7HQY6NWUa58ekduCgbnRAJxk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ay4w8p/b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ay4w8p/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF1F1F000E9;
	Wed,  8 Jul 2026 23:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783554195;
	bh=T6E2V2liXmf3D3Qf+A1o/ILW3dsRFuxf1/QLUD09rsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ay4w8p/bKgNDb/e76PamgunNTyVcWHWKyuML8nOYz9HxthGDTLGbwkhOvLL9jQMbx
	 +visb2lLHvBDKeQcB9bABtUgt97QBHuJYEyT+Jn/Z0Z2qWaL2As6tNCbdaxhSmZSnA
	 Ei60zuxlBFYwEIXsF11jUVpJgjNBGPCRnE7oIA5M8GD92h7rGwIMwThM/hyMpm1Jni
	 GeTvh+Z1zYfx88ixuVS5gQMrW/ESdCG03S3JJrlakGxx9K3z8ZNl1LyuZNtimGxqUu
	 sQOS37wrsDUB7eM2aVbitUsGTx+6U68JwGslVJnukXexRZ6z/97rlp1zTRfd/MMku+
	 4uC7WhOSVyIww==
Date: Wed, 8 Jul 2026 16:43:13 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Ivan Lazaric <ivan.lazaric1@gmail.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf stat: reject --field-separator and --json-output
 combination
Message-ID: <ak7gkZaEahlRlgvA@google.com>
References: <ak3scJT4MfbAg0G4@google.com>
 <20260708131359.71732-3-ivan.lazaric1@gmail.com>
 <20260708133656.107611F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260708133656.107611F000E9@smtp.kernel.org>

On Wed, Jul 08, 2026 at 01:36:55PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Missing explicit inclusion of `<stdio.h>` for standard I/O functions and types.
> --
> 
> --- Patch [1]: [PATCH v2] perf stat: reject --field-separator and --json-output combination ---
> commit 14ca4ce3700a93ed48a3336a633292f7e45ae462
> Author: Ivan Lazaric <ivan.lazaric1@gmail.com>
> 
> perf stat: reject --field-separator and --json-output combination
> 
> This patch explicitly rejects using both the --field-separator and
> --json-output options in perf stat. It adds a check to output an error
> message and exit cleanly, preventing malformed mixed formats.
> 
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index a04466ea3b0a0..6ec82752d71c6 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -2643,6 +2643,13 @@ int cmd_stat(int argc, const char **argv)
> >  
> >  	stat_config.aggr_mode = opt_aggr_mode_to_aggr_mode(&opt_mode);
> >  
> > +	if (stat_config.csv_sep && stat_config.json_output) {
> > +		fprintf(stderr, "cannot use both --field-separator and --json-output\n");
>                 ^^^^^^^
> 
> [Severity: Low]
> Could this cause a build failure when compiling perf with musl libc?
> 
> While glibc often implicitly includes standard headers, musl has stricter
> header separation.
> 
> Since this code introduces a new call to fprintf and uses stderr, does
> builtin-stat.c need an explicit #include <stdio.h> in its global includes
> block to guarantee musl compatibility?

It should be fine as it's used in other places already.

Thanks,
Namhyung

> 
> > +		parse_options_usage(stat_usage, stat_options, "x", 1);
> > +		parse_options_usage(NULL, stat_options, "j", 1);
> > +		goto out;
> > +	}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260708131359.71732-3-ivan.lazaric1@gmail.com?part=1
