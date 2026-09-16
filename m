Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846E94C33F1
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 23:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602890; cv=none; b=YQQNJcXUcCpNxpIWizROfEKhMIqK94HqDDsmJrQ90O3SliDFUETZv8H6bRFapAzhOKNccWTRJTyzzHXB1aeHf9AnjltT3IHrs/4eoW/rG/FqbcNcTHEjiXbvQvOnbwBfXSDjwrZdaeU7CFbxbjvqLmiZ43hWqFy23xmQ5n1eeS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602890; c=relaxed/simple;
	bh=1js9b49hEfFetNfOQkOa0pO8HEmj+2i8wTA5+uwvQFU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WJp+4budpEJtPUoXdrPwO0n3Fqehb7bleeQVixQFOp7iEinN9KtD6ynXxj0s5vHdf7yXyty+gB0MbI6Z1V+oX8yh6cHvgN4F3R7XovRGwIi1mt3wR6xQYQy6JIhkBU5b94ZQbFuPnXitwUhAFpd9KNVd7r7W3xAfeR+MnV+9qvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLyYlJ+N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLyYlJ+N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703351F000FF;
	Wed, 16 Sep 2026 23:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789602887;
	bh=T5vR/g2W87VFIYQDNq1SxL/Oz0WZQMDCprtUDJoz/kk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eLyYlJ+N0mhsf4zAf7kVBSSiszuLyFpb/gxE1gjfVvDhekaTK05YKqMoKDbKbeyPK
	 Cl/9nFc9M1cVPg09ejdSRpDaiUK5tXgV/d0sEELwL1XZV+2iETmrAUZ6P9iFmGt+4N
	 8ksL9cVFYeHzAIHlJAd23Oh7yYPDrZo2pgWEjxy2WSnd1Ph9X/wqgnyyy3rLwXva/r
	 1v8sihLlnBO79pbZGNbTa4hYYnk791xmlOgav/hrS6gC5shg4oAN/vGO5NENDPOTY6
	 TkuOyeiNfDtk/sXFf9LGGwo6f8EySlaDkXr0fas644gwetaYlnCj7hl/blJcsyrMzS
	 O0bLa6AOBUoEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] perf dso: Separate libbfd and cmd addr2line
 caches to fix confusion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916234402.437113-3-irogers@google.com>
References: <20260916063545.3103314-1-irogers@google.com>
 <20260916234402.437113-1-irogers@google.com>
 <20260916234402.437113-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 23:54:47 +0000
Message-Id: <20260916235447.703351F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf: redundant duplicate include of dso.h
--

commit 44eae5fccba5e70d2ae1177b6b716c83f9242611
Author: Ian Rogers <irogers@google.com>

perf dso: Separate libbfd and cmd addr2line caches to fix confusion

This commit separates the libbfd and command-line addr2line caches in the
dso struct to prevent type confusion during fallback. By splitting the
caches, it avoids casting a2l_data into child_process, which previously
caused arbitrary instruction address coercion and silent aborts.

> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index df39e6ca88e6a..6510767177be5 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -1,38 +1,45 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include "dso.h"
> +
> +#include <errno.h>
> +#include <stdlib.h>
> +
>  #include <asm/bug.h>
> +#include <fcntl.h>

[ ... ]

>  #include "compress.h"
> +#include "debug.h"
> +#include "dso.h"

[Severity: Low]
Is this second inclusion of dso.h intentional?

The patch already adds an include for "dso.h" at the very top of
tools/perf/util/dso.c, so this results in a redundant duplicate include
remaining in the alphabetical block.

> +#include "dsos.h"
>  #include "env.h"
>  #include "namespaces.h"
>  #include "path.h"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916234402.4371=
13-1-irogers@google.com?part=3D2
