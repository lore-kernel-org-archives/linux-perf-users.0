Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ED62DB7BE
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Feb 2026 01:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771379531; cv=none; b=nyWh7N3UDpmsUdEIJdVIRVdfZyB5BOb0C6hKlE7GtAHanv4lDXPy0a1FmOsA6L17SEqkxg990m0hcw+Dt1Ur8ZJelazmMgk4Tcw0v6lN5d3Pqbdkknufd6khc+QGmyA43W3xel7Zl314ntgj2mb4lI+LqsOjkBRckTalTnKPjGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771379531; c=relaxed/simple;
	bh=duucAK2uk3/NECB2ijHK73Ejzz5T7OwATlFKbirm1p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQUIHpDwU6Uklj+rQcJKsnSSahkMtABTvqAwdmLFqCt12UQ0KXvCkkN8VbbpJ/8YkABhHod+BJyWusKsLNNE4YkwuqCMJ0Wr3D+9XpeSW+IY6j3D27Rq4WhuoX8i8XAk4PS9DwOLPPEY1Jfbidhy0Sg73V2utdW70U10bt1D7Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlDN8lUr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlDN8lUr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA97C4CEF7;
	Wed, 18 Feb 2026 01:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771379530;
	bh=duucAK2uk3/NECB2ijHK73Ejzz5T7OwATlFKbirm1p8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tlDN8lUrUweAN90exajCONMhcjXdOFUEpkb0u/lswDXmfsE2mAS/4lNH+1/ytUDWL
	 Kx3zKGQflkXxGKUPW/5+ldGQGn7MjQmaiv5HwXoYnqvDwjsCXeL45cuQsqKkXZS1qf
	 RbYrGdoAZL4ZNVfEnXZT3YSoVQrTZ405p29fy8mV2+ObLhmxQSBQXTLrb3/DXhvCgr
	 Ps30NfOYSxw+5uodTCnG4a/uwmBFWfiDqSCINMTJDXqXN8q/aIwN9L6huq24l2Fr32
	 lHwI1g6VS2ynzVYN09hqm1I0QhVXlc4y//6Gep0uH69OlWi8zHmvTa6NErcg4wmn1U
	 JugHnpMQgn94A==
Date: Tue, 17 Feb 2026 17:52:08 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>
Subject: Re: Question: perf report & top memory usage
Message-ID: <aZUbSLeRCSdTp55m@google.com>
References: <20260217190821.3882437-1-stephen.s.brennan@oracle.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260217190821.3882437-1-stephen.s.brennan@oracle.com>

Hello,

On Tue, Feb 17, 2026 at 11:08:19AM -0800, Stephen Brennan wrote:
> Hello all,
> 
> I had an interesting case where perf record required 35 GiB of memory to create
> a report for a 400 MiB data file. Unfortunately I don't believe I can share the
> perf.data, but I did an analysis and wanted to share what I found and ask some
> questions.
> 
> The particular data file contains 1,087,091 samples, with call chains, generated
> by a pretty standard "perf record -a -g sleep 10" on a machine with 76 CPUs. I
> looked at the perf report code and profiled memory allocations. Three items
> seemed to dominate memory use:
> 
> 1. Histogram columns. The default being "comm,dso,symbol". The more buckets that
>    the data is broken into, the more memory is used, and the histogram columns
>    directly control this.
> 
> 2. Callchains. The default is to track them when the perf.data contains them,
>    though it can be disabled with "-g none". The data structure storing call
>    chains seems pretty efficient (a prefix tree) but it looks like there is one
>    per histogram bucket. This makes sense, but it seems duplicative with #3.
> 
> 3. Accumulating child overhead. The default is to do this, creating the
>    "Children" column in the report. The implementation walks the stack for each
>    sample, creating a histogram bucket for each stack frame (even if no samples
>    were observed actually executing in those symbols).
> 
> My understanding is that the 35 GiB memory usage then comes from a sort of
> combinatorial explosion. In this data file, nearly every process has a unique
> comm with numeric identifiers embedded within (e.g. "db1234"). This means that
> the default "comm,dso,symbol" sort will result in a large number of buckets. The
> call stacks are reasonably deep (though not absurdly so). There are many
> non-leaf functions in the call stacks which don't have any Self samples. Child
> overhead accumulation creates more buckets than there are samples: around 1.3
> million buckets, compared to 1 million samples.
> 
> From this perspective, the memory usage makes sense to me. I understand that I
> could tweak any combination of those knobs to ameliorate the issue. The most
> straightforward option is to use "-s dso,symbol" because the "comm" column
> wasn't informative for this workload. I also created a new histogram column
> implementation (see below) that represents a command with any digits stripped,
> so that the commands could still be grouped together, without the numeric
> identifiers disrupting the bucketing. These solutions reduce memory used to 5.1
> and 5.4 GiB respectively.
> 
> My concern is that most users aren't prepared to dive into this sort of detail,
> especially when they're likely already in the middle of an analysis of some
> other performance issue. While they may be familiar with the call graph options
> and event selection choices, in my experience they generally aren't aware of the
> many options that "perf report" provides. They certainly aren't aware of these
> memory trade-offs, especially for what seemed like an innocuous 10-second data
> collection at the default sample rate.
> 
> To sum up, I have the following questions:
> 
> 1. Does my analysis make sense and seem consistent with your understanding?

Yes, it does!

> 2. Does anybody else deal with this sort of memory usage issue, and have
> strategies they can share?

No, but I think "-s dso,sym" should work fine.  And it's the default
sort key for `perf top` command.

