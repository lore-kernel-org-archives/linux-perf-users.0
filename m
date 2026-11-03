Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793679524;
	b=2y8semXB9KTh24NxwLCX+zFuCFCkjh74J96pXVxSoqGV8KPFL8K8LHAOnPYtLpy8bUPo
	 xkRzmLHXF5VvgB3Gv5JCt0QGHIu+j2NerPPH8r7wIxF2cInNRm8rE6PJKmP8YQ/d7G6+9
	 YYh60UmaefkERzNXlkvWHOCeYks1rU0Uf6w2r85Dq5g+KKYX3SgMVb4HEr+Fs21EDAzbt
	 x2lRM1e71BPPVPRoVSNG6ndMjTCWuPkOJxqswDAjE7W6JojM/Twj5UgqtyR+ZjGheFX5C
	 zchifSC0vIJA3a8021HGEonBSK59U4grTV5JAHX8WWV6he/ow0La7f0vJdV+DTheRJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793679524;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mIRuWlLlPaAqzyvbkCAqbFq/wa6ER+SH/5DFkCSw1CA=;
	b=AfmGYeYZznMGaOLpSnrMMsYixUWclMhGa3B4usdI6LoDsX1A9YCpFMChYGelM1UAbSm4
	 ypqaMyXOyXTyCxzmIzdvQUq4w9pTLy2gVbubtS6EFZiclFmIm3p9xVlRWcCZEcag0D6AB
	 Ov5afYf4CsAZ5PDo14hUMZAfnBC+vEtcDSex84ynWr7N4rDUIsnyqTzH0cG4iyngIoPqm
	 MlEHRgYWDUFK3/aLXyct6saqfnscHKJBwpahZN7laNn6Tpcru24ReyFnlyAHwUnhb/iuC
	 G9TLrMXe3WoJyB5WfMyMWIyRFKngVBKDSAErUWV25eAS80Fzz66bf5hhVXznWoXWyuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j8rOr2H7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB34606A335
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 04:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j8rOr2H7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255B71F00A1B;
	Tue,  3 Nov 2026 04:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793679523;
	bh=mIRuWlLlPaAqzyvbkCAqbFq/wa6ER+SH/5DFkCSw1CA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j8rOr2H7DHMfQWPxFv0Rbzsr0Dkb+AIL12VXl4rbe2E2idA9jPTr17aF51+UgKdAt
	 GLwcvnlzjt+t/5iNd0o+/XoURM8Pr3eVB9sKRNXDDMtrD1uvgaLmIAwCQ0Fm30NRlu
	 4cQt6nrGLapeHZMvSwjqwV7EJg6L+KybEtZ+Uvdxozb5EPHX6BQ9Au2soC1XHAmAnS
	 uN7QCYGOiQlywo/CnZsDHESxjSwDJ7lGQNrdBobpADT1g9UsvpOSxtlLEp5uamvEua
	 oY00NjkZiG01tY6pHuu0tF8NcvuvOUMP3tvlVbFRJbNLAIJgLzN4h0FBsXNb33FrjJ
	 yWqODfO6Zsulg==
Message-ID: <sashiko-outbox-194561@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 3/3] perf: Add Raspberry Pi 5 (BCM2712) AXI PMU
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261103041416.2940213-4-irogers@google.com>
References: <20261103041416.2940213-1-irogers@google.com>
 <20261103041416.2940213-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 04:18:42 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103041416.2940=
213-1-irogers@google.com?part=3D3

