Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B30D397694
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 23:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849530; cv=none; b=I1I4Jnobc41BlP+qU1bXcb/yA/aWnOPLRXuoMkZjGcz/4/QVrZt9vF9kRml+LcS5ZiZxhPvRheunazOuVL8dWv7S8sR30wUF+uBCiwB9WVtNdhcmdh37AEVArPrPv5daUJmwo4uDo5RqMCYJKambV+b87VVOZlJeV/jJyaEfJX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849530; c=relaxed/simple;
	bh=3dbLkPBP8KdbilF1AB/TgqaMqWJs4SvlBnrGIBDRZOE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=tA14XpeHzMMGcrLO04TeMkBDqt5c9JnSG7/gWO6pArAQnpD1EMn/t4sXPaeUFRrlsTcaQh539va6TSqcFaidthnrj8aZ50Q3QUZR+mYll99XnMk+VlfCEkQTGgUAB4do5UYiM88yvSlV+B556G+H0I3efiYutr97XJBpJEy6OKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvCUz8hR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvCUz8hR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A0C1F0089B;
	Mon, 12 Oct 2026 23:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791849529;
	bh=zUAatOomjs26hKdEhD7wECtZtYr1ANvBDvExXZLWWcw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HvCUz8hRXetI18QYzyODnb3tdb2a1AV6pSJSdNZvDlP0XTNT4r6r0Um0f7UAWTxWh
	 kp+TTJV1yp+Ezf8YRfVE+Z1N1d4a8tgFosZPlkHtMsFx24xEGPk9HuSGA/wIsNqbVc
	 dA2YfWwAi3HozOh4PnDMdZJbAIxnquYR4vZed/RRXDo7SSIsmS7/2AEnSmrXt1VIIz
	 /4+lU4v7SCusEB6UsaYX2sqVWWqRo4VWG8Vgcp6y20i3M3ySmAJFPqwkj0LrHYrnRe
	 4rIbB9Vx+Mko6YSN0P9p+eQDFXxhiWBKYqqS0sG4nbbaFi0HIHe9CYvDv8N/wquFB+
	 1+KqSUHTdE+Yw==
Message-ID: <sashiko-outbox-168759@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/10] perf tools: Factor out dso__find_binary_type()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261012234654.60666-7-namhyung@kernel.org>
References: <20261012234654.60666-1-namhyung@kernel.org>
 <20261012234654.60666-7-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 23:58:48 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: spurious FD-eviction and DSO failure due to uninitialized =
errno
--

commit 00af7deeab2857b031fe6b82dcee452b2fe4afb8
Author: Namhyung Kim <namhyung@kernel.org>

perf tools: Factor out dso__find_binary_type()

This commit separates out the logic to detect the binary type of a DSO by
checking if the candidate file contains a .text section. It ignores
data-only DSOs and adds handling to retry with the DSO data open lock if the
search fails due to hitting the open file limit.

> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 913877b84b2d4..c42ad0c5c66a7 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
[ ... ]
> +	do {
> +		dso__set_binary_type(dso, binary_type_data[i++]);
> =20
> -		dso_data->fd =3D open_dso(dso, machine);
> -		if (dso_data->fd >=3D 0)
> -			goto out;
> +		path =3D dso__get_filename(dso, "", &decomp, dso__binary_type(dso));
> +		if (path =3D=3D NULL) {
> +			if (errno =3D=3D EMFILE)
> +				goto open_err;

[Severity: Medium]
Could this lead to spurious FD evictions and failure to find the binary type
if errno is already EMFILE from a prior, unrelated operation?

If dso__get_filename() returns NULL for a normal reason (such as a missing
build-id cache) without touching errno, it appears a stale EMFILE would cau=
se
an early abort to the open_err label.

Since the caller __dso__find_binary_type() evicts a DSO and retries up to 3
times, and errno would remain EMFILE across those retries, it seems this mi=
ght
permanently mark the DSO binary type as NOT_FOUND.

Would it make sense to clear errno before calling dso__get_filename()?

> +			continue;
> +		}
> +
> +		errno =3D 0;
> +		found =3D filename__has_section(path, ".text");
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012234654.6066=
6-1-namhyung@kernel.org?part=3D6
