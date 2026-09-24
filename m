Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38F13B14BE
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269578; cv=none; b=hHY0eTjezbn+bsnWmHjW0r49cU2NKV/EIsEmzXiyS/IIdRcv9ZxN+xdXEca/Isu42ENWpJ9avX8H43j8CAwjES37Eo9KK+85Q1HRA+F4mfc1C6v9RYICaFMah+NBFB5zn8AfCAL2gV71FnOgkNGyDqtwknPQlTyYDNSVdxs3MDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269578; c=relaxed/simple;
	bh=0C0TSjnhuEJKLeLBe6FkUIgyQ8gG9ATZ6QL2jw9Kg6s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u60nPo4BbeHMip1i/TC1esAw4YLWpbj+cH+glu5LZyVtEanzeM3Mnnd6lwCMBGGmflMdq5E3Qy/lsLCfgoS+EQSzElx/kwReEVGkcqPBfDyFSy7d9CFOXDjn9hcp1iFdRynvrqniLCaPwokcXqG/RexJOL5XfGvtjpz7SWeOf4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlB2nk7z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlB2nk7z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674221F000FF;
	Thu, 24 Sep 2026 17:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269577;
	bh=B7LSce7Th53BRS6Xz3QI+aDQxFdO2ToQoOMhZyMZmzQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YlB2nk7zlYH4MABGR2HFl9mSZ6ObNxKeNtWztlOam36Lcnht4EVm+t6ckPfGNmCfi
	 BBoMr3gWjN/WEE4EU7ePsCZiEa+vEIeo5wkNz5fIxoOaIMHEJUEdsq7Dov+/RXxW/X
	 y6gd18/O3/mczqXl5a3WLmb43doibbsGco10e2fi/jPF67ToHmRbSadnv0VI5rY5TD
	 uP6zl6t7lj1g3+7Aw94nyX+5G6RyHwe/xwAG84bnPS9IKdEnHZ9eJa6eRYEYP8uAd2
	 7lb1eC1943fFIEYmDU6L9UHC8bXBj7x8/TiaBIFyAb38IYd27uqG3lHzrXFiw8j2L7
	 UEet95ukiXkog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/26] perf vendor events intel: Update alderlake
 events from 1.40 to 1.41
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924170346.3872848-2-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924170346.3872848-1-irogers@google.com>
 <20260924170346.3872848-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 17:06:17 +0000
Message-Id: <20260924170617.674221F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The updated events were published in:
>=20
>   https://github.com/intel/perfmon/commit/5d7b37d5671a49c72abf735dc81d147=
c7776119c
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924170346.3872=
848-1-irogers@google.com?part=3D1

