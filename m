Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584044;
	b=zuBH5tui2xznIt0XI9QqUK54UO8c8ZgEP0EdLmpkHn93zICBYDGGu0YbYCjnkatgif3F
	 YCQoUi5hbzL+Nvi7RBYQz692HCxARDvokiBG8U+J3RisuET09bMo9vAqQusqGrIFpDqIm
	 VBN55/J4sAP12qExp/0Gyf+M87MLw/VcnxebVsSDtxZ3MWJKD8JXCGp7nPbJs80mOEyct
	 /Xb5ozBUl16aU6NLhGFL3e/lFODZxWmGWYP+Nhmxi2re1rnLEdscujNOs90YICIz3+9nv
	 qag/uihnZf/VO3a5jrFG6Wo9593BK4DcT8kVCAeDlE7/zwFZlwQZHxXcSy46nVOEL7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584044;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=e14dPWpcyIFv0jJRc0wOqj+LV16TNIUxx0iM4bu5JH0=;
	b=hanQo88Yp3wNMsuJ6cql4NgJmBGtnIdGWh6OnT0LDWAuoN4TLNiUpFDUHIxqayFxUUY7
	 0VQHFFEOzh3vL9IIvGPhSL5FOpT8T3XdR/oCgvUj0959ctRKbYuK97HwqI/zKV5K/QX32
	 oZPuQAazD5TsERpmlVw/5yA0eUpC4GUSNb9CvyY9ZofaTjEZ9xsaR/A9WDp9NpIiXS8LK
	 UuOIa/mRgGt26zDYZnQvxkFmgAbLMA/XBo0DCtBmW1F19kAAY6O5f8sMGbn9X4fDgtjUX
	 tdTI0VWO01/lIUC4O0ixm2h0uGPk0t81Eo7kZO9wEZWgQi7QW+z6+vSXAR2xewEXA/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZI6wpcDT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90DC606A327
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZI6wpcDT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976E01F000C4;
	Fri, 13 Nov 2026 15:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794584044;
	bh=e14dPWpcyIFv0jJRc0wOqj+LV16TNIUxx0iM4bu5JH0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZI6wpcDTF2lO6T/QzMBwArS66fgYqS6P6nMkJ0HIQX8n4BHl38AWRkBCZcXwzIc28
	 geB3fD90tdPmFDQHHRrJfGsALW/lxoqI4XYmSd2SHn6AewBRXYcDXGvRkRTrI1OAKE
	 0buOIx0VzxLQ4FfnXs9dbzi3WYUobJVpzggsRfj8ANfslFcNtLIVegu+PjbfzD8Xie
	 jyFLbFA84jCEQFh7K94KTGmc9y/vkoHadcukXP1zcJdcmMJKG7oelUI6gzoWDe9fkd
	 ZSx6flJFsi3STapRfvHzvOz17V1f7F+gKPbcYYmPvIyKqHt2RJSmqJDjPWxsuNBise
	 ObG3rhviUpurg==
Message-ID: <sashiko-outbox-213098@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/2] perf test: Test perf timechart --live
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113152622.1991001-3-irogers@google.com>
References: <20261113055926.1159033-1-irogers@google.com>
 <20261113152622.1991001-1-irogers@google.com>
 <20261113152622.1991001-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 15:34:04 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Alice Rogers <alice.mei.rogers@gmail.com>
>=20
> Extend test_ttimechart_python.sh to cover --live option validation,
> LiveRecorder's perf record subprocess, control pipe and -o output file
> when system-wide recording is permitted, a synthetic live UI test
> exercising the rolling window, pruning, pause/resume gaps, round-flush
> framing and zoom/cursor following, and a live workload recording test
> when scheduler events can be recorded system wide.
>=20
> Signed-off-by: Alice Rogers <alice.mei.rogers@gmail.com>
> Co-developed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113152622.1991=
001-1-irogers@google.com?part=3D2

