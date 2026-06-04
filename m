Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086943A2544
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 20:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780605013; cv=none; b=l3gF9AEGw8Aw5k5TNfJ5nBfHlE0gWUYpfWCV3it46jAI6VaWz6QD1n4G1TS3Zv5ruapKlITAQsBrumgFm2sVFVViWxJKnONRHRgonBDJcgUKehpRZyYIROfA8vEI/d5NIwXPXZEl00k7dvoWfOlAnnMslHyVp2hAgSEDt0Jawjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780605013; c=relaxed/simple;
	bh=nXil9YGFrXgViBEXlhUEbXekYhd+7BpKVLVyJKxLQWs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MmMQ30nlceKi3BKZ2Ym4EIffEcToMs0uecXfiYlKP09IsV84UwuP/SOpmamKKVwDwHBiz41Ow/KiqyQC3hqPL6jVqR4R1th6WxFKDbFTG30YfD2DAkXRB5uSDo1Wv2t2H0c6ijZ368ubkdFtNl1VyQfoTnmBbyxgtc5n89HGqe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmbyjjHu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmbyjjHu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430A01F00893;
	Thu,  4 Jun 2026 20:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780605011;
	bh=JiSUmqGyRYaO+kex4qVhrvZPN8x+hYcxbvlpVEMnOrc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WmbyjjHuLZxeyQa0r6n+Z267F5T8xMiQVQMuw0snB8BTzgoiinNXJoA5EJbHDhMu6
	 A8cA2VkC8HJxaddPnTo4HcUVPznyfOsL6+tIpPp9uEVx2L+bej69oUnPlRVvCULRgI
	 DdyBc9wJm8klP9n/CaEqeUE9Z5rXQI6N7LEbdbh2vDzyWitVumSv//o4SxM+MtIg/6
	 knWgQ5QgwVfhbCyNbnG4mcvSMUH2CjC2IBtw8dQCNmgfR+27+BnAH507GHFZ/liaTI
	 rcoirnP5FxDSG4YBhCLqZoYA+0Ke33BHXXeigbel4lf51FUnYnifL6roOLOzxhQ5CH
	 WjNH8aSXatDhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] perf sched: Fix NULL dereference in
 latency_runtime_event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260604201119.1702338-4-acme@kernel.org>
References: <20260604201119.1702338-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 20:30:10 +0000
Message-Id: <20260604203011.430A01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Using strcpy() to copy untrusted string payloads into a fixed-=
size buffer leads to a heap buffer overflow.
- [Critical] Unbounded attacker-controlled PID values are used to calculate=
 memory allocation sizes, leading to integer overflows and OOB writes.
--

commit ab6f421859203bf939f45ab57b4ced38c5193ef5
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf sched: Fix NULL dereference in latency_runtime_event

This commit fixes a NULL pointer dereference in latency_runtime_event().
It moves the assignment to atoms using thread_atoms_search() after the=20
thread NULL check to match patterns used elsewhere in the file.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 13b801496a012..36da451447b5e 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -1213,13 +1213,15 @@ static int latency_runtime_event(struct perf_sche=
d *sched,
>  	const u32 pid	   =3D perf_sample__intval(sample, "pid");
>  	const u64 runtime  =3D perf_sample__intval(sample, "runtime");
>  	struct thread *thread =3D machine__findnew_thread(machine, -1, pid);
> -	struct work_atoms *atoms =3D thread_atoms_search(&sched->atom_root, thr=
ead, &sched->cmp_pid);
> +	struct work_atoms *atoms;
>  	u64 timestamp =3D sample->time;
>  	int cpu =3D sample->cpu, err =3D -1;
> =20
>  	if (thread =3D=3D NULL)
>  		return -1;
> =20
> +	atoms =3D thread_atoms_search(&sched->atom_root, thread, &sched->cmp_pi=
d);
> +
>  	/* perf.data is untrusted input =E2=80=94 CPU may be absent or corrupte=
d */
>  	if (cpu >=3D MAX_CPUS || cpu < 0) {
>  		pr_warning("WARNING: at offset %#" PRIx64 ": out-of-bound sample CPU %=
d, skipping sample\n",

[ ... ]

While reviewing this file, I noticed a couple of pre-existing issues in
register_pid():

tools/perf/builtin-sched.c:register_pid() {
...
	if (pid >=3D (unsigned long)pid_max) {
		BUG_ON((sched->pid_to_task =3D realloc(sched->pid_to_task, (pid + 1) *
			sizeof(struct task_desc *))) =3D=3D NULL);
		while (pid >=3D (unsigned long)pid_max)
			sched->pid_to_task[pid_max++] =3D NULL;
	}
...

[Severity: Critical]
This isn't a bug introduced by this patch, but could an attacker-controlled
pid from an untrusted perf.data file overflow the size calculation here?

If pid is set to 0xFFFFFFFF, the pid + 1 calculation wraps to 0 on 32-bit
systems, resulting in a 0-byte allocation.

The subsequent while loop would then write NULL pointers sequentially out
of bounds, which could corrupt heap memory.


Also in the same function:

tools/perf/builtin-sched.c:register_pid() {
...
	task =3D zalloc(sizeof(*task));
	task->pid =3D pid;
	task->nr =3D sched->nr_tasks;
	strcpy(task->comm, comm);
...

[Severity: Critical]
This is a pre-existing issue, but does this strcpy() allow a heap buffer
overflow?

The comm string extracted from the perf.data payload is copied into the
fixed 20-byte task->comm array.

If the untrusted string is longer than 19 characters, this could overflow
the struct task_desc heap allocation and overwrite adjacent fields.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604201119.1702=
338-1-acme@kernel.org?part=3D3
