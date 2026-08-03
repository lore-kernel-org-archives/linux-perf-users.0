Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CA0405C3F
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 12:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760449; cv=none; b=h0jFIEKQcgEhMqyTnteeytVzI13NmVpGggmrKzq906Xbga/wxtNejYrrwbe69Z6ZAoAY9tIptqf9PuHaJ2Jvit7xEsK90tcGgTUpnUeUqPkXzKKEt8w3t7ijAtSuHDeELxJACsyZiWHMY8qZoxRBmh1xLuZlV0gQ1p8pGaS5UGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760449; c=relaxed/simple;
	bh=cvkCUySjHyh/CsEqFC2mRN96HSUjMZvECOJTuy1Mbec=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HdrnfT4l+G0spteOtXI4vkiIdhf14N86MHnmuJ9Tq6tvvABMajQce/0smSVKWQnc5skjT5r3WsqXrU5Gf1m+YzSegGbqb00O9ueS1oezeFnSlCtwPWVSoAS3QLXOfyva+UvoNbjtCWM336TFvGt0MGRCbR/m5RmAL+cMqPay0sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHVJMDr5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHVJMDr5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1161F000E9;
	Mon,  3 Aug 2026 12:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785760448;
	bh=Ga0FevkmgSXUYUHl3HpeN9Q14d5mJiZOJtVd5cApKQE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LHVJMDr5lH7YERqGq5fOzutft6EytKbwGQPOWmK9/KJKyyP1thfX6g3eJ7n60L9fJ
	 PC3xJBZSlK6n2/v7qwBWAw+K7EBg7E5Xivjv8R1en3RloSP2gR7U2YEihDXqQFmLV8
	 /mmc4j/xnFSDrS+pzFf6lEvegx/6NrR4Ij6YW8JF47aAAkcUkdyfOrC04dOAyO0q3w
	 8P0MBfoNdCqFz5Zwwrqq4OHNgSNcZFK6Uq0+jx8Jvx78Ib32W3eUkz6WHOWxG/gHf5
	 D7P1uaNuv/l0YYJDkyYzjCkONXyNGwCgSrwULtDN9tuOwn/uTTsIsA4qj2c0kn9WgK
	 NpaF5ZzKpZkyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf c2c: Clean up registered formats on
 c2c_hists__init() failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260803120452.181273-3-acme@kernel.org>
References: <20260803120452.181273-1-acme@kernel.org>
 <20260803120452.181273-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 12:34:07 +0000
Message-Id: <20260803123407.ED1161F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] `__hpp_list__parse()` contains a bug where breaking out of a swi=
tch statement fails to terminate the enclosing for-loop, leading to order-d=
ependent error masking.
--

--- Patch [2]: [PATCH 2/2] perf c2c: Clean up registered formats on c2c_his=
ts__init() failure ---
commit 8cd4f405e8cab7ae300b2dd0a747dc102c29836e
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf c2c: Clean up registered formats on c2c_hists__init() failure

When c2c_hists__init() calls hpp_list__parse() and fails partway through,
format structures registered are left on the hpp_list. This adds cleanup
inside c2c_hists__init() itself, so all callers are protected.

> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index c9584dbedf77a..9f6ae3adb7951 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c

[ ... ]

> @@ -2063,26 +2065,34 @@ static int c2c_hists__init_sort(struct perf_hpp_l=
ist *hpp_list, char *name, stru
>  	return 0;
>  }
> =20
> -#define PARSE_LIST(_list, _fn)							\
> -	do {									\
> -		char *tmp, *tok;						\
> -		ret =3D 0;							\
> -										\
> -		if (!_list)							\
> -			break;							\
> -										\
> -		for (tok =3D strtok_r((char *)_list, ", ", &tmp);			\
> -				tok; tok =3D strtok_r(NULL, ", ", &tmp)) {	\
> -			ret =3D _fn(hpp_list, tok, env);				\
> -			if (ret =3D=3D -EINVAL) {					\
> -				pr_err("Invalid --fields key: `%s'", tok);	\
> -				break;						\
> -			} else if (ret =3D=3D -ESRCH) {				\
> -				pr_err("Unknown --fields key: `%s'", tok);	\
> -				break;						\
> -			}							\
> -		}								\
> -	} while (0)
> +static int __hpp_list__parse(struct perf_hpp_list *hpp_list, char *_list=
, struct perf_env *env,
> +			     int (*_fn)(struct perf_hpp_list *hpp_list, char *name, struct pe=
rf_env *env))
> +{
> +	char *tmp, *tok;
> +	int ret =3D 0;
> +
> +	if (!_list)
> +		return 0;
> +
> +	for (tok =3D strtok_r(_list, ", ", &tmp); tok; tok =3D strtok_r(NULL, "=
, ", &tmp)) {
> +		ret =3D _fn(hpp_list, tok, env);
> +		switch (ret) {
> +		case 0:
> +			continue;
> +		case -EINVAL:
> +			pr_err("Invalid --fields key: `%s'", tok);
> +			break;

[Severity: Medium]
Will this break statement only exit the switch block, rather than the enclo=
sing
for-loop?

In the old PARSE_LIST macro, breaking out of the loop aborted parsing upon =
the
first invalid key.

With a switch statement, it looks like this will continue parsing remaining
tokens, overwriting ret and masking the earlier error if a subsequent token
succeeds.

Does this need to return immediately or use a goto to exit the loop?

> +		case -ESRCH:
> +			pr_err("Unknown --fields key: `%s'", tok);
> +			break;
> +		default:
> +			pr_err("%m for --fields key: `%s'", tok);
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803120452.1812=
73-1-acme@kernel.org?part=3D2
