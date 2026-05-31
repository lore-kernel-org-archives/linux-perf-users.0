Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF570274B2A
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 11:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780227180; cv=none; b=ZF3TxJOqtouFepUDovRc91PGkjQJYEXdxXwDEaqg0rB3Ui6xYPkyj6Pf/GIEd/lEue9E0cFzDw98syJY3fW2dQu12TULoyTYPjW/CiIyauL4HodEg9KvWYp/Io3w5ZHfh7l7Euxb5peZDpRetA0gA4N2TKuauEZK1Ca1lBxne5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780227180; c=relaxed/simple;
	bh=hqSLUxUYu8GkmUYMecnJz1rdNoQLtM+KNsshNj6oXmw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OHdqmXTrAHzdwQU25lJGtAuYy/jV/ZCal6XSfkpHML4zn7bS0n/U15WSKU/iarW3+FlUIf+lmX/IKaCoHbZctuKxjkAjhTDZOHrcFxj1T9IJTyzTadxsdELP9V6J/dF345H0nalIjhseSlJc/SuLch/HIr2q66lul08FwWQfQR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3hqrUaD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3hqrUaD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0F71F00893;
	Sun, 31 May 2026 11:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780227179;
	bh=5ODlMmNcvXtU4y8qcawCpdcLjrAgTIBPyOtBbd6uVF4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V3hqrUaDFTCHNfqYKBEnX8ahFTGe+929wDqQCKdktmMtXpGip1Bj1FefUIKxOLcc3
	 50llqdCC1M+3/Yyu9eNEJkeuaThxtFWZlQodOtQUKWBJ/BQ0cLSH5Qs6Su92YIRkWX
	 y6gIeqvQ8t8KIddJCsaTqqDte9A1a8NL0Oo248Po5RVGRiHgARzHQIHuTeEfoYVYFK
	 lBT2bXqZw0G8MypGOLLJ667Do6jN3gK5R/eugr3t/PpO6owYpfK/J/KslILpmyOSIK
	 5wGR9+ygL9GszIM4anGbazJwBZo/HEVE5J0OpirLQYlMn9v5Cvh63gUIVB2066p+/H
	 fvrq0FgOlJ3hQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] perf/arm-cmn: Add workarounds for CMN-S3 on
 Graviton5
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aviv Bakal" <avivb@amazon.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260531110447.10095-3-avivb@amazon.com>
References: <20260531110447.10095-3-avivb@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 11:32:58 +0000
Message-Id: <20260531113259.5B0F71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Setting the DTC node's logical ID to the parent XP's logical ID ca=
uses DTC nodes to be sorted out of domain order, breaking PMU event routing.
- [High] The hardcoded bit-shifts in arm_cmn_graviton5_dtc_domain() can pro=
duce DTC domains >=3D 4, leading to out-of-bounds writes in arm_cmn_event_i=
nit().

Pre-existing issues:
- [High] Memory allocated for `hw->dtm_idx` and `hw->wp_idx` is leaked if `=
arm_cmn_event_init` fails.
--

commit c34c59523c8b94745143d1d1114415bb33c12d3e
Author: Aviv Bakal <avivb@amazon.com>

perf/arm-cmn: Add workarounds for CMN-S3 on Graviton5

Graviton5 uses a customised CMN-S3 implementation where certain discovery
registers report zeroed fields. This patch adds workarounds to identify the
variant, derive the DTC domain from the XP node ID, and set the DTC logical
ID from the XP's logical ID.

> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index f1978a53d1c19..3fb71d9a57eb5 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
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
Can the hardcoded bit-shifts extract overlapping bits if the mesh dimensions
are smaller than 10x14?

If the system describes a smaller mesh (e.g., 8x8), arm_cmn_xyidbits
evaluates to 3. This would cause the hardcoded shifts (xp_id >> 7) and
(xp_id >> 3) to extract overlapping bits that inflate y (e.g., y =3D 15),
yielding a domain of 5.

If a 14x10 mesh is used, the x coordinate can natively reach 13, yielding
a domain index of 4 ((13 / 5) + (9 / 7) * 2).

When an unvalidated domain index >=3D 4 is assigned to dn->dtc, does it
cause an out-of-bounds write in arm_cmn_event_init()?

drivers/perf/arm-cmn.c:arm_cmn_event_init() {
    ...
    hw->dtc_idx[dn->dtc] =3D 0;
    ...
}

Since hw->dtc_idx is a fixed 4-byte array (s8 dtc_idx[CMN_MAX_DTCS]), an
index >=3D 4 would write past its bounds and corrupt adjacent fields like
hw->num_dns.

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
Does overriding the DTC logical ID with the parent XP's logical ID cause
DTC nodes to be sorted out of domain order?

In arm_cmn_init_dtcs(), CMN_TYPE_DTC nodes are sorted by their logical ID
(dn->logid), which determines their index in the dynamically allocated
cmn->dtc array. Standard CMN parts have their logid read from hardware as
the exact domain index (0-3).

Because the domain index here is a 2D block distribution, the physical XP I=
Ds
do not monotonically increase with the domain index. For example, an XP at
x=3D7, y=3D0 belongs to domain 1 but has a smaller logid than an XP at
x=3D2, y=3D3 which belongs to domain 0.

If cmn->dtc[0] points to the hardware base of domain 1 instead of domain 0,
will events programmed for domain 0 be routed to domain 1's hardware, break=
ing
PMU event counting?

Would it be better to explicitly set this as:

    dn->logid =3D arm_cmn_graviton5_dtc_domain(xp->id);


[Severity: High]
This is a pre-existing issue, but does arm_cmn_event_init() leak memory
if initialization fails?

drivers/perf/arm-cmn.c:arm_cmn_event_init() {
    ...
    if (arm_cmn_is_watchpoint(event))
        if (eventid !=3D CMN_WP_UP && eventid !=3D CMN_WP_DOWN)
            return -EINVAL;
    ...
    return arm_cmn_validate_group(cmn, event);
}

The driver dynamically allocates memory using arm_cmn_alloc_dtm_idx() and
arm_cmn_alloc_wp_idx(). If the initialization subsequently encounters an
error, such as an invalid eventid for a watchpoint or a failure in
arm_cmn_validate_group(), it returns an error code without freeing the
allocated memory.

The core perf code perf_try_init_event() does not call the driver's
event->destroy() callback if pmu->event_init() fails, expecting the driver
to clean up its own resources. Could this allow memory leaks if invalid eve=
nts
are repeatedly created?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531110447.1009=
5-1-avivb@amazon.com?part=3D2
