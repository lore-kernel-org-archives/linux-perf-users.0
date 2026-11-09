Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211582;
	b=MfY/XLgZHFZewsY8G/oTYvxgLKi9jF22oIWe81Ixx5Cz3oe2kDtcgA1jTbbkFaYTmGwz
	 9ESh44l1XaxfeocE6gkdPtsuM7aCK59bKsdRNkloVSG/31gVMlrKwX7GZD78Ll1Wk9qT1
	 +WANX2y4BRj02MbZn7e2KU7RijOCvPvXoaHVW3+8HAGSiNrwGqXshO4vUAegWIGq4iVmE
	 UKqNlsEK1jrRtrSWRcGJbjH6BU7h6wMMK5WJt9bNkK0ilMyqT30OD7P06zRoR+I3gczi+
	 M7NP/FEWel95INirGwaJdU2bTLTpIZWuJ+BtnEf4V7FYayRogR4EFYe6hoSSVxqwR5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211582;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zb/Z71NmBL4/NE5LGBhbc42dyZCrm+r4z6vTmTBW0bQ=;
	b=SOreLMBuy7sXm7y1lN3XnldEMz036nI1IhIEPZg63FpBbh2t6z3lc4AUp0F+npU7PLuq
	 dd6yxIWBQt/Fki2Kyqzsfo3h6wBw2kj1IuJAV9DNTwShFF12scvkY8BTlEDGRaUJeEtaf
	 9LpfEwvRJ6WgHasqmBT+yPdx9kFIYibQ1d3D+KLZzMSLf2CWT6QS5/fxTSrvldCCEE3Rb
	 K21Z+EaiTwMtE7KN09CaeuXdvPnZkO0yx7uP6rlMhvQbT2wveQ5jZloEra6Sq+X6A9jb6
	 cSkx9R6Cg9qJlc6vz///Pu51mQH/Aif/GSCGdGk4vj2YJLX++DUm+MzpwEDSdwRs0KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=berNbiWQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7F9606A31C
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 08:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=berNbiWQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99501F0089F;
	Mon,  9 Nov 2026 08:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794211581;
	bh=zb/Z71NmBL4/NE5LGBhbc42dyZCrm+r4z6vTmTBW0bQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=berNbiWQmen8pZs/N5sbo2Cd4o8JXR/qLwfGryFbClinAoAIVW2Rg/MCbh0Tt9/VG
	 vQs/rLlu3WEGwSIOK00X24gjqLuHY1FRu3c1eJ5ERUKH44V3fGOiaUNWpnEFX8NUmm
	 MhGJs1uq971yhZKjI+MH6v1AOhxxXxrn5ibz9SMb+hH/mQH7XpUzAEql5YP+0KY7Ko
	 KBhJFFkBApo7uNhd14XCcmTthv+dQZqVRSs5oUyQRy+eBhCQVxnBV2qAYysQWGvnWr
	 n4Jv5CLuaI+07N7ujQDEzoQO90cmMaPQy4sNcs9LRzrKGip901q7VHAgHQlnrZEsW3
	 513MeGIwdgwIg==
Message-ID: <sashiko-outbox-204561@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 3/3] perf: Add Raspberry Pi 5 (BCM2712) AXI PMU
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261109080126.417161-4-irogers@google.com>
References: <20261109080126.417161-1-irogers@google.com>
 <20261109080126.417161-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 08:06:21 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Extend the Raspberry Pi AXI PMU driver to support the Broadcom BCM2712
> used in the Raspberry Pi 5.
>=20
> As on earlier chips, the System monitor is accessed directly via MMIO
> and the VPU monitor via the firmware mailbox. BCM2712 has 6-bit AXI
> master IDs.
>=20
> The System bus names in Broadcom's documentation describe the set-top
> box variant of the chip, so they were checked by measurement on C0 and
> D0 boards. PCIe2 (RP1) traffic appears on the port documented as
> BSTM_TOP, SD/eMMC with DMA0 and DMA1 on the one documented as SRC, and
> SD/eMMC2 (WiFi SDIO) on the one documented as ARB3; these are named
> pcie_02, sd_dma and emmc2 here, and the display_top and argon_top ports
> are named display and argon.
>=20
> From BCM2712 D0, three System monitor ports (XPT, PCIE_01 and HVDP) are
> removed and the remaining ones renumbered, with the external PCIe moving
> to the Argon port. The bus watchers also match a full AXI ID under a
> mask: 10-bit ID and mask fields on the System monitor, and 6-bit fields
> holding the master ID directly on the VPU monitor. D0 is detected at
> probe by whether the ID mask field is writable, and selects its own bus
> table and filter encoding.
>=20
> Co-developed-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Dom Cobley <popcornmix@gmail.com>
> Tested-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109080126.4171=
61-1-irogers@google.com?part=3D3

