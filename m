Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1352D4477E7
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 19:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790364087; cv=none; b=VVlFxzclxGjhVc6sxwLGabK/kCvYRiZq2k66UDRCP06Ylwuo5H5ias3K1hwA+YLVZRv+eVyUYMhgu6NmCn6hAx2kUqkY2e+/sP8/xJffaPKLm1suzKtkM0UhfH2Q3s68rxQ3hy57RZRBp2/NizA42a9PhX5XlokgEHoXMj3BhW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790364087; c=relaxed/simple;
	bh=o86+JGt0a7FVwDdhcoHMH+XzbYhrKlebnHO6kIeCsxo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UiutF0Dw6BxrqdduNPeZCPnqdkynvNYAmpHk+FvMKuTToXRkaFntw4G66t9hug3ax5R/qc7RY9HkCzDal4yLykvfE/ZrWCLel1gskMbSsPQ2mvr7VlyWzlZUDTjX9em/Rq9+ysYw/HOaE67X2Jm6jZkbkNDAgMSey4NCML9IQug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOdxNUCp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOdxNUCp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8064B1F000FF;
	Fri, 25 Sep 2026 19:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790364085;
	bh=o86+JGt0a7FVwDdhcoHMH+XzbYhrKlebnHO6kIeCsxo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BOdxNUCpPVsFepzDYZ2eh07b6CL+JohuPWRXxKmy5A35nU4/Y+n9LJWwZNcGCDwbp
	 5orDxWhLTaEGhrqHE6qhPYR3vRzbUTDCGKO5mKlj+SWW7yrz1KLJO3FFCM6U2xmruz
	 qmovqFnt4lCtelxf8fgAG9KyXocg2vr2MbCMOOSnhasAvmPlDJVcCfhdIUDurAeZgT
	 AdyVxauqGniFjFo6IsyIiyL/EefLFH9BBn6VmNSZHxg93SbMHWEErSsa4zA+x34V5p
	 c/zaheYu39PP+E/6hu+jR2Ux7srfzHpzSYNhokOw5eukjLllhx25vszLvXXacdXW70
	 bl9WcHaCqq3nA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/6] perf symbols: Fix broken ELF_C_READ_MMAP
 fallback guard
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260925-perf-symbol-memory-send-v3-1-3e4e234c363b@uber.com>
References: <20260925-perf-symbol-memory-send-v3-0-3e4e234c363b@uber.com>
 <20260925-perf-symbol-memory-send-v3-1-3e4e234c363b@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 19:21:25 +0000
Message-Id: <20260925192125.8064B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Alireza Haghdoost <haghdoost@uber.com>
>=20
> Commit 22dd1ac91a77 ("tools: Remove feature-libelf-mmap feature
> detection") replaced perf's compile-time feature test with an #ifdef on
> ELF_C_READ_MMAP. ELF_C_READ_MMAP is an Elf_Cmd enumerator rather than a
> preprocessor macro, so the condition is always false and perf silently
> uses ELF_C_READ.
>=20
> Perf already requires a sufficiently recent elfutils version that
> provides ELF_C_READ_MMAP. Use the enumerator directly instead of
> restoring a feature probe or retaining an unreachable fallback.
>=20
> Fixes: 22dd1ac91a77 ("tools: Remove feature-libelf-mmap feature detection=
")
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-perf-symbo=
l-memory-send-v3-0-3e4e234c363b@uber.com?part=3D1

