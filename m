Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741459;
	b=JZIG02XOcxjmrctvUFrcsD3BCD4cHbIs1rXheMcmGsTmQgoMrk8ubr+jH/jIwg5uy2oi
	 IHowewy+ZvtpifwnzFhQFE4KZedTr7JEFN9A0hnXByiNpkHh+8mLawnwugf3fD5qcmZDB
	 3ubh11KiLNjJ5CLKD63V24iuOdTBmP4FYJzYljQZzinNKtOmjd1nql399Ktb4WXN0sy8W
	 aXnt3Es4Y9m2tt6qE/oH7JEtSHLS6chR/ugubJnzVIyEdbChPauzcGMwikL+6C8H7cqT9
	 GpVA/BdtS4nd13Pp6kHxjKuf/9tygQZ7Q/y+jOHKBioU97y0KY6+dWDlWdU425kzhJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741459;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6sh+HgbHmGKW2p76RFFfcZnJYKqAPy+G06iw+nPADWs=;
	b=mid5jPYHvD53sVSk5XZFqT/gSGqTOfsC8b5B8ZBbpZB30Rzk4/b7886oxBQBsst0YLD3
	 9VluSFpP5fdxNgk2HNiQV8rAxqvDRsrMigWYU8x84Le19JS2CGs2AoKz7bbgk649H4/NA
	 nP7F0R8zivYkDyFhNiOTQsQYHd25IRkRof3ZJyXQ1cYrlXO78jlt8IaYmfOSwyaPf+BPo
	 LnEmisJ7guRB8Biq56DaZjocVERNMcYkI4xTV1/AOlJ7eCNQa8xaqyE3Fmsc0cDq1FmdA
	 sez6ATGN0PoMVQx448N8M5tNOm1tjnYYTSVuOnTgCnCWBZcq3lwlF/xhcuLihRL/z5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UCHb55XO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9152B606A31F
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 07:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UCHb55XO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C021F031E6;
	Fri, 23 Oct 2026 07:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792741459;
	bh=6sh+HgbHmGKW2p76RFFfcZnJYKqAPy+G06iw+nPADWs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UCHb55XObaK/m1XeJ5Zx4cOVSSEM4fkdAp7e8ZZ0GmZ4dgNHbs6+5+kKCI/iwjKb3
	 UB3Lnpq4wl+RaM9bHUaBwgjQFgEABDYLqbLmR9nb2nzvl7mcHll9+l3OykMA3pwhnM
	 KqW8pFTDR5hLyoMgTpFkqmB0TOmT4FdwQKPRUta+uGBPYoDxV3lWuCc0MuNbSJl704
	 IkU12sKXVvGWVseoMrbSa4s8lZ4ZEM7NjFWSITa1ATGUK46sPzBZ8aNjA8VDooAEJZ
	 3U+eliH4fNKXh/AQygbrmU1nz428PwTwV7Lz+T0kJcLDqoBSesLCuT8IrIyPWTZUIh
	 rJkCbrQ/5ZABA==
Message-ID: <sashiko-outbox-182434@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 06/11] perf tools: Check thread liveness when
 accessing /proc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261023071141.134149-7-namhyung@kernel.org>
References: <20261023071141.134149-1-namhyung@kernel.org>
 <20261023071141.134149-7-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 07:44:18 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Medium] perf: mark replaced parent exited in machine__process_fork_event=
()
- [Medium] perf tools: missing thread__set_exited() in perf_event__exit_del=
_thread()
- [Medium] perf tools: premature perf_env__is_same_boot() call poisons env-=
>boot_id
- [Medium] perf tools: unsynchronized nsinfo mutation in thread__set_exited=
()
- [Medium] perf thread: thread__e_machine_endian() bypasses thread__is_aliv=
e() when pid !=3D tid
--

commit 8a3b91cf7c4d52fe98a2a5c0924575e60cc8f0b2
Author: Namhyung Kim <namhyung@kernel.org>

perf tools: Check thread liveness when accessing /proc

This commit adds thread__exited() and thread__is_alive(), marks threads and
their nsinfo as exited upon PERF_RECORD_EXIT, PERF_RECORD_FORK replacement,
or boot ID mismatch, and guards /proc accesses with thread__is_alive().

> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 14f52234d4d99..8f6298aff681f 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
[ ... ]
> @@ -1954,6 +1957,7 @@ int machine__process_fork_event(struct machine *mac=
hine, union perf_event *event
> =20
>  	/* if a thread currently exists for the thread id remove it */
>  	if (thread !=3D NULL) {
> +		thread__set_exited(thread, /*exited=3D*/true);
>  		machine__remove_thread(machine, thread);
>  		thread__put(thread);
>  	}

[Severity: Medium]
Should the replaced parent thread just above in machine__process_fork_event=
()
also be marked exited before it is removed?

tools/perf/util/machine.c:machine__process_fork_event() {
	if (parent !=3D NULL &&
	    thread__pid(parent) !=3D (pid_t)event->fork.ppid) {
		dump_printf("removing erroneous parent thread %d/%d\n",
			    thread__pid(parent), thread__tid(parent));
		machine__remove_thread(machine, parent);
		thread__put(parent);
		parent =3D machine__findnew_thread(machine, event->fork.ppid,
						 event->fork.ptid);
	}
}

When a prior exit or fork event was lost and event->fork.ptid now belongs to
a different process, parent is removed from machine->threads without calling
thread__set_exited(parent, true).

As a result, parent->exited and parent->nsinfo->exited remain false (and
nsinfo__clear_need_setns() is not called on parent->nsinfo). Any remaining
references to parent or to parent->nsinfo (such as dso->nsinfo shared via
map__new()) will continue to treat the removed thread's nsinfo as live, and
if the TID is recycled again into the original process, nsinfo__check_proc()
and thread__is_alive() can succeed against the wrong thread.

> @@ -2001,9 +2005,8 @@ int machine__process_exit_event(struct machine *mac=
hine, union perf_event *event
>  	/* There is no context switch out before exit, so we decrement here. */
>  	machine->parallelism--;
>  	if (thread !=3D NULL) {
> -		if (symbol_conf.keep_exited_threads)
> -			thread__set_exited(thread, /*exited=3D*/true);
> -		else
> +		thread__set_exited(thread, /*exited=3D*/true);
> +		if (!symbol_conf.keep_exited_threads)
>  			machine__remove_thread(machine, thread);
>  	}
>  	thread__put(thread);

[Severity: Medium]
Does perf_event__exit_del_thread() in tools/perf/util/event.c also need a
call to thread__set_exited(thread, true) before removing the thread?

tools/perf/util/event.c:perf_event__exit_del_thread() {
	if (thread) {
		machine__remove_thread(machine, thread);
		thread__put(thread);
	}
}

In cmd_buildid_list() -> perf_session__list_build_ids(),
build_id__mark_dso_hit_ops sets .exit =3D perf_event__exit_del_thread. When=
 a
thread maps a DSO via perf_event__process_mmap2() -> map__new(),
thread__nsinfo(thread) is attached to the DSO via dso__set_nsinfo().

When that thread later exits, perf_event__exit_del_thread() removes the
thread without calling thread__set_exited(thread, true), leaving
nsi->exited false on the surviving dso->nsinfo reference. If a subsequent
sample with DWARF callchain data is processed by build_id__mark_dso_hit() ->
sample__for_each_callchain_node() -> __thread__resolve_callchain() ->
thread__resolve_callchain_unwind() -> unwind__get_entries(), loading the DSO
calls nsinfo__mountns_enter(dso__nsinfo(dso), &nsc) with nsi->exited still
false, which can inspect /proc/<pid>/task/<tid>/ of a recycled PID on the
same boot.

> diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
> index 377c39ec624bb..f75eafb25bfc0 100644
> --- a/tools/perf/util/thread.c
> +++ b/tools/perf/util/thread.c
> @@ -37,6 +37,10 @@ int thread__init_maps(struct thread *thread, struct ma=
chine *machine)
>  		}
>  	}
> =20
> +	if (!machine || !machine__is_host(machine) ||
> +	    !perf_env__is_same_boot(machine->env))
> +		nsinfo__set_exited(thread__nsinfo(thread));
> +
>  	return thread__maps(thread) ? 0 : -1;
>  }

[Severity: Medium]
Can calling perf_env__is_same_boot(machine->env) here during idle thread
registration prematurely populate machine->env->boot_id with the local host=
's
boot ID in pipe mode or featureless recordings?

In perf_session__process_events(), perf_session__register_idle_thread() runs
before __perf_session__process_pipe_events() reads any
PERF_RECORD_HEADER_FEATURE events from the pipe:

tools/perf/util/session.c:perf_session__process_events() {
	if (perf_session__register_idle_thread(session) < 0)
		return -ENOMEM;

	if (perf_data__is_pipe(session->data))
		return __perf_session__process_pipe_events(session);
}

perf_session__register_idle_thread() creates the idle thread (0, 0) via
machine__idle_thread() -> machine__findnew_thread() -> thread__init_maps().
Even though thread__nsinfo(thread) is NULL for tid 0, thread__init_maps()
evaluates perf_env__is_same_boot(machine->env) -> perf_env__boot_id():

tools/perf/util/env.c:perf_env__boot_id() {
	if (env->arch || env->hostname) {
		boot_id =3D NULL;
		goto out;
	}

	env->boot_id =3D read_host_boot_id();
	boot_id =3D env->boot_id;
}

Because env->arch, env->hostname, and env->boot_id are all still NULL before
feature events are processed (or in interrupted recordings where
f_header.data.size =3D=3D 0), perf_env__boot_id() assumes a live environmen=
t and
caches read_host_boot_id() in env->boot_id.

