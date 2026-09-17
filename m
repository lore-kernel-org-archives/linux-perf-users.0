Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C773CF685
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 04:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621160; cv=none; b=TSeZ4ubBoABJMR09uFy+LwbJW6h1O9VVUDxhqMKv+XB98a/3Debrsgr7cZwZPHT0QyZs/nKHsHNHr55ZO0S7HDHpIcNkMC7KnDbNS6laS1ucxS+Vp5uwPQX0JHGSTkVFVvpjrwqC5PQc/fYP4cX/cAhsoQuNa/bX6JTNRiLxpoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621160; c=relaxed/simple;
	bh=YHRxCcm1vQUq/OfLjqhZBbSaw5n0EJVbYz342kK2UXg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hXitX5eS9hE6zrukg4yah9QZ0R5NeLWqL3Xr3Zn3SpU/fd7o95NNEIRQygHbON+ZsCF1N4vtoclFYDzJ/5D7umvYYRO0DQQz38x/Q2c1K1pm8ioBJrAGw99minF4dAH88jVfVn76jGNcqCsFjwcvbLKhozNeSUWnvf+MZN049+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtW9X3iG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtW9X3iG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272181F00893;
	Thu, 17 Sep 2026 04:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789621159;
	bh=khJHbFPILdMQaqSECZBKw3v6LJpmvrjc5Bl/4/fDtWw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KtW9X3iGvcX8aUVVu88lkGoBhpnw9ciZrvK+yAAkOkIh+v6CoJzf4ok8bh2JU74PG
	 /FU8LaTuioOnz8WQyd+FLK//TtBbP3le3PtJg17y/lqlaoONfe9r522I6kv6LUhKxS
	 0CKDkUNv4SnPTD8AkPPdFbdAxCCpI391aFc/g5W9fYDqJ/Oxuu7yI3amed3KhO90ia
	 gGBNraMWbfzffHeGUkxhaKDZNA804lFA1hWwMPI7s6X6l5+IfVlVblJIeuD/b4A/lf
	 Hja6AMMwT2S9aRE6O8wntrxSYX/YppHMkJPaVjhHM93cXnkA8ez1vCF48yv8g/vnHP
	 Yq34mK7RiJ2oA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 08/11] perf annotate-data: missing <string.h>
 inclusion for libc string functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917045326.63601-8-irogers@google.com>
References: <20260917045326.63601-1-irogers@google.com>
 <20260917045326.63601-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 04:59:18 +0000
Message-Id: <20260917045919.272181F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Sashiko reported:
>=20
>   When compiling the perf tool with musl libc,
>   tools/perf/util/annotate-data.c fails to build due to the missing
>   <string.h> header.
>=20
>   The source file utilizes standard C library string and memory
>   functions, such as memset() in init_type_state() and strcmp() in
>   data_type_cmp(). While glibc implicitly pulls in <string.h> via
>   other standard headers, musl libc enforces stricter header
>   separation. Because the header is not explicitly included at the top
>   of the file, the compiler encounters implicit function declarations
>   for these standard string functions. This results in a direct
>   compile-time build error.
>=20
> Add the header files and use git clang-format to sort.
>=20
> Reported-by: sashiko-bot@kernel.org
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917045326.6360=
1-1-irogers@google.com?part=3D8

