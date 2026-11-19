Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082634;
	b=JL9KZHhkmG1CyxbadHSYS5DXwKlz22peJ4IO4Ds3RrFbILKz81fnUqPQiVjzhM6CSlpg
	 mMvnCdN3xeznbQ2RWSmTNvBT0jCJL55JwhmcnqpMS20kX9ktKgmJ+XoAlMwuq8cLqAc5A
	 jkcoEubZ1ZCTkAP9E2p6YP0GyVpyyqRFnTqpD5qCv8FIn7JE/hYLUoftNrF13SBPArqwU
	 wvFVEcB1yKNp/HaGbVT8SbJbmSmYpOV5uYGnIAkaj3yoNdttdm1XX7j5VJCQPg94Q3CJ4
	 izbzSyXVzSABzs2SOVGDYhBn8OoQkxJZKm4or/hUDFAAgzOxuKd+V+VQRAjnHjRFoEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082634;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=X/dmOT4zwkRbuBf3ax8KoOD3ZjGSqz7a7crNo1/Ow+Y=;
	b=TDf+vsxwvXUne7Uk1XA0fHimBkoTI/rSi2uEtGhOMOovyrL7wgDifOrTiBzqVjyuYhAg
	 SYT5vn66zaoWHDgMVKXnEh0qHYClZqmcMktSg28mF4vldoxz2Ev2gWOhA6+0CeILZS6+o
	 A0z+EiN+vFzeb6I8XRUGyXrkTcQFJVeaq2FrXK47CyCEqANI8/BAmekN8Uv7nP7W8Nl8S
	 EFkB3QggEJ5rmnb8m5d6zFStPN6KSwItS4tEWdOGsrYQDoAYE2nZul9k/sGrEls5Nt9TI
	 +nGLCR/T4xzmcfcrUhz/Wfz/RZEgio18wS7wA+/XUGi4djl2uwbDI0ab3VVQCFArw1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DJXiA9Zl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18330606A320
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 10:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DJXiA9Zl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1641F000C5;
	Thu, 19 Nov 2026 10:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795082633;
	bh=X/dmOT4zwkRbuBf3ax8KoOD3ZjGSqz7a7crNo1/Ow+Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DJXiA9ZlU/2dXyEFpGpAuyuFy5yukiyrs16ETkXdrpz5ZVB74sqPjI4jWEvO8UR4G
	 tKytBcvZUOi5VIxu3aqpOIwIwXJZsnDrcSD75QGbKF1Ge0Icv8xLOjOz8q4Ca8+y3l
	 a8qVnkfOv38CnM6TaIIFE2aGyGgK5s4HC5g4+0gz+/Wvtvf0xbmfjI6gHpr8E4vLTo
	 45mVgXCFf99jVbpeC/skBPNQOEE6yK6uSJtvP9cC8BKEf29YMmYSThp5YB6kyIp8P+
	 fW7u7uMDu6P0y9QWIwEvA1K4wwCLpEXB/JP0M9cV8HAIkSCZGUusIqJMC1iyp5F89P
	 gEGnCQkUAFN+Q==
Message-ID: <sashiko-outbox-222905@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] perf/core: Disable context fast-swap for sigtrap
 events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <55b1a2845b0ad34a874a7653644e34af9eb068d3.1795053619.git.wutengda@huaweicloud.com>
References: <cover.1795053619.git.wutengda@huaweicloud.com>
 <55b1a2845b0ad34a874a7653644e34af9eb068d3.1795053619.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 10:03:53 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] perf/core: non-SMP-atomic local_t race on
  ctx->nr_no_switch_fast
--

commit 5e829db733e2fe49cdac7cb99bb9428db1c83359
Author: Tengda Wu <wutengda@huaweicloud.com>

perf/core: Disable context fast-swap for sigtrap events

This commit excludes sigtrap events from the context fast-swap path by
incrementing and decrementing ctx->nr_no_switch_fast when adding and
removing events with attr.sigtrap set.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index da86bc6e8be94..483ba8704d418 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1999,7 +1999,7 @@ list_add_event(struct perf_event *event, struct per=
f_event_context *ctx)
>  		ctx->nr_user++;
>  	if (event->attr.inherit_stat)
>  		ctx->nr_stat++;
> -	if (has_inherit_and_sample_read(&event->attr))
> +	if (has_inherit_and_sample_read(&event->attr) || event->attr.sigtrap)
>  		local_inc(&ctx->nr_no_switch_fast);
> =20
>  	if (event->state > PERF_EVENT_STATE_OFF)
> @@ -2225,7 +2225,7 @@ list_del_event(struct perf_event *event, struct per=
f_event_context *ctx)
>  		ctx->nr_user--;
>  	if (event->attr.inherit_stat)
>  		ctx->nr_stat--;
> -	if (has_inherit_and_sample_read(&event->attr))
> +	if (has_inherit_and_sample_read(&event->attr) || event->attr.sigtrap)
>  		local_dec(&ctx->nr_no_switch_fast);

[Severity: Medium]
Can concurrent local_inc() and local_dec() calls on ctx->nr_no_switch_fast
from different CPUs race and lose updates?

ctx->nr_no_switch_fast is a local_t, so local_inc() and local_dec() are
only atomic on a single CPU (for example, unlocked inc/dec on x86).  When
installing a disabled sigtrap event into a non-empty task context,
perf_install_in_context() runs add_event_to_ctx() directly on the
installer CPU under ctx->lock without an IPI, while an already-active
sigtrap event in that context can update ctx->nr_no_switch_fast on the
target task's CPU without holding ctx->lock:

CPU0                              CPU1 (running ctx->task)
perf_install_in_context()
  raw_spin_lock(&ctx->lock)
  add_event_to_ctx()
    list_add_event()
      local_inc(&ctx->nr_no_switch_fast)
                                  __perf_event_overflow()
                                    local_inc(&ctx->nr_no_switch_fast)
                                      <-- non-SMP-atomic RMW race
                                  ...
                                  perf_pending_task()
                                    local_dec(&ctx->nr_no_switch_fast)

A similar cross-CPU race is possible between list_del_event() in
perf_remove_from_context() (when !ctx->is_active) and perf_pending_task().
A lost increment allows ctx->nr_no_switch_fast to drop to 0 while a
sigtrap event or pending task_work is still present, re-enabling the
context fast-swap path and hitting WARN_ON_ONCE(event->ctx->task !=3D
current) in perf_sigtrap().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795053619.gi=
t.wutengda@huaweicloud.com?part=3D2
