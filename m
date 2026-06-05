Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584941CEAC2
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780662544; cv=none; b=MCSh4YgF4mfmqgTczpBIy8M2JVdJyN9+KYbF3yxn8Qb8jTR/hTKyw+/1J9kToTEwkfVpdiNIxq/W4SnAUomriIqya53hZLpktRR67LlUkxkvWmy8Z4o9kCL7GEooQvyldMlmep3AtqxnJ/B3Xm6FYXG9zg52s402I2PLGjoKoLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780662544; c=relaxed/simple;
	bh=sLGwtSI4vlSUX+gl0N39+Iuq7yjw54USwemKBDljq+0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hgcZ1a9uGVqM3QPyNq8aZHjXy2e2rcHIDEUIeoT9EOFiKuXwvEvjmtlYE8u8xjT30WSV2u2w80AyZbhzk7/j0h9gNu2R+wwzcYWzoUbwY/Q+ZGThFoD+Hu3sXMk6x5hGSaPOqk4f2bcPfCXMrDuMeEUKZQW68YAcTk2FLB/tRC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8kTPbHU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8kTPbHU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32F21F00893;
	Fri,  5 Jun 2026 12:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780662543;
	bh=8kfKNnDWNQWWeVXMEn8V59MxHmJKmQH5eTGuvZPvlgQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j8kTPbHUjWDwBiLCC1capC/SCMzILcuLk5wH573tOZdGmltEHRZDpn598gqkcNjUq
	 WL5gb+tZ0pUdDrSkM1LptCkOO13vqGyeV/Jrso03ZqSYZMVtWqCt+wVlKc2CbPQpQF
	 wnRNCcuJTZMotWjYVeoPSkKVnHvuP5MMJd/n18pZb973k6Y8LAfXcJzCtY/L7E9WAA
	 ys78Pe43XE89u8sQpJZTxyMOA4vp1e0ndUUDNQbkWEoLUOdMQYSCrJFraEQcbZOanQ
	 LWsjd9IQ3qI9EcTH3GL2N/Ip+KZMn/lw6fZpYPwH+EK0uK4Yb2twUgi2KI24D4R/wG
	 w6inVGL39HOTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] perf sched: Fix register_pid() overflow, strcpy,
 and BUG_ON
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605121515.1725549-6-acme@kernel.org>
References: <20260605121515.1725549-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 12:29:02 +0000
Message-Id: <20260605122902.D32F21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Incomplete error rollback in register_pid() leads to state corrupt=
ion, memory leaks, and deadlocks during replay.

Pre-existing issues:
- [High] Unhandled memory allocation failures and reachable BUG_ON() in get=
_new_event() and add_sched_event_wakeup() cause crashes on untrusted input.
--

commit ff8db8ecbe0e2e8aa902db3edce9b5b6e8db02f4
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: perf sched: Fix register_pid() overflow, strcpy, and BUG_ON

This commit aims to fix several issues in register_pid() when processing
untrusted perf.data, including integer/heap overflows and BUG_ON calls on
allocation failures. It caps the PID, uses safe string copying, and handles
reallocation failures gracefully.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 87a1f4cf8760e..21fb820b625b4 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c

[ ... ]

> @@ -469,9 +481,11 @@ static struct task_desc *register_pid(struct perf_sc=
hed *sched,
>  		return task;
> =20
>  	task =3D zalloc(sizeof(*task));
> +	if (task =3D=3D NULL)
> +		return NULL;
>  	task->pid =3D pid;
> -	task->nr =3D sched->nr_tasks;
> -	strcpy(task->comm, comm);
> +	if (comm)
> +		strlcpy(task->comm, comm, sizeof(task->comm));
>  	/*
>  	 * every task starts in sleeping state - this gets ignored
>  	 * if there's no wakeup pointing to this sleep state:
>  	 */
>  	add_sched_event_sleep(sched, task, 0);

[Severity: High]
This is a pre-existing issue, but since the patch aims to prevent crashes on
memory exhaustion when parsing untrusted data, does this still leave a path
to crash?

register_pid() unconditionally calls add_sched_event_sleep(), which calls
get_new_event(). Inside get_new_event(), the result of zalloc() is used
without a NULL check, leading to an immediate dereference:

get_new_event()
{
        ...
        struct sched_atom *event =3D zalloc(sizeof(*event));
        ...
        event->timestamp =3D timestamp;
        ...
        BUG_ON(!task->atoms);
}

There is also a remaining BUG_ON() upon realloc() failure.

Similarly, add_sched_event_wakeup() allocates wait_sem and passes it
unchecked to sem_init(), causing another crash if zalloc() fails:

add_sched_event_wakeup()
{
        ...
        wakee_event->wait_sem =3D zalloc(sizeof(*wakee_event->wait_sem));
        sem_init(wakee_event->wait_sem, 0, 0);
}

> =20
>  	sched->pid_to_task[pid] =3D task;
> -	sched->nr_tasks++;
> -	sched->tasks =3D realloc(sched->tasks, sched->nr_tasks * sizeof(struct =
task_desc *));
> -	BUG_ON(!sched->tasks);
> -	sched->tasks[task->nr] =3D task;
> +	tasks_p =3D realloc(sched->tasks, (sched->nr_tasks + 1) * sizeof(struct=
 task_desc *));
> +	if (!tasks_p)
> +		return NULL;

[Severity: High]
If realloc() fails here, does this leak the newly allocated task and leave
a corrupted state?

The task has already been assigned to sched->pid_to_task[pid] above. If we
return NULL, the caller gets an error, but the partially initialized task
remains in the pid_to_task array and is never added to sched->tasks.

If a caller like replay_fork_event() ignores the NULL return value:

replay_fork_event()
{
        ...
        register_pid(sched, thread__tid(parent), thread__comm_str(parent));
        register_pid(sched, thread__tid(child), thread__comm_str(child));
}

Subsequent events for the same PID will find the partially initialized task
in pid_to_task and successfully add events to it. Because the task is not in
sched->tasks, perf sched replay will fail to spawn a thread for it in
create_tasks(). When other simulated threads expect to be awoken by this
missing thread, they might wait indefinitely on a semaphore, deadlocking the
tool.

> +	sched->tasks =3D tasks_p;
> +	sched->tasks[sched->nr_tasks] =3D task;
> +	task->nr =3D sched->nr_tasks++;
> =20
>  	if (verbose > 0)
>  		printf("registered task #%ld, PID %ld (%s)\n", sched->nr_tasks, pid, c=
omm);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605121515.1725=
549-1-acme@kernel.org?part=3D5
