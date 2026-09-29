Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663AA3A7F54
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 03:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790650838; cv=none; b=UXju1zTNzvG4fVPs/Acy87kdggIvDbVCLT2rHdFcO7QNjk0YEB+QsC2EuLpO5BAo/Y8/m+4IdlxTNLb0clVSlBozlXIx+k5pnt7Y+A1l/OSjtdjUMleEyjEH9PAu24VE9KEMp8SyXZLm22QBLmv1+naGw0LuCbjLH/PE8K5X/+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790650838; c=relaxed/simple;
	bh=bBGFFivXNSx+UWnRIM/5ERy8+w3xGXV4QLtf/mJfjBg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LKmiosjX+hnQgY7uJJ1ckmadR0R5PNIZaLddrhoopTXk4gZVOZ83iNQcbVhiVegXjENQhoekjO+JwJ0eWOBY02abVxoE59Te99g83gxvPa6duXDHTgVa3CuTX02VgEQfuIz6sfhNuXrqiT03IJo23RlrUvEI59YKZOYjQy5z1zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moKCUUxj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moKCUUxj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D801F00893;
	Tue, 29 Sep 2026 03:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790650833;
	bh=fZjv/VAJuWZrzI190IrWmbz0a5gi/zx8GpXmmR9Hl/E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=moKCUUxjPSbbaJMJ2Rq1TgPCEDjAA77slCRESccFWDmDL7dSPRrVVpMVDqCLVOO+t
	 UTpavcOdpNdkruOx3rLrNfqetqIUgqrrBO/FcRqBhMUSwuY0GTieNn+Z3RZZCR08+l
	 C7i47IuSCN94zZBA9W0+0+0uI0SXwdHMerwWYfuCP0x0EfiQe7AnhWqVt9a+kjUNLX
	 xFPwZwGalpq2yKfCciWWzgVyolgxPhBr8v4PaU00XoX3o+yUypLXhLWWVFBU5t5cGK
	 HUVbzOpGDU0Af5L7RL3tCkSblkTz8toap4P1Q6VN27NJKYOrQ/nShRsAfazg6XUL3A
	 19c895brxXgPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] perf test: Add per-test timeout support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929025345.88829-1-irogers@google.com>
References: <20260929011837.4157334-1-irogers@google.com>
 <20260929025345.88829-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 03:00:32 +0000
Message-Id: <20260929030033.02D801F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When a test hangs in 'perf test', the entire test run hangs and makes it
> difficult to inspect output from other tests.
>=20
> Add a new TEST_TIMEOUT result category and a per-test timeout (default
> 60 seconds, configurable via '-t'/'--timeout', with 0 to disable). When
> '-F' ('--dont-fork') is specified, timeouts are disabled.
>=20
> To enforce the timeout:
> - Place each forked test child into its own process group via
>   setpgid(0, 0) in the child and setpgid(pid, pid) in the parent so any
>   subprocesses spawned by shell or workload tests can be terminated
>   together.
> - Arm an ITIMER_REAL periodic timer with a SIGALRM handler (using
>   SA_RESTART so /proc status reads in check_if_command_finished() are
>   not interrupted by EINTR while poll()/usleep() waits still wake up).
> - Check elapsed child runtimes against test_timeout in finish_test() and
>   finish_tests_parallel(), sending SIGTERM first and escalating to
>   SIGKILL after 1 second if the child process group has not exited.
> - Report timed out tests in red ('TIMEOUT!'), track and display them in
>   the test summary, and emit '<error message=3D"TIMEOUT" type=3D"timeout"=
>'
>   counted under the 'errors' attribute in JUnit XML output.
> - Document '-t'/'--timeout' and '-F'/'--dont-fork' in perf-test.txt.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929025345.8882=
9-1-irogers@google.com?part=3D1

