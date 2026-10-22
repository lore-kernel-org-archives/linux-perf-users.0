Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700650;
	b=zpRIHLf+Kf3MOTkPGMc8cdzFNOJcipsUgluKyw1D30q8KncV2w1Z6xdLWnoWUdkgVkpi
	 slNCa1jy+bfLfTFTTny54EdZj4bb3qmRXTppA6p2N38pXItWpDs2ddE83nliRrd53pUWt
	 PEm8BnlXlBzKYP6G2RhRD3i4eDOKxhmGcQmdxapCzXahFdwZEAewWeCTpIH+gNHkNRhh3
	 NJ4N7B4l494umgpsFM2+xdDYEpD3JCijAN9iEp22kxeU1Cwq+1jXKl5VhxxUWhMPv6Wx+
	 lBj3saC4rc1fCi0+wB+E+ekdv1DruXr+dhacPm2RJ4t86tEhsqusmLrb1MS6ub13U8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700650;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ILZWyPMy7YeAtx299nxcKLMcvVtqvrtSaXbsooCBv0Y=;
	b=pSDsVhirY5rLismlqFfXrqvGKrlywZHqYAGR0UPmZMJn6nbtOwOJNYbfVwD82ufCx5fd
	 ye7AGx+E3zrr+Nc2jR6dixvvXXbUtukr/NiulfxezNb8cmqLf1eyqalp9DMh4wdxfJzOZ
	 BO7qCPqC8aHB3zZHFfegmFht+f+AyAqfIThkfMamTAgMDXBUHWXq4NE8VQn8zDUUJpi6+
	 vIq9g4JgLhsuF/Rbau0HdPdUXIB2f2RH93COI/7iaDw0IkbaOyJD4BZCjzDCIkQWqUpPD
	 pVWVji8HP9fhAdR8h+Rhh2s9pZ5FR4jHY7FmnJ0PxlNu9uy1ILBQfUuRgZD2P8T+5YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ypiu8kSR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369FF606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ypiu8kSR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFFF1F01825;
	Thu, 22 Oct 2026 20:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792700650;
	bh=ILZWyPMy7YeAtx299nxcKLMcvVtqvrtSaXbsooCBv0Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ypiu8kSRKyNKCDvAA55y4kBl9wYU09ZL5yn+9Ip1uAgR9Hg2a7CpmXRfLy8Ow6L1m
	 khzkFYX3xBQ+xHZbKE4VkpBjqONduZAW4yZ9jSwFp35ulp5RH9SuzBTrJF2P+Eo1h4
	 f2VpnfhuaEqtvQKAoCWeTW8Yh6hoONcFNV/PwtOyvsrV7ASVBTT1bKaVsze9xNWB+p
	 B0uk+08bTkO2OV/X3gk+OS4p60LrKScRJ2qH56uUUsYkyMpo0sxER889QE2hM5Bqxe
	 rm8icpI0QtP5XVsAu/M2eoMvU2XKohy/H/LAOCAqf6Xk3nODaurc3St7WYD1QxLfav
	 34FpefiPqfYcw==
Message-ID: <sashiko-outbox-181993@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 03/19] tools headers: Synchronize
 linux/compiler-context-analysis.h with the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022201453.1717523-4-irogers@google.com>
References: <20261021223905.715051-1-irogers@google.com>
 <20261022201453.1717523-1-irogers@google.com>
 <20261022201453.1717523-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 20:24:09 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Replace the no-op stub tools/include/linux/compiler-context-analysis.h
> with the full kernel implementation from
> include/linux/compiler-context-analysis.h and add it to
> tools/perf/check-headers.sh so future changes are tracked.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022201453.1717=
523-1-irogers@google.com?part=3D3

