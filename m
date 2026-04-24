Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D322D3CF66B
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050538; cv=none; b=jTTWdo+dqI4sC6SJhCtPbOiK9OgFbN2mkmUyP69ufDBTa6jLg2doP82USwRD2GcflsaGasEIpyHrwHTxo8U8X17s37bLgVNG8r7J27jJVsnriXZTPhQ84ulir/Z5lIO1p58UDFjWkaSVKuxLxGagqTNHJ5Y+aZHp1e02QGaeb7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050538; c=relaxed/simple;
	bh=itZsqRm0hufhndv+brrlj1DGAzqR95NzaCgYqF7P7ho=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fJPjGA5z/nWqRPZhiq2ZY0rdQb4WUcZCE7TKEXOxg3FaNpCjk0XggUdq3TOLK+mCoz0VgFZ/cPJvJnnaLe8ER3GQVevDACZJD7xl8Eu6CaYltopZ/Y6fUOrCTC+/r31vIOutDgqTniGgKccXQPjy/LzPrL0x7kxcNIvoQ0ajq+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQB79WIz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQB79WIz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BB9C19425;
	Fri, 24 Apr 2026 17:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777050538;
	bh=itZsqRm0hufhndv+brrlj1DGAzqR95NzaCgYqF7P7ho=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=DQB79WIzlDCnW5TK++52xbAy4dTRe0XTUrk3fHeJOExUbw9bdpT9yklFTZEUWv6hd
	 eA5ZTSUHbzQsmyOAaiuCse1fP//0XGnN/b4Y3JaGB8JEtLQNxNSkrrPxAnBkXl9zhR
	 S5G0pAnr1/KlF6+vHevwWTmjLyhJzCYU3KzVRbf/V9MSbmhh5ZKlbndWmeSU14/Zhl
	 RaxhPHb6cI8MRbJ2NfsMk9c8kmlHXdv3DLN15gKrENaD+ZwJHjjkRk+S9QiJp6tl4q
	 CP9SbvBUunjo5ESrI6zovy14h0Dq5J3E7VAhf72XcWo5teDTAbVdchA/Vq6km3eThF
	 WmUKhiRp+hXbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/58] perf arch arm: Sort includes and add missed
 explicit dependencies
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-3-irogers@google.com>
References: <20260424164721.2229025-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:08:57 +0000
Message-Id: <20260424170858.62BB9C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Low] The generic utility header `../../../util/cs-etm.h` is mistakenly p=
laced at the very top of the file, while the actual local primary header `"=
cs-etm.h"` is relegated to the bottom.
--

commit 9e010dab2620eb3c40fc54789365c1d0f47e3438
Author: Ian Rogers <irogers@google.com>

perf arch arm: Sort includes and add missed explicit dependencies

This commit fixes missing includes found while cleaning header files and
sorts the remaining headers for consistency.

> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util=
/cs-etm.c
> index b7a839de870755..cdf8e3e6060670 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -3,10 +3,13 @@
>   * Copyright(C) 2015 Linaro Limited. All rights reserved.
>   * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
>   */
> +#include "../../../util/cs-etm.h"

This isn't a bug, but standard practice dictates that a source file should
include its corresponding local header file first to guarantee that the hea=
der
is self-contained.

Was the generic utility header ../../../util/cs-etm.h mistakenly placed here
at the top instead of the local primary header "cs-etm.h" due to a name
collision?

[ ... ]

>  #include "../../../util/session.h"
> -
> -#include <errno.h>
> -#include <stdlib.h>
> -#include <sys/stat.h>
> +#include "cs-etm.h"

The local primary header is relegated to the bottom here. Should "cs-etm.h"
be the one included at the very top instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D2
