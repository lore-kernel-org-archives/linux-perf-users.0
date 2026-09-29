Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CB33D47AB
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 18:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707601; cv=none; b=unXcFTT8hyHbnd+tTm/b8O7Ap2CQBI4F8N2Qe27f2X1V9inqnxXy+cBwS9jeUSDVyaWu8CxeDJTeua/3c8eT8H4l0ifq6qxEvS+z11pyFYGSWXojhQQZucGbBgjM1Bwp8H3I1PmaHQzOkj4P75LqpXY9KZszAKC8A5wzNbcthEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707601; c=relaxed/simple;
	bh=fT3dsXu+UR2/r1Sgo5jEU/OoH4F10hTX5rsuwzs/MO4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WElceiVXtJYnMqdOfOoVURokNQnqEh5eH/XCyQdAAWO+UceC6fP+2CxikKwKft6o6BHtaPG3iMfud5hPoMZK+ZMOdy4gr0mKC80Oa7ZX3kd73+qPliRE0yMFLOeMJSDFs9j/DR8jGBuZcuOIG4vvCgsNqTdoEKMsyz185yKds8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMdzDeou; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMdzDeou"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F4E1F000FF;
	Tue, 29 Sep 2026 18:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790707599;
	bh=SX2rZpueXTZOAg3WcIidnq015JX1qp50RHXPeoDlLYw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mMdzDeouG/aZl0goUzax7aIKR7fDTARuUzJksFFM5lBrRRSiTBSGaXb1fLT3ewZWD
	 HfsMIJTgi8mI1JvtHgumBBcaLDmTNyewE7PGS/wp3t0w4VeI1hNIFGgslDg+QIheE2
	 ngxm6zqGgDZuqzeLIHWdYq4t754xNd7TKrBMPsURIf6oSj0COlui0bM/s3wVi9WL5X
	 xbpHP84QTxKwznCZVjtzQ49vsxY7Fn6VmanXOhmzUrhpnCguBtz3CizXAf0DZYLItr
	 SKp+YYIdX5eUCb1fN6NzKb+OHUQQaBIyMwi6Wt6gV1TS78cMfRhTya81JjJ+fCGHH2
	 owhsqq7yE5Wpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/core: Don't send SIGTRAP after exec removed the
 event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danish Khateeb" <danishkhateeb03@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929182935.355892-1-danishkhateeb03@gmail.com>
References: <20260929182935.355892-1-danishkhateeb03@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 18:46:38 +0000
Message-Id: <20260929184639.53F4E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf: strict event->state check allows fatal SIGTRAP on execve wit=
h O_CLOEXEC
--

commit 7195999db39d67f15f48d557a068f0dc7588f8ab
Author: Danish Khateeb <danishkhateeb03@gmail.com>

perf/core: Don't send SIGTRAP after exec removed the event

This commit prevents a SIGTRAP from reaching a newly executed program if an
event with remove_on_exec overflows right before execve(). It adds a check =
for
the PERF_EVENT_STATE_EXIT state in perf_sigtrap() to drop the signal if the
event was removed during exec.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 634d2ccbab82d..948583ffeb535 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7631,6 +7631,14 @@ static void perf_sigtrap(struct perf_event *event)
>  	if (current->flags & PF_EXITING)
>  		return;
> =20
> +	/*
> +	 * exec() removed the event (remove_on_exec) after this signal was
> +	 * queued. The new program has default signal handlers, so a SIGTRAP
> +	 * would kill it.
> +	 */
> +	if (event->state =3D=3D PERF_EVENT_STATE_EXIT)

[Severity: High]
Does this strict equality check account for the PERF_EVENT_STATE_DEAD state
caused by O_CLOEXEC processing?

If a perf event is configured with remove_on_exec=3D1, sigtrap=3D1, and the=
 file
descriptor is opened with O_CLOEXEC, an event overflow queues
perf_pending_task() via task_work_add().

When the task begins execve(), do_close_on_exec() closes the O_CLOEXEC file
descriptor. fput() then queues ____fput via task_work_add(). Because the
task_works list executes in LIFO order (works are prepended to the head),
____fput is positioned to run before perf_pending_task().

After perf_event_exec() removes the event and sets=20
event->state =3D PERF_EVENT_STATE_EXIT, execve() completes and task_work_ru=
n()
begins processing:

____fput()
   perf_release()
      perf_event_release_kernel()
         event->state =3D PERF_EVENT_STATE_DEAD;

When perf_pending_task() subsequently runs and calls perf_sigtrap(), the
event state is PERF_EVENT_STATE_DEAD (-5). Since -5 !=3D PERF_EVENT_STATE_E=
XIT
(-3), the strict equality check bypasses the filter, erroneously sending
SIGTRAP and killing the new program.

Should this check for detached states via=20
if (event->state <=3D PERF_EVENT_STATE_EXIT) instead?

> +		return;
> +
>  	/*
>  	 * We'd expect this to only occur if the irq_work is delayed and either
>  	 * ctx->task or current has changed in the meantime. This can be the

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929182935.3558=
92-1-danishkhateeb03@gmail.com?part=3D1
