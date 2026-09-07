Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0FE38A72B
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Sep 2026 02:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788746604; cv=none; b=C2F0HO9Ni1jCj3gqEu+6jWqJOMPMavD55zh7QWJJ9+/Zv8gW2E42SjxLV8N3skFKlulFFyvtfvSR1P0OljrS4Ii0tyFwMOfeDXVII7xxXLbdhPbRnkIRKkpBmeBq6jgQC3AawLxpdSezHd2daRQGPiz7p7wD+7WWA+gYqyvj75U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788746604; c=relaxed/simple;
	bh=+1O1LWdh5pmYrRSNLyxma1b6n8FQtASUuJJNkjgMssQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r/ZoUjYSQG1dao17QrPybo+sMirujeHjMGmbeQHh6UYnZsrG1FlpaJCEvJx63fPzG2lxeiIEtgkGlzkwPixnzlrFf6ZDQLEI4/6kSL8FgMqCpnbeMZ/DY5OhWBFTLqfvMNCNUjS9m/hZDhH2XqqsnfJ0X8Se5SX3my3wF41ICQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mv5TuxqY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mv5TuxqY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE021F00A3A;
	Mon,  7 Sep 2026 02:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788746600;
	bh=y7G2DznOkdjy6P2TSH3fFs13UgDGJJdRUQtLbaEKvGI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mv5TuxqYJ2+IM+DykzaG4xxlYK3UIst9A87t9NJ75SQnuRZDrt6EcRWNpSno9oi1V
	 OaMNvbct2FxhAmwchnV3PcmpkGZnEFF0v22sev30TNVepUESEMAfe4pnFSwM9nDvSa
	 56Lbuz4QCoKzei7jn5GXQ0VwGBN2xYlyJgUYt7Q0B4enCoZmpcx9hQI0u3h06qYmvy
	 oPcUpy4r8zVqqS09OaoSP7gdoReJ7aUbrJfvAU3Qbdr0VSTTYrecWLgHEQBycBkE1t
	 xUh+JUoRoDB2uHm9R+DKGUAjY78IRJkjbqivQpIDQ4GXgGdHmvdUpxqzDjDf9Zf72a
	 A13Url/iAUbVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 perf-tools-next 5/6] perf trace beauty: Validate
 payload size in augmented sockaddr beautifier
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260907015140.363076-6-atomlin@atomlin.com>
References: <20260907015140.363076-1-atomlin@atomlin.com>
 <20260907015140.363076-6-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 02:03:19 +0000
Message-Id: <20260907020320.4BE021F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Hardcoded address families in the validation logic break extensi=
bility for future formatters.
- [Low] Missing explicit POSIX / Standard C header inclusions for newly int=
roduced types and macros.

Pre-existing issues:
- [High] Missing null-termination enforcement in AF_LOCAL socket paths lead=
s to out-of-bounds reads and abstract socket logic errors.
--

commit 229e56bcf8519abca8347b48fb3e2d0bdc74e111
Author: Aaron Tomlin <atomlin@atomlin.com>

perf trace beauty: Validate payload size in augmented sockaddr beautifier

This commit adds size validation to the augmented sockaddr beautifier to
ensure the captured payload is large enough before dereferencing address
family-specific fields. It verifies the payload size against the augmented
argument bounds and checks for sufficient bytes for AF_INET, AF_INET6, and
AF_LOCAL before formatting.

> diff --git a/tools/perf/trace/beauty/sockaddr.c b/tools/perf/trace/beauty=
/sockaddr.c
> index a17a27ac2a6ff..00c702ff4465b 100644
> --- a/tools/perf/trace/beauty/sockaddr.c
> +++ b/tools/perf/trace/beauty/sockaddr.c
[ ... ]
> @@ -47,23 +47,48 @@ static size_t (*af_scnprintfs[])(struct sockaddr *sa,=
 char *bf, size_t size) =3D {
[ ... ]
>  	if (sa->sa_family < ARRAY_SIZE(af_scnprintfs) && af_scnprintfs[sa->sa_f=
amily]) {
> +		bool valid =3D false;

[Severity: Low]
Does this file miss the <stdbool.h> header for the bool type?

The patch introduces the usage of bool in tools/perf/trace/beauty/sockaddr.=
c,
but the explicit POSIX standard header is missing, which can cause compilat=
ion
failures on systems using musl libc.

> +
> +		if (sa->sa_family =3D=3D AF_INET && augmented_arg->size >=3D (int)size=
of(struct sockaddr_in))
> +			valid =3D true;
> +		else if (sa->sa_family =3D=3D AF_INET6 && augmented_arg->size >=3D (in=
t)sizeof(struct sockaddr_in6))
> +			valid =3D true;

[Severity: Medium]
Does this hardcoded validation bypass the extensibility of the af_scnprintfs
dispatch table?

If a new address family formatter (e.g., AF_NETLINK) is added to the
af_scnprintfs dispatch array in the future, it appears it will never be
invoked because the hardcoded validation logic only explicitly recognizes
AF_INET, AF_INET6, and AF_LOCAL.

> +		else if (sa->sa_family =3D=3D AF_LOCAL &&
> +			 augmented_arg->size > (int)offsetof(struct sockaddr_un, sun_path))

[Severity: Low]
Does this file miss the <stddef.h> header for the offsetof macro?

Similar to bool, the patch introduces offsetof but fails to explicitly incl=
ude
<stddef.h>, which is required for musl compatibility.

> +			valid =3D true;

[Severity: High]
This is a pre-existing issue, but does this newly introduced validation fail
to enforce NUL-termination or bound the string length for AF_LOCAL paths?

This explicitly marks the payload as valid without ensuring NUL termination.
Later in syscall_arg__scnprintf_augmented_sockaddr(), the formatter is call=
ed
without passing the actual bounds of the captured sockaddr payload:

tools/perf/trace/beauty/sockaddr.c:syscall_arg__scnprintf_augmented_sockadd=
r() {
    ...
    if (valid)
        printed +=3D af_scnprintfs[sa->sa_family](sa, bf + printed, size - =
printed);
    ...
}

This leaves af_local__scnprintf() unable to safely bound the read when
formatting sun->sun_path with the "%s" specifier. If the captured payload in
perf.data lacks a NUL terminator, scnprintf() will read past the validated
bounds of the augmented_arg buffer.

> +
> +		if (valid)
> +			printed +=3D af_scnprintfs[sa->sa_family](sa, bf + printed, size - pr=
inted);
> +	}
> =20
>  	return printed + scnprintf(bf + printed, size - printed, " }");
>  }
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907015140.3630=
76-1-atomlin@atomlin.com?part=3D5
