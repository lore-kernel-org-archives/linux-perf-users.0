Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A42359A94;
	Fri,  1 May 2026 21:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777670618; cv=none; b=WP2DG85S6QcwT8tAqrR18DlUTFMvfHARyYz8onBl/p9epSD3FY2aCE81+Gxf5/I0awOPTd7mR63PmWLeQZzgPYPIdzE8PqHUl089RN7lg51kr16YFKOsOvL69PimtQ385RWHkFh9t7lMkUWsvkcN/n7efR/BpprIjNqblXLYEtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777670618; c=relaxed/simple;
	bh=mZ1FqiBx0hTcJj0FM1/JYgxMhU2tqclnf1fgCAd5nMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTMoukM0p/R0kSp6ZcTfE+DVxe0iDcxJqQfQp+0Jr36RV4VKsy7SftB3hpmw7e1r4ZVqr+Q1+YDS6lMp5BxC0AmgtcFplN0AFdjLn3gL2HWG2k8M8tXgXQ9q8e+xazb5hi0TB6dBjzQ6WKhSDk589/OhlDLnrydmOWi1ESRsrDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvxKY+BU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvxKY+BU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CFDC2BCB4;
	Fri,  1 May 2026 21:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777670618;
	bh=mZ1FqiBx0hTcJj0FM1/JYgxMhU2tqclnf1fgCAd5nMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UvxKY+BUCG9Lfb5uE3mt8+yEY17zB6+P8XZPhQNIu6ZLaa70O5eHNh42vj6L5JKaG
	 TrtfGLPm69X7u7fPRFX0cr3SKYh+/C6cXlpFJTIVsVaZyY5mQh3xXUw3Gbtj/KiwRF
	 d8cHfb1Ut3/MTG5hl12aFv73m/y5vbyd0gs2B/0QmU/yb5fH+aMA5tENIO50AXNAUo
	 YvHOm3D6akEvdsBu9IwItTcU0CXZ0URotN6VwC3ioSf+bQAcJJ3tRLQ+m24fkqgWvY
	 BMX6y2n3vTqtNWi4dFe3bUU2h3vh3CkHWKIP82EZeA7gHWYGZNbWaNQYXJ0eCQ9sJE
	 ayfkxfoICfeUQ==
Date: Fri, 1 May 2026 14:23:36 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
	thomas.falcon@intel.com, tmricht@linux.ibm.com,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf tools: Ensure event leader stays at head of evlist
 after sorting
Message-ID: <afUZ2K-C4hMxcl7g@google.com>
References: <20260501043532.790711-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260501043532.790711-1-ctshao@google.com>

On Thu, Apr 30, 2026 at 09:35:10PM -0700, Chun-Tse Shao wrote:
> From: Ian Rogers <irogers@google.com>
> 
> For evlist of a certain event/metric, the HEAD should be the event
> leader. In some scenarios where uncore_xxx_0 does not exist, the event
> leader is not the first element after sorting. For example, on my test
> machine uncore_iio_0 does not exist, the event leader is uncore_iio_2.
> 
> However, in `evlist__cmp`, it was reordered based on the PMU name, which
> makes uncore_iio_1 the HEAD of evlist, breaking the following merge
> logic in `evsel__merge_aliases`.
> 
> The patch adds a loop at the end of
> `parse_events__sort_events_and_fix_groups` to make sure the first
> wildcard match is the earliest entry in the list, updating pointers
> accordingly without breaking reordering detection.
> 
> Tested on DUT lacks uncore_iio_0, and `perf test` looks good.

DUT?

> 
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>

If this commit is from Ian, there should be Ian's sign-off before yours.

> ---
>  tools/perf/util/parse-events.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 1497e1f2a08c..be825617321d 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -2251,6 +2251,33 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
>  		}
>  		last_event_was_forced_leader = (force_grouped_leader == pos);
>  	}
> +
> +	/*
> +	 * Make sure the first wildcard match is the earliest entry in the list.
> +	 * Since list_sort might have reordered the aliases, the original leader
> +	 * might not be at the head of the list anymore. We find the first
> +	 * alias in the sorted list and make it the new leader, and redirect
> +	 * all other aliases to it.
> +	 */
> +	list_for_each_entry(pos, list, core.node) {
> +		struct evsel *l = pos->first_wildcard_match;

Why 'l'?  It's not conventional and can be confusing with capital 'I'.
Can it be just 'evsel', 'first' or 'leader'?

Thanks,
Namhyung

> +
> +		if (!l)
> +			continue;
> +
> +		if (l->first_wildcard_match) {
> +			/* Original leader was redirected to a new leader */
> +			pos->first_wildcard_match = l->first_wildcard_match;
> +		} else if (pos->core.idx < l->core.idx) {
> +			/*
> +			 * We are earlier than the original leader in sorted order,
> +			 * and no earlier alias has claimed leadership yet.
> +			 */
> +			l->first_wildcard_match = pos;
> +			pos->first_wildcard_match = NULL;
> +		}
> +	}
> +
>  	list_for_each_entry(pos, list, core.node) {
>  		struct evsel *pos_leader = evsel__leader(pos);
>  
> -- 
> 2.54.0.545.g6539524ca2-goog
> 
