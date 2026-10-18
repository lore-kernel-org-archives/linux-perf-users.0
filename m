Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1AE29D291
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 02:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792291566; cv=none; b=IoxuQQZcAEqxj9H+TF8B4dblwl9i9+53exqtpxCPCrrDaMrzAcvyWhxzlhknpsCoJw98F8Bl1kuL5mldS5nlvbsvL+Ym9ExRaVyqg8BFgly1ivl/iV0EoGjxMBNCjhQ4keq22FW0hyvZD+DMMbg7L9yFwUbc4gjujQgmDgHDejQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792291566; c=relaxed/simple;
	bh=WqM6HbVJJHmfqO3celfuZfFq5vKg3tS2nTBa4HlawQg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=YpGrOKApm2nOASGJUY7KlapzI71N2HKUQvjt2oEZzQkjB57LKyPjC58en7RWq44Xo3n2T6YliOWDQ/kzB7bKiGZRjuFf1Qo1JLIjE1fzVJYjUMX8+DQGj3Fri+kLTIcg+NHnP+uw24+bUd4p0BqVC+ec2f5kSk8vyutNhPTDngY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGT2Yb0p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGT2Yb0p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D271F000C4;
	Sun, 18 Oct 2026 02:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792291564;
	bh=fZ+ahQ+CU9vMyKhfVAKakFYN/sIAhhv4OgrXLkQXHcI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XGT2Yb0pYyCZtep1Ft+oOmA4DPQhGU1aBEiGp8QZFLJV0bKR3v9GoaiARmtrj9ASf
	 ZODm+xScYIbFUFS+4/xbhHsRXd7mC16C5Y0tb7dhOvHYGETjeCejlyVg1NBbLEMfe9
	 awD0PsYH+rBHjvEhYieR2vOlJRAHXP54nY7z6mT0kKJ4EY7nABsQulI1yuR3c6gf/K
	 3FScuQqAeZ4gwVWc0kYy9hLWdVF1NakDKOKSgp+gdXJx9MPjxjp03PXlJC8MxCcrUg
	 nVRiT40kZkip2ScDJ2paqMAxOoflSPSpoRz8vnkpBTzji9eOd2t/yQDGvSJFnS4xHU
	 0j+NjOVC1H1CA==
Message-ID: <sashiko-outbox-175890@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v8 2/6] perf ftrace: Support filtering
 return address comments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261018023753.584873-3-atomlin@atomlin.com>
References: <20261018023753.584873-1-atomlin@atomlin.com>
 <20261018023753.584873-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 02:46:04 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf ftrace: ftrace_filter_retaddr() strips leaf return values
--

commit bb5a10abc2299a6ae2ba0cbda70fab044e68ad36
Author: Aaron Tomlin <atomlin@atomlin.com>

perf ftrace: Support filtering return address comments

This commit introduces ftrace_parse_retaddr() and ftrace_filter_retaddr()
along with a --filter-retaddr command-line option and unit tests to strip
funcgraph-retaddr return address comments from function_graph trace output.

> diff --git a/tools/perf/tests/ftrace.c b/tools/perf/tests/ftrace.c
> new file mode 100644
> index 0000000000000..596cecee844e3
> --- /dev/null
> +++ b/tools/perf/tests/ftrace.c
> @@ -0,0 +1,80 @@

[ ... ]

> +static int test_filter_retaddr(void)
> +{
> +	char line1[] =3D "kernel_read() { /* <-load_elf_phdrs+0x6c/0xb0 */";
> +	char line2[] =3D "__cond_resched(); /* <-load_elf_phdrs+0x6c/0xb0 ret=
=3D0x0 */";
> +	char line3[] =3D "do_filp_open();";
> +
> +	ftrace_filter_retaddr(line1);
> +	TEST_ASSERT_EQUAL("filter standard retaddr", strcmp(line1, "kernel_read=
() {"), 0);
> +
> +	ftrace_filter_retaddr(line2);
> +	TEST_ASSERT_EQUAL("filter retaddr with ret", strcmp(line2, "__cond_resc=
hed();"), 0);
> +
> +	ftrace_filter_retaddr(line3);
> +	TEST_ASSERT_EQUAL("filter line without retaddr unchanged",
> +			  strcmp(line3, "do_filp_open();"), 0);
> +
> +	return TEST_OK;
> +}

[ ... ]

> diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
> new file mode 100644
> index 0000000000000..aaf108369c365
> --- /dev/null
> +++ b/tools/perf/util/ftrace.c
> @@ -0,0 +1,86 @@

[ ... ]

> +/**
> + * ftrace_filter_retaddr - Remove return address comment from trace line
> + * @str: The trace line to modify
> + *
> + * Find and strip the funcgraph-retaddr comment from the trace line
> + * in-place, removing trailing spaces where applicable.
> + */
> +void ftrace_filter_retaddr(char *str)
> +{
> +	char *start =3D strstr(str, "/* <-");
> +	char *end;
> +
> +	if (!start)
> +		return;
> +
> +	end =3D strstr(start, "*/");
> +	if (!end)
> +		return;
> +
> +	end +=3D 2; /* skip end-of-comment delimiter */
> +
> +	/* Also backtrack any spaces before comment */
> +	while (start > str && *(start - 1) =3D=3D ' ')
> +		start--;
> +
> +	memmove(start, end, strlen(end) + 1);
> +}

[Severity: Medium]
Does ftrace_filter_retaddr() unintentionally strip return values from leaf
functions when both funcgraph-retaddr and funcgraph-retval are enabled?

In kernel/trace/trace_functions_graph.c:print_graph_retval(), when both
TRACE_GRAPH_PRINT_RETADDR and TRACE_GRAPH_PRINT_RETVAL are active, the
kernel combines the return address and return value into a single comment on
leaf functions:

    __cond_resched(); /* <-load_elf_phdrs+0x6c/0xb0 ret=3D0x0 */

Non-leaf functions place the return address on the entry line and the return
value on the closing brace line, so their return values are unaffected.
However, on leaf functions, ftrace_filter_retaddr() removes the entire
comment from "/* <-" through "*/", discarding "ret=3D0x0" as well (which
test_filter_retaddr() also asserts).

When running with "--graph-opts retaddr,retval --filter-retaddr" (or when a
subsequent change such as "perf ftrace: Support display of inlined functions
in function graph tracer" automatically enables funcgraph-retaddr and
filter_retaddr alongside "--graph-opts retval"), shouldn't
ftrace_filter_retaddr() preserve the "/* ret=3D... */" portion of the comme=
nt
on leaf functions instead of removing the whole comment block?

([ ... ])

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018023753.5848=
73-1-atomlin@atomlin.com?part=3D2
