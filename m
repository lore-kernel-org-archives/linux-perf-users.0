Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D371733ADA9;
	Mon, 25 May 2026 15:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723924; cv=none; b=uE6dlL6Rk/J57R3MPzBCcW/Xv6IgbOf55InpSJmnRErJev5YlRJXhjR8VGLHoBfHgrFepZeV4gPuS8ph/Pq1/Q3tVLaILCuT2mqNCWhb6cIQncgZMLb0dEAnMGLyny0fYW44456/Nb9Oim8CvTqJY/zZx/FLK/qA50c5nQ+KwcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723924; c=relaxed/simple;
	bh=tsk7c+xNRQWxd+2F2/KyoRrsk/LaWAX5ky7gPyKUE1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSK2QCcUNJH9+MpIy79iU4jjoHKPnzTYX/E2sAIp/68go9GvJGOnFSitgvOvuRsQieAE7qz5dlEZioAG1HI+4j2SlV1/fu2dUQExyiHQgIcXtKp6v8hdjXLQMhfMeVGEN9VEhRSpgFKCKPtUcANjPActtxvibLKlufqOr4FQ7FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4IskNiH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4IskNiH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247341F000E9;
	Mon, 25 May 2026 15:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779723923;
	bh=AJOefHgmNw499YkKpfbnitpmfqsTc3lb2urchf/cgOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J4IskNiHIae3Qp1q7cAcYwyGThpXT2wlPajfbU5PhysN7+2ydpiAi6SjIHejp9Dlw
	 bH6VqmxGf75BmYXlFH4GnKIIlu2S9sEUwVVBSoMguCgUsSTpOaCIWDAd8nzIluAbvz
	 0pEVnkcBOACPZptcNbAopmVZGIhhJ3VMML4JmIX843uJ2FGEUjRJeeHsm4md1eeOVF
	 F+RHj6wsIK25M52MlpWs9W3Yo+njdMvl6tPYKkvJPFH+xWj9RcFP3/U9iAodO8NAVC
	 TkzvYTSY+KYYslz2CdvuRdxRBrtgpx7yhEhNaxULc5ieb7upToGucG3DmgyBvVMtT6
	 3ShdBz28JQ+LA==
Date: Mon, 25 May 2026 12:45:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/3] perf trace: Include copied headers in the beauty
 directory
Message-ID: <ahRukLitz4NR6lMC@x1>
References: <20260525011133.179130-1-namhyung@kernel.org>
 <20260525013129.F04641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525013129.F04641F000E9@smtp.kernel.org>

On Mon, May 25, 2026 at 01:31:29AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The copied UAPI header `fcntl.h` includes `<linux/openat2.h>`, which was not copied into the `tools/include/uapi/linux/` directory, causing build failures on older host systems.
> --
> 
> commit 7bb011deeef80e2496028a3477432fac108a240f
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf trace: Include copied headers in the beauty directory
> 
> This commit updates the trace beauty scripts to use local copies of UAPI 
> kernel headers directly, rather than relying on system headers or manual 
> macro definitions.
> 
> > diff --git a/tools/perf/trace/beauty/fcntl.c b/tools/perf/trace/beauty/fcntl.c
> > index e1b99b8f55eb0..10fd6a2b75c35 100644
> > --- a/tools/perf/trace/beauty/fcntl.c
> > +++ b/tools/perf/trace/beauty/fcntl.c
> [ ... ]
> > -#include "trace/beauty/beauty.h"
> >  #include <linux/kernel.h>
> > -#include <linux/fcntl.h>
> [ ... ]
> > +#include "trace/beauty/beauty.h"
> > +#include "trace/beauty/include/uapi/linux/fcntl.h"
> 
> [Severity: Low]
> Will this cause a build failure on systems with older kernel headers?
> 
> The newly copied uapi/linux/fcntl.h includes <linux/openat2.h>, but it 
> appears openat2.h was not copied into the tools directory. On build 
> environments with kernel headers older than v5.6, the compiler will fall 
> back to the host system's include paths, fail to find linux/openat2.h, 
> and halt the build.
> 
> Should linux/openat2.h also be copied into the tools include directory to
> prevent this?

So, this is exactly the kind of dependencies I mentioned in my reply to
you :-)

- Arnaldo
