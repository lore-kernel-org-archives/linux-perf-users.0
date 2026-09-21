Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2562E8B67
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 08:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789978935; cv=none; b=g9wRLOQ3X37LaUI7Bsm0X2TtyITlmP2LOkBj3ZJEzUxUfXOIi6N/V337s7lauWCI5oV5G+DB9a+2RNuhbN9OEtdMxQkkfQGFRzJIHYqWR0+oMJXBfKZqtgJwM7nkUmQM/muMy8eRvvoAD4lvqhKEKf1kcoZuySK1hW3s3nfywPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789978935; c=relaxed/simple;
	bh=/S/Do04aOwVQNDz4R0z1pZIw0f0chipS0lY9WYQMHcI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mBZDgaKnqTUnz0qBocEI06oVgIZbyVe1yfgIDddW7OT6crAmrXxTaj4GPyEI9iTU6aE71ng/cJWwgKsVKMOGLNJh4aHeUpFf88bWdFOshDno+UQwkMuLrhdoZyvkx9AihurFwTQzqOPJHJpbpn/18e+wBW5kk37EZiuMM3AAPm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZ3GLh8R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZ3GLh8R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E95A1F000FF;
	Mon, 21 Sep 2026 08:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789978934;
	bh=/S/Do04aOwVQNDz4R0z1pZIw0f0chipS0lY9WYQMHcI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GZ3GLh8RIL1QQPIMIPhxBAf688U+z+J38PNy4L5EA8+yJYTUBDGg7uUNjJMbT7gYW
	 hbA0vomJHmfBghsCcmFlimICOHiQa0P8no6KlYOmw/ydzpD+djLe/DaogUfGHh9ODQ
	 0C/qceQQQciWJyGPkIH3x42un1FCdB70y8gzERq+ikhiyuUlXBiUIUr/0cesy1vyuT
	 1TPKqhenSLl/9G0+/b2au7f1d/yY6umWzY+sbVEw1Iie5Rmbo2vf93ay/OXXtUNei0
	 YRerK3wSh2plv/D15PPNfyf8GfxJ5iG9ivsuXGFZGN735uXqFcJ9jyeUeBPVbvu47i
	 mt1dV0AjaVPmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 2/2] iommu/riscv: create a auxiliary device for HPM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zong Li" <zong.li@sifive.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260921081544.1797510-3-zong.li@sifive.com>
References: <20260921081544.1797510-1-zong.li@sifive.com>
 <20260921081544.1797510-3-zong.li@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 08:22:13 +0000
Message-Id: <20260921082214.0E95A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Create an auxiliary device for HPM when the IOMMU supports a
> hardware performance monitor.
>=20
> Tested-by: Chen Pei <cp0613@linux.alibaba.com>
> Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Yicong Yang <yang.yicong@picoheart.com>
> Suggested-by: Samuel Holland <samuel.holland@sifive.com>
> Signed-off-by: Zong Li <zong.li@sifive.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921081544.1797=
510-1-zong.li@sifive.com?part=3D2

