Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02D81ACEAE;
	Thu,  9 Jan 2025 21:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736459031; cv=none; b=bUd91PVpdOSYUPGUU1KQ11vKouWm4hLAPFT3QoODItShTxNZqYcSEeL5uITRhMmSoX224fLJ5XRUbCR5StzB2TGj1EmPZuLmJQkHI60tqsYSJlqaBm82m5PICrd7a3UKMH794sjVmQoBUhhnKr9huT3myaTAJxVT7JgqonBRHrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736459031; c=relaxed/simple;
	bh=M0snV44UFgly4ylZ82gceg9saj8Zti2LYEIqYCeS/kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DerAycNxFaSezcwLQ5ybHf7p6FfQsqQDt7+Om/nn7DTQ9Mayd18SZopq4Rl+5pHZBBng9MA2+fnCcGRWig4KF3IAbLhm3bRWEng1e9FWDZUbegJfNH/5mownItbRa2sD9dN6a8Y7IcpLFWZ4EY2PHyC0OIQkqZVpYu8I8cendMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WiEuB6+E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiEuB6+E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503C0C4CED2;
	Thu,  9 Jan 2025 21:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736459029;
	bh=M0snV44UFgly4ylZ82gceg9saj8Zti2LYEIqYCeS/kY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WiEuB6+EMhIOrGoGMA6MrOvyTB4uPzg0gQpWFKkTHoPDQcyW+3KvyjVgfvnww+5cZ
	 BAzpASOK2s6SMhixrye2OwLt/gqoGIQJQt+2stRdKvYpxi4JC41G0uLCFSrQzifCq8
	 GRIE+eAEUFsFgTU9aLyHBOu6pGd/xS0vukk5uW9GmrTl8mYhgr2dlEq6IGEa2nqh46
	 cXxcAPUNU7Eshpusz9D2lmETZ4BJauiQMW+5O56g9C2tuldNJdhR0XQd77CpnS51AR
	 xKq32frREjLU4DykqiTRYNq0WzadQJ6XbviBbZW7HuYWHY7njWGL5VGPCr7XulmI0b
	 r66Y1Ee1LeO0g==
Date: Thu, 9 Jan 2025 13:43:47 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf hist: Deduplicate cmp/sort/collapse code
Message-ID: <Z4BDEz3Bmd2DmfNi@google.com>
References: <cover.1736321686.git.dvyukov@google.com>
 <4bf65a9a789a0bb78e4a3e120ad30389725d2249.1736321686.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4bf65a9a789a0bb78e4a3e120ad30389725d2249.1736321686.git.dvyukov@google.com>

Hello,

On Wed, Jan 08, 2025 at 08:36:53AM +0100, Dmitry Vyukov wrote:
> Application of cmp/sort/collapse fmt callbacks is duplicated 6 times.
> Factor it into a common helper function. NFC.

It's interesting to use offsetof and cast it to functions. :)

