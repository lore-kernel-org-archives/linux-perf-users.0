Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7890839FCCC
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 08:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782896114; cv=none; b=DVNhhWYS4XHsMURYX9J1kvyrrd/nsXtCk34ww0aEwXbj8PWBuSTydDuhOfdGZCA0+Zvf1h8tuHSlqXmivSDVn74y2z6mNFt7wZD5i0Zw2stTuKCr+w3LJaTGAHzpxvEJFkC3oWqgz2FnOm2B01UNYICnd9bPyo6L1E+PNwi/2nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782896114; c=relaxed/simple;
	bh=r8B799Yxe+ykJ83FrUXeyL1bxtGWjfV5wtCsJaTOU10=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IzUCyDn1Bb1RJsK5AgMQH7i2+ftX8PkdMLx0uICp5oJEGulElx8hAvMlRfBmTlgNlAHn6f0L1I2hJ1eEK3HRphNK+n3+eL7dl6Ckp3D4V/DMkX6D3N49W8m+w8xM1L/UVKEzGe+MEwYaN/dqwyn8soSY2CKerES63rhRNCWn67A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1eRhhTZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1eRhhTZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C3A1F000E9;
	Wed,  1 Jul 2026 08:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782896113;
	bh=9cWS/9rBJ7vrOmCx8NlH1R19cjCBRrY6GWR5BqIneU4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c1eRhhTZQ1IiEC6zDKdE7vwzP7ovtdbKuZKnQO4W5NNsuochmiv19v3Py5cJEYEhI
	 fr8TnSHg1vD7pX/WO87C3EUBIBlaByVyrHumfWJJn26RLAa9NEmzNK9yZr81/vixjZ
	 vwb0HDd3v83+N74aGwnFBcGSdYRazGG+cIskdhckmYlECyG3seXaLgIjJ4XVqiwisu
	 Fwq8RL16EMV2pLtGQx6yrd68WzBtsRUvb9hlqztgXrxqFkCl9HehM8Rc8Yzqsx5KSn
	 oar0twDUMgN6oyzXVnQYVeEXvjyQNvfLqjpu7XxOzg3PSoUg2naqlNQJhzZv3RAEPy
	 ex70xAdG72Hxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/9] tools/perf: Add powerpc callback support for
 arch_record__collect_final_data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260701084115.80383-5-atrajeev@linux.ibm.com>
References: <20260701084115.80383-1-atrajeev@linux.ibm.com>
 <20260701084115.80383-5-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 08:55:12 +0000
Message-Id: <20260701085512.E9C3A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Direct access to `evsel->name` without NULL checks causes a segmen=
tation fault.
- [High] Premature loop termination in `arch_perf_record__need_read` due to=
 artificial overwriting of loop variables.
- [High] Unconditional compilation of PowerPC-specific execution logic glob=
ally overrides a cross-platform weak symbol.
- [High] The negative error return value from `perf_evsel__read()` is ignor=
ed, leading to premature termination of trace data collection.
- [Medium] The functions and callbacks described in the commit message are =
completely missing from the implemented code.
- [Low] Malformed include path directive `../../../util/record.h` causes a =
build failure.
--

commit dee0b2f32508f51e2b57675240fda0c4192160d5
Author: Athira Rajeev <atrajeev@linux.ibm.com>

tools/perf: Add powerpc callback support for arch_record__collect_final_data

This patch adds an architecture-specific hook to collect additional HTM tra=
ce
data before closing events. It reads the HTM event counts to determine if
more data is available to be written to the perf data file.

>     Add arch_record__collect_final_data to collect additional
>     data before closing the event. Define the callback in
>     util/powerpc-htm.c
[ ... ]
>     the event using evlist__enable after reading event using
>     htm_read_data function. The perf_evsel__read returns zero, when

[Severity: Medium]
The commit message mentions adding arch_record__collect_final_data and
reading events using the htm_read_data function. However, the implemented
code defines arch_perf_record__need_read and uses perf_evsel__read instead.
Could the commit message be updated to match the actual implementation?

> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 5e2265018826f..4d79662e88266 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -142,6 +142,7 @@ perf-util-y +=3D hisi-ptt.o
>  perf-util-y +=3D hisi-ptt-decoder/
>  perf-util-y +=3D s390-cpumsf.o
>  perf-util-y +=3D powerpc-vpadtl.o
> +perf-util-y +=3D powerpc-htm.o

[Severity: High]
Does unconditionally adding powerpc-htm.o here cause it to be compiled for
all architectures? Since it defines arch_perf_record__need_read globally,
this could override the weak symbol in builtin-record.c and incorrectly
execute PowerPC-specific logic on other architectures like x86 or ARM.

> diff --git a/tools/perf/util/powerpc-htm.c b/tools/perf/util/powerpc-htm.c
> new file mode 100644
> index 0000000000000..5043ff41a609e
> --- /dev/null
> +++ b/tools/perf/util/powerpc-htm.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * HTM support
> + */
> +
> +#include "../../../util/record.h"

[Severity: Low]
Will this include path resolve correctly during the build? It appears to
point outside the normal include directories for the perf tool, which might
result in a compile-time failure.

[ ... ]
> +int arch_perf_record__need_read(struct evlist *evlist)
> +{
> +	struct evsel *evsel;
> +	int found_htm =3D 0;
> +
> +	/* there was an error during record__open */
> +	if (!evlist)
> +		return 0;
> +
> +	/* First, check if any HTM events exist */
> +	evlist__for_each_entry(evlist, evsel) {
> +		if (strstr(evsel->name, "htm") !=3D NULL)

[Severity: High]
Can evsel->name be NULL here? For raw hardware events or events before
parsing has dynamically assigned a name, passing a NULL pointer to strstr
or strcmp will cause a segmentation fault.

[ ... ]
> +		for (int x =3D 0; x < xyarray__max_x(xy); x++) {
> +			for (int y =3D 0; y < xyarray__max_y(xy); y++) {
> +				struct perf_counts_values count;
> +
> +				if (!strcmp(evsel->name, "dummy:u"))
> +					continue;
> +
> +				if (strstr(evsel->name, "htm")) {
> +					perf_evsel__read(&evsel->core, x, y, &count);

[Severity: High]
Does this properly handle failures from perf_evsel__read()? It returns a
negative error code on failure and leaves the count struct uninitialized or
zeroed. If ignored, count.val could evaluate to 0 below, causing the trace
data collection to terminate prematurely.

> +					y =3D xyarray__max_y(xy);
> +					x =3D xyarray__max_x(xy);

[Severity: High]
Are these assignments intentionally overwriting the loop iteration variable=
s?
This forcefully terminates both the inner and outer loops after checking
only the very first CPU and thread index (0, 0), preventing the iteration
from checking any of the remaining CPUs.

> +				}
> +				if (!count.val)
> +					return 0;
> +			}
> +		}
> +	}
> +
> +	return 1;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701084115.8038=
3-1-atrajeev@linux.ibm.com?part=3D4
