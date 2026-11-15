Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794707363;
	b=2dg2QnOPNO/8Xhpluyc0NUgspO/IAzX90RiXi6rJEux3qF/hhC0ufCiQGbRl5ZpRyQya
	 9LnnRwgySgxZmfIFtAnb2zABApdV25QiQaK0DAvbzVRnHt8j7hnzeEwOnOmtrmMgoiapm
	 +fNV0kc7tVvMKCXoKmtxA/5PILOfeuXuD9/C5S/3X+eu3k17oHdSoXxkHD11zVaIcQW/2
	 ZZF2SH32v3MT2rjq+sjB5nxmkh7wTKRVHqxAe0ahq7YezHl7K8NQmbqW3PpJlLUrdyI2C
	 fXXeiO+fhFRRj6fKcZIvET6FlSNdWa1ZfAddtQTLhBwPbiyw0HwVkF8MaPhg8emK53Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794707363;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JeawTJNv3mgSApKH3AVUl4y3J1tRMOC6KORngITCOZ8=;
	b=4EXUn7usjG2dKstKRyEiIwl3Z7s+QFT1I5ASmlwycD1T0gzmJksXaaL8njn/3jwgrXG9
	 l5MSiy5uoO0XS/QLynQHb0wQDFtf0aJswCLvw3tlXs5gayDuCbjbljLHlDUq+rgGzgr1Y
	 MemnISzVOTuypLm+fTkdOSES5Q+kER0DBEFdRn//cK/gH7HirkuTZnMFOqs8AqXdYqX/p
	 3n9LITc2O8o+w/oBF2DQQZwsTZciFcHnRR9Qi6C5sP9hSSY2rXR/ffMvN7fcelH07AFbZ
	 WvxKEaQ4ZeiRSQ5PodQ9XBV+CiRoTHJwVs95Y9nw2kQudpomSVAVPQc2V89W6Hj8jdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gZA45yzZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CD2606A32D
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 01:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gZA45yzZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3158B1F000C4;
	Sun, 15 Nov 2026 01:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794707363;
	bh=JeawTJNv3mgSApKH3AVUl4y3J1tRMOC6KORngITCOZ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gZA45yzZQ0D4Ru66fzlrWYjSh+Z1h8jSpWx0nofAI9mujgOux68ztuooR5McBWvli
	 WeDSwKA0Kx0zGmswxDdo7QwFDTl0AXkwPTdgO4vJ1sdsd1EXEC9OjvI3wSyek1eJiG
	 FjETdoYlvE289nJKA/uFwUBZFT+/m44bChCBCvBDd60DpnGOlHLzBkLQ1Q5MTaHHLP
	 e9EA6adGQ44Bi/3lELaqw8BzTuKak7Y4AShDnytZoXMAftTnmkrtENwwLOyixoUrDh
	 p74fGiIttlb35mdXTZjuRxIhQpuZ4DQ/iGBdOAnOKPBorH0Kx6XjiKbYrCxDzOGPQq
	 ZPaKLGEnpCPiA==
Message-ID: <sashiko-outbox-215173@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/12] perf build: Record the display-only features
 in FEATURE-DUMP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261115014102.2879372-10-acme@kernel.org>
References: <20261115014102.2879372-1-acme@kernel.org>
 <20261115014102.2879372-10-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 01:49:22 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115014102.2879=
372-1-acme@kernel.org?part=3D9

