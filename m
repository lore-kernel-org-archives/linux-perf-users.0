Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2484536165E
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 21:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776116669; cv=none; b=Ry742akbM+5cYHujBD1XbGxrw94b67btLxr/9qU6rxzST5oDAmt21EZPJ9QPO1K67ziIbJrpwihHt6ynjWrOXi24aF4CzWuBLWSapR0gEwHCh/KRkLrEAU5qSAUi8/STjjuPXN1ajewloqBC51WiKjxVwpwZN3mQFKfGlGlOXmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776116669; c=relaxed/simple;
	bh=R0HCdIRRPxoffT0I1c1c4F8Ur6cdPqm2MqYhG05qL0g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZmRkXjpR6gdmkKsC9iDJ9F3cSNWaX8tSKW7d5sBV8RCzVpVGK56ZX2nwxLVtMqqRgK6IKOjHYA1CcLEion8ybkbgNSiLMpKq/i0m6vmZR/lbNd2ZCFTEgjmQ2iJI2C5eXp4m9EyPVeUDSzKIzXlyuGLRuSXvrnLo9MLgiKiMfCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCYeeE1l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCYeeE1l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6A0C2BCAF;
	Mon, 13 Apr 2026 21:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776116668;
	bh=R0HCdIRRPxoffT0I1c1c4F8Ur6cdPqm2MqYhG05qL0g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=cCYeeE1lutnVhIyZIAkPqZxKozhvVu5jOCPyUpjUl/v3f3JRNvX0ezwaAIFvyq0dV
	 4NipWIhkTIzvagEquzegT22JaqM3VgWVZxuDJO9ucMYE8rqBjYYvxd6fD7Gep4WS1N
	 aAoXW99OfP15ts5EId4Sbx/OrKCDpgxzzx7XA40ea2tp8BWGdqYi+BXwJG1jL5mLZR
	 u7nZmeb/AQODXuW3nsBa+uJGMckf3TzM92y26YWySyor2yGI9nE8TQE7XD68DFv5Q9
	 XDAafqrtClc7FFW/u99MdJ6IufIBsG2SqQZkQzJwK7LJbtKyH0zO9pRk9OpOSW33A9
	 Q7gZc2S1cPniQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] perf tests: top/kvm don't depend on coreutils
 timeout
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260413213300.1700116-1-irogers@google.com>
References: <20260413213300.1700116-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 21:44:28 +0000
Message-Id: <20260413214428.9D6A0C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [High] Orphaned watcher process can send SIGTERM to unrelated system proc=
esses (PID recycling).
- [Medium] Exit code mismatch in timeout emulation falsely fails tests.
- [Medium] Implicit standard input redirection breaks the protective pipeli=
ne.
- [Medium] Non-POSIX sleep argument causes immediate timeout on strict mini=
mal systems.
--

commit 17f50e3b3f4410cb65917a2951f5c28c36d9bf25
Author: Ian Rogers <irogers@google.com>

perf tests: top/kvm don't depend on coreutils timeout

This commit adds a bash-based fallback for the coreutils timeout command
to prevent failures on minimal test systems. It then updates the kvm and
top test scripts to use this new bash_timeout function.

> diff --git a/tools/perf/tests/shell/kvm.sh b/tools/perf/tests/shell/kvm.sh
> index f88e859025c42..a27b3d6414e9d 100755
> --- a/tools/perf/tests/shell/kvm.sh
> +++ b/tools/perf/tests/shell/kvm.sh
[ ... ]
> @@ -102,7 +105,8 @@ test_kvm_stat_live() {
> =20
>          # Run perf kvm live for 5 seconds, monitoring that PID
>  	# Use sleep to keep stdin open but silent, preventing EOF loop or inter=
active spam
> -	if ! sleep 10 | timeout 5s perf kvm stat live -p "${qemu_pid}" > "${log=
_file}" 2>&1; then
> +	if ! sleep 10 | bash_timeout 5s perf kvm stat live -p "${qemu_pid}" > "=
${log_file}" 2>&1

Does POSIX sleep support the "s" suffix passed as "5s" here?

On minimal systems lacking coreutils, sleep "5s" might fail instantly, caus=
ing
the watcher script to kill the target command in 0 seconds.

> +	then
>  		retval=3D$?
>  		if [ $retval -ne 124 ] && [ $retval -ne 0 ]; then

When bash_timeout kills the process via SIGTERM, it returns 143 (128 + 15),=
 not
the GNU timeout exit code of 124.

Since this code checks for 124, will an expected timeout incorrectly regist=
er
as a test failure?

> diff --git a/tools/perf/tests/shell/lib/timeout.sh b/tools/perf/tests/she=
ll/lib/timeout.sh
> new file mode 100644
> index 0000000000000..b4d2c0acf0e22
> --- /dev/null
> +++ b/tools/perf/tests/shell/lib/timeout.sh
[ ... ]
> +bash_timeout() {
[ ... ]
> +    local timeout_secs=3D"$1"
> +    shift
> +    local command=3D("$@")
> +
> +    # Execute the target command in the background
> +    "${command[@]}" &

Does placing the target command in the background automatically redirect its
standard input from /dev/null?

This appears to sever the connection to the "sleep 10 |" pipe used in the
calling scripts, causing perf to read an immediate EOF and triggering the l=
oop
and interactive spam the pipe was meant to prevent.

> +    local cmd_pid=3D$!
> +
> +    # Start a watcher process in the background
> +    (
> +        sleep "$timeout_secs"
> +        kill -TERM "$cmd_pid" 2>/dev/null || true
> +    ) &

If the test script exits early (for example, due to set -e or an interrupt)
before killing the watcher process, does the watcher survive as an orphaned
background task?

Since perf tests often run as root, this orphaned watcher might wake up lat=
er
and send SIGTERM to a recycled PID, potentially terminating unrelated system
services.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413213300.1700=
116-1-irogers@google.com?part=3D1
