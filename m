Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C89502D7A
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 13:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899105; cv=none; b=Z5wsmLsZjybCeDxuqopHgEh4Q86pBCyUhzPRx/oRgO6JQTqz9hBzIlCQwjRGmIw4sX4BmaTXnI2XLPB9QoI8h+kyr9GClGdxKn5CUOqwCahCvDbngsAlUPmrmXmtYaDFJNxHP3ivWgbwZeMvKx/MFfeO0rgINKJ3WmXajOPokn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899105; c=relaxed/simple;
	bh=MEzaqSXvJC2cr/V+TW2r92bKo4apB/wGUhX8mgnQzMQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=AAsDSceHRp/CqEHk2lL+ZPYNv1p7wnnvu8adPhjxMOqrBKknKzoKJKVuPP0WZe9tL5WZJK25/ANANp+Ng/ppFFjod+KRNjgnxnAG5QXvMGs0rHnabUeJvBW/XbXOmRWZcFjC89JHrO6qH3JNR+p5BHup2pOHpVjGf5ri+pwLlqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfCsdxfA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfCsdxfA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A661F000FF;
	Tue, 13 Oct 2026 13:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791899104;
	bh=MEzaqSXvJC2cr/V+TW2r92bKo4apB/wGUhX8mgnQzMQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MfCsdxfADy9fn+u4tCcsPlO9apPdAL6BSVjnLRBlSpD6DXHDH6mD2PrwpYenfazjJ
	 MGt5hvL59i3DttZfbe8kPJkeT33d76O9zpVMHiK3vBHd3IUhrtHB+9MruqBtxd5no4
	 Fr4HP+l2HausD3Cmhnq6h/eVHuGA2589cXPNwaRVYCHHKMsYbjCLmvLAvujRNrsgC6
	 1q51mUo8Apg4h+GA/Ed0cmTMjRdepnJ8Tp26CBUy2kGamDPWG3pIPScQQgDTQYUVbV
	 4wbUd4OBsxWuhg2KWKSIdkKC1C1HXLwld/Q1fUWY1i+Ksrs+gf/H5t7eEGkTmt4qoQ
	 GQBXXZZlLNOWw==
Message-ID: <sashiko-outbox-169855@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/15] perf annotate-data: Expand type_state_reg
 imm_value to u64
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <4582a236d6a0ead429a602fec2c8fbbb0916d382.1791629326.git.wutengda@huaweicloud.com>
References: <cover.1791629326.git.wutengda@huaweicloud.com>
 <4582a236d6a0ead429a602fec2c8fbbb0916d382.1791629326.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 13:45:03 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The arm64 'adrp + add/ldr' instruction pair involves global variable addr=
ess
> calculation and passing, which requires storing the 64-bit address in
> type_state_reg. Currently, there is no field in type_state_reg that can
> hold such an address. The most likely candidate for reuse is imm_value,
> but it is defined as u32, which limits the size of values it can carry.
>=20
> To address this, expand imm_value from u32 to u64. Also update related
> compilation warnings and fix the sign-extension issue introduced by this
> change.
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791629326.gi=
t.wutengda@huaweicloud.com?part=3D7

