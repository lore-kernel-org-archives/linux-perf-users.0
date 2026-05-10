Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040D434F24A;
	Sun, 10 May 2026 06:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778395967; cv=none; b=oJ2gnQ2x4VH/CRnsJGZN/QN5pxS1/bfNFyck9e8jiY5CMyxxZLKOzIj9/nRb2L26eB6qwrKN2GmZ5zUO0fJcl7kseLFSmNFssW9G1t76Fn3Cr/+tMciJadlFoQkfSMZriw0YM6zYWJUIK1f33sJZH3uEgQi54Ev3DjuPcDQpFKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778395967; c=relaxed/simple;
	bh=dwErTHAqrNhla9wg2z1syY+cJGnGwHtFPeDrswcofsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsb36KsvvMvCVBAJgzBPdvwBqdn/MXJlqpYfqLQjBqIfOBZLzaFGUdGTgkGEg7ne+PitA6j/XTMbRtikh5/+5YAG6oo1WXp4y9rtYbgQiTqufNpjwioOL3GHBJ9ANKd/ceLz5vwSuxbHqgjOVwSYb204QNcFwfmM+l6l+odFmWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2t3ejyE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2t3ejyE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11252C2BCB8;
	Sun, 10 May 2026 06:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778395966;
	bh=dwErTHAqrNhla9wg2z1syY+cJGnGwHtFPeDrswcofsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A2t3ejyEzmmdC+EVRzRxiiw5WBHGdEVZwIRRnyXvWwNnV1YAhq/VwhTLhrscd+yIY
	 cRbx+dRO+0RXHZmk2F7WxS78nMssSJsQC26QxRGbSXjx3KblZ1PytRp8nQ8aCT4HKJ
	 Gs7881Ix6L9UYSfImeCIxYYGTevS1FQIwzUHMzYydGwxjq9bcF2XmewuI3NJHsEait
	 IJBVANLDr6OPGLji+mULNEGrp8t5t1Dq5oaEackeBqDOE4K4q0Egb4f+wQa8gWrP4s
	 ggqX41U5rAyIk1SE4BFxxJcSwdmvAf2lyxFArGRAOB5kkLG+e186cYHH/RCbomxclw
	 IHPPE3CHZtzGw==
Date: Sat, 9 May 2026 23:52:44 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>,
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org,
	thomas.falcon@intel.com, tmricht@linux.ibm.com,
	linux-perf-users@vger.kernel.org
Subject: Re: [RESEND PATCH v2] perf tools: Ensure event leader stays at head
 of evlist after sorting
Message-ID: <agArPG7T5rACOOcv@google.com>
References: <20260505211924.1961056-2-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260505211924.1961056-2-ctshao@google.com>

Hello,

On Tue, May 05, 2026 at 02:19:00PM -0700, Chun-Tse Shao wrote:
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
> Tested on device lacks uncore_iio_0, and `perf test` looks good.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
> v2:
>   Adding missing Signed-off-by from Ian Rogers.
>   Renaming variable `l` to `orig_leader`.
> 
> v1: lore.kernel.org/20260501043532.790711-1-ctshao@google.com
> 
>  tools/perf/util/parse-events.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 1497e1f2a08c..943569e82b82 100644
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
> +		struct evsel *orig_leader = pos->first_wildcard_match;
> +
> +		if (!orig_leader)
> +			continue;
> +
> +		if (orig_leader->first_wildcard_match) {
> +			/* Original leader was redirected to a new leader */
> +			pos->first_wildcard_match = orig_leader->first_wildcard_match;
> +		} else if (pos->core.idx < orig_leader->core.idx) {
> +			/*
> +			 * We are earlier than the original leader in sorted order,
> +			 * and no earlier alias has claimed leadership yet.
> +			 */
> +			orig_leader->first_wildcard_match = pos;
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
