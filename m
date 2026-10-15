Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A28282F34
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 01:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792027485; cv=none; b=T8xqaCLvb3lpKCA3J8mZFjCLKUF69NZE+X7gk5IPvXIHmE560Di9EOVzi9/Rbc8R6erLVGRMxkgsO3R5EyGzaZk7Yoc/BDeHVCQfVckfGjEOfmXlunDTkRUbi9ssboos/1G4D259ksafiVfnapMMm8jN/Nfi+HGHhRuDZuf6iz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792027485; c=relaxed/simple;
	bh=GDhA/t7excOtS9QHVPMllHyFa/r9vnnC9EzM4nm2ka0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=CMkdmhf7hdq9eiZBsuJ0JOE1yX/WjrqCFkvwaHXF/J8qwoz5rBfA9kIkpIRoy9HYLj08wytyezBKr2CJ3SH0naYxsFqZDxDtYbmwI4XnSX2KETQW04zHZNgaGMZIsurOxI1/THzZvdbiYaQyOmWe+uulkfKfDXKJbCO05g2hsJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+nqV6Z9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+nqV6Z9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DE91F000C4;
	Thu, 15 Oct 2026 01:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792027484;
	bh=6Hh8LblJue9MqHap/NDuE/ynrBczjRrNYmIo7RMmPhU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P+nqV6Z9nTC/eAt5TSTKDBCAEjkJrDb31OU7DURhD6AldLNU/XAcFPnP99lM8TDda
	 Y5LxRtuHwimT2nw4Vri8Fs8GXk3LfjYXUETBforkqKAqb+pjWEXRyF11EhV8tzzuCN
	 qegxjHQ1o6L3sF63orFa1etNhKf0daEl8vFzibYwLugcbg5bKLtUJIlVNr7Kviiiwr
	 1IcGzAb9EXQ8TSU9uVfcTgYRTtIBilKBEfiUql6EVpCSe99yMFco9BjwszayaBHDBM
	 on/N1m9Oj8moyUcRUM+mQl5NuirgXUWVfq22KPD7ZCnBBuYh9mkEFKN+G0SyFhg07l
	 lAIXbegLA872Q==
Message-ID: <sashiko-outbox-172087@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v5 3/5] perf ftrace: Support display of
 inlined functions in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261015011155.414667-4-atomlin@atomlin.com>
References: <20261015011155.414667-1-atomlin@atomlin.com>
 <20261015011155.414667-4-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 01:24:43 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf ftrace: implicit declaration of zalloc due to missing <linu=
x/zalloc.h>
- [Low] perf tests: memory leak of out_buf on test assertion failure
--

commit e3c3c2f995806f10402b965ab958305c3e8ca004
Author: Aaron Tomlin <atomlin@atomlin.com>

perf ftrace: Support display of inlined functions in function graph tracer

This patch introduces the --inline option to perf ftrace for the
function_graph tracer. It resolves return addresses to their inlined
callchains using DWARF debug information and synthesises the intermediate
inlined frames directly into the streamed call graph.

> diff --git a/tools/perf/tests/ftrace.c b/tools/perf/tests/ftrace.c
> index 596cecee844e3..3d0f5748252b5 100644
> --- a/tools/perf/tests/ftrace.c
> +++ b/tools/perf/tests/ftrace.c

[ ... ]

> +static int test_stack_saturation(void)
> +{
> +	struct perf_ftrace ftrace;
> +	char *out_buf =3D NULL;
> +	size_t out_len =3D 0;
> +	FILE *out;
> +	int i;

[ ... ]

> +	/* Verify base_func starts at standard 2 spaces indentation without dri=
ft */
> +	TEST_ASSERT_VAL("no indentation drift after stack saturation",
> +			strstr(out_buf, "|  base_func() {") !=3D NULL);
> +
> +	free(out_buf);
> +	return TEST_OK;
> +}

[Severity: Low]
Does this code leak out_buf if the assertion fails?

The TEST_ASSERT_VAL macro appears to return early upon failure, which would
cause the execution to bypass the free(out_buf) call at the end of the
function.

> diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
> index aaf108369c365..09b2fd30a01b7 100644
> --- a/tools/perf/util/ftrace.c
> +++ b/tools/perf/util/ftrace.c

[ ... ]

> +static struct ftrace_cpu_state *get_cpu_state(int cpu)
> +{
> +	if (cpu < 0 || cpu >=3D FTRACE_MAX_CPUS)
> +		return NULL;
> +
> +	if (!ftrace_cpu_states[cpu])
> +		ftrace_cpu_states[cpu] =3D zalloc(sizeof(struct ftrace_cpu_state));

[Severity: Medium]
Will this cause a build failure or pointer truncation due to a missing
declaration for zalloc()?

Since the appropriate header providing the prototype for zalloc() does not
seem to be explicitly included, the compiler might implicitly assume it
returns an int.=20

On 64-bit architectures, this could truncate the returned pointer.
Alternatively, modern compilers configured to warn about implicit function
declarations may fail the build entirely.

> +
> +	return ftrace_cpu_states[cpu];
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015011155.4146=
67-1-atomlin@atomlin.com?part=3D3
