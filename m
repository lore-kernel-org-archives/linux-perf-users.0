Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3DE3D75B4
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780502019; cv=none; b=ANInNkeZBoD2G9/nWZBdWpeJH2EyCiT5u31BVsJ3IxH6fpNVvOdLRAFiNMQh9rOD1Aj+Ok3Q4WI70ewlOVPmsWrucvwEyAII+wRBDQS+5c08lhDBOD3bmYhztNs9ZAmFl1AA/6Gt64hAmWWdY0o1jGzW6GgQ7hA6aGJfEUmU0cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780502019; c=relaxed/simple;
	bh=aqM/ZK1m7bst4Gaeu3ZCgMlwUZBT1/ddqO119vvNsa8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SvT2Lm8d9GYWcbY9+c4UmF76q5Rq8Hfgnp9RA2STuwzJ/qRWVQ2X1HtLUxgFknAK6OpgfG0ZhlGVkHG/GnFhCa98nJ4WwVa77N7Zpc4g+7Ijbh7P0UXhnhO3ts3bR6CboiUpqfl6V504SNSV6lOFlx0KOBumQgqfcC/q10fFvls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjAvoxg2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjAvoxg2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235291F00898;
	Wed,  3 Jun 2026 15:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780502018;
	bh=KrS6H8i7CjNoIIiKOXn+MXVFgIC9N0CKmTlkwUocQxA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SjAvoxg2akaK7tnRCVCUS/FCTgdZa6+/cAeNVUxJ+7o1+60/zAyJjZonmgx8+4t6Z
	 OSgZz6VgHFRrvEICiBWDZQzKoElTL9SXjZs3nM1zAuIlXYzhlYu+xbAVCGhB3vk0T1
	 KndDOfKN/h/9x2Mkv4+VN8f2veysoPl80YhBXz/ILTU57eCrO2UDmaMeQ9tLDjMohW
	 VouXDYZ2HEbYzkCahvt07G1QnKtiBF0NYH3P/kkAIyuWpMY1YsuAXWJnLdT8OKubnu
	 rZ9Bd6f59eZ5LUh5jvc3UNKaW7ynJNxHFtUs7DVo9QA0NcKFMg/Q5pYPwa9taHGHTp
	 TCipcJrsMz3tw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] perf/arm-cmn: Add workarounds for CMN-S3 on
 Graviton5
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aviv Bakal" <avivb@amazon.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260603150025.30980-3-avivb@amazon.com>
References: <20260603150025.30980-3-avivb@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 15:53:35 +0000
Message-Id: <20260603155337.235291F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The `arm_cmn_graviton5_dtc_domain` function computes a DTC domain =
index without upper bounds, which can exceed the `CMN_MAX_DTCS` limit and c=
ause memory corruption.
- [High] The Graviton5 workaround assigns the XP's logical ID to the DTC no=
de's logical ID, breaking the domain-based sorting order and causing DTC re=
sources to be assigned incorrectly.

Pre-existing issues:
- [High] Lack of bounds checking on `cmn->num_dtcs` allows a `memset()` cal=
l to overflow the `dtc_idx` array.
--

commit fd0610a07c973430036fe29d5eab5bfbb5c0eb4c
Author: Aviv Bakal <avivb@amazon.com>

perf/arm-cmn: Add workarounds for CMN-S3 on Graviton5

Graviton5 uses a customised CMN-S3 implementation where certain
discovery registers report zeroed fields. This patch introduces a
dedicated ACPI HID, derives the DTC domain from the XP node ID, and
sets the DTC logical ID from the XP's logical ID.

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index f1978a53d1c19..3fb71d9a57eb5 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c

[ ... ]

> @@ -2250,6 +2253,18 @@ static unsigned int arm_cmn_dtc_domain(struct arm_=
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

[Severity: High]
Can this calculation exceed the CMN_MAX_DTCS limit?

If a compromised or malformed firmware reports an XP node ID with
coordinate components up to 15 (e.g., x=3D15, y=3D15), this calculation
yields a domain index of 7.

The domain index is later inherited by the DTC node (dn->dtc) and used
directly as an array index in arm_cmn_event_init():

    hw->dtc_idx[dn->dtc] =3D 0;

Since the hw->dtc_idx array has a fixed size of CMN_MAX_DTCS (4), an
index of 4 or higher would overwrite adjacent struct fields like num_dns,
leading to memory corruption.

[ ... ]

> @@ -2472,6 +2497,10 @@ static int arm_cmn_discover(struct arm_cmn *cmn, u=
nsigned int rgn_offset)
> =20
>  			switch (dn->type) {
>  			case CMN_TYPE_DTC:
> +				if (graviton5_workaround) {
> +					/* Node info logical ID is zeroed; use the XP's */
> +					dn->logid =3D xp->logid;
> +				}

[Severity: High]
Does setting dn->logid to xp->logid break the domain-based sorting
order for DTC resources?

The CMN driver sequentially populates the cmn->dtc array based on the
sorted order of DTC nodes:

drivers/perf/arm-cmn.c:arm_cmn_init_dtcs() {
    ...
    int err =3D arm_cmn_init_dtc(cmn, dn, dtc_idx++);
    ...
}

Standard hardware sets a DTC node's logid to its domain ID (0..3),
ensuring the array is populated in domain order. However, XP logical
IDs do not monotonically increase with domain IDs (e.g., an XP in Domain 1
at X=3D5, Y=3D0 has a lower logid than an XP in Domain 0 at X=3D0, Y=3D1).

Will this cause the DTC nodes to sort out of order, misaligning the
cmn->dtc array and causing PMU events to be programmed into the wrong
hardware domain counters? Would it be safer to use dn->logid =3D xp->dtc?

>  				cmn->num_dtcs++;

[Severity: High]
This is a pre-existing issue, but does cmn->num_dtcs lack bounds checking?

During hardware discovery, the driver increments cmn->num_dtcs for every
CMN_TYPE_DTC node reported by the firmware, without capping it at
CMN_MAX_DTCS (4).

Later in arm_cmn_event_init(), the driver uses this unbounded value:

    memset(hw->dtc_idx, 0, cmn->num_dtcs);

Since hw->dtc_idx is a 4-byte array, if the firmware provides more than
4 DTC nodes, will the memset overflow the array and corrupt the
arm_cmn_hw_event struct?

>  				dn++;
>  				break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603150025.3098=
0-1-avivb@amazon.com?part=3D2
