Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FCA223DE9
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Jun 2026 16:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780850189; cv=none; b=F6/b4VhH19hWc1Fa5DbsdxU0kSJ+uqkwFglIYla5PlmIWII75Bvdc/GA7R6kBHj6bCld5+FmXK84QlB8vyVMFkKwm+2GuHhhEWUFzmKdNxGWZ0mgC77V9BM1EC5VgYT3r9A2yHMomNlvT9xA0XVi0JC7uzPSKz6s0ir+IBK8pbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780850189; c=relaxed/simple;
	bh=scspx2C/3yA5GqclISdXkl110uKQloI5bNZKERYxyBw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oNkOT+rlIULdFVynSbHNMBzxRuyb+MYPgPLtGZHG0eO4QcUttbSLONC5Tjy5B32hrMAyuNziTgBER/056DSgSWBGVqtmiTXTRHswiJr+yvJTo6eSqPrulmVNMjTruZcLLewnE8GQMnZfR3sobjpS42ZS8Li+OLNVXVVRCILNiKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEyzUi7z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEyzUi7z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22CD1F00893;
	Sun,  7 Jun 2026 16:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780850188;
	bh=SeGhIqOQ+63PXbkVuswOUY35m55oIea/wF1u5nQy+XQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YEyzUi7zFCaSsUGses5YqiQVoKRH0iA0u+1BL6mK6eUIylBdZLzZ+IKRPEk53Avvx
	 M5iD8l97m98u2gqHw9dC4xTmSwNjflkqw6WW1CrEZHh/rDq8NMAgsAHqmyEx1CHqiu
	 tJLyqVayPAYXfFn0B1nWMm/0Iajazzm5QMKQh5Q6e61rNvEBzQPGObikgaQqI7U+UF
	 bkwc2UZ6ZmXwrQfOTEp3V8oJUFOhW4CUBM5VtfItLRIaxQVyW1OM3SLY7nlwPxpDYS
	 +ISomo8xTSTJ63H7AKwpkY3zbIB2LZIqoXuEA6M2guIRt/8oJlKMLGAEDeq1Z6Sk1T
	 ga209zZVHYLmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf: avoid lockdep warning in self-monitoring
 perf_event_open
Reply-To: sashiko-reviews@lists.linux.dev
To: l1za0.sec@gmail.com
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260607162622.15534-1-l1za0.sec@gmail.com>
References: <20260607162622.15534-1-l1za0.sec@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 16:36:27 +0000
Message-Id: <20260607163627.F22CD1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Hard deadlock and unsafe `this_cpu_ptr()` usage due to bypass of I=
PI context in `perf_install_in_context()`.
--

commit edfe32c20b9adaadf4bb22117c091b1b0e31a92d
Author: Haocheng Yu <l1za0.sec@gmail.com>

perf: avoid lockdep warning in self-monitoring perf_event_open

This commit attempts to fix a lockdep warning by adding a fast path for
self-monitoring in perf_install_in_context(). It directly calls
__perf_install_in_context() instead of using task_function_call() when the
target task is current.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 7935d5663944e..6e689f2dafbd9 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
[ ... ]
> @@ -3199,6 +3199,10 @@ perf_install_in_context(struct perf_event_context =
*ctx,
>  	 */
>  	smp_mb();
>  again:
> +	if (task =3D=3D current) {
> +		__perf_install_in_context(event);
> +		return;
> +	}

[Severity: High]
Does this direct call to __perf_install_in_context() introduce a regression
by running with preemption and interrupts enabled?

Since perf_install_in_context() only holds ctx->mutex here, preemption and
interrupts are still active. When __perf_install_in_context() is called
directly instead of via IPI, it executes:

kernel/events/core.c:__perf_install_in_context() {
    ...
	struct perf_cpu_context *cpuctx =3D this_cpu_ptr(&perf_cpu_context);
    ...
}

Will this trigger a warning for using this_cpu_ptr() in preemptible context,
and potentially allow the task to migrate and corrupt per-CPU data?

Additionally, __perf_install_in_context() acquires locks without disabling
interrupts:

kernel/events/core.c:__perf_install_in_context() {
    ...
	raw_spin_lock(&cpuctx->ctx.lock);
	if (ctx->task) {
		raw_spin_lock(&ctx->lock);
    ...
}

If a hardware PMU interrupt or a timer tick (like perf_event_task_tick())
fires on the same CPU while these locks are held, could this regression
result in a hard deadlock when the interrupt handler attempts to acquire
them again?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607162622.1553=
4-1-l1za0.sec@gmail.com?part=3D1
