Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114645;
	b=nwWVIpi130deCSU4qsZaX0Ywf57LWY/PerOhgCJthah/nxUcvY5eEaU9WIJzZUUdLpEZ
	 rtEiVVWcJ2b2tnGocdj3jQmVBG2fP7b0OS9iFyigp/cRf5EfJ2+c+R5+pt5NhTbu0AJMQ
	 2ITVgP7UFHIFR+uszhrBuk531uR2XSh9oRtZ1+aHYd7hyXz0SCcGWdVw2SV43aO3YtRPb
	 b2W6p7PPrwo/bi/G4ZweE5w8XKymgCIav+cXoZS59bwG9XnFK3R+DO8FnZhEEFWnx1PXZ
	 5tnBLp6MhiPAlpx1X7Wrb9CmHJ5eru4ISgakQ5T/vasOVr2eqFfiC9QHKaG8gVbAwvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114645;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1oarGNlKCqSeT86IKs108Vff1TJeiBaWAK3mX8A+vp8=;
	b=GNSdd5SWtPfHRF273HufSl9cZoP52ynbT+OaMzCoTWcCtREuu4phkYZTbUKhsegjp1ei
	 z0aBe1uPNM3TfFtJ3YJNRFN91SSQjY6ALxXGa6JRrpOmsk5Qdjh33slPQv3RpECmGfrqP
	 OXJidfTUxja3RbgxUu04gwZa3FqRm+PhSICwh8wzI3YR3yCTcxH1CjdHKzB/bWYrr3MpW
	 Wq1AS8f7bzRlShUer2lzdcfh08tWH8LTMx+V+DiDKjUUY005Sy7Qs620cTOJugbm6U9LS
	 TgPzOZYacOB2h7M04us/rDtHrvbbDtV/AP4dqxaXkF7vQC4As6zQF7fR3UDZ6zrxngQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XlO7O1Ux;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1A9606A320
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 18:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XlO7O1Ux
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A594B1F000C9;
	Thu, 19 Nov 2026 18:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795114644;
	bh=1oarGNlKCqSeT86IKs108Vff1TJeiBaWAK3mX8A+vp8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XlO7O1UxV+V4gjq7nxjy74vHw4NDxgWarNDcrd0y9e16X/E6RPUIcV1DvJ1zX4CLN
	 JMBnADVC1sok4JTfLhymtDsBPDRTB5hIZZueDuh/86t3zZ3sQvFcea9BXMmTAxjyhO
	 afoSmpAC8w9/yYlIAqZ4PfqfmGeOAEbBiAdqfgpA4j0xWZN5FmNOXfIFsZIXWCnTLu
	 tQRShsFasZNvLRkvfYiPI36fVyFG/WKalMbi58LNwfBM73U1w7UajhD45mpAp39Qeq
	 c9Mx2xaGvgwMCvtGNmb6wK4NneW/jB7TG59m7dgKwnKW3kchURjpIW7C/uG1NyYfWK
	 WLcsuGfujR07A==
Message-ID: <sashiko-outbox-223813@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 03/33] KVM: arm64: Reorganize PMU functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119185215.632334-4-coltonlewis@google.com>
References: <20261119185215.632334-1-coltonlewis@google.com>
 <20261119185215.632334-4-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 18:57:24 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> A lot of functions in pmu-emul.c aren't specific to the emulated PMU
> implementation. Move them to the more appropriate pmu.c file where
> shared PMU functions should live.
>=20
> Tested-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119185215.6323=
34-1-coltonlewis@google.com?part=3D3

