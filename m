Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792746545;
	b=cXZlFGMIhblEqTcdjYaZkz8RQAHCrnsMzXZlyIqacrin9tcqbUXrnlOlxRtjK+ducZXi
	 9UssS+G9fpISou155g/Al0MV1dkFYm0xGP0E1AU8WBPTRkdKefZ7/r5+csByV/KfhElKJ
	 6zqO9kxHzKPCb2hj/BEswUPoe3cIMYcfVWzyctx2Sr+gsPbCoCzjxdMfxYiZJWACoyIFm
	 hlVEaIoBV9jRQPlnbhHwNMbWX+i8Q3MZKzcGvFmXajgIHiWHkJdfyJkTDwUB82NWbMyQ5
	 A0Zz1rUh2k9+sxaaCpUPIV3Ypw8vdlLXWjljC9l5XoTFd8gmqYqsuQl6KR+EeSYOVmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792746545;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mZCTGnvjSCznyPwCD0X/xi6bxO3weaMlBf1o5RdjVXc=;
	b=XwGYtjJUjdjYXkptVgTuplB8ybZZmPps9/EMBeOd9IPKkdyIgcIOeSNA04A/P1HutJtp
	 QKScs3RNtaIh1Jp4X4oa33vth+YWU5dAzRGjDKN0/6MARyDt/incnWS5QLwLg7GKr7WBM
	 NnSXJVAvLqdSe3noemdM0gZiRhk4uXKhN1Xo7A5oVGCzrfDM7KlalWmlt9FYfnIKZgL15
	 zO5oGMkhC7uEcFR9qwpXdW2ZnwPMduv0HSUjSmw5rObWi7pkpNvNnh/QpWPiIZH9ypeKZ
	 DEOEdaVP9zbooyryhJ1L6m3VloPfqb0Um66XaVgEoaJpBbQZYlaedctFh+mZ03HXn9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Li3Ko/jA";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36CD606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Li3Ko/jA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C581F01825;
	Fri, 23 Oct 2026 09:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792746544;
	bh=mZCTGnvjSCznyPwCD0X/xi6bxO3weaMlBf1o5RdjVXc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Li3Ko/jAIxNvMOoQRpeQ142ucGkle+hJocjvy3YDUhmrNs7LI3qiju9RIEBHHsuhE
	 c1FfMBxw2RZER9vfhf6GJkorbie4EhhMaI/6QfZtXV5fA8LKAh8Rqs+KsyMWMN2xII
	 GQBw1KjLFNigfUWmo00IJCNJp4lFds4Ym1/6VayPlfn/NlqeHZH0+dBmDdbpCRzrer
	 Tpyx/ZQE8i7SecTdRLy+RU1Qnrvm+lGORammJFpgX+wpzscxl804TjlvmU3W32Of9B
	 RS0nOtNFvfHniWafRsJ9sxCdfGoeE8pgXfDPmX94o2AAcCHJXfjeeaEIGjs3sF426G
	 VvA/blpTnFPcw==
Message-ID: <sashiko-outbox-182559@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf test: Add --skip-name to skip tests by name
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261023-james-perf-test-skip-v1-2-b6c11bdafd46@linaro.org>
References: <20261023-james-perf-test-skip-v1-0-b6c11bdafd46@linaro.org>
 <20261023-james-perf-test-skip-v1-2-b6c11bdafd46@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 09:09:03 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> --skip takes test numbers which change whenever tests are added or
> removed, so a list of tests to skip in CI has to be updated as perf
> changes, or it silently skips the wrong tests.
>=20
> Add --skip-name to skip a test by its name which should be more stable.
> The option can be repeated to skip more than one test instead of taking
> a comma separated list, as some descriptions contain commas, e.g.:
>=20
>   $ perf test --skip-name 'Add fd to a fdarray, making it autogrow' \
>               --skip-name 'Simple expression parser' 7 32 33
>     7: Simple expression parser                : Skip (user override)
>    33: Add fd to a fdarray, making it autogrow : Skip (user override)
>    32: Filter fds with revents mask in a fdarray : Ok
>=20
> The match is exact rather than substring so that adding a new test
> containing an existing skip substring doesn't get skipped.
>=20
> A name that matches no test exits with an error so that a renamed test
> isn't silently run again:
>=20
>   $ perf test --skip-name 'Add fd to a fdarray'
>   No test matches --skip-name 'Add fd to a fdarray'
>   $ echo $?
>   234
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-james-perf=
-test-skip-v1-0-b6c11bdafd46@linaro.org?part=3D2

