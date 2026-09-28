Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B7430FF36
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 08:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582739; cv=none; b=G25X9FykxiU6R1Ain9jo0K6esx1ntU7ZsB/AVwALx30C/2eoQHjfZEZm9eULhPNi+j+edUFbpoQAfO4iSLVNS4SijbyBOykQZXI56d8bOBjtNMhKYKmmN4IS8BWT+PE8aGxEk2w0HHsoV6WEzR4J1bw0sehW9OE7/U/OsLeFrVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582739; c=relaxed/simple;
	bh=vnu8bfxG8HtHLZsqXPQsszDbD9PNEkQun0mXcljiVfk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CPku4asDJbbpiDmjS2k3kqgAI2pdH52F321Rv4qk0h7LEqKwlNj6lEP0fQSHa95NllKmLOzeLyS4omOxd8howiuyr7sYdoVVXhHp1c/YmJB/p4wBPmp9GXlVEaWTphmsWKQKQjaPIPetZxUHu/3rRmeo6vKUjaUOupMIe2mrvWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORhGfaXQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORhGfaXQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5212D1F000FF;
	Mon, 28 Sep 2026 08:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790582737;
	bh=02XzQe+Uxg2LZDpQj9zVVQ4It2Og+E6zJI8LI/2RCpg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ORhGfaXQpsZyxtCvvipS/QPra7IXzWdenyWGvBliat7MKOPx08EuxJsLYegpbELHf
	 KZLXCivwzyU0XpW++yNKQFZEdMeBGhokdCoc0/lHxGImk4WbZGvDzNrvRj9bkfvco9
	 HMaFHHLlwz9AC8X86nFS/kppwc7LXfw5lNYt8ATv3ppTr52gUBg1vv++7OK0Loo1Ra
	 ri8DU/OhqtbIHniN1XVj4VAWcmh+XJ+fSSlLEtTXVZ4Wisf7jvVqNzXZHEQD7+9Z1S
	 IQnk5YM8o3oyb+z4QxJSh9aLKKbU9aGHs/GcPDOJyEw2QTpm6iLqYofcY+gd4Ku3ai
	 N+yYMspzuRBeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/15] perf/core: Add event_caps dependency flags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928074309.898043-15-dapeng1.mi@linux.intel.com>
References: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
 <20260928074309.898043-15-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 08:05:36 +0000
Message-Id: <20260928080537.5212D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf/core: Userspace-triggerable WARN_ON_ONCE via retained event_c=
aps in promoted group leader
--

commit ee7032954fb61d16c3b9fceb7931ce04cf4b8852
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
   =20
perf/core: Add event_caps dependency flags
   =20
This commit adds two new event capability flags, PERF_EV_CAP_RELIED_ON and
PERF_EV_CAP_RELIANT, to track dependencies between perf events in a group.
When a relied-on event is detached, all reliant events are scheduled out
and transitioned to an ERROR state.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index de05df65ab3d0..55db0ad8b93a0 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2349,13 +2349,12 @@ static void perf_promote_sibling_to_leader(struct=
 perf_event *sibling,
>  					   int group_caps)
>  {
>  	/*
> -	 * Events that have PERF_EV_CAP_SIBLING require being part of
> -	 * a group and cannot exist on their own, schedule them out
> -	 * and move them into the ERROR state. Also see
> -	 * _perf_event_enable(), it will not be able to recover this
> -	 * ERROR state.
> +	 * Events with PERF_EV_CAP_SIBLING or PERF_EV_CAP_RELIANT
> +	 * must stay in a group or depend on another event in the
> +	 * group; otherwise schedule them out and move them to ERROR.
> +	 * _perf_event_enable() cannot recover from this state.
>  	 */
> -	if (sibling->event_caps & PERF_EV_CAP_SIBLING)
> +	if (sibling->event_caps & (PERF_EV_CAP_SIBLING | PERF_EV_CAP_RELIANT))
>  		__event_disable(sibling, ctx, PERF_EVENT_STATE_ERROR);
> =20
>  	sibling->group_leader =3D sibling;
>  	sibling->group_caps =3D group_caps;

[Severity: High]
Does this code need to clear PERF_EV_CAP_RELIED_ON and PERF_EV_CAP_RELIANT
from sibling->event_caps when promoting the sibling to a singleton group
leader?

Since the flags are retained, a newly promoted leader can still carry
PERF_EV_CAP_RELIANT.

> @@ -2371,6 +2370,43 @@ static void perf_promote_sibling_to_leader(struct =
perf_event *sibling,
>  	perf_event__header_size(sibling);
>  }
> =20
> +static void perf_group_disable_reliants(struct perf_event *event)
> +{
> +	struct perf_event *leader =3D event->group_leader;
> +	struct perf_event *sibling, *tmp;
> +	struct perf_event_context *ctx =3D event->ctx;
> +	u32 mask =3D PERF_EV_CAP_RELIED_ON | PERF_EV_CAP_RELIANT;
> +
> +	if (!(event->event_caps & PERF_EV_CAP_RELIED_ON))
> +		return;
> +
> +	/* Group leader should not carry PERF_EV_CAP_RELIED_ON. */
> +	WARN_ON_ONCE(leader->event_caps & PERF_EV_CAP_RELIED_ON);
> +	/* Group leader should not carry PERF_EV_CAP_RELIANT. */
> +	WARN_ON_ONCE(leader->event_caps & PERF_EV_CAP_RELIANT);

[Severity: High]
Can userspace trigger this WARN_ON_ONCE because of the retained caps when
siblings are promoted to leaders?

If a user creates a perf event group with a non-slots leader, a slots
sibling, and a metric sibling, the metric sibling can acquire
PERF_EV_CAP_RELIANT.

When the user closes the leader, the metric sibling is promoted to its
own group leader, retaining PERF_EV_CAP_RELIANT and entering
PERF_EVENT_STATE_ERROR.

If the user then opens a new slots sibling and a new metric sibling under
this promoted leader, and finally closes the new slots sibling, won't
perf_group_disable_reliants() hit this WARN_ON_ONCE because the leader
still holds the reliant flag? On systems with panic_on_warn enabled,
this could cause a kernel panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928074309.8980=
43-1-dapeng1.mi@linux.intel.com?part=3D14
