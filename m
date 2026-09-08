Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EB35581F2
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873172; cv=none; b=qHweHYIVFumU03QZJhX7y4cqcEcyQCdKzGawbqlBeHAvYnbPVHmhqx6KDXQZFfiQc/BGu4tzGUowdS9cTMa1xXk3g7e+xLJ6Dz3JaNni9j+UmXpDLrvBkTQ4uVrEtNaM/8HyxD/sw28ooQtuHpskfrU6F/2dq1jpqtoAw1Ht6as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873172; c=relaxed/simple;
	bh=TQc0BKbISgdNRCtrWEGo1xFNRzwffvedrBJuuI4CicQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VryMe1pHJVCZPtb4AiMhFXwuScj3+tpV2dDuiCefQ/mFBJi0TrYFVN5vL5vqL1NB9tJqZkxMfaYQ7NMTsGxvvmhNmoxF49cF9T01DLU3W57oMXp3QsLtaeFcCCr5I/RUuqZkgS7wsLr9h907gk0Dc7KVu/XBNNHmpubCJmQnb7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QV56lUVI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QV56lUVI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC4D1F00A3D;
	Tue,  8 Sep 2026 13:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788873164;
	bh=/jr8iufy9XLtrP2ssdl6WKvravJAa39nMwj/axYQClU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QV56lUVIhpV304aQUVXjzH4wjbjbqiTyohfi0DoXRBfacZkeW1Q0/UZHBT8EV3hxF
	 2E9KHkUtGJn32FWaoXmE/eKT1vZ3/7OaXzZocraQ2A8kFQ13foa/8vVPP97QzRaYOi
	 ShrHxATDYvLI+6B6h5xJWlDvrRKeNfsxadvadF/uCAxB6Tfi8ZTem6rybk066og/tU
	 jKAcehlu+eyNL/bP7ZY7py1kdpQa2h3cZIt7x8bMm6Bz7je/gLnnaiaZ3UEAtq7llQ
	 Zt4ZrbIIgYWENijgWTiFezMfR3Eldf2EB6GXLByg90wwFWufgqSlKo68z8CwKOf/jX
	 tXR5QVBtez5Eg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/26] perf arm-spe: Set default synthesized event
 period to 1
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <59d7bfeddd5ee06561e91876662d40fbf202ac6b.1788872630.git.wutengda@huaweicloud.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <59d7bfeddd5ee06561e91876662d40fbf202ac6b.1788872630.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:12:43 +0000
Message-Id: <20260908131243.CAC4D1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When using --itrace=3DM for data type profiling on arm64, the 'Percent'
> values in perf annotate output are all zero:
>=20
> Annotate type: 'struct mmu_gather_batch' in [kernel.kallsyms] (15 samples=
):
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>  Percent     offset       size  field
>     0.00          0       0x10  struct mmu_gather_batch  {
>     0.00          0        0x8      struct mmu_gather_batch*    next;
>     0.00        0x8        0x4      unsigned int        nr;
>     0.00        0xc        0x4      unsigned int        max;
>     0.00       0x10          0      struct encoded_page*[]      encoded_p=
ages;
>                                 };
>=20
> However, adding the -n option (show-nr-samples) reveals non-zero sample c=
ounts:
>=20
> [ ... ]
>     0.00        0xc        0x4      unsigned int        max;
>     0.00       0x10          0      struct encoded_page*[]      encoded_p=
ages;
>                                 };
>=20
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788872630.gi=
t.wutengda@huaweicloud.com?part=3D11

