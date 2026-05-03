Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676E928725F
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777825240; cv=none; b=OCeuAhFvFe1zcswykVOcpPXY+L7crt3sPYOU/JZtf6PvcfQJPw1DXM/fOaXO5U0W/jrNkYbM3rSZMHAQ/YBVQTlObTP0TyQHUrzV1SwzgSF4PKF1cH39yujWhGhsbueMr0GkLnDIkmMuv+SauHJrCI7f0k1K5Foe4S+H+33kSts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777825240; c=relaxed/simple;
	bh=N1++fl+5ofrTB3M1SuzqwIYRB+VT1GvZqDBQDig8BCo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ei59SkwjcODFO9GiW0tD/h6jJ44Tcn8M3SIB2maCZQbDXBWT1RUC/12+skYoIwtU1oVZ3VD521iRd+V0+nbgfepteojQ/Z0Qe5MbsBg4pRNIigDKq1BbuuxCki0TKt2GlHtQ6v3SVmvGWBCldrt25EJHnWNQa0Yi14EUbIuP2jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5Yssrav; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5Yssrav"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E185EC2BCB4;
	Sun,  3 May 2026 16:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777825240;
	bh=N1++fl+5ofrTB3M1SuzqwIYRB+VT1GvZqDBQDig8BCo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Z5YssravhbIADzHKfIxnc/QrlZXAh2cxAo/wbZa5FzZxtoVPhIN0i0yU/9aVXJohp
	 /aRLdOf2J2x8MkjGysq8C8Fh2D3UeQsCZsjVv8GrWRYDYK6L0ORYX3XShWHMzzgfPB
	 X4au7Cv14eqD073HzSPp8HBwtHpVGbxlAp13yPVBXKrUEorpT7JOCH9yv+tNu0tnM2
	 cRH42lPuYuo1Lif7e/ijq0ClH0irq6W2chjDP+U5UtFNiQYWoxaWa9BFH6+N3LRDrF
	 JxbBPaihNdJdyjUiWFmAiEJga8R1HUm1dYQgC51RO1b+OJ4TWUtjpm/FEcGal+43Dn
	 XxePSH9T4Y5AA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/arm-cmn: Add workarounds for CMN-S3 on Graviton5
Reply-To: sashiko@lists.linux.dev
To: "Aviv Bakal" <avivb@amazon.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260503155118.16191-1-avivb@amazon.com>
References: <20260503155118.16191-1-avivb@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 16:20:39 +0000
Message-Id: <20260503162039.E185EC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incorrect DTC logical ID assignment cross-wires DTC domains.
--

commit 621fea5b4bb35e497f17f2f20187c68b18f49751
Author: Aviv Bakal <avivb@amazon.com>

perf/arm-cmn: Add workarounds for CMN-S3 on Graviton5

This commit introduces workarounds for a customised CMN-S3 implementation on
Graviton5, where certain discovery registers report zeroed fields. It adds a
dedicated ACPI HID, derives the DTC domain from the XP node ID, and sets the
DTC logical ID from the XP's logical ID.

> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index f5305c8fdca4..368fe1a86bfb 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c

[ ... ]

> @@ -2443,6 +2468,10 @@ static int arm_cmn_discover(struct arm_cmn *cmn, u=
nsigned int rgn_offset)
> =20
>  			switch (dn->type) {
>  			case CMN_TYPE_DTC:
> +				if (graviton5_workaround) {
> +					/* Node info logical ID is zeroed; use the XP's */
> +					dn->logid =3D xp->logid;

Will this cross-wire the DTC domains?

In arm_cmn_init_dtcs(), the cmn->dns array is sorted by logid, and the
cmn->dtc array is populated sequentially based on this sorted order.

During PMU event programming, the driver uses the domain ID (dn->dtc) as an
index into the cmn->dtc array.

If the physical layout of the DTC XPs causes their xp->logid values (typica=
lly
y * mesh_x + x) to sort differently than their computed domain IDs, wouldn't
the cmn->dtc array be misaligned?

For example, a Domain 1 DTC at (5,0) has a smaller logid (5) than a Domain 0
DTC at (0,6) (60), meaning Domain 1 would incorrectly occupy cmn->dtc[0]. T=
his
cross-wiring could cause PMU events to program the wrong physical DTC hardw=
are
and map IRQs to the wrong domains, resulting in incorrect performance
statistics and unhandled interrupts.

Would it be better to assign the computed domain ID to the logical ID here
using dn->logid =3D xp->dtc?

> +				}
>  				cmn->num_dtcs++;
>  				dn++;
>  				break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503155118.1619=
1-1-avivb@amazon.com?part=3D1
