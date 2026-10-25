Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792952268;
	b=ctod2XQzeFOCXqWzHVPmOe5djNMRmp18N1pKi+qgxu64BpmDMltg77osCAskz0HpIxz8
	 b4vXYvqkQXxGwLX8MiRqSu7jssJ8O2OUa1qQbA0Cm/FY1aaQ6z+leL/MgirsQ5ngRGttz
	 mHRjXsa7tF4eGSNn5qRTGJd5P2pwzAgBUJushnqqv+Y0g5nziJJnHNK4lz4Ex7d6FtART
	 nioVmUUBh7M9oKbMk9yr5vfFb+YIiKOqGybwWCdFKBgIU9tLNthg7X6zxT6Q6OXtZ4P1p
	 c2AgLqQ3PQ3Jl/en8HCXcwARHsvzpPrIWCXn/SzLj0nfMIYwYIeYJq7D3kb067CBCEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792952268;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8+Ocj61XarvK030rhL6YhCfeQlfD5wGnIRz/DEvUPI4=;
	b=V2jlPKl29CgDGGzSFrZGOyxalt+P/B5Z0FMu/cqB3e64Nb93tyaznFRk/Bs3OShudaWi
	 IK4+vFbUcrc5IiAQcS4kxYDRjBENPv2lqsKMgOUSQKPle8FRxavqorW1PqyTAWcTT+5o9
	 wNPUrd7dNpo1hvPtB62WEV5iLZHM3c6knlUl9vlx2JrI/M7t2TowOJGpHUbz5xfB7h8c7
	 Lo9FKIH3476tERwEtK+EWGMy7mdYlxW5R/TDIAx0Rhjqr8+YmLo/wkwP1U2uRjV96cQDi
	 dOHjILDcYC4HAAgWhWDLoC7BuCGwBf8BKjOLr3M5cUzr2B37XBq/oJI5ihGWs5rfYkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UbBq7xAb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F2C606A31A
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 18:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UbBq7xAb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED81C1F01825;
	Sun, 25 Oct 2026 18:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792952268;
	bh=8+Ocj61XarvK030rhL6YhCfeQlfD5wGnIRz/DEvUPI4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UbBq7xAb8oDfUcz7lp7Y4+jaNYe6rIf1TWwy5XX5M35yjG8NCCZ8zj1nMSCTtZbde
	 ZuzHb/8JayQDnCJPDZqYV5Zsn+kmwZc4xToyGd2zDSzoVleKceX6ppT2XCBTi6gJLp
	 NwVikOVSD1yj1VPnH0GqAc0kFJsspnoqK24n+MuAJT9dP4gk7tlXO2lhPww4+zxRem
	 HfG7Zli9XqparS6fiCTVD5MjZ+n4E47hQ+jyPzjaZ1Cl7fNiWUseaUfM5D9n2A4ZcO
	 6Sj59mHciUcgUbvNWX1F380+qgXyP96bgHREI35bEWPurCKG+33IKWhtpyUZchxlFX
	 tq+WLRyIlRMdA==
Message-ID: <sashiko-outbox-184323@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v11 07/10] perf symbol: Introduce
 vmlinux_path__find() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261025181125.514372-8-atomlin@atomlin.com>
References: <20261025181125.514372-1-atomlin@atomlin.com>
 <20261025181125.514372-8-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 18:17:47 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The vmlinux_path array maintains standard paths used by perf to locate
> the kernel image (e.g. "vmlinux", "/boot/vmlinux",
> "/lib/modules/%s/build/vmlinux", "/usr/lib/debug/..."). While
> vmlinux_path__init() populates these candidates and dso__load_vmlinux_pat=
h()
> loads symbols into a DSO/map, callers (such as test suites or probing too=
ls)
> often need to verify the existence of an accessible vmlinux on disk before
> attempting machine setup or test execution.
>=20
> Introduce vmlinux_path__find() to search through the configured vmlinux_p=
ath
> entries (or symbol_conf.vmlinux_name if explicitly set) and return the
> path to the first readable vmlinux file, or NULL if none is accessible.
>=20
> Tested-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025181125.5143=
72-1-atomlin@atomlin.com?part=3D7

