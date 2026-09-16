Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ECF3BE636
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 06:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539754; cv=none; b=uxLs9BTGHHM1r+5nF7ezxpcYqjXf1yXpaUI4sjf6l/9RgRNHUJUGxWARyfz3zP8HaQh9cNUZMt8Frlvfye9c3idi9p4zKScvtTapBWgb0uJUP+OTcpwH+E7dJeVrv7TQJCsO4D2IqvnOSrgMlgwbkiBgNK2TLJrQMhIo1xDdEUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539754; c=relaxed/simple;
	bh=WHpSelm+tx995qwHAJTTJljinlp7jIFrBvnsLuqYxnk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CtQ+Tn486hWcOVcasEgd6gQKEYm3a4DyZVlTd1yiRBOO6E21VB2W4m79zqwBS0RMSGzhkz7OCNOrrJ/MTnH+foHoYr/1CdSZi3GnQn5PgOBvKu8OIPzpPoYl9gkxoMc6bR/mYe3GI2zsfSjKvdGjbsyhrj1cM4oUoQNtrQ5feUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imko1i9I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imko1i9I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192271F000FF;
	Wed, 16 Sep 2026 06:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789539753;
	bh=aX9oY0a5ObcJJX20qvC/rDyenmcF6USFdSph6ni8uRo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=imko1i9I3LAnTv641BKDXhyUW2Z6Km+lkANx7Lvhkkudx2rJQSTSYkD2t0hQa0mGQ
	 5yiftHaxynt9V7SE3QsZy+za/LN51hVIIlfcCaWSCMT/sNsoXm8RMERPqFMc8RuwPS
	 N2THumRZPiILFVQS3wKOBhGPGxPpUVWgBtAN0aGsa4cLlyQ+Xbbpy34P++hPVCNic4
	 g+GGuh7ofgYwqyFjSYa5yk4FINi5MIpxktn6Gg/CqVb5oGH8RwTtX2VeYOZUWp4LlW
	 AopvOLiBOsmzD4g6PtyONIMMTo0FSJeKcOqaA6ph449g8ELc9qAwWG3oq44oZJVI2o
	 xd9PYBcBOIeXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/9] perf libbfd: Include the headers that are used
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916061218.3061216-4-irogers@google.com>
References: <20260916061218.3061216-1-irogers@google.com>
 <20260916061218.3061216-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 06:22:32 +0000
Message-Id: <20260916062233.192271F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf libbfd: build failure on musl due to missing <stdarg.h>
--

commit b4b64b7fbd73cf480fc5aaa2ad17802e8f46fbcc
Author: Ian Rogers <irogers@google.com>

perf libbfd: Include the headers that are used

This patch explicitly includes several POSIX headers directly into libbfd.c
instead of relying on indirect inclusions. It also reorders the includes to
group system headers before perf's own headers.

> diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
> index 131bfedf48cdf..1b23a261a9ced 100644
> --- a/tools/perf/util/libbfd.c
> +++ b/tools/perf/util/libbfd.c
> @@ -1,5 +1,19 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include "libbfd.h"
> +
> +#include <errno.h>
> +#include <inttypes.h>
> +#include <limits.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
> +#include <fcntl.h>
> +#include <pthread.h>
> +
> +#include <tools/dis-asm-compat.h>

[Severity: Low]
Does this inclusion order break the build on musl libc?

Because <tools/dis-asm-compat.h> uses va_start and va_end in an inline
function, it strictly requires <stdarg.h>. Previously, this requirement
was satisfied implicitly because it was included later in the file, after
other headers provided the necessary declarations.

Moving <tools/dis-asm-compat.h> higher up in the file exposes this missing
dependency, which will cause va_start and va_end to be undeclared in strict
environments like musl.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916061218.3061=
216-1-irogers@google.com?part=3D3
