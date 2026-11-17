Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946503;
	b=ElDjovjGgafvXhjtNZK+3YCulrT1OFcadlNqcm2hCqpAcLqvg3YUT1UeDSWCoEg4msm9
	 VYd3HcKjnlQcbZF1ENeC0zYQ1S/Y17ywwA/QKKCZFyO/HxzxXWtQZdcUfmBMrIBmzMZge
	 kPO4yZ6OrB5TU1d7spNW1SXZOXKzL7Q7zGQ/adeSH2ezPiyY3nq3S+Fb78fI0vasbjnOQ
	 S+3z2i97wZJVlSh82hhSUIis4BjKC4QnkihDdkBCvggYcp8kEGn0z2ieHN9VDBdWHi5fj
	 /ocYCntbn09pVLVdwg1VdxrbqWzygWaoAkm0oLyVRvmLvOskINFXL63l9K77+hIC34A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946503;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FR5mlwvJkUww5Y6KF6U7pgc/dT/0ZiKxlbdKEZOWtmY=;
	b=pLvBbL0uOs120GWIQZp32pz1a6/W0WR8ykAxhljehoIMznQXXA/DYQirnpXA+ohf/XiT
	 jw/ecaNFNWNiuNDZ0Ens9zgspaStb52crd2S2CBeU/vtyhggZ8xECT+akUiUtmICX+F77
	 I8cD+qe9PEYyrkgTF/ZqQbVTcakbuCzm9upotRRlb7mwmVaBPp7OQ3R3MGW5ZFyPUXOcB
	 ysm6Hk4I74jc8hD5ZQpwOl91tFj54ZFDmjWf3dgD4orPENZV9MnQNa0UqINCUVBq3ROY2
	 etRi9LvW81kxvXUn1L8qqEsK4uG7eOPmAVHNW5cwSSiDDA8IlT7d1pzmWXgmphBOmiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OuHtEZeI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBA4606A332
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 20:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OuHtEZeI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD1B1F000C4;
	Tue, 17 Nov 2026 20:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794946502;
	bh=FR5mlwvJkUww5Y6KF6U7pgc/dT/0ZiKxlbdKEZOWtmY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OuHtEZeI93YvgtjK9I3igxb79uYspF8xG+3bMN0j7kP6hDySUzqPnmkECb1hqbVpn
	 uMJOCRhG4GiB5/EcOQvE4qsyphcOUYLA7lNJnqwB6rvG2q6At+/pMS1IGUjgZ4VGDr
	 ypqR9y6l9bN+Etzd5hFhBj/KjC47UgPJ3JbqVEDVpsbHH63vU3meP3cJY+ZddKfkxv
	 gmKR65YKkS72uWfTEJB3n0Hz+WP9jxRLx3lwuzSxzkFPdYO3UOX1sk/GNyp3Jcp/BP
	 7v+Tl9SzeUfTXKXiiHyK4zNu+kPh2ElBtgcOQYrjjf9mJgJBckSkNEsod43Z4uvm3e
	 YFbBLJ1c2BP0w==
Message-ID: <sashiko-outbox-219584@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/13] perf build: Record the display-only features
 in FEATURE-DUMP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117200433.45174-11-acme@kernel.org>
References: <20261117200433.45174-1-acme@kernel.org>
 <20261117200433.45174-11-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:15:02 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117200433.4517=
4-1-acme@kernel.org?part=3D10

