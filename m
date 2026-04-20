Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B53A54652
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776644455; cv=none; b=B8ngzPm522Ebb8NVOeAYXG+GAIczveIBMxtdvwhu6q0dPE1l8Av07dX+R7hiAOJrcdfGFywK2hwnP6xB4PzpuN+VYChcp7FWAMyC4GXFOjhaU6whXHkRo4HWZgBa1sfdyAPS3iCSRPl+/cVA9N7Db7eedBXxTvCEs5rC84JrYIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776644455; c=relaxed/simple;
	bh=O0VmDtpxwnOzEbRwGZfmBHUg7GiuBupA7b0szuULKfw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kMtH2c2B9pGGwtOcNNnMLu6ghB+SpgCZCnD7/qkmQsRDMXKKHSj4VOttOJoQCg7lur2kbbXQ7y4BTAC1TyoD4WxcFRvC3om01AuQKkHGZKgGm9Qqtp/vG2imzc/a/rpKVFIPqN1/yD1kPxvl9Ko6mzBS+WAEpPWYjmFjV9SJC6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3e7UkEF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3e7UkEF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33010C2BCAF;
	Mon, 20 Apr 2026 00:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776644455;
	bh=O0VmDtpxwnOzEbRwGZfmBHUg7GiuBupA7b0szuULKfw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=N3e7UkEF+skg2RfRiuX6LGTsrpM5jsui3Bw8P5smYIBvYicnf+nueMAz9NYkCVkqt
	 8nJ+9bavSf6FJxJ8cWTUq7ySJp/DTr5WW5EJzNXaleB2I+cd5RxJVMLbxwkUWTIm+X
	 WJ9780nBarXU5sdIuimNbFOU1u/LF5tKhnQ8tlk2cb1lf6DazGTyRwv7ZPlRsQ+sPD
	 4VkmiJkaFD5qetK1Xjr6ZbL3ETnD7OCmNzW8fl6BUNIMTXTL98ne8H4j8w+owYDu/W
	 gChx+cSvSnhm8XbgHWS17uE8xUX7mWygZKV8uMdRKzGDORevxnWbKndHu2vFLyi54N
	 XukujEXdgP87g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 06/58] perf util: Sort includes and add missed
 explicit dependencies
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-7-irogers@google.com>
References: <20260419235911.2186050-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:20:54 +0000
Message-Id: <20260420002055.33010C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Low] Inconsistent include path prefix cleanup for hashmap.h in stat-shad=
ow.c.
--

commit e221e930350cab6bed86340ed82955a75d841278
Author: Ian Rogers <irogers@google.com>

perf util: Sort includes and add missed explicit dependencies

This commit adds missing includes found while cleaning up the evsel and
evlist header files. It also sorts the remaining header files across various
utilities for consistency with the rest of the code.

[ ... ]

> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index bc2d44df7bafa..2f68f02dbc431 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -2,20 +2,24 @@
>  #include <errno.h>
>  #include <math.h>
>  #include <stdio.h>
> -#include "evsel.h"
> -#include "stat.h"
> +
> +#include <linux/zalloc.h>
> +
> +#include "cgroup.h"
>  #include "color.h"
>  #include "debug.h"
> -#include "pmu.h"
> -#include "rblist.h"
>  #include "evlist.h"
> +#include "evsel.h"
>  #include "expr.h"
> +#include "iostat.h"
>  #include "metricgroup.h"
> -#include "cgroup.h"
> +#include "pmu.h"
> +#include "pmus.h"
> +#include "rblist.h"
> +#include "stat.h"
> +#include "tool_pmu.h"
>  #include "units.h"
> -#include "iostat.h"
>  #include "util/hashmap.h"

This isn't a bug, but I noticed the "util/" prefix was removed from
hashmap.h in other files like evsel.c and stat.c, while it remains here.

Should this be updated to just "hashmap.h" so it sorts correctly under 'h'
instead of 'u'?

> -#include "tool_pmu.h"
> =20
>  static bool tool_pmu__is_time_event(const struct perf_stat_config *confi=
g,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D6
