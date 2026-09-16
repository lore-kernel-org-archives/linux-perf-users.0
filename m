Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA88A495AFD
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 18:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584290; cv=none; b=ZjqhNOqCw4hJAA6AaIKFtbfUP/nrbMfmFoghyfWypAs9mceISKL9Nz8ZPA0taJ1ntMvefELpwimoRqaDpopG2FLIEVfwaiBOeBSsUhrUD7qV64Q7z9n32zdu62caSeKe/3DtdRmfd17zbVNllqTE6WRPJNjha7+IUooHjdE2Ydg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584290; c=relaxed/simple;
	bh=xcqbs0KgVbsjYnKvdjr3IB6gkJZ6kJBOyCNLY1ohTpw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pc1q/BgnVULkEdTjVyzF9TwXoQ8i08x9ZT2+hpMBvW2/Qpa4+Q50tZCkyGjnwQAmxr4OHBN3LTtjPRqdSE7gXT5raCwkDmdEDqbfbUQoegOoPXAqpYqUMAqcJY3Iec5/rLZ22LZRp5atLtJCcjdCFW/pFUZa717TZGkKBORRWyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkbvwmZJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkbvwmZJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203661F00899;
	Wed, 16 Sep 2026 18:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584274;
	bh=kftHObVVw+Fv+x9pPoSU6CSzCghegcbX323oKHaVIaE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XkbvwmZJolANd0Vz2weepHDFbgTILj05OwJQ0XjchdWs2wXd2wVj8QMK6p6fFyyao
	 eq1PgnAZpy/vU9ZN96orhzP+edOfCEX7KzWDSOZQivFc5BFwSUGH02PhLKd1YDEOXv
	 tnm5rt+c07reHGDXryXRqs6YXFVtqoPYZGtsOXUbbZvxY2nTLl7I+DMimm3Nv/ceVx
	 f+q6nDk7mRrT9jYTgr9iHoueyDR+r/uq4PBmMHWM43hPB+71k5AZUQpkzr0QH1OMai
	 7l8+FHzVuqnITzH6y/3Az9O57/9PanTzybs6taMgSjaql+i/HnjrJb5rgVTMjb9ZLe
	 WnzOlu7WXKs9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/12] perf debuginfo: Show the debuginfod fetch
 progress and keys in the TUI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916183215.54305-6-acme@kernel.org>
References: <20260916183215.54305-1-acme@kernel.org>
 <20260916183215.54305-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 18:44:33 +0000
Message-Id: <20260916184434.203661F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: terminal width underflow in ui__progress_window causes DoS
--

commit b92eb48b4032b30d5c7972471d8fd2b1f910094c
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf debuginfo: Show the debuginfod fetch progress and keys in the TUI

This commit implements a TUI progress window for debuginfod fetches to
prevent the UI from appearing hung during long operations. It handles word
wrapping and keyboard interruptions in a constrained terminal space.

> diff --git a/tools/perf/ui/tui/util.c b/tools/perf/ui/tui/util.c
> index e4d322ce0b54c..c3274b92b0e22 100644
> --- a/tools/perf/ui/tui/util.c
> +++ b/tools/perf/ui/tui/util.c
[ ... ]
> @@ -272,3 +274,178 @@ struct perf_error_ops perf_tui_eops =3D {
>  	.error		=3D perf_tui__error,
>  	.warning	=3D perf_tui__warning,
>  };
[ ... ]
> +void ui__progress_window(const char *title, const char *text,
> +			 u64 fetched, u64 total)
> +{
[ ... ]
> +	ui__refresh_dimensions(false);
> +	mutex_lock(&ui__lock);
> +	inner =3D SLtt_Screen_Cols - 2;
> +	if (inner > 255)
> +		inner =3D 255;

[Severity: Medium]
What happens to inner if the terminal is very narrow and SLtt_Screen_Cols
is less than 2? Since inner is a signed integer and is computed without a
lower bound clamp, it can evaluate to a negative value.

> +	nr_lines =3D progress_window__wrap(text, inner, lines);
> +	height =3D nr_lines + 3;
[ ... ]
> +	SLsmg_gotorc(y++, 1);
> +	len =3D strlen(title);
> +	if (len > (size_t)inner)
> +		len =3D inner;

[Severity: Medium]
When inner is negative, it gets cast to a large size_t here. Doesn't this
bypass the truncation logic and allow the title to exceed the bounded width?

> +	SLsmg_write_nchars(title, len);
> +	for (i =3D 0; i < nr_lines; i++, y++) {
> +		SLsmg_gotorc(y, 1);
> +		SLsmg_write_nstring(lines[i], SLtt_Screen_Cols - 2);

[Severity: Medium]
If SLtt_Screen_Cols - 2 evaluates to a negative number, passing it directly
to an API expecting an unsigned length could trigger massive space padding.
Can this lead to a 100% CPU lockup or hang of the perf tool if a user resiz=
es
the terminal to 1 column during a debuginfod fetch?

> +	}
> +	SLsmg_gotorc(y, 1);
> +	SLsmg_write_nstring(bytes, SLtt_Screen_Cols - 2);

[Severity: Medium]
Similarly, wouldn't passing the negative width here to the SLang library
cause the same issue for the bytes line?

> +	SLsmg_refresh();
> +	mutex_unlock(&ui__lock);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916183215.5430=
5-1-acme@kernel.org?part=3D5
