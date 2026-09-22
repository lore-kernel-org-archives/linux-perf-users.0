Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5C838910F;
	Tue, 22 Sep 2026 04:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790052115; cv=none; b=J1tc+gYJxbisSvTTQaGhaF9qdl3SmdQRTDQXPG4SD/ZFACQNpJ1AYu6DaU9CZ3NRkvnP6DQUSTd3XyXzZT3ldU6x6xFcTMnebAaR9Yuu85UkrWNJMgo/zzvsa7Ir1dfW42VF3IR2lquz6qUz11b7jQQxGJCSowJ66oHyLDIYdY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790052115; c=relaxed/simple;
	bh=CDsPjk2P490NloENJm1wSWK3k7823S7c/j5roKnAepk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l4G1C7SAeqiNg9pf6b7mvTtTmmFnXy3tviPyfZtnJHyFordJ2YtRQQ6iS8YmZeDNU8x2+9d4JCyMVHT54/Trfo2lgYmT3TYO3wWY0YKrJCtDGjuvAl/ahaqnbtXEm2LdOaPgzJMU+N8bdRplYrpdYCh2eApgJOOs6SfC9afZbbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPyD+UPC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPyD+UPC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE881F00893;
	Tue, 22 Sep 2026 04:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790052113;
	bh=DSIhTUcGRdLQI8wsh4IZOtSQ6HUTqL7xNi748BfddNA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZPyD+UPCiPwPPQuukVWulhTRK9HyjRpnKSmp459kvbwSAlcEMm8yzc1zqlr0sZRJR
	 POM+GYVl1j0bKFo2n599/+E7JUEyY5nf00QjJrfdrJcSovOhdm0oRGISMMU8e4xYrd
	 2uqA7iBjPaBxV9td9XYffAOzX+f1sCsPPZAEZmyrqzZSDquudxrxnzgnp2bsHf4sNZ
	 hqdgL2UZFAYL33chSp0YZe+jyLhd2DV3Uy6NOtNNeXZUK6sbkyPGgmrd70sarn+lm9
	 MhOpZYr95oTnPrR8mG39Vt86UGLU5SuyoQ3e5eqYhpw8y5OT9yjTBxeLwyB0MDYva1
	 U39GA/PJ761jQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 11/13] selftests: tracing: Add wprobe trigger
 testcases
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <179005121474.388919.14749093387340836147.stgit@devnote2>
References: <179005108298.388919.4535333252892590932.stgit@devnote2>
 <179005121474.388919.14749093387340836147.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 04:41:53 +0000
Message-Id: <20260922044153.ADE881F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] kselftest: trace buffer not cleared before verifying offline wprobe=
 triggers
- [Low] kselftest: missing set_wprobe dependency check in requires lines
--

commit 0d531760cdf15ae449a5bc0545ea39a43134b990
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

selftests: tracing: Add wprobe trigger testcases

This commit adds several test scripts for wprobe triggers in the ftrace
selftests. The test scripts verify setting and clearing wprobe triggers,
CPU hotplug behavior for wprobes, and syntax error logging.

Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.=
1785067572.git.wangjinchao600@gmail.com/

> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe=
-hotplug.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-=
hotplug.tc
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-hotplu=
g.tc
> @@ -0,0 +1,150 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: event trigger - test wprobe trigger across cpu hotplug
> +# requires: dynamic_events "w[:[<group>/][<event>]] [r|w|rw]@<addr>[:<le=
n>]":README "f[:[<group>/][<event>]] <func-name>[%return] [<args>]":README =
events/sched/sched_process_fork/trigger "[(structname[,field])]<argname>[->=
field[->field|.field...]]":README

[Severity: Low]
Should we check for set_wprobe in the README in this requires line? If a ke=
rnel
has CONFIG_WPROBE_EVENTS=3Dy but CONFIG_WPROBE_TRIGGERS=3Dn, it seems this =
test
will execute and fail unexpectedly with "Failed to set set_wprobe trigger"
instead of being gracefully skipped as UNRESOLVED.

[ ... ]

> +:;: "Take target CPU offline" ;:
> +echo 0 > $cpu/online
> +sleep 1
> +
> +# Wait for sample_timer_cb to fire and set_wprobe trigger to activate wh=
ile CPU is offline
> +sleep 2
> +
> +:;: "Check set_wprobe trigger activated the watchpoint" ;:
> +if ! grep -q watch trace; then
> +  fail "Failed to trigger watchpoint while CPU is offline"
> +fi

[Severity: Low]
Does this grep falsely match events generated while the CPU was still onlin=
e?
Because the target fprobe (sample_timer_cb) fires continuously, the trace
buffer could log a watch event before the offlining process actually comple=
tes.
Should we add a clear_trace call either before or right after taking the CPU
offline?

[ ... ]

> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe=
-syntax-errors.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-w=
probe-syntax-errors.tc
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-syntax=
-errors.tc
> @@ -0,0 +1,37 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: event trigger - test wprobe trigger syntax errors
> +# requires: dynamic_events error_log "w[:[<group>/][<event>]] [r|w|rw]@<=
addr>[:<len>]":README "f[:[<group>/][<event>]] <func-name>[%return] [<args>=
]":README events/sched/sched_process_fork/trigger

[Severity: Low]
Similar to the hotplug script, does this requires line need a set_wprobe RE=
ADME
check to prevent false test failures on kernels that lack wprobe trigger
support?

[ ... ]

> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe=
.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc
> @@ -0,0 +1,107 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: event trigger - test wprobe trigger
> +# requires: dynamic_events "w[:[<group>/][<event>]] [r|w|rw]@<addr>[:<le=
n>]":README "f[:[<group>/][<event>]] <func-name>[%return] [<args>]":README =
events/sched/sched_process_fork/trigger "[(structname[,field])]<argname>[->=
field[->field|.field...]]":README

[Severity: Low]
Does this requires line also need the set_wprobe dependency check to ensure=
 the
feature is fully supported before execution?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179005108298.388919=
.4535333252892590932.stgit@devnote2?part=3D11
