Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A7D38C2B3
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158325; cv=none; b=RlE/3oGlDFAv4pomI32apnklZRrK8oxSLhz6J52Vq+fFxoSLYxpSNwwXkgFjpEhKsuaYRLjdZKru/WIse1IMS/sQiQTneXdjYOm6wUDRa2DZJh863JkDlgleJ4Qv3tKGffj6YNJh1fq0XaSFvhuW1QYcnr81CknFEqNFYI4PW80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158325; c=relaxed/simple;
	bh=Aukyi9CNkV/M3PA0lOGsOQQkoUgNx9jg+4XUePmgNzA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YVmQ1+lrE1j3n3PqOWAg6qYXEceULtHMuV65wATyJCVhmf9/wFMyHu0BMeTxZz9V7Z9HN+equRUh5JxAijrW+iW5xDTOqhvK5E9rUU3BZVetuNrYggjhldFxYuW7dr4GEm+dJaEe/JW3tYd6pI3nq0WJWDhaIjroG9MYUfQjcIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSXLnGaY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSXLnGaY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4BBC2BCB0;
	Sat, 25 Apr 2026 23:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777158325;
	bh=Aukyi9CNkV/M3PA0lOGsOQQkoUgNx9jg+4XUePmgNzA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=gSXLnGaYyJthsFLjOswNS97aWY8QGC3LYZ3gg+P+X5BmK9X+dTZDFqMNtzIaq2ab/
	 b4ObSylYqnUqmTY3PtmajT1si7TJ4F1bl/lPhbx/R9EHaxry81P4FMiUZSMDhbz3Qh
	 TsLYaXGVQktdfkNG3WlF/oZA0qAxgTNYQpk0FT6d54sOrbEyUDEEXrzB98i2qL3Q6u
	 yN68LQq2+TNg65MUHtfxuZjHQHkZ31sR4IPLe4GfZzNGhiixqB29LGC89fdfrMa/Jj
	 0uuE3rtvaf1H4GgH+sJb9B0yNXpqxSI+KjTMKv+/PjceqfIiE6ig2A9keeJhn18A35
	 1Wu9jPxqQZIlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/59] perf arch arm: Sort includes and add missed
 explicit dependencies
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-3-irogers@google.com>
References: <20260425224951.174663-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:05:24 +0000
Message-Id: <20260425230525.6E4BBC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Low] Incorrect primary header identification during include sorting. The=
 patch moves `../../../util/cs-etm.h` to the top block and pushes the actua=
l local primary header `"cs-etm.h"` to the very bottom.
--

commit febaa4aba550b6cb11c26a233479adf942c73a27
Author: Ian Rogers <irogers@google.com>

perf arch arm: Sort includes and add missed explicit dependencies

This commit adds missing includes found while cleaning evsel/evlist header
files and sorts the remaining headers in cs-etm.c for consistency.

> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util=
/cs-etm.c
> index b7a839de8707..cdf8e3e60606 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -3,10 +3,13 @@
>   * Copyright(C) 2015 Linaro Limited. All rights reserved.
>   * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
>   */
> +#include "../../../util/cs-etm.h"

This isn't a bug, but did the sorting logic mistakenly identify
../../../util/cs-etm.h as the primary header for this file?

A source file normally includes its own corresponding header file first
to verify that the header is self-contained. Since this cs-etm.c implements
functions declared in the local "cs-etm.h", that local header would
typically be the primary one.

[ ... ]

>  #include "../../../util/session.h"
> -
> -#include <errno.h>
> -#include <stdlib.h>
> -#include <sys/stat.h>
> +#include "cs-etm.h"

Should "cs-etm.h" be placed at the top block instead of being sorted to the
very bottom of the include list?

Leaving the true primary header at the bottom bypasses its self-containedne=
ss
check, as the compiler has already parsed all the other system and utility
headers by the time it reaches this one.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D2
