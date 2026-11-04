Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793756188;
	b=rR3MNq/i1UNAyXk2gUMjoCWrZEmfW7CVByQqGn54jKaeIH7r5jmjwWyqFKSMPk8LPGSr
	 GMiApNQzRroZq0Os+Nz2laz/fRkeBj7VqOCMgqOi147nvWz0LEu3T3vSUbUxbTg8fcJmo
	 0k2UPpywF8KW68IM5UCSmToCyvueZyo5gQ95xe1x2PIQViQ34FF5IAmkRrEJYK2yUxXOR
	 xnf7CkjTNchXVK2aOkxDp1SH5jj1x7kS9XXZJSMEMd4z+ktoMc3Ml7ROsgCgYKmBVBOQ8
	 5Wl8Nmd4eJvILl8BNzhaC2lPaUfmAjfA7TCDXqWMk/R/NRIM1tvh8SUNzlJtXMJwi0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793756188;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9r1G8o9LX4h7XFjfUytn97xpRQsifOxouYNvXWuel3k=;
	b=2cs1fGIhpEGa6bJ5zGyCrMYVF0CmylVRMEEFMGNg0q6F7Ky87hvPUzRLXkbyBit93Mdi
	 oU1wGV7nYsekI6ZCwjGyBi+DBI5rOhzx6yznkt7C1bvu9aQf1D/GBIr2VnhYupD+TyHPf
	 Z048k0g42Gk3ub5ulNVpkRucfI99a1TuJJLX+7yopZoJnuw5kC36Vl88q5xPZwn48QQ0B
	 XmtiFrAP/LlSRXofU3eIWmosTUSPego5pCpOhbXhrypmH2PyPArQh7ECtyGU9d7Wv3DrM
	 x10XoKp6U+Pr1H+pjjDXn8fUw1I8BI7qC62A2dnBO560VD2LoazGvwADzB6psKIRGVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cVV3W2ul;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CDD606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 01:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cVV3W2ul
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55B71F000C1;
	Wed,  4 Nov 2026 01:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793756187;
	bh=9r1G8o9LX4h7XFjfUytn97xpRQsifOxouYNvXWuel3k=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=cVV3W2ul+sRIVQ+laMqlT/NdnPp+oHtcXnZ1RcfR/eBoAVXGRcyF5Y097kGCX7MeP
	 Ehf4fJsVrK9fooCLBAPdf2V0t3jUFhpZBZ4jHRTDmjYfSYNxAG1uJHKUGDHoSNPk2o
	 tAR1e7R3mTut28UOnIJ02u1fQKhz3muaSGuPIeHTnSvUmXB82vG0cVS4c7Qnb57tl7
	 l/pUnqdmCSKB9fcEaEj49+7b9KZcRP/K2y6S4tujqUgjS2DNPzlX2q2CvAPdvTsmho
	 Y6zrLCqQEXauGZveqLo3kmj2tdYcn23A1fB4EbcHTF5dTej3azXhg1m/RMiB4ybObl
	 eQWgVG5G4T2Yw==
Message-ID: <sashiko-outbox-196364@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 12/41] perf test: Add CPUID matching tests for other
 architectures
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-13-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 01:36:27 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Test strcmp_cpuid_str() for the ELF machines other than arm64: exact
> matching of the test and common tables, x86 stepping specific and
> stepping optional matching, PowerPC PVR matching, conversion of x86
> and PowerPC HEADER_CPUID strings, and regular expression matching for
> RISC-V and s390 CPUIDs, where RISC-V's hyphens don't imply an x86
> stepping.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D12

