Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4B817A2FC
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 00:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786666558; cv=none; b=BXbLDh5wAuY9Q70s5ddvae1tf6HID3He794m5AsPeXTouZYXV4VSy4bnsZv/2LYDdyzsRIxaibfgUlX1r1i/cSPwCrdoppJXsDkzIQhW4VcZYouF6W8KYkWNhdlXtyFwflnxXwrbQxby9CRU16B0vWk82ooGn6OQFFP0b4ExQqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786666558; c=relaxed/simple;
	bh=I1ejuK8FK11QGofTVx3qAMXwn4OC1Ugy4vUXZhG+n5w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W5exk2/3PBqm8rRvtvPlbq043os9B8n6JR3/vwAp4f6QmmXkjRa3mCJx+SJypJVm3x+2H/Hdb1IVfks0ADulhHHwBIL/6OB1gUdEJvbPoRZbmAFmKwMLxxiNsofAi4hic4WWK9YxQsJk3WGP+LKkhoBGPkX2WF077f+0AUhBTPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nm7GpCLk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nm7GpCLk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35541F000E9;
	Fri, 14 Aug 2026 00:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786666556;
	bh=I1ejuK8FK11QGofTVx3qAMXwn4OC1Ugy4vUXZhG+n5w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nm7GpCLkASQk2wToTdsbfGfNuPIm4ZSPMLrQ+cXljk0GOp8J2BiaXzrQey3/4IigJ
	 7Om+ZALDWZUmpMqRzo6l3v9H/vIarc55+Uz3b8LXl7JDsyRz7qbMbEGuRRtx24IJ/r
	 qlXI0ewTGhhFk/KHIDAXhYStPtpbI3sqkRLottBdMbgwtUcg2KZXH1PzPjv2xUNoDk
	 w4oMzy7iwpL+sCUA/gZEWHX3wftp6Ih5dVTNUHG+hjbEb+KPwEaTVZTjkXHUMPd+dn
	 yYpgHta7Kz4gfMXYHxG9C2udgJx+TIrwmI90MzJDdeEMBfdPhNs0hqfNq6GDSuFft8
	 zrPGE12ceFRCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 15/29] perf kmem: Don't pass evsel with sample
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260411065718.372240-16-irogers@google.com>
References: <20260411065718.372240-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 00:15:56 +0000
Message-Id: <20260814001556.A35541F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The sample contains the evsel and so it is unnecessary to pass the
> evsel as well. Fix memory leaks on error paths spotted during code
> review.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260411065718.3722=
40-1-irogers@google.com?part=3D15

