Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1941240312A
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 18:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778868948; cv=none; b=sWO3TrmYcmNJf9TPP8+BzMiRE8Pe3TV/7bLM99ho7mcUQc7pDTYthA4GDqVq8swvarBnVZv3eR8Hndrt9PgrXkJ03H3qVLJdLuxlZo+/PPggm3SbKN1TlYwP4z/Eqlq6JV4uykbktz92Fft8CgDW/2taYbiAz0O9gD8f4lMOp7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778868948; c=relaxed/simple;
	bh=RCy9qd+GLgoMXy1TzjRQ23yeH1NYIZnKP58HXQMslYo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T/QzjgjHN3uiGbp8Z9I87PtvxrvI9Drgr+sMKck5U3k3VYGAmtGDU2oXYOpxBHNfXH4UyirbG+ulq5cQaeGOK+3FQwsI3pTEV4NbUbSwtwahUMpNZhOMyhbIb84hbv0Y4QM92itRDNIhavcgBzbaJkTU4CP0WsyUuGp72BUl7mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6GmE0kH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6GmE0kH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D82C2BCB0;
	Fri, 15 May 2026 18:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778868947;
	bh=RCy9qd+GLgoMXy1TzjRQ23yeH1NYIZnKP58HXQMslYo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=R6GmE0kHdqiahK8Yr2+sPQI02DN6Djvqx/JZiUxeiSrrBTHQ8wGkswjii3lJL6ctv
	 fDpi59AeZ/A3f6R2BwG7bE0kofVWZjYzy4iEoncytA9DchDcS0ydWNhvRA7YZihfih
	 E53BqdHFiL1rI7x2dIVDYJMnpwl5Vnsy23jBJX2KvuEXKd/NDmpTdc2I+27X1DRDgs
	 y0lka6l13EdfB5WMwkz+csBHGxYNyp5Qs2qU32SRX+WsfOdnFEYZmEeyCGIePpTpRU
	 ZMUmf09vr4vWeTE8nTAHBl4SrDhep19Sh+Di+xJ3vyMKLRhUUCMRY+VRkiJZHS4Ofj
	 AD8am1ea9g3Dw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] treewide: replace /usr/bin/python3 shebangs with env
 python3
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oli R" <sigmatwojastara@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260515180806.246914-1-sigmatwojastara@gmail.com>
References: <20260515180806.246914-1-sigmatwojastara@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 18:15:47 +0000
Message-Id: <20260515181547.99D82C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Commit message states it replaces `#!/usr/bin/python3` shebangs =
and causes no functional changes, but actually changes `#!/usr/bin/python` =
to `#!/usr/bin/env python3` in `tools/perf/tests/shell/lib/perf_json_output=
_lint.py`.
--

commit 7d3e9689ede53be80434b3ba8cd07c27777d11ad
Author: Oli R <sigmatwojastara@gmail.com>

treewide: replace /usr/bin/python3 shebangs with env python3

This commit replaces hardcoded /usr/bin/python3 interpreter paths with
/usr/bin/env python3 to improve portability.

> treewide: replace /usr/bin/python3 shebangs with env python3
[ ... ]
> No functional changes intended.

Is this description accurate?

[ ... ]

> diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/=
perf/tests/shell/lib/perf_json_output_lint.py
> index dafbde56cc76f..dccafd507bb79 100644
> --- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
> +++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/python
> +#!/usr/bin/env python3

Could this affect functionality on systems where python defaults to Python 2
or is managed differently?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515180806.2469=
14-1-sigmatwojastara@gmail.com?part=3D1
