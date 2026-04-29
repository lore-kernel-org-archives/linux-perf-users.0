Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DD029D288
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 02:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777431238; cv=none; b=S6AXO2+7gTgMPDLmjUUqT/XclB2yXEXOKwDv+/hGAccQWkZaWwhljcs3InOZKSMVZIGthMqL8AKnTDH7QjWOTo6M9vCzFq0UbfIjTOv2iIoqOqznt02HwpiMCBlNK9b9i/m1SU/3TNXaIvMGjgs7WutffoSQKsf5jLBpPdYLwh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777431238; c=relaxed/simple;
	bh=eppZvw1tuSmy0l88KVAWH8BrfK+20wGzJOEBMKCH5qk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jJX67Bkb+EZyjdHvj3yj29ZdydRx0HS6z52KovFdrlE79gVV5rSyikEOq0CjlvOEfQsYvK0GMXvv8VRzYF8ezAjSX5aS8YDa3JZNX0oTbAm+7vlY4xxqX8Rm8SkdwoU74hgKJQOVxOZYLuUzS6pB0ScvcU7cAR4fCHVdZ1qjyXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJzX9jxm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJzX9jxm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2B2C2BCB7;
	Wed, 29 Apr 2026 02:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777431237;
	bh=eppZvw1tuSmy0l88KVAWH8BrfK+20wGzJOEBMKCH5qk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=tJzX9jxm1jZwm1GgR4es5bB7jZmwMZo1EWfV90nAgW5RGRZcCZ4kFCLy9uEnYN7jb
	 5kTxMPVuO8DKQXqLf0NBZi+dhEtYan73d/TW+hdk4k9xsfluKl0CBDxkEexhRsQj7X
	 tBFHv6AdpD3p0AiDKjIdCeaoPsIut+TUg3BkUSNIOn3c8ro7HD20EGGz5QuyKK9I6l
	 SDehfbsCQpQ9T3Wnj1a4iv+5yCoWihE3u1L9pLKoO5b77WSiWpWwzQnSXFceZUe8AK
	 LtGX471eLe398xZizn/P8ZGMcy2TJX2LvuUvrhL3dtezyqvKRCWHQYdPChT0g5xA+b
	 Q3VOlhRa0w0uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] DO NOT MERGE: selftests: perf_events: Add device
 memory callchain unwinding test
Reply-To: sashiko@lists.linux.dev
To: "Fredrik Markstrom" <fredrik.markstrom@est.tech>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260428-master-with-pfix-v3-v1-3-c384d3e53092@est.tech>
References: <20260428-master-with-pfix-v3-v1-3-c384d3e53092@est.tech>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 02:53:57 +0000
Message-Id: <20260429025357.BD2B2C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Insecure temporary file usage in /tmp creates a privilege escalati=
on or file overwrite vector
- [Medium] Test silently reports a false positive on initialization or perf=
 execution failures
- [Medium] Hardcoded 4KB page alignment breaks on arm64 systems with 16KB o=
r 64KB pages
- [Low] Uninitialized wait status variable `pst` can lead to undefined beha=
vior
- [Low] File descriptor for `/dev/mem` is leaked to the `perf` child process
--

commit 72f5293ddcb8999284919045e0f80f532368b0f1
Author: Fredrik Markstrom <fredrik.markstrom@est.tech>
DO NOT MERGE: selftests: perf_events: Add device memory callchain unwinding=
 test

This commit adds a regression test for device memory callchain unwinding by
mapping an MMIO address via /dev/mem and sampling the process with perf.

diff --git a/tools/testing/selftests/perf_events/test_perf_vmio.c b/tools/t=
esting/selftests/perf_events/test_perf_vmio.c
new file mode 100644
index 000000000000..780c5800dd6b
--- /dev/null
+++ b/tools/testing/selftests/perf_events/test_perf_vmio.c

[ ... ]

> +	env =3D getenv("MMIO_ADDR");
> +	if (env)
> +		pa =3D strtoul(env, NULL, 16);
> +
> +	page =3D pa & ~0xFFFUL;
> +	off =3D pa - page;

Is it possible for this to break on arm64 systems configured with 16KB or
64KB pages? The bitwise mask assumes a 4KB page size. Could this be changed
to use sysconf(_SC_PAGESIZE) instead?

> +
> +	fd =3D open("/dev/mem", O_RDWR | O_SYNC);

Does this leak the file descriptor to the perf child process? It is opened
without O_CLOEXEC, so the fd remains open across the execvp() call for perf.

> +	if (fd < 0)
> +		SKIP(return, "cannot open /dev/mem");
> +
> +	/* Fork a spinner child with FP pointing into device memory */
> +	spin_pid =3D fork();
> +	ASSERT_GE(spin_pid, 0);
> +	if (spin_pid =3D=3D 0) {
> +		/*
> +		 * mmap /dev/mem in the child so remap_pfn_range populates
> +		 * PTEs directly. fork() does not copy PTEs for VM_PFNMAP
> +		 * regions, so mapping before fork leaves the child with
> +		 * empty page tables =E2=80=94 the unwinder would get a translation
> +		 * fault instead of a synchronous external abort.
> +		 */
> +		m =3D mmap(NULL, off + 4096, PROT_READ | PROT_WRITE,
> +			 MAP_SHARED, fd, page);
> +		if (m =3D=3D MAP_FAILED)
> +			_exit(1);

If the child process fails to mmap /dev/mem here (for instance, due to
CONFIG_STRICT_DEVMEM or an unaligned offset), it immediately exits.=20

Because the parent does not verify the child's status before running perf,
perf will attempt to attach to a dead process and fail with a status other
than 1. The test then incorrectly passes. Can we verify the child process
is alive before running perf, or check its exit status?

[ ... ]

> +	if (perf_pid =3D=3D 0) {
> +		char *const perf_argv[] =3D {
> +			"perf", "record", "-g", "--call-graph", "fp",
> +			"-p", pid_str, "--", "sleep", "3", NULL
> +		};
> +
> +		if (chdir("/tmp"))
> +			_exit(1);
> +		execvp(perf_argv[0], perf_argv);

Could this overwrite unintended files by running a root-privileged perf
record in the world-writable /tmp directory without specifying an output
file?

perf record defaults to writing to perf.data in the current directory.
An unprivileged user could pre-create a symlink at /tmp/perf.data pointing
to a sensitive file.

Could the test use mkdtemp() to create a secure directory, or pipe the
output instead?

> +		_exit(1);
> +	}
> +
> +	waitpid(perf_pid, &pst, 0);

Could pst be left uninitialized if waitpid() fails and returns an error
(such as -1 from being interrupted by a signal)?=20

This would cause the subsequent WIFEXITED(pst) and WEXITSTATUS(pst) macros
to read uninitialized memory. Can we initialize pst to 0 or check the
waitpid() return value?

> +
> +	kill(spin_pid, SIGKILL);
> +	waitpid(spin_pid, NULL, 0);
> +	close(fd);
> +
> +	if (WIFEXITED(pst) && WEXITSTATUS(pst) =3D=3D 1)
> +		SKIP(return, "perf not available");
> +
> +	/*
> +	 * The real test is that the kernel survived. If we got here
> +	 * without a synchronous external abort, the guard worked.
> +	 */
> +	TH_LOG("kernel survived perf sampling with FP in device memory");
> +#endif /* __aarch64__ */
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428-master-wit=
h-pfix-v3-v1-0-c384d3e53092@est.tech?part=3D3
