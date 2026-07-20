Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEDE2C21F1
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 11:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784546156; cv=none; b=jOF5E7Zslh+FNZdL33QbhsWBW5dMsgcr4lmPsJBmjR0yRZ2heKSlO+RArM+YAaXbo/1nXxTZU0ehxxwrc0I2TvnjUT0Vhv50uR6ily+znPct9bEZcM5go/0jwZv8u2JhN6lBAykNQug/mYHV3ZwAtW2pS+VyNcTtC6dO+DeKZu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784546156; c=relaxed/simple;
	bh=ArtRSgFLAR8BlCl6enOnaJqJueyLhf+Wag2kjoEkHbI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OiWxXQqkj0leYYrpiDbJbfThd50W7iQwqNo8RpMtJstCGes+19Q2bM1P6IiDxkwUz4tJyOqEbedIBwb+lIf/KI8Ph10VIlHthrQaITcTNEb1dEHQElAqAhlyZe0wLAvofNINkXfYQJUH/VLZMUmXYZ8HPR5cD8RBVYUQqhs3BS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3dIV+43; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3dIV+43"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990641F00A3A;
	Mon, 20 Jul 2026 11:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784546154;
	bh=gCFSdEYGbY6krNKpWMH8T/Fk61JRQf7OKd7qByaqU4o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V3dIV+43TiGNpjivpRipRngh5/sfo4fSlZ3zj1HeE1tei+kJvxX818FZshG9qHwLT
	 dGno1h5VOQv0cfORzz4kv/jmunpCjTJ8drTbKLOU7pJkQw1kJ9+MSj2ZEoKrVCNSh9
	 50+DsBrpOFDu1OeD1NM84aboQHcMivqdsWxEO67XvUliBM7JC7f72ekrOLzZ8Z35NL
	 uhXKQwRFZqZlU9oAxjrWRnQiqD6o3CReYL1KgDZY+EMlsFy7ajwXm+X6zfXXlVjAr6
	 bt2NMxIjq9ZgPs/l+Y+MsfMN7Dmkkgb8/2EGoTbeNJNrKAM0yx6VBjgIwIJIUDDkW5
	 P0zD9gg6YZK1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 1/6] tools/perf: Move powerpc VPA-DTL auxtrace init
 into a separate file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260720105218.14277-2-atrajeev@linux.ibm.com>
References: <20260720105218.14277-1-atrajeev@linux.ibm.com>
 <20260720105218.14277-2-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 11:15:54 +0000
Message-Id: <20260720111554.990641F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added file `vpa-dtl.c` uses `zalloc()` but fails to in=
clude `<linux/zalloc.h>`. On 64-bit platforms like PowerPC, this implicit d=
eclaration causes the compiler to assume `zalloc` returns `int`, leading to=
 the truncation of the upper 32 bits of the returned 64-bit pointer.
--

--- Patch [1]: [PATCH V2 1/6] tools/perf: Move powerpc VPA-DTL auxtrace ini=
t into a separate file ---
commit 36d571f8cc56fc84bd8c942791167ff968206898
Author: Athira Rajeev <atrajeev@linux.ibm.com>

tools/perf: Move powerpc VPA-DTL auxtrace init into a separate file

This commit extracts the VPA-DTL auxtrace recording initializer into a new
file, vpa-dtl.c. It reduces auxtrace.c to a thin dispatch layer to prepare
for HTM recording.

> diff --git a/tools/perf/arch/powerpc/util/vpa-dtl.c b/tools/perf/arch/pow=
erpc/util/vpa-dtl.c
> new file mode 100644
> index 0000000000000..fde388d874775
> --- /dev/null
> +++ b/tools/perf/arch/powerpc/util/vpa-dtl.c
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * VPA DTL AUX tracing support
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/string.h>
> +#include <errno.h>
> +#include <stdlib.h>
> +#include <limits.h>
> +#include "../../util/cpumap.h"
> +#include "../../util/evsel.h"
> +#include "../../util/evlist.h"
> +#include "../../util/session.h"
> +#include "../../util/util.h"
> +#include "../../util/debug.h"
> +#include "../../util/auxtrace.h"
> +#include "../../util/powerpc-vpadtl.h"
> +#include "../../util/record.h"
> +#include <internal/lib.h> // page_size

[ ... ]

> +struct auxtrace_record *vpa_dtl_recording_init(struct evsel *pos, int *e=
rr)
> +{
> +	struct auxtrace_record *aux;
> +
> +	/*
> +	 * To obtain the auxtrace buffer file descriptor, the auxtrace event
> +	 * must come first.
> +	 */
> +	evlist__to_front(pos->evlist, pos);
> +
> +	aux =3D zalloc(sizeof(*aux));

[Severity: Medium]
Is the <linux/zalloc.h> include missing from the headers at the top of the
file?

Since zalloc is used here without a declaration, the compiler will treat it
as implicitly declared and returning an int. On 64-bit platforms like Power=
PC,
this truncates the upper 32 bits of the returned pointer, which could result
in a segmentation fault at runtime.

> +	if (aux =3D=3D NULL) {
> +		pr_debug("aux record allocation failed (-ENOMEM)\n");
> +		*err =3D -ENOMEM;
> +		return NULL;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720105218.1427=
7-1-atrajeev@linux.ibm.com?part=3D1
