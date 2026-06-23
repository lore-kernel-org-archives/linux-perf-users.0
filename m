Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE114395ADE
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 21:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782249135; cv=none; b=UNmM9zsx55/m/wFFHkVxifXxy78GFGSCXqQoKTnI/q39MmPwo1DW9Sgl0PIc+jQwqz6pEMsM4/BP8XsgLv+rkZSaBXxfDl24la5ApfL2NNY0dnyzKgtV5J6rbxITEj2FShl655W/svdSiOgsPgnGDO1jxTXJoCBlbpodlbJjclI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782249135; c=relaxed/simple;
	bh=gVpPhQJuSwY4TE5VrV9yWM7PICW1UIgxam+zlTFi0Nc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SHfavwWR20p3CjmsA/Z8rQFEgGAieaK1aqVieOuAbsj1Vh4yD1DhleiIT0nECu5Yv6nIjwiThpTojCFk5JJ4/TOcadwAQEbUqrJMVvlPy7qd28dbezU0H0nrUJOlCBI/cuB0ZoYukJ/UIqQsE/J7nzzlmz2JsTvTXFHRgUj60kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnZEwm6W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnZEwm6W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367481F00A3D;
	Tue, 23 Jun 2026 21:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782249134;
	bh=ABYNDQL/ZFp63l/iVnFyLewcyzlJ0hUcqnwS8o/GF9k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SnZEwm6WxLwFFFce8qoP5MdKDKPiF/uMC7lZHpAyH5fWYK6g+xAAKSWTK9V/28mrB
	 F8Dj9rp3OKIqCAr8qkm0s3ZexzfPltkjq37Igx8t/MELo5Ed6vru8N1jRSklFlZrAC
	 j6xha3MiYNS7z3OBVrCbBJpOoRXurXK7mCS++NGnwSzD8++mU9+qbp6i3xezACjBBn
	 SVCfKwR0IY96KwEEOQbG935fdx+qRRyXlNm6UlL7ZrYsMut5BVcbP8GSzyrKxbpJub
	 ExUjB3sgP3kR34VqReVJ8O3VkTWBsAjnk2PcZB21zOiSAirhq0jLWbiSvgxQxt1MXo
	 wle8jVTlD0lxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/13] perf test: Truncate test description to fit
 terminal width
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260623012758.2291858-3-irogers@google.com>
References: <20260616164819.370939-1-irogers@google.com>
 <20260623012758.2291858-1-irogers@google.com>
 <20260623012758.2291858-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 21:12:13 +0000
Message-Id: <20260623211214.367481F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing explicit inclusion of `<stdio.h>` for POSIX standard I/O fu=
nctions.
--

commit a38919168aca480a6e9314b30b0c93edcb90fb79
Author: Ian Rogers <irogers@google.com>

perf test: Truncate test description to fit terminal width

This commit addresses an issue with the parallel test harness where long te=
st
descriptions wrap around and cause output corruption. It fixes this by
querying terminal dimensions and dynamically truncating test descriptions.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 7e75f590f225e..8b8f63f706d93 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c

[ ... ]

> @@ -415,73 +418,73 @@ static char *xml_escape(const char *str)
>  	return res ? res : strdup("");
>  }
> =20
> -static const char *format_test_description(const char *desc, int max_des=
c_width,
> -					  char *buf, size_t buf_sz)
> +static int get_term_width(void)
>  {
> -	int len =3D strlen(desc);
> +	struct winsize ws;
> +	int cols =3D 80;
> +	int term_width;
> =20
>  	/*
> -	 * Clamp to buf_sz to prevent GCC format-truncation warnings
> -	 * when terminal width is very large.
> +	 * If output is redirected to a file or piped, we don't need to wrap
> +	 * or truncate at all. Use a massive virtually infinite terminal width
> +	 * so descriptions are printed in full.
>  	 */
> -	if (max_desc_width >=3D (int)buf_sz)
> -		max_desc_width =3D buf_sz - 1;
> +	if (!isatty(fileno(debug_file())))
> +		return 10000;

[Severity: Low]
Does this new call to fileno() need an explicit include for <stdio.h> at the
top of the file to ensure it builds correctly under musl libc?

This file already lacked the <stdio.h> header, but since musl libc strictly
separates declarations rather than relying on implicit inclusions, this new
POSIX standard I/O function call might cause build failures without it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623012758.2291=
858-1-irogers@google.com?part=3D2
