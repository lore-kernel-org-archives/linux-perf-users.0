Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1587431E822
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 20:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780692791; cv=none; b=QgLLCimljw0RPtJZB4R4PJatUVxIDmHYXgxKOhONbWK2vm0DkpEjM8tuaVVZYDqVrtqkwFM2EtRlPX8FXCTJ5tE/Ps7ftkGk58VlSN2uF9AjeTzo10+79ZTHhs79f42cmcpWRCzkDTTLTqJrJvtcDhduVKR5+8E+LPG6iBdM3sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780692791; c=relaxed/simple;
	bh=JhdVHb1YeRtyepZ4WgA79nXtEKMALa9rKY9C4MrNnHM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZojA6yuGJoOw8Gd81ejEDrQSlvwz2c9CWLRSOp6Ck2fXoxCOVWen14NDTe82XKkk/mnssC6fdELP1lqqKOZ3zGFxiBUAG375vbANOwPx9dho1lYf3964Md4spizEHEr1fxw7mCb3hTg32GqQD25hQzeTqtl0seUwWHbCgS8R+mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iE5u//BG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iE5u//BG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810BA1F00893;
	Fri,  5 Jun 2026 20:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780692789;
	bh=+vYG4p6Hn7dvdNqNO4uCYyuYfQY/shd0ickmCV0lKHU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iE5u//BGVwKntEhKAMcxsz2ZKAD1RT8zDiyWP81nIlr0ZbuxSbapQsZqstJVnAalf
	 NPOu4cLhpXFLxe+3fuf4NTI6p1DeG4qybtFGJ6d9zHTZQ2hzZlSai+cQddzRmi1vvg
	 lycfV8xUbHqq0ozj5NZQjO5i49lmlAd5FAzgBpdGbmOqYel2lhG/5MxxWCnxhUflml
	 /GrR5SSitE+/JBLgZd5s67/IIS+8wEgTvxbZm4GMqHVLlMat5xfjJMz4MpG/yI9QBR
	 lm372MAVN3/G5iWehCvC6D4v/2CL6oXYcMLZqMFUDgfoHi8x74GKH2IIsD0tPAblKs
	 6XmOjWvWZ/uvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/8] perf sched: Clean up idle_threads entry on init
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605203316.1758661-6-acme@kernel.org>
References: <20260605203316.1758661-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 20:53:09 +0000
Message-Id: <20260605205309.810BA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Negative array index out-of-bounds read and write in `get_idle_thr=
ead()` due to unchecked `sample->cpu`.
- [Medium] Missing `thread__put()` causes reference count and handle leaks =
for both `idle` and `thread` variables in `timehist_get_thread()`.
- [Medium] A NULL pointer dereference occurs in `latency_runtime_event()` i=
f thread allocation fails.
- [Medium] Leaked `callchain_cursor_node` structs inside `idle_thread_runti=
me` when the thread is destroyed.
--

commit f4d6b1c97697918976cf8390fa17c92e7ead50bf
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

    perf sched: Clean up idle_threads entry on init failure
   =20
    get_idle_thread() allocates a thread via thread__new() and stores it in
    idle_threads[cpu], then calls init_idle_thread() to set up the private
    data. If init_idle_thread() fails, the partially initialized thread is
    left in idle_threads[cpu], causing subsequent calls to return a thread
    without private data. This patch resets the slot on init failure.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 555247568e7a6..e47db1c5c6020 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -2475,8 +2475,11 @@ static struct thread *get_idle_thread(int cpu)

[Severity: High]
This is a pre-existing issue, but does this function properly validate the
cpu index? The sample->cpu field is read from the untrusted perf.data file.
If a sample lacks a CPU, it typically defaults to (u32)-1. When passed to
get_idle_thread() as an int, cpu becomes -1.

The upper-bounds check will evaluate to false:

        if ((cpu >=3D idle_max_cpu) || (idle_threads =3D=3D NULL)) {

And then a negative index is used to read and write memory out of bounds:

        if (idle_threads[cpu] =3D=3D NULL) {
                idle_threads[cpu] =3D thread__new(0, 0);

Could this unchecked value lead to heap metadata corruption?

>  		idle_threads[cpu] =3D thread__new(0, 0);
> =20
>  		if (idle_threads[cpu]) {
> -			if (init_idle_thread(idle_threads[cpu]) < 0)
> +			if (init_idle_thread(idle_threads[cpu]) < 0) {
> +				/* clean up so next call doesn't find a half-initialized thread */
> +				thread__zput(idle_threads[cpu]);
>  				return NULL;
> +			}
>  		}
>  	}

[Severity: Medium]
This isn't a bug introduced by this patch, but doesn't the
timehist_get_thread() function leak the thread and idle references on error
paths?

tools/perf/builtin-sched.c:timehist_get_thread() {
        ...
        idle =3D get_idle_thread(sample->cpu);
        if (idle =3D=3D NULL) {
            ...
        }

        itr =3D thread__priv(idle);
        if (itr =3D=3D NULL)
            return NULL;
        ...
}

It appears get_idle_thread() returns a reference to the idle thread that is
never released with thread__put(). Also, returning NULL when itr is NULL
leaks both the newly acquired idle thread and the primary thread reference.
Could this cause a memory leak over time during large traces?

[Severity: Medium]
This is a pre-existing issue, but does latency_runtime_event() dereference
a potentially NULL thread pointer before checking it?

tools/perf/builtin-sched.c:latency_runtime_event() {
        ...
        struct thread *thread =3D machine__findnew_thread(machine, -1, pid);
        struct work_atoms *atoms =3D thread_atoms_search(&sched->atom_root,
                                                       thread, &sched->cmp_=
pid);
        ...
        if (thread =3D=3D NULL)
            return -1;
        ...
}

If thread allocation fails, machine__findnew_thread() returns NULL, which is
then passed to thread_atoms_search() and dereferenced before the check
if (thread =3D=3D NULL) is reached. Is it possible to move the NULL check a=
bove
the call to thread_atoms_search()?

[Severity: Medium]
This isn't a bug introduced by this patch, but does the idle_thread_runtime
structure permanently leak its callchain_cursor nodes?

When init_idle_thread() sets up the idle thread:

tools/perf/builtin-sched.c:init_idle_thread() {
        ...
        callchain_cursor_reset(&itr->cursor);
        thread__set_priv(thread, itr);
        ...
}

During execution, save_idle_callchain() allocates nodes dynamically via
callchain_cursor__copy(). However, the destructor for thread private data is
typically just free(), meaning the dynamically allocated callchain_cursor_n=
ode
elements within itr->cursor are never deep-freed when the idle thread is
destroyed. Should a proper destructor be registered to free these nodes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605203316.1758=
661-1-acme@kernel.org?part=3D5
