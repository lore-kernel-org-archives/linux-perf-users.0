Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C5C347BC6
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 15:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464727; cv=none; b=Vu5YWQddj/s2UTec5IffbCM/uzfGcTjfabNq/cOgOGIm0NfevSR4VYotnySYirYyto/oqmVb3qKMKwb53DOhANNh2Ll/EBhPMWnEYMPV1ISsDDSqE7RvcxpDA9YL2Ur8e7zYc9AQdR7jPRQB2SunNic2FIx/egxLBg05HK4++zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464727; c=relaxed/simple;
	bh=3Q/n8EEkHHg4Yom+piT9XqUrx50mK1UNzeu3REH8lhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdcBxdCaJ79nLFDyiVVSK5dzxFmRpUw4CX8UgmxbwLlyOnpfMUvQSDhKEg0bRbGKIMs8JzrMXFkq3+5/ZRzQc0IHZsez58emC/4g7sqS/Ho/9Z+Qa8bldzYGMvQM9Riu1SF2DVc1iaBH3bS3N/ug2xA+ljOCFoTjOcaaywYyYFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KJ+upK0n; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KJ+upK0n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779464724; x=1811000724;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3Q/n8EEkHHg4Yom+piT9XqUrx50mK1UNzeu3REH8lhU=;
  b=KJ+upK0nS0hY0d7qGHX8umMV/c+9sYXUuhnZmC9g7mxFlT/6y2fOvn0i
   jp/MkcDb717oDSh7nTU9UN/GxFlVf1zxh1PLunrCbVkdQwUVMu+dmCVss
   seG9YkE62HRmL7oy5faU15i5kfbz6RMKXaWpTx/mpyCmCw9n0onZ+1Vvh
   OdDKVu4QlmyPKAZHycusYJ6qpHNnnyK422lXVbSAyEt9NTqLkMJzcodqW
   J6ZvDLocMh2w26SaWdRrr1CJqbB4phZuf4Jko93Rc12J7a3dzv7CSOdUq
   f/8GvdnvL6tlckmBBe4FYo9r7TGwgsUQGBMTWe4LLrz6aUr7zHXeJkNs6
   A==;
X-CSE-ConnectionGUID: B0gG2MNnRkGy+a+Kn7pRxQ==
X-CSE-MsgGUID: Z0TwUYanSrulvwCYgHw0jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="79429608"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="79429608"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 08:45:23 -0700
X-CSE-ConnectionGUID: 8KEXdqAvR4SzBXAWmyOojQ==
X-CSE-MsgGUID: Hq+3ZymNRqqd3ahIwrgVdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="245228911"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 08:45:23 -0700
Date: Fri, 22 May 2026 08:45:18 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org
Subject: [PING] Re: [PATCH v2] perf stat: Make metric only column line up
 with header
Message-ID: <ahB6DmlNJfxqCB7q@tassilo>
References: <20260513144906.557896-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513144906.557896-1-ak@linux.intel.com>

Ping for the patch!

On Wed, May 13, 2026 at 07:49:06AM -0700, Andi Kleen wrote:
> Since some time the metric-only output columns are messed up and do not
> line up with the header, which makes it hard to read. I haven't bisected
> it, but presumably it was broken for some time.
> 
> There were multiple problems:
> - The dummy pm invocation at the beginning did print a bogus field
> - The column computation in pm did not agree with the header length
> - The color escape strings from highlighting confuse printf's field
>   length computation
> 
> Fix all those. I simplified the column width computation significantly,
> ignoring EVNAME_LEN, MGROUP_LEN, config->unit_width which don't
> seem to be useful in the metric only context. It now only uses
> the actual unit width as well as config->metric_only_len. The result
> is more code removed than added.
> 
> Before:
> 
> % perf stat --topdown -a -I 1000
> +           time %  tma_backend_bound %  tma_frontend_bound %  tma_bad_speculation      %  tma_retiring
>      1.000190386                                         45.5                   40.0                     5.3                     9.2
>      2.005185654                                         45.3                   40.1                     5.6                     9.0
>      3.009193207                                         45.4                   39.9                     5.6                     9.1
> 
> After:
> 
> % perf stat --topdown -a -I 1000
> +          time %  tma_backend_bound %  tma_frontend_bound %  tma_bad_speculation      %  tma_retiring
>      1.000810024                 46.3                 39.7                   5.3                 8.7
>      2.004800656                 45.8                 39.8                   5.4                 8.9
>      3.008804783                 46.0                 39.6                   5.4                 9.0
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> 
> ---
> 
> v2: Add missing headers removed by git because they started with #
> Remove unrelated hunk.
> ---
>  tools/perf/util/stat-display.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 993f4c4b8f44..2b69d238858c 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -580,16 +580,13 @@ static void print_metricgroup_header_std(struct perf_stat_config *config,
>  					 const char *metricgroup_name)
>  {
>  	struct outstate *os = ctx;
> -	int n;
>  
>  	if (!metricgroup_name) {
>  		__new_line_std(config, os);
>  		return;
>  	}
>  
> -	n = fprintf(config->output, " %*s", EVNAME_LEN, metricgroup_name);
> -
> -	fprintf(config->output, "%*s", MGROUP_LEN + config->unit_width + 2 - n, "");
> +	fprintf(config->output, " %*s", config->metric_only_len, metricgroup_name);
>  }
>  
>  static void print_metric_only(struct perf_stat_config *config,
> @@ -599,19 +596,20 @@ static void print_metric_only(struct perf_stat_config *config,
>  	struct outstate *os = ctx;
>  	FILE *out = os->fh;
>  	char str[1024];
> -	unsigned mlen = config->metric_only_len;
> +	unsigned mlen;
>  	const char *color = metric_threshold_classify__color(thresh);
> +	int olen;
>  
> -	if (!unit)
> -		unit = "";
> -	if (mlen < strlen(unit))
> -		mlen = strlen(unit) + 1;
> +	if (!unit) {
> +		os->first = false;
> +		return;
> +	}
>  
> -	if (color)
> -		mlen += strlen(color) + sizeof(PERF_COLOR_RESET) - 1;
> +	mlen = max_t(unsigned, strlen(unit), config->metric_only_len);
>  
> +	olen = snprintf(str, sizeof(str), fmt ?: "", val);
>  	color_snprintf(str, sizeof(str), color ?: "", fmt ?: "", val);
> -	fprintf(out, "%*s ", mlen, str);
> +	fprintf(out, "%*s%s", max_t(int, mlen - olen, 1), "", str);
>  	os->first = false;
>  }
>  
> -- 
> 2.54.0
> 
