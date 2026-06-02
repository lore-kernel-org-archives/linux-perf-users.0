Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BC33BAD82
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 14:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411122; cv=none; b=REdQmUo1xSVpkEJiY5B0JNrh2uuGwl+OPXsyB5zSIam+mG7VI3WZvo2uCKYA1KAQjdmBQ02rmqCStRsvfRZ9rVzgv6w/O8MuF1qHFtSQOqcl/AwRtI8kTBrvpcykoynIlolT1QLzBhuuQZz4/70Qff0zlC2w3ml6HthrWPxYRL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411122; c=relaxed/simple;
	bh=T8n4xrhfJ9AGXMKegFKmS3+fPTveCktqpmTJOBHHxoE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OkdsXD5WHwcWG9OWUiIgt33yhN70ynFR21s92blE2FWjAENGI3rgoPvdWBf5aPibf+/sdem4tBU+jPZ+MRwdoDO/N3fOfvzZpDZJ0eeQLCC9KN+CIjWs4MMDlGr9A8xgbbXtp+xDXC1JHT7z+D+HTYhz+0aEGnMML9YpFflbjIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqd/T7Pt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqd/T7Pt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAEB1F00893;
	Tue,  2 Jun 2026 14:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780411121;
	bh=hmF8SxQa5l5iqrYi3uXgYNf5zUrSjlA8zO0eaujnlEs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jqd/T7PtGpl9xvc+Ty2eY4NBJraKq0i+7BYWd/v+VNp4zh4wtwTa4jR6DEuPczxyC
	 IRWBbRKgweiLbL4ilCSfy+pGm0A6jUEH4RbqDFO6PntnIxNYKUluHYRbFj/wZOpdMw
	 FxOawECrjNizBfzD6EIlnbJL9Yb9t96/BbcKuk02lcUJu6eT1tKMm4Nk4lQvxQMKWt
	 NmlUlkXutOJMTdx3DHp+vDH7EC2cfI6Du0T0rrdKxmnKlBaga74xPciyejpM8JYbV3
	 0geJqAHbicDFmrTGIDbU9LuXoaOi2xDGeUqlHKWJlNjbeNchF0z1p5idZ4DZoUVQ+H
	 b4olrRBiW5WhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/18] perf test: Add a workload that forces context
 switches
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602-james-cs-context-tracking-fix-v2-3-85b5ce6f55c6@linaro.org>
References: <20260602-james-cs-context-tracking-fix-v2-3-85b5ce6f55c6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 14:38:40 +0000
Message-Id: <20260602143841.1AAEB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Parent process fails to close unused pipe ends, causing a deadlo=
ck if the child exits prematurely, and leaks file descriptors on all paths.
--

commit 4b7337e6446674341b89bdd15dec4b286776529f
Author: James Clark <james.clark@linaro.org>

perf test: Add a workload that forces context switches

This commit adds a new test workload that forces context switches by launch=
ing
two processes that block when reading and writing to each other.

> diff --git a/tools/perf/tests/workloads/context_switch_loop.c b/tools/per=
f/tests/workloads/context_switch_loop.c
> new file mode 100644
> index 0000000000000..73bfcaeff5b09
> --- /dev/null
> +++ b/tools/perf/tests/workloads/context_switch_loop.c

[ ... ]

> +static int context_switch_loop(int argc, const char **argv)
> +{
> +	int a_to_b[2], b_to_a[2];
> +	pid_t proc1_pid;
> +	int status;

[ ... ]

> +	if (pipe(a_to_b) || pipe(b_to_a)) {

[Severity: Medium]
If pipe(b_to_a) fails, does this return 1 and leak the file descriptors
successfully allocated by pipe(a_to_b)?

> +		perror("Pipe error");
> +		return 1;
> +	}
> +
> +	proc1_pid =3D fork();
> +	if (proc1_pid < 0) {
> +		perror("Fork error");
> +		return 1;

[Severity: Medium]
Similarly, does this error path leak all 4 file descriptors allocated by the
pipes?

> +	}
> +
> +	if (!proc1_pid) {
> +		close(a_to_b[0]);
> +		close(b_to_a[1]);
> +		prctl(PR_SET_NAME, "proc1", 0, 0, 0);
> +		context_switch_loop_proc1(b_to_a[0], a_to_b[1]);
> +		exit(0);
> +	}
> +
> +	prctl(PR_SET_NAME, "proc2", 0, 0, 0);
> +	context_switch_loop_proc2(a_to_b[0], b_to_a[1]);

[Severity: Medium]
Does the parent process (proc2) need to close its unused pipe ends (a_to_b[=
1]
and b_to_a[0]) before executing its workload loop?

If the child process (proc1) terminates unexpectedly or calls exit(1) (e.g.,
due to a read/write error), it closes its file descriptors. However, the pa=
rent
waiting in read(a_to_b[0]) will not receive an EOF (0) because it still hol=
ds
the write end a_to_b[1] open itself. This could cause the parent to block
indefinitely and hang the test suite.

> +
> +	if (waitpid(proc1_pid, &status, 0) !=3D proc1_pid || !WIFEXITED(status)=
 ||
> +	    WEXITSTATUS(status))
> +		return 1;
> +
> +	return 0;

[Severity: Medium]
Do the waitpid error path and successful return path both exit without clos=
ing
the remaining pipe file descriptors?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602-james-cs-c=
ontext-tracking-fix-v2-0-85b5ce6f55c6@linaro.org?part=3D3
