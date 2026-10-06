Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBEA8834
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 23:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791329746; cv=none; b=FHAjtOG8ekS404Of+Xpv+GAZ37h4oy8K4oFSo6ClYR5lz0XSNfhDGhjtvLaEqV98RowANcmF4cKRxnsiG6Nr5q0HrNFaScvr9wPjhqCws7nTIEdLyhO2n6xMGdxZuK0zdRfHPLt8gqELIv2zsetwqLJvmfSZlZs+gtObaSXv9gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791329746; c=relaxed/simple;
	bh=Y2TSaivEadBWp1yRlRcuaMNZR6P3ABiOeDclDxeIuGs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=rkNhIqmz159HfM2KbVSuA1ajb5zckOswRvSOXMWQIanuWd1f1Hprhg+OVaiMuIQ8p04YHdccYYX8PiINqhM1jw2nJPskcBC+cnqSZCiTAaHjkFvg+g9GlsmpjeTloKoGqDT8MKuPcnLIirvJ02rZWdzP1Tb2ewiB2FpnIaRkL70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Osq56kIt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Osq56kIt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD041F0089B;
	Tue,  6 Oct 2026 23:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791329744;
	bh=T3YETzf/j7D9+SIpv8GiqhdUQHUQ5OhmBkrXr5Gy4KI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Osq56kItZTmkiJE1oC3/4FhahSqufmibLAGJkWf3y+Ew+5VFect6CSnRVBCJ6yaU5
	 7WbagkDz50c+q4sUt68ZfKw8wSB7xfbdPMH2gP1hQaSK1mtOXUG7RGngyd79QXmEm7
	 a9RLGxO9AUdui+yodTrbX4fABaDHuOo+tlfKKNU+5RXCXKvCbA7DJfE5ihNEwumK2d
	 GkWMRMNtjcCkJkMYzzr0rYHO4XLU6kSLvirANwNZSsYG1TegAQWU2J3PDPzO+6v0Sn
	 Z/Rd4QCIuPws/IaClAQgEuQ5hgqFKaEIrWvrHl7K3zgRtuEGYpnM7iXAjFI3FCLBAk
	 8jJZuNc2746aw==
Message-ID: <sashiko-outbox-162513@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v2 1/4] perf ftrace: Optimise
 __cmd_ftrace() stack frame with strbuf streaming
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006232756.65620-2-atomlin@atomlin.com>
References: <20261006232756.65620-1-atomlin@atomlin.com>
 <20261006232756.65620-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 23:35:44 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: Memory leak of buf and linebuf on early ftrace setup error=
 paths
--

commit e5886f5c4e0cc584a5a7ac05c7c069ab1b80f135
Author: Aaron Tomlin <atomlin@atomlin.com>

perf ftrace: Optimise __cmd_ftrace() stack frame with strbuf streaming

This commit refactors __cmd_ftrace() to use a dynamically allocated buffer
and a string buffer for streaming trace data instead of a fixed stack array.

> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 6017493ff1797..4e77a0b2513f8 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c

[ ... ]

> @@ -767,6 +771,13 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
> =20
>  	setup_pager();
> =20
> +	buf =3D malloc(TRACE_BUF_SIZE);
> +	if (!buf) {
> +		pr_err("failed to allocate trace buffer\n");
> +		goto out_reset;
> +	}
> +	strbuf_init(&linebuf, 512);
> +
>  	trace_file =3D get_tracing_instance_file("trace_pipe");
>  	if (!trace_file) {
>  		pr_err("failed to open trace_pipe\n");

[Severity: Medium]
If get_tracing_instance_file("trace_pipe") returns NULL, or if the subseque=
nt
open(trace_file, O_RDONLY) fails within __cmd_ftrace() in
tools/perf/builtin-ftrace.c, the error path executes goto out_reset.

Because the out_reset label completely skips the resource teardown label
out_close_fd:

out_close_fd:
	free(buf);
	strbuf_release(&linebuf);
	close(trace_fd);
out_reset:
	exit_tracing_instance();

Does this permanently leak the heap-allocated buf (TRACE_BUF_SIZE bytes) and
the internal buffer of linebuf on these early ftrace setup error paths?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006232756.6562=
0-1-atomlin@atomlin.com?part=3D1
