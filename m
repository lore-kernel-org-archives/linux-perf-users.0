Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429E58632B;
	Fri, 20 Jun 2025 19:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750448214; cv=none; b=rJgVZI6ZjdUAqxB8sqH4v45iWALBY6oWonHbZJFtwrLOjzIgtN0ouSimSFrbkZk58f5g2WGv3hBEVGy9j6XdsyRAE7kT8Q2DP7nTxeNq8ARAhGGkPj3G2F79p/eHJKBIvdyruTIOdjV9HDRHbZbbP8Gh06e0JTOiXKKH2vbxCK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750448214; c=relaxed/simple;
	bh=NvZm0pQnEMk9DM/K7roC2F0CdvDSkvQc1kyaCnfCCa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhYectIVfeBrnMKV591SkbiWEesCzT6RvWr8WZq9n5UZnBZuBx7HoebzT6g4W7wFDHlwTtGCNNCeiddX6xh+9DMYncbbSpakIlSSRMpaihHY6KIMpFMXUHXNuitXzmg0Kc/fvgUEvNWvh3vzW8MTDvHA4FzIXdIK8Jy11mdlMoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h77SFSCH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h77SFSCH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666B0C4CEE3;
	Fri, 20 Jun 2025 19:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750448213;
	bh=NvZm0pQnEMk9DM/K7roC2F0CdvDSkvQc1kyaCnfCCa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h77SFSCH+5ox59hry2GfbsJ2hgdHFJ4XoYwU8MrpLCwgvJzKv2T6qjwGOHDs3i8yy
	 L5vVklL4WZghlzKmLTV6ZUP6K6qpUgtWK3AJD3QtrVR6yOV96+0MwzQFCx7nXBd2ZJ
	 KVnnSjK+u+E1o03V/nhxoJXrXnnO70pFB3mHLXWn5eG4LkFSoUCeNpXums6Ou4pki+
	 lomB9bOTe+635bXH/+OPwCqh04oIr30UC+EaQyN1nN5xl4B/9STQcPelGRAn7qH0h5
	 xOpvY4S9WgGJn1hg/rzImHFeq0WEGnu++e9glEXQ9MZpamQeJ3ck/N0AWqgTVMFXDV
	 AGL0Am826IKjQ==
Date: Fri, 20 Jun 2025 12:36:52 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf test workload noploop: Name the noploop
 process
Message-ID: <aFW4VJtk96JD865U@google.com>
References: <20250619002034.97007-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250619002034.97007-1-irogers@google.com>

Hi Ian,

On Wed, Jun 18, 2025 at 05:20:33PM -0700, Ian Rogers wrote:
> Name the noploop process "perf-noploop" so that tests can easily check
> for its existence.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/workloads/noploop.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/tests/workloads/noploop.c b/tools/perf/tests/workloads/noploop.c
> index 940ea5910a84..8b954d466083 100644
> --- a/tools/perf/tests/workloads/noploop.c
> +++ b/tools/perf/tests/workloads/noploop.c
> @@ -2,6 +2,8 @@
>  #include <stdlib.h>
>  #include <signal.h>
>  #include <unistd.h>
> +#include <linux/prctl.h>
> +#include <sys/prctl.h>

I'm afraid it'd introduce a build failure on musl.  Please see

https://lore.kernel.org/linux-perf-users/20250611092542.F4ooE2FL@linutronix.de/

I think <sys/prctl.h> would be enough.

Thanks,
Namhyung


>  #include <linux/compiler.h>
>  #include "../tests.h"
>  
> @@ -16,6 +18,7 @@ static int noploop(int argc, const char **argv)
>  {
>  	int sec = 1;
>  
> +	prctl(PR_SET_NAME, "perf-noploop");
>  	if (argc > 0)
>  		sec = atoi(argv[0]);
>  
> -- 
> 2.50.0.rc2.701.gf1e915cc24-goog
> 
