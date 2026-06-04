Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B5530C17A
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 19:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780600699; cv=none; b=T5HC8l559TuacXfkwJ8rC7/3YkiX9+mqBFC9LEjetoE+VQbTWsVg8iSrH6rGjqlQMYzNkE85rj7v7xms25qpPyba1tUl866C5ZzTHomaYvNM+TL3XKSqGQG7j2eCkIix4am9lyvFdff+U2Fl0537YA49XmVapqUGcfLBtN2QbCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780600699; c=relaxed/simple;
	bh=pZzLNJMTt0W+Z5M3PH26hfnqHD7oNPqgB/vIzL+IpVk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j/j7S4OZsG8dueJZBtGG6B3N4bfAbQY+IlQeKSri/SbELZYkT7JJkpq/BGhFF0ikgM9yUfpRPQiAUAfiVdKDkjn1tTBKu6ue/n6PK0+8T6Im/MoVWBifeToFmmuMC99XUDxe/e4dVR1d0ZvuyuLuEkQkEatmScd3POjoN3FoWfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAJ1rfyV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAJ1rfyV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352171F00893;
	Thu,  4 Jun 2026 19:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780600698;
	bh=Zxyz1y6/XGnIG59vFC4jLdV7jQLBjbb+MEtOzTn6vTw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EAJ1rfyV6mWoB8fL/sxRElMlXggFymd9soUCpVGT/ENYv5uzSgiMAtJcax3dBSEXy
	 WVW355xTJ45VcNrRiPkX2lCBNY+w645uu+M5ZZyxZ8tQYkWI5X0vR0TjH3OwF3IF+r
	 CIvSwIZZIXHeW91k8IgZUDNtmyiHcyhxyOEFJSKMRHZeKPa/sDeOQ0Fx8AH081AnqF
	 gj+XEddflVp5Rev2dF64AY0Anu2o8IPlrpS1SBf0OMDWsGa7tUvxiYx4U5hvgiC08s
	 +dDBTep4whQlz7jdlpgGYHABkZ4+lcS8YQObpC9wVJ6Jq7R93x2Zf5UX05W3qvlbMG
	 LUtHkz3GFUmEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] perf timechart: Remove unnecessary copy of
 backtrace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260604190812.2168118-5-namhyung@kernel.org>
References: <20260604190812.2168118-5-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 19:18:17 +0000
Message-Id: <20260604191818.352171F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Removing `free(backtrace)` causes severe memory leaks when the b=
acktrace string is not consumed by the sample tracking logic.
--

commit 8d24fd58d3a0d2702142c45fce31ca640b59f748
Author: Namhyung Kim <namhyung@kernel.org>

perf timechart: Remove unnecessary copy of backtrace

This commit updates timechart to use the backtrace string directly instead
of duplicating it with strdup(). It updates pid_put_sample() and
sched_wakeup() to store the original pointer and removes the free()
calls in the process_sample routines.

> diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechar=
t.c
> index 4efac73a714c5..2fd24d3aaa837 100644
> --- a/tools/perf/builtin-timechart.c
> +++ b/tools/perf/builtin-timechart.c

[ ... ]

> @@ -434,7 +434,7 @@ static void sched_wakeup(struct timechart *tchart, in=
t cpu, u64 timestamp,
> =20
>  	we->time =3D timestamp;
>  	we->waker =3D waker;
> -	we->backtrace =3D backtrace ? strdup(backtrace) : NULL;
> +	we->backtrace =3D backtrace;

[Severity: Medium]
Does this leak the dynamically allocated backtrace string from
cat_backtrace() if the wake_event allocation fails?

tools/perf/builtin-timechart.c:sched_wakeup() {
	struct wake_event *we =3D zalloc(sizeof(*we));

	if (!we)
		return;
    ...
}

Because the unconditional free() was removed from
process_sample_sched_wakeup(), the backtrace pointer is dropped and
leaked if zalloc() fails.

> =20
>  	if ((flags & TRACE_FLAG_HARDIRQ) || (flags & TRACE_FLAG_SOFTIRQ))
>  		we->waker =3D -1;

[ ... ]

> @@ -678,7 +677,6 @@ process_sample_sched_switch(struct timechart *tchart,
>  	backtrace =3D cat_backtrace(sample, &tchart->session->machines.host);
>  	sched_switch(tchart, sample->cpu, sample->time, prev_pid, next_pid,
>  		     prev_state, backtrace);
> -	free((char *)backtrace);

[Severity: Medium]
Will this leak the backtrace string if sched_switch() does not consume it?

tools/perf/builtin-timechart.c:sched_switch() {
	if (prev_p->current && prev_p->current->state !=3D TYPE_NONE)
		pid_put_sample(tchart, prev_pid, TYPE_RUNNING, cpu,
			       prev_p->current->state_since, timestamp,
			       backtrace);

	if (p && p->current) {
		if (p->current->state !=3D TYPE_NONE)
			pid_put_sample(tchart, next_pid, p->current->state, cpu,
				       p->current->state_since, timestamp,
				       backtrace);
	}
    ...
}

If both TYPE_NONE conditions evaluate to true, pid_put_sample() is not
called. The backtrace string goes unreferenced and is permanently lost
now that the unconditional free() has been removed.

>  	return 0;
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604190812.2168=
118-1-namhyung@kernel.org?part=3D4
