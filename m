Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AF039184C
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781199495; cv=none; b=NIJHXeDbVLTKcW3Yvgj0DD7NBUGu47PG6zDKIbPDzON3i6ZzDSLc1Ri3N+7c4C6FyuFL+Y73SPIMPJ0rk6vXrLXQF1D0p+NITTewPf43FTq1IhsttMyngqUERKcWrv8yEiN8Rc6Q8vMNcx/m82VgbNN9+J5CFaZVaLkMWPPDOAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781199495; c=relaxed/simple;
	bh=VQgDDCj0V/2YmdH6FPFjkYBtq5Aa+oEB4kVPte673B4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qccxdMPpmQpwhCbwnS0WCK1sbE4ybiyrxIkP5xyPQHOTJ0slfi6VewxhXTccXoLhGb5jcIXXzF3LR5xiejW7AViQ0LfXQ9gqzUnlmwuB5NuzwiXxPYGlaTaOEuttTEISK3XhkQmqpDf80Dmx+f6GKUpxCcez1rtlf49Z/Q7OD5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1frSa4b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1frSa4b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128851F00893;
	Thu, 11 Jun 2026 17:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781199493;
	bh=rXizrUFLeiClzqdaVW1P/mZiKcWnAwhusWmskk32GkM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B1frSa4b/xBJlf09IB4dCAycb9/mG6nKQ/vIMwX99lVw5HBdnlb/bP41lVNchToCz
	 LaPqIO49NEAeTLDbrR0FNeRtp9HN4JhCgvhjMMWbyAu7kWmZP0c1/2bRmqOmdjjZ6/
	 osiLZidvM2D0wqlKSexGJqGcnL567C2PBOAv+5LfqLQ7UNzI7FSKPcPkfd3pClH1BB
	 LzrPvv4SqBSt0mXdpBB4lIukwZQZWynRe2cuQqoIPxzPw2OD424W0kYRKo+ueG9q3Y
	 24PWTH12myKi/lFVLbDxEBXQR+LVlO/O+RGDrntvI1Lh7nIYxJLj4BbWDRUojVWoNh
	 Y9VrCMDuyj1Wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 07/19] perf evlist: Add reference count checking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611171756.4008769-8-irogers@google.com>
References: <20260611171756.4008769-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 17:38:12 +0000
Message-Id: <20260611173813.128851F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [High] Asymmetric cycle-breaking logic between `evlist__put` and `evsel__=
put` causes a permanent memory leak if an `evsel` outlives its `evlist`.
- [High] Time-of-Check to Time-of-Use (TOCTOU) race in lockless cycle detec=
tion in `evlist__put` allows concurrent double-free or use-after-free of th=
e evlist.

Pre-existing issues:
- [High] The Python binding `pyrf_evlist__read_on_cpu` fails to call `perf_=
mmap__read_done` after processing an event, breaking ring buffer synchroniz=
ation.
- [High] Splicing evlists via `evlist__splice_list_tail` leaves stale `evse=
l->evlist` pointers, causing infinite loops, out-of-bounds reads, and memor=
y leaks.
- [High] Missing NULL check on the result of `PyList_New` leads to a NULL p=
ointer dereference in `pyrf_evlist__get_pollfd`.
- [Medium] `list` is permanently leaked in `pyrf_evlist__get_pollfd` on err=
or paths.
- [Medium] The return value of `perf_event__synthesize_extra_attr` is overw=
ritten without being checked in `perf_event__synthesize_stat_events`.
--

commit a5c50520559655c0ea79aa1554e187bff87b04fd
Author: Ian Rogers <irogers@google.com>
perf evlist: Add reference count checking

Now the evlist is reference counted, add reference count checking so that
gets and puts are paired and easy to debug.

> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 1721a2470fb67..eb7c0d7be064e 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
[ ... ]
>  void evlist__put(struct evlist *evlist)
>  {
> +	struct evsel *evsel;
> +	unsigned int count, ref_cnt;
> +
>  	if (evlist =3D=3D NULL)
>  		return;
> =20
> -	if (!refcount_dec_and_test(&evlist->refcnt))
> -		return;
> +	if (refcount_dec_and_test(evlist__refcnt(evlist)))
> +		goto out_delete;
> +
> +retry:
> +	count =3D refcount_read(evlist__refcnt(evlist));
> +	ref_cnt =3D count;
> +	evlist__for_each_entry(evlist, evsel) {
> +		if (RC_CHK_EQUAL(evsel->evlist, evlist) && count &&
> +		    refcount_read(&evsel->refcnt) =3D=3D 1)
> +			count--;
> +	}
> +	if (refcount_read(evlist__refcnt(evlist)) !=3D ref_cnt)
> +		goto retry;

[Severity: High]
Is there a potential TOCTOU race condition in this lockless cycle detection?
If multiple threads drop their references concurrently, couldn't they both
enter the retry loop, observe that the remaining refcount equals the number
of evsel back-references, and proceed to the out_delete path, causing a
double-free of the evlist? Furthermore, if another thread acquires an evsel
reference concurrently, the cycle detection might read a stale state and
incorrectly free the evlist while it is still in use.

> +	if (count !=3D 0) {
> +		/*
> +		 * Not the last reference except for back references from
> +		 * evsels.
> +		 */
> +		RC_CHK_PUT(evlist);
> +		return;
> +	}

[Severity: High]
Does this cycle-breaking logic successfully handle cases where an external
caller holds a reference to an evsel that outlives its evlist? It appears
that if an external component holds a strong reference when the evlist is
destroyed, count !=3D 0 evaluates to true and the function returns without
breaking the cycle. Since evsel__put does not seem to contain reciprocal
cycle-breaking logic, both the evlist and the evsel could be permanently
leaked.

[ ... ]
>  void evlist__splice_list_tail(struct evlist *evlist, struct list_head *l=
ist)
>  {
> -	perf_evlist__splice_list_tail(&evlist->core, list);
> +	perf_evlist__splice_list_tail(evlist__core(evlist), list);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does splicing the list here
move the evsel nodes without updating their evsel->evlist back-pointers? If
the pointers remain stale, iterations like the one in evsel__merge_aliases()
using list_for_each_entry_continue() might rely on the stale pointer for
loop termination, potentially leading to an infinite loop and out-of-bounds
memory reads.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index dc097c5befdb7..9f4216aa3867c 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -1777,13 +1791,18 @@ static PyObject *pyrf_evlist__get_pollfd(struct p=
yrf_evlist *pevlist,
>  					 PyObject *args __maybe_unused,
>  					 PyObject *kwargs __maybe_unused)
>  {
> -	struct evlist *evlist =3D pevlist->evlist;
> -        PyObject *list =3D PyList_New(0);
> +	struct evlist *evlist;
> +	PyObject *list;
>  	int i;
> =20
> -	for (i =3D 0; i < evlist->core.pollfd.nr; ++i) {
> +	CHECK_INITIALIZED(pevlist->evlist, "evlist");
> +
> +	evlist =3D pevlist->evlist;
> +	list =3D PyList_New(0);
> +
> +	for (i =3D 0; i < evlist__core(evlist)->pollfd.nr; ++i) {

[Severity: High]
This is a pre-existing issue, but should the return value of PyList_New(0)
be checked for NULL? If allocation fails, the subsequent call to
PyList_Append() within the loop would receive a NULL pointer, which could
cause a crash.

[ ... ]
>  		PyObject *file;
> -		file =3D PyFile_FromFd(evlist->core.pollfd.entries[i].fd, "perf", "r",=
 -1,
> +		file =3D PyFile_FromFd(evlist__core(evlist)->pollfd.entries[i].fd, "pe=
rf", "r", -1,
>  				     NULL, NULL, NULL, 0);
>  		if (file =3D=3D NULL)
>  			goto free_list;

[Severity: Medium]
This isn't a bug introduced by this patch, but does jumping to the free_list
error label leak the newly allocated list object? It looks like
PyErr_NoMemory() is returned without a corresponding Py_DECREF(list).

[ ... ]
> @@ -1837,13 +1861,16 @@ static struct mmap *get_md(struct evlist *evlist,=
 int cpu)
>  static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
>  					  PyObject *args, PyObject *kwargs)
>  {
> -	struct evlist *evlist =3D pevlist->evlist;
> +	struct evlist *evlist;
>  	union perf_event *event;
>  	int sample_id_all =3D 1, cpu;
>  	static char *kwlist[] =3D { "cpu", "sample_id_all", NULL };
>  	struct mmap *md;
>  	int err;
> =20
> +	CHECK_INITIALIZED(pevlist->evlist, "evlist");
> +
> +	evlist =3D pevlist->evlist;

[Severity: High]
This is a pre-existing issue, but does pyrf_evlist__read_on_cpu() fail to
call perf_mmap__read_done() after processing the event? The function calls
perf_mmap__consume(), which advances the local reader state, but without
perf_mmap__read_done(), the kernel's ring buffer tail pointer is never
advanced. This could eventually cause the buffer to fill up and drop events.

> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> index 5307d707711d8..b75f9dcf4dbfe 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
[ ... ]
> @@ -2404,13 +2404,16 @@ int perf_event__synthesize_stat_events(struct per=
f_stat_config *config, const st
>  	}
> =20
>  	err =3D perf_event__synthesize_extra_attr(tool, evlist, process, attrs);
> -	err =3D perf_event__synthesize_thread_map2(tool, evlist->core.threads, =
process, NULL);
> +	err =3D perf_event__synthesize_thread_map2(tool, evlist__core(evlist)->=
threads,
> +						process, /*machine=3D*/NULL);

[Severity: Medium]
This isn't a bug introduced by this patch, but is the return value of
perf_event__synthesize_extra_attr() intentionally overwritten here? The
result is stored in err, but then immediately replaced by the call to
perf_event__synthesize_thread_map2() on the next line, causing the first
error to be discarded.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611171756.4008=
769-1-irogers@google.com?part=3D7
