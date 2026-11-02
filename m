Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793663271;
	b=JL/inaBMExVgoZoi1/u+MOqfHsCXKiNw8/R+atJWTXeTdmE4bVb7yVpUrBjZWScPskl8
	 DCblgv2uPqc2KGpvH5gaKJqdEHfsOX7y81jTn66atSeG72LnALIr2rythlVuiO+BCEYGm
	 mPGt4VnjJ/U4bgaYk+/8KrISle90df7phFdHD1wmffsJK9ostWk1yLvcoiRWwtdlY2OrM
	 R8uvTSXuewXHw7Zz/dAbTb85owc4+gEdlkcEqs+t29WlwGIatU2d4kraaMbSqjQhSU4Ek
	 P6f2m8+ffLdmYHzkBefY9ULmqi8ZbZlsXt7REC09M3Tg80TX7dy57UUB7L6K72DhsJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793663271;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ySFMoX3UbkfKHS74foTxnNVbxm4RAMrmoY2gtbnJdh8=;
	b=4Rr4i2YVXi05Msn18VRyOEnjwNAY/et6ccjG8fQORuTrrGRIqDv1cO+FiXqHybRElmtr
	 Np08+FpIRlGbOgsacwL5cT0akYDdwu5+ncAnJ0rys01ENcK8b1ywT2WjM5hb6hJq/kyVc
	 jr6AR5Vn/ss+E+7hnkXn4J9A2UD+4SAgsigDXTp/7eCnzTPJZllqX2qqhyD7zaWIfimFt
	 RngzJbTP9kOscVm9j+01WBVLR7GHSPlRORfn6Wv93jGa89978v7FNqPs2E//TdhxyxocB
	 GHhcnlmxzkZ+LoOQRLm298aJR9LpNyaCtDDUPUz5yMa+XsyGz2rJLkEJx0PyGzy21Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AN663eb3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA06606A336
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 23:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AN663eb3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBAC1F00A1A;
	Mon,  2 Nov 2026 23:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793663270;
	bh=ySFMoX3UbkfKHS74foTxnNVbxm4RAMrmoY2gtbnJdh8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AN663eb3ukwjCmvc160hBz/Z+do9+Yvlsd2p7/iI6xQBD5cyJWcmfjhORqCFnLuVQ
	 jMwIxL7WCE+ZMUxHOmCiMw1919no/hZFedtAyo1DSb0WGpWXw8qDPyWgDLbI2oysjA
	 O/baxoHpFue54xR2dIAVgUHtfpTRfA4dUnq304IIGgYR823OPLjZ5Dr4lCs0GtsVLC
	 g+8t/HDSrppnNJzK3Q6B79EtVtWuM0JV3D0cU1xDUqNJkrkEBb2nc0YkB9LmJMRDJ5
	 EwsoXzVqSEelEVe8AjcaPSFiLj5uz9hkLwz2vCmrcI/7bgT7DhPHUlF0FRZ5ZgWjxy
	 6XzWT/x4VwLOQ==
Message-ID: <sashiko-outbox-194342@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 3/3] perf: Add Raspberry Pi 5 (BCM2712) AXI PMU
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102234301.2242242-4-irogers@google.com>
References: <20261102234301.2242242-1-irogers@google.com>
 <20261102234301.2242242-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 23:47:50 +0000
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
> D0 boards. RP1 traffic (PCIe2) appears on the port documented as
> BSTM_TOP, SD/eMMC with DMA0 and DMA1 on the one documented as SRC, and
> the WiFi SDIO controller on the one documented as ARB3; these are named
> rp1, sd_dma and sdio_wifi here.
>=20
> From BCM2712 D0, three System monitor ports (XPT, PCIE_01 and HVDP) are
> removed and the remaining ones renumbered, with the external PCIe moving
> to the ARGON_TOP port. The bus watchers also match a full AXI ID under a
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102234301.2242=
242-1-irogers@google.com?part=3D3

