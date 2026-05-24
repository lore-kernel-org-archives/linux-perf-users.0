Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5AA3A8730
	for <linux-perf-users@vger.kernel.org>; Sun, 24 May 2026 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779640826; cv=none; b=G/IBaiAbXDSEuN4xVMvKLhgurB3h7IPNJAaQw2ug1XwdYmOyt4hNkoDtz/biqbyG9oAYmVTbVlXYa7JRJjWijbJURZ57iN78DiHdWM51iR/iFcMxVhpeTldlL9uGKLwD29B3nFD8q1WJJ1iKoyyTlCFKsykoPJeo5YRhcqAEBwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779640826; c=relaxed/simple;
	bh=8t73peUDNRFXYF1ijwXoiyIfIt3TeY+T3RW5VXayKRA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OeyMHuv4eznIvmT+yu/df9wlrO0+rF+2xKzXw7L8iIFXkePJqt9cKGKfGvkIPZ/nIm8Oi/DNAlF3U8CYvT4b1BKUVB4gDih0ZRaBLWbt//cwQMOFdMReOMqHt/EjIHfTTAKcTZ9kX0y+6e28x4KS4BsXMRa9f9R2aT5akduPLT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZP4/DGQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZP4/DGQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82541F000E9;
	Sun, 24 May 2026 16:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779640821;
	bh=kYTAn8+NSTnhVk1BTcV4gkS6mUhEBkO2PfOJadiwVro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nZP4/DGQ7eWmWlhnaKJH66YQ6eSXB2enJXLl8PZULuGHbBUNdkZ6/gNF0MiI8mt6n
	 6bJ+OjK4qWxeFdSGKQKdfLyxdgpEp/kUb9q8Byfa9LjGvVHImMSDtFtX+YL39gCVaN
	 WBvn9tkyiTsCizwLF4bKUvt8AVuSdcptU86kRLzfgDOptNMmPPq/e6CZsmONtFnkDk
	 ahw+L/MxQ45hV2BOycDzJkF6jsmF5xb03dxvmNTSIbQwqTR9xR10k0M6k//41Vi3Rt
	 DPwcLkhmwc62eLNr64nZ62Rclhbo1h4002/q8MhICxLgOKnsOu2kTE1y/F0KSMUJbB
	 ke3fFU8kShAdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] perf/arm-cmn: Add workarounds for CMN-S3 on
 Graviton5
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aviv Bakal" <avivb@amazon.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260524153848.16334-3-avivb@amazon.com>
References: <20260524153848.16334-3-avivb@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 May 2026 16:40:21 +0000
Message-Id: <20260524164021.B82541F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Setting the DTC node's logical ID to the parent XP's logical ID br=
eaks the DTC array indexing, leading to incorrect PMU event programming and=
 IRQ routing.
--

commit 20d5a81cc2d5eb87a70576532c9a783cb6e011c3
Author: Aviv Bakal <avivb@amazon.com>

perf/arm-cmn: Add workarounds for CMN-S3 on Graviton5

This commit introduces workarounds for a custom CMN-S3 implementation on
Graviton5 where certain discovery registers report zeroed fields. It adds
a dedicated ACPI HID and derives the DTC domain and logical ID from the
XP node.

> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c

[ ... ]

> @@ -2419,6 +2443,10 @@ static int arm_cmn_discover(struct arm_cmn *cmn, u=
nsigned int rgn_offset)
> =20
>  			switch (dn->type) {
>  			case CMN_TYPE_DTC:
> +				if (graviton5_workaround) {
> +					/* Node info logical ID is zeroed; use the XP's */
> +					dn->logid =3D xp->logid;

[Severity: High]
Will setting the DTC's logical ID to the parent XP's logical ID break the
DTC array indexing?

For standard CMN hardware, a DTC's logid is its Domain ID. Nodes are sorted
by type and logid, which means DTCs naturally sort by Domain ID.

By using the XP's logid instead, the DTCs will be sorted by their physical
XP order rather than their Domain ID. The cmn->dtc array and ACPI IRQs are
populated sequentially based on this sorted order.

Later, when programming PMU events, the driver indexes into the cmn->dtc
array using the Domain ID:

    d =3D max_t(int, dn->dtc, 0);

If the physical XP sort order doesn't match the Domain ID order, will this
cause PMU events to be programmed into the wrong hardware blocks and
misroute IRQs?=20

Could this be assigned the Domain ID directly using dn->logid =3D xp->dtc?

> +				}
>  				cmn->num_dtcs++;
>  				dn++;
>  				break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260524153848.1633=
4-1-avivb@amazon.com?part=3D2
