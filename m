Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794024992;
	b=U2YxLWo/NX/UJwXmwl3TOtHLskcTb3W7zgz7CPU88DYKxPMVsl6Ir1fgmSOQP4/2wgEl
	 fu42QND6LKZiLWyDm87ghjnuAaijMHOAdy6mH13/5Ndr9T45hq5xO4i0AYNOHDPlzhXGb
	 LKLmnjpbstfkh8ZkHP+5fyo4SRSlKdpsnL15xAJFewuuwx7yiG0oeijgzINIW8xUI4stO
	 E7RAYiKAJe12riix6u+DNb0sJYoyBiQbdk5vs5MZ4GhC/8gV18X67kLqpa8Hq2fVXvtDN
	 hQYgSyLIFzsabDgSijrG7GsPPPT34vYhbhcJRIvS+BJ50KqMjCqQouwbloRrVHISx9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794024992;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bRbioLoPoDGrr9Gun16SHWQf6dOTmC26OjecA1FRFtM=;
	b=czNLnFM4XPXu2VaiHqTB4eDai14qfGI/8WwCYzdHRvIDPEwFqccT0kERUiiMZUX1bYNo
	 f+5D755QwHXiQD1nq7yuHbODVeVpXmvrvOErNwaTtPfJpL8zwuo/XgaEryGQwoXm1ibyz
	 EA6Q7kR/6x2BLqXD5zIXq35689NXlX4ne1wMLEpisx0mma1JqXo7+VUfNM0/C0yryFSa5
	 yTzYx8TnV2X5pzYxtpSwbqscPVoeUllAjYiaHFSKiBqZlbaDqQL59FcqhBPnmJPYqZNs9
	 BXIPkCXZX7SJYozjd0gKEfspHjQ3YuSSXP+ILCSivYj3VClDnCzVEDvIEztQ172fXLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XobJyN4T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A342B606A326
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 04:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XobJyN4T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0922A1F0089F;
	Sat,  7 Nov 2026 04:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794024991;
	bh=bRbioLoPoDGrr9Gun16SHWQf6dOTmC26OjecA1FRFtM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XobJyN4TGgwHH9bZNKCMgzJqfSJSwZqJ2RSZ32EVKOvIrn2tMTaKfBEqRyILtvFFR
	 SWaOR9iwmMOQxLHjGkgwvRCSl4vbPERFXnghsC/WlkJ34XIYWvdmw/52D0BlceIeLP
	 h5C/HmYLbLejy/pN7Wfu5esLsYLmYuBTOMPN27Rn0mEC2bATeuIjAcCA6fVhGf5bsc
	 3/WYJw80W9eiSN5zbcSj0MSZ4IAbBs7DlYSXIsFfheb5MSWoaWEN18tW6AbDmzsj6D
	 ckB6EexuKmi/niUxkm2w8zJCKQDGCXxBeeomVXq+TFL5rtJC1QBZYvQ59kYjUeQM0w
	 1TpO7+KvZfUkQ==
Message-ID: <sashiko-outbox-202564@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 3/3] perf: Add Raspberry Pi 5 (BCM2712) AXI PMU
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107040913.1384033-4-irogers@google.com>
References: <20261107040913.1384033-1-irogers@google.com>
 <20261107040913.1384033-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 04:16:30 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107040913.1384=
033-1-irogers@google.com?part=3D3

