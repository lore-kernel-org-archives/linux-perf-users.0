Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8676D3B8BC7
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 19:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790364387; cv=none; b=gPYtGc6ohSCALvS95Vsbx3SHJgxiHBmyBbw1yoepykT+ybRaNtGJKyA2FjKAXiVA439l7IOf5HchNwMGrTaiVv34o9Hid+05MlukbLyx11wIZyrgcmMjuEQNtlijJAiaiJ7AQ0Up7oqv6rW7Wh8PcxE47ZFsnAbvYUNy5L2b3Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790364387; c=relaxed/simple;
	bh=tecsB8aa2LeSHXbjSBnaCGS0/cvmaeGi5Y1KXep9pgg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XFknLZdozb2FKZq0DrzlL7VQayeJV+sgN3vbJpwYm1dtwwuBte/4KcEy3I95IC/2LV9SVa/pHjRmEuJrFYfkgAeaWhlOH8mrnoDiRHP2keP+u+6aJZp5J0na/dua+Xoj0S5YeqAVCOBtGtBR2lo0nS36jnCIngoC7JI0FVw4qv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/ZS8XyV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/ZS8XyV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29D81F000FF;
	Fri, 25 Sep 2026 19:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790364384;
	bh=eAVbYO0zkG2TysN4jdUjaqBoM/pZJYAgg6E3HY2wyGY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H/ZS8XyVsITNqkDmDFrTz18tLhezLNb7/XqO1ZuHZk0+NZDPMoaXOwBHBmf5A1SlU
	 PeURsx6p53Ce/7KodN0nfcuiTOY6Oz/k7fY2D6ILuRqsdse//Fw/Gs5ZEfHoTSmpwy
	 T+kY6GI9JGboSehos/7I42MDR7yXnJslaNwjRHM3yzBS89UoECZutHBwzA3d9bX3zN
	 /VpZwPjP1xWI8Ylt/Xo4xMran4YhbEqBitPuIFnE4G8ec8PQiIyCOvPDixW+TKY7HC
	 A5STiUORJGbIW1isF5D0vNP8le7U+TdJDWDXwCR9/qwfhkR4ZZ1EriysEVdJ1q+c0q
	 AwzwSRLhxXPJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/6] perf script: Add --max-symbol-bytes to bound ELF
 symbol memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260925-perf-symbol-memory-send-v3-4-3e4e234c363b@uber.com>
References: <20260925-perf-symbol-memory-send-v3-0-3e4e234c363b@uber.com>
 <20260925-perf-symbol-memory-send-v3-4-3e4e234c363b@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 19:26:23 +0000
Message-Id: <20260925192623.F29D81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf: missing <string.h> inclusion for string functions
--

commit 79450839068bd1d9b33fd4d112e056707965c93e
Author: Alireza Haghdoost <haghdoost@uber.com>

perf script: Add --max-symbol-bytes to bound ELF symbol memory

This commit adds a --max-symbol-bytes option to perf script to bound the
memory footprint of struct symbol allocations on the ELF loader path. Once
the budget is exceeded, it stops loading symbols and leaves unresolved
addresses as [unknown].

> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 0174489d1c0fd..6c459ce6f433e 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
[ ... ]
> @@ -4110,6 +4111,44 @@ static int parse_callret_trace(const struct option=
 *opt __maybe_unused,
>  	return 0;
>  }
> =20
> +static int parse_max_symbol_bytes(const struct option *opt,
> +				  const char *str, int unset)
> +{
[ ... ]
> +	if (!strcmp(str, "0")) {
> +		*max_bytes =3D 0;
> +		return 0;
> +	}
> +
> +	len =3D strlen(str);
> +	if (len < 2 || !strchr("BKMG", str[len - 1]) ||
> +	    strspn(str, "0123456789") !=3D len - 1)

[Severity: Low]
Does this file need an explicit #include <string.h>?

The new parse_max_symbol_bytes() function relies on POSIX string functions=
=20
(strcmp, strlen, strchr, strspn). To ensure build compatibility across stan=
dard
C libraries like musl, standard header files should be explicitly included
rather than relying on implicit inclusion from other headers.

> +		return -1;
> +
> +	bytes =3D parse_tag_value(str, size_tags);
> +	if (bytes !=3D (unsigned long)-1) {
> +		*max_bytes =3D bytes;
> +		return 0;
> +	}
> +
> +	return -1;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-perf-symbo=
l-memory-send-v3-0-3e4e234c363b@uber.com?part=3D4
