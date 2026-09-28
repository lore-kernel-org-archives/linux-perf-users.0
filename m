Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E059A33E37C
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 23:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790638758; cv=none; b=qgzI5CpyakWtD5OdekUe+0cwCsg/qn8TaWoZ5hbEi+qESIJhvQ/emtHkKKoOrDjWOtPxIxJ5rnwzmkvutrPQJLdqc7ZDjiL5Os4I8asxFs4Kz9IxFzN4XgUhPSqH4AlRE0KSpzgbLyvFpLLIS9yX54NV8IFPElEkCYzeElIhUB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790638758; c=relaxed/simple;
	bh=BxDStLsChi2kybr/hCgyCZuTlmfXE5w7vhCFdHh+usE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lxd0U+odTpiI0GVWEBbZZPMnq+0bk3VDgtybG0TYNzlSi9KbPOqn9kDK9dyFve83xCTZ5c+udyjioUtvBPJ6UtMUYHjHVchnqBr/BE/Pd15UMuJJJkLt0rtvJ5mhWvSBJDMLSsOGrbnZM2aK7+FYe0mEUmvPnxfR7Dnw5W56wlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXQxSef9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXQxSef9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51CE51F000FF;
	Mon, 28 Sep 2026 23:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790638756;
	bh=eBVzhOB5fF8r4fMLJ5hP+Btn3i6pGuCk9kGjdalryeU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QXQxSef9h/n/CQtsn/jAG52/g4FG/KB5NzIegXijO57H8pAlpaufz2bWVe3EiK3Kx
	 iItO9TM/9EZegD8tTzh2e3e2jLBo0DkUoWmTKvgkGLGlXbpZggr+9yubkKo/N+GZ49
	 GsSkVdAQibji+zB0PIV/q/5gyCTaPny5lNYXaWb7M+jt2zajzKKuy2KDRs3oAe3GQt
	 hLvhcn5FcI4q6HMpIWcErMghL7tJ04kNNoRCAcbpPxxNQQJS1p+EEoAYPQcQAzsBHD
	 EbT6pInkgIq5ZlGeOgfDEGxyh/gKdZHYHtJF+w0oMNy6EcG07HX7+fiK9kV9fART+G
	 J8ftC4AR0Y/UA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf symbols: Don't let a module's last symbol overlap
 the next module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928-haghdoost-perf-symbols-fixup-module-end-v1-1-0a70d1edd401@uber.com>
References: <20260928-haghdoost-perf-symbols-fixup-module-end-v1-1-0a70d1edd401@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 23:39:15 +0000
Message-Id: <20260928233916.51CE51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf: missing explicit <string.h> inclusion for strcmp
--

commit 4f103cd2e58d587c3ce270538dfd9a32b1e56fa8
Author: Alireza Haghdoost <haghdoost@uber.com>

perf symbols: Don't let a module's last symbol overlap the next module

symbols__fixup_end() extends a zero-size symbol that is the last one in
the kernel or in a module to the end of the next page. This patch clamps
the end to the next symbol's start so that lookups do not return the
wrong symbol. It also adds a test case to the Symbols suite to cover
these boundary cases.

> diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
> index c09e04f36035a..b644d95c6be9a 100644
> --- a/tools/perf/tests/symbols.c
> +++ b/tools/perf/tests/symbols.c
> @@ -2,6 +2,7 @@
>  #include <linux/compiler.h>
>  #include <linux/string.h>
>  #include <sys/mman.h>
> +#include <inttypes.h>
>  #include <limits.h>
>  #include "debug.h"
>  #include "dso.h"

[ ... ]

> +static int check_symbol(struct dso *dso, u64 addr, const char *name, u64=
 end)
> +{
> +	struct symbol *sym =3D dso__find_symbol_nocache(dso, addr);
> +
> +	if (!sym || strcmp(sym->name, name)) {

[Severity: Low]
Omitting the exact POSIX header <string.h> for strcmp() can cause musl libc
builds to fail, as musl enforces strict namespace separation without the
implicit inclusions common in glibc.

Does this new call to strcmp() in check_symbol() require an explicit includ=
e of
<string.h> at the top of tools/perf/tests/symbols.c?

> +		pr_debug("%#" PRIx64 ": expected %s, got %s\n", addr, name,
> +			 sym ? sym->name : "no symbol");
> +		return TEST_FAIL;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-haghdoost-=
perf-symbols-fixup-module-end-v1-1-0a70d1edd401@uber.com?part=3D1
