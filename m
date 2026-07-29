Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5D73AFCFF;
	Wed, 29 Jul 2026 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337874; cv=none; b=tbwnDSpCf0kl4MLuPYo804/dpG51+X+SGGgpLAIJdMmFHVXa3gFJyf5RWk06n5Fz1S51hzplJZYPqK7DzFsS7AE/TBlQcizqUUm6n4HAMYR8mjMaEAmuGKw9ITNwyaRm1gHxAmb+C1xIfGXMF4cmqCQf8yv9H7AKyoVS1otoRs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337874; c=relaxed/simple;
	bh=GZrCaFMHQYQBy3Wj6aMZE9RPlmbFQVvvHf2IhSSJlmU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hFGW+8AWUHrh0p1atFUAGmas5YktBgWLj1sbvrTjxI55uiBZ7660ZAANiQCU/rF1SPZwZt0KyPVameh975tB2w0qczWMD7lgt0GyOprXf+NaGN+ExyVz3tnW3g0U1ls6o7Pn/LeeCEl1Qnm94pzchBcedWId5avofey/5ocxoN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLScpba0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLScpba0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D391F00A3A;
	Wed, 29 Jul 2026 15:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785337872;
	bh=jX/Y5r5j+DCdJw2oVnD5BtN9G1Dc8RDrn9/CsBF/FNM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CLScpba0SrIGOyBknDwEflkPyeCiJGZTDpusUx/ngF+Hj++xDH+d/7N09oVc9CZnO
	 +pE91T3uDFRahPzF3zf+wzMyPmwkOJOo+h4V0MbL9pTroNyO1yazd8cml60nFWmPgB
	 ec0TT8TT+4DBkqEwNThiyQcUZgoF4x+DvV+VKJn+rULQIVTed/94svF5VzXpB0T1hG
	 +fIfei4hr0WjSZug4Q8Xho4WtS7/L85+lLvAps7MxwmNtpCEKNsmTp19ClIJ5jFbUN
	 JqDi+1DTPRHXGsjTlDVb6TFwKzf5gmCP/3rGq7i1t3XrKhMeYMrO5E14r1MiHXKE+S
	 gYwDSi9ejt3KQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/9] perf/cxl: Validate the hardware-reported counter
 width
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260729145555.3919550-8-dave.jiang@intel.com>
References: <20260729145555.3919550-1-dave.jiang@intel.com>
 <20260729145555.3919550-8-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 15:11:12 +0000
Message-Id: <20260729151112.B1D391F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds MMIO write via `writeq()` overwriting the adjacent 3=
2-bit filter register.
--

--- Patch [7]: [PATCH v2 7/9] perf/cxl: Validate the hardware-reported coun=
ter width ---
commit 5420efbe1c059e0ba51ccd9a185a7ae26d9866db
Author: Dave Jiang <dave.jiang@intel.com>

perf/cxl: Validate the hardware-reported counter width

cxl_pmu_parse_caps() takes the Counter Width straight from the CPMU Capabil=
ity
register with no bounds check. A device reporting width 0 or > 64 is invali=
d,
so reject a counter width outside 1..64 at probe.

Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolab=
s.net?part=3D1

> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 52e78a6e09603..2e817a52ff1e1 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential
out-of-bounds MMIO write in cxl_pmu_event_start() in this same file:

    writeq(cfg, base + CXL_PMU_FILTER_CFG_REG(hwc->idx, 0));

Can writing 64 bits using writeq to a 32-bit MMIO register cause an
Unsupported Request (UR) PCIe error on devices that only support 32-bit
access to this region?

If the hardware does happen to accept the 64-bit write, will this silently
overwrite the adjacent 32-bit filter register with zeroes, corrupting its
state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729145555.3919=
550-1-dave.jiang@intel.com?part=3D7
