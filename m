Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371523CAA55
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 18:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784055015; cv=none; b=OVj5HEEkj2cVqO1P2VpOVpdsgvvln5mJnjcJNxSLPMVNg2FvO8BloLewhDErWSON7qNFwrgJ5g+hsTP6HV4M1rtEViP+/r/9PiiGtlLkuzHCF1GLHMvmDmdvJDbP/EZwmbyT7z+oruPkthSvDj+HUA9dkN/tbO9l4Y7Zo54X8+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784055015; c=relaxed/simple;
	bh=oUBtgHNFl7FW7o0ffzQ9V2rRbcjvThsdcsrTfCjIdV8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QIzEzsjtCNIqbuShOSVkQJIwMMh1f/z31FLf8BMAgvfSxNI+Md5ttjfmg7IfrxsUvlTQ/SqdxNG+Zh39h4VaDnTli3jxBUPta7Yjrf1JqUo9CHi4u0LKV7ZU9VQnu63gK+qgVOwmDtcDaTT22ViFUvjgW480KkAhsE+2yfYCifg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+Y1tQ6f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+Y1tQ6f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0561F00ACF;
	Tue, 14 Jul 2026 18:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784055010;
	bh=nUD4vwd9rr+N8sgTwCB5fDAUSGlPsZiMOxBCg8VuqTY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S+Y1tQ6fTEw7qDazy2JiwktakEHy1N8nkB4J89W9Gvsoi1dsEaTEQvSi79CA5GxPp
	 OXRXs1+Q9cY2y8c+lzql/FLpnedVdZw+CXVbxkVh9oY4FTZ1nqhkh+lOSO9wroxlr6
	 HNaWDw7NHXcygvOTlc8qFpxGTzpONA7bLnSEisqAFUW00Bma43IuFk2QCplIBRR42O
	 nI7xvnKswDrl38NsTieu/syHtXiiGMi26JZjt6tZXrBrnM/1i6lp9ubx4blHB/zsVw
	 mdm/0jZd2LyFGmR9vPqmQ5Qfkz0upGbz0qOJzQOwW+PqwQjopjdv0TsUCwc1x0s/u0
	 rTxqrXE2+AgMw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 12/13] mm/kwatch: add KUnit tests for the watch
 expression parser
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinchao Wang" <wangjinchao600@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260714183339.13044-1-wangjinchao600@gmail.com>
References: <20260714182243.10687-1-wangjinchao600@gmail.com>
 <20260714183339.13044-1-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 18:50:09 +0000
Message-Id: <20260714185009.DE0561F00ACF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Hardcoded 64-bit absolute address in the KUnit test will cause com=
pilation warnings and guaranteed runtime failures on 32-bit platforms.
- [Medium] KUnit test cannot be enabled when KWatch is a loadable module, a=
nd fixing the Kconfig exposes a multiple `module_init` build failure.
--

--- Patch [12]: [RFC PATCH 12/13] mm/kwatch: add KUnit tests for the watch =
expression parser ---
commit 5eda6d9ba13c286416e92d504d097afadcc1400d
Author: Jinchao Wang <wangjinchao600@gmail.com>

mm/kwatch: add KUnit tests for the watch expression parser

This commit adds a KUnit test suite for the KWatch expression parser. It
covers base anchors, offsets, dereference chains, and rejection of malformed
expressions.

> diff --git a/mm/kwatch/Kconfig b/mm/kwatch/Kconfig
> index b1c37a829dd53..74083040a1a33 100644
> --- a/mm/kwatch/Kconfig
> +++ b/mm/kwatch/Kconfig
> @@ -15,3 +15,13 @@ config KWATCH
>  	  exact instruction causing the illegal access.
> =20
>  	  If unsure, say N.
> +
> +config KWATCH_KUNIT_TEST
> +	bool "KUnit tests for KWatch" if !KUNIT_ALL_TESTS
> +	depends on KWATCH && KUNIT

[Severity: Medium]
Will this test be silently disabled when KWATCH is built as a loadable modu=
le?

Because CONFIG_KWATCH_KUNIT_TEST is a bool, if KWATCH is configured as a
module ('m'), the dependency expression evaluates to 'm' and Kconfig will
automatically downgrade the boolean's visibility to 'n', making it impossib=
le
to run the test suite for module builds.

> +	default KUNIT_ALL_TESTS
> +	help
> +	  Enable KUnit tests for the KWatch kernel module.

[ ... ]

> diff --git a/mm/kwatch/deref_test.c b/mm/kwatch/deref_test.c
> new file mode 100644
> index 0000000000000..094b7afeb235e
> --- /dev/null
> +++ b/mm/kwatch/deref_test.c
> @@ -0,0 +1,137 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <kunit/test.h>
> +#include "kwatch.h"
> +#include <linux/string.h>
> +
> +static void kwatch_test_parse_deref_chain(struct kunit *test)
> +{
> +	struct kwatch_config cfg;
> +	int ret;

[ ... ]

> +	// Test 13: Absolute address
> +	memset(&cfg, 0, sizeof(cfg));
> +	ret =3D kwatch_deref_parse(&cfg, "0xffffffff81000000+8");

[Severity: High]
Will this hardcoded 64-bit address cause failures on 32-bit platforms?

On 32-bit architectures, this string will exceed ULONG_MAX, causing
the internal kstrtoul() to safely fail and return -ERANGE. The parser
will then fall back to treating it as a global symbol name via
kallsyms_lookup_name(), which will also fail, ultimately returning -EINVAL
and breaking the test logic.

> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +	KUNIT_EXPECT_EQ(test, cfg.base, KWATCH_BASE_ABS_ADDR);
> +	KUNIT_EXPECT_EQ(test, cfg.sym_addr, 0xffffffff81000000UL);

[Severity: High]
Does this 64-bit literal cause implicit truncation compiler warnings=20
and test comparison failures on 32-bit architectures where unsigned long
is only 32 bits?

> +	KUNIT_EXPECT_EQ(test, cfg.offset_count, 1);
> +	KUNIT_EXPECT_EQ(test, cfg.offsets[0], 8);
> +}
> +
> +static struct kunit_case kwatch_deref_test_cases[] =3D {
> +	KUNIT_CASE(kwatch_test_parse_deref_chain),
> +	{}
> +};
> +
> +static struct kunit_suite kwatch_deref_test_suite =3D {
> +	.name =3D "kwatch_deref",
> +	.test_cases =3D kwatch_deref_test_cases,
> +};
> +
> +kunit_test_suite(kwatch_deref_test_suite);

[Severity: Medium]
If the Kconfig dependency above is fixed to allow this test to run with mod=
ule
builds (e.g., depends on KWATCH !=3D n), will this cause a multiple definit=
ion
build failure?=20

Since deref_test.o is linked directly into the kwatch module in the Makefil=
e,
and kunit_test_suite() emits a module_init() alias, this will conflict with
the primary module_init() definition that likely already exists for kwatch.

> +
> +MODULE_DESCRIPTION("KUnit tests for the KWatch watch expression parser");
> +MODULE_LICENSE("GPL");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714182243.1068=
7-1-wangjinchao600@gmail.com?part=3D12
