Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349503806DB
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780482622; cv=none; b=b/5nn2nxM1nbmYnpJQ25lzXPF5bIdleewV2FzIRbjbHodzcx/NShhCjh/vSzsAE5OC6fm5SOt+SCP0phA0uVJUXtCLs8puZJ6Hb0u+/VhiudnMJVxuEBY0nW6lF7IWECH4cTQhW7T4eNlofMPXPTL69Y3aHkGKnz47tMQRlBOwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780482622; c=relaxed/simple;
	bh=mCf5ZDixv2R4Q2BCUKpU66xzkB5KSbcGy7eBvBYDqeA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IDyWvr+3GN2YyIm5DIyC+6UOl6sNM/FE0WaAUrZe6p62K/znVUHHFfZ12YFDPDXQkIhecb2I7gugkFd8b/DGmyjLYnwLxxVirEduPuvNlvzFBPhC+EJnMmre08g3wbbSu5x56p6lalQjaoPeWSS6oWWO8B31Sz7H1gi1wTWdxjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fkp0biOr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fkp0biOr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B731F00893;
	Wed,  3 Jun 2026 10:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780482620;
	bh=P/ylKxaQRlNRjym2xQgow2FrrTZNKMtPxyj/8C5rflI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fkp0biOrnHE3nWQZ0vpIF5+vVQebhPc3NkY9NSQ72nOLra6OOT9bGA8Mocq/lMQUY
	 Zv28DW3fv1Bk12F1aTDtmPR5icYWpDNFr7pvNOuAf8lCHj/uG7O5M6mLe6IBFq3Cjc
	 +gQh9zeIomN5IgM6p9xFs3eDaLMg4JtvIh9/zdAuIgwLWtOZFkcGxpVfutcQiTayVv
	 +IMwBdqi9AFg5bYWXaSCZl4kIo0SIGJoqpic5zhUb2NtMZCoKbtGZ/XmD8n70G0Sze
	 7A/IL7O5xLvOL1dJhtY87yZgtWtuhKiL9DSURnQpoY9MW2cqbjRw4DFnrWZIPMl1iu
	 mUM/YK+tMR++Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/19] perf test cs-etm: Replace unroll loop thread
 with deterministic decode test
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260603-james-cs-context-tracking-fix-v3-6-c392945d9ed5@linaro.org>
References: <20260603-james-cs-context-tracking-fix-v3-6-c392945d9ed5@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 10:30:20 +0000
Message-Id: <20260603103020.A5B731F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Signed integer overflow in `deterministic` workload causes Undef=
ined Behavior.
--

commit 4589a67d2fd8e0ec516cb0f0c6ed8dd3e2079b76
Author: James Clark <james.clark@linaro.org>

perf test cs-etm: Replace unroll loop thread with deterministic decode test

This commit replaces the unroll loop thread test with a new deterministic
decode test. It introduces a shell script that records and validates the
deterministic workload to ensure decoding always yields the same result for
a given code sequence.

> diff --git a/tools/perf/tests/shell/coresight/deterministic.sh b/tools/pe=
rf/tests/shell/coresight/deterministic.sh
> new file mode 100755
> index 0000000000000..52e033fd6b82a
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight/deterministic.sh
> @@ -0,0 +1,71 @@
> +#!/bin/bash -e

[ ... ]

> +cf=3D"$tmpdir/ctl"
> +af=3D"$tmpdir/ack"
> +mkfifo "$cf" "$af"
> +
> +# Start disabled and use the control FIFO to only record the workload an=
d not
> +# startup.
> +perf record -o "$tmpdir/data" -e cs_etm//u -D -1 --control fifo:"$cf","$=
af" -- \
> +	perf test --workload-ctl fifo:"$cf","$af" -w deterministic > /dev/null =
2>&1

[Severity: Medium]
Does executing the deterministic workload here cause a regression by
triggering undefined behavior?

Looking at the workload in tools/perf/tests/workloads/deterministic.c,
dt_work is initialized to 1234 and then multiplied by 7 twelve times
across deterministic(), function1(), and function2():

tools/perf/tests/workloads/deterministic.c:deterministic() {
	dt_work *=3D 7;
	dt_work *=3D 7;
	dt_work *=3D 7;

	function1();

	dt_work *=3D 7;
	dt_work *=3D 7;
...

On the 8th execution (the second multiplication after returning from
function1() to deterministic()), the value reaches 7,113,764,434, which
exceeds the maximum value for a 32-bit signed integer.

This causes a signed integer overflow regression. When the perf tool is
compiled with the undefined behavior sanitizer enabled, this workload will
trap or crash, breaking the test's strict deterministic execution behavior
and resulting in test failures.

Could dt_work be modified to an unsigned int to avoid this overflow?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603-james-cs-c=
ontext-tracking-fix-v3-0-c392945d9ed5@linaro.org?part=3D6
