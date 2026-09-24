Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E733D0BED
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 02:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790216647; cv=none; b=EY+2L+fz5bZ1lJtNU40SV7YEUkFtwsbYCigR2Yu3uPVQLdKgUCbVTRt9CPRZD8m5X8NAM+MCz3yDVeen/gD7sYCvSb9oQUdWxo7sd/lQ16IY6LwAxGbyG6QWx6AZfOW/RLl6iTlBaXaDPB41DEpkw5br5O4h+lwxCcLyCBBROa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790216647; c=relaxed/simple;
	bh=cN0EdRbnXq5uSEhREuU4T5u0ZKnpgSlePI7y5p8Mz88=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fYYK2Kf+GwpRqVgznI/Ywp4gwpL8OAgi5dbjHG4RAqnRP7nh833pLhE9OKjBEbDWNcNUMiFYXDbv2FW6aps3lMi9/tLwTl6jKR6CE3882kbgfzDW5JFAfTp1gNARVF0HibhTYPGUjwzMt6gNUGUHWg8dTuDGU66HoIygxIFP8fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/9gH/lb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/9gH/lb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A523D1F000FF;
	Thu, 24 Sep 2026 02:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790216645;
	bh=VQFHkMwAfUfmz3cHsO/OO0+G2KfCl8x1Wg35S7ZX6Yg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b/9gH/lbuwwlZEgmly5E4uw9ALTCExfBC8tdRy1FcEgk/ZlXqc+8etz83KqIHppFe
	 n+mLPZJMSf+pV3sppckGyLDvnAMZHFK0JM1Cw1bsjfiayrqlZ8n1LVvV3R0i56aMe5
	 8p6CTHTPmPDsjmoj7QXGhAGe2tqXFnmcqbiC8gv0fsjj2afEjmrX/uyXMFvN4KY+DK
	 ZvGtrJdsBJT4e/sRC2U9/etJA3aRATotfSHL0R60+Ft7K2IVl/76YbJtBGHKPf6yYm
	 tmY6+KADG+xBqUx9dxtr9fHL2+RjlVgFHxf1BB9VqliVeA/YyaUK2T6Lh9HctDtB1L
	 aItpeWLv8zUIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] perf loongarch: Fix discarded const qualifier in
 _get_field()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924021756.22433-1-yangtiezhu@loongson.cn>
References: <20260924021756.22433-1-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 02:24:05 +0000
Message-Id: <20260924022405.A523D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When building perf on LoongArch, the following compilation errors occur:
>=20
>   CC      arch/loongarch/util/header.o
> arch/loongarch/util/header.c: In function '_get_field':
> arch/loongarch/util/header.c:31:15: error: assignment discards 'const' qu=
alifier from pointer target type [-Werror=3Ddiscarded-qualifiers]
>    31 |         line2 =3D strrchr(line, ' ');
>       |               ^
> arch/loongarch/util/header.c:36:12: error: assignment discards 'const' qu=
alifier from pointer target type [-Werror=3Ddiscarded-qualifiers]
>    36 |         nl =3D strrchr(line, '\n');
>       |            ^
> cc1: all warnings being treated as errors
>=20
> Declare 'line2' and 'nl' as const char * to ensure type safety. In modern
> glibc versions, strrchr() returns a 'const char *' if the input string is
> const.
>=20
> This is similar to commit 7378b6656aa4 ("perf riscv: Fix discarded const
> qualifier in _get_field()").
>=20
> Fixes: 492ac37fa38f ("perf kvm: Add kvm-stat for loongarch64")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924021756.2243=
3-1-yangtiezhu@loongson.cn?part=3D1

