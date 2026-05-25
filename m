Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6C15478D
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 01:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779672691; cv=none; b=qAdZu6xSelvSKtLB+/Q5YmbJFVSo9+Esma2PnKhD5Z9VA02zhVtZSTlLNFvzDHD3Tx+8TYy8+X4ropvylOu7nboTRrGX7l5IyrSMMml01yQRFCis6yWZdJR17/3RPH8VYK2Sk1zsAyWK7qu0m0tX0pfkeKZ3x1bQ4iN/ABZhJnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779672691; c=relaxed/simple;
	bh=BqGDw1bTnweiDKuuJ7YEivQ0zEXZ2mDrhFyD/ODuZ0E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dzd5Ldn9/jdKRn95kHsmvf0iHbeNkqmjC02StxY3fF8boAkiAGs/M6YISdCUAsTmsHXiPtN6s5xrK9sx1bmS55nLpNcva8t8IIJ7KaFwhoq5n1kDQmy/VL4w1LbghkxCp5wf0gfzukayuge/yVpYllNttyCsMMzvlwsFNDDC7NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzvZULQ+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzvZULQ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04641F000E9;
	Mon, 25 May 2026 01:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779672690;
	bh=EgvVWbJL+InjqZyd5sSF0z6Oi6jgc4wjH0xmELpY+Qg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AzvZULQ+kXzW6cisQR5HOfuI99j7TsK7acD2yEKWuWjYC4pqyaOrDelRuNV0C/iGs
	 XUep0gmhkp4/OEWjrp6rr2D/w95+vMg81iaILSzHI8Xiz8Cvn1Ru9QYvztY5TcMq9s
	 Hes3nQoXv45ivyF7mywgchYYFUQY7JYR8oOiOGsl+p1bO29FX1WMIfxMHra4UvolNC
	 iggY0MIIhQKlhF8hGH/5jhE4t1MCfXCS4wasAetdiIea+KBz0p5CN31n+Fz7YsD64T
	 JzG5QIgBoRzl9/m8N854mpK+Gyesdpb/cy09zFJGMoJZ43jXJMUbRobq0fGladAx2z
	 pET83UKQgc1Bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] perf trace: Include copied headers in the beauty
 directory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260525011133.179130-1-namhyung@kernel.org>
References: <20260525011133.179130-1-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 01:31:29 +0000
Message-Id: <20260525013129.F04641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The copied UAPI header `fcntl.h` includes `<linux/openat2.h>`, whic=
h was not copied into the `tools/include/uapi/linux/` directory, causing bu=
ild failures on older host systems.
--

commit 7bb011deeef80e2496028a3477432fac108a240f
Author: Namhyung Kim <namhyung@kernel.org>

perf trace: Include copied headers in the beauty directory

This commit updates the trace beauty scripts to use local copies of UAPI=20
kernel headers directly, rather than relying on system headers or manual=20
macro definitions.

> diff --git a/tools/perf/trace/beauty/fcntl.c b/tools/perf/trace/beauty/fc=
ntl.c
> index e1b99b8f55eb0..10fd6a2b75c35 100644
> --- a/tools/perf/trace/beauty/fcntl.c
> +++ b/tools/perf/trace/beauty/fcntl.c
[ ... ]
> -#include "trace/beauty/beauty.h"
>  #include <linux/kernel.h>
> -#include <linux/fcntl.h>
[ ... ]
> +#include "trace/beauty/beauty.h"
> +#include "trace/beauty/include/uapi/linux/fcntl.h"

[Severity: Low]
Will this cause a build failure on systems with older kernel headers?

The newly copied uapi/linux/fcntl.h includes <linux/openat2.h>, but it=20
appears openat2.h was not copied into the tools directory. On build=20
environments with kernel headers older than v5.6, the compiler will fall=20
back to the host system's include paths, fail to find linux/openat2.h,=20
and halt the build.

Should linux/openat2.h also be copied into the tools include directory to
prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525011133.1791=
30-1-namhyung@kernel.org?part=3D1
