Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327893F86F1
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 12:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779797632; cv=none; b=U6xdn1UdcLEWTbadTuZmz9tHWcmP50QHN3t/I8gjlOMylEgtNH2pfFaZfnJF9y/o96JhuxAEQHyVEWsRLOZ2r4vSsQn7Cuq8HxlnEzclYjyhWLsE9z41WVNKeBXOtDCMxGnGHEi8nGFT6+6yQUK7WfADHsaP5hyJ6avSSBEVJbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779797632; c=relaxed/simple;
	bh=HRctaSpOD08fAmSyhgRa7fE2hGTmkwj5S0CXFnV6aKY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IoEnLrQZoyYHPwAYG2+ASA0CObcFLq2e3Ra73Az3WMdgWY9NYY9Odvk0qF9OAmW2LlYqSuqDi3IiQipLlq6rsquRa7zPGr2MTPyPVHHpBQwrQuywzT73ccoyEYNogU1sgYPiT9+UDHB2vUsfllG/qC5wk8bXjiRfcoXXwt8JxC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9vDZYqY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9vDZYqY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28651F000E9;
	Tue, 26 May 2026 12:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779797628;
	bh=selSWoffNrIxPN9Kf5aD1jy9tBrWF1/80Syr2cJe0+8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d9vDZYqYd0dg7PkCA7QPO4pIBTLgN+8olAsVsDFAFE4Ox+ZLzjHYQWvz1Q/p/clQD
	 RLmu2+4m6xSHgD1fJq5BEZjYXCvs9bWhRHn08wdlmjKsHErhVHHxbIBFiozPBb7Wo3
	 YmH+572zQs7bOGn+KAjNfqx1tXGkSI+Wao57NzslFbg4lJNywn9kuQteMUS+UF+2XR
	 r4EySU1GXrtVagS2T5iT5SQtx5gRKGU55uPX/aul27Rurdc9UNfBiOKpl4cMy6CzNm
	 VyiZUfBOjglgez8u2xzz2nFuQVKPqq0y7HLrsFDni4aIHCURqthuSd58oROauBteMD
	 AwOhueD4LWwtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf test cs-etm: Test thread attribution
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260526-james-cs-context-tracking-fix-v1-2-ebd602e18287@linaro.org>
References: <20260526-james-cs-context-tracking-fix-v1-2-ebd602e18287@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 12:13:46 +0000
Message-Id: <20260526121347.D28651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Unused pipe file descriptors are not closed after `fork()`, whic=
h creates a deadlock risk that can hang the test suite indefinitely.
- [Medium] The test script `context_switch_thread.sh` hardcodes greps for t=
he exact symbol names `thread1` and `thread2`, but the functions are declar=
ed as `static`. Under Link-Time Optimization (LTO) or when local symbols ar=
e stripped, these symbols may be renamed or dropped, causing the test to fa=
il.
- [Low] The user-space test tool incorrectly includes the kernel-specific h=
eader `<linux/compiler.h>` to use the `noinline` macro.
--

commit 5c37aa232ad92e715b665569c8d8414545369de0
Author: James Clark <james.clark@linaro.org>

perf test cs-etm: Test thread attribution

Add a workload that creates two threads reading and writing to a pipe to
verify processor trace attributes symbols correctly across context switches.

> diff --git a/tools/perf/tests/shell/coresight/context_switch_loop/context=
_switch_loop.c b/tools/perf/tests/shell/coresight/context_switch_loop/conte=
xt_switch_loop.c
> new file mode 100644
> index 0000000000000..6b7cd11952a2f
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight/context_switch_loop/context_switch=
_loop.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/compiler.h>

[Severity: Low]
Is it safe to include the kernel-specific header <linux/compiler.h> in this
user-space test tool to use the noinline macro?

If the test is compiled standalone outside of the perf Makefile tree, the
build might fail to find the header. Would using the standard compiler
attribute __attribute__((noinline)) be a more robust approach here?

> +#include <stdio.h>
> +#include <stdlib.h>

[ ... ]

> +static noinline void thread1(int in_fd, int out_fd)

[Severity: Medium]
Could these static declarations cause the test to fail under Link-Time
Optimization (LTO) or if local symbols are stripped?

The companion script context_switch_thread.sh hardcodes greps for the exact
symbol names thread1 and thread2. Since they are declared with internal
linkage, the compiler or linker might suffix the symbols (e.g.,
thread1.lto_priv.0), inline them despite noinline, or omit them from the
symbol table entirely. If omitted, the greps will fail.

Would removing the static keyword ensure they have external linkage and
their symbol names are strictly preserved?

> +{
> +	for (int i =3D 0; i < loops; i++) {
> +		read_block(in_fd);
> +		work +=3D i * 3;
> +		write_block(out_fd);
> +	}
> +}
> +
> +static noinline void thread2(int in_fd, int out_fd)
> +{

[ ... ]

> +	thread1_pid =3D fork();
> +	if (thread1_pid < 0) {
> +		perror("Fork error");
> +		return 1;
> +	}
> +
> +	if (!thread1_pid) {
> +		prctl(PR_SET_NAME, "thread1", 0, 0, 0);
> +		thread1(b_to_a[0], a_to_b[1]);
> +		exit(0);
> +	}
> +
> +	prctl(PR_SET_NAME, "thread2", 0, 0, 0);
> +	thread2(a_to_b[0], b_to_a[1]);

[Severity: Medium]
Does this process setup risk deadlocking the automated test suite?

After fork(), both parent and child processes inherit all four file
descriptors for the two pipes, but neither process closes the unused ends
of the pipes (e.g., the child leaves a_to_b[0] open and the parent leaves
a_to_b[1] open).

If one process exits prematurely, for example via exit(1) upon an
unexpected read or write failure, will the surviving process block
indefinitely in read_block()? It will never receive an EOF because it
still holds a write end of the pipe open itself, which could hang the perf
record command waiting on the workload.

> +
> +	if (waitpid(thread1_pid, &status, 0) !=3D thread1_pid || !WIFEXITED(sta=
tus) ||
> +	    WEXITSTATUS(status))
> +		return 1;
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526-james-cs-c=
ontext-tracking-fix-v1-0-ebd602e18287@linaro.org?part=3D2
