Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C5D511E78
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 23:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789603065; cv=none; b=e3HM8rqkQamn6x7RWsDRrnywn7LIqNREbVtg0MmHagLu5e+1q9UAKcyVrwOjejctLPBCGwP7isQblZjGjz/XYDHwHPvZuGesXGO73GCD51uplZINPwZABy+Jieb/+QPhr0RbUW+QO9rQkjqRDZ2b3axdfjW0BDmWEbMxHKzm2yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789603065; c=relaxed/simple;
	bh=MfZBK80PNFDJsYo185AG06V9m/aGiD77wpA6Uus297c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IHuWpn30WztpVIL43cSzolkey22HRnaxEmj9VU98ZDoqVGB2Elwa5cgx3+yxgnmyNO54GQPtw4WOxgl/AHfbXJcCJei+EV/0yudHP2m49clHgeTjYsByQr8LOnP/OmFlAx6heshkgwaCpVX7Gk3lUG26dId7TXR7/TrKFct2Bl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJSkm1VO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJSkm1VO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70101F000FF;
	Wed, 16 Sep 2026 23:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789603064;
	bh=MfZBK80PNFDJsYo185AG06V9m/aGiD77wpA6Uus297c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WJSkm1VOA3OINwZeQMNKswgZ3yD7T3Zv7V4tZFkA7LNwDihq3qEdmrSfK4MzjY0Kc
	 4e6KuCg0/G+jM2rtnBKfZ1r6L0zT+zR9COnFN+4c2VSbvWtOET+g9ha1MGAq/8/GgW
	 Gaim8woSJaeOitqqkVySYaQ2zh5KwAhgozCMmB3ao8IHshe5s2SvuM2lg3pdCGzCBn
	 iB7diyeLM4Qon64XAy5N1Ughay4feGRN0z4Hme4hf0jI+pClsYddWZJ0ByGSiW2uLJ
	 8TFsXeOfF//sxZszm4whqoicfxrEwOZ5P2CPTgdDB7ehJ5IqbkAFwJZBATuFBPvesU
	 fPkDqnuP43P3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/9] perf tools: Expose opt-in --hybrid-merge
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916234652.439778-4-irogers@google.com>
References: <20260916065248.3153556-1-irogers@google.com>
 <20260916234652.439778-1-irogers@google.com>
 <20260916234652.439778-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 23:57:43 +0000
Message-Id: <20260916235743.E70101F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add --hybrid-merge to perf report and perf top. It merges the events a
> wildcard expanded to across the core PMUs, and their histograms, so
> that a symbol which ran on more than one kind of core is reported once
> with the total rather than once per PMU.
>=20
> evlist__merge_hybrid() links the events and evlist__merge_hists_hybrid()
> links the histograms. There is nothing to merge on a machine with a
> single core PMU, or when the events didn't come from a wildcard, so
> warn in that case rather than quietly producing an unmerged report.
>=20
> Merging collapses the per-PMU entries into one set, which doesn't
> combine with the per-level breakdown of --hierarchy, so asking for both
> is an error.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916234652.4397=
78-1-irogers@google.com?part=3D3

