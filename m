Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792740407;
	b=qkMHaXVdwqipI083n75OoLfEd8dO6mhSCPqsVX8/QcB7mAnx10inCgvTq5TESLaNw/82
	 GrtMnvX4Q5AFJSit+N8nTSd+vUOSWEvMNuYBjjHP5NwRAiJP/ZIkygu+YctG2jdhSQ9SU
	 cLhhRP9D4KmepUidKgYP3iPtnF34EMINcmhoQMGog9skDgqxnCcWlNPhBG7nrQCLyAsxM
	 UKNrq6usNj1B9dQUiCVoPrshS2vLJJ0N6PFZcXbNm0uQBAxLBuiU3DEsJlGf9K4BIHNno
	 OhA3TLkc/JtL61L3RbvMklJwI21XP3YE2hVNxnl8WR8U+4/kdemDRKhjl5dX1oGv54A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792740407;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dPOVJwJss1EIZjf8xg80+j8YmKECbrvmt8s9GBGBnxs=;
	b=l3SaSQLRoJ2Ijc9Y47Xic2RRx23MeLDBh+xyMKBDr25pktEoHWkrTusegLfXWPoqAHDb
	 GerzYS5ON/JsASG0IFbtB2cI2KyKxNPSlS47Af6C9vWALS/0+gFrbrPBVnIEzdC1/QK8F
	 RuI/OY0bVeUd5C+mxr4b7PBYmYdEg7MTG9ZLvOLn+I41jetkenx1zbCXXGOmx4f5J4mfP
	 t309iPU6ZEEnQJJJCxvS8qsLqXiIWmpTlIywlK5pt8tAntINNIljvp88nkDI6PZ3Qc1+P
	 +kd+wmY+mQJ2yWMoz/p+ziBiho+YIBchyLqUHaC9MFSkN/gL4L5RaYT40As2a73ag3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Km8tdETu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20752606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 07:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Km8tdETu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999411F01825;
	Fri, 23 Oct 2026 07:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792740406;
	bh=dPOVJwJss1EIZjf8xg80+j8YmKECbrvmt8s9GBGBnxs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Km8tdETuAF1+8Lkef/PRO7+qelV9TuaDJ8Xo8cCOj67/lxqkwvTw3NYOYES1k9zbK
	 Yl9C7qjLIj4RyrWQGOLm11iIuewc5INqjt96CZVSXA1VIX580uHEjnxmuqCT5QIqLa
	 84VJhEYBlPhibAQ2gSHmnPlc3brdT3tgGDZnvDmvPkojvZFpMwMX0803VBNQm+TBe+
	 U8BlR7Pzub9RzTv9RXwwqNZ+Ksd0fEE8oUi8nessjnaj1o7y5fF2MgiIQxAgq6uLmZ
	 oHW3W2lWomMLzXXL8jnZ54USnqDXA9MFoh9NvbKgo0X5fvoRZ5KDymCbN2TeUUxTdE
	 t1B0iYC3sQrow==
Message-ID: <sashiko-outbox-182410@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 04/11] perf tools: Defer /proc lookup until nsinfo is
 used
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261023071141.134149-5-namhyung@kernel.org>
References: <20261023071141.134149-1-namhyung@kernel.org>
 <20261023071141.134149-5-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 07:26:46 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] perf namespaces: eager /proc lookup in nsinfo__copy() on vdso ma=
ps
- [Medium] perf namespaces: stale PID namespace fields after nsinfo__reset_=
init()
- [Medium] perf namespaces: unsynchronized in-place mutation of shared nsin=
fo
--

commit 8a6dea83f2e96bc304e510d4de1293c50368eb01
Author: Namhyung Kim <namhyung@kernel.org>

perf tools: Defer /proc lookup until nsinfo is used

This commit defers reading /proc/<pid>/task/<tid>/ in nsinfo__new_thread()
until namespace information is queried or entered via nsinfo__ensure_init(),
and resets the initialization state on exec and PERF_RECORD_NAMESPACES even=
ts.

> diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
> index f426eba04d6ef..843d075d30409 100644
> --- a/tools/perf/util/namespaces.c
> +++ b/tools/perf/util/namespaces.c

[ ... ]

