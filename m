Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795448307;
	b=tmeGZDR3WY2hloKXZzraCUyd4r5DuV/88iP/rOD+oXnK6kdV1VuVbjxB7E/2qWcb07Y4
	 pA0BBGjMZo4sJqhijS77dJAg/uJXxAkyl1n8lDArCtyoonJTxuhtYTni4dCTYdaMMn2zf
	 nJP1uYDZRnrJd5WDHTkwYam4d1Zlf2AS0SwoPitS7wC79wsHguLlSrFJmV/0Kf/hsH9R/
	 nhdUc4Jper+zwp4VEswE1sNneeYJs6IlXHc07fPzkEGxR3dJWdXb6M9/k60hJN72CwFZg
	 2NxkdDhTgucmzi+v50M8d1qmFMwDP+r27AjXxmJpVhboAy3VILnSfMae5JiMb8otGpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448307;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ddZ9CfQecO3xHWcpvvm/NLFhTfXcEXYmmEbAw8FaOtI=;
	b=OlQeiDzu7CadlfJFHpriSjt6Rfd+Ckxkxft27hrjYrYBresJp5cEzpx6bmvfQwMmGQfH
	 dPd++PnWGE+NPculDquiNDolpYrzNdCimZHyqXHt5qX4lvF6+XOYh3aOYCx7ZztmK99Sy
	 N6uiBIEvS/iK+QcR5fSVIh33E5jmN7tCzV1XLpVQfSq5L4MK6gKkSAiDofLqRaSq2pOG0
	 +6YxCsGWTwzSwtQPIhYwv6FXWXTrSl4bIcA8voL0gpUuFrCN27seWshQefovCjYzCgZEV
	 twRxVuTUaIYLWIIJnneJI6tow/mfnjrJ6m9z1kRUy7ccyTJMGFe+b9H18eM6zoTFsfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=krhI9ym3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF508606A31E
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 15:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=krhI9ym3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550D61F000CF;
	Mon, 23 Nov 2026 15:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795448307;
	bh=ddZ9CfQecO3xHWcpvvm/NLFhTfXcEXYmmEbAw8FaOtI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=krhI9ym3r+kM8n8hXrCF11Zu9ONPfgxJpdGtsXCwxGfgMpz7ShcghiUcuwqwzIo9J
	 8sKpgIr39oFgJjN4Yumrp/NTzL73MyT+PgDBYzbNTDFFfYmMkqT3mcGpswrj/6luK6
	 wDJ3ILDzpUsxX8qDWzg1XLN2qa0Ud5vy0YvuUI5YzYlx0yI94fmPCV0cZ6vXhqr+Lq
	 2XkId5/H5k4j24U7Qvl0EJegPEZfQvgi4LIkwkx8tsVgE6zJ+mJHJTmTBKAyz3i8uG
	 YYNezckqHOrZ4LPCfxdwGIgUJ/JhKwNMnNELV1NtZIGCsh3STVUGMBjxO/z7OdxUcB
	 L4BdtHVg0+Kww==
Message-ID: <sashiko-outbox-229587@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf test: Fix race in "Event re-armed with
 PERF_EVENT_IOC_REFRESH"
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261123-james-perf-event_refresh-v1-1-571efa5395ab@linaro.org>
References: <20261123-james-perf-event_refresh-v1-1-571efa5395ab@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 15:38:24 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> trigger() is invoked without blocking, but the test expects N events to
> always be received for N triggers. After each trigger, the event is
> disabled and only re-enabled by the signal handler. If the next trigger
> happens before the event is re-enabled, then an event count will be
> dropped. This is possible because signals are delivered asynchronously.
> Fix it by blocking signals then unblocking while waiting for the event
> after each call to trigger().
>=20
> Blocking results in a 1:1 relation between trigger and signal counts,
> even when there are extra page faults, so remove the comment and change
> >=3D to =3D=3D on the final test assert.
>=20
> Timeout after 2 seconds because we already know there are broken kernels
> for the tracepoint test, and the default 120s timeout would be annoying.
>=20
> This fixes the following failure seen on Arm64:
>=20
>   $ perf test -vv -r 30000 -S "Event re-armed"
>   ...
>=20
>   ---- start ----
>   test child forked, pid 1087
>   1000 events, count 999, 999 overflows (999 POLL_HUP), re-arm errno 0
>   ---- end(-1) ----
>    20.1: Software event                   : FAILED!
>=20
> Fixes: 3dabc8ad8ae0 ("perf test: Add test for events re-armed with PERF_E=
VENT_IOC_REFRESH")
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-james-perf=
-event_refresh-v1-1-571efa5395ab@linaro.org?part=3D1
