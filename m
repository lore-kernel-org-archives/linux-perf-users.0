Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761694;
	b=EsfoqQ6ewQlGl2gRfbvpJPyaFXn7cjFjfizqTyZK8ufv+CKU5ypwYIYdOENaOBXK0eBe
	 JyATHZjSbmKb24KJfUUOx1wnnQSe+ZELonsHLqFskGEqSFIECEmivr76mLukFSHs2zYtE
	 3PJoZmXOAhM9hBnYoBk5GLhzbPjEanA4jROER4a/3virudysxci/LKmvwBwZnhkb3XQ7I
	 Br3+nS2DgkY/K4+55JswrWpJBWMWBEZRFvB2SCFzRMSIMIxuIVT6YSJQ1PaujA3mnlgF7
	 T1OgoZdReXxEyMJ5S6MIhWVdHcCP+pvrXpb9cOxrtOs2cQX2EGxKjXlxxRfz+cZsMJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761694;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1GfuzYz6MzplaA8uhmTwN84piy/jG9MT9mnLSR5G070=;
	b=KeN7lEs8my4RQ2eW4l3aXRKljN+OCP0i5rq938DS8O0A7J0xX9u6HGhqH4LOJZ1kXCzl
	 VSEP2BnXZXMuXjFIJY08VqJj4nOqf7o+c/ycEFDC9LfrRGcacN4qjwGWzxoBDtfBUyGd7
	 th3tlitIqoNq5ATHiiBaEztME3lT+7a9m4JDlrNPzBL9jEeM8y2j9DfJkboNM35+FU0NM
	 /mFj9t5w/PJFWsfAMtmk2DJvKYPzxsUFFrcugHeCWXu2v7dy0ObBjwAldds+E49Jav+f3
	 cByDdZ64a7+3lcg9Dm2WtgIq5GmPSbHXLgiuMlvBUN3HydK7AJ/BIzqL3joxGCO5MWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K+jDUUaR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F22606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 03:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K+jDUUaR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789EE1F000C1;
	Wed,  4 Nov 2026 03:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793761693;
	bh=1GfuzYz6MzplaA8uhmTwN84piy/jG9MT9mnLSR5G070=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K+jDUUaR03yL/DFAHIERiEk+7bXTu2z65M7ETUUMqKfhVjerb8C9nXfOPZdCrOyad
	 HWoH1hPZIE/q+NgBq+W3r/2nBlFOk3533iwugpmVCdFrsT0PaONuDSOIcWnM0luRr9
	 c47t3ECDq3kWOZH+JkAObABLVOw6KWJFci///fR+xC9iXFVDh54MQS0WoYajdzkWu5
	 tv3Tu9DnvY1mKaL8AJpA6tvTWhGWFvycqY9PCm3fKEsmdNs+eGQMOJ4pZh5vHV4wsa
	 8Pxe08PVs7KcbwSnS8WkG5rokG9x7MvjgQEOkK4rKPQD461LAP6+D6ArVl/wZ6CXdq
	 JFZCsfxtuZPJg==
Message-ID: <sashiko-outbox-196585@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 3/3] perf: Add Raspberry Pi 5 (BCM2712) AXI PMU
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104030300.1140180-4-irogers@google.com>
References: <20261104030300.1140180-1-irogers@google.com>
 <20261104030300.1140180-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:08:13 +0000
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
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104030300.1140=
180-1-irogers@google.com?part=3D3

