Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2608D377AA6;
	Sat,  3 Oct 2026 01:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991208; cv=none; b=hg38AHZkO2AZ1pHlcXfE1HkK0T+eC0ywiTCZH5fUAkt5ddM2f8ghx21fP3zjwwvKxSpq7hu4p3hb5w2vUlO11mldyEmSCxNMqCFGbXVnKnXfemH6u2bHvXWimmdTenTdB2QB4gCSgt+078Z5t/iP7HXoqN3Qp8ehE/kaSsqAofc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991208; c=relaxed/simple;
	bh=db01s1Dcl2cxZXktyr+XBOA6phZF7oPtIpHSDRh3LFA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MCze1U0RzCdedIpHba+Y1KKS0/I5RJ09KR7FY5PaH0lAp53TgDiKNANTMX5kOFKJ+5auoyflJOtoJiugM10xlFcj049dpGjEZJArkpmk95w6jJOZ2HfG12oPqa+SlrFIFqltzm6yP661/xMPMG8aZSf9umyKyagXJtKfIckmGR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlVDhjUM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlVDhjUM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9F91F00893;
	Sat,  3 Oct 2026 01:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991206;
	bh=db01s1Dcl2cxZXktyr+XBOA6phZF7oPtIpHSDRh3LFA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VlVDhjUMNZ4P3mPtbdD2waAhuaNManmQliyHZHPnNNuQLrA+j5BZi95SiLRQ/j6Hu
	 5wtcpuAUpi2nxzXoLmV643PS76mkjTI2Ii+FOQj1fauSz/KkPbDvhH5SlK//mx3g5e
	 L5O8PQbl/+UtFCa9OExbfROPUcq1tsIVehpmc2f2Xgxwp0mEaj5eCaqNDpdq0277SS
	 Sc9JXZACXnj0FVsfn03j3b60KgdYpREZWQetaGOuvlBDvU/HuxUexc+KhvNQB5ebv7
	 JYQ+PRqHq2jAUHnpcJrO4rqj2zPSPyp2WUjnslN9qhp+oTN8jE9z2b9mONqLzSg3yC
	 MqwgZwMlNGRwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 3/3] perf: Add Raspberry Pi 5 (BCM2712) AXI PMU
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20261002175738.3242646-4-irogers@google.com>
References: <20261002175738.3242646-1-irogers@google.com>
 <20261002175738.3242646-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:26 +0000
Message-Id: <20261003013326.AF9F91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Extend the Raspberry Pi AXI PMU driver to support the Broadcom BCM2712
> architecture used in the Raspberry Pi 5.
>=20
> The BCM2712 SoC drops the legacy VideoCore VPU monitor and exposes a
> unified System monitor via MMIO mapping distinctly different hardware
> pipelines (such as DISPLAY_TOP, ARGON_TOP, BSTM_TOP, PCIE_01, and XPT)
> and expanded 6-bit AXI master ID filter tables.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002175738.3242=
646-1-irogers@google.com?part=3D3

