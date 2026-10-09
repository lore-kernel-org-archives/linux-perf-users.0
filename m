Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5993911A8
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Oct 2026 16:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791562250; cv=none; b=Kio3V+tTOnBYkOv7Nv0I/tZUAUTM2rl8rZQb/YSsA0K+5jh5H2DGW0FRJDQhM5CkCaiHYE01R50jcJrzRqai+c3D9I71eL3MhUwiH/2bqh1CyBEi2VVRjYtyebntmCCPwM8jqwD+ytt2GuBPkikOJQKCPazqFRTtR63+ZiZ8Mgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791562250; c=relaxed/simple;
	bh=Xw6aitEnhSj03OoVGV+NQUIYRxIVlwCtIDSxzGxKXqo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=WqJF+mw30u7im7JLPo0lCQal4Ydtzcik/k+Y6INZ6EXmgnp4UeD34abZ9iK1a4cDCrOEH8ug+ePYgcjvgDnlsBVWdwVoSudxRxYDWu9ZbxmQb16zEPbl8eKaQyNJFyeE8BZys9G1NIlIinLu8xLYwxNvd2XxAU1QkR1rkVze9nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUex9r8/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUex9r8/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702C71F000FF;
	Fri,  9 Oct 2026 16:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791562248;
	bh=CViapJJDeKSOwV1FXzosNqvpULKrnvJmpxfKrrBbGbI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GUex9r8/wZldCDMvoFa6Px+gWMYrq8xBAHtJxbRaTtKJJmvhU6I8lxgqr+XVvQ6Jw
	 eHkWMZKoYWL68pZKCWLtcFqQKaage75PLCyVtsv8JDnufGO+KXhjzfkwKHGsBjp+2Q
	 YvyS6x6jY/G4VEeeE407DQHgF/XABSXQB2QA8wenUXOeuy+6VHvHKArg5t18zPDrIL
	 bXSCJNpC+dXoCoLm34T3+CJe1XVERvlvM8Qb6EoqBZv+yXTm1dIHPkxmxxhZfe3Mnp
	 B4fU0xbq0oXpEGBMYExxmjtS3Q+2mglVDwqyzNgg+AF7TghdhqaElJKUBrJsLL4ASJ
	 +AOWW88I31fPQ==
Message-ID: <sashiko-outbox-165816@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] selftests/perf_events: add AUX kernel API
 selftest script
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kunwu Chan" <kunwu.chan@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261009160010.1829642-6-kunwu.chan@gmail.com>
References: <20261009160010.1829642-1-kunwu.chan@gmail.com>
 <20261009160010.1829642-6-kunwu.chan@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 16:10:48 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Medium] selftests: bash syntax error due to missing line continuation
- [Medium] selftests: manual C compiler invocation bypasses Makefile and CF=
LAGS
- [Low] selftests: incorrect translation of KSFT_SKIP exit code to failure
- [Low] selftests: git dependency for source tree path resolution fails in =
tarballs
- [Low] selftests: untracked TEST_GEN_PROGS binary missing from .gitignore
- [Low] selftests: brittle source code grep tests create maintenance burden
--

commit b62175593d8e1e9cdad05106f3f506af47e718eb
Author: Kunwu Chan <kunwu.chan@gmail.com>

selftests/perf_events: add AUX kernel API selftest script

This commit adds a shell script to run the perf_aux_kernel KUnit suite, use=
rspace
regression program, hardware tests, and static checks. It is designed to wo=
rk
both in-tree and from an installed selftest location, with results written =
to a
temporary directory.

> diff --git a/tools/testing/selftests/perf_events/Makefile b/tools/testing=
/selftests/perf_events/Makefile
> index fbafbd43f097e..9b82c7ee1238a 100644
> --- a/tools/testing/selftests/perf_events/Makefile
> +++ b/tools/testing/selftests/perf_events/Makefile
> @@ -4,4 +4,5 @@ LDFLAGS +=3D -lpthread
> =20
>  TEST_GEN_PROGS :=3D sigtrap_threads remove_on_exec watermark_signal mmap
>  TEST_GEN_PROGS +=3D aux_kernel_usermode

