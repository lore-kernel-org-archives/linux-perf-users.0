Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B50D302753;
	Wed,  9 Sep 2026 20:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986900; cv=none; b=o8laY0Kz0Yf5PMC4lF/HjBmiVVZFLIo2CA7hLSjpH5eXzxAe5Yli8Qi21ULWtNrgp0W1bEFgLDXWB69Zvar8THsoh4bAeOYrGmUbtGr1o7UXP/XR9U8cZeiyriUHOeBL8Rtfm7aXNYJ7LchlDIVLIwuBXeipae6dy+MpQmmHLmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986900; c=relaxed/simple;
	bh=fRnHZix8/fcmAEv5H6nQgHwlwRTojsgF5RiKJluWdHM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VokRTi1FnDC5tFxqgGiJEq1ipMiYdE48VcKBCu+W7XCSyLzoCQSienjO2ptrnvSOUpayGhI77nJm+SdpurQTCRqidJ5SEssRkSKeJ85C/u927c81FNSw6JUo+2oEbfvwAYyKsq4B3aMkAv1wHO45jpC4HNJZppz4KdwmeYa1vsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czV981mb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czV981mb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68701F000FF;
	Wed,  9 Sep 2026 20:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788986886;
	bh=fRnHZix8/fcmAEv5H6nQgHwlwRTojsgF5RiKJluWdHM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=czV981mbzBSDCXwwKamJQk5Y8fSXw9kpd6HO/HFDyf34E510BfRO9iht4QPqxlSe0
	 MR0bFec+LF9PxOizuZ8IGb682d9DRdPDBI8kIi5Upy/hALnqjzM82WElYfOGMBScO0
	 tY0zK9X+bfyQvVrjIKnCqkV5dmhf+PHh/GIP5vMuQHX8U6JlvfdI+TKMCWoFHvl0ft
	 MdHhLInfCezu9uLf67M7T2yMkQPROcV0Bc0qmuIG0s/yrzzkN4CLVG9+o8gteBJXn0
	 zikscyxHyDilkfgYKgum2qBIx2f5hRjCrxzBASiQDEtRgni8KaHpfORVOgXALfNjQO
	 UBIBMNGwALPRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] perf build: Add explicitly sequenced -lzstd to
 libbfd feature fallback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260909204122.1993010-3-irogers@google.com>
References: <20260909204122.1993010-1-irogers@google.com>
 <20260909204122.1993010-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 20:48:05 +0000
Message-Id: <20260909204805.E68701F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Distributions like Fedora currently ship a statically compiled binutils
> libbfd that natively depends on zstd to decompress sections (e.g.
> undefined reference to 'ZSTD_decompress').
>=20
> Since libbfd generally does not reliably distribute a .pc file for
> pkg-config (e.g. 'binutils-dev' evaluates missing on standard PKG_CONFIG_=
PATH
> checks), perf historically supplements manual linker flags in fallback
> chains (-lbfd -ldl -liberty -lz).
>=20
> Extend the testing cascade in tools/perf/Makefile.config to utilize the
> newly introduced 'libbfd-liberty-z-zstd' feature test.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909204122.1993=
010-1-irogers@google.com?part=3D2

