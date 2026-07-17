Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF4F28640B
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 02:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784254886; cv=none; b=IDjqF2wZT3lnmrNxY7BkOCmWtJ+v2BtHRwepWaiuc2mCS9Cq1mDYISbB6c97dQdailijHtKCZcvwsUIUnw4fvmRQMEW7VuGDsaQc7/dC6FcwWuAhxR3V8Or8YAWNBU7Igjkq/MVQu7z5NJ/gjxh6lqD3eSuysZPa+mvTZOP1l0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784254886; c=relaxed/simple;
	bh=BTqWa9RtU/sO7tS7fjCAg/Dcwq5On708u8ezTjDU7kI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qExqQYzJnTD39QMVWzBNOgteNR4KaknND8y6eeHq+wdt6NECq5IToXTY/HPZ1hryS+WprDgXYO+/UadkXcVvmoBhKCdSS8z7FnLqvLrJOcwwreT996cbyRFUIhxFPUM+ZDL6YVLGZJ3ClqsScHukTdbPRrAd00u1TDz66+n34cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLoBvbQW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLoBvbQW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D8F1F000E9;
	Fri, 17 Jul 2026 02:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784254885;
	bh=Jwcgc73TH5T5lKjrhOej0Nfm8NODQpwgxcopTdMgI2c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nLoBvbQWel1KFjdslFXhC5kvbxJRoS6ixmqluYf2vkuVBNcr7ynHHDMeQtIFa4PVm
	 RnSARb5NNNqOM2Maabz787XHhM3dsMSUE3yMxKhnDK3/iwH/tVrfWG9NAU9Q3Zwrt7
	 6JGOyotcwCtGPCXrXZ9zutynhkOKNlmpv/nb0fGoOf3UcqF9shSv+YZUh+QKcuPFcJ
	 YhjI7JpaGLW6h9b+FMBb7D9ssoF+XqdGHarRNVxThlOZ9u2/Ar4dfNolV+bk+vMh9n
	 aQ6Eabx74CA0AD1bPM/NhxkPgyD7l9TmiMQT16UO9QfzHu9JuLc+2Np4C0rVEqjNqL
	 0PnASfT+SM9+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/14] perf c2c: add column format infrastructure for
 function view
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260717020530.1645123-5-jiebin.sun@intel.com>
References: <20260710084247.3576706-1-jiebin.sun@intel.com>
 <20260717020530.1645123-1-jiebin.sun@intel.com>
 <20260717020530.1645123-5-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 02:21:24 +0000
Message-Id: <20260717022124.E6D8F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] c2c_hist_entry__cycles() incorrectly calculates cycle counts by =
omitting peer snoop latencies and misattributing peer load counts to the la=
tency of regular loads.
--

--- Patch [4]: [PATCH v3 04/14] perf c2c: add column format infrastructure =
for function view ---
commit 989667f800a57839109dc11e25255b1d88273729
Author: Jiebin Sun <jiebin.sun@intel.com>

perf c2c: add column format infrastructure for function view

This commit adds the column format plumbing functions used by all function
view dimensions. It introduces helper functions for calculating symbol widt=
hs,
dispatching column widths, and rendering multi-line column headers.

> diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browse=
rs/c2c-function.c
> index 1ef5d08e81c39..ace7e3f27b55c 100644
> --- a/tools/perf/ui/browsers/c2c-function.c
> +++ b/tools/perf/ui/browsers/c2c-function.c

[ ... ]

> +/*
> + * Return the estimated total cycles for a c2c_hist_entry
> + * (rmt_hitm + lcl_hitm + rmt_peer + lcl_peer + other loads).
> + */
> +static __maybe_unused u64 c2c_hist_entry__cycles(struct c2c_hist_entry *=
c2c_he)
> +{
> +	double cycles_rmt, cycles_lcl, cycles_load;
> +	u64 other_load, total_hitm;
> +
> +	cycles_rmt =3D avg_stats(&c2c_he->cstats.rmt_hitm) * c2c_he->stats.rmt_=
hitm;
> +	cycles_lcl =3D avg_stats(&c2c_he->cstats.lcl_hitm) * c2c_he->stats.lcl_=
hitm;
> +	total_hitm =3D c2c_he->stats.tot_hitm;
> +	other_load =3D (c2c_he->stats.load >=3D total_hitm) ? c2c_he->stats.loa=
d - total_hitm : 0;
> +	cycles_load =3D avg_stats(&c2c_he->cstats.load) * other_load;
> +
> +	return (u64)(cycles_rmt + cycles_lcl + cycles_load);
> +}

[Severity: Medium]
Does this calculation correctly account for peer snoop latencies?

The function comment explicitly mentions including rmt_peer and lcl_peer,
but the implementation appears to omit cycles_rmt_peer and cycles_lcl_peer
entirely from the cycles aggregation.

Additionally, by only subtracting tot_hitm from stats.load, does this
inadvertently group peer load counts into the other_load bucket? This
would cause peer load events to be multiplied by the generic load latency
instead of their actual peer latencies, potentially skewing the performance
metrics shown in the function view.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717020530.1645=
123-1-jiebin.sun@intel.com?part=3D4
