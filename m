Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC9F3939A2
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 19:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790449826; cv=none; b=m0w2cnSyQrt2YNBKXvc8E8idpqqsvtUYzDvDeGQLqO0b9okPTYV2nlOLSYKYnF8K/CHZnYr488McaEX6HRWqOPKSVzEdlKQuDTlcCJH0AkINhuok9EUyvMNrTJc6c3OdfbU5b5ZS6t6lYkoTzDDKIFkv4RIE/aPYuF+zipcQEzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790449826; c=relaxed/simple;
	bh=GXzqwU7ALSSiU70XQ6lKonKJKLHRj4W+iIxPPkzz39I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dp0U6uYZg1C3qHA3/poMYSBSCY+26ly/L4tHFrbjCJppusCztrmmq+y5Ib1v3Mk33CMx1n97s95HtbDIL5UDjdCOpeEsaOa1HA57EYR6lCf2dPg0xFZa1RovE9n/0MX3iAhCQITBm+BB+WHJW3hoAuFDBMrbWSRL2hSf5zHPSFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vo+ODzCB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vo+ODzCB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4FD1F000FF;
	Sat, 26 Sep 2026 19:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790449824;
	bh=GXzqwU7ALSSiU70XQ6lKonKJKLHRj4W+iIxPPkzz39I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vo+ODzCBwXvUf0jFrYsOVdxGvvnnTNCHjjR59v5/+k+xpWlRwqZGHafSgnYb4oIZ4
	 PDpMkR3VETZpklY654wC1rrpywBHBDYAT4IOAk9kHoPzY1eUgNlOyfbJhxm+q0ZlLe
	 F6hNz0L+OykxsY6tBxSmSE1Pro4c21k0JTtVnrzper6afbZL8bYqQm/XhcRiBpIaA4
	 tfcPMWMOAHtP4Q6tQwU9c+43XT89b+WCipomASL8COCCxdiSOJn3ewEWyfwlNjznGt
	 QlgFNb9M2ZvOBuKgRI6IlY3rlM0EsJDloMWDfxMFi/+VpbMBztHtM6rujOrgPH8ldH
	 qt1QOo0bwtdcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/8] perf bench futex: Stop when futex_wake() fails in
 futex wake
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Pluta" <michalpl2003@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926190407.1106421-6-michalpl2003@gmail.com>
References: <20260926190407.1106421-1-michalpl2003@gmail.com>
 <20260926190407.1106421-6-michalpl2003@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 19:10:24 +0000
Message-Id: <20260926191024.8B4FD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> If futex_wake() fails, 'futex wake' adds -1 to its unsigned counter of
> woken threads and retries forever. Exit with an error instead, as
> 'futex requeue' already does.
>=20
> Fixes: 27db78307481 ("perf bench: Add futex-wake microbenchmark")
> Assisted-by: LLM
> Signed-off-by: Michal Pluta <michalpl2003@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926190407.1106=
421-1-michalpl2003@gmail.com?part=3D5

