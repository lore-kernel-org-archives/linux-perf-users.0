Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2B241B356
	for <linux-perf-users@vger.kernel.org>; Fri,  1 May 2026 18:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777659974; cv=none; b=YlUletmEsVI+B8eGGWxPMh8/42pH/vgpt2HtkwgGG1crT0PXKTB70AAAumFWWrfW9xT9JxoKjiEHvn+ZDd8BusdHWwKc0aa0FjITr2GkmVQcU0CkbALP7GnNdbOQd6dhl35JMTE/Bil1EYmK6ndDNYf1JDjlXirSx7W60yoh//Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777659974; c=relaxed/simple;
	bh=Un459UvnMbdB60qEBrDkDkXnb8KfHeky9CNj15IeuEk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GXN1yUXT3T+JbRpLS0OaOwUXK8JLJ8vKtiFoSkwEiHhu6mnntspUeSZA/N3PEA32i/XzjfpV8V4RlOh+cVTlRIqCeDx3zPOyJHUn2A4F4FeQNVb39RStOCdboK8b/zVpZyf7Ubt6OEAMYkeIDVRtSmK+kW8b3gWfKq3BSXpsWGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWnRy35M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWnRy35M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A183C2BCC4;
	Fri,  1 May 2026 18:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777659974;
	bh=Un459UvnMbdB60qEBrDkDkXnb8KfHeky9CNj15IeuEk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=OWnRy35MHX8odcWn525cZug/iJeVLvuR3Jj8ZTe0VCgnKOedA/ZLszTdPrHQjQZy5
	 aO32/lddmnJfzAsbZoOEfMg2gqFtE6rB9mRO/8pI8JpoyJdOA7o7a3zkG6gLneSFkC
	 kpz4T5f/bWs7xtl6v6cEWvNMsDLmzmi5BzfEBxKK9ztQ2Ke0N8qRKqMSl7Z7rMJAQb
	 0OqyEsk9svR6i5DmYTUsID0sX9HrJ4n7bjExQQGnyULEiaeox99tl7Tbg7+I+D4JeX
	 wTsI+U+1hG3GIlpa8miHnHfvMvpZ20nsBl9QzHYD0KAcLcOrSTK+H/ukn4oCLeL1xr
	 9aoB+337AYQwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf stat: Check aliases in should_skip_zero_counter
Reply-To: sashiko@lists.linux.dev
To: "Chun-Tse Shao" <ctshao@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260501181129.938256-1-ctshao@google.com>
References: <20260501181129.938256-1-ctshao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 May 2026 18:26:13 +0000
Message-Id: <20260501182614.8A183C2BCC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The alias checking loop introduces an O(M * N^2) time complexity=
 during the display phase, causing unnecessary overhead.
--

commit 1ba80061bda839b47a8c18bdc8aa600c735044d6
Author: Chun-Tse Shao <ctshao@google.com>

perf stat: Check aliases in should_skip_zero_counter

This commit checks aliases directly in should_skip_zero_counter instead of
mutating CPU maps in evsel__merge_aggr_counters. This is done to prevent
zero count aggregation IDs from being hidden in aggregated modes like
--per-socket.

> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index 993f4c4b8f442..c12a3405118a5 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -945,6 +945,27 @@ static bool should_skip_zero_counter(struct perf_sta=
t_config *config,
>  		if (aggr_cpu_id__equal(id, &own_id))
>  			return false;
>  	}
> +
> +	/*
> +	 * If the counter is a leader in alias merging, check if the aggr id
> +	 * matches any of its aliases.
> +	 */
> +	if (config->aggr_mode !=3D AGGR_NONE && counter->first_wildcard_match =
=3D=3D NULL) {
> +		struct evsel *alias;
> +
> +		evlist__for_each_entry(counter->evlist, alias) {

Does this introduce an O(M * N^2) time complexity during the display phase?

Since should_skip_zero_counter() is called for each aggregation unit (M) and
each event (N), the function is called O(M * N) times.

If the event is a standalone event or an alias leader, this block iterates
over the entire evlist (N events) to find its aliases.

Could this scale poorly for very large event lists by introducing unnecessa=
ry
iterations, leading to an overall O(M * N^2) complexity?

> +			if (alias->first_wildcard_match =3D=3D counter) {
> +				perf_cpu_map__for_each_cpu(cpu, idx, alias->core.cpus) {
> +					struct aggr_cpu_id own_id =3D
> +						config->aggr_get_id(config, cpu);
> +
> +					if (aggr_cpu_id__equal(id, &own_id))
> +						return false;
> +				}
> +			}
> +		}
> +	}
> +
>  	return true;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260501181129.9382=
56-1-ctshao@google.com?part=3D1
