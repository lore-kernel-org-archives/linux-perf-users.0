Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC642F532C;
	Tue, 10 Mar 2026 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773154181; cv=none; b=NkmosyTG6QD8p9kxxJeV9TZNXigiIl2oB05En9g0jLYfE7heSBPRB3FChaRdlJfjfLUwHYwQpetmMrayb+CRnIZ6k2YAYDIn8AyvKZC9JYXrmnVKpQdAgL1+aYB/orbt+GMdZCYNy56V2ZTXvpGHjMo456KwURqJ9JGz/wSPOaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773154181; c=relaxed/simple;
	bh=laYhC56p5mdiuhVxVQmsdMjtbZDTDrkgcsfZiGmUU7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQxSTd83bckTiUww1qJO7VBrzidiHFfT1n/MGRzbGX469KkoUcho0aazZRQ3vdzX/D6dpvvNRGjIQ1qt9g0fLUfia4/YcERXoyG8CS9w8N2V7XetStXpfLKgnGeaCLK1Hyb5M4fGExe3BryT1P3s4MUX1gkfVK4jgIniHF3k/+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=us2OAWeS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="us2OAWeS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0B9C19423;
	Tue, 10 Mar 2026 14:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773154181;
	bh=laYhC56p5mdiuhVxVQmsdMjtbZDTDrkgcsfZiGmUU7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=us2OAWeSRmbqAICHkl56JCwNZWKEf9sD+10mShXhnSVjpCgwAWBKUX52hypRkMUSz
	 7qGWaRfOOpdSF+dOMp1dK+mloyntkkMdTn+u/Bz3AG4RJM5GEm3DXG/e88jTrAH2vm
	 g4oKLPD6LYdILFj6ZuVK4VX+bSIeUaTshu7GSHy2pi9zoetHHtDRI9glybh6kX5GGS
	 cWiYVrQmEICOI20wJ03x/8e/S+XmNfj3ij2xcqqUpQSMR3S0Wmu3PNUuVVfv639lHT
	 e7GoffQJAVEQaJUyiNu5rPEAJLRcgeMyGWcTyzvFZeFkg3H5W+e5t0iWYcu4l4109s
	 JMbsycRXB+ytw==
Date: Tue, 10 Mar 2026 11:49:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: linux-perf-users@vger.kernel.org, peterz@infradead.org,
	mingo@redhat.com, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
	tianyou.li@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf annotate: Fix hashmap__new() error checking
Message-ID: <abAvgbIoWbpTRCQ2@x1>
References: <20260306035648.1266660-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306035648.1266660-1-nichen@iscas.ac.cn>

On Fri, Mar 06, 2026 at 11:56:48AM +0800, Chen Ni wrote:
> The hashmap__new() function never returns NULL, it returns error
> pointers. Fix the error checking to match.
> 
> Additionally, set src->samples to NULL to prevent any later code from
> accidentally using the error pointer.
> 
> Fixes: d3e7cad6f36d ("perf annotate: Add a hashmap for symbol histogram")
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Thanks, applied to perf-tools, for v7.0.

- Arnaldo

> ---
> Changes in v2:
> - Set src->samples to NULL on error
> - Update commit message
> ---
>  tools/perf/util/annotate.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 2e3522905046..63f0ee9d4c03 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -44,6 +44,7 @@
>  #include "strbuf.h"
>  #include <regex.h>
>  #include <linux/bitops.h>
> +#include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/string.h>
>  #include <linux/zalloc.h>
> @@ -137,8 +138,10 @@ static int annotated_source__alloc_histograms(struct annotated_source *src,
>  		return -1;
>  
>  	src->samples = hashmap__new(sym_hist_hash, sym_hist_equal, NULL);
> -	if (src->samples == NULL)
> +	if (IS_ERR(src->samples)) {
>  		zfree(&src->histograms);
> +		src->samples = NULL;
> +	}
>  
>  	return src->histograms ? 0 : -1;
>  }
> -- 
> 2.25.1
