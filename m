Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9135217F27
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 13:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784294126; cv=none; b=NE8Cpz+GpdosABw039HX5sWWXSmPw2iEkLh9p8i7acQby/9lclI6Dp3KL6sQSFmYMnqTZSEXeHHi9wvGF5iXmAkFm8Neu9Mo8tf6Hbt1xnLQOh78F6+2WSd3exIRYZ8kCRUhaqVzLAgF/I1sX0i1BLXiHo568krKNiT77XaT1/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784294126; c=relaxed/simple;
	bh=vQ5P16piBpVZKIHBg1jxQNW0AC+gIb4L4eD04fC7ZUY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u5Id802vh3h92P17F3+jP4w3JR9iyDn3sOv+NR4EgCQNJUi/aQAkBr3kSs7/Fu7ukWx6A+cQu02gSgHEGtS+9OTWut5sO4C9duR4nNJYexYvM00RAYqNio6WY7OgiBNz0Na6B+81u0g6jSygccxIwFT73IRysp9bsht/YamqO3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Muk12Nwk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Muk12Nwk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456941F000E9;
	Fri, 17 Jul 2026 13:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784294125;
	bh=z4I6w+BLo1ocE2+xnDrH3CRHlw35uQ46m8G9xkQ9Oq4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Muk12NwkKEqr29CgrPSSAYkBS7mfKqEdo1pcUERUemb58j/lxqwS3U8nRQivCHJ6s
	 3uMNXbbI84b+njvx0oK4KWaK6EA4yujfqEX+poowcQ/MEWQg2x2k50wpAH6pjrsaa8
	 xnCZVF+tUZ4sl3gUYEN8umURmheHj292p8FLuIfviBt8mjfn0c0o/fydXRlQhiSpzP
	 5t5TEK4f9dO+H2TIO6F8io//BiJLonDz2LL0PuWI8XVETzbOIK5ZSM91yS+ljRsNqB
	 NlIj+JFxA08br9bcpe2yMOHzv9i0our7Jn+5oHexCOgTb6bCVt/S9KSplIzN+B58dN
	 uLXx+WGxg6hOQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 05/13] mm/kwatch: add watch expression parser and
 dereference engine
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinchao Wang" <wangjinchao600@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260717130405.1902323-1-wangjinchao600@gmail.com>
References: <20260717125023.1895892-1-wangjinchao600@gmail.com>
 <20260717130405.1902323-1-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 13:15:24 +0000
Message-Id: <20260717131525.456941F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The watch expression parser incorrectly shadows valid 4-characte=
r symbol names starting with 'arg' (e.g., 'args', 'argv', 'argc', 'arg0').
--

--- Patch [5]: [RFC PATCH v2 05/13] mm/kwatch: add watch expression parser =
and dereference engine ---
commit f73ceb00166a670b40222eb3b2e46fa6d5931306
Author: Jinchao Wang <wangjinchao600@gmail.com>

mm/kwatch: add watch expression parser and dereference engine

This commit introduces the watch expression parser and dereference engine f=
or
KWatch. It allows parsing textual expressions into configurations and resol=
ving
them safely against pt_regs at probe time.

> diff --git a/mm/kwatch/deref.c b/mm/kwatch/deref.c
> new file mode 100644
> index 0000000000000..a93c76139e7cd
> --- /dev/null
> +++ b/mm/kwatch/deref.c
[ ... ]
> +int kwatch_deref_parse(struct kwatch_config *cfg, const char *watch_expr)
> +{
[ ... ]
> +	if (!strcmp(dup_expr, "stack")) {
> +		cfg->base =3D KWATCH_BASE_STACK;
> +	} else if (!strncmp(dup_expr, "arg", 3) && strlen(dup_expr) =3D=3D 4) {
> +		int arg_num;
> +
> +		if (kstrtoint(dup_expr + 3, 10, &arg_num) || arg_num < 1 ||
> +		    arg_num > 6) {
> +			ret =3D -EINVAL;
> +			goto out;
> +		}

[Severity: Medium]
Will this logic incorrectly reject valid 4-character symbol names that start
with "arg" (like "args", "argv", or "arg0")?

If a user attempts to watch a global symbol like "argv", this block interce=
pts
it because it starts with "arg" and is 4 characters long. However, the call=
 to
kstrtoint() will fail on the "v" character, causing the parser to return
-EINVAL immediately instead of falling through to the general symbol lookup
block.

> +		cfg->base =3D KWATCH_BASE_ARG1 + (arg_num - 1);
> +	} else if (kstrtoul(dup_expr, 0, &cfg->sym_addr) =3D=3D 0) {
> +		cfg->base =3D KWATCH_BASE_ABS_ADDR;
> +	} else {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717125023.1895=
892-1-wangjinchao600@gmail.com?part=3D5
