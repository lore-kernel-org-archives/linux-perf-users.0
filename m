Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACC92DC344
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 22:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780610569; cv=none; b=lnGy3Lt5xHJ20ExVlPsNHNJXTegjdrhoKRJizzQFYc59CfPomZoN2eauFOD9veUQbn1hBddx00xoiksKdt2yUal+ZcbJNkfmZdnzayFIu9ftoD7uRY4GhHlUyid1Gs8lvuJyNqUZjHTcE/sjpImPeHz45KyaLQFtBcKh10u+bsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780610569; c=relaxed/simple;
	bh=t1DtZI2laHv1yfWK5kuKYq9PmmcalAdjEEZ95MMNCig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYxXUUcBD997GRu6B7QiZ+LGULODo/tvw+Nfsuh4Nmrd8ImMuwVMZWMghtURTY/nLpzHmy9/N437IYF6bJjAyVUvEwms8F6UkdHsINoW/YyB6OeC/IT8pbS54nzIH80lwxay6hLwXBNNqJJzHJGc2WZckN2Sf8sSHN3DOqCGQgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwz9qbkz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwz9qbkz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152C61F0089B;
	Thu,  4 Jun 2026 22:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780610568;
	bh=sYFd5mjW+3GpnWug9qUuFEOQy1mvxVurKdO28/objfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lwz9qbkz1Y5uzc2JmHF/5O6RSHbG/5WqZ2ncx7WzWQCcNP9CToN09cOpLr7n7y9xz
	 bhAjccIIknQlB5XLBqo7HgQ1sxVYYcpbBn6hKm7mx04IHGo3CvcO7o3yGrDdCPb6yt
	 6Fvm4ZCMdIHvh0ecZ0Y12AdCiOJfrF8NNlCPXmLAbWq1EdQ9BcOTRbeRo3WXwrNEZd
	 6fsKjefheWlxWCLlRK6/46m3VuNlbtnT5qIt2ZRuM+FahaMqB+KpIMvvJo529EiWNJ
	 ekz2OsNueROEimfC5E/tPssFFV9gXQBdD5mW5tFMWp+X01KolEJd4OJrcKTMNnc0gc
	 ByQleMb4XZg8A==
Date: Thu, 4 Jun 2026 15:02:46 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
	irogers@google.com, linux-perf-users@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com,
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com,
	shivani@linux.ibm.com
Subject: Re: [PATCH V4 2/2] tools/perf: Use scnprintf in buffer offset
 calculations
Message-ID: <aiH2BnKXmur79SSR@google.com>
References: <20260504154205.21394-1-atrajeev@linux.ibm.com>
 <20260504154205.21394-2-atrajeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260504154205.21394-2-atrajeev@linux.ibm.com>

