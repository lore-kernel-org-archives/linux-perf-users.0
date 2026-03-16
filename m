Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E9A33A6F1;
	Mon, 16 Mar 2026 17:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773683285; cv=none; b=MwjcNdw1IffCWNi4r8HbQk84+AXPb4omX1TWLQKY1sYFHOJeYAd+6d9lmCs2nMkpCU826bReTSa4/0WOXhHZDXmw/sgWWSimdJP2hBic1RNfGQCwWgcbSF9NydkcHF9rosnZwXs9MreAvBqXLBFYL2B00ArLCftenwV1qLWJPjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773683285; c=relaxed/simple;
	bh=n/9d5hUdodqfyWOj8ieOm2l1UE31ceFt4fIKFa1W+Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYeUuKR+D9tVgFxZZHi27kNihFx+xXx6K3jHm4fTsL0wYiF59j3w7Do85dFz4jGQNgOmpdyQ0VLr9uD4dNhbvYNgFVoOuTZZk3V11PmsHTODOjlPcVVDZ9TRFwBypOJr7WUBG9vVHGX9NZhvBKB/xKUD8oAC3lDyp/sICIVGW5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1/2xhny; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1/2xhny"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E5BC19421;
	Mon, 16 Mar 2026 17:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773683284;
	bh=n/9d5hUdodqfyWOj8ieOm2l1UE31ceFt4fIKFa1W+Sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m1/2xhnyUC70XPhzvA6vhXnYnun7f3ctApsrDoS9lkv8p9rLCHYsehh607RyRu2k7
	 iasMlG+YKqJ9Gy54EihUrcI01SFd10zbyqB6c1ODBc2TfR+mHbpHeQir73Xp55X/es
	 o8x4AoadL/AuNkK5qsHU2Zj/EP5b4fvhFZdRePel3stYhtTvbIhUx/yqSfi6leZ/RO
	 zVXGGQs5CP0KdJhOCi+toQn5nGwV5fwq191uhs9nowgey9Bptqz/xN+swmxH9KWmrA
	 AXQObJo2XJgSZiVXYJ1CLsZKOJRMoeEq9AJDRJYNjUvOWFneFsmwmj1bCbpdZO/4Bv
	 nHAgI62tAXuGg==
Date: Mon, 16 Mar 2026 10:48:00 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Wangyang Guo <wangyang.guo@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Tianyou Li <tianyou.li@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] tools: perf: add comm_ignore_digit column
Message-ID: <abhCUFPsyWGJ6DNn@google.com>
References: <20260305181847.3249498-1-stephen.s.brennan@oracle.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260305181847.3249498-1-stephen.s.brennan@oracle.com>

Hello,

On Thu, Mar 05, 2026 at 10:18:47AM -0800, Stephen Brennan wrote:
> The "comm" column allows grouping events by the process command. It is
> intended to group like programs, despite having different PIDs. But some
> workloads may adjust their own command, so that a unique identifier
> (e.g. a PID or some other numeric value) is part of the command name.
> This destroys the utility of "comm", forcing perf to place each unique
> process name into its own bucket, which can contribute to a
> combinatorial explosion of memory use in perf report.
> 
> Create a less strict version of this column, which ignores digits when
> comparing command names. This allows "similar looking" processes to
> again be placed in the same bucket.

Can you please rebase this onto the current perf-tools-next?

Thanks,
Namhyung

