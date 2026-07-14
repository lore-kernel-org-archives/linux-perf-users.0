Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214472EB5B8;
	Tue, 14 Jul 2026 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052376; cv=none; b=dSVlWyouqqBVYAEV0xSUFjdhjpL4PCeWaNJ5VZ+TECM2A9aeHM6JSEBASQSF763CQT9KzO8mojuzPdbtAu0iKJsBWeGd9IxNO6Oyx3govKTF1nVRuxDl+DHpiEMzijkDwn4iNR7zx4FcNHBgAwJkVDFpGweAxGAt4LWiyclkTBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052376; c=relaxed/simple;
	bh=MqTIqKE8i3oJgnhB0TQxad6yzf/GNJ8ai1PUUDoSG+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnL5rtie0hNefe2m1KoLCZSrIvJSxbVshi1s/9UV2eHwAXyCe1ZxD7OBII29FRKbai43J5UsGTXavC9KbXTuM/yWmT/0BDeBa+/QofQaBeKL/9mW6N6+AaaE+ODD8OS7uSM6cIeTZOW6AXWo/x0VLEOOoXDQYO1TXzXiDAMbtxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2rUzfup; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2rUzfup"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D341F000E9;
	Tue, 14 Jul 2026 18:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784052375;
	bh=Wv9lUpot9rOo4fXUhVR8uK7JY8xnzHat2ipvEU+zQWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j2rUzfupb5JmxjVa7T2VrJeAbdRHl6kbSj3db2F9D3tFybVkXWYmOkSriM+vajfXA
	 bL4u70zRxZUdlpPljyPVgQ0U7c+3Nab7s8uXD4+SNbgnFel3at7VmUuT9b5V2Ot62C
	 Lg2SLFz++ZoaZm1a9VGC853NVcprAgR2E4UeywaUb4gJ11wXuVzVIkPtrI/smAqJG2
	 Kr7fZBc85CnnTjFMeodgsyw7ppwB+saIxoo+QZvEjfTjmxZtEhNitnZla910Vo6f3K
	 GMjGBAqRH1Xa5HOgf7BPpGo8BFe8OBLB3BAEQvgFGqsCpwIruzfMPLCwDTASrEbzLM
	 3YRw+MVFTuvpg==
Date: Tue, 14 Jul 2026 11:06:12 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Wang Yan <wangyan01@kylinos.cn>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, leo.yan@arm.com, xiaqinxin@huawei.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf metricgroup: Fix memory leak of metric_name in
 metricgroup__copy_metric_events
Message-ID: <alZ6lOYQpwD5mweL@google.com>
References: <20260710032241.119031-1-wangyan01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260710032241.119031-1-wangyan01@kylinos.cn>

Hello,

On Fri, Jul 10, 2026 at 11:22:41AM +0800, Wang Yan wrote:
> In metricgroup__copy_metric_events(), new_expr->metric_name is allocated
> via strdup() but is not freed in all error paths, leading to a memory
> leak when subsequent allocations or evsel lookups fail.
> 
> Add the missing zfree() calls:
> 
>   - On strdup() failure, free the already allocated new_expr.
>   - On metric_refs allocation failure, free metric_name before freeing
>     new_expr.
>   - On metric_events allocation failure, free metric_name in addition
>     to existing freeing of metric_refs and new_expr.
>   - On evsel lookup failure, free metric_name along with the other
>     resources already freed.
> 
> Fixes: b214ba8c4275 ("perf tools: Copy metric events properly when expand cgroups")
> Signed-off-by: Wang Yan <wangyan01@kylinos.cn>

It's already fixed in 

https://lore.kernel.org/r/20260602081104.271325-1-pengyu@kylinos.cn

Thanks,
Namhyung

> ---
>  tools/perf/util/metricgroup.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 69bfa2a723b2..96dd780a5601 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1693,8 +1693,10 @@ int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
>  			new_expr->metric_expr = old_expr->metric_expr;
>  			new_expr->metric_threshold = old_expr->metric_threshold;
>  			new_expr->metric_name = strdup(old_expr->metric_name);
> -			if (!new_expr->metric_name)
> +			if (!new_expr->metric_name) {
> +				free(new_expr);
>  				return -ENOMEM;
> +			}
>  
>  			new_expr->metric_unit = old_expr->metric_unit;
>  			new_expr->runtime = old_expr->runtime;
> @@ -1707,6 +1709,7 @@ int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
>  				alloc_size = sizeof(*new_expr->metric_refs);
>  				new_expr->metric_refs = calloc(nr + 1, alloc_size);
>  				if (!new_expr->metric_refs) {
> +					zfree(&new_expr->metric_name);
>  					free(new_expr);
>  					return -ENOMEM;
>  				}
> @@ -1724,6 +1727,7 @@ int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
>  			new_expr->metric_events = calloc(nr + 1, alloc_size);
>  			if (!new_expr->metric_events) {
>  				zfree(&new_expr->metric_refs);
> +				zfree(&new_expr->metric_name);
>  				free(new_expr);
>  				return -ENOMEM;
>  			}
> @@ -1735,6 +1739,7 @@ int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
>  				if (evsel == NULL) {
>  					zfree(&new_expr->metric_events);
>  					zfree(&new_expr->metric_refs);
> +					zfree(&new_expr->metric_name);
>  					free(new_expr);
>  					return -EINVAL;
>  				}
> -- 
> 2.25.1
> 