On Mon, May 04, 2026 at 09:12:05PM +0530, Athira Rajeev wrote:
> Replace snprintf with scnprintf in buffer offset calculations to
> ensure the 'used' count will not exceed the "len".
> 
> The current logic in perf_pmu__for_each_event uses an unconditional
> + 1 increment to buf_used to account for null terminators. This can
> cause a a stack buffer overflow in the subsequent scnprintf call.
> When the local stack buffer buf (1024 bytes) is full, buf_used can
> reach 1025. This causes the subsequent remaining space calculation
> sizeof(buf) - buf_used to underflow.
> 
> Use sub_non_neg() to see if space actually existed, and only
> increment the offset if remaning space is present.
> 
> Changes includes:
> - Use sub_non_neg to check if space exists
> - Replacing snprintf with scnprintf to ensure the return value
> reflects the actual bytes written into the buffer.
> - Only increment buf_used by 1 if space exists
> - If a parameterized event uses a built-in perf keyword for its
> parameter name (eg, config=?), the lexer parses it as a predefined
> term token, which sets term->config to NULL. Add check to use
> parse_events__term_type_str() if term->config is NULL.
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> ---
> Changelog:
> v2 -> v3:
> - Split the scnprintf related changes in separate patch
> - Handle the overflow issues and unconditional increment
> wrapped around sub_non_neg addressing review comment from Sashiko
> 
>  tools/perf/util/pmu.c | 46 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 35 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 0b8d58543f17..4b9ade1a4cf9 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -2129,15 +2129,19 @@ static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
>  		pr_err("Failure to parse '%s' terms '%s': %d\n",
>  			alias->name, alias->terms, ret);
>  		parse_events_terms__exit(&terms);
> -		snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, alias->name);
> +		scnprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, alias->name);
>  		return buf;
>  	}
> -	used = snprintf(buf, len, "%.*s/%s", (int)pmu_name_len, pmu->name, alias->name);
> +	used = scnprintf(buf, len, "%.*s/%s", (int)pmu_name_len, pmu->name, alias->name);
>  
>  	list_for_each_entry(term, &terms.terms, list) {
> +		const char *name = term->config;
> +
> +		if (!name)
> +			name = parse_events__term_type_str(term->type_term);
>  		if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR)
> -			used += snprintf(buf + used, sub_non_neg(len, used),
> -					",%s=%s", term->config,
> +			used += scnprintf(buf + used, sub_non_neg(len, used),
> +					",%s=%s", name,
>  					term->val.str);
>  	}
>  	parse_events_terms__exit(&terms);
> @@ -2201,6 +2205,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
>  	int ret = 0;
>  	struct hashmap_entry *entry;
>  	size_t bkt;
> +	size_t size_rem, len;
>  
>  	if (perf_pmu__is_tracepoint(pmu))
>  		return tp_pmu__for_each_event(pmu, state, cb);
> @@ -2234,17 +2239,36 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
>  			}
>  			buf_used = strlen(buf) + 1;
>  		}
> +
>  		info.scale_unit = NULL;
>  		if (strlen(event->unit) || event->scale != 1.0) {
> -			info.scale_unit = buf + buf_used;
> -			buf_used += snprintf(buf + buf_used, sizeof(buf) - buf_used,
> -					"%G%s", event->scale, event->unit) + 1;
> +			/* Check the remaining space */
> +			size_rem = sub_non_neg(sizeof(buf), buf_used);
> +
> +			if (size_rem > 0) {
> +				info.scale_unit = buf + buf_used;
> +				len = scnprintf(buf + buf_used, size_rem, "%G%s",
> +						event->scale, event->unit);
> +				/*
> +				 * Increment buf_used by 1 only if
> +				 * it fits remaining space
> +				 */
> +				buf_used += min(len + 1, size_rem);

Hmm.. it seems scnprintf() cannot return a number greater than or equal
to size_rem.  Can we just do like this?

			buf_used += scnprintf(...) + 1;

Thanks,
Namhyung

> +			}
>  		}
>  		info.desc = event->desc;
>  		info.long_desc = event->long_desc;
> -		info.encoding_desc = buf + buf_used;
> -		buf_used += snprintf(buf + buf_used, sizeof(buf) - buf_used,
> -				"%.*s/%s/", (int)pmu_name_len, info.pmu_name, event->terms) + 1;
> +		info.encoding_desc = NULL;
> +
> +		/* Check the remaining space */
> +		size_rem = sub_non_neg(sizeof(buf), buf_used);
> +		if (size_rem > 0) {
> +			info.encoding_desc = buf + buf_used;
> +			len = scnprintf(buf + buf_used, size_rem, "%.*s/%s/",
> +					(int)pmu_name_len, info.pmu_name, event->terms);
> +			buf_used += min(len + 1, size_rem);
> +		}
> +
>  		info.str = event->terms;
>  		info.topic = event->topic;
>  		info.deprecated = perf_pmu_alias__check_deprecated(pmu, event);
> @@ -2254,7 +2278,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
>  	}
>  	if (pmu->selectable) {
>  		info.name = buf;
> -		snprintf(buf, sizeof(buf), "%s//", pmu->name);
> +		scnprintf(buf, sizeof(buf), "%s//", pmu->name);
>  		info.alias = NULL;
>  		info.scale_unit = NULL;
>  		info.desc = NULL;
> -- 
> 2.47.3
> 
