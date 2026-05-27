Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6EF1F130B
	for <linux-perf-users@vger.kernel.org>; Wed, 27 May 2026 01:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779846728; cv=none; b=OthMGZFNYCtiW+pA+ZhPdPGDapQp01Achjc2zAZP1IpiJoPLWl4GK/+dwcPMMcyIbBiA8/dQGHL9UoUh/NNFk3slEd1VwyjiF/LbGduA2K4hHdBaBkOomTAZBfZv1QHjIyzF/gTf4LGpf24ngfQQblfRpTcQ8OpyRXisydv/N/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779846728; c=relaxed/simple;
	bh=pOpifXL2yu3oX7rJ6BX8vEExcqpOUPWWqZ4Ga1nCPPM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bEa0DqQCvhBpGI3iDmWt39wjnJpgKVerCitToVXdWU2s7dfMJ9JFov+0VlkIr8Im8rtz12S6OXleub9inBOGKTp2RQJqS0sDB4WYCCx3gv6gERjfYqQg1QQGrz0ynj5ZI3pL9YDm346wYZJkmewr83CGDLmFGIXlyYaXniuLeX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLK4uyDK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLK4uyDK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0066C1F000E9;
	Wed, 27 May 2026 01:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779846727;
	bh=pa2jztfFFMrU7JViVbp5zAP2FpTpj6zYlyqfJevWBuM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MLK4uyDK5/qYnUdhdhvAMkyMX9hH75IOGmrnqf3CO/tstPhawzswkKFl1sH+jsAn9
	 kyAY4S+aSFHSIthW2Pcuvq489r5vR4Iw9Z2B0+rM5bdMR84ttajlnkEM8tfRYFqQSS
	 AibAOCK0s6mhmc4hs2W87nDhT2LdTxaWYxqEBtdGaObyBJhv/ZfWS967Lu9bRht8Ar
	 IC4Iv1C3xuVvxIUhQzwt2XWYeK/n4yc4F2jobjemi8PBjffV47QbjIjwA3uYhCJYcS
	 C7mGHWxl+ZwttukF091hJZSE0dCZX9fOyCnrwbp+f1Rr3z70vbJ0fcKnWswsIzK7ys
	 jyNWPEzIUqJ5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] perf/core: allow trace events to be accessed from
 any CPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Junxiao Chang" <junxiao.chang@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260528005136.1906479-2-junxiao.chang@intel.com>
References: <20260528005136.1906479-2-junxiao.chang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 01:52:06 +0000
Message-Id: <20260527015207.0066C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Cross-CPU invocation of __perf_event_read() corrupts the targe=
t CPU context's time due to non-monotonic local_clock() drift, causing inte=
ger underflows.
- [High] Setting PERF_PMU_SCOPE_SYS_WIDE incorrectly limits system-wide tra=
cepoint event collection to a single CPU, breaking system-wide monitoring a=
cross the kernel.
- [High] Uncore PMU context migration during CPU hotplug is incorrectly tri=
ggered for tracepoint events, leading to per-CPU semantic violations and do=
uble-counting.
- [Medium] Per-task tracepoint events silently fail to update their time at=
tributes due to an incorrect CPU context check when read cross-CPU.
--

commit 115effb2b7801e60a78fb41cfb479a744b13b4de
Author: Junxiao Chang <junxiao.chang@intel.com>

perf/core: allow trace events to be accessed from any CPU

This commit attempts to reduce SMP IPI overhead when reading trace events by
setting the perf_tracepoint PMU scope to PERF_PMU_SCOPE_SYS_WIDE, allowing
access from any CPU.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index bcaf175f3ded2..da9c41392130e 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11324,6 +11324,7 @@ static struct pmu perf_tracepoint =3D {
>  	.start		=3D perf_swevent_start,
>  	.stop		=3D perf_swevent_stop,
>  	.read		=3D perf_swevent_read,
> +	.scope		=3D PERF_PMU_SCOPE_SYS_WIDE,

[Severity: High]
Will this cause system-wide tracepoint event collection to be limited to a
single CPU?

Setting perf_tracepoint.scope to PERF_PMU_SCOPE_SYS_WIDE causes the PMU
framework to dynamically expose a cpumask sysfs file:

/sys/bus/event_source/devices/tracepoint/cpumask

This returns perf_online_sys_mask, which typically contains only a single
CPU.

Userspace tools like perf record -a parse this sysfs attribute, assume
the PMU is an uncore or system PMU, and only open tracepoint events on the
single CPU specified in the mask.

Does this regression break system-wide software tracing by silently ignoring
tracepoint activity on all other CPUs?

[Severity: High]
Could this trigger incorrect PMU context migration during CPU hotplug?

When a CPU is offlined, perf_event_clear_cpumask() iterates over all PMUs
with a defined scope. For perf_tracepoint, it invokes
perf_pmu_migrate_context() to migrate all tracepoint events from the
offlining CPU to another online CPU.

Since tracepoint events are inherently per-CPU, migrating an event pinned
to CPU A over to CPU B means CPU B will now host multiple identical
tracepoint events.

Will this regression lead to duplicated records and double-counting when the
tracepoint triggers on CPU B?

Also, when CPU A comes back online, its events are not migrated back,
potentially leaving its tracepoint monitoring permanently broken.

[Severity: Critical]
Does bypassing the SMP IPI and calling __perf_event_read() cross-CPU risk
corrupting the target CPU context's time?

If __perf_event_read() executes on the local CPU (CPU B) for an event active
on a remote CPU (CPU A), it calls ctx_time_update_event(), which executes
update_context_time(ctx).

This function calculates "now - ctx->timestamp" using perf_clock(), which
wraps local_clock(). This returns the hardware clock of the current CPU
(CPU B).

Since local_clock() is not strictly synchronized across CPUs, CPU B's clock
can be slightly behind CPU A's last recorded timestamp.

Could this negative delta underflow the unsigned 64-bit integer, yielding a
massive positive value that is added to ctx->time, permanently corrupting
the timekeeping baseline for all events hosted on CPU A's context?

[Severity: Medium]
Will per-task tracepoint events fail to update their time attributes during
cross-CPU reads?

When __perf_event_read() executes on the local CPU (CPU B) instead of the
active CPU (CPU A), it checks if the task is currently active:

if (ctx->task && cpuctx->task_ctx !=3D ctx)
    return;

Because cpuctx is retrieved via this_cpu_ptr(&perf_cpu_context) on CPU B,
its task_ctx reflects CPU B's active task.

Since this naturally mismatches the event's context from CPU A, won't this
regression cause the condition to incorrectly evaluate to true, silently
returning and skipping perf_event_update_time()?

>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528005136.1906=
479-2-junxiao.chang@intel.com?part=3D1
