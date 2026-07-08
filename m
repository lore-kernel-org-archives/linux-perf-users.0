Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F50309EE7
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jul 2026 13:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517817; cv=none; b=JHogQF8QWeq1cAtJiR96Z0ApZlaOlQ5RWlOxH7amh/PUk8Lxyaoo82g8yfbhza5oXQ2xrJIQjyMBXlFApy9Iaz1oOHTw7N0P1CJcD4gcfxmtQ8IqPxUZ1cPSoJA09cvGfPhDxbQA9Wn9BTGDesNXCOSvSfXXqSc9Bg6Fbhoq8ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517817; c=relaxed/simple;
	bh=YiBc00cE4gIf4hvYV/D+tTzU2KTSlMuOVy0UJ0GYdp4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p5Gk7S3D/4Um5yfLIjzJYtQR6WCCp5HPSPNRfGlTZ/T1wXmz3NKMeUuwr4WAUV9gRn9+Go+xcpR9WCfu4zs6yB7ocj/qDpF5mpE3ZyME90r1q0+/YYk1+FRqyncV+QvINn0M19NoH2vm8hTPNKUVbtc0SnwzgxcLj5Eb5+A1tA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rcat3iGI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rcat3iGI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107611F000E9;
	Wed,  8 Jul 2026 13:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783517816;
	bh=2EAOlsl5H9VQzeDpft/+hFJe+aSz+5FtnfHhFU+LGHk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rcat3iGIEKj0cpXRxDiDQF0/b6fzzSkNSzAj+ota1u7i34/g2jEXFokaezHjcZQZU
	 TCucjwKE+k9Fi+EypwRTGTZW5ut7q7W5E1sL6ZeQ4H5bX1Ynf++jeCzBEMxE/h4J44
	 PsZ9i7eDrhej7htBA3hc+o24/Df+sHjgoFEz2bNGbQlxZ8xKSiYpCejoNK9u308lt1
	 J1Z29Q3U268OPnLOyPPcBws/H7ooM2kYzoH/ehKDNQptCKPiUgqEsfFDojpoH851he
	 YwP+6amYU6sj5NQeiHP7azk9k8IbmwvwpYtjLRlFcm/fERNM5Vdac40yERfCezOnog
	 LqA1VG1G45xBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf stat: reject --field-separator and
 --json-output combination
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ivan Lazaric" <ivan.lazaric1@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260708131359.71732-3-ivan.lazaric1@gmail.com>
References: <ak3scJT4MfbAg0G4@google.com>
 <20260708131359.71732-3-ivan.lazaric1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 13:36:55 +0000
Message-Id: <20260708133656.107611F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing explicit inclusion of `<stdio.h>` for standard I/O function=
s and types.
--

--- Patch [1]: [PATCH v2] perf stat: reject --field-separator and --json-ou=
tput combination ---
commit 14ca4ce3700a93ed48a3336a633292f7e45ae462
Author: Ivan Lazaric <ivan.lazaric1@gmail.com>

perf stat: reject --field-separator and --json-output combination

This patch explicitly rejects using both the --field-separator and
--json-output options in perf stat. It adds a check to output an error
message and exit cleanly, preventing malformed mixed formats.

> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index a04466ea3b0a0..6ec82752d71c6 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2643,6 +2643,13 @@ int cmd_stat(int argc, const char **argv)
> =20
>  	stat_config.aggr_mode =3D opt_aggr_mode_to_aggr_mode(&opt_mode);
> =20
> +	if (stat_config.csv_sep && stat_config.json_output) {
> +		fprintf(stderr, "cannot use both --field-separator and --json-output\n=
");
                ^^^^^^^

[Severity: Low]
Could this cause a build failure when compiling perf with musl libc?

While glibc often implicitly includes standard headers, musl has stricter
header separation.

Since this code introduces a new call to fprintf and uses stderr, does
builtin-stat.c need an explicit #include <stdio.h> in its global includes
block to guarantee musl compatibility?

> +		parse_options_usage(stat_usage, stat_options, "x", 1);
> +		parse_options_usage(NULL, stat_options, "j", 1);
> +		goto out;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708131359.7173=
2-3-ivan.lazaric1@gmail.com?part=3D1
