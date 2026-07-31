Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE4C299959
	for <linux-perf-users@vger.kernel.org>; Fri, 31 Jul 2026 22:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785535926; cv=none; b=Auqs2b2WXhklbmVoWFM+hMcvN6FRhehGgFX6E7+3s4fNaNKdub8DGLK98E7UQBdWrBWJTN7ETECN2oPry6rUG5UxM3aAymxz9hzKHlvNPPrR0mYXKdVJWdgxgdvoI94YvoncNcQaOHSNslSCROjfgr0rS2TZBpBnBxe1JXhqVew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785535926; c=relaxed/simple;
	bh=XTKUR2olwpr4IAggWUn8BqhwRomnVuvqGcc74SvZTRM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dmyeHY7keTqZuYJeNYffHJvrIWMyxuYe3IOTI9gQZSu4hptWvnEefZxM6KO2FGAKKECUNhEGXRrkHKI0blMFx1GKBYA2heGHs4JsZj3+YjjWMCQMw5BzBfuC1yrrC0O1XWJD99gnjIDRyBHHXftGB3VqyynvJtGENiE4FMhaXEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFxGOMTh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFxGOMTh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654141F00AC4;
	Fri, 31 Jul 2026 22:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785535924;
	bh=nU3p3CkSqU+/5bHGnJYXBpH0Bw7uq4rVSI8tYhjdd3E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kFxGOMThPbz5J2zou4K637O2468oyHSw5jmw3HouprbXrTRAxoyK2ph0XU2jnnHyW
	 dQEfkkvosbDzAsuwCzOGdSwzhtSjuoUwelB8oJUPl9s7qxDgWu5g8nMXOOR8qTxHmG
	 Rkriht/OgDmXZrytBlw6fIa1C6i2orEQ06YPVpVa/7XG2hf16k1mwvexiI5JmSqWYB
	 Bg2ByUEvIvJvo5enKOnQRZPoTGIlVPBXhKTAPad/Nh8e4IOln+JoGKaX18lUo6CcDL
	 CWTK6g7jovTDXyVAJ2ThFT3h1I+rf6MkrA4DF8u5b/Yy7Uy1KSbOLzzXTAZ7lh8iXO
	 TTBqqsP7fWPaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf trace: Format fields with hex specifiers in
 print_fmt as hexadecimal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260731215909.125335-1-atomlin@atomlin.com>
References: <20260731215909.125335-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 22:12:03 +0000
Message-Id: <20260731221204.654141F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] field_has_hex_fmt() prematurely truncates the format string sear=
ch when it encounters escaped quotes.
--

--- Patch [1]: [PATCH] perf trace: Format fields with hex specifiers in pri=
nt_fmt as hexadecimal ---
commit 1d9edf5adf3cf666d7e9393e5db036cd73d6656a
Author: Aaron Tomlin <atomlin@atomlin.com>

perf trace: Format fields with hex specifiers in print_fmt as hexadecimal

This commit introduces field_has_hex_fmt to inspect tracepoint print_fmt
strings. If a field uses hexadecimal specifiers, it assigns SCA_PTR formatt=
ing
to display the value in hexadecimal by default.

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index ba0f8749fc7d7..b0ce9c2a24e57 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
[ ... ]
> @@ -2098,6 +2098,37 @@ static bool is_internal_field(struct tep_format_fi=
eld *field)
>  	return !strcmp(field->type, "__data_loc char[]");
>  }
> =20
> +static bool field_has_hex_fmt(struct tep_format_field *field, int len)
> +{
> +	const char *fmt, *pos, *end;
> +
> +	if (!field || !field->event || !field->event->print_fmt.format)
> +		return false;
> +
> +	fmt =3D field->event->print_fmt.format;
> +
> +	/* Limit scanning strictly to the quoted printf format string */
> +	if (*fmt =3D=3D '"') {
> +		fmt++;
> +		end =3D strchr(fmt, '"');

[Severity: Medium]
Does this parsing correctly handle escaped quotes inside the format string?

If a tracepoint format string contains an escaped quote, this strchr call
will incorrectly match it as the end of the format string, causing the end
pointer to be prematurely truncated.

> +	} else {
> +		end =3D strchr(fmt, ',');
> +	}
> +
> +	for (pos =3D strstr(fmt, field->name); pos && (!end || pos < end); pos =
=3D strstr(pos + 1, field->name)) {

[Severity: Medium]
Because the end pointer can be truncated by an escaped quote earlier, won't
the pos < end loop condition evaluate to false for any fields positioned af=
ter
that escaped quote?

This seems like it would skip hex format detection for those subsequent fie=
lds,
causing them to fall back to default decimal formatting.

> +		if (pos =3D=3D fmt || !(isalnum(pos[-1]) || pos[-1] =3D=3D '_')) {
> +			const char *after =3D pos + len;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731215909.1253=
35-1-atomlin@atomlin.com?part=3D1