If the stream lacks HEADER_BOOT_ID or is processed by a tool that does not
populate session->header.env from feature events (such as perf inject or
offline perf trace), env->boot_id remains set to the local host's boot ID,
causing perf_env__is_same_boot(machine->env) to return true in
thread__init_maps(), machine__update_thread_pid(), and thread__is_alive()
during offline analysis.

> @@ -289,6 +293,30 @@ int __thread__set_comm(struct thread *thread, const =
char *str, u64 timestamp,
>  	return ret;
>  }
> =20
> +void thread__set_exited(struct thread *thread, bool exited)
> +{
> +	RC_CHK_ACCESS(thread)->exited =3D exited;
> +	if (exited)
> +		nsinfo__set_exited(thread__nsinfo(thread));
> +}

[Severity: Medium]
Can calling nsinfo__set_exited(thread__nsinfo(thread)) on every exit and
fork replacement race with concurrent nsinfo users in multithreaded modes
such as perf top?

A struct nsinfo instance is shared without an internal lock between
thread->nsinfo and one or more dso->nsinfo pointers via map__new() ->
dso__set_nsinfo(). Calling thread__set_exited() invokes nsinfo__set_exited()
-> nsinfo__clear_need_setns():

tools/perf/util/namespaces.c:nsinfo__clear_need_setns() {
	if (!nsi)
		return;

	RC_CHK_ACCESS(nsi)->inited =3D true;
	RC_CHK_ACCESS(nsi)->need_setns =3D false;
	zfree(&RC_CHK_ACCESS(nsi)->mntns_path);
}

In perf top, where process_thread processes PERF_RECORD_EXIT and
PERF_RECORD_FORK events concurrently with display_thread resolving symbols
and reading DSOs:

1. nsinfo__mountns_enter() checks RC_CHK_ACCESS(nsi)->need_setns and then
   calls open(nsinfo__mntns_path(nsi), ...), which can race with
   nsinfo__clear_need_setns() freeing and zeroing mntns_path.

2. nsinfo__copy() checks if (nsinfo__mntns_path(nsi)) and then calls
   strdup(nsinfo__mntns_path(nsi)), which can pass NULL or a freed pointer
   to strdup() if nsinfo__clear_need_setns() runs concurrently.

3. Concurrent calls to nsinfo__set_exited() (for example, process_thread
   handling PERF_RECORD_EXIT while display_thread calls
   thread__e_machine_endian() -> thread__is_alive() -> nsinfo__check_proc()
   or nsinfo__mountns_enter() -> nsinfo__check_proc()) can race in
   zfree(&RC_CHK_ACCESS(nsi)->mntns_path) and double-free mntns_path.

[ ... ]
> @@ -541,7 +572,7 @@ uint16_t thread__e_machine_endian(struct thread *thre=
ad, struct machine *machine
>  			is_live =3D !session || !session->data;
>  		}
>  		/* Read from /proc/pid/exe if live. */
> -		if (is_live) {
> +		if (is_live && thread__is_alive(thread)) {
>  			e_machine =3D read_proc_e_machine_for_pid(pid, &local_e_flags,
>  								&args.is_big_endian);
>  		} else if (machine && machine->env) {

[Severity: Medium]
What happens in thread__e_machine_endian() when thread is a non-leader
sub-thread (pid !=3D tid) whose thread or leader has already exited?

Earlier in thread__e_machine_endian(), before reaching the
thread__is_alive(thread) check, a sub-thread delegates to its group leader:

tools/perf/util/thread.c:thread__e_machine_endian() {
	tid =3D thread__tid(thread);
	pid =3D thread__pid(thread);
	if (pid !=3D tid) {
		struct thread *parent =3D machine__findnew_thread(machine, pid, pid);

		if (parent) {
			e_machine =3D thread__e_machine_endian(parent, machine, &local_e_flags,
							     &args.is_big_endian);
			thread__put(parent);
			goto out;
		}
		/* Something went wrong, fallback. */
	}
}

If the leader thread (pid, pid) has already exited and been removed from
machine->threads (when symbol_conf.keep_exited_threads is false),
machine__findnew_thread(machine, pid, pid) allocates a fresh parent thread
with parent->exited =3D false and a new nsinfo for (pid, pid), and recurses=
 on
parent.

In the recursive call, thread__is_alive(parent) is checked instead of
thread__is_alive(thread). Even if the sub-thread had thread->exited =3D=3D =
true,
parent->exited is false, and nsinfo__check_proc(parent->nsinfo) only checks
whether /proc/<pid>/task/<pid>/status has Tgid =3D=3D <pid>, which will suc=
ceed
for any new process that recycled <pid> and cause
read_proc_e_machine_for_pid(pid, ...) to read /proc/<pid>/exe of the
recycled process.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023071141.1341=
49-1-namhyung@kernel.org?part=3D6
