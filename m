Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932B11C84D7
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 21:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776376570; cv=none; b=nJPQTMAPN65UrPx5ggBNkw5Zq9nxg04Oqz+CQAAXgtYYaGNMHcqRaX9T17eA501J8/HGCO7Y5jJuQxQpUnSqmSucq/BTyrfcG0XGGRHvyLpTIVuZaSe736QENR40bE+NmKbUVlPHUJ/8EeQIh9v8+v97Y40Uejqwo4pzA3v+qUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776376570; c=relaxed/simple;
	bh=2JyGZFA/w30OKHsTN3zjA78zuOknwh7AKENa81QXsow=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XGBD+2bTxz5xwBDRu8Qwvfu0EzFvAjBgR4ILCLJxSUYFfwf1kb3nU+rdit16pt5kEZicHVfsFqTKuGjZHiARKBiB8QsNg+FADZS0AWyZTod08mobKm7QtGbj+ZAE6TsgnDpXKLVLCa1pKww0sjiQE9fWZTlQdsrPexyIlNxMFZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2REDOT+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2REDOT+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21210C2BCAF;
	Thu, 16 Apr 2026 21:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776376570;
	bh=2JyGZFA/w30OKHsTN3zjA78zuOknwh7AKENa81QXsow=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=I2REDOT+321oDm6k+b9daUIAwIq29NXVGbUUhxKrwLIvpq9PqcPqFnTMIZwpRDpN/
	 SJCMb806tjuTjHY/j/J/a8CCBIpVIjM6An70WLg6KU1Jy4gnVORXfb3hMoxF4yUaTb
	 Jx3gZCZg0JtbRJ9gxBVc3pXhtabsHk3DVXQ8zORyOyJC7HrGWgR+uY17jVE6jaz0S5
	 p2jo9AjX0vad84GC/5bWNbsl/TJkguLqUSXTZK2P9eEL+9/CnOnwEb8b+CObwT+kWe
	 WPrSMu3D0L1z6g3qBHokeCJNGhb10vzsNny4q8YrZxf0WDIo+6NmJyAsC3893dcBlL
	 4b+oo7C3YACDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf stat: Merge CPU maps when merging uncore aliases
Reply-To: sashiko@lists.linux.dev
To: "Chun-Tse Shao" <ctshao@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260416204828.1303734-1-ctshao@google.com>
References: <20260416204828.1303734-1-ctshao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 21:56:09 +0000
Message-Id: <20260416215610.21210C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] Expanding `evsel->core.cpus` without reallocating parallel array=
s causes a deterministic NULL pointer dereference and out-of-bounds access.
- [Medium] Missing error handling for `perf_cpu_map__merge()`, masking memo=
ry allocation failures.
--

commit ca357f612c76d14c9a719708c9f0cdce0f262717
Author: Chun-Tse Shao <ctshao@google.com>

perf stat: Merge CPU maps when merging uncore aliases

This commit merges CPU maps for aliases in evsel__merge_aggr_counters() to
prevent the display logic from hiding sockets with zero counts. It aims to
ensure the aggregated event correctly reflects all underlying PMU instances.

> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 14d169e22e8f5..d696d217f98d6 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
[ ... ]
> @@ -535,6 +535,12 @@ static int evsel__merge_aggr_counters(struct evsel *=
evsel, struct evsel *alias)
>  		aggr_counts_a->run +=3D aggr_counts_b->run;
>  	}
> =20
> +	/*
> +	 * Merge the CPU maps so that the display logic (e.g. should_skip_zero_=
counter)
> +	 * knows this merged event covers all CPUs from both aliases.
> +	 */
> +	perf_cpu_map__merge(&evsel->core.cpus, alias->core.cpus);

perf_cpu_map__merge() can fail and return an error code like -ENOMEM.
Should we check the return value here and propagate the error, instead of
ignoring it?

Additionally, does expanding the CPU map in-place here cause out-of-bounds
memory accesses?

Arrays like evsel->counts and evsel->prev_raw_counts are allocated earlier
based on the original size of evsel->core.cpus:

tools/perf/util/stat.c:evsel__alloc_prev_raw_counts() {
	int cpu_map_nr =3D evsel__nr_cpus(evsel);
	int nthreads =3D perf_thread_map__nr(evsel->core.threads);
	struct perf_counts *counts;

	counts =3D perf_counts__new(cpu_map_nr, nthreads);
	...
}

If perf_cpu_map__merge() increases the number of CPUs in the map, later
iterations over the CPU map (such as in interval mode) will access these
parallel xyarrays out of bounds. When the loop index exceeds the original
array size, the access returns NULL and causes a segmentation fault when
unconditionally dereferenced.

Do we need to reallocate evsel->counts and evsel->prev_raw_counts when
merging these CPU maps?

> +
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416204828.1303=
734-1-ctshao@google.com?part=3D1