> @@ -196,6 +198,8 @@ struct nsinfo *nsinfo__copy(const struct nsinfo *nsi)
>  	if (nsi =3D=3D NULL)
>  		return NULL;
> =20
> +	nsinfo__ensure_init((struct nsinfo *)nsi);
> +
>  	nnsi =3D nsinfo__alloc();
>  	if (!nnsi)
>  		return NULL;
> @@ -204,7 +208,8 @@ struct nsinfo *nsinfo__copy(const struct nsinfo *nsi)
>  	RC_CHK_ACCESS(nnsi)->tid =3D nsinfo__tid(nsi);
>  	RC_CHK_ACCESS(nnsi)->tgid =3D nsinfo__tgid(nsi);
>  	RC_CHK_ACCESS(nnsi)->nstgid =3D nsinfo__nstgid(nsi);
> -	RC_CHK_ACCESS(nnsi)->need_setns =3D nsinfo__need_setns(nsi);
> +	RC_CHK_ACCESS(nnsi)->inited =3D RC_CHK_ACCESS(nsi)->inited;
> +	RC_CHK_ACCESS(nnsi)->need_setns =3D RC_CHK_ACCESS(nsi)->need_setns;
>  	RC_CHK_ACCESS(nnsi)->in_pidns =3D nsinfo__in_pidns(nsi);
>  	if (nsinfo__mntns_path(nsi)) {
>  		RC_CHK_ACCESS(nnsi)->mntns_path =3D strdup(nsinfo__mntns_path(nsi));

[Severity: Medium]
Should nsinfo__copy() copy the raw fields of struct nsinfo without calling
nsinfo__ensure_init(), nsinfo__tgid(), nsinfo__nstgid(), and
nsinfo__in_pidns()?

When a PERF_RECORD_MMAP or PERF_RECORD_MMAP2 event for a [vdso] mapping is
processed in tools/perf/util/map.c:map__new() or
tools/perf/builtin-inject.c:dso__findnew_id(), perf copies the thread's
nsinfo and immediately clears need_setns on the copy:

	if (vdso) {
		nnsi =3D nsinfo__copy(nsi);
		if (nnsi) {
			nsinfo__put(nsi);
			nsinfo__clear_need_setns(nnsi);
			nsi =3D nnsi;
		}
	}

Because nsinfo__copy() calls nsinfo__ensure_init() on the source nsinfo (as
well as the getter helpers that also call nsinfo__ensure_init()), any proce=
ss
that maps [vdso] will still trigger an eager /proc/<pid>/task/<tid>/ns/mnt
and /proc/<pid>/task/<tid>/status lookup and duplicate mntns_path only for
nsinfo__clear_need_setns() to immediately free it, even when namespace
information is never subsequently used.

> @@ -251,21 +256,41 @@ void nsinfo__put(struct nsinfo *nsi)
> =20
>  bool nsinfo__need_setns(const struct nsinfo *nsi)
>  {
> +	if (!nsi)
> +		return false;
> +
> +	nsinfo__ensure_init((struct nsinfo *)nsi);
>  	return RC_CHK_ACCESS(nsi)->need_setns;
>  }
> =20
>  void nsinfo__clear_need_setns(struct nsinfo *nsi)
>  {
> +	if (!nsi)
> +		return;
> +
> +	RC_CHK_ACCESS(nsi)->inited =3D true;
>  	RC_CHK_ACCESS(nsi)->need_setns =3D false;
> +	zfree(&RC_CHK_ACCESS(nsi)->mntns_path);
> +}
> +
> +void nsinfo__reset_init(struct nsinfo *nsi)
> +{
> +	if (!nsi)
> +		return;
> +
> +	nsinfo__clear_need_setns(nsi);
> +	RC_CHK_ACCESS(nsi)->inited =3D false;
>  }

[Severity: Medium]
Does nsinfo__reset_init() leave stale PID namespace values in in_pidns, tgi=
d,
and nstgid?

When nsinfo__new_thread() allocates a struct nsinfo, tgid and nstgid are set
to pid and in_pidns is false. Once nsinfo__init() (or nsinfo__set_in_pidns(=
))
populates tgid, nstgid, and in_pidns for a task in a PID namespace, a
subsequent exec or PERF_RECORD_NAMESPACES event calls nsinfo__reset_init(),
which only clears need_setns, mntns_path, and inited.

If the task exits or becomes inaccessible in /proc before the next
nsinfo__ensure_init() call, nsinfo__init() sets inited =3D true at the star=
t of
the function and fails before or inside nsinfo__get_nspid():

tools/perf/util/namespaces.c:nsinfo__init() {
	...
	RC_CHK_ACCESS(nsi)->inited =3D true;
	...
	if (stat(newns, &new_stat) < 0)
		goto out;
	...
	rv =3D nsinfo__get_nspid(&RC_CHK_ACCESS(nsi)->tgid, &RC_CHK_ACCESS(nsi)->n=
stgid,
			       &RC_CHK_ACCESS(nsi)->in_pidns, spath);
out:
	free(newns);
	return rv;
}

In that case, in_pidns, tgid, and nstgid will retain their stale pre-reset
values instead of reverting to false and pid.

> diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
> index d12eb6bc63313..377c39ec624bb 100644
> --- a/tools/perf/util/thread.c
> +++ b/tools/perf/util/thread.c
> @@ -199,6 +199,8 @@ int thread__set_namespaces(struct thread *thread, u64=
 timestamp,
>  	down_write(thread__namespaces_lock(thread));
>  	ret =3D __thread__set_namespaces(thread, timestamp, event);
>  	up_write(thread__namespaces_lock(thread));
> +	if (!ret && event)
> +		nsinfo__reset_init(thread__nsinfo(thread));
>  	return ret;
>  }
> =20
> @@ -282,6 +284,8 @@ int __thread__set_comm(struct thread *thread, const c=
har *str, u64 timestamp,
>  	down_write(thread__comm_lock(thread));
>  	ret =3D ____thread__set_comm(thread, str, timestamp, exec);
>  	up_write(thread__comm_lock(thread));
> +	if (!ret && exec)
> +		nsinfo__reset_init(thread__nsinfo(thread));
>  	return ret;
>  }

[Severity: Medium]
Can mutating thread__nsinfo(thread) in-place via nsinfo__reset_init() and
nsinfo__ensure_init() cause a use-after-free on mntns_path or corrupt DSO
namespace state?

In tools/perf/util/map.c:map__new() and
tools/perf/builtin-inject.c:dso__findnew_id(), dso->nsinfo takes a reference
to thread__nsinfo(thread) via nsinfo__get(), so the same struct nsinfo
instance is shared between the thread and its DSOs.

In multithreaded modes such as perf top (where display_thread resolves
symbols via nsinfo__mountns_enter() while process_thread handles
PERF_RECORD_COMM and PERF_RECORD_NAMESPACES events) or multithreaded event
synthesis, one thread can check nsinfo__need_setns() and then pass
nsinfo__mntns_path(nsi) to open() or strdup():

tools/perf/util/namespaces.c:nsinfo__mountns_enter() {
	if (!nsi || !nsinfo__need_setns(nsi))
		return;
	...
	newns =3D open(nsinfo__mntns_path(nsi), O_RDONLY);
}

while another thread calls thread__set_namespaces() or __thread__set_comm()
-> nsinfo__reset_init() -> nsinfo__clear_need_setns() ->
zfree(&RC_CHK_ACCESS(nsi)->mntns_path) without synchronization, freeing and
clearing mntns_path concurrently.

Similarly, nsinfo__init() sets RC_CHK_ACCESS(nsi)->inited =3D true at the
beginning of the function before setting need_setns, mntns_path, tgid,
nstgid, and in_pidns, so a concurrent caller of nsinfo__ensure_init() can
observe inited =3D=3D true and read partially initialized fields (or two th=
reads
can enter nsinfo__init() concurrently and leak the first mntns_path
allocation).

Furthermore, even in single-threaded mode, resetting thread__nsinfo(thread)
in-place mutates the struct nsinfo already attached to DSOs mapped by the
thread prior to the namespace change or exec. Would it be safer to replace
thread->nsinfo with a newly allocated struct nsinfo on namespace changes and
synchronize lazy initialization inside nsinfo__ensure_init()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023071141.1341=
49-1-namhyung@kernel.org?part=3D4
