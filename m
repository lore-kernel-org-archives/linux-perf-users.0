Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8EB414438
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269738; cv=none; b=M3nJoz4BqUqyVTpKOOL9yk6DSDL37Au3WmZxJqdrD9uLMc4wFEQryTTaX8AThzNQVYUUSd4K/MYioftOvG18uncYoqRw3w3u0AZuyxV56bzqkhRBZwhUDaQGXexwGucS0TUSjKRmvmhU9i7ICdNIHRhrtgYDiR01xv7sdFCmzs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269738; c=relaxed/simple;
	bh=IJlSDAUJ2dNpE97Csk0uKtT4QgY2Fa/mODCElhJ//SE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HM4fGopfvJgsE/awiQxxwewDubTy4XF+1nydVi0E5nbNwdj6E6NNUotGEqScVx477iTfcQO6oX+7fBI4yZbYBZ2TQkZb0bnY0Cp9Ed0hqnWlBvR3mEOUGTsr+kU+Js/a4nYo0hhAkYm298Q/5glmvUK/02IMushxwysUjnjyHz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNLXps5v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNLXps5v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9501F000FF;
	Thu, 24 Sep 2026 17:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269737;
	bh=F03KgoNxX2OdPmt6J9L5lJkpJn8Ipof6vRTpVVHYgRc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kNLXps5vssNP1KOsrB0AKqoI0I7bWVvxM8q0Y2TM3JpvjlFdJzhlqlaiCbu2TgX55
	 G85U4v/3oRtB0lXVT+TTpyfcmBNE5ma380RiZVP2dnD57rUmXIu19rK9Y6HbpPAuYX
	 0CgDdpYUHNMYoYBPjkgRewS65Jy47IHE6m7CJaZeX09IsI+Gr8yrn5+MBUDnO/oXEa
	 tF6QR0dzzhxaMLVIW/WYhBsGeC13iY0Zd/n3CIamlXRAtEnIVi7o5ZtAgBFjvD/tUP
	 J5Q+zcWYelzqMBQNrcWsJMeIIdCHsZNKEaEsVFr8a4QJK5CtyWrWBkQtIwn18pzDcZ
	 5T98B341PPGyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 16/26] perf vendor events intel: Update pantherlake
 events from 1.07 to 1.08
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924170346.3872848-17-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924170346.3872848-1-irogers@google.com>
 <20260924170346.3872848-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 17:08:56 +0000
Message-Id: <20260924170857.2E9501F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The updated events were published in:
>=20
>   https://github.com/intel/perfmon/commit/f3bbfcf86d67948fc330d4b2cddb294=
087663da4
>=20
> Fix umask encodings that weren't incorporating UMaskExt.
>=20
> Fixes: dd171167f220 ("perf vendor events intel: Update pantherlake events=
 to v1.00")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924170346.3872=
848-1-irogers@google.com?part=3D16

