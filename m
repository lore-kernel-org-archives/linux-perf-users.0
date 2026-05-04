Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC603A1CF3
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 19:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777923531; cv=none; b=Cpzwr5Z0tTHo7ygcERRvCYw3Td9rA6YOoNgIOuo3IETWPDKDFgv1omk9h9KlXNdOYnv/0/EzA7a83XCduvHZ+w4HKQa9HHKNIUy5x6m+ctXM4VGrJopgV5SLe9mHIrxcIRB8PKi2PSlUhLJ7gm+GHgzb9W0AmgyplHy+5udf5w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777923531; c=relaxed/simple;
	bh=U/AErjhTlm9x8mZQKPv9Umf9iy49wiwMuoEfcXlGXus=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j5/XLQhUFPOiLGd9KJhwANwMiB7iSPoxK0sowKHuhNk7dmOXT36ns8ja3pJitgrNADcH7OER/rgQO0Wf5NxE9EVjNChakVPtxGgJvIbgqDN3RcvbQZMgMcOp1rgrH5TwDiFhksMhEmh0DslHUXoe78hvOUp6prvl0f5w8aYs8Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sazB/T2X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sazB/T2X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994ADC2BCB8;
	Mon,  4 May 2026 19:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777923531;
	bh=U/AErjhTlm9x8mZQKPv9Umf9iy49wiwMuoEfcXlGXus=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=sazB/T2XEihTMmarpbS4S38FkZJt0jJNYDTMXDqYFcDPL8fFL6TVVDnS09Aq/ocje
	 KN54EtWLBhEPQAjTcvu2i82Iet6RoEtca6LTNq8Tf5a60rET5ohfZ+Uj8o4MDRmVQA
	 AGITNF4zRFQFs+uuyl6/1yQgGD2fQOobtV1Km9O1VBGIpKIng9Qx4INcXFYhImKllc
	 mNHiNln7zQzg2aNiMR+Z9FvuUHWHNpgJEz7x5lqOmXtIUwsZDsqaMCMiuUGJax6cxf
	 4nFDuHUisOYPFibbt5mCYHzeEYlfHFdgajRTPfcQ5PsMkAkAJ+Ly20j6MGiFHNWOE9
	 F7wkLadsb2DnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf/arm-cmn: Add workarounds for CMN-S3 on
 Graviton5
Reply-To: sashiko@lists.linux.dev
To: "Aviv Bakal" <avivb@amazon.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260504133923.23373-1-avivb@amazon.com>
References: <20260504133923.23373-1-avivb@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 19:38:49 +0000
Message-Id: <20260504193850.994ADC2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Buffer overflow in `arm_cmn_event_init` due to `CMN_MAX_DTCS` not =
scaling with mesh dimension.
--

commit 9d571ad62b9e626c4f8ff883ad8a2627c1e26529
Author: Aviv Bakal <avivb@amazon.com>

    perf/arm-cmn: Add workarounds for CMN-S3 on Graviton5

    Graviton5 uses a customised CMN-S3 implementation where certain
    discovery registers report zeroed fields. Add the following workarounds:
   =20
     - Introduce a dedicated ACPI HID to identify the Graviton5 CMN variant.
     - Derive the DTC domain from the XP node ID, since the unit info
       register reports it as zero.
     - Set the DTC logical ID from the computed domain ID, since the node
       info register's logical ID field is also zeroed.

> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index f5305c8fdca43..8ee3f86386025 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -31,7 +31,8 @@
>  #define CMN_CHILD_NODE_ADDR		GENMASK(29, 0)
>  #define CMN_CHILD_NODE_EXTERNAL		BIT(31)
> =20
> -#define CMN_MAX_DIMENSION		12
> +/* Some implementations use a mesh larger than the architectural max of =
12 */
> +#define CMN_MAX_DIMENSION		14
>  #define CMN_MAX_XPS			(CMN_MAX_DIMENSION * CMN_MAX_DIMENSION)
>  #define CMN_MAX_DTMS			(CMN_MAX_XPS + (CMN_MAX_DIMENSION - 1) * 4)
> =20

[ ... ]

> @@ -2221,6 +2224,18 @@ static unsigned int arm_cmn_dtc_domain(struct arm_=
cmn *cmn, void __iomem *xp_reg
>  	return FIELD_GET(CMN_DTM_UNIT_INFO_DTC_DOMAIN, readl_relaxed(xp_region =
+ offset));
>  }
> =20
> +static unsigned int arm_cmn_graviton5_dtc_domain(u16 xp_id)
> +{
> +	unsigned int x =3D (xp_id >> 7) & 0xf;
> +	unsigned int y =3D (xp_id >> 3) & 0xf;
> +
> +	/*
> +	 * The unit info register reads as zero; derive the DTC domain from
> +	 * the XP's mesh coordinates over the 10x14 mesh.
> +	 */
> +	return (x / 5) + (y / 7) * 2;
> +}
> +

Does this new dimension limit require an update to CMN_MAX_DTCS?

CMN_MAX_DTCS is currently 4, which sizes the dtc_idx array in struct arm_cm=
n_hw_event:

struct arm_cmn_hw_event {
	struct arm_cmn_node *dn;
	u64 dtm_idx[DIV_ROUND_UP(CMN_MAX_NODES_PER_EVENT * 2, 64)];
	s8 dtc_idx[CMN_MAX_DTCS];
	...
};

For a 14x10 mesh where X=3D13 and Y=3D9, arm_cmn_graviton5_dtc_domain() wil=
l return 4.

Will this cause an out-of-bounds write in arm_cmn_event_init()?

	memset(hw->dtc_idx, -1, sizeof(hw->dtc_idx));
	for (dn =3D hw->dn; dn->type =3D=3D type; dn++) {
		...
		if (dn->dtc < 0)
			memset(hw->dtc_idx, 0, cmn->num_dtcs);
		else
			hw->dtc_idx[dn->dtc] =3D 0;
		...
	}

If the larger mesh size exposes more than 4 DTC nodes, could cmn->num_dtcs =
also
exceed 4, causing the memset() to overflow the dtc_idx[] array?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504133923.2337=
3-1-avivb@amazon.com?part=3D1
