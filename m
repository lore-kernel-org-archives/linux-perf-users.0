Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4628D3CF685
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 04:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621144; cv=none; b=Gn+pNBO/YJqOpGyarNI0+uAWBHfQkQebrIp64VyhKLXMHKSwAgjGLqps2NPoLppJ7siq4FuokJVW/BaTbSvSgBtXK8xnqtCGvDAM6kPCWcMjFAg/fvSiTBvNFLgNmL+kgF2d4hOAK/4fMYhbmz+8om6fLLb66foulp4NOf398o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621144; c=relaxed/simple;
	bh=1rhuQZ0Yc3KMfp4mmAQ7NVxz9sRgs4/szHskXubn9+k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bbg/xHFOIGkAxrmKYEF2eT63QlkkUcdWEHN3LPLM+Ecy9EU6QDRJ20ILkjmAbI3LsuZOxvGl2ZLE7QJu0Um1EmrrnElkFhdMCi2+MnTxwGvDTA9jLpH79w6tVG66vtAGXo3IqGPBrr1alr4bUxdRfUvbQMBGpfkCQvxSBB2jxO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOcWYepD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOcWYepD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E1D1F000FF;
	Thu, 17 Sep 2026 04:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789621142;
	bh=kn9l3H6J2Gm+mloxMt9cjSkGZ292BMb1XghBd8YiJXA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cOcWYepDEU//Jms58aIFHcYW+9Jg6LDxgFGKg8lN8Jh9GDDazsj4ouxlGMfi9FHm2
	 GIytus8ZH5WhZEbwR9S96QFcRVDNTeF70xAeisjrjqTHRt88ftd+Upx2a85DGAMm0U
	 pcPbUjdRq1KTzGV8tGMQYXuuLBHV4bumGg/LM7qjf/Lo7EStE7F62C5icuyEgwA1H0
	 KhwNN6Sz0CERBBQ0eedysbvXKY1kBbBWvXVaCpTKMgvKQsbld4OACFEVyjwUcsyZa8
	 7iNu57r3YVdP75BNnh+FdTqq31IlA0t5BEcC+KAyFq8zGoNQC0zrXeIvJj+OJgJnuy
	 +SloPG5V+UhKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 09/11] perf mem: missing stdio.h and limits.h in
 mem-events.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917045326.63601-9-irogers@google.com>
References: <20260917045326.63601-1-irogers@google.com>
 <20260917045326.63601-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 04:59:02 +0000
Message-Id: <20260917045902.B8E1D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Sashiko reported:
>=20
>   When compiling the perf tool against a strict POSIX C library such
>   as musl libc, tools/perf/util/mem-events.c fails to build due to the
>   use of undeclared standard symbols.
>=20
>   The source file defines an array using PATH_MAX in
>   perf_pmu__mem_events_supported(), and utilizes fprintf() with stderr
>   in perf_pmu__mem_events_list():
>=20
>   Because the required <limits.h> and <stdio.h> headers are not
>   explicitly included, these symbols remain undeclared. While glibc
>   masks this omission by implicitly pulling in these definitions via
>   other standard headers, musl libc adheres strictly to POSIX
>   inclusions. This causes the compiler to reject the undeclared
>   PATH_MAX macro, the stderr stream, and the fprintf() function,
>   halting the build process on systems utilizing strict libc
>   implementations.
>=20
> Add the header files and use git clang-format to sort.
>=20
> Reported-by: sashiko-bot@kernel.org
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917045326.6360=
1-1-irogers@google.com?part=3D9

