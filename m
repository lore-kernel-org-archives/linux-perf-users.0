Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE90427E1A7;
	Tue,  4 Mar 2025 15:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101369; cv=none; b=Mhd1OeZga/ikxRrT0G5egOagYNlUE4gjlURF26dgA0Jaz8n/2t5EK4D+VkQX411qY7TgVbbjXmRhLJ9HU5NJjwpurt43eRLIpuW6aTVoAR3aNWE+4MZP2cjOKMtLN76WVdHN6H40OmNnzW0xPAm41PN5UrtdJsvDPohN2MLZvKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101369; c=relaxed/simple;
	bh=3vs6fa+35UNMa4PxgO1HCbpblGveRjv4ZsbbxAKpvak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVAAjCaxumdUtE47QMftlJUtYM2KhqaBuVGECHPRoLoYC+J81/7VEa4nkQk+feMw0adJHRqorPFjk+k5VTh3YWGgREkVkIRcQ+HENUnGikQInaevgMFn3x0ixB3s6YB14NTB3QJ7SQ22UGAK1PnEcU6MEKoETC8rquVifAbuE3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1D3EFEC;
	Tue,  4 Mar 2025 07:16:20 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2BFE3F66E;
	Tue,  4 Mar 2025 07:16:06 -0800 (PST)
Date: Tue, 4 Mar 2025 15:16:04 +0000
From: Leo Yan <leo.yan@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Thomas Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH v2 5/6] perf test: Add timeout to datasym workload
Message-ID: <20250304151604.GB13418@e132581.arm.com>
References: <20250304022837.1877845-1-namhyung@kernel.org>
 <20250304022837.1877845-6-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304022837.1877845-6-namhyung@kernel.org>

On Mon, Mar 03, 2025 at 06:28:36PM -0800, Namhyung Kim wrote:
> Unlike others it has an infinite loop that make it annoying to call.
> Make it finish after 1 second and handle command-line argument to change
> the setting.
> 
> Cc: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Leo Yan <leo.yan@arm.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>

> ---
>  tools/perf/tests/workloads/datasym.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/workloads/datasym.c b/tools/perf/tests/workloads/datasym.c
> index 8e08fc75a973e5f7..8ddb2aa6a049e343 100644
> --- a/tools/perf/tests/workloads/datasym.c
> +++ b/tools/perf/tests/workloads/datasym.c
> @@ -1,3 +1,6 @@
> +#include <stdlib.h>
> +#include <signal.h>
> +#include <unistd.h>
>  #include <linux/compiler.h>
>  #include "../tests.h"
>  
> @@ -12,9 +15,25 @@ static buf buf1 = {
>  	.reserved[0] = 1,
>  };
>  
> -static int datasym(int argc __maybe_unused, const char **argv __maybe_unused)
> +static volatile sig_atomic_t done;
> +
> +static void sighandler(int sig __maybe_unused)
> +{
> +	done = 1;
> +}
> +
> +static int datasym(int argc, const char **argv)
>  {
> -	for (;;) {
> +	int sec = 1;
> +
> +	if (argc > 0)
> +		sec = atoi(argv[0]);
> +
> +	signal(SIGINT, sighandler);
> +	signal(SIGALRM, sighandler);
> +	alarm(sec);
> +
> +	while (!done) {
>  		buf1.data1++;
>  		if (buf1.data1 == 123) {
>  			/*
> -- 
> 2.48.1.711.g2feabab25a-goog
> 
