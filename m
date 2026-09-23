Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC9A54A7F9
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181668; cv=none; b=UOG9v5ukChZkhv2LWN15xGo/JFidkV3if+Df1tl4TIGmMEBQIqBzfFRfzttoQb7pi6JwJ8lwI4aXJ1C4XCUFjtOuU5EhyMUFsLrjW7ZboXHSJxv3uPsNoBsK/KG07DoZ5ywsb39mzfl+/Cf2daNA06oWwXS7lsmTm7AerkqaPcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181668; c=relaxed/simple;
	bh=bMOrFRVDrCbSFrzNlkm6TtH0u2+xhwMFK1VuNUyQiz8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nTeJTkzruhS7usVqCy6a22YU7DgSmvi0z9Mm7eJUgxP42JDpKsh8PrFS90KJOb4I44XoZLH/5LbOaKCVO+QvLkFSkc8xYO06p+vOA5veXDvRxpa8HTz6E53REGELEn6eWIytZVSduL9LFMcb0vV0sk16fJnTkDaijHqW3YGuT94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4EdTFlk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4EdTFlk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5691F000FF;
	Wed, 23 Sep 2026 16:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790181659;
	bh=q8Ykm/EbEznUAFOkVZc/FLcot+2ej63g/bkNr1VGvAM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m4EdTFlktmNaBLZYILJ64FbC57tSY/K2SXWMvOoQGNllcfr42EHkPZqokU60pk1Ae
	 na1UixmdNg82bch/ZrisMuIl1uRj/vIsCWMDWAqlTM2tLUAbWZkaTdIUbA2lrJdLw1
	 iUk++BYxIpRjpMurrEsPdumjKSjYYoF7OcI+XkOdBNOjJRN1eFG8fYMEIHYfqkRcRq
	 2PEN2QWOUwi9Q2dj2NsZK2Fibve02E93kzSrmCiZCPu80ynyzdkSY0ywOItttTdZO+
	 DNTGCsxH8hjnqUDfLpssdmwhCPfIAsh8VFcYV0DABwnC8KNlLpytt1nzBLyMz96vXC
	 9G0h6l4Bi+oUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/14] perf tests: Check CoreSight IRQ entry and exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923-perf_cs_etm_fix_non_taken-v2-11-6ab8c07a5455@arm.com>
References: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
 <20260923-perf_cs_etm_fix_non_taken-v2-11-6ab8c07a5455@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 16:40:58 +0000
Message-Id: <20260923164059.0A5691F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add an AArch64 branch_not_taken_loop workload and a CoreSight shell test
> checking IRQ entry and exit PCs. Use cpu-clock generates timer
> interrupts.
>=20
> Retry at different timer frequencies and skip if no complete pair is
> captured.
>=20
> For example, an expected hw int/iret pair is:
>=20
>   hw int           5cc928 =3D> ffff800080010c80 insn: 63 04 00 f1
>   ...
>   iret   ffff800080012284 =3D>           5cc928 insn: e0 03 9f d6
>=20
> The entry PC is the architectural resume address, here SUBS X3, X3, #1
> at 0x5cc928. After the IRQ is handled, ERET returns to the same PC to
> continue execution.
>=20
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-perf_cs_et=
m_fix_non_taken-v2-0-6ab8c07a5455@arm.com?part=3D11