> 3. Does the patch below for the custom column make sense to submit? I know it's
> rather workload specific, but it could be useful for others in this situation.

I think it makes sense and could be useful.  Maybe it's good to group
kworker threads together.

Different options would be

1. to add an option to enable it for the existing 'comm' sort key.
2. to have a regex pattern or so to specify names to merge.

But a separate sort key as you did seems to be fine.

> 
> Patch for the "commIgnoreDigit" column. For this workload, it reduced perf
> report's peak RSS from 35 GiB to around 5.4 GiB, when used in place of "comm":

We don't use CamelCase in the perf code base.  But otherwise looks ok.

Thanks,
Namhyung

> 
> From df1452ae742d933b45c18d9dde090c11fb3cf846 Mon Sep 17 00:00:00 2001
> From: Stephen Brennan <stephen.s.brennan@oracle.com>
> Date: Wed, 3 Dec 2025 16:01:49 -0800
> Subject: [PATCH 1/1] tools: perf: add commIgnoreDigit
> 
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
> 
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
>  tools/perf/util/hist.c |  2 +
>  tools/perf/util/hist.h |  1 +
>  tools/perf/util/sort.c | 88 +++++++++++++++++++++++++++++++++++++++++-
>  tools/perf/util/sort.h |  1 +
>  4 files changed, 91 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index ef4b569f7df46..5f691d9b0272d 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -110,6 +110,8 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
>  	len = thread__comm_len(h->thread);
>  	if (hists__new_col_len(hists, HISTC_COMM, len))
>  		hists__set_col_len(hists, HISTC_THREAD, len + 8);
> +	if (hists__new_col_len(hists, HISTC_COMM_IGNORE_DIGIT, len))
> +		hists__set_col_len(hists, HISTC_THREAD, len + 8);
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
> index f3a565b0e2307..656b5cc62a730 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -1,4 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <ctype.h>
>  #include <errno.h>
>  #include <inttypes.h>
>  #include <regex.h>
> @@ -265,6 +266,89 @@ struct sort_entry sort_comm = {
>  	.se_width_idx	= HISTC_COMM,
>  };
>  
> +/* --sort commIgnoreDigit */
> +
> +static int64_t strcmp_nodigit(const char *left, const char *right)
> +{
> +	for (;;) {
> +		while (*left && isdigit(*left)) left++;
> +		while (*right && isdigit(*right)) right++;
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
> +sort__commIgnoreDigit_cmp(struct hist_entry *left, struct hist_entry *right)
> +{
> +	return strcmp_nodigit(comm__str(right->comm), comm__str(left->comm));
> +}
> +
> +static int64_t
> +sort__commIgnoreDigit_collapse(struct hist_entry *left, struct hist_entry *right)
> +{
> +	return strcmp_nodigit(comm__str(right->comm), comm__str(left->comm));
> +}
> +
> +static int64_t
> +sort__commIgnoreDigit_sort(struct hist_entry *left, struct hist_entry *right)
> +{
> +	return strcmp_nodigit(comm__str(right->comm), comm__str(left->comm));
> +}
> +
> +static int hist_entry__commIgnoreDigit_snprintf(struct hist_entry *he, char *bf,
> +						size_t size, unsigned int width)
> +{
> +	int ret = 0;
> +	unsigned int print_len, printed = 0, start = 0, end = 0;
> +	bool in_digit;
> +	const char *comm = comm__str(he->comm), *print;
> +	while (printed < width && printed < size && comm[start]) {
> +		in_digit = !!isdigit(comm[start]);
> +		end = start + 1;
> +		while (comm[end] && !!isdigit(comm[end]) == in_digit) end++;
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
> +struct sort_entry sort_commIgnoreDigit = {
> +	.se_header	= "CommandIgnoreDigit",
> +	.se_cmp		= sort__commIgnoreDigit_cmp,
> +	.se_collapse	= sort__commIgnoreDigit_collapse,
> +	.se_sort	= sort__commIgnoreDigit_sort,
> +	.se_snprintf	= hist_entry__commIgnoreDigit_snprintf,
> +	.se_filter	= hist_entry__thread_filter,
> +	.se_width_idx	= HISTC_COMM_IGNORE_DIGIT,
> +};
> +
>  /* --sort dso */
>  
>  static int64_t _sort__dso_cmp(struct map *map_l, struct map *map_r)
> @@ -2576,6 +2660,7 @@ static struct sort_dimension common_sort_dimensions[] = {
>  	DIM(SORT_PID, "pid", sort_thread),
>  	DIM(SORT_TGID, "tgid", sort_tgid),
>  	DIM(SORT_COMM, "comm", sort_comm),
> +	DIM(SORT_COMM_IGNORE_DIGIT, "commIgnoreDigit", sort_commIgnoreDigit),
>  	DIM(SORT_DSO, "dso", sort_dso),
>  	DIM(SORT_SYM, "symbol", sort_sym),
>  	DIM(SORT_PARENT, "parent", sort_parent),
> @@ -3675,7 +3760,7 @@ int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
>  			list->socket = 1;
>  		} else if (sd->entry == &sort_thread) {
>  			list->thread = 1;
> -		} else if (sd->entry == &sort_comm) {
> +		} else if (sd->entry == &sort_comm || sd->entry == &sort_commIgnoreDigit) {
>  			list->comm = 1;
>  		} else if (sd->entry == &sort_type_offset) {
>  			symbol_conf.annotate_data_member = true;
> @@ -4022,6 +4107,7 @@ static bool get_elide(int idx, FILE *output)
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
