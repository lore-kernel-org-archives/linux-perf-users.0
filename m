Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E2A481FA5
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 12:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044962; cv=none; b=sUVX9FKzYytq86huWwWY+T+C39NlCIutazuxgArEgwARX91vVAolkSfoBNK8mUYO9bi796ToXt7fvo4Nq0OLEHgDALWtMYAXj8xyKTtQ7L1CZDtrCLz3LB/LksZD8igfaoeuBPOAcJywNUjATpzJUvJX4RJrUYYVvabAc+VbUVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044962; c=relaxed/simple;
	bh=DyqpyiGjyNkvYKuSrXMdxl8pmq6iRuSdvhlg417acu8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jty96q/jLdy46qx5czobVYNpqqd/9dz8CTQ3sSdCWrcZaSPz5Dadon78t7rgMVrLIxTAQQv00Wd19m1mwWt1nydrMlW2cmwJKqnV20XR+wVX/X3XA26Fvx/IjVFBoOll4XliH0EWRapZaIiBjRYwCxetbicO8lZQR4gPZRe10eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bI0eHoko; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bI0eHoko"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54B71F00893;
	Thu, 10 Sep 2026 12:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789044959;
	bh=l7e9psFHZt1n7/WHG1mDp5TprckMPmZa4zqzYVqMeik=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bI0eHokoaq79dDZYo3x87FkXX+2RVsgQatmTostdxr3vWWJ/y2H7Yye/4NWW1AzWe
	 7V5XExKkMU8F/pWaZItKTZOF3bOAN+7yWxCxxy+01pvzeSWTSV0i8NmDFGai0r5zi8
	 RuZqa8ZdfeAG6bmyEZpjBdpbZlL/ejQjhSa4oze4DiXIK/7ym00ylLBQCrVhm70ex5
	 Jt0hzsYZLC1/JEJPpl8PtNCcs9qsMNr4CqR7eqmegg3f9h8q/Wl1mk6owumyagzJs3
	 9lVig+jNdGtvOSdSdQyc4NyKG7cz7Xbap+/IJLhqSanYs1H9dQ+GAUXEsg0KaOCUvy
	 3w7CFmcgcq+nQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next] perf list: Avoid repeated strlen when
 escaping JSON strings
Reply-To: sashiko-reviews@lists.linux.dev
To: Qerogram <qerogram@naver.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260910123839.72285-1-qerogram@naver.com>
References: <20260910123839.72285-1-qerogram@naver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 12:55:58 +0000
Message-Id: <20260910125558.E54B71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The %S conversion in fix_escape_fprintf() calls strlen(s) in the loop
> condition while escaping each character. GCC 14.2.0 retains this call
> inside the loop in a normal DEBUG=3D0 (-O3) perf build, repeatedly scanni=
ng
> the whole string.
>=20
> Test the current character for NUL instead. This processes the same bytes
> without rescanning the string. Escaping and buffer growth are unchanged.
>=20
> Full-command wall-clock measurements on an Apple M5 Pro host running an
> aarch64 Linux container with GCC 14.2.0 and glibc 2.41 gave these medians:
>=20
>   perf list --json metrics       Before (ms)  After (ms)
>   Default catalog                    0.5969      0.5855
>   PERF_CPUID=3D0x00000000410fd830        0.7818      0.7033
>=20
> [ ... ]
> Codex assisted with identifying the redundant scan, preparing the change,
> and running the comparisons.
>=20
> Assisted-by: LLM
> Signed-off-by: Qerogram <qerogram@naver.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910123839.7228=
5-1-qerogram@naver.com?part=3D1

