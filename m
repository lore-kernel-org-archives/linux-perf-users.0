Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA48444C664
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 18:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784570729; cv=none; b=d6upxLToQMjywLklzmFZUcxVLRpJ0L8T0HLf6TOFsBt4EIvetkYkcKAKcMl7D/6t96su3dY1Uq8UWitj8mhV3aJTzifq7SQ4sh/JtLXnphRbs0fdcCynaJnrPC743XNzbm7qI7YMJs7qHxAIcYsb+P3qACXByJYa/LhjtA9goVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784570729; c=relaxed/simple;
	bh=j55SzFn/Q8YLV6xouMWbDAXope2V9aOm67PL7YNRsEc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iePo4OzGbXDdZK85CzhxXb/nBVPCgB0pGGNg65eeO5LAQeIMLRg+ZGBJfziS7iTqD9XuGmWo7Lp1pDIJnsOQTkTX7oHTb4MxRn98f+lpxQctagI/f5igBAOXQzkRrR6KUP+QrrFtfjAqPmshdi4rdAfez20mgpsURO8ujscje9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7p61VoF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7p61VoF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F3C1F000E9;
	Mon, 20 Jul 2026 18:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784570727;
	bh=QVhmQ0916iVucpV+L+v34SXc7msbW1tZLgfpFS04mdE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c7p61VoFdzoSdRmhQtTuQh/LReB4v1t124zmTK0oJqPhDetxoNbJgAVMbgwcBqDE+
	 XStel7bReinl5V7CpaJLaDnULPd7t0eA5FC7F4vpKcOcK9BC0z58g0ysHuMlxnJbP6
	 oqlCSXm9hjD8pUQlB5PxDbXarQcIssv9pU5IOGVvE6WhKlkNdWjmUiCS2MZX8o8YPZ
	 5ng6q4rsLeXwBtrC8iITkQUZI9xAdzKiC4cmyXuN6Bu9FIaIH4HN5b4DM8Mk0GcZ8Z
	 46pqQ1dQ3exZC/LHlKEptJPja3Cp+Ndcr3kIlOa7ct/MYQ+4IM9kVJaoL/KXGSRkuP
	 EoaERybqx4fFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/4] perf find-map: Remove PATH_MAX 128-byte stack
 array restriction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260720175455.3645946-2-irogers@google.com>
References: <20260720175455.3645946-1-irogers@google.com>
 <20260720175455.3645946-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 18:05:26 +0000
Message-Id: <20260720180526.D8F3C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `read_ret` variable is assigned the result of `getline()` but i=
s never subsequently used, which triggers a `-Wunused-but-set-variable` com=
pilation error.
--

--- Patch [1]: [PATCH v1 1/4] perf find-map: Remove PATH_MAX 128-byte stack=
 array restriction ---
commit 9da3c5d9150546a40fb376c8547c0725fc587af7
Author: Ian Rogers <irogers@google.com>
perf find-map: Remove PATH_MAX 128-byte stack array restriction

This commit updates the find_map function to dynamically allocate the=20
line buffer using getline. This prevents potential buffer overruns=20
associated with the previous 128-byte stack array limitation.

> diff --git a/tools/perf/util/find-map.c b/tools/perf/util/find-map.c
> index 7b2300588ece0..4d740b32814f8 100644
> --- a/tools/perf/util/find-map.c
> +++ b/tools/perf/util/find-map.c
[ ... ]
> @@ -1,8 +1,14 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
>  static int find_map(void **start, void **end, const char *name)
>  {
>  	FILE *maps;
> -	char line[128];
> +	char *line =3D NULL;
> +	size_t len =3D 0;
> +	ssize_t read_ret;
>  	int found =3D 0;
> =20
>  	maps =3D fopen("/proc/self/maps", "r");
> @@ -11,7 +17,7 @@ static int find_map(void **start, void **end, const cha=
r *name)
>  		return -1;
>  	}
> =20
> -	while (!found && fgets(line, sizeof(line), maps)) {
> +	while (!found && (read_ret =3D getline(&line, &len, maps)) !=3D -1) {

[Severity: Low]
Does this leave the read_ret variable set but never used?

Because perf is typically built with -Werror, this unused assignment
triggers a -Wunused-but-set-variable compiler warning which gets promoted
to a build failure.=20

Could the read_ret variable be removed and the loop condition simplified to=
=20
just evaluate getline(&line, &len, maps) !=3D -1 directly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720175455.3645=
946-1-irogers@google.com?part=3D1
