Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC533382FA
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 17:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776100327; cv=none; b=ujpppQnl/p3o/phA3mhzye6AMnh4Xj9WgBEbt1HH7pDNvL4AzovrlccLhcNcn9qOtfVXmj4TYqNBPc6x77XE4SGg838hXczZ2IquxpHH1sV5depoqS9mlEc34kRFgPaaqVfiEq9wTAwcGGjSJbTSxoJRTkgtF+9zO+SB2X5m/Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776100327; c=relaxed/simple;
	bh=I/E3UZI0gxgVnMN2U44baV9IpDCgO6fkXU3pFV+SuGs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TaF3aFMc0ZVofeHdKKM+IZoW1FfxV8Q82ssfXH3AvAmg2ZOB62j+cOQO6ptgPZKnZ1tkVPKqk37CJmh+cJ2hRpBG+btabKT19in7RZ7gAYDmocW8Db6kHRYByo8omcbs2xDs/QRH5Kw5vvrqgKsQnWB5i/hi/QrcHk+NyX/Flos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vmk5T5bP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vmk5T5bP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F380AC2BCAF;
	Mon, 13 Apr 2026 17:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776100327;
	bh=I/E3UZI0gxgVnMN2U44baV9IpDCgO6fkXU3pFV+SuGs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Vmk5T5bPgMSo9kN4tIzshG5Vmi3ruMz6JHS4EMfersZCeBCxwO/VXzg8G4tx64+Nf
	 xf89CgpGFaLDCNNPDazsCHYvv7nFTNtzatNF/5GpTggQiaOhlRa4a/qgiZdJB6aWen
	 47T+7gikMHsDfbCpcd8s51+DSiu13C19ZGVxINU87IvkBUWsmr9cA76RCPBIPfmSBk
	 rlxQxfgRVeUgyWq6NmjttQ4VLOA3/Ck5yEJufpRtchbo/eDOeqt4ncKAse4rihfTen
	 kva6366o4lp+GzVDNr1HuFaGo+wneRLpqsr6rdrlZPSQ9S0CjRxKma7KOgq9P4f+bM
	 eF3U2boEV4QtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: perf: marvell: Add CN20K DDR PMU
 binding
Reply-To: sashiko@lists.linux.dev
To: "Geetha sowjanya" <gakula@marvell.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260413165621.10921-2-gakula@marvell.com>
References: <20260413165621.10921-2-gakula@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 17:12:06 +0000
Message-Id: <20260413171206.F380AC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Low] DT binding example unit address and generic node name mismatch.
- [Low] Unnecessary duplication of binding files instead of updating the ex=
isting schema.
--

commit e2d439a05897c67e7bc90170f7cf6e218505769a
Author: Geetha sowjanya <gakula@marvell.com>

dt-bindings: perf: marvell: Add CN20K DDR PMU binding

This commit adds a new device tree binding for the DDR Performance Monitori=
ng
Unit found in Marvell CN20K SoCs. The hardware provides counters to monitor
DDR traffic and is accessed via a dedicated MMIO region.

> diff --git a/Documentation/devicetree/bindings/perf/marvell,cn20k-ddr-pmu=
.yaml b/Documentation/devicetree/bindings/perf/marvell,cn20k-ddr-pmu.yaml
> new file mode 100644
> index 0000000000000..cc6aa760de49e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/marvell,cn20k-ddr-pmu.yaml

The commit message notes that the CN20K DDR PMU is functionally equivalent
to the CN10K DDR PMU. Does it make sense to consolidate this by adding the =
new
compatible string to the existing marvell-cn10k-ddr.yaml schema instead of
introducing a new duplicate file?

Splitting schemas is typically recommended only when conditionals become
too unwieldy.

[ ... ]

> +examples:
> +  - |
> +    bus {
> +        #address-cells =3D <2>;
> +        #size-cells =3D <2>;
> +
> +        ddr-pmu@c200000000 {
> +            compatible =3D "marvell,cn20k-ddr-pmu";
> +            reg =3D <0xc200 0x00000000 0x0 0x100000>;
> +        };
> +    };

Is there a unit address mismatch here? The 64-bit base address formed by the
reg property is 0xc20000000000, but the node name uses @c200000000, missing=
 two
trailing zeros. This can trigger a unit_address_vs_reg regression during
dt_binding_check.

Also, does this example need to use a generic class-based node name like pmu
instead of ddr-pmu to match devicetree recommendations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413165621.1092=
1-1-gakula@marvell.com?part=3D1
