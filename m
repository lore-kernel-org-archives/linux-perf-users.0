Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1950235F5FB
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 11:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779363492; cv=none; b=mv/otssmPogwkzQ4nNquY8MLm96rqyTkmwW/OSV0RsXIZ65LB+WWPI2b0xZZIJHTmz9WBvpWf7OanfteeX8hr3nzjdk6hTaRduaR5dxypsHXvfTHpsTWGjdUvHT614qK8PDA6Xulc+5WNsmLm/6qTWekerdw28R8s0esjzx2NcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779363492; c=relaxed/simple;
	bh=TMWCW5hTceqttJL1ckArMeadhJb2uOOuAJfcfxAt09Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GphU295tBABb9pT6UEZCPdotEF+L38XaeTkQJQlnuR7aSqNAPXC1ylEPlpaw5FkUANiI+Kh5vm9TIURfOyp8lj9+9LzdAOteZcfxlTNL/BnaZLLdtOfGt0w/T9cg3ly5O0TMHeOViGGB+mFpXS5iarkhuefL9cxRr4eeLyB7HCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Av4wX6B9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Av4wX6B9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BAB1F000E9;
	Thu, 21 May 2026 11:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779363490;
	bh=U82/xZQO0kTKcLX/3Y31h7VnDL+e9iYZYvibXkGf7DA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Av4wX6B9c9IsFy1O9L1Zc6q1FMiS93YhqrmXzCc8UyKwNLUgyXOGR42kNQRVTvKiS
	 eK6fKxpaD/a+0USKxKrbZimGgd7Q+uXk8m/1BghKoQ2RosjXFZ3gQsfJSwgabC3J9d
	 VQTuKHSsSb1RqlsGw7EjoCIptqXlYuapqyUlOfcxc+3z4s4IrSgycoZlVhqHqhhYGD
	 7n7fQaxk1ZHuzz3bYdczTY7jtiyR+cGG9PmLBb9Eg3sZrBsI65zL6Y3c8K7aDmuVYy
	 +eKF0fS4hOIYD/M146P2Rtr7W+fp73gg1aHP12ZyReYZlgFal2cJ215uqnuYmlylAl
	 +bJ/chM5Ekq7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf: Fix off-by-one stack buffer overflow in
 kallsyms__parse()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rui Qi" <qirui.001@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260521111429.4042238-1-qirui.001@bytedance.com>
References: <20260521111429.4042238-1-qirui.001@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 11:38:10 +0000
Message-Id: <20260521113810.A5BAB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Parser desynchronization causing valid symbols to be skipped whe=
n encountering symbols of exactly KSYM_NAME_LEN length.
--

commit 6a5c6924aa13657b35988b3648db68dd1a6e6f83
Author: Rui Qi <qirui.001@bytedance.com>

perf: Fix off-by-one stack buffer overflow in kallsyms__parse()

This commit changes the loop bound in kallsyms__parse() to prevent a stack
buffer overflow when reading long symbol names. It ensures the null
terminator always fits within the symbol_name array bounds.

> diff --git a/tools/lib/symbol/kallsyms.c b/tools/lib/symbol/kallsyms.c
> index e335ac2b9e197..f7100d43ecf49 100644
> --- a/tools/lib/symbol/kallsyms.c
> +++ b/tools/lib/symbol/kallsyms.c
> @@ -60,7 +60,7 @@ int kallsyms__parse(const char *filename, void *arg,
>  			read_to_eol(&io);
>  			continue;
>  		}
> -		for (i =3D 0; i < sizeof(symbol_name); i++) {
> +		for (i =3D 0; i < sizeof(symbol_name) - 1; i++) {

[Severity: Medium]
Will this change leave a trailing newline in the stream for symbols that
are exactly KSYM_NAME_LEN characters long?

If a symbol name is exactly 128 characters, the loop terminates without
reading the newline character since the bound is now restricted to 128
iterations.

When the outer loop continues to the next symbol entry, io__get_hex()
would encounter this leftover newline and fail. This triggers the error
recovery path which calls read_to_eol(), skipping over the entire next
valid symbol entry.

Could this cause the parser to silently drop valid kernel symbols when
it encounters symbols of exactly this length?

>  			ch =3D io__get_char(&io);
>  			if (ch < 0 || ch =3D=3D '\n')
>  				break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521111429.4042=
238-1-qirui.001@bytedance.com?part=3D1
