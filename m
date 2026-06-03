Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6917637268A
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 10:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780482499; cv=none; b=NGnkrrLf93EZGGrZvWq39PWACnYw/Xw5THgKWT6H+Q+jsjM0AyF+PsnR9q8HuWtugbTjeYvr6u5OA0nR4AbgLpuTqQkt/V+j5mHRjB5Kz9PHxGUcpV8rJiHZlQBj4XJAjVTaRZHrcHjnLXhvAXFymSv7rqYdL+89LUJOgUilI/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780482499; c=relaxed/simple;
	bh=w9WbsApml8rRYZvjYgE9ocJWAF8xOw3WwV3vn7JejOE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MknX6gcBhckXikz31XH4rQuU264lnvn8hKdplysEqOcIRuzNj4+XJ6lWI8eflq/KhxwKJ0kDJWwlIH21LfAFTxcgLbDmQboRcenf5AHasEeuXMLdGdGaFVBnD6GzL9PZpssxcCt9Icyn+0JDBjQMCJREm1iOLUI96cI2iflZxuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUabJM6F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUabJM6F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB021F00893;
	Wed,  3 Jun 2026 10:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780482498;
	bh=qJPrP1zD0h0sKQnXQbTq1DgQTbYepF8Q1HYCtCJ0L5I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SUabJM6F7yIpHtjodyELvQ/dSI+Heg+RJZ1YRVlKyp8g0pwF+3m/KUSxTg7yhhhbX
	 tF26zZo7k6jYaY9w5v3+j1CM1UIeZS79nwIkyPMIZcyfmu8UZg9fVAs1SYmN+aJsHf
	 WT+jqWf3GhgkoLuO7A6IrXVuXxE3d7gxWiJxdIslPxwGnXhO61+svPB4GuFuniIWf4
	 RcM5TiMFajnysMq2tdMLHlVE3PqgCCOi14hkSgl+TlFJiktfPmYDSmK7yswPjgGadA
	 xAtLBRps2HciFNJR+bxPGuB36KFXb632V013AEMjudiyJrYOEdiYFzIIhQJk306KFg
	 7f4xS1FXFGetA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/19] perf test: Add a workload that forces context
 switches
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260603-james-cs-context-tracking-fix-v3-3-c392945d9ed5@linaro.org>
References: <20260603-james-cs-context-tracking-fix-v3-3-c392945d9ed5@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 10:28:17 +0000
Message-Id: <20260603102817.EFB021F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Calling exit(1) on I/O failure in the parent process abruptly te=
rminates the test wrapper and bypasses workload control cleanup.
--

commit 4bc96eb1d44f39f8252cd4bbe7f402600bc7ca26
Author: James Clark <james.clark@linaro.org>

perf test: Add a workload that forces context switches

This workload launches two processes that block when reading and writing
to each other forcing the other process to be scheduled for each
read/write pair.

> diff --git a/tools/perf/tests/workloads/context_switch_loop.c b/tools/per=
f/tests/workloads/context_switch_loop.c
> new file mode 100644
> index 0000000000000..173d770ae6192
> --- /dev/null
> +++ b/tools/perf/tests/workloads/context_switch_loop.c
> @@ -0,0 +1,101 @@

[ ... ]

> +#define write_block(fd) \
> +	do { \
> +		if (write(fd, &buf, 1) <=3D 0) \
> +			exit(1); \
> +	} while (0)
> +
> +#define read_block(fd) \
> +	do { \
> +		if (read(fd, &buf, 1) <=3D 0) \
> +			exit(1); \
> +	} while (0)

[ ... ]

> +	if (!proc1_pid) {
> +		close(a_to_b[0]);
> +		close(b_to_a[1]);
> +		prctl(PR_SET_NAME, "proc1", 0, 0, 0);
> +		context_switch_loop_proc1(b_to_a[0], a_to_b[1]);
> +		close(a_to_b[1]);
> +		close(b_to_a[0]);
> +		exit(0);
> +	}
> +
> +	close(a_to_b[1]);
> +	close(b_to_a[0]);
> +	prctl(PR_SET_NAME, "proc2", 0, 0, 0);
> +	context_switch_loop_proc2(a_to_b[0], b_to_a[1]);

[Severity: Medium]
Since context_switch_loop_proc2() runs in the parent process, does calling
exit(1) on I/O failures abruptly terminate the entire perf test wrapper?

If write_block() or read_block() encounter an error like EINTR, they call
exit(1) directly. Because context_switch_loop_proc2() is executed in the ma=
in
process rather than a forked child, this bypasses the workload control clea=
nup
in run_workload().

Should the parent process return an error code instead of calling exit(1) so
perf test can clean up gracefully?

> +	close(a_to_b[0]);
> +	close(b_to_a[1]);
> +
> +	if (waitpid(proc1_pid, &status, 0) !=3D proc1_pid || !WIFEXITED(status)=
 ||
> +	    WEXITSTATUS(status))
> +		return 1;
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603-james-cs-c=
ontext-tracking-fix-v3-0-c392945d9ed5@linaro.org?part=3D3
