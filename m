Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33A036AF6;
	Tue, 26 May 2026 00:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779755662; cv=none; b=Hrdnkg6nGH8JrHwkP1jaQGtCyNWURzPvB6O5kgnyEDn34iLLbBbh9YQEuEROAIAltsX6TjOVimyhgrAx0YNZVA560CrpuQlCUjnL7osaMEGCNYtAXQ3MmisU0Jkhr4o1YoqlUNSuAIjsb+q8D+61ica35VQ5oWr4wCrjuGiM3jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779755662; c=relaxed/simple;
	bh=935//ou58ZaFH6w8EGgmBV9yH2kFv3Tr0FgHUlxe1UI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJFTywKn5W4ylQlySRs868m+ELD8jB98aIAUQsiMLbjtds86JjxVht1QKyXE3FyXatqjvIQKl5JWZLHjsmRUeGVlQwsUB9LVlpwPlyADt9penykbRQ1BhDQLaW3xMJ+SGqIArKXMg6F4VsOjKxnW1f9U6QFFqHIAFAWaFtkATAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNsx6HUU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNsx6HUU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B1C1F000E9;
	Tue, 26 May 2026 00:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779755661;
	bh=0euLdxJnWy0EoxKDZrB4CSHo7mPetTf1x1QsmKsxErs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nNsx6HUUrBFi1hstkNcO6rfTFM6VKyf23dX5e/5h9sw5LaG+20/FtCnYANJmHVMxL
	 Zy7NV8yGNYZ30ubtmiZTkJxeofpy1QJyvWlQPp46UH7egFpCAkVQ6W81mB12VnkXUu
	 ayhHPM52ILxNsNalIjA5KJCnW/GSEtE1/0HaVhV1TbHI8/morqLwraLvxHnRqx9bIu
	 HzlHcCA0LA79933C9k5Liacf1G7kBLk9+SFjeO1HLeTmGDGIzITNmGlsiMYWAcJcts
	 6fjRT32ONMvjFel9AkbTOkcvRxpBYxbtryXrVIHtz/MpRsDfFIiaipi6gBNGDOQ25Q
	 ZHjDk5EUsMIog==
Date: Mon, 25 May 2026 19:34:17 -0500
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, alice.mei.rogers@gmail.com,
	dapeng1.mi@linux.intel.com, james.clark@linaro.org,
	leo.yan@linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Subject: Re: [PATCH v9 01/23] perf arch arm: Sort includes and add missed
 explicit dependencies
Message-ID: <ahTqiZ_EQXR3PFxp@google.com>
References: <20260428071903.1886173-1-irogers@google.com>
 <20260522220435.2378363-1-irogers@google.com>
 <20260522220435.2378363-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260522220435.2378363-2-irogers@google.com>

On Fri, May 22, 2026 at 03:04:12PM -0700, Ian Rogers wrote:
> Fix missing #includes found while cleaning the evsel/evlist header
> files. Sort the remaining header files for consistency with the rest
> of the code.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/arch/arm/util/cs-etm.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index b7a839de8707..cdf8e3e60606 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -3,10 +3,13 @@
>   * Copyright(C) 2015 Linaro Limited. All rights reserved.
>   * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
>   */
> +#include "../../../util/cs-etm.h"
> +
> +#include <errno.h>
> +#include <stdlib.h>
>  
> -#include <api/fs/fs.h>
> -#include <linux/bits.h>
>  #include <linux/bitops.h>
> +#include <linux/bits.h>
>  #include <linux/compiler.h>
>  #include <linux/coresight-pmu.h>
>  #include <linux/kernel.h>
> @@ -14,25 +17,24 @@
>  #include <linux/string.h>
>  #include <linux/types.h>
>  #include <linux/zalloc.h>
> +#include <sys/stat.h>
> +
> +#include <api/fs/fs.h>
> +#include <internal/lib.h> // page_size
>  
> -#include "cs-etm.h"
> -#include "../../../util/debug.h"
> -#include "../../../util/record.h"
>  #include "../../../util/auxtrace.h"
>  #include "../../../util/cpumap.h"
> +#include "../../../util/debug.h"
>  #include "../../../util/event.h"
>  #include "../../../util/evlist.h"
>  #include "../../../util/evsel.h"
> -#include "../../../util/perf_api_probe.h"
>  #include "../../../util/evsel_config.h"
> +#include "../../../util/perf_api_probe.h"
> +#include "../../../util/pmu.h"
>  #include "../../../util/pmus.h"
> -#include "../../../util/cs-etm.h"
> -#include <internal/lib.h> // page_size
> +#include "../../../util/record.h"
>  #include "../../../util/session.h"
> -
> -#include <errno.h>
> -#include <stdlib.h>
> -#include <sys/stat.h>
> +#include "cs-etm.h"
>  
>  struct cs_etm_recording {
>  	struct auxtrace_record	itr;
> -- 
> 2.54.0.794.g4f17f83d09-goog
> 
