Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECB752CCF2
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 21:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789766865; cv=none; b=MAH/Zb4zsYdXi13pckdkSvvgvGee/AUaaJh4OP+3PtCWmW3F+MLtwsyv1mtGbFfFmK8LPq7SJ2nm1340gxOmm4FrYLL9GAYxV7AImGRKr4QXANezHAgviShovVCKgevKFXDDxaKUNPB3ciu8ncE0h1O7pPnBCyzn9B944Kfv1Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789766865; c=relaxed/simple;
	bh=mhyt51vzh5zFh4qmSF+WIOnIZCsGpJhnxu+uzCjSsb4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Au198n4kg3FPNiOv3qDN9CjHq4WSroziYYvd0z/JdJyJDHLczchhffBCCzj6s1rUwgbjQpVTssElzMP0EwHaXnytjyR/6ey939zmajsBJiWili3PbH5hEOOg3uIHp/mTOWSUJCVRpgtt3IyrQEYad1+nrVCLEPJUW47zAdhZucI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPDqS4cF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPDqS4cF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6B71F000FF;
	Fri, 18 Sep 2026 21:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789766863;
	bh=mhyt51vzh5zFh4qmSF+WIOnIZCsGpJhnxu+uzCjSsb4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fPDqS4cFfR+dQRGACnm6N9a15D1m2JL1h+LZ/MbmvItOrJn7FeD8in1GeYAsFcPm5
	 PcCeut0uV3d/zPOIHzGBDVuqDTtjYBs4Yyf/mInZdFdAWS6w5VLX0/fTjjCKrkx4uk
	 jAcyQfBxIGOBlJgfHp2iattTh4jzS6vtq9dzXEaDBcu8vSCibQTuothdP5YUSzlIp+
	 nK3YMryEmG8gQVxU7rTddPAbKXe5ntvpWYoqiXiCIzXOMpdwQrS69pAHxJrM37mqTg
	 FASxrxTf0oMYWkaeP2CybEAJv9OJ5BiRIBwMYMWQblTK58k5oAgtrjXP0vaI1l6sut
	 glNn6dR2c988w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/18] perf test trace_summary: Improve error
 diagnostics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918211932.2966061-16-irogers@google.com>
References: <20260918140659.2501976-1-irogers@google.com>
 <20260918211932.2966061-1-irogers@google.com>
 <20260918211932.2966061-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 21:27:42 +0000
Message-Id: <20260918212743.6E6B71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When pattern matching fails in test_perf_trace(), print the command
> that failed along with the actual match count, the matching lines
> found, and the last 20 lines of output to aid debugging.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918211932.2966=
061-1-irogers@google.com?part=3D15

