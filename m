Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA3A395D8B
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 20:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788208207; cv=none; b=nMNH//pEemVGI3yDpaWsw3dTFxf1eo6uUoEyltsGB4BCkf9Tr/mRx/Ox5ugpp/ebdtKWompef8voBsB6dW+bpKdF6ihQGUQGAy1WYgakOAf1JUfffr2CMwpneiTuJKe8H2mZ/f7CwTJGIBlsYhV1gP8hfYyDp+B2VJ86EpVoiMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788208207; c=relaxed/simple;
	bh=d4Md+JneUG5EStsnKKq6PWy9IK9XIFF+Qa5QbrWYueI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IKjJhpCSyaRYcEGtv7j+HQj43ctobKwm7wU/TCYoHCywzpRAzao+r2iexYQzP9kKsvk8ZSbgjQVTWzuX1+jpdQn3MQn8FnKZfDEAPECNjxAj/WDSsDlYCcqrcX7cmPlkUDEdw5knB8mmEaPHiZooSmy+Zox1w3pJvxt2c18f3mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4FmKBaU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4FmKBaU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD20B1F000E9;
	Mon, 31 Aug 2026 20:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788208206;
	bh=d4Md+JneUG5EStsnKKq6PWy9IK9XIFF+Qa5QbrWYueI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c4FmKBaU8OZDu6dT+rqEQua66HL+/pjJ2CkSjmLwTKkYtQgMs1NIDsEUJ3/nCwY2/
	 TK3Hsrhs0YBfRVT1l4vorw1YPM6+E3WfIjivZz+qoYNBGjFev/LkxYDkcW/hVtvDiN
	 iI8ZM32vlu5dsY44ehHB/UI0AVaGmotWlgp/M9F1MHu+XY1MMFQEZgChaL201pZJOW
	 508FzYBH89RzihDZ+kyQtnAf7ay+wCnhgQ2UT3Sl4c1oQ/UGvhWcZfQ9DuYQln93lm
	 Qkf+PzjZwnd5Alx2sU5yO8hWbHKusTibEGMbNZ/Ebr0pFJHEf18VSHVSSi0tzkQUav
	 BpL7+EYPaGZmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] perf tool: Remove util/cache.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831182232.2959017-1-irogers@google.com>
References: <20260828222045.1314766-1-irogers@google.com>
 <20260831182232.2959017-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 20:30:05 +0000
Message-Id: <20260831203005.CD20B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Move definitions to places they are used, or path.h in the case of
> path.c's mkpath function. Remove unused definitions. Fix transitive
> include dependencies.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831182232.2959=
017-1-irogers@google.com?part=3D1

