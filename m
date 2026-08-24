Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5477B3E7BCA
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 06:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787554431; cv=none; b=npc8yyALVqsutASQ/RPPumBgEikJSPFfG6z1lx8hKpUPjdVObz/HQXNKCTUX7w6trF1xVkof/KLnoX/HFteDByaGcsrWHFivX+/KIv1156YIFavONvee52JS4B3Kv9v2TDswLZrQZJcceS9cI646rQkc4svvu3sNW5VjWMcsSy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787554431; c=relaxed/simple;
	bh=D9J4qyD9vwHtq3IZNEkIHURFq+2H4+lSsLS9ylu1atI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eg23J1ozFtTTaqPtrMQKggWy4HBEbpMZJqGEzDUgeGjMxBAnwmflvw3Vo2pyNUz5x9geWQrw5r+qWCl+Zvxxj3wiw5nwj2GAfsQbWOk9JwEcdLmye1Gmam5S3saevuAx9t7p7ru1jEu02BCPXlWb5OUDtmYFPKAf+ACIQ5XW+nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4x0DRLy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4x0DRLy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1851F000E9;
	Mon, 24 Aug 2026 06:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787554430;
	bh=u0Prj3LZbOWk8vuOj1FY5Qu8O1f5wYD6VPMabiUX+GU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e4x0DRLyyKwz3dUKnzNXVLooViZpPf7gL37I66q/dX/otoZq4YMkizS7wZkBUWPlU
	 FFEFr4bySXW1bBXGAjXGA/fyg9B0SPkH7M3/OQ8hykisN99VkYfGUqFE1wkojgsC7K
	 VkCe6OQ8Ly4N1QH8kV4xdekNA5Ll6LCV61HKzc67sNOAmGCCE2mJtQSupKT4ifeyEi
	 VPSuw01hn+lwEHZip1aez39kyybCfccCSfKE8TN74ifNxzoqwKfeb9fvs93M3Owj18
	 r5N4ALQ8sU4CX0wjZ+Ztk5iQ/Q0rDnxfdeLCTjRe2Z60AYUex4Ia5oUF2GtTYflbY2
	 W8jMHTz117G/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/7] perf ui hist: Add support for aggregated
 total_period and merging entries cleanly
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824063744.1533837-3-irogers@google.com>
References: <20260813132519.4099508-1-andi@firstfloor.org>
 <20260824063744.1533837-1-irogers@google.com>
 <20260824063744.1533837-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 06:53:49 +0000
Message-Id: <20260824065349.EC1851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] hist_entry__get_percent_limit incorrectly early-returns 0 for me=
rged histograms when the group leader has no samples, causing valid entries=
 to be hidden.
- [Medium] __hpp__sort_acc does not aggregate fields across pairs when merg=
e_entries is true, causing incorrect sorting for accumulated callchains.
--

--- Patch [2]: [PATCH v1 2/7] perf ui hist: Add support for aggregated tota=
l_period and merging entries cleanly ---
commit 7077e4a680da4bc6b3a68f49b2a79f0a03e770ef
Author: Ian Rogers <irogers@google.com>

perf ui hist: Add support for aggregated total_period and merging entries c=
leanly

This commit implements cross-PMU histogram sorting logic to support merging
entries cleanly. It scales the global total_period to fix symmetric percent=
age
ceilings across different core types. This resolves issues with --percent-l=
imit.

> diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
> index e58327595d37d..09f0baa808e0a 100644
> --- a/tools/perf/ui/hist.c
> +++ b/tools/perf/ui/hist.c
> @@ -287,6 +287,24 @@ static int __hpp__sort(struct hist_entry *a, struct =
hist_entry *b,
>  		return __hpp__group_sort_idx(a, b, get_field,
>  					     symbol_conf.group_sort_idx);
>  	}
> +	/*
> +	 * Relies on merge_entries being only enabled if there are
> +	 * only matching events. If that is ever relaxed will need
> +	 * more logic here.
> +	 */
> +	if (a->hists->merge_entries && b->hists->merge_entries) {
> +		u64 val_a =3D get_field(a), val_b =3D get_field(b);
> +		struct hist_entry *pair;
> +
> +		list_for_each_entry(pair, &a->pairs.head, pairs.node)
> +			val_a +=3D get_field(pair);
> +		list_for_each_entry(pair, &b->pairs.head, pairs.node)
> +			val_b +=3D get_field(pair);
> +
> +		ret =3D field_cmp(val_a, val_b);
> +		if (ret)
> +			return ret;
> +	}

[Severity: Medium]
Does __hpp__sort_acc() also need this merge_entries aggregation loop?

When sorting accumulated fields for hybrid events, hpp__sort_overhead_acc()
delegates to __hpp__sort_acc(). Since __hpp__sort_acc() lacks this
paired-summing loop, will the default `--children` sorting order evaluate o=
nly
the leader's he->stat_acc->period instead of the aggregated global samples?

[ ... ]
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index ea79628bbc6b3..6cb7059e8405f 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
[ ... ]
> @@ -445,6 +447,9 @@ static inline float hist_entry__get_percent_limit(str=
uct hist_entry *he)
>  	if (symbol_conf.cumulate_callchain)
>  		period =3D he->stat_acc->period;
> =20
> +	if (he->hists->merge_entries)
> +		return hist_entry__get_percent_limit_merged(he);
> +
>  	return period * 100.0 / total_period;
>  }

[Severity: Medium]
Will this new check be bypassed if the group leader recorded no samples?

Earlier in hist_entry__get_percent_limit(), there is an early return:

static inline float hist_entry__get_percent_limit(struct hist_entry *he)
{
	u64 period =3D he->stat.period;
	u64 total_period =3D hists__total_period(he->hists);

	if (unlikely(total_period =3D=3D 0))
		return 0;
...

If total_period is zero (e.g., the leader PMU on a hybrid core had 0 samples
for a workload), the function returns early. Could this cause valid merged
histogram entries to be hidden from the UI because the new merge_entries ch=
eck
is never reached?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824063744.1533=
837-1-irogers@google.com?part=3D2
