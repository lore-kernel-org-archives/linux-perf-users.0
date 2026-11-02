Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793654535;
	b=HchGx2GcXoWNhEWET3fFVSM8kLnySCcTYEF1qp4Jrn5UIleeprJrd+YLxN6YBToKm/vP
	 4XjYJU8FDAxu3hQlLYZ+4HTB7VM8hcvPuCBWrDXY6TUrnfhBNQTaUBJB4XxAkB0FpmWsG
	 J6xDoCtsvYBQazmVEmweri28GXOZtcoiadxveo/VQtseQUV9SnxeoAvFhwH8/WlB9ueRb
	 ZM601mjBBPZdrVZkIDefIwDvV5MuJ+82ho9WXK9K59kKzxZBD4OLU4RPGBn01Ne3nv5YJ
	 QXI+/HxUtjJ4EQi1h4TW8/adn86/6B9rU33/epvWoQfRyKqiQLsZIE1+zonr3XTZ6kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793654535;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bJHRXh2RtxnFiB8irCpfoG3TotdBuywUjxkTgtgxy2Y=;
	b=cvGmmY/hYr4WTQOdQ99E96bHfRFziv4cKr9rRtEpFBLjMmVtoICDm3m4+Mx44yFZjB4e
	 ddKubkt76g+B+fef/cE4ZYfxRsOxNdX/yG19Rqm/YaY54rfO7q/wNZ4QQlqyIqyOxOvYj
	 Q2mFvwzcQSIhglxotV444ccsi+dQ0SgU2X1aDh5awpEDu92NU5c6ygPOK6PAHTFO2DMUT
	 8KJ1jKtOsiWg5mUH7MlzEoQhu5p//HJsDDWgL+Tj5a56H/i16alKJTtA0JUI+JiAPtwgn
	 bBsvdRclfdzdV3zLsD++N9bes7VAtiEUuxrKJaZ/R/C5BYwOLOEm/qgvyCWU8XeALOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=asxYvhxo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9E2606A324
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 21:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=asxYvhxo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE7F1F00A16;
	Mon,  2 Nov 2026 21:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793654534;
	bh=bJHRXh2RtxnFiB8irCpfoG3TotdBuywUjxkTgtgxy2Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=asxYvhxoeOnX8y3NkulwlzS9f3STvMg5hKC5FM+3RMdS/U26CG15F9jKdtWpgB1l8
	 v+mgjldtmddxpnZ/DFmikBDbJ7+U/a1drvCDXTf8eLkK6MGc1ctBiLHADOe5e3DZZF
	 9tvEK+HFGjcNd+bJuweJT0D3RqqR0YvQYkBtdpwL8f/sdnuIBSmtO5ixtgzIJubjh3
	 uCchGKP/lwCzWFfVyLXUt/JjCCfMwF3Vjx14MewIr1KPcw4GtxOyclqfWpWZCCCiE8
	 jSLd56d11YJTq8TeQoxgAOu/JkaoLvdXp4Dsw9JjcmuhA9fkAq95Da5dSn0+qDMo1u
	 BTg562PQnaAHw==
Message-ID: <sashiko-outbox-194191@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] perf jevents: add iommu page table walk metrics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jacob Lefkowitz" <jlefkowi@akamai.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102-perf-tools-next-v2-1-4d237f886710@akamai.com>
References: <20261102-perf-tools-next-v2-0-4d237f886710@akamai.com>
 <20261102-perf-tools-next-v2-1-4d237f886710@akamai.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 21:22:14 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Jacob Lefkowitz <jlefkowi@akamai.com>
>=20
> Adds page table walk metrics specfically to perf jevents for AMD
> platforms to enhance observability into IOMMU overhead. The metrics
> are supported on Zen 2 and neweer processors. They are implemented
> using the amd_iommu PMU events.
>=20
> The list of metrics added here are:
> - lpm_iommu_ptw_reads_per_tlb_miss
> - lpm_iommu_ptw_nested_read_ratio
> - lpm_iommu_ptw_guest_read_ratio
> - lpm_iommu_trans_per_sec
>=20
> The changes here have been tested with 'sleep 10' as the workload:
>=20
> perf stat -M iommuptw --per-socket --metric-only -j -a -- sleep 10
> {"socket" : "S0", "counters" : 8,
> "reads/tlb_miss lpm_iommu_ptw_reads_per_tlb_miss" : "0.5",
> "%  lpm_iommu_ptw_nested_read_ratio" : "none",
> "%  lpm_iommu_ptw_guest_read_ratio" : "0.0",
> "trans/s  lpm_iommu_trans_per_sec" : "971.5"}
> {"socket" : "S1", "counters" : 0,
> "reads/tlb_miss  lpm_iommu_ptw_reads_per_tlb_miss" : "none",
> "%  lpm_iommu_ptw_nested_read_ratio" : "none",
> "%  lpm_iommu_ptw_guest_read_ratio" : "none,
> "trans/s  lpm_iommu_trans_per_sec" : "none"}
>=20
> Signed-off-by: Jacob Lefkowitz <jlefkowi@akamai.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-perf-tools=
-next-v2-0-4d237f886710@akamai.com?part=3D1

