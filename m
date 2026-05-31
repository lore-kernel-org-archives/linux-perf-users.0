Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80D11DE4EF
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 05:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780205797; cv=none; b=rRhAowHv+sFCSTSdQeW98Iyl7365PGKL1jAm6c8R8GW22UoyWgbDJxLUnsbFedAUKAgEDMLQx86KXIb1jyR2PGM4P8WhOsDNXP9fNU2AM6ko/UsJ3nJrA0WSSdw9Tk0R1zXstjdd2J4ZGzT45wXPzCSbVBGR0og7EfXpFkr5q04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780205797; c=relaxed/simple;
	bh=9nzmfyhOlf6DTz2S+V42bJmBM9x3kWheCs6/7K46K5g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AZCJ87DEffjjUK45ZcgKFzAT/g9LHgMNQU2HBWXj9zRhsCxEU3GzScjXm7yAx0iZ62tjgqnsMl27Iqslsz26brz8gyuXWe03YwwOk1Ra775lUnOp1qeXlvICK2FQxDJRJOF9zmWcQRnqENp3+XZ+52iZWDi4sGcvQoXjTSTzEbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mB7IO866; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mB7IO866"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528371F00893;
	Sun, 31 May 2026 05:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780205796;
	bh=ZMir0vbgt1MBP87T7NrlrBwdpG1xSFX7azIFbrvvjHs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mB7IO866UARGzAZFPzFSILZT4QNMzNxTbnrRDOMFvarVcGXTOjbDPnz9l+WucLLDD
	 dBM/aQUtHC0r69+JERRViA2OJtngiKo3EuoIgNqOF3f36zh2/fjcmDvPiQr2ImxrtV
	 nbBd7RGgYfiYCX9DQgp5PlvLWigRr1/hcPCCMV9mbM3x8xwGMB5RWOVGgQt/Wgfr9g
	 NQPcdfk/AJpkS+TGk/x66UcdxsA9PCMzFVZIjgr9FJprJLOMM3itdhA9/zWeI8xrlw
	 tDudrY+eDatnnK3PR5lQH6czg20ieN8/Hi84gfA6sbTWv8Qo5NzvaZJxBVKB5Vk+qo
	 x0A5RERxEP1yA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/14] perf jevents.py: Make generated C code more
 kernel style
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260531052740.796087-2-irogers@google.com>
References: <20260531052740.796087-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 05:36:35 +0000
Message-Id: <20260531053636.528371F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing `/* clang-format off */` and `/* clang-format on */` pra=
gmas claimed in the commit message.
- [Low] Off-by-one error in comment truncation logic appends an ellipsis wi=
thout truncating.
--

commit f801f2e2a8b552960175ff6a93f04c89a197b0be
Author: Ian Rogers <irogers@google.com>

perf jevents.py: Make generated C code more kernel style

This commit modifies jevents.py to generate C code that complies better
with kernel formatting tools. It updates indentation to tabs, attempts to
bound comment lines to 80 characters, and updates other formatting rules.

> perf jevents.py: Make generated C code more kernel style
>=20
> Make jevents.py generate C code that complies with formatting tools:
>=20
> - Add /* clang-format off */ before big_c_string and re-enable it
>   after system mapping tables, bypassing large generated tables while
>   checking functions and early structs.

[Severity: Medium]
The commit message mentions adding /* clang-format off */ before
big_c_string, but it doesn't appear to be included in the patch.
Did this get accidentally omitted during a rebase or rework?

[ ... ]

> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 7344940e776a6..356ac1324be05 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
[ ... ]
> @@ -450,11 +450,12 @@ class JsonEvent:
>    def to_c_string(self, metric: bool) -> str:
>      """Representation of the event as a C struct initializer."""
> =20
> -    def fix_comment(s: str) -> str:
> -        return s.replace('*/', r'\*\/')
> +    def make_comment(s: str) -> str:
> +        s =3D s.replace('*/', r'\*\/')
> +        return f'\t/* {s} */\n' if len(s) < 80 else f'\t/* {s[0:80]}... =
*/\n'

[Severity: Low]
Is the < 80 condition slightly off here? If the string is exactly 80
characters long, it takes the else branch and uses s[0:80], which evaluates
to the full string, and then appends the ellipsis without actually
truncating anything. Should this be <=3D 80 instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531052740.7960=
87-1-irogers@google.com?part=3D1
