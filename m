Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ABE554085
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873755; cv=none; b=WtGuKaYTeqTCCq7MATDzFbGC2FI2zuCEIOq38aBHtKMdmc+wXCmTwPtb6TclVrlo23Q8o2y8amdNnWRd8WnP0HQgG0YPZlKt3GtIE1OTRJ0/K6ZeH5F3rrNdhFPzckBEkNHbRxT9+axE7O4mSxLWcoGvas6ToHuIvPAVZNH2CAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873755; c=relaxed/simple;
	bh=UWjrhlFgSVvl02MLD/n2ZU0osaLgMplrQkOnmR5k6O4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rGupK0TfZNcAN7pH7p2npc9uRYk4NDtgKAL3Tf8veDkbINralXjxr7oGOW7ENeR/gAjmkeqYXMog4KP+FVfw7jDK93uN4T+hQkoIfrbLmiaItiJMxQUL3FtTNLFTQNrEsurDR2HBWC3mTzn6n0SZYodgaG3RA4o/Yejml/1MWuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMNU2Qi4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMNU2Qi4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345141F00A3E;
	Tue,  8 Sep 2026 13:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788873748;
	bh=UWjrhlFgSVvl02MLD/n2ZU0osaLgMplrQkOnmR5k6O4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IMNU2Qi4Hnvxtnmb6Pwh/ookRGFLS9GVsLbymJ0fYstpW0gyNIeQt9mW36djAnFin
	 +MunyBWU2qDC+67QsutUh7QrHmtduALzwCF0t1r0iVDp2M4TS5Kc+HIpk2YP3rTQI0
	 FY65v1tYzdLeZ5jD4z44vvqsZ5wXUfVh6Rs9/X+5JxDYKzq8h0eyR8001mvTOUb1Ky
	 rhyyxuiooloPScySgRMW/kGWostjf9vT0rVIsGh+COq+XBpUR7i4rkhKpwp8+cVOlb
	 mUhm2SRZq+NG938rxYgkzMD0WI0boE7ENOcf4lPa/OH2l9DWHLO/szk0XiUlsA25+H
	 MdT3LNGgyY5nA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 17/26] perf annotate-arm64: Support store instruction
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <1e6613616abcf852b54025176f70357f11507d25.1788872630.git.wutengda@huaweicloud.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <1e6613616abcf852b54025176f70357f11507d25.1788872630.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:22:27 +0000
Message-Id: <20260908132228.345141F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Extend update_insn_state_arm64() to handle standard store instructions
> (str, stur, stlr, stp). Exclusive stores (e.g., stxr, stxp) are omitted
> as they exhibit different operand semantics.
>=20
> Unlike load instructions, a store instruction sets a value in the struct
> within the memory where the destination register resides, and does not
> alter its type. Therefore, no processing is required for the transfer.
>=20
> The only point to note is that store instructions support pre-index and
> post-index addressing modes, so calling adjust_reg_index_state() is still
> necessary to handle their addressing.
>=20
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788872630.gi=
t.wutengda@huaweicloud.com?part=3D17

