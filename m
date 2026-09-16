Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324B9366060
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 06:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789542001; cv=none; b=ISgm08vYHY7Sy9Y9ur11Koyc4/ZFZPeAxn26EWg0WM45LmkjQzoHpzQTxSgBo5S8JH7BzJ7rKA5nvErY2bpvwCWorlQb3yAOqdBv7N3cxrJWWvM8he+XYc0LbY5402yFmsgBdlgPY9KshAIUXGDjvbECFIX/es1jD21k/3DOU5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789542001; c=relaxed/simple;
	bh=mvD708PF7Ydc319xOKq0NK44qxnti3HFafyAvIK2zp0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I4EjATSY4FaqUVjcabsMrcjC80kOfyww+t5LFBkGFF8GK/uxqQaQBcbDs7laK++jR584Rqj+ckCEVhlKveYU1Kiux8B29fHsIQC9K4eUIdcT8+de77vR9h3Nur0MNb0if4cIVAbsrwtqm7Ur6rSAViCVSioQCMBdxEQWdI8ynKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnPNQef+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnPNQef+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4891F000FF;
	Wed, 16 Sep 2026 06:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789541999;
	bh=mvD708PF7Ydc319xOKq0NK44qxnti3HFafyAvIK2zp0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KnPNQef+fT5QYHpM4MTgTYpUo2Mg/YC9rP0LOO5O8igw5CJOR3PNnGyiSL82/fykL
	 2NwK/SKQlbJ1X4nOXIxwEPDTs3X57tHv16lRTvp5NbFjCflUu/RXNLUi7cytu+xfUo
	 8jHQmwAGRPp1o6k2QEqQNY51Bf2gm+X5s68QPZk3G4Pf6oZ7UaHgTk5RyyEh72cUwP
	 dTECl7mGwEoBu9Twz2iU2YA0voAhQQQYQxl0WY+DeinNKzCTR1qQAJCn1x5mVlt3gq
	 FMvIjciTZDOlOQBF8Cx9hotbMOKZ5Yl/aPeTJZzzSvGY3rOi6F7VEkzQTAG71mQLwY
	 ZGN0gtqnu7+gw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/9] perf config: Add core.hybrid-merge to configure
 event merging
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916065248.3153556-8-irogers@google.com>
References: <20260916065248.3153556-1-irogers@google.com>
 <20260916065248.3153556-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 06:59:59 +0000
Message-Id: <20260916065959.BC4891F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Provide a core.hybrid-merge configuration option in .perfconfig
> to allow enabling hybrid event aggregation by default, avoiding
> the need to pass --hybrid-merge explicitly on every invocation.
>=20
> The config value is a default rather than an explicit request, so with
> --hierarchy it is ignored with a warning, while giving both
> --hierarchy and --hybrid-merge on the command line remains an error.
>=20
> perf stat has its own merging options for counting, the sampling
> core.hybrid-merge deliberately doesn't alter it and its
> --hybrid-merge must still be given explicitly.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916065248.3153=
556-1-irogers@google.com?part=3D7

