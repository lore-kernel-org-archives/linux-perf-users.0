Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020184;
	b=mxyD3jnm52+Iw2GHLbrC/mM6NnMhyrcJKnWSpd7Zne+qMKOSzgZ44LvMay5n+qmk+CPY
	 rokpgdOoQqBK3ytz3NfuPe2ntb3wZH5gq28fI2CWzLwOgmXAe1J+iXL7fQAEKusFRjGcZ
	 IExnBkr/Z8EmwOXbRl274lYX3zSUs40wZ3dRVs1xU/hlb2AmMCtA7USf/MRad6xR7X53s
	 +J2THI9xbRG/eYUDqU8YMNHzrzZP8Vp3DiRKCnMNnWUHuyUQ14wEqTMO2BYQApiYiaG9d
	 7Vh1see0lt4TL+v9lKauzkWB2QbcdY62wallJMNJeyZDPaT5swFbCMu9VuEfd7Tm+6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020184;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7nzlWtrW0sz3FDTa1dDGdar7r6UjXb+UfY1DITsgoto=;
	b=bv3WVTQOofMzBNmvIZRa9QJLvOd4KoOfk69RnTsuU9O67Hn4hR9rReyVCsnif5pp1q+/
	 B7mMNJw3wbWo9SVNlqaREqQGpUDGW0IG+mS0kKfEXhGpN4xByk0vFqCr4QRwPypHPv+hH
	 IIYAyFxnagg2POypuzKBOfcTTnHm9o38RBxiEJMkAvRzIyvgdTDiKvuhxJGl+WWRtOyKJ
	 WZMMP2X6egAt6Ntmr6zJjPsEDYniPRhS53jYC/5EqXIGeb81Pf0prbF7PexIwxJ0qHADQ
	 6LUvNBSnJtBhJ2Q1zXuB+5qhmtSy52JDJFnpKeDVr6dcZX/bC1Zq4AgC5aXcBnpwN0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CDCVOs0b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B57606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CDCVOs0b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48011F000C4;
	Wed, 18 Nov 2026 16:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795020184;
	bh=7nzlWtrW0sz3FDTa1dDGdar7r6UjXb+UfY1DITsgoto=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CDCVOs0bYFRg4MAWNK+XWdES4aAfmV+yZg6xegCmt9VzznZoSiUNMiyYfBLhBShO3
	 qRfbEJDk6l2v0k1yhLKyIWx44ggqizk+yJaq2cKepooCyq5wbnRcYh9gxJMuULqzgx
	 sv70GjF8CICUexBekXDSYPqqQPZy3BUtwrebo/ZMLt8FYF7AhXrQerNCe3D3XhQnM7
	 4GYtxX95xFxZcMNSBo3EQfB04j3b6/hHZtxmx4WHvh403MPIXxMtxS70eez9Mwe35n
	 ujT1ufFpO0wJjYXcJOcClCyDwcnIS2QS2+XZ0r6pnijB+qLXDtp1iukdXHDIVOe6/1
	 SLgHyIK6eytYw==
Message-ID: <sashiko-outbox-221539@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 16/34] perf cs-etm: Don't buffer non-timestamped packets
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118-james-coresight-jit-v1-16-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
 <20261118-james-coresight-jit-v1-16-dad4d90747f6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:43:03 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> We're going to use the same decode path for timestamped and not
> timestamped, but we don't want to buffer non-timestamped trace
> unnecessarily. Buffering is only for searching for a timestamp and doing
> it when there are no timestamps only results in not generating samples
> in trace order.
>=20
> Let the backend know if timestamps are expected or not so it can decide
> to buffer or not.
>=20
> Rename pending_timestamp_chan_id because now it just means that a packet
> is pending, either due to a timestamp being found or the first packet
> decoded.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-james-core=
sight-jit-v1-0-dad4d90747f6@linaro.org?part=3D16

