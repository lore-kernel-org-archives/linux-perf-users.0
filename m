Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3F9377AB0
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619046; cv=none; b=CKaxgQ39Y85f5Dbzxl3/JXOWm9AZbMqngFymlUl+UngpQuOH1XUh9R60n02ZUDTXWu2TEp8TkLr1iDq5EKHj9TD18sOANZB1r4mVCJHhDSyrAc5Pr1e7HxM5VeOmR2XYngUzzclYeJ2icftYs0FCYKaeST5YXy7KDFsNqV7GzxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619046; c=relaxed/simple;
	bh=IZLYRz0IndOwZDAbNDWJJ1L3ns7thcj6JahvI+AWlkg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JD0pdHyAj0QsGCarNN3AgzKupWplXJXRRL38FDkO/2RoXSppPNa0KNGku/jpQzuzHGfa6df9SFybpzWBOuI6O6yAl26jM2gyqfDp13NTyiKX71Bg2h2lkXrhT66D1EQ99dHBMsPkqAT/uMMX48pBvqmQXpQh0YAv9dSTmH3l/vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzEE1xXz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzEE1xXz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB911F000FF;
	Mon, 28 Sep 2026 18:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790619044;
	bh=IZLYRz0IndOwZDAbNDWJJ1L3ns7thcj6JahvI+AWlkg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dzEE1xXziqAmwbhtDqf76nJiTB2XE5KSKoXaLUB0k0LPi2m93kXTxD/5bun/yTKK9
	 eWykFq1BzBXb4Mw9nCybMawQiyNAlEeHpFtAwweqcCvipKcVSHldi84PEQgZj60VnL
	 gTBaCRjedIlNybe8LqFJQERZneqJjnXBTe9+ELR5KWT481WArBXnRpL6cwjzVmzTWQ
	 wHpYq40dT6u8y5HS5zGa2emtqqB+gYatbsVx64PHDw3nL/TMubO35gTHH5FWwHpZX8
	 C29W4RmWzfTXRZkqN93oJTDuv6Y7amGcGzNuR1Bpdl25Eft0UmE6OrZuJu/asRpaSC
	 JmWBA7Qqyz1EQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf test probe_vfs_getname: Also look for the probe
 line in do_getname()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926223905.6865105-1-irogers@google.com>
References: <20260926223905.6865105-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:10:44 +0000
Message-Id: <20260928181044.7FB911F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Since commit 9fa3ec84587c ("allow incomplete imports of filenames"), in
> v7.0, getname_flags() only calls do_getname(). None of the lines the
> vfs_getname tests search for are in getname_flags() any more, so the
> tests always skip. Fall back to the initname() call in do_getname().
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926223905.6865=
105-1-irogers@google.com?part=3D1

