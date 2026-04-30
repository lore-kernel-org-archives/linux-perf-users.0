Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9AE3FFADC
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Apr 2026 12:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777550922; cv=none; b=cZSSuzQ6W0CWor1IDxHvSz0hZgP8jaKAaVIeXRlkXC3rfpLGrU8GnbnOoO/VKQzhicraODqNY3qEGfNmErqHVronRGodpxIxKCusF7s9EQMr7pc5luQjsDUIhaFKc8bHGPLmvdixR2kvi4a/E98o7+sTIdISkh8oaCc/YZvyAfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777550922; c=relaxed/simple;
	bh=waXEBtjIIx9Dr8EQEIEm9MtnogZDsCxd3bv+UbtcalE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ec0jAq/sPIREfAWUxXoDAk+/hBwHjhLscrrZtJTHAEJVJqADs9nxKPHQg9AhtROFrqSDI6azfgAb2LH1EfwE1Uz0fNJB4ttS9gcwCe61AmpBB7ISiidviuGje1wLpBSKQlqelk13YTMohVmYUGtdpKNMmFLd0V9krfvw0WgLzMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvIPtGJm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvIPtGJm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2DD6C2BCB3;
	Thu, 30 Apr 2026 12:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777550921;
	bh=waXEBtjIIx9Dr8EQEIEm9MtnogZDsCxd3bv+UbtcalE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=BvIPtGJmYJc8J+JA9myvuObMx2ZY86SYNMmDzw2Yvoz9n3heCXcVvp/PmBkC/zGdP
	 3wsmDVYy0W3tff5y0WUHKZu6SHSPVslACbsoIm6f4pgtHFFTRdI4Mw+KegtmSotvZh
	 LJWmvcbCgKZ9LKB5ejRrGgCD2WPzTstAhSLnysTy7nG3I7/ebLqgQgOjPh9XJthfCP
	 gvC1DX0eToki2wT2dP14j6gf06orDmydb6eYEBUREOmd/3qQU2IZcN5dyQts+a0eWH
	 o8atHdypzpzNnfDELjBryuC79atCqIjpQQcMEmzl/RfsCrnefwJOpMJDuBusqJxkwJ
	 2Hu6RuqWRLE/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] DO NOT MERGE: selftests: perf_events: Add device
 memory callchain unwinding test
Reply-To: sashiko@lists.linux.dev
To: "Fredrik Markstrom" <fredrik.markstrom@est.tech>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260430-master-with-pfix-v3-v2-3-bd526ec04a75@est.tech>
References: <20260430-master-with-pfix-v3-v2-3-bd526ec04a75@est.tech>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Apr 2026 12:08:40 +0000
Message-Id: <20260430120841.A2DD6C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] The test silently passes if `/dev/mem` mmap fails or `perf recor=
d` encounters an error.
- [Medium] Race condition due to missing synchronization between child proc=
ess initialization and `perf record`.
- [Medium] The temporary directory and `perf.data` file are permanently lea=
ked on every test run.
- [Medium] The child process can become a runaway process consuming 100% CP=
U if the parent is terminated.
--

commit c99f3e3dd4b06157e6d6eea6478e0ee3ffe3951a
Author: Fredrik Markstrom <fredrik.markstrom@est.tech>
DO NOT MERGE: selftests: perf_events: Add device memory callchain unwinding=
 test

This commit adds a kselftest that uses perf record to sample a process
that has its frame pointer pointing into a device memory mapping created
via /dev/mem. The test is designed to verify that the kernel survives
without crashing due to synchronous external aborts.

> diff --git a/tools/testing/selftests/perf_events/test_perf_vmio.c b/tools=
/testing/selftests/perf_events/test_perf_vmio.c
> new file mode 100644
> index 0000000000000..c9ceee3f15927
> --- /dev/null
> +++ b/tools/testing/selftests/perf_events/test_perf_vmio.c
[ ... ]
> +	/* Fork a spinner child with FP pointing into device memory */
> +	spin_pid =3D fork();
> +	if (spin_pid < 0) {
> +		close(fd);
> +		rmdir(tmpdir);
> +		ASSERT_GE(spin_pid, 0);
> +	}
> +	if (spin_pid =3D=3D 0) {

If the parent test process crashes or is killed by a test runner timeout
before executing kill(spin_pid, SIGKILL), will the child process be orphaned
and run indefinitely in the busy-wait loop?

Could prctl(PR_SET_PDEATHSIG, SIGKILL) be used here to ensure the child is
automatically killed if the parent dies?

> +		/*
> +		 * mmap /dev/mem in the child so remap_pfn_range populates
> +		 * PTEs directly. fork() does not copy PTEs for VM_PFNMAP
[ ... ]
> +		 */
> +		m =3D mmap(NULL, off + page_size, PROT_READ | PROT_WRITE,
> +			 MAP_SHARED, fd, page);
> +		if (m =3D=3D MAP_FAILED)
> +			_exit(2);

If this mmap() fails (for example, due to CONFIG_STRICT_DEVMEM), the child
exits immediately. Since the parent ignores the child's exit status, does
this cause the test to silently pass without ever exercising the
vulnerability?

> +		fp =3D (char *)m + off;
> +		__asm__ volatile(
> +			"mov x29, %0\n"
> +			"1: b 1b\n"
> +			: : "r"(fp) : "x29", "memory");
> +		_exit(0);
> +	}
> +
> +	/* Launch perf to sample the spinner */
> +	snprintf(pid_str, sizeof(pid_str), "%d", spin_pid);
> +
> +	perf_pid =3D fork();

Is there a race condition here between the child process initialization and
perf record?

If the system is heavily loaded, perf record might finish its 3-second
sleep before the child process completes the mmap() and reaches the
assembly loop.

Could we add synchronization, such as a pipe or file lock, to ensure the
child is ready before perf starts sampling?

[ ... ]
> +	waitpid(perf_pid, &pst, 0);
> +
> +	kill(spin_pid, SIGKILL);
> +	waitpid(spin_pid, NULL, 0);
> +	close(fd);
> +
> +	/* Clean up perf output */
> +	rmdir(tmpdir);

Does rmdir() fail with ENOTEMPTY because perf record generated a perf.data
file inside the directory?

Since unlink() is not called on the perf.data file, do the directory and
file leak on the file system after every test run?

> +
> +	if (!WIFEXITED(pst))
> +		SKIP(return, "perf terminated abnormally");
> +	if (WEXITSTATUS(pst) =3D=3D 1)
> +		SKIP(return, "perf not available");
> +
> +	/*
> +	 * The real test is that the kernel survived. If we got here
> +	 * without a synchronous external abort, the guard worked.
> +	 */
> +	TH_LOG("kernel survived perf sampling with FP in device memory");

If the child exited early because mmap() failed, perf record will fail to
attach to the zombie process and might exit with a code other than 1 (such
as 255).

Because the check here only looks for WEXITSTATUS(pst) =3D=3D 1, does this
allow other perf failures to bypass the check and incorrectly log that the
test passed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260430-master-wit=
h-pfix-v3-v2-0-bd526ec04a75@est.tech?part=3D3
