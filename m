Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887873AA1A7
	for <linux-perf-users@vger.kernel.org>; Sun, 24 May 2026 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779639216; cv=none; b=pRASzhAmFhvJOGEjdIFjnSr1d6Jwozort6AJXeQrxLvx5Eal1fqLtGpjzmTD1WJM6hSwJImZTiG2tjHXmvSuwPK666OqdzvG/t7pNkOgK0fzU3O79CeRPunPcB8spqibXpW7O74FrQ6U2p4xHbWDKtg2i7RO7r4hoRJ9/GnPoMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779639216; c=relaxed/simple;
	bh=9bPnS+GFENYLOrlL7H9apS3jx8Iafb+D4gylwX7jkb8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gZ+aueijLJG1n32s09iiwdfeuVNyusbZw4U/2Ym3PCEwq89gfxMKixryId5FKBwohl8ThhlaFkc8KINwvUrDBK95twKKLa3GRLQ4uCqTPt0mdAsV+6kqRjBxZjUuwLtziDEyVGrW0lYaBJLcXHVnXo19q3JTu0XJ0LyBol9mxgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNA6u/ua; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNA6u/ua"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1805B1F000E9;
	Sun, 24 May 2026 16:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779639209;
	bh=g3qZHxEN6CyiBbhG6XUsO1pMQFuc47gfagHBUHwyn1w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eNA6u/uaSke9INesgl4cWbuYO5/F2vtMS/yK9FEWNbmouQKAleWKvOArhINdWTN0i
	 +pNs6MW/isNrfJKHg3bntPHwnoPUtz4beviMLnZ8DBviAu5GWNSqcJCmDOYHjPKq5A
	 7jtIiVbsNlD00Xk49n6JDHfMtdxLnbvG544Hwvs6BIhF5uOm+DxNAu/ZLq4QWDCRKi
	 41WKxXGMse00S6v3x7v3ECEHhBvYCdd8dA3eA13Ci16WfvPiidEPE0Zfehz8/fyQkc
	 Lnil62TQDFGc6OvRK99ltcppxUm+GY4NTEIVbRz5DJ1klgB2nmxbCY9M3kHhetjIF0
	 zl3VyndPfM35w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] perf/arm-cmn: Move struct arm_cmn_hw_event into
 struct hw_perf_event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aviv Bakal" <avivb@amazon.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260524153848.16334-2-avivb@amazon.com>
References: <20260524153848.16334-2-avivb@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 May 2026 16:13:28 +0000
Message-Id: <20260524161329.1805B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Low] The patch breaks the build when `arm-cmn` is configured as a module=
 due to an incorrect `#ifdef` guard in `include/linux/perf_event.h`.

Pre-existing issues:
- [Critical] Integer truncation of `cmn->num_dns` leads to an undersized he=
ap allocation followed by an out-of-bounds write.
- [High] Unbounded `cmn->num_dtcs` leads to an out-of-bounds memset in `arm=
_cmn_event_init()`.
- [High] Unbounded counting of `hw->num_dns` leads to an out-of-bounds writ=
e in the `hw->dtm_idx` array.
- [High] Unbounded DTM pointer advancement leads to an out-of-bounds write =
in `arm_cmn_init_dtm()`.
--

commit 783e16d4bed9e2f619820aa17251b0f781f0cd6e
Author: Aviv Bakal <avivb@amazon.com>

perf/arm-cmn: Move struct arm_cmn_hw_event into struct hw_perf_event

This patch moves the arm_cmn_hw_event structure out of the driver file and
directly into the hw_perf_event union to allow expanding its size for larger
mesh topologies without violating static bounds.

> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 48d851fbd8ea5..c38576a8e3383 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -200,6 +201,27 @@ struct hw_perf_event {
>  			u64	conf;
>  			u64	conf1;
>  		};
> +#ifdef CONFIG_ARM_CMN

[Severity: Low]
Will this break the build when the arm-cmn driver is compiled as a module?

When the driver is built as a module, Kbuild defines CONFIG_ARM_CMN_MODULE
instead of CONFIG_ARM_CMN. If the ifdef block is skipped, the cmn field is
omitted from struct hw_perf_event, resulting in compiler errors when
drivers/perf/arm-cmn.c attempts to access it.

Does this need to use IS_ENABLED(CONFIG_ARM_CMN)?

> +/* Some implementations use a mesh larger than the architectural max of =
12 */
> +#define CMN_MAX_DIMENSION		14

[Severity: High]
This is a pre-existing issue, but is the DTM initialization logic vulnerable
to an out-of-bounds heap write with larger meshes?

When multi_dtm is enabled, the driver allocates 2 * num_xps + 1 DTMs.
However, if multiple XPs have more than 4 connected ports, the logic in
arm_cmn_init_dtm() can initialize up to 3 DTMs per XP.

For meshes containing multiple such XPs, the total number of initialized
DTMs could exceed the allocated capacity, overwriting adjacent heap memory.

> +#define CMN_MAX_XPS			(CMN_MAX_DIMENSION * CMN_MAX_DIMENSION)
> +#define CMN_MAX_NODES_PER_EVENT		CMN_MAX_XPS

[Severity: Critical]
This isn't a bug introduced by this patch, but does the discovery phase
have an integer truncation regression when accumulating the total node coun=
t?

In struct arm_cmn, num_dns is declared as a 16-bit integer (u16). During
arm_cmn_discover(), accumulating child_count across all XPs can wrap around
this 16-bit boundary if an unexpectedly large number of children are report=
ed.

Because devm_kcalloc() uses this truncated value to allocate the dn array,
the subsequent pass that advances the dn pointer based on the true number
of children could write past the end of the undersized heap allocation.

> +#define CMN_MAX_DTCS			4
> +		struct arm_cmn_hw_event { /* arm_cmn */
> +			/*
> +			 * CMN PMU event state overlaid on hw_perf_event.
> +			 * Must fit before the 'target' field.
> +			 */
> +			struct arm_cmn_node	*dn;
> +			u64			dtm_idx[DIV_ROUND_UP(CMN_MAX_NODES_PER_EVENT * 2, 64)];

[Severity: High]
This isn't a bug introduced by this patch, but what prevents hw->num_dns
from exceeding the capacity of the dtm_idx array?

While the driver restricts individual dn->logid values, it does not limit
the total number of nodes of a specific type. If firmware declares more than
224 nodes of the same type, hw->num_dns will exceed the space allocated for
dtm_idx.

During event addition, the driver calls arm_cmn_set_index() for values of i
up to hw->num_dns - 1. Does this result in an out-of-bounds bitwise write
that corrupts nearby structure members?

> +			s8			dtc_idx[CMN_MAX_DTCS];

[Severity: High]
This is a pre-existing issue, but is there a missing bounds check for
cmn->num_dtcs during discovery?

In arm_cmn_discover(), the driver increments cmn->num_dtcs for every
CMN_TYPE_DTC node found. If the firmware reports more than CMN_MAX_DTCS (4)
nodes, arm_cmn_event_init() will perform a memset() using the unbounded cou=
nt:

memset(hw->dtc_idx, 0, cmn->num_dtcs);

Since dtc_idx has a fixed capacity of 4, could this lead to an out-of-bounds
write that corrupts adjacent perf_event fields?

> +			u8			num_dns;
> +			u8			dtm_offset;
> +			DECLARE_BITMAP(wp_idx, CMN_MAX_XPS);
> +			bool			wide_sel;
> +			int			filter_sel;
> +		} cmn;
> +#endif
>  	};

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260524153848.1633=
4-1-avivb@amazon.com?part=3D1
