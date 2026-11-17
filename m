Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794873613;
	b=vfuypuowsWgZjT95YZYCjku+VVDytK2EbAcGxpwOIqItMwOHJ769V2kwu4pnW97NLgpN
	 UNHIvoqQ/xW5K6pfAEMoMGpw+ng8KQbdIcW9BLk0hO8DFcHW30qn6rVu6QxTMsRQ83qY1
	 n8aaPl/NIZQ9JYDisLQVhlT6AlvUeICPNGiVBYPt1XZ8cXHMQrngk1kg8jXOOvhD12o2B
	 1S0BNcV8gLYyzJY8BRSO4Rp8rr3+eEeMV+Fpy+wxKVkSYgm9a4CE7tgwWYPa/I4CpEIIR
	 Ya0fIgnxC5VYJlwbE8SyKvwqnUMHOiOP/bF3Sbfa94kEKhZ4V9aw6SrrQqA1who9HKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794873613;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VrWp+i75av5V6DsdNdRMOj7tb4uWfyCDjgtiQALLmag=;
	b=z76ZnQ6nJh3yhwiWu4Uu28gx4YsWh/ONeoSQvxv4v1nu/Do5bg96xRy9uKgDOvri2gDK
	 cJT8XnoSUk4WI/bEy90ya3msM1u5B61cevpFGC47CnGW5IJExe7K1kxouaa9FKuZBaGXc
	 3xJes+QBihj3ac+6EOnMkRWZryIQAc7UCRsHL3ZfcKR+O6E/DTITd9lMct1JV46ibgeIx
	 VDbqTk3tDXNP76dfCM4qyETJVCj5sYfkHS0cFz7Z7I78UIBLkB9r9xtEcaTtUKGfM06Qz
	 u18DrebRpkGnm0T0VIjj+xCcwHA1jLE8qs1VzXEchhb6YxE515Q1VVBt9FXPJns+p7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EGlrSvr2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787C9606A333
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 00:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EGlrSvr2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44301F000D1;
	Tue, 17 Nov 2026 00:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794873613;
	bh=VrWp+i75av5V6DsdNdRMOj7tb4uWfyCDjgtiQALLmag=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EGlrSvr2TFXO5aFtX9tBfSEogAJLQ3wrBw4Kd6IsZZpSEKO9YOV6I5b/n9ErMDCK1
	 j4EDDhnZ/nWHBr9eCLUrex9Due8c32bQ7Vha3L9qa6Jk/XQ7uxsaOgnILJErkXJt/x
	 Y0kbfc/Yszlbhuc2sQ0b0Qya+ybiNmw/EEtYPUBBDE5dyA087i7rp5x6zevkPxVxXJ
	 95DhkCU4ednQgPbTp1lNePlqMnGfCF2+Qw2LNJw54C+3rZYLZHagLh/H6hKkT+4rsH
	 abVzKwfmTFo7cab/6gk+ycwLgCjftwS7DZJ2T1k03d8YbZZVqj6Rjo64Z7H0I6D/sm
	 eyHMVHsHnMFXA==
Message-ID: <sashiko-outbox-217962@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/12] perf build: Record the display-only features
 in FEATURE-DUMP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116234659.3950531-10-acme@kernel.org>
References: <20261116234659.3950531-1-acme@kernel.org>
 <20261116234659.3950531-10-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 00:00:12 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> llvm-perf and rust are in FEATURE_DISPLAY but not in FEATURE_TESTS: they
> can't be part of the test-all fast path, which sets every FEATURE_TESTS
> entry to 1 when test-all.c builds.  Since FEATURE-DUMP is written from
> FEATURE_TESTS only, a FEATURES_DUMP=3D build, as used by build-test, never
> sees them and silently builds without libLLVM and the rust workloads.
>=20
> Append the display features that aren't in FEATURE_TESTS to the dump
> after the regular feature checks have run.
>=20
> Fixes: 206dcfca1f5cfac3 ("perf build: Autodetect minimum required llvm-de=
v version")
> Fixes: 3f5dfa472ea6771c ("tools build: Fix rust feature detection")
> Cc: James Clark <james.clark@linaro.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116234659.3950=
531-1-acme@kernel.org?part=3D9

