Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA71CA64;
	Wed, 15 Jan 2025 01:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736903224; cv=none; b=m5n2FYS45vYSg7f1TXDAnAlk+FSK89nyzU4aDg8HqLgzLSKmOsmEsPZbJ2s1+h2bwipwZgCsxp4Rf1qJS7TfOE0IpzTKulyYPQMQOsMUz9voMBO0NL/wq/ZTqun4t+koEnpwqKagmlKZ3Bc8mOR9jOFwLgEzYSewg0iQkTG7IOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736903224; c=relaxed/simple;
	bh=zMhObxW9HdXKUNKn4dhx0tlbOofGDpHmAzSKRN8MKsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=La+BzoUh+D4U2a0tiIs8qCREhmHwrfTaIIQQSX+Vi6TVyUAb7wml+D3YJGnutgjsglHa8Y6RMPG/ZUtFlU/zi8bKZBX+WpJA/5sN8t7xWjlH7EpoWmflaRZZxpK3OJOmtDp3kUAFarR826+ZVwjV8q6lc4Wcu2xFpQoQDxYEkOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjXo0REg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjXo0REg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B5CAC4CEDD;
	Wed, 15 Jan 2025 01:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736903224;
	bh=zMhObxW9HdXKUNKn4dhx0tlbOofGDpHmAzSKRN8MKsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NjXo0REgvHdUBPDHMbzo7NWSlgrXrZzO3IAvit2+U5/Yx2QLFZC4oj0f/BHPMuhZS
	 iPIC211s6XlSKY6oVYRX6IsYnf/oRdCLRfT1WZp3tMFk/5uwWl/ZbHn06bSpt4SktV
	 4pwu/ZDBuyHCZ07px/fJRCoXUCSQ76RmcW+u4RlfkhFzkeBrXbLiQixo6LmK9GLSu7
	 SO/R8jwFQi7ZuWABSEFaJ1giA1/+cf3ZoGljUmgpnkuVwE+PRYEDqOlNDeuAYzoCqA
	 40QVC7UD5x44bDf6aWaN3Zoayhb6qnDdXOpYPznKupQKH5Ugo4I0A+jJrmJPE+1e1/
	 2LdGCdNqa7zJQ==
Date: Tue, 14 Jan 2025 17:07:02 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf hist: Deduplicate cmp/sort/collapse code
Message-ID: <Z4cKNjudLDJBrlM_@google.com>
References: <cover.1736775109.git.dvyukov@google.com>
 <52f5a4dcc10ecb00fdf78750d1b32dabcbaf2a31.1736775109.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <52f5a4dcc10ecb00fdf78750d1b32dabcbaf2a31.1736775109.git.dvyukov@google.com>

On Mon, Jan 13, 2025 at 02:34:14PM +0100, Dmitry Vyukov wrote:
> Application of cmp/sort/collapse fmt callbacks is duplicated 6 times.
> Factor it into a common helper function. NFC.
> 
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> ---
> 
> Changes in v2:
>  - add perf_hpp_fmt_cmp_t typedef to util/hist.h
>  - use the typedef for perf_hpp_fmt::{cmp,collapse,sort}
> ---
>  tools/perf/util/hist.c | 103 +++++++++++++++++------------------------
>  tools/perf/util/hist.h |  14 +++---
>  2 files changed, 49 insertions(+), 68 deletions(-)
> 
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index fff1345658016..a4b8ec3805565 100644
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
> @@ -1292,19 +1295,26 @@ int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
>  	return err;
>  }
>  
> -int64_t
> -hist_entry__cmp(struct hist_entry *left, struct hist_entry *right)
> +static int64_t
> +hist_entry__cmp_impl(struct perf_hpp_list *hpp_list, struct hist_entry *left,
> +		     struct hist_entry *right, unsigned long fn_offset,
> +		     bool ignore_dynamic, bool ignore_skipped)

Maybe it's a matter of tastes, but I think it could be simpler like
below.

>  {
>  	struct hists *hists = left->hists;
>  	struct perf_hpp_fmt *fmt;
>  	int64_t cmp = 0;
> +	perf_hpp_fmt_cmp_t fn;

	perf_hpp_fmt_cmp_t *fn;

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
> +		fn = *(perf_hpp_fmt_cmp_t *)(((char *)fmt) + fn_offset);
> +		cmp = fn(fmt, left, right);

		fn = (void *)fmt + fn_offset;
		cmp = (*fn)(fmt, left, right);


Otherwise, looks good to me.

Thanks,
Namhyung

>  		if (cmp)
>  			break;
>  	}
> @@ -1313,23 +1323,33 @@ hist_entry__cmp(struct hist_entry *left, struct hist_entry *right)
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
> @@ -1503,14 +1523,7 @@ static struct hist_entry *hierarchy_insert_entry(struct hists *hists,
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
> @@ -1730,24 +1743,6 @@ int hists__collapse_resort(struct hists *hists, struct ui_progress *prog)
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
> @@ -2449,21 +2444,15 @@ static struct hist_entry *add_dummy_hierarchy_entry(struct hists *hists,
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
> @@ -2521,16 +2510,10 @@ static struct hist_entry *hists__find_hierarchy_entry(struct rb_root_cached *roo
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
> index 1131056924d9c..46c8373e31465 100644
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
> @@ -452,6 +450,9 @@ struct perf_hpp {
>  	bool skip;
>  };
>  
> +typedef int64_t (*perf_hpp_fmt_cmp_t)(
> +	struct perf_hpp_fmt *, struct hist_entry *, struct hist_entry *);
> +
>  struct perf_hpp_fmt {
>  	const char *name;
>  	int (*header)(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
> @@ -463,12 +464,9 @@ struct perf_hpp_fmt {
>  		     struct hist_entry *he);
>  	int (*entry)(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
>  		     struct hist_entry *he);
> -	int64_t (*cmp)(struct perf_hpp_fmt *fmt,
> -		       struct hist_entry *a, struct hist_entry *b);
> -	int64_t (*collapse)(struct perf_hpp_fmt *fmt,
> -			    struct hist_entry *a, struct hist_entry *b);
> -	int64_t (*sort)(struct perf_hpp_fmt *fmt,
> -			struct hist_entry *a, struct hist_entry *b);
> +	perf_hpp_fmt_cmp_t cmp;
> +	perf_hpp_fmt_cmp_t collapse;
> +	perf_hpp_fmt_cmp_t sort;
>  	bool (*equal)(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b);
>  	void (*free)(struct perf_hpp_fmt *fmt);
>  
> -- 
> 2.47.1.688.g23fc6f90ad-goog
> 
