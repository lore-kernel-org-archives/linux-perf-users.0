Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E2449B20D
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791298973; cv=none; b=CHdTCCY/iG4z1X3i4Ex+kzQzjnN620Pd/AGIjhiDp8XBy18owSrj6mjYqx1elHYIy8D1JVMZRZcDJ1o57yzM02aBWUYiJ4RW1fy8ud6mIztG/ShAPv0GT6sBLW6G9e8A3STE8XM1Eb8ENRulnINpmrGmxsZMmSlAW/FrGmdx6mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791298973; c=relaxed/simple;
	bh=0F11sPHlbpYZDdNHWqgMmxfvqqlO0vkWrZ0Icvn+Zcs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r2GlsnVBk93qfV/cjIEz2MZhKhLDy1YwnmTfl7lyP413XGnjFhS39uAchwcd5ay0vw6cVLX/2ZgDx5yfFWx9vqUbtucVFUxsIDEIdvCrGz80Z5uLYpW4HgT5/jFk43gi2IsqRtYh5957oXMrY2vd92iIRqjkXSKtjvDn+mXRAUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMFerJmp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMFerJmp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D319D1F0089B;
	Tue,  6 Oct 2026 15:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791298971;
	bh=0elWwuTwqxZsuKc6A0wflCITVEMnAW68qx0DBBuB8q4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WMFerJmpM5SGRSUZ0CVZdvdc4boUNuQEZrKlbaP4AfPqSA1HIeii9aDPcYpXpfbMS
	 1TIz2JriJqd4PlwLnVfSd8t07C7Dnb99ElZQ0dY5OOu0aTROLyNP+2tiNs83YIL9GF
	 Dlvg921gv7wLTyPs1HbmUcDpFHCNVAN3UHm4diZo4VVR6OZ1Pp9XIhj6LAT5YT124Z
	 eAPfHxASsox4pJELj5L0jE84ZHnNlA8aMGoSn2UXT1QGoba2Xjn3u/5AJcCEvmUVEd
	 wep2BJePadjGQ0D6aEHqYoSFFiOCctz/0Ypp4OqhA/YJ1Cwiyi8k9HQSwn+lJOGAbT
	 uq0zJtjJRxe1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/8] perf mutex: Add DEFINE_MUTEX() static initializer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006145729.3028247-4-acme@kernel.org>
References: <20261006145729.3028247-1-acme@kernel.org>
 <20261006145729.3028247-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 15:02:51 +0000
Message-Id: <20261006150251.D319D1F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> For file scope mutexes, so that they don't need a constructor function
> to initialize them at startup, mirroring PTHREAD_MUTEX_INITIALIZER
> while keeping the clang -Wthread-safety annotations of struct mutex.
>=20
> DEBUG=3D1 builds have mutex_init() set PTHREAD_MUTEX_ERRORCHECK, making
> the CHECK_ERR() paths in mutex_lock()/mutex_unlock() report relocking a
> held mutex and unlocking one that isn't held.  PTHREAD_MUTEX_INITIALIZER
> gives a default type mutex, so statically initialized ones would silently
> lose that: use PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP, a glibc
> extension, falling back to the default type in libcs that lack it.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006145729.3028=
247-1-acme@kernel.org?part=3D3

