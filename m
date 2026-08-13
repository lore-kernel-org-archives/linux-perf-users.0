Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1837499F20
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 17:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786641098; cv=none; b=AVMBKThcc2Pot53v3KShbf93g6I2DYngZS+kJaFVX92v1tY9CbU83nqIQXLQnwUu8KoOmYv5/oxHFnLnsJ551vOegugq/YIt/F5frGiqBzvw+XVj6PgmqqL6QQF24XKohYoLHJm0qTXDInI9rmTBgZkbRoc75UVBbFu7TDYALMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786641098; c=relaxed/simple;
	bh=TOFmlxv9+DFIZi02JxEWIxIv5ntnfC9v3XAtaAT6pAU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aX4Gx8NMmk8XKDbYqKYNF6pSzBOJM1oECF9/ByMkllg3e+/dNRj8ITOsSP95o6QmGl7eArJDJd25D6Xyn7O8WQJfZAWiCBW2BHSJSno95O2bQ9y9taBNdyLr9+9maMOwBd3p+2glxKyZkuMizbb0yq3mjI4nLEMExGRCqs0gDwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoM+uAy9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoM+uAy9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E26F1F000E9;
	Thu, 13 Aug 2026 17:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786641096;
	bh=TOFmlxv9+DFIZi02JxEWIxIv5ntnfC9v3XAtaAT6pAU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hoM+uAy9f1e1+tZ5t/nqtJlLxb2LEHykvuOLSVDEnfMMBNydSp1w0JGdMw71ceiJ/
	 /dIggygMRxDa5r6W4sniUj2q4aO6z/Zy2G3a8wZ9Pw12jdGTdKTCqIE+7S/7+0TMXC
	 +fhWFYdPkTuYEbwarROEw1v149MTahkC/otowPAI4USAqd45+MpPV85ba30WgTRuCx
	 nGmkJ8NKUesZ+Cfe+roqFiNGcFHPE9MBFmqBLKTngJza0XAPIvp8RxGRAYl/oXbwyL
	 ES/d0mbLocNq2H0KPVTiSOwxiOBmcD/wckfiV6odWg2CM5UgrtDe3OD/Coivt/TLTr
	 RiRM5ywpSJO8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf vendor events arm64: fix swapped MetricGroup
 for Tegra410 L1 prefetcher metrics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Besar Wicaksono" <bwicaksono@nvidia.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260813170155.1156593-2-bwicaksono@nvidia.com>
References: <20260813170155.1156593-1-bwicaksono@nvidia.com>
 <20260813170155.1156593-2-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 17:11:35 +0000
Message-Id: <20260813171136.5E26F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Saurav Sachidanand <sauravsc@amazon.com>
>=20
> The L1D prefetcher metrics (l1d_cache_rw_miss_ratio, l1d_demand_accesses,
> etc.) were incorrectly assigned to MetricGroup "L1I_Prefetcher_Effectiven=
ess"
> and vice versa. This causes 'perf stat --metric-group L1D_Prefetcher_Effe=
ctiveness'
> to display L1I metrics, which is misleading.
>=20
> Swap the MetricGroup assignments so L1D metrics are in the L1D group and
> L1I metrics are in the L1I group.
>=20
> Fixes: 86ff690f45cc ("perf vendor events arm64: Add Tegra410 Olympus PMU =
events")
> Signed-off-by: Saurav Sachidanand <sauravsc@amazon.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813170155.1156=
593-1-bwicaksono@nvidia.com?part=3D1

