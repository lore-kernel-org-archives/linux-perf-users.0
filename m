Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039494;
	b=L3vblRb2pgnrrl/dyFe5wFGgyRTPDtPwWxjTkb5kjJBHq7abREvSDBodhmBH1Qj9Zgf1
	 CbJ3Sq4a3P5chU429/RnVEWe5Bnt7WbosCKtjoHOclpdqRhWTM0eiFi1wN4QzVcJciSc/
	 TqP1QiNuWOvNl+tUts6KNoHbnI26k/8jjGs4jMW3KpRI7x4uzIaNYCOExGd+PVds+z6S2
	 YYE1FK00114aqgyIDc+i/63qaQPA5ZjosRpU6tSfshfc87XbZIBLt9RQeBYqucbToWxR5
	 AK8UEQAeNF3zus/XipDpCFKiSgJQSv8JAHyChbJhJZabNohu0BCqU6Zsrx8LVYy4Byw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039494;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=h56j91DeNtODpRx/XeX3sfOX+GjSS5BVbN4f06oxIis=;
	b=K4U47oKLfWyjuN2VcgksFkXDnb+rHiG3SnbhTCCSpM5C1AKQZIm2oikYRNKAT53QHhbS
	 vBn8/flB2hxfwgKNpNfOYQNOWDkm/7FqeqtJSuvIgM5V6GjWJXLVlP7rbRFa84dUaGStW
	 PEJrbTSFxucuL/N3tj7Nv9G1w4c67WzDgFOZjOhT9g9hDrJIdKTeqT5Caxh6hHWMUx8vq
	 +W9m4fZBrhBDDK8zxVJ7LCEdOVZgh7uLOfB7Tg2j2EeHDBSeiqQacWaDPwsFEa+XSp9pQ
	 tM7LppoCnwEdgwSWkzTuFBcMqI9QVPZJbpfNnY2C56BFWnLGGqbzrIm8UxOfpCWNwMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LxONbHaF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFDA606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 22:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LxONbHaF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6913D1F000C4;
	Wed, 18 Nov 2026 22:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795039494;
	bh=h56j91DeNtODpRx/XeX3sfOX+GjSS5BVbN4f06oxIis=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LxONbHaFLS53jnm+VfDGbnq7qx8eSpT8D5xG+UHnpuBX3bUrrYc3Ncux5VkEUukz8
	 MgZV2enXZvmO09Wl0Zr0L8VRS+/MwqO/9WTKCaXpUCX7tHTdyQO1VK6+Lp232YBIED
	 c5JbykmVfJXiJfpr+OrJVvbW/imBhoudWZD7evuozpDGnNup41oJoNMWgsB6C+5ai6
	 DwwsElzOw+zn+JdrBQ8VIf1anljvu6nhDCxaykpSIWo0No1aeGt42/IKRyYErqlexr
	 9LY3bcBIY/gb+tmTvRbG2Nrmey8T7w7S7sYIqdYy9jf0A/RgT3rujlhyceyruHKmeB
	 QJ3JZ+w5R0uRA==
Message-ID: <sashiko-outbox-222075@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/13] perf build: Record the features checked
 outside FEATURE_TESTS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118215716.114868-11-acme@kernel.org>
References: <20261118215716.114868-1-acme@kernel.org>
 <20261118215716.114868-11-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 22:04:54 +0000
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
> llvm-perf and rust are in FEATURE_DISPLAY but not in FEATURE_TESTS, and
> jvmti and jvmti-cmlr are in neither list: they can't be part of the
> test-all fast path, which sets every FEATURE_TESTS entry to 1 when
> test-all.c builds.  Since FEATURE-DUMP is written from FEATURE_TESTS
> only, a FEATURES_DUMP=3D build, as used by build-test, never sees them and
> silently builds without libLLVM, the rust workloads and the jvmti agent.
>=20
> Record the display features and the jvmti ones that aren't in
> FEATURE_TESTS in the dump after the regular feature checks have run.
>=20
> Fixes: 206dcfca1f5cfac3 ("perf build: Autodetect minimum required llvm-de=
v version")
> Fixes: 3f5dfa472ea6771c ("tools build: Fix rust feature detection")
> Cc: James Clark <james.clark@linaro.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118215716.1148=
68-1-acme@kernel.org?part=3D10