> 
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  tools/perf/util/hist.c | 104 +++++++++++++++++------------------------
>  tools/perf/util/hist.h |   2 -
>  2 files changed, 44 insertions(+), 62 deletions(-)
> 
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index fff1345658016..8e4e844425370 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -32,6 +32,9 @@
>  #include <linux/time64.h>
>  #include <linux/zalloc.h>
>  
> +static int64_t hist_entry__cmp(struct hist_entry *left, struct hist_entry *right);
> +static int64_t hist_entry__collapse(struct hist_entry *left, struct hist_entry *right);
> +
>  static bool hists__filter_entry_by_dso(struct hists *hists,
>  				       struct hist_entry *he);
>  static bool hists__filter_entry_by_thread(struct hists *hists,
> @@ -1292,19 +1295,27 @@ int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
>  	return err;
>  }
>  
> -int64_t
> -hist_entry__cmp(struct hist_entry *left, struct hist_entry *right)
> +static int64_t
> +hist_entry__cmp_impl(struct perf_hpp_list *hpp_list, struct hist_entry *left,
> +		     struct hist_entry *right, unsigned long fn_offset,
> +		     bool ignore_dynamic, bool ignore_skipped)
>  {
> +	typedef int64_t (*fn_t)(struct perf_hpp_fmt *, struct hist_entry *, struct hist_entry *);

Probably better to put it in util/hist.h and each members (cmp, collapse,
sort) use the typedef to make sure they remain in the same.


>  	struct hists *hists = left->hists;
>  	struct perf_hpp_fmt *fmt;
>  	int64_t cmp = 0;
> +	fn_t fn;
>  
> -	hists__for_each_sort_list(hists, fmt) {
> -		if (perf_hpp__is_dynamic_entry(fmt) &&
> +	perf_hpp_list__for_each_sort_list(hpp_list, fmt) {
> +		if (ignore_dynamic && perf_hpp__is_dynamic_entry(fmt) &&
>  		    !perf_hpp__defined_dynamic_entry(fmt, hists))
>  			continue;
>  
> -		cmp = fmt->cmp(fmt, left, right);
> +		if (ignore_skipped && perf_hpp__should_skip(fmt, hists))
> +			continue;
> +
> +		fn = *(fn_t *)(((char *)fmt) + fn_offset);

Doesn't just below work?

		fn = (void *)fmt + fn_offset;

Thanks,
Namhyung


> +		cmp = fn(fmt, left, right);
>  		if (cmp)
>  			break;
>  	}
> @@ -1313,23 +1324,33 @@ hist_entry__cmp(struct hist_entry *left, struct hist_entry *right)
>  }
>  
>  int64_t
> -hist_entry__collapse(struct hist_entry *left, struct hist_entry *right)
> +hist_entry__cmp(struct hist_entry *left, struct hist_entry *right)
>  {
> -	struct hists *hists = left->hists;
> -	struct perf_hpp_fmt *fmt;
> -	int64_t cmp = 0;
> +	return hist_entry__cmp_impl(left->hists->hpp_list, left, right,
> +		offsetof(struct perf_hpp_fmt, cmp), true, false);
> +}
>  
> -	hists__for_each_sort_list(hists, fmt) {
> -		if (perf_hpp__is_dynamic_entry(fmt) &&
> -		    !perf_hpp__defined_dynamic_entry(fmt, hists))
> -			continue;
> +static int64_t
> +hist_entry__sort(struct hist_entry *left, struct hist_entry *right)
> +{
> +	return hist_entry__cmp_impl(left->hists->hpp_list, left, right,
> +		offsetof(struct perf_hpp_fmt, sort), false, true);
> +}
>  
> -		cmp = fmt->collapse(fmt, left, right);
> -		if (cmp)
> -			break;
> -	}
> +int64_t
> +hist_entry__collapse(struct hist_entry *left, struct hist_entry *right)
> +{
> +	return hist_entry__cmp_impl(left->hists->hpp_list, left, right,
> +		offsetof(struct perf_hpp_fmt, collapse), true, false);
> +}
>  
> -	return cmp;
> +static int64_t
> +hist_entry__collapse_hierarchy(struct perf_hpp_list *hpp_list,
> +			       struct hist_entry *left,
> +			       struct hist_entry *right)
> +{
> +	return hist_entry__cmp_impl(hpp_list, left, right,
> +		offsetof(struct perf_hpp_fmt, collapse), false, false);
>  }
>  
>  void hist_entry__delete(struct hist_entry *he)
> @@ -1503,14 +1524,7 @@ static struct hist_entry *hierarchy_insert_entry(struct hists *hists,
>  	while (*p != NULL) {
>  		parent = *p;
>  		iter = rb_entry(parent, struct hist_entry, rb_node_in);
> -
> -		cmp = 0;
> -		perf_hpp_list__for_each_sort_list(hpp_list, fmt) {
> -			cmp = fmt->collapse(fmt, iter, he);
> -			if (cmp)
> -				break;
> -		}
> -
> +		cmp = hist_entry__collapse_hierarchy(hpp_list, iter, he);
>  		if (!cmp) {
>  			he_stat__add_stat(&iter->stat, &he->stat);
>  			return iter;
> @@ -1730,24 +1744,6 @@ int hists__collapse_resort(struct hists *hists, struct ui_progress *prog)
>  	return 0;
>  }
>  
> -static int64_t hist_entry__sort(struct hist_entry *a, struct hist_entry *b)
> -{
> -	struct hists *hists = a->hists;
> -	struct perf_hpp_fmt *fmt;
> -	int64_t cmp = 0;
> -
> -	hists__for_each_sort_list(hists, fmt) {
> -		if (perf_hpp__should_skip(fmt, a->hists))
> -			continue;
> -
> -		cmp = fmt->sort(fmt, a, b);
> -		if (cmp)
> -			break;
> -	}
> -
> -	return cmp;
> -}
> -
>  static void hists__reset_filter_stats(struct hists *hists)
>  {
>  	hists->nr_non_filtered_entries = 0;
> @@ -2449,21 +2445,15 @@ static struct hist_entry *add_dummy_hierarchy_entry(struct hists *hists,
>  	struct rb_node **p;
>  	struct rb_node *parent = NULL;
>  	struct hist_entry *he;
> -	struct perf_hpp_fmt *fmt;
>  	bool leftmost = true;
>  
>  	p = &root->rb_root.rb_node;
>  	while (*p != NULL) {
> -		int64_t cmp = 0;
> +		int64_t cmp;
>  
>  		parent = *p;
>  		he = rb_entry(parent, struct hist_entry, rb_node_in);
> -
> -		perf_hpp_list__for_each_sort_list(he->hpp_list, fmt) {
> -			cmp = fmt->collapse(fmt, he, pair);
> -			if (cmp)
> -				break;
> -		}
> +		cmp = hist_entry__collapse_hierarchy(he->hpp_list, he, pair);
>  		if (!cmp)
>  			goto out;
>  
> @@ -2521,16 +2511,10 @@ static struct hist_entry *hists__find_hierarchy_entry(struct rb_root_cached *roo
>  
>  	while (n) {
>  		struct hist_entry *iter;
> -		struct perf_hpp_fmt *fmt;
> -		int64_t cmp = 0;
> +		int64_t cmp;
>  
>  		iter = rb_entry(n, struct hist_entry, rb_node_in);
> -		perf_hpp_list__for_each_sort_list(he->hpp_list, fmt) {
> -			cmp = fmt->collapse(fmt, iter, he);
> -			if (cmp)
> -				break;
> -		}
> -
> +		cmp = hist_entry__collapse_hierarchy(he->hpp_list, iter, he);
>  		if (cmp < 0)
>  			n = n->rb_left;
>  		else if (cmp > 0)
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index 1131056924d9c..6cff03eb043b7 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
> @@ -342,8 +342,6 @@ int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
>  struct perf_hpp;
>  struct perf_hpp_fmt;
>  
> -int64_t hist_entry__cmp(struct hist_entry *left, struct hist_entry *right);
> -int64_t hist_entry__collapse(struct hist_entry *left, struct hist_entry *right);
>  int hist_entry__transaction_len(void);
>  int hist_entry__sort_snprintf(struct hist_entry *he, char *bf, size_t size,
>  			      struct hists *hists);
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
> 
