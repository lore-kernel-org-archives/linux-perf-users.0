Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D8936493F
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790450018; cv=none; b=SfNrVpNxaZTC4fhz0eNmsYjNFG5thbzneyZKLcUk4mJq7TPRr/JSBTvMO8RNfjvFWzC8hRNTr6ioWerzbIVWAwbjDoGa9e2a7yXaLZynONBlU/B6wy2Hob9jAwIlLgdBUjcPyvQsw37iLUGRfatNsk/6AQ7rgDv59WJ3zp/Hk3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790450018; c=relaxed/simple;
	bh=OYMsnPa7CsxnSYRJogdDBgJoVx+c2aN6SzyYqylRRx8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=er/CaC3hpjaOGuUCIMDm1c2CHFxf9gT4u4PLDu8GiV+GiJRbKcdh367Fs51v5D/A6/pPsL2I6jhiavx1JLD3iwB7xAyi73dZ8JJsEcYV5/N4YR39bc+Hu8S8b8SY8Wc6cOliA0Gd1wPYBQAPUt81INNYVtmh3WpiWrSXlxY0xQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCM3F6+8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCM3F6+8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6781F000FF;
	Sat, 26 Sep 2026 19:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790450017;
	bh=vBynte+gDcp6PPorxYabALUMJQcY4VxphgunOkQbBGE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hCM3F6+8Xl6pSD8ARoAiFOjmAxmp7ANbeyE+Tb6aZKWbIAwIxJbjWNfJ4Ag8GidH0
	 9LaRxFWTbBi9+fQGcJ8swGPl31TD9mnNwh3QQOihG3bmky/h5Oo22sjfywRKcBpNC4
	 w4TrBo9aqHLSfuCiRnwS30cpl6uNwm+6NtOlQwvyHcnBluDpTFsNRWWGF4HX+R4ci7
	 20OtaNOWya5cxQ4ZlP61QskzhkMWj75H5yOsi8ScNVa4+DBlMAdcZLZ1NDirwqa9rL
	 UpSPbFtxKg6dX0j0fSuILE34Spb8ZAYXlJS5PHlcWKe/iwbbv0Vkc9H+azXYwH4FMa
	 KmliST1p5qkow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/8] perf bench futex: Fix wording in futex bench
 messages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Pluta" <michalpl2003@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926190407.1106421-9-michalpl2003@gmail.com>
References: <20260926190407.1106421-1-michalpl2003@gmail.com>
 <20260926190407.1106421-9-michalpl2003@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 19:13:36 +0000
Message-Id: <20260926191337.3E6781F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When the kernel is using a different number of hash buckets than
> requested with -b, the message printed is ungrammatical, and it ends
> with a stale errno even though nothing failed:
>=20
>   Requested number of hash buckets does not currently used.
>   Requested: 3 in usage: 64
>   perf: prctl(PR_FUTEX_HASH): No such file or directory
>=20
> Fix the wording and use errx(), so that no errno text is printed:
>=20
>   Requested number of buckets differs from the number in use.
>   Requested: 3, in use: 64
>   perf: prctl(PR_FUTEX_HASH)
>=20
> Also fix "Wokeup" in the 'futex wake' output, which should be "Woke up".
>=20
> Fixes: 60035a3981a7 ("tools/perf: Allow to select the number of hash buck=
ets")
> Assisted-by: LLM
> Signed-off-by: Michal Pluta <michalpl2003@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926190407.1106=
421-1-michalpl2003@gmail.com?part=3D8

