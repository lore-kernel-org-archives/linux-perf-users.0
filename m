Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C423D27A47F
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Aug 2026 22:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787956595; cv=none; b=o/Ow71dYnMyImMZDt6sWcqDPq4KhoRS7HhiBUH/xQd+SFPEMNy62H9XfC7q5ZVHvVcrz4llC3gaxXxCSG9sheEPwl0Ab6Fji7qituX0R9r4DA8BBbGchmr4nfx4IgRdmbUh2W2JVg/3Pj1DO7StKvN/Y3ySYiJNYGg+P8FEbQDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787956595; c=relaxed/simple;
	bh=RiNcM/GCz209XQxR+sNCz4p19uN3zPUZjVRHHcsYF0Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=brnsbLmNT+ybwXO16yB8fOI1EM91QMcydJimUF1PBpbe2+bJtIWz3x1FuY5RW9C+9Hj+KBj4/vSM5J+dACwAUwd0OEmRbpMV1N9TdHwTTxn/iqDK5N1CP/U9n2fmt1R+CgEaDjYFVWbDcfpVD1zQo9BsyMK/B5Fs7podxjI3Cag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8Io428T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8Io428T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5044D1F000E9;
	Fri, 28 Aug 2026 22:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787956594;
	bh=IvZGQQYhn+co76YEyy7SwAGAI9in/JrISERh3xEBf+M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a8Io428T43MSiWVbHsHcCbBTTLz0efdY6/WWYbTlhnONvB6SpIkuXu9UoXU+nYPjA
	 Taj1Zg1QrBzGguKSw0otrjCCoydmOJ5spBQonxrmi+HYm3YdbQx48ASI1sBBqBGMWQ
	 0FPYyUbFA9l1bCgPDf6pZpl8Hu7eWCDSA0svFxadjSOg4nriC6sRu3IFLZQ8rq3DJp
	 KXdLjdvYhXPUvRTYF/U8V0dX85iqwyN/5p/Nvfx4OPot+KWsz27ioWX8afgJYTfCgV
	 lDecemPNmCi/BQ55tEzJQCVrQ4Ay5RCg6Tlmo2dQ7bUdGYLGPGGh6iP50SIsWRJCLc
	 BRmEV3VeAkDgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] perf tool: Remove util/cache.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260828222045.1314766-1-irogers@google.com>
References: <20260828222045.1314766-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 22:36:33 +0000
Message-Id: <20260828223634.5044D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Removal of `util/cache.h` removes implicit inclusions of standard P=
OSIX headers, causing musl compatibility violations due to missing explicit=
 includes.
--

commit 6e76c8b7f671374f4e87596d7f1af0426551795a
Author: Ian Rogers <irogers@google.com>

perf tool: Remove util/cache.h

Move definitions to places they are used, or path.h in the case of
path.c's mkpath function. Remove unused definitions. Fix transitive
include dependencies.

> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -11,7 +11,6 @@
> =20
>  #include "util/color.h"
>  #include <linux/list.h>
> -#include "util/cache.h"
>  #include <linux/rbtree.h>
>  #include "util/symbol.h"

[Severity: Low]
Does the removal of util/cache.h drop implicit inclusions of standard POSIX
headers? This file uses standard string and allocation functions, so it
seems <string.h> and <stdlib.h> need to be explicitly included to avoid
build failures on systems using musl libc.

[ ... ]

> diff --git a/tools/perf/util/path.c b/tools/perf/util/path.c
> --- a/tools/perf/util/path.c
> +++ b/tools/perf/util/path.c
> @@ -1,6 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include "path.h"
> -#include "cache.h"
>  #include <linux/kernel.h>
>  #include <limits.h>

[Severity: Low]
With cache.h removed, does mkpath() now lack the required <stdarg.h> includ=
e?
Looking at mkpath() later in this file, it relies on va_start(args, fmt) wh=
ich
requires <stdarg.h>. Without the explicit include, this causes musl
compatibility violations.

[ ... ]

> diff --git a/tools/perf/util/strbuf.c b/tools/perf/util/strbuf.c
> --- a/tools/perf/util/strbuf.c
> +++ b/tools/perf/util/strbuf.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include "cache.h"
>  #include "debug.h"
>  #include "strbuf.h"

[Severity: Low]
Should <string.h> be explicitly included here? Looking at strbuf_add(), it
uses memcpy(), and relying on <linux/string.h> instead of the standard POSIX
header can cause namespace pollution and musl compilation failures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828222045.1314=
766-1-irogers@google.com?part=3D1
