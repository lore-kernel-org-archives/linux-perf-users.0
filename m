Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020053;
	b=TeuzI2FnlyMHi0Hffl5778V6Mi9aFhACTxXmw7Dfww8Q9somGwRZA6XFLQkqRkULEXvu
	 nGdMCqZjGdbaEukmooEidaq4OzlbcTKlWTXJTphmd3eNY1kO7J1TkM1FI2QQjc4n4kqoC
	 YCjpVK9tD2rW/FJdkXv9VlVqKxBPt5UKJKfDOSsmnmBH+Oycot/TR4d7fBSkmbhdkjnkD
	 TotpRwtqezOgMdMInoF9IIvD4EyhgQ+6X3Ikm59MRsgaRoIpZldu6tPdLNHJl3HTFBmXD
	 70nwWH2RVihdfzX/ruUgJKeA/sOGGZR+aEc5+avosCfCukTJ2Q+T23CY3jlf2JDcwfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020053;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=u7B7CNYt7Cmq0paDpM2w6ycgZbZCfF4BHEZ2mv6RHDA=;
	b=yFIL6GOkHPGM9oRBWnn2ZEaoN0QP42gPMGPFGkwszzIDSjT13JwBKIkcitghdDDQF9/L
	 3hQOEbrY23dxaKtI6DbXYaE4lv/OK36RVWK9aKK0+jw74CU58oT7c2HSfGOjNwx4k8zya
	 R/oQaj6osADfJnhz25hhTt5ge+dr0fgzSbWQeTg0zyM/lKMk+5lV/Y6z55x7g9yB/Qojz
	 hqFR5OxsLRAmmzbbS3Cj9jvYu1hMHF6LJq2NT7KvyT56egx4HDsaaKvSJe3ruyesqr7kr
	 s5gCKXzJ+UFp8C5ure1t+PdDgY2hy2Aqi5RY0OwBa0I1HWYMidlZzuqzTMlvTPcQFTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kq1MSWQK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E5E606A320
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kq1MSWQK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD841F000C4;
	Wed, 18 Nov 2026 16:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795020052;
	bh=u7B7CNYt7Cmq0paDpM2w6ycgZbZCfF4BHEZ2mv6RHDA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kq1MSWQK/T4cToGONlM09NolRnUNWGtbCbPkN5kiZcDbsQdTW4ENd5J9k4pVAUpX8
	 SsOhJeAeGCC0IFgHs8+F9C1W5vquU0jnKezRAldTIFb0ZjynUyn8/+yFfu0uv+iB0x
	 99zHSs41WtoAPtndwd9V7rStco4Q5kWvOIVCZIy++7Ap71DrNy2yKNYf5S7ij6TAIE
	 d8tvNnazmza3CaEboosHU3mqz5jSmlTO8fvshV7GupGskN5gK8juelyaWfzE71T7bu
	 iNTWH5nxBNQ+qWtMKFtNB1+w1AVQzguqNwhXEdiQLn89ED7Pbn38Niygo3Hygu66zv
	 /mubBsG4PFI0w==
Message-ID: <sashiko-outbox-221528@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 18/34] perf cs-etm: Don't special case per-thread mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118-james-coresight-jit-v1-18-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
 <20261118-james-coresight-jit-v1-18-dad4d90747f6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:40:52 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> This was always an extra edge case to have to understand, and keeping it
> would require another new special case in the following change to add a
> timestamp decoder tree per trace ID. Removing it makes both cases
> simpler and nothing is really lost anyway. The only change needed is to
> seed every trace ID context with the TID from the AUX record, rather
> than only updating the single special context.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-james-core=
sight-jit-v1-0-dad4d90747f6@linaro.org?part=3D18

