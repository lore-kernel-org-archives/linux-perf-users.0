Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57C04349AA
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 22:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790203953; cv=none; b=rQ8uoArNlYtCJiTWA9WzBpLoMMq6FnB+9zWhvP0ZFAp0jQyo9jsnWLiTyyIjC5n2q0laV5W/M+ZhC+nF2T6rzpxtZK61INVvgB9zL7dYytjXhwx+o32kEJhymJLwORgXQww9UDtI6bxNnVMb0dI3Pq79I/jHC4Yza+CGU69ksH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790203953; c=relaxed/simple;
	bh=fBHfqD7J/8mgv+P6XryhAZg89tKBR83HN68twZrsbzA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l0JOVDZ+xR1Y3zNTqmsSbktfSOxJQQAmh1t947TE/HrVwyJ4Dwz8s8WRRQ3SqtXAz//eUTKtLq6vBkyBjKvCfuDhsf0jLcU1ReJ1/mYj5U9hF5KvZWzU+vuEtzpnFRZAo/XlGgSV9xOygRFFMhs3zCFc51nBoqCgug6mLx2uc0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RefTcAu1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RefTcAu1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F4F1F000FF;
	Wed, 23 Sep 2026 22:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790203952;
	bh=fBHfqD7J/8mgv+P6XryhAZg89tKBR83HN68twZrsbzA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RefTcAu1iKatqu9YB/RXPNthFshVTHtAfGYykR0721EONQMs75k3JOsy2Ic9uAmaZ
	 QWCd2SkxXtqlciBpiKFQfhqxERdqmsqIv1zDZYDaijpK79qRiNR1oXSkwxmpSfTMqd
	 +goZRUwHB3RLasBy/jmpWtIoULFL7VDRWyHJ/OZR20iSu6tUIOiUcHj82PgneK736J
	 neUAyVAnnS2mJq6fS6FINgpYpm85guLMP/Zdi4YLdpA85lXqDDbTE8LAxzhUHpGDPm
	 dfCHlVtmyxhTjP7KX3WHrbCIBzJg/xj/lK7MVvefz+oYZHbKbSnPPNqWeNpENqifDo
	 9eW8R30V1Xchw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] perf test: Fix PMU metric parsing tests for unknown
 literals
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923224106.3268925-1-irogers@google.com>
References: <20260923224106.3268925-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 22:52:31 +0000
Message-Id: <20260923225232.33F4F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> On ARM the #slots literal may or may not be present, it won't be
> present on x86. As it is missing it causes the ampereone and
> ampereonex PMU metric tests to fail when run say on x86. Extend the
> fake_pmu logic so that in these test cases we fake the unknown
> literals like #slots as 1.0. When building with JEVENTS_ARCH=3Dall the
> ampere metric tests no longer fail.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923224106.3268=
925-1-irogers@google.com?part=3D1

