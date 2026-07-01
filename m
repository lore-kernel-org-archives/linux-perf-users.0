Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BCB37D107
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 04:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782879515; cv=none; b=psA0F7ywjzsutZlB/DnGUTzpFpayvLBve9J+OpX+jW93JMW+NcDGG5DPdi+AxwsO9KsC8LJSOjG0Ed+POabMFfoYY5SX0IJ0Z3Q0iBAbw3iuBI9TwAdv0vKrtXqlLOLwbwOnepulzt2Jy38NKWmZeH5IXENV+utuuYXXVrxkw/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782879515; c=relaxed/simple;
	bh=zMSbn944jEyA27OCDLFCOf9X04oeMCCz77NKBwKD7rc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hir6c3ajTP5P6t6hTIH0iinEuCAEH6wFuBLQBjiq9MmRcdkk0HsHsbGbYtPTWkfg3DV+rJb+klBlH0TViLwJ9q1xqaS5HLiyKcoUmx6SC+/jlFzh1LeW4DbPyXntfY4U/kLrPYnp5k4YXf0jHG+qFeMsoe/AIU79Hx7iAbcKJI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jm0SUdzO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jm0SUdzO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30CA1F000E9;
	Wed,  1 Jul 2026 04:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782879510;
	bh=yhfgXH5AaKw1tGK1d7swgQQPsg/6lJBapTfN7dNxsDM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jm0SUdzOGluAzxxA6An+0cppgrgQXZ/5Gn9tK1C/sb34E+UlDClARYaeUZWkKwaTm
	 YWh8K0unehsKPoE9vHQhnTG/V0mSVtD0Kx6GvfaZsqswt2FgUmg3h9I46tFlfTR/n4
	 RyZaxfEhxcLY5ARUzqDKTNHc7L24vtV7Dp5v6oOizKHU95+FZ1/ai+qm6YjIrPAOc1
	 A5WbrBwQ2g/l5hpaGP1HxxqYUzHR4JUGmFtTlQ1Gv17ZTvOMySrgrKS+zBnBx3nLNL
	 oglwDogpJEO3QZOj8ruyH8BhDsJSC4enU3B7ACukscnWVAMuGRgDhabZnjNzAvlYvg
	 qooSLY8GuGkkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 20/21] perf annotate-arm64: Support per-cpu variable
 access tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260701035355.752944-21-wutengda@huaweicloud.com>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-21-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 04:18:29 +0000
Message-Id: <20260701041829.F30CA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Low] Missing explicit inclusion of <string.h> for POSIX string functions.
--

commit 2114d02145b83196afb640a1330f3e5c5b83b2b7
Author: Tengda Wu <wutengda@huaweicloud.com>

    perf annotate-arm64: Support per-cpu variable access tracking
   =20
    Extend update_insn_state() for arm64 to handle per-cpu variable
    addressing.

[ ... ]

> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-d=
ata.c
> index 6fa5cd373a464..b0bf0437168bb 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c

[Severity: Low]
This is a pre-existing issue, but this file appears to be missing an explic=
it
inclusion of <string.h> for POSIX string functions.

At the top of the file, <string.h> is not included alongside the other head=
ers:

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
#include <linux/zalloc.h>

However, the code uses strcmp() in data_type_cmp():

static int data_type_cmp(const void *_key, const struct rb_node *node)
{
...
	return strcmp(key->self.type_name, type->self.type_name);
}

Will this cause the build to fail when compiling under musl libc, which does
not implicitly include <string.h> through other system headers?

> @@ -1252,11 +1252,33 @@ static enum type_match_result check_matching_type=
(struct type_state *state,
>  	}
> =20
>  	if (state->regs[reg].kind =3D=3D TSR_KIND_PERCPU_BASE) {
> -		u64 var_addr =3D dloc->op->offset;
> +		u64 var_addr;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701035355.7529=
44-1-wutengda@huaweicloud.com?part=3D20
