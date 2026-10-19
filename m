Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A29C4973B1
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420511; cv=none; b=bjwrYKOSVQyTnyCINtITPM3rC3ree8E00Vj1bs50XOAoESZtQ+Uiv63wZUtjdY8/YFSTMCt5GhTKE0Zi8Zu2ZqSKRx6Z3hDIZjnQdWFTwBqphvUQW1Iz3Oej+WBCyRuMLbIW2sPCOJxPCLDV2eZMLdh847Fzsyjiux6Ly4pf/LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420511; c=relaxed/simple;
	bh=12DquMtTxOGmT1TDENiKd3oZcoWX9rCualx0AtCvNaU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=D4yAS9fuOk7xXy1A0WunCmQ9xOSskMI2m0hKVStpw5oLY/x3DIzdYRHQrz1KZhrtvyFgVGCfv8DjJcmzQqtfargfWBcZnWeNlr78PizmIqIG6IJt72Qx1qGBR8o77rENEmdfZkEP4pl+LNdQ/JQWaCftiIX6ioPlX8NXQWS42Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaxVNwhw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaxVNwhw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39C51F000C5;
	Mon, 19 Oct 2026 14:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792420509;
	bh=VI11lHhBtPwIITauVPBnFQwKOSQjRniRyTo3fbSjD34=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JaxVNwhwe6JsguyHRRYNTa5MosZjDiTfZ31mW5mlwCyKKtyj944jXu4b3KfMpnP/p
	 qA3KZG8+Uc+0jfto0GTcdbe9mKfxFam4qOs/arlK1cl5HZ+PR/HhjxGUlgG2ynv5hx
	 xqU5NgzFnzUqQHxTH8MJr3d2e4JoI5n2lJ1jn833sorlL/jPGlKbAmmQdp1rFXU8cV
	 V0kyFsB3njUBKAv1Gaj3QVuZZgYvtILqOWWRKxpCyhF35Ye36RxXI9KuZxg3NGcE6g
	 ZRrgTPQM44Lj5b5IYFvcNavxPYU2s9/rTTAmR6e32BlW5TA8fdFGhe3BCTF0VMnVcg
	 8Ke8bzpcJV35w==
Message-ID: <sashiko-outbox-177434@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] perf/arm-cmn: Add workarounds for CMN-S3
 on Graviton5
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261019135441.1420968-145-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-145-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:35:09 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf/arm-cmn: CMN_MAX_DIMENSION bump breaks 32-bit COMPILE_TEST =
static_assert
--

commit 27fbc22fac85b996ea007fe76c639085d36b43ec
Author: Aviv Bakal <avivb@amazon.com>

perf/arm-cmn: Add workarounds for CMN-S3 on Graviton5

This commit adds an ACPI HID and discovery workarounds for the customised
CMN-S3 implementation on Graviton5, and raises CMN_MAX_DIMENSION from 12
to 14 to support its 10x14 mesh.

> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 527a953bf4744..688a94ef81c22 100644
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

[Severity: Medium]
Does raising CMN_MAX_DIMENSION to 14 break 32-bit builds when
CONFIG_ARM_CMN is enabled under CONFIG_COMPILE_TEST?

Upstream commit 9d0b1714e1af1 ("perf/arm-cmn: Add workarounds for CMN-S3 on
Graviton5") was patch 2/2 of a series depending on upstream commit
56603c28d9169 ("perf/arm-cmn: Move DTM index data out of hw_perf_event"),
which moved dtm_idx and wp_idx out of struct arm_cmn_hw_event.

Without that prerequisite commit in this tree, struct arm_cmn_hw_event in
drivers/perf/arm-cmn.c still embeds both arrays:

struct arm_cmn_hw_event {
	struct arm_cmn_node *dn;
	u64 dtm_idx[DIV_ROUND_UP(CMN_MAX_NODES_PER_EVENT * 2, 64)];
	s8 dtc_idx[CMN_MAX_DTCS];
	u8 num_dns;
	u8 dtm_offset;

	/*
	 * WP config registers are divided to UP and DOWN events. We need to
	 * keep to track only one of them.
	 */
	DECLARE_BITMAP(wp_idx, CMN_MAX_XPS);

	bool wide_sel;
	enum cmn_filter_select filter_sel;
};
static_assert(sizeof(struct arm_cmn_hw_event) <=3D offsetof(struct hw_perf_=
event, target));

Increasing CMN_MAX_DIMENSION from 12 to 14 grows CMN_MAX_XPS and
CMN_MAX_NODES_PER_EVENT from 144 to 196. That expands dtm_idx from 5 to 7
u64 elements (+16 bytes) and wp_idx on 32-bit architectures from 5 to 7
unsigned longs (+8 bytes), increasing sizeof(struct arm_cmn_hw_event) from
88 to 112 bytes (or from 80 to 104 bytes on i386).

On 32-bit architectures, unsigned long in struct hw_perf_event
(include/linux/perf_event.h) is 4 bytes, so offsetof(struct hw_perf_event,
target) is only 104 bytes (or 96 bytes on i386), causing the static_assert
to fail at compile time.

Should upstream commit 56603c28d9169 ("perf/arm-cmn: Move DTM index data
out of hw_perf_event") also be included as a prerequisite?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-145-sashal@kernel.org?part=3D1
