Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864A0244687
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776919846; cv=none; b=m6+gK0AnTvGHlw4JlgPaqhOlp2OzZ9TV2pdNpGGLmVH4cq9c1xqoRdmZVMqwwKA1CCbAaIt/DINzpaGB7wGEr7kTcNXi+31LvEn/xGpPYfLvp/jL/EbhbG8SVzygZ8bl83LAM0T33x6QeOWg7rilXAM/iYeS6abFUhx8tkAGMoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776919846; c=relaxed/simple;
	bh=dzq6wxvzq+IENOfQZKgl7D+mWF6lo/eJoUN58yrJSyM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YuluBUVTyypnvMToyl9KiUGsN1f5qjAgGcsg9cSH3iU19XWRPnBsmiW1wd1uSxOgdR5MwRGGHX22zvMPrmmTEAtPeVcXROC4LIOzNaYtv/C5ozP7uCNC03/YRpkpP2HWyghP65yd8nFtPnGIBxldmh+Y6xRKFHjAzTxWNM3zvBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8ed1xij; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8ed1xij"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0905CC2BCB4;
	Thu, 23 Apr 2026 04:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776919846;
	bh=dzq6wxvzq+IENOfQZKgl7D+mWF6lo/eJoUN58yrJSyM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=p8ed1xij9Gwepzi9yqK13TabMU3DgkSkNNEdGnY/XgYZueBLUI3Ymp11rWKUTiUci
	 8OspcLl4/0meNWcfq6SFu4aJGUwL8marbJXS86zJU5XYjjMyH2UWw3Cg6ukoblWLoa
	 mCeOSjveOGiUZmf/mm4KBdU0c7NrF7wpBQgsmZD9C71Fbtv2wkj90ZZMelMcy7PP61
	 IFA9hC1rd67w4WILMPGVve3i7yljf2X1E6gmu+NexvIV4gxfPYtn+FNP2EMf0407Ro
	 7dktgpsDDg02e+zKVVInn/CYJ/u+3Ah7i5x8S326XLOBgf0ZMjlDa6t7Zb+f0xG2k1
	 4Gs1zs3D8nEXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 58/58] perf python: Improve perf script -l
 descriptions
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-59-irogers@google.com>
References: <20260423035526.1537178-59-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:50:45 +0000
Message-Id: <20260423045046.0905CC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The patch fails to improve the descriptions for `twatch.py` and =
`exported-sql-viewer.py` as claimed in the commit message, and it introduce=
s additional memory leaks due to a pre-existing parser bug.
--

commit eb1bf023eba14ef9575f31d47d28eb599d1896ec
Author: Ian Rogers <irogers@google.com>

perf python: Improve perf script -l descriptions

This commit updates the descriptions of several python scripts for "perf
script -l" by adding or modifying the docstrings at the beginning of the
files.

>     $ perf script -l
>     List of available scripts:
[ ... ]
>       exported-sql-viewer                  exported-sql-viewer.py: view d=
ata from sql database.
[ ... ]
>       twatch                               Example to show how to enable =
a tracepoint and access its fields.
[ ... ]

Will the output for these scripts actually match this description?

[ ... ]
> diff --git a/tools/perf/python/exported-sql-viewer.py b/tools/perf/python=
/exported-sql-viewer.py
> index f3ac96ada1f51..6d526a2502ca1 100755
> --- a/tools/perf/python/exported-sql-viewer.py
> +++ b/tools/perf/python/exported-sql-viewer.py
> @@ -1,6 +1,6 @@
>  #!/usr/bin/env python
>  # SPDX-License-Identifier: GPL-2.0
> -# exported-sql-viewer.py: view data from sql database
> +"""exported-sql-viewer.py: view data from sql database."""

Looking at read_script_info() in builtin-script.c, when it matches a
single-line docstring, it breaks out of the quote-matching loop but fails
to break out of the file-reading while loop.

Because both twatch.py and exported-sql-viewer.py contain subsequent
triple-quote blocks later in the file, does read_script_info() continue
scanning and overwrite desc->half_liner with those later blocks instead of
displaying this text?

If so, does this also leak the memory allocated for these new descriptions
when strdup() is called again without freeing the previous allocation?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D58