> 
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
>  tools/perf/util/hist.c |  1 +
>  tools/perf/util/hist.h |  1 +
>  tools/perf/util/sort.c | 92 +++++++++++++++++++++++++++++++++++++++++-
>  tools/perf/util/sort.h |  1 +
>  4 files changed, 94 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index ef4b569f7df46..6759826be8344 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -110,6 +110,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
>  	len = thread__comm_len(h->thread);
>  	if (hists__new_col_len(hists, HISTC_COMM, len))
>  		hists__set_col_len(hists, HISTC_THREAD, len + 8);
> +	hists__new_col_len(hists, HISTC_COMM_IGNORE_DIGIT, len);
>  
>  	if (h->ms.map) {
>  		len = dso__name_len(map__dso(h->ms.map));
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index 1d5ea632ca4e1..ae7e98bd9e46d 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
> @@ -44,6 +44,7 @@ enum hist_column {
>  	HISTC_THREAD,
>  	HISTC_TGID,
>  	HISTC_COMM,
> +	HISTC_COMM_IGNORE_DIGIT,
>  	HISTC_CGROUP_ID,
>  	HISTC_CGROUP,
>  	HISTC_PARENT,
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index f3a565b0e2307..e6012b2457c5d 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -1,4 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <ctype.h>
>  #include <errno.h>
>  #include <inttypes.h>
>  #include <regex.h>
> @@ -265,6 +266,93 @@ struct sort_entry sort_comm = {
>  	.se_width_idx	= HISTC_COMM,
>  };
>  
> +/* --sort comm_ignore_digit */
> +
> +static int64_t strcmp_nodigit(const char *left, const char *right)
> +{
> +	for (;;) {
> +		while (*left && isdigit(*left))
> +			left++;
> +		while (*right && isdigit(*right))
> +			right++;
> +		if (*left == *right && !*left) {
> +			return 0;
> +		} else if (*left == *right) {
> +			left++;
> +			right++;
> +		} else {
> +			return (int64_t)*left - (int64_t)*right;
> +		}
> +	}
> +}
> +
> +static int64_t
> +sort__comm_ignore_digit_cmp(struct hist_entry *left, struct hist_entry *right)
> +{
> +	return strcmp_nodigit(comm__str(right->comm), comm__str(left->comm));
> +}
> +
> +static int64_t
> +sort__comm_ignore_digit_collapse(struct hist_entry *left, struct hist_entry *right)
> +{
> +	return strcmp_nodigit(comm__str(right->comm), comm__str(left->comm));
> +}
> +
> +static int64_t
> +sort__comm_ignore_digit_sort(struct hist_entry *left, struct hist_entry *right)
> +{
> +	return strcmp_nodigit(comm__str(right->comm), comm__str(left->comm));
> +}
> +
> +static int hist_entry__comm_ignore_digit_snprintf(struct hist_entry *he, char *bf,
> +						size_t size, unsigned int width)
> +{
> +	int ret = 0;
> +	unsigned int print_len, printed = 0, start = 0, end = 0;
> +	bool in_digit;
> +	const char *comm = comm__str(he->comm), *print;
> +
> +	while (printed < width && printed < size && comm[start]) {
> +		in_digit = !!isdigit(comm[start]);
> +		end = start + 1;
> +		while (comm[end] && !!isdigit(comm[end]) == in_digit)
> +			end++;
> +		if (in_digit) {
> +			print_len = 3; /* <N> */
> +			print = "<N>";
> +		} else {
> +			print_len = end - start;
> +			print = &comm[start];
> +		}
> +		print_len = min(print_len, width - printed);
> +		ret = repsep_snprintf(bf + printed, size - printed, "%-.*s",
> +					print_len, print);
> +		if (ret < 0)
> +			return ret;
> +		start = end;
> +		printed += ret;
> +	}
> +	/* Pad to width if necessary */
> +	if (printed < width && printed < size) {
> +		ret = repsep_snprintf(bf + printed, size - printed, "%-*.*s",
> +				       width - printed, width - printed, "");
> +		if (ret < 0)
> +			return ret;
> +		printed += ret;
> +	}
> +	return printed;
> +}
> +
> +struct sort_entry sort_comm_ignore_digit = {
> +	.se_header	= "CommandIgnoreDigit",
> +	.se_cmp		= sort__comm_ignore_digit_cmp,
> +	.se_collapse	= sort__comm_ignore_digit_collapse,
> +	.se_sort	= sort__comm_ignore_digit_sort,
> +	.se_snprintf	= hist_entry__comm_ignore_digit_snprintf,
> +	.se_filter	= hist_entry__thread_filter,
> +	.se_width_idx	= HISTC_COMM_IGNORE_DIGIT,
> +};
> +
>  /* --sort dso */
>  
>  static int64_t _sort__dso_cmp(struct map *map_l, struct map *map_r)
> @@ -2576,6 +2664,7 @@ static struct sort_dimension common_sort_dimensions[] = {
>  	DIM(SORT_PID, "pid", sort_thread),
>  	DIM(SORT_TGID, "tgid", sort_tgid),
>  	DIM(SORT_COMM, "comm", sort_comm),
> +	DIM(SORT_COMM_IGNORE_DIGIT, "comm_ignore_digit", sort_comm_ignore_digit),
>  	DIM(SORT_DSO, "dso", sort_dso),
>  	DIM(SORT_SYM, "symbol", sort_sym),
>  	DIM(SORT_PARENT, "parent", sort_parent),
> @@ -3675,7 +3764,7 @@ int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
>  			list->socket = 1;
>  		} else if (sd->entry == &sort_thread) {
>  			list->thread = 1;
> -		} else if (sd->entry == &sort_comm) {
> +		} else if (sd->entry == &sort_comm || sd->entry == &sort_comm_ignore_digit) {
>  			list->comm = 1;
>  		} else if (sd->entry == &sort_type_offset) {
>  			symbol_conf.annotate_data_member = true;
> @@ -4022,6 +4111,7 @@ static bool get_elide(int idx, FILE *output)
>  	case HISTC_DSO:
>  		return __get_elide(symbol_conf.dso_list, "dso", output);
>  	case HISTC_COMM:
> +	case HISTC_COMM_IGNORE_DIGIT:
>  		return __get_elide(symbol_conf.comm_list, "comm", output);
>  	default:
>  		break;
> diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> index d7787958e06b9..6819934b4d48a 100644
> --- a/tools/perf/util/sort.h
> +++ b/tools/perf/util/sort.h
> @@ -43,6 +43,7 @@ enum sort_type {
>  	/* common sort keys */
>  	SORT_PID,
>  	SORT_COMM,
> +	SORT_COMM_IGNORE_DIGIT,
>  	SORT_DSO,
>  	SORT_SYM,
>  	SORT_PARENT,
> -- 
> 2.47.3
> 
