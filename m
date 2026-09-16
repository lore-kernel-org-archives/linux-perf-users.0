Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6A73C060E
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 01:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522888; cv=none; b=Ic8ZecCFBzfU09X+tiE7vZIGVRbRTgHqoO+muHxEcyUAV8YOwk5C+4x+sxBKy1VuWD8OLQOLCD2dWXXME9HDmKeRrlGb0tdtTrSruuBVVaEOSSfRx3mnqMNUsnN09cRVrgt2Jone8APYuh+TNaZAU7E0fLsKYZCWB/veBDV90qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522888; c=relaxed/simple;
	bh=TZTlgZlKrWWrtspmI772dT71NkMfEr9apRzzIxzGpOk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GWRp4kRsYrP/gi2buDggD/VQiVcfabo4lVVzriYZPptDJ0GeC62JvPYiVuNyZO0GRPD73Yu/j2BlTwW3YGMG7TtL5dB3UxrM0ps49DXLDDl4SSgSg5kAO4tIizNAMsVqnwlS7JZDDYZlw39Mfm7dEUGpLlp7ZjPDJSOF+sz2LKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPcSSrZ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPcSSrZ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFE51F00893;
	Wed, 16 Sep 2026 01:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789522876;
	bh=TZTlgZlKrWWrtspmI772dT71NkMfEr9apRzzIxzGpOk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mPcSSrZ5TwopzwhPE1pwZSGKmyX5LHJ9fupH4k6aJkdCLCaevpNdoCaV1d3Wpo3MA
	 qatmCKtxDpBwUFM1O9ndZeUy0E7Z9zR/hkzonLEY/I4YuoXxxWVoLMYiVCnZ5hsomZ
	 6gmK3HqNIdWCHM2GpLugOrrda8FFv7U45Iv7NVfBRRDMp8MD41hHoqAOF0AAEnXbQ8
	 znKUEGPuuujyZM8NJNkxaDdZkL0yq1zMf6IzVe/bo4tOwKYqMBhYg7gjdhQoJ9Chhz
	 xnax/gm435ZhQ7AYywLuX5HjP9VoqJxW7JTuapXkSWbyM/1/dsjXfiQCp0hww+C/5/
	 E3Zuxr3045o8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 17/26] perf annotate-arm64: Support store instruction
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <5f49abec1847e5e684ce4ae4462f06857cdbea89.1789521520.git.wutengda@huaweicloud.com>
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <5f49abec1847e5e684ce4ae4462f06857cdbea89.1789521520.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 01:41:16 +0000
Message-Id: <20260916014116.BAFE51F00893@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789521520.gi=
t.wutengda@huaweicloud.com?part=3D17

