Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8493644C4
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620553; cv=none; b=h6mwUXZDc+DrtEoKdniG+SxeEPPuUSS/qccgr0x0SgumRoEpefdL4H9fYWNizjz9/JWyxKKHblGoNpzWXG5kyCC59F4iX+fDMuqUtwHGT8o/RAAQvu0xVvB0k+7d8TNvWPx5R5zPVjK/wtzyWomn+dGf54colaHd2wnlPIJ8rj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620553; c=relaxed/simple;
	bh=ckQ6Nil2HzYtzhafscY+aJcgbAB8jBb6XLvoSGCSw9A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DYm8OyOU01xuiAlcwstuc15D3bpzfW6ZUuaXwWSCPbFV/wGWxioOO7qH0Mv5pE71Bxio3ctgYV3AaBFVWm9GaqnudfJWeFGjnD3lN8Lwta51kFIVPfQo0+JDEf1eZuhr2zhvHDehTt+8HPc6DiC3bZFBgk1klgkL3xLHuzzE2Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IW09q8Iw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IW09q8Iw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3364C1F000FF;
	Mon, 28 Sep 2026 18:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790620551;
	bh=ckQ6Nil2HzYtzhafscY+aJcgbAB8jBb6XLvoSGCSw9A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IW09q8Iw0tTOSSK2uFXgHsSMdsQYB5Ut75l9KS9jasJLiFvtJc7zgIGwYzAClGOyF
	 hKOb6Q8m6O3o3nbj75DgaNLaEUox5i2zoOAMkb23387DAS44TA8lfFyU7LUJxx14gR
	 nwdZevzIuIelfuSw6Oin9vLFXX4A0a1rDiSNf3391ItfJBiocB8YgdqIYi8B27FP/z
	 3wvSKXnKx4Id8Fr26jwqNi9oVQXezn9cAYIfZQ3ILgMvdCC5hUAYo9l8zrTS1Hu/bE
	 yDeb6eB+CaoAtvZ3EpKwsXkJAxg92uuIDL9XhwbEs5dl4/15cCF8QK6/nK7IGxME+P
	 DfJjYi2998LDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 23/26] perf test trace_summary: Improve error
 diagnostics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928182605.3649015-24-irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-24-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:35:50 +0000
Message-Id: <20260928183551.3364C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> On a mismatch print the command, the match count, the matching lines and
> the end of the output.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928182605.3649=
015-1-irogers@google.com?part=3D23

