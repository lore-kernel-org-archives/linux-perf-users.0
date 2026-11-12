Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794447173;
	b=eb4cgEQ4PYRkPZvRIXClvlGgG4FfybHeLZXW6x7ldKP1KGpzCKie0uBiGtbMKYAd2PzN
	 naPPuukHzb9RldP4dn+obO+FFjxuJ0zpp8B+n9hvL+RO5aaY5G7a8vaP99VGBhXZK5Pop
	 F10b7Pt5EM1HR5Yml6jeskcWNIw+6lj2rHPf1L6+C+TWRZSsSYVBJ529Cv0i3/Fdj1Mm7
	 hbruSvrc7zFA11LK+1p6gAn5Q8qdciFXOmZwT2ZGW287GlUxOOCm1K0+qvtx0HYNYmnTY
	 jdOpPZyEXSkFiKCpYAeAJ3oMwQBOHWEzFP2LBTceDQl6X6nmyizTcLZ16VfkO7FBTIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794447173;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iQljxC/op/0jU85/zThEkhvsZcMEey6A3u/bkcGjl6U=;
	b=mrWsWnq9XMvq38t/08uYGO/iRzs2hL2WXCvTtdKWdrx1dwgwlY4Wb2vdgDd6Cv+cIaco
	 yz3dkCXeIIyxkB7YqQPw2fwHiUzvg+cokT1dcKDdW5EfmuEtb3vOWfe+GkJaFJVUtp6Ka
	 qgfTI7lRpO13u5fjCy8Mej/mjywSA0u6SHuNWj9SCeiXf1rfulJOAgfJp/BgDePTX7xuj
	 yeSThtk+hsc5wZkIDfOLhb0dN0fkdV+RbIt0yusyQLPAXQqNnF+Rhw/LHgzfS0GiqRVqW
	 51JXNMkV4iXNGawWB5bLeOVbhHRJXQy0BkjOAw3bwnePbA+8LlM+EALbflwesCEWBLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JIxAV9mH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFC4606AD69
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 01:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JIxAV9mH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBED81F00A06;
	Thu, 12 Nov 2026 01:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794447173;
	bh=iQljxC/op/0jU85/zThEkhvsZcMEey6A3u/bkcGjl6U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JIxAV9mHzZo4b9qk8vnpPlJOrmTIs9+OtLQrc7ULx5t759f4lDLGzo3ho0/H+/uSs
	 9ZJbkl35013uYLcz2nSB+NKojcvOxhvmHYaHt6TIXc05yz92f99pxMAwtd1MOjgJpD
	 STC8+rjIwSse5QgbpHzBLelr7y+BCvhTA18ELKYmkLYc75DmwhBF2bwlYPZoWF9CEI
	 NReshf6AB1UBYR8ji97oTBsRNuNtDYjM/di4x7KyKLk4qMt6A1LRYEJMhxCBt2thOg
	 BQTVfSjNo14wW4Tu8qHG6IBjnCejL0+PViYMTkQrD4LoF3xlH5/J4t7bo4e2FBx3/J
	 q0HxE8TKlAhjA==
Message-ID: <sashiko-outbox-210069@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/5] perf test make: Reuse Makefile.feature for
 libbfd and llvm probes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261112011514.4032822-5-irogers@google.com>
References: <20261022204627.1813821-1-irogers@google.com>
 <20261112011514.4032822-1-irogers@google.com>
 <20261112011514.4032822-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 01:32:52 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Include tools/build/Makefile.feature in tools/perf/tests/make (using a
> temporary OUTPUT directory that is removed immediately after probing)
> and replace the open-coded new_libbfd and have_libllvm compiler
> invocations with the existing libbfd-threadsafe and llvm-perf feature
> checks.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112011514.4032=
822-1-irogers@google.com?part=3D4

