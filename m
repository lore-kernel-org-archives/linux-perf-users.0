Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C822537F32B
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 03:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785729530; cv=none; b=V1Ts+UtCvlS/uQ2JME1tQXXYtBZRR9ym8FQEKJ+UXa7nKHJB+ioIYmmJHS8efP50lF4d+lxAtGafOaXecHToUnh+hkdMhrchHRD8NR/fvKAJQYSePQ6svnCZlFdFmrtVDpr2z0wADNZMUMKlcm7WIEQ34soOpHYKft42kK8A7dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785729530; c=relaxed/simple;
	bh=PzNBznLIo1kFSkH4/l+4DFPH19F/2P3g2f7hq8n7lps=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ioph/a5q0VO5JLCLTqAN5kJzutvI6iwtsWTMhpPWNtg41+jQn2UriI+DZTtf4oX755ybQY5nPnXTcnrP3a5fkHSOUP1YPxpMfMEg9ouVIiNOjDJqzuHex8MptJn0HizITRy6Rakurh0+85vhxsQOvXb/AGAVEghk15eZeJ3JJko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lx6Q+6p2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lx6Q+6p2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591B11F000E9;
	Mon,  3 Aug 2026 03:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785729525;
	bh=TdT7YjR9znNVRVyNyydSndXoLied6ilfNKt4uEmDgUw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lx6Q+6p2MsNajkWEQ8Iqn1pz669p4BPJRFMj+4AN4IRLZE3GdbDeHKpmZJGVUHGtc
	 p3WmRTqxtMPSf4Aml/TY4GJ1QsMI1pIcGB+QP76nFuRQ8Gu4HHHpZmn5P4PyL5CzgV
	 xrrWgPW4iKNpd2eN6FEMe7WBcPo252YDbBOvcA8E6M8/kjvQlbLYbbxLmNva1n6oE4
	 lfQ62pFY+XIQJbtYPLT4cTmVV3BfnD+R/R1iWTMo4cffwZcdVB57xXQbawof0dVtib
	 hNqYn1zrHnULEaHFCRIDs7C0XPK7M/s3mc704MX31MRcUbXu+GFADEPVr0z5cAwCVv
	 E8mx+1VVmxsuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/9] perf c2c: extract shared data structures into
 c2c.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260803035220.172022-2-jiebin.sun@intel.com>
References: <20260803035220.172022-1-jiebin.sun@intel.com>
 <20260803035220.172022-2-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 03:58:44 +0000
Message-Id: <20260803035845.591B11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The header `c2c.h` uses the POSIX libc type `int64_t` but does n=
ot explicitly include `<stdint.h>`.
--

--- Patch [1]: [PATCH v6 1/9] perf c2c: extract shared data structures into=
 c2c.h ---
commit 0f5b8701063010839966e39a3a6a2759c7919cbf
Author: Jiebin Sun <jiebin.sun@intel.com>

perf c2c: extract shared data structures into c2c.h

This commit moves shared data structures and formatting macros from
builtin-c2c.c into a new c2c.h header file. It also exports functions
like perf_c2c__browse_cacheline(), c2c_fmt_free(), and c2c_fmt_equal()
for reuse by the upcoming function view browser.

> diff --git a/tools/perf/c2c.h b/tools/perf/c2c.h
> new file mode 100644
> index 0000000000000..aac01d4f67605
> --- /dev/null
> +++ b/tools/perf/c2c.h
> @@ -0,0 +1,149 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _PERF_C2C_H_
> +#define _PERF_C2C_H_ 1
> +
> +#include <stdbool.h>
> +#include <linux/types.h>
> +#include "util/stat.h"
> +#include "util/hist.h"
> +#include "util/mem-events.h"
> +#include "util/mem2node.h"
> +#include "util/tool.h"

[ ... ]

> +struct c2c_dimension {
> +	struct c2c_header	 header;
> +	const char		*name;
> +	int			 width;
> +	struct sort_entry	*se;
> +
> +	int64_t (*cmp)(struct perf_hpp_fmt *fmt,
> +		       struct hist_entry *left, struct hist_entry *right);

[Severity: Medium]
Will this fail to compile under musl libc? The struct c2c_dimension uses
int64_t for the cmp function pointer, but c2c.h does not explicitly include
<stdint.h>.

Since musl strictly separates declarations, relying on implicit header incl=
usion
can lead to build failures. Should we explicitly include <stdint.h> at the =
top
of this file?

> +	int   (*entry)(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
> +		       struct hist_entry *he);
> +	int   (*color)(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
> +		       struct hist_entry *he);
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803035220.1720=
22-1-jiebin.sun@intel.com?part=3D1
