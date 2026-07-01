Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BC93612F6;
	Wed,  1 Jul 2026 01:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782870937; cv=none; b=rALSnd6uuokRuipgNF4V0vr6T3dc5B36sseq44lrjccxQ+N4CiF5AcA/xwyHznAkQYonEYk8AqftWjEz6IASfBBY9znrZ40BtjLBjApSHHJXZh3CV3VTc9GvzNcmleLprKgE/Zo9eepe3Q55hrps5PkPwov2uOejXo1arAgn698=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782870937; c=relaxed/simple;
	bh=YLQRiwiNwAMu1Sy6NGJQuSnK0cM5yV192brPt84x3c4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RhTrgB7x4SsXmgEbywddo4wdD7RWQ0Xr7Y+FOQ1eW1RkgxkgQi6NNExppGcVX9C2Bi3u3ao5kzgwsM5cicX7Hv3nHwsGOkAiZNVfFtg/7nI0vajelKRyEcDO5QOcE+8bsl1ic2kDS7WanmlFSpEfzRVVSsDxwae7JaQ8vnreQDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAVuSHn9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAVuSHn9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC6B1F000E9;
	Wed,  1 Jul 2026 01:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782870936;
	bh=KDG6DYlkY9mGU+G3JWqS4Jl00s6qbLiJ09QIn/rUD/Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AAVuSHn9Qbomh3eBP23JUc1gSNzdXfymGIpYiuDQtr52YxiIIthSM8FtDQKXE2avL
	 UcD4uwOqKmqjCME+Uw61J1I1E81mtmZpTdD48ZtRhKktfXuweZC2unvGvzeM42gnNJ
	 3bQYzedRzgvMQT8POvl6D8hHDizAvkCzDQVlSthx9wTKtVu76Aa+y5n1nqCW9w2Qso
	 HFIRk3rtr9uFh5wKzSDpeYfYjv9oBARxsGKiMlAY+EQs4QLAIM+WA/+Qfdhr6kGfM1
	 ZAG0O/Mv0EhaIxRS+0IYsE/xFJ8HjM6KcHVpxqGHuThwh4HGlcw2KIHFXYJ5MTEoDp
	 ZIEbA8q93mByA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] perf/cxlpmu: Support Channel/Rank/Bank filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Davidlohr Bueso" <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260630235002.253297-2-dave@stgolabs.net>
References: <20260630235002.253297-1-dave@stgolabs.net>
 <20260630235002.253297-2-dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 01:55:35 +0000
Message-Id: <20260701015535.8BC6B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] PMU filters (like the newly added CRB filter) are silently ignor=
ed if the requested event is assigned to a fixed counter.
--

commit efebea58e23a015bdb87cae3df5f0d067aa37706
Author: Harshal Thakkar <harshal.t@samsung.com>

perf/cxlpmu: Support Channel/Rank/Bank filter

Implement CRB filtering per CXL 4.0 8.2.7.2.2, and extend the current
filtering support beyond HDM. These filters are only for DDR Interface
events.

> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
[ ... ]
> @@ -627,15 +660,23 @@ static void cxl_pmu_event_start(struct perf_event *=
event, int flags)
>  	hwc->state =3D 0;
> =20
>  	/*
> -	 * Currently only hdm filter control is implemented, this code will
> -	 * want generalizing when more filters are added.
> +	 * Filter ID=3D0: HDM decoder filter
> +	 * Filter ID=3D1: Channel/Rank/Bank (CRB) filter
>  	 */
>  	if (info->filter_hdm) {
>  		if (cxl_pmu_config1_hdm_filter_en(event))
>  			cfg =3D cxl_pmu_config2_get_hdm_decoder(event);
>  		else
>  			cfg =3D GENMASK(31, 0); /* No filtering if 0xFFFF_FFFF */
> -		writeq(cfg, base + CXL_PMU_FILTER_CFG_REG(hwc->idx, 0));
> +		writel(cfg, base + CXL_PMU_FILTER_CFG_REG(hwc->idx, 0));
> +	}
> +
> +	if (info->filter_chan_rank_bank) {
> +		if (cxl_pmu_config1_crb_filter_en(event))
> +			cfg =3D cxl_pmu_config2_get_crb(event);
> +		else
> +			cfg =3D GENMASK(31, 0); /* no filtering if 0xFFFF_FFFF */
> +		writel(cfg, base + CXL_PMU_FILTER_CFG_REG(hwc->idx, 1));

[Severity: Medium]
Will this filter configuration be silently ignored if the event is assigned
to a fixed counter?

In cxl_pmu_get_event_idx(), fixed counters are prioritized for assignment=20
without checking if PMU filters were requested:

cxl_pmu_get_event_idx() {
	...
	pmu_ev =3D cxl_pmu_find_fixed_counter_ev_cap(info, vid, gid, mask);
	if (!IS_ERR(pmu_ev)) {
		if (!counter_idx)
			return 0;
		if (!test_bit(pmu_ev->counter_idx, info->used_counter_bm)) {
			*counter_idx =3D pmu_ev->counter_idx;
			return 0;
		}
	}
	...
}

Since fixed counters do not support filtering per the CXL specification, do=
es
writing the CRB filter configuration to a fixed counter's register result
in the hardware silently ignoring it? This could lead to unfiltered counts
being returned to the user when they expected filtered statistics.

>  	}
> =20
>  	cfg =3D readq(base + CXL_PMU_COUNTER_CFG_REG(hwc->idx));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630235002.2532=
97-1-dave@stgolabs.net?part=3D1
