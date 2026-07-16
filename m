Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4874309EFA
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 04:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784176926; cv=none; b=fyLhTI+Dk2IPLXuSqMKAHr2p13hOFAvxaT8NRfF3+77McnzuMnPZNf5bcek0SbYc2ASGQVgwmXgbuIE/CNXcPKK6mnCMZjGny1wO26GJhglGTMCW/Xk6MNi7gCO2G4CJQln3GdAllVg3mtpvCfHnO0N4Q6VLkI3/mC52za8ylnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784176926; c=relaxed/simple;
	bh=cM6SoU4P7qe+uz2EsC0YvUUqsujLPKq3A87LyWT1qHY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=av6cfHW4+mk7WrzKHN0H21IaJWvEcv6zeW/i7hzac1wqozO3n21xzCuiNEIkZdtpyeRcNqAm58VeR+e8qyi+YO09Kjifn4QBcMqjd+WNPNJmfdJe3yXyQiuVo3r1CCIhN5lZPc/Nyr4YITzPdyxVtJZqx+WeWVb2uDHBkPKQl6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLzm4dLI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLzm4dLI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A39F1F000E9;
	Thu, 16 Jul 2026 04:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784176925;
	bh=EdaJsUpCY5YWtkBFqU7alv+yC5avjHMkMoBmFwLa10Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DLzm4dLIQXJAXcRkzAw4E0UGcNpRD03Hdw26qXN2j1hkYa+R07qnKWhNdfa6RG+5a
	 Ak8VyPCYa5XTQ9/vYFmX9xwaBGWJ3XcCmIDg6e7cY3C0e1H51JkN5GlrSA9qeBod+y
	 qbfNGIELF09HIcfnjEPbdV1jIBFzX2nPW0BkevyzFBc/ytqjDiufYw/jX/uPsLSYZ8
	 lkldoh4iBwhyhgqMmEo6ickQ6zX/IU75GvOB+NxStIlIQNcFljMA10I2uv/6g1ac6k
	 UMAXl5yT6n2SVvIAnZFBo6gX69kdAQeXFKV95qAlkpKrQnZkIjX3csMIstto3j0/GC
	 SDEBB4rQO8aQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/14] perf stat: Extend STD output linter to test
 basic New API checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260716043223.388233-4-irogers@google.com>
References: <20260525231900.3527228-1-irogers@google.com>
 <20260716043223.388233-1-irogers@google.com>
 <20260716043223.388233-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 04:42:04 +0000
Message-Id: <20260716044205.1A39F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing explicit POSIX headers (`<time.h>`, `<sys/time.h>`, `<sys/r=
esource.h>`) required for struct definitions in `stat-print-std.c`.
--

--- Patch [3]: [PATCH v3 03/14] perf stat: Extend STD output linter to test=
 basic New API checks ---
commit 388aec1d9173e9ef9de1f0a805bf06f934582952
Author: Ian Rogers <irogers@google.com>

perf stat: Extend STD output linter to test basic New API checks

This patch extends the standard console (STD) output linter script
to run the basic no-argument check a second time using the --new print flag.
This ensures that standard console outputs produced by the decoupled
printing callbacks are formally validated by the test suite.

> diff --git a/tools/perf/util/stat-print-std.c b/tools/perf/util/stat-prin=
t-std.c
> new file mode 100644
> index 0000000000000..eb841a729e9ec
> --- /dev/null
> +++ b/tools/perf/util/stat-print-std.c
> @@ -0,0 +1,828 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <errno.h>
> +#include <math.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>

[ ... ]

> +#define USEC_PER_SEC 1000000ULL
> +#define NSEC_PER_SEC 1000000000ULL
> +
> +static double timeval2double(struct timeval *t)

[Severity: Low]
Could this cause a build regression by missing explicit includes for POSIX
structures needed to support musl libc?

The code in tools/perf/util/stat-print-std.c uses struct timeval in
timeval2double(), which requires <sys/time.h>. Additionally:
- struct rusage (via ru_data) in print_footer_std() requires <sys/resource.=
h>
- struct timespec used in perf_stat__print_std() requires <time.h>

Without these explicit POSIX headers, compilation on systems using musl libc
may fail due to incomplete types.

> +{
> +	return t->tv_sec + (double)t->tv_usec / USEC_PER_SEC;
> +}
> +
> +static void print_footer_std(const struct perf_stat_config *config)
> +{
> +	double avg =3D avg_stats(config->walltime_nsecs_stats) / NSEC_PER_SEC;
> +	FILE *output =3D config->output;

[ ... ]

> +		if (config->ru_display) {
> +			double ru_utime =3D
> +				timeval2double((struct timeval *)&config->ru_data.ru_utime);

[ ... ]

> +int perf_stat__print_std(struct evlist *evlist, const struct perf_stat_c=
onfig *config,
> +			 const struct target *target, const struct timespec *ts, int argc,
> +			 const char **argv)
> +{

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716043223.3882=
33-1-irogers@google.com?part=3D3
