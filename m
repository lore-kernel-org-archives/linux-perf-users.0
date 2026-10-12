Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B141C84D0
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 00:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791765820; cv=none; b=DVgfX7nrtlW9gtDWmF8su0czkBf3qniRacI4AO3cq0LF46Iuxu+vHta1kLti+XIeik65RZdnU8eXQX/gV+o/51iXfwOYBhKIYP0hTzF3Ns8qb4DNT+CZXkXr+gPMuRcOsvAyTRJyOkl/ktxUjxED8UrXTPu2Ph5Djeog7eHCdk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791765820; c=relaxed/simple;
	bh=xKdEDpobRdpEthp8O2+KtItEjeJ9pR+7O/fB7tS2WV0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=X7le9kYro+vE5gwgzaQ9ClVQYO5fL7nKDWfzM7oREZeYNPEuiKtnS00f5VgajOvPqjFAmEH052++opdClYUgYmCm+zW4F7boyG9cG/ccUMpx+RMlKBR5jh5pUW9fMZnPY1ds4yzyenk9yWeC9aYGt1V3t6ixmjWnnvdJMe82ZPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIfNfwah; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIfNfwah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10AC1F0089B;
	Mon, 12 Oct 2026 00:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791765818;
	bh=56/9ViECNplUY0sgbkQWE8xXVF1DnAPqPemiicynoLE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MIfNfwahxO/a/d0k2IE6bWh2v7OsNPBC4Q9fUYvLvvyle0hf03PYjSNxNzCj0XeUf
	 eHD9g7e0GpXPYtf6VfolRHo3M/fIda4eC2z2NynW3H3jjCYHKtjqTDW23vV5iQecj/
	 KPu9a1w+WlapVHM33MjOBLoYcX+HArijtdQbCOnV+0rOvvjPl3izsYBBZjzJL+oltQ
	 aCIs6SvYLp/ZQyGhec69KNU7/NsTXudDXuXbV1BbR2j8JKHamwiAHLY2FR8OY+A5Hi
	 SecyZH//h1phZU4lSdvIeb6kV6Jkr7xt6QlH6hjQe/XWiLI2nLjWUkL/xxrrT0NAjJ
	 Vxlzq8rB12yIA==
Message-ID: <sashiko-outbox-167530@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v3 3/5] perf ftrace: Support display of
 inlined functions in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261012003016.263063-4-atomlin@atomlin.com>
References: <20261012003016.263063-1-atomlin@atomlin.com>
 <20261012003016.263063-4-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 00:43:38 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] perf: machine__delete() used instead of machine__put() violating=
 refcount API
- [Low] perf: missing explicit POSIX libc headers in tools/perf/tests/ftrac=
e.c
- [Low] perf ftrace: make_blank_prefix clobbers comm-pid column in verbose =
mode
--

commit 9964df54e91214dc84e330cbac056548e3af8bc4
Author: Aaron Tomlin <atomlin@atomlin.com>

perf ftrace: Support display of inlined functions in function graph tracer

This commit introduces the --inline option to perf ftrace for the function
graph tracer. It utilizes DWARF debug information to dynamically resolve and
synthesize inlined function frames directly into the streamed call graph.

> diff --git a/tools/perf/tests/ftrace.c b/tools/perf/tests/ftrace.c
> index 596cecee844e3..e856bed00700a 100644
> --- a/tools/perf/tests/ftrace.c
> +++ b/tools/perf/tests/ftrace.c
> @@ -7,6 +7,10 @@
>  #include <unistd.h>
>  #include "tests.h"
>  #include "debug.h"
> +#include "dso.h"
> +#include "machine.h"
> +#include "map.h"
> +#include "symbol.h"
>  #include "util/ftrace.h"

[ ... ]

> +static int test_inline_processing(void)
> +{
> +	static const char line_entry[] =3D " 0)               |  wake_up_new_ta=
sk() {";

[ ... ]

> +	struct perf_ftrace ftrace;
> +	char *out_buf =3D NULL;
> +	size_t out_len =3D 0;
> +	FILE *out;
> +	const char *unmatched_pos;
> +	const char *inline_exit_pos;
> +	int ret =3D TEST_OK;
> +
> +	memset(&ftrace, 0, sizeof(ftrace));
> +	ftrace.use_inline =3D true;
> +	ftrace.filter_retaddr =3D 1; /* Default when --graph-opts retaddr is no=
t specified */
> +	ftrace.tracer =3D "function_graph";

[ ... ]

> +		out =3D open_memstream(&out_buf, &out_len);

[Severity: Low]
Is it possible that test_inline_processing() and other functions in this te=
st
file will fail to compile under musl libc?
The perf subsystem guidelines require files using POSIX standard libc funct=
ions,
constants, or variables to directly include the corresponding headers. This=
 code
makes heavy use of string/memory functions like memset() and file streams l=
ike
open_memstream(), but the file does not include <string.h> or <stdio.h>. Co=
uld
these headers be explicitly included to avoid relying on implicit glibc
namespace pollution?

[ ... ]

> diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
> index 344d36293f5ca..8737bb52921e1 100644
> --- a/tools/perf/util/ftrace.c
> +++ b/tools/perf/util/ftrace.c
> @@ -1,13 +1,82 @@

[ ... ]

> +static void make_blank_prefix(const char *line, const char *pipe_char, c=
har *buf, size_t size)
> +{
> +	size_t len =3D pipe_char - line + 1;
> +	const char *paren =3D strchr(line, ')');
> +	char *c;
> +
> +	if (len >=3D size)
> +		len =3D size - 1;
> +
> +	memcpy(buf, line, len);
> +	buf[len] =3D '\0';
> +
> +	/* Replace duration between ')' and '|' with spaces */
> +	if (paren && paren < line + len) {
> +		char *end =3D buf + (pipe_char - line);
> +
> +		if (end > buf + len)
> +			end =3D buf + len;
> +		for (c =3D buf + (paren - line) + 1; c < end; c++)
> +			*c =3D ' ';
> +	}
> +}

[Severity: Low]
Does make_blank_prefix() inadvertently erase the comm-pid string when in
verbose mode?
In function_graph verbose mode (--graph-opts verbose), the trace output
includes a comm-pid column and a duration column between the CPU number and
the function name. This loop overwrites everything between the closing
parenthesis of the CPU number and the final pipe delimiter before the funct=
ion
name with spaces. While this correctly blanks out the duration column, it
looks like it might unintentionally clobber the task comm-pid string and its
pipe delimiter as well, breaking visual alignment.

[ ... ]

> +void perf_ftrace__cleanup_inlines(struct perf_ftrace *ftrace)
> +{
> +	if (ftrace->machine) {
> +		machine__delete(ftrace->machine);
> +		ftrace->machine =3D NULL;
> +	}
> +	ftrace_cpu_states__clear();
> +}

[Severity: Medium]
Should machine__put() be used here instead of machine__delete()?
The machine reference is allocated using machine__new_host() earlier in
perf_ftrace__setup_inlines(). The perf subsystem guidelines mandate strict
reference count checking, stating that every reference handle allocated via
_new() must be strictly paired with a matching _put(). Bypassing the refcou=
nt
API by calling machine__delete() directly can lead to memory leaks,
use-after-free traps, and LSAN failures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012003016.2630=
63-1-atomlin@atomlin.com?part=3D3
