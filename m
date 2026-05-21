Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EA132E151
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 21:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779397737; cv=none; b=QDFUIEYHsxgT+9A3DvwEuPsj6fi0AkkVbRimt5KT12jo9QI+tYzxC72d7DummwLahBHpraKYUaXXu7mv1wZF9ibpDiPUBAayBcLy/mlkISdE8FbUB3m5BDiBIxVtnt6wFYumLRSPRxT5+5LzirzmRjL+WRev4K2Fj8ho1en81to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779397737; c=relaxed/simple;
	bh=tHuw0riGfcLn+SlEUGRfqZeD+oBogJUhQ/G/X7r38sQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lP4nykBAQBDAjK4wRoqrC1SGfJ5EZCPSOLn3FMkkR+gnkW1FBBrAzsfa+w3zyL0Jm+y/wYztYw89WAGWihGVw3wK/9ulaTTx9Jls2ma6/p2mgXiT8OFrWezZkWpq3hfuafwi/zRIKYgdkMrxu4Chp/AXvX3JBmVF/flBvldyjb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EK8zDlWn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EK8zDlWn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4751E1F000E9;
	Thu, 21 May 2026 21:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779397736;
	bh=BaOaqVmiQSIVM+MJkJ4WEzh3iHHRkkACVioNjQ8r6IQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EK8zDlWnwbXhk3p1hVeRWc83mR/uMWOpQ81Vw7qG14x9tJc8I0qVxsD6h1HxJunPF
	 +5nHhV3fQUrvFt7nJg9LaNDJcSxZosuTNPvpfs7/FFFpsjodBIEwxSzmmvIywM6ga/
	 ROSS+2gRYbqh6vidiqFfVHBW7a/j9D4Q5IOWqkcTWkm1r1aXf8o9Cq4MTYIHgWORZh
	 c+NpzSunnaf012PrMBMu1T3UzJm6iCohEQxp82uLszIx/rfMBxBCVBCpy1ZLHI+c2G
	 5LYRhoxctY4E/kxu51E0vCHCLSgh4SwPhx+/+AQ9YxmPY3lAmh/XwY0xgCBMDed1ml
	 lnoDLNJ/4p9Yg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] perf stat: Use aggr_nr scaling for Intel uncore
 miss latency metrics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chun-Tse Shao" <ctshao@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260521201505.124690-3-ctshao@google.com>
References: <20260521201505.124690-3-ctshao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 21:08:55 +0000
Message-Id: <20260521210856.4751E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Replacing `source_count` with `aggr_nr` for uncore events yields=
 mathematically incorrect metrics.
--

commit 25ed3f24e52414351780a2cc517f2d6534c79d03
Author: Chun-Tse Shao <ctshao@google.com>

perf stat: Use aggr_nr scaling for Intel uncore miss latency metrics

Update metric.py to support the new aggr_nr keyword in the python metric
generator. Replace the usage of source_count with aggr_nr in IntelMissLat
inside intel_metrics.py so that uncore latency metrics scale correctly on
multi-socket and SNC systems when aggregated globally.

> diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-even=
ts/intel_metrics.py
> index 52035433b5054..d99c7dd43797c 100755
> --- a/tools/perf/pmu-events/intel_metrics.py
> +++ b/tools/perf/pmu-events/intel_metrics.py
[ ... ]
> @@ -674,10 +674,10 @@ def IntelMissLat() -> Optional[MetricGroup]:
>      else:
>          assert data_rd_loc_occ.name =3D=3D "UNC_CHA_TOR_OCCUPANCY.IA_MIS=
S_DRD_LOCAL", data_rd_loc_occ
> =20
> -    ticks_per_cha =3D ticks / source_count(data_rd_loc_ins)
> +    ticks_per_cha =3D ticks / aggr_nr(data_rd_loc_ins)

[Severity: Medium]
Does replacing source_count with aggr_nr here yield a mathematically incorr=
ect
metric?

aggr_nr evaluates to the number of CPUs in the aggregation unit for a speci=
fic
evsel, while source_count correctly tracks the number of PMU event sources
(e.g., total CHAs).

For system-wide uncore events in global aggregation mode (AGGR_GLOBAL), each
PMU's evsel typically monitors a single CPU mask, so its aggr->nr evaluates
to 1.

Could dividing ticks by 1 instead of the total number of CHAs result in
metrics being off by a factor of the system's CHA count?

>      loc_lat =3D interval_sec * 1e9 * data_rd_loc_occ / \
>          (ticks_per_cha * data_rd_loc_ins)
> -    ticks_per_cha =3D ticks / source_count(data_rd_rem_ins)
> +    ticks_per_cha =3D ticks / aggr_nr(data_rd_rem_ins)
>      rem_lat =3D interval_sec * 1e9 * data_rd_rem_occ / \
>          (ticks_per_cha * data_rd_rem_ins)
>      return MetricGroup("lpm_miss_lat", [

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521201505.1246=
90-1-ctshao@google.com?part=3D2