[Severity: Low]
Is aux_kernel_usermode missing from tools/testing/selftests/perf_events/.gi=
tignore?

Building the selftests will leave this untracked binary in the working tree,
polluting the repository status.

> +TEST_PROGS +=3D aux_kernel.sh
>  include ../lib.mk

[ ... ]

> diff --git a/tools/testing/selftests/perf_events/aux_kernel.sh b/tools/te=
sting/selftests/perf_events/aux_kernel.sh
> new file mode 100755
> index 0000000000000..af7f2e8d5d094
> --- /dev/null
> +++ b/tools/testing/selftests/perf_events/aux_kernel.sh

[ ... ]

> +SCRIPT_DIR=3D"$(cd "$(dirname "$0")" && pwd)"
> +ROOT=3D"$(git -C "$SCRIPT_DIR" rev-parse --show-toplevel 2>/dev/null || =
true)"

[Severity: Low]
Will this git dependency fail when executed from a release tarball?

When testing from a kernel source tarball, the .git directory is absent and
the git rev-parse command will fail. This causes $ROOT to be empty,
silently skipping the source-level analysis despite the full source tree
being available. Traversing parent directories via relative paths is a more
robust approach.

[ ... ]

> +	echo "  Building aux_kernel_usermode with ${CC}..."
> +	if "$CC" -o "$UMODE_BIN" "$UMODE_SRC" -Wall -Wextra -O2; then

[Severity: Medium]
Does this manual compilation bypass the kselftest build infrastructure?

By avoiding make, variables such as cross-compilation CFLAGS,
KHDR_INCLUDES, and LDFLAGS are discarded. For instance, LDFLAGS +=3D -lpthr=
ead
is explicitly set in the subsystem Makefile but is omitted here. Test
dependencies should rely entirely on the TEST_GEN_PROGS infrastructure.

[ ... ]

> +	if [[ "$UMODE_RET" -ne 0 ]]; then
> +		fail "Userspace API regression: C program failed"

[Severity: Low]
Does this check treat standard test skips as fatal failures?

In the kselftest framework, a test program returns 4 (KSFT_SKIP) when
prerequisites are unmet (such as missing permissions or unsupported
features). Evaluating any non-zero exit code as a failure improperly fails
the overall test suite. Should this explicitly check for exit code 4 and
translate it into a skip?

> +	else
> +		pass "Userspace API regression: $UMODE_PASS passed, $UMODE_FAIL failed=
,"
> +			" $UMODE_SKIP skipped"

[Severity: Medium]
Is there a missing line continuation backslash here?

Because set -e is active at the top of the script, bash parses the second
line (" $UMODE_SKIP skipped") as an independent command, causing a fatal
command not found error. This immediately terminates the test script,
preventing subsequent hardware AUX tests, DAMON checks, and the final
summary from executing.

[ ... ]

> +# ---- Section 6: Memory ordering and concurrency checks ----
> +echo ""
> +echo "--- 6. Memory Ordering & Concurrency ---"
> +
> +if [[ "$HAVE_SRC" -ne 1 ]]; then
> +	skip "Memory ordering checks" "kernel source not available (installed r=
un)"
> +else
> +
> +# Verify smp_rmb() in perf_event_aux_head()
> +if grep -q 'smp_rmb' "$SRC_EVENTS/ring_buffer.c" 2>/dev/null; then
> +	pass "perf_event_aux_head(): smp_rmb() barrier present"

[Severity: Low]
Do these brittle source code grep tests create a maintenance burden?

This tightly couples the selftest to an exact textual representation rather
than verifying behavioral API contracts. Routine kernel refactoring (such as
renaming variables, extracting logic to helpers, or changing barrier
primitives) will falsely fail these tests. Source-level constraints should
be enforced by static analysis tools (like sparse or smatch) rather than
regex matches in the selftest pipeline.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009160010.1829=
642-1-kunwu.chan@gmail.com?part=3D5
