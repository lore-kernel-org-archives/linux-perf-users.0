Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484F8248166
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 21:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776201453; cv=none; b=AF2poND5U6YMzVlHzoE7aEyCuIUkx1SYWABukG2+dHUI1Z8BLjvIj7VethJPbyIhuutsUUn/Hy/GdlE3E83Vzwlih2P+HjStK95HNIODTQ5TaJ/FxejVNYjAp0sh59Uxp2/+ToBvphdsXOIOO6SMudesekcn7aWBRvNyMydwG9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776201453; c=relaxed/simple;
	bh=0BmxO5OHAL92qDI4mS00mu+pB5UNv2BaIJS2DAwu7F4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g2IM5RTLDfl7RsmsrVq0nQaSys/HdzuhrPCH+EpswvLTUP65zkr44+FZQNrSNN6G5svyOtxxzTJ80cPOYYKmeE4i//FzCDNklMYsrW8o+u/qMIMWincR4setYXgjzRLsOMOxkK0TenfVQlfPf5kRW40gzKRPgxc/zb5gYyYQgc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/q74EzE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/q74EzE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8664C19425;
	Tue, 14 Apr 2026 21:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776201452;
	bh=0BmxO5OHAL92qDI4mS00mu+pB5UNv2BaIJS2DAwu7F4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=P/q74EzE3/q6OaT0p+Bxx4XSop/ayy47uOY/43n8OkpEoN03Byb5ghr/+YkU2DsCG
	 oK5QPuWCwoPnF4VzM4Cyq3W2meRCpKNsOHSq/zhmWt9uUOb4i4AaBUWVaIdAoPJIK8
	 xcvcoJurpFhD9e/BPlP6Z0jv86ebxB74spHBilpYVByqenauVGLLNn/tRzzDp3L4Fu
	 U8F5Uzysnorxuhd+NV0V478xJFUZhbcxJZ+7GQZZjo0wyRuywNfP/wJph12UCfIlqi
	 LiYrp6I2HBbeNf50ZxRL73CZ+VxJ1tHHIklAUGvjzvttkXnnjyMqJAZrifAt8WvBmJ
	 zkoewgUiltQjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] perf header: Ensure read strings are '\0' terminated
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260414205725.2211169-1-irogers@google.com>
References: <20260414205725.2211169-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2026 21:17:32 +0000
Message-Id: <20260414211732.A8664C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Casting the unsigned 32-bit length to a signed `int` causes inte=
ger underflow and logic failures for large lengths.
--

commit 684fd164d75fdb623faa938c77daf911d959b273
Author: Ian Rogers <irogers@google.com>

perf header: Ensure read strings are '\0' terminated

This commit adds a check to do_read_string() to ensure that strings read
from perf data are correctly '\0' terminated. If the string is not
correctly terminated or if the length is zero, it returns NULL.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c

[ ... ]

> @@ -269,7 +272,10 @@ static char *do_read_string(struct feat_fd *ff)
>  		 * thus the actual strlen of buf
>  		 * may be less than len
>  		 */
> -		return buf;
> +		for (int i =3D (int)len - 1; i >=3D 0; i--) {

Could this explicit cast of the unsigned 32-bit length to a signed int
cause integer underflow and logic failures for large lengths?

Since do_read_u32() reads the 32-bit unsigned integer len directly from
the perf data file, a length greater than 2GB (e.g., 0x80000001) would
result in a negative number when cast to int.

Would this cause the loop condition i >=3D 0 to evaluate to false
immediately, skipping the null-terminator check and rejecting the string
by returning NULL?

Additionally, if len is exactly 0x80000000, would subtracting 1 cause
signed integer underflow?

> +			if (buf[i] =3D=3D '\0')
> +				return buf;
> +		}
>  	}
> =20
>  	free(buf);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260414205725.2211=
169-1-irogers@google.com?part=3D1
