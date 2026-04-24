Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD98D22FE0E
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777052135; cv=none; b=jivYRu4+eiY1EP0bzp5RNRx4NIMW3ssMfzNOK46uxLxEzV8MsJiVdHgTyD+5xrzkmHv7f4qi2EN7HOl7X97zf4B76ncUbFTROYaW8osrziQm2g5h5N39BJie0AP+OqWSqzjznGQTvZXZiUyvUaLjeHWNOWTKE2nX9xDeGXmn1xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777052135; c=relaxed/simple;
	bh=yi/YkUZlHER1r3azo+snk8bWUFKHmCekW69pBEIY1xw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p2Gn5TshadijyJguIvUyG1xclWiyvEdSxFG901PufEO+f8G6NXQd5fPrrQDhJ53OZGZMiiaRYAopbwFgE/AYQ9s/FJ4xwbn27+ggEk3zXBcLTkFWclR2ejhbN17Y8C02AIyHJXypkAdTuzRsmIxIPQgeoPf5BP01wPS4OrMvMBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/Ii87/2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/Ii87/2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82460C19425;
	Fri, 24 Apr 2026 17:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777052135;
	bh=yi/YkUZlHER1r3azo+snk8bWUFKHmCekW69pBEIY1xw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=J/Ii87/2abkHtvQeYHhVestTinRJjMzsNL3pHagkKUnuTDmkxWMvG7rWvvQ8Qvkj/
	 g2Wj56MflU7r0xjngpC2silL89zKvaQP4ZxlztlQmt8AZYmF0TJKFq6+e4yyInMKaz
	 lUcZHdxAewW7qsRh/oUISUUGn9qBK+4zwJ6jv7o0bjIISDgP+UFJUlQOlv8z/FAVUq
	 xjyCfWAIWa8OYKVX5FUDVz6gcO4cLo2RFqYBHsEcG0770xUec3xSBikrmjomsFOsSF
	 RrPXZ7S+jDgjIBr8zUDWVYgJEjWuGStzTelvINemeEAY4GIkjY3UGBovJtTdsOSZqN
	 Vk0OAT+BL8siQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 58/58] perf python: Improve perf script -l
 descriptions
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-59-irogers@google.com>
References: <20260424164721.2229025-59-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:35:34 +0000
Message-Id: <20260424173535.82460C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The commit message claims to update the descriptions for `twatch=
.py` and `exported-sql-viewer.py`, but the updates are ineffective and resu=
lt in a meaningful mismatch between the commit message and actual behavior.
--

commit 95fbe28eb15f529282a5c7b545c5be06fa83c1a1
Author: Ian Rogers <irogers@google.com>

perf python: Improve perf script -l descriptions

This commit adds docstrings to several Python scripts in the perf tools
to improve the descriptions shown when running "perf script -l".

[ ... ]
> diff --git a/tools/perf/python/exported-sql-viewer.py b/tools/perf/python=
/exported-sql-viewer.py
> index f3ac96ada1f51e..6d526a2502ca13 100755
> --- a/tools/perf/python/exported-sql-viewer.py
> +++ b/tools/perf/python/exported-sql-viewer.py
> @@ -1,6 +1,6 @@
>  #!/usr/bin/env python
>  # SPDX-License-Identifier: GPL-2.0
> -# exported-sql-viewer.py: view data from sql database
> +"""exported-sql-viewer.py: view data from sql database."""

Will "perf script -l" actually display this description?

Looking at read_script_info() in builtin-script.c, when it matches a
single-line docstring it copies the text and breaks out of the
quote-matching loop, but fails to break out of the file-reading
while loop.

Because exported-sql-viewer.py contains subsequent """ blocks later in the
file, won't the parser overwrite this newly added description with the later
text, leaking the memory allocated for the first string and preventing the
intended description from being displayed?

[ ... ]
> diff --git a/tools/perf/python/twatch.py b/tools/perf/python/twatch.py
> index 04f3db29b9bc18..e50cc2feb58a36 100755
> --- a/tools/perf/python/twatch.py
> +++ b/tools/perf/python/twatch.py
> @@ -1,5 +1,6 @@
>  #! /usr/bin/env python
>  # SPDX-License-Identifier: GPL-2.0-only
> +"""Example to show how to enable a tracepoint and access its fields."""

Does this suffer from the same issue?

Similar to exported-sql-viewer.py, twatch.py also contains subsequent """
blocks further down the file. The pre-existing parser behavior might cause
this update to be functionally ineffective, resulting in a mismatch between
the output claimed in the commit message and the actual command behavior.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D58
