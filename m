Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89A83431F5
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118035; cv=none; b=lfcvBic8DohQ1chUkkcZB34VqMm0BBlhqr5HeedDF9/N5TWHp0tUx1dl5gwHn1oG3gZW4I7eCNiHIytRfvDpgg6E3hXF3E3WSNUIXQkuGERkf/Q3lc8ir9bqizEKMl2SHUO9jBqP3B2+xC2ODXjGUJvFGSZ0QDYGl8K1vQEgTfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118035; c=relaxed/simple;
	bh=jY+1K7smWmfHBfyNuBUK1FiPaVhQL/rQl36kfDDGbkA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kbYlyU4xIO8Kd5D0nORLvXsrh47316QgRU3SoqvurnZ+w40u17OfpcmxN3bb81KD0nAx+bwto7KzVsKfl4/v00Jn65f6Gh4uD+zeYeE8KDw3myksPMrClR6zPfzQ9/MAiF/kEzWLDSf4cSzVh3D7Q4qdZdvxeJDADDzFfLOGK0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGBbJLLv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGBbJLLv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE9C1F000E9;
	Fri,  7 Aug 2026 15:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786118034;
	bh=1E0lSy6/mmoNEW3QjYUFLnBHnCvDq+nIqY8lqWRSwFc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lGBbJLLv36wot/a9b1jpRrTIHGQo8fyoe8JuXlaPu8FByW5HFysHCu/A0Ze4yCZgh
	 ZaSPCexp9NMoQEyUok2mi6CBxwylkyqN3xwmxaqWPPy+S+35Lkucbqst8i2iH2HrGW
	 u3UQ5Z69kLYC5WU8Cr0q12lndRr/7M9vA0z/g9jJh9VXm69lLwZyUWGEFmjxRO46NB
	 YUbM76VcCqkhIl6SQtyKSf75WU1BeuHMCV8RJOQqz4zQbG1BWsiMIlaxLZtruB8S1+
	 24b5zUxycdGWSMz6idAuhAKR9OMlc5TEPS5m6pHgEZChqZb6cf3y4Bjx1buH7kZi2h
	 ZMgv+TrL9lyPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 09/11] selftests: ftrace: Add wprobe trigger
 testcase
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <178611689884.237811.7547180621874073837.stgit@devnote2>
References: <178611679753.237811.10190793347982785419.stgit@devnote2>
 <178611689884.237811.7547180621874073837.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:53:53 +0000
Message-Id: <20260807155354.3EE9C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Race condition in `trigger-wprobe.tc` causes spurious test failu=
res because `set_wprobe` trigger is not removed before verifying `clear_wpr=
obe`.
- [Medium] `trigger-wprobe-syntax-errors.tc` relies on `do_sys_open` withou=
t verifying its existence, causing the test to fail on kernels where the fu=
nction is unavailable.
--

--- Patch [9]: [PATCH v12 09/11] selftests: ftrace: Add wprobe trigger test=
case ---
commit d811031bfa18879b95fa2051a73496d3fcc8f562
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

selftests: ftrace: Add wprobe trigger testcase

This patch adds a testcase for checking the wprobe trigger. It sets
set_wprobe and clear_wprobe triggers on fprobe events and static trace even=
ts
to monitor memory accesses. It also includes a testcase to verify wprobe
trigger syntax error logging.

Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.=
1785067572.git.wangjinchao600@gmail.com/

> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe=
-syntax-errors.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-w=
probe-syntax-errors.tc
> new file mode 100644
> index 0000000000000..7e02313cf1c73
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-syntax=
-errors.tc
> @@ -0,0 +1,31 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: event trigger - test wprobe trigger syntax errors
> +# requires: dynamic_events error_log "w[:[<group>/][<event>]] [r|w|rw]@<=
addr>[:<len>]":README "f[:[<group>/][<event>]] <func-name>[%return] [<args>=
]":README
> +
> +check_error() { # command-with-error-pos-by-^
> +    ftrace_errlog_check "wprobe_trigger" "$1" "events/fprobes/testevent/=
trigger"
> +}
> +
> +# Add a dummy fprobe event to attach triggers to
> +echo 'f:fprobes/testevent do_sys_open dfd=3D$arg1' > dynamic_events

[Severity: Medium]
Will this script fail unconditionally on kernels where do_sys_open is
unavailable as a valid fprobe target?

On many modern kernels, do_sys_open has been removed, renamed (e.g., to
do_sys_openat2), or heavily inlined, which causes this echo command to
dynamic_events to fail with an error.

Could we check against /proc/kallsyms before using it, similar to how
sample_timer_cb is checked in trigger-wprobe.tc?

[ ... ]
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe=
.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc
> new file mode 100644
> index 0000000000000..4071fe0c878b9
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc
[ ... ]
> +:;: "Set clear_wprobe trigger on foo_bar_with_fn" ;:
> +echo 'clear_wprobe:watch' >> events/sample-trace/foo_bar_with_fn/trigger
> +cat events/sample-trace/foo_bar_with_fn/trigger | grep ^clear_wprobe
> +
> +# Clear trace and wait to ensure no new watchpoint events are generated
> +clear_trace
> +sleep 1
> +
> +:;: "Ensure clear_wprobe trigger deactivated the watchpoint" ;:
> +! grep -q watch trace

[Severity: Medium]
Is there a race condition here that could cause spurious test failures?

Since the set_wprobe trigger on testevent (sample_timer_cb) is still active
and fires concurrently with foo_bar_with_fn, if sample_timer_cb fires after
foo_bar_with_fn during this 1-second window, the wprobe could be re-armed.

Memory accesses would then generate new watch events, causing this assertion
to fail.

Should the set_wprobe trigger be removed before verifying the clear_wprobe
behavior?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178611679753.237811=
.10190793347982785419.stgit@devnote2?part=3D9
