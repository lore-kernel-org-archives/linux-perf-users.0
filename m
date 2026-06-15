Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DF11C861D
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 00:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781484345; cv=none; b=auojCQiQNAxELQqQz+Fg4Z0ZzfcSgNuhWEY5lk6JkGHdQLg5TvKBbk7WVh4L8U+lhssI7rkPbxFMI5WJX7vQxG6S0NeIHBo9+kIV7qHRI95xpenhYYNNXSG6vwGwi/P6DMjzvLR6GDbvWtvxz7DUxIEYHcTLIvf9XSFRAvb68Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781484345; c=relaxed/simple;
	bh=zXrnDlMRMDxw2a7ybhex6oTV623f+5hJ2t4LTOk9zfs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hwsI4orJ2lJNVA9j18vAE3JCvQG6bGpp2rEKi82pHfV2aGlTtAM2D3GYb/9ud7kb4sEiLMWbjPn31ob+5XxLmaxP+ifXTY3vg6ELvBd8B4mKv6qj6eReQ3kuz52zQEFLn/Qn8s3pFX1sBcgEvILr7/2naOeEOQ/vY0hA0WMAPEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mo7FcTNu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mo7FcTNu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14F71F000E9;
	Mon, 15 Jun 2026 00:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781484343;
	bh=0QIa9mFzG/2jxCXazNbal1Hbt0cEbhBM4evzSTael4Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mo7FcTNuixnqOrLL0SYU+Ys8n1E4KtTemdJJ6VJaV1aDZVneK/p4X4E+ZAggTDKL8
	 V+yN3RIa2xJ0cwlM5S+cEs2+Drdl89zdWWFrHwGAooYVMSwftlsyP5OKBvnO3wxNq5
	 DctlA/2yiwOvtJMrudQxRzAJ8M/uzKhLCi0QofHWpq9Gty8IMUzGypK2ntasPKlDka
	 hcedk292u2mdYIxv4MUacD8B0fkY4s6wd6Yz8/XaCMHTcSwyyu+lsqFFjbRnlcKNvB
	 jTracXBCTUxzBKCVHHAnhc3V+nUR34bjtx2KSsfR9Qma2lTZIJC3Lv7D3vlaHzITjn
	 Mk1b0f7BjLq7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 07/20] perf evlist: Add reference count checking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615002812.2234795-8-irogers@google.com>
References: <20260615002812.2234795-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 00:45:43 +0000
Message-Id: <20260615004543.D14F71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

New issues:
- [Critical] Asymmetric lockless cycle detection in `evlist__put` causes me=
mory leaks, and a TOCTOU race causes double-frees.

Pre-existing issues:
- [High] `data_offset` is used uninitialized in `perf_session__data_offset(=
)`.
- [High] `pthread_join()` is called on an uninitialized `pthread_t` if `evl=
ist__add_bpf_sb_event()` fails in `record__setup_sb_evlist()`.
- [Medium] `metric_evlist` is permanently leaked on error paths in `script_=
find_metrics()`.
- [Medium] `evlist` handles and memory are leaked in multiple error paths i=
nside Python bindings.
- [Medium] Leak of `evsel_list` in `cmd_stat()` when delegating to `record`=
 or `report` commands.
- [Medium] Leak of `top.sb_evlist` in `cmd_top()` on BPF event initializati=
on failure.
- [Medium] Missing `Py_DECREF()` on Python list in `pyrf_evlist__get_pollfd=
` error path.
--

commit 2fc962400b34423645a98a19d6da18b8f0a9d7f5
Author: Ian Rogers <irogers@google.com>

perf evlist: Add reference count checking

This patch introduces reference count checking to the evlist structure=20
to ensure get and put operations are correctly paired. It replaces=20
direct access with accessor functions across the perf tooling.

> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 1721a2470fb67..eb7c0d7be064e 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -206,23 +213,44 @@ static void evlist__exit(struct evlist *evlist)
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
> =20
> +	if (count !=3D 0) {
> +		/*
> +		 * Not the last reference except for back references from
> +		 * evsels.
> +		 */
> +		RC_CHK_PUT(evlist);
> +		return;
> +	}
> +out_delete:

[Severity: Critical]
Does this lockless cycle detection introduce a TOCTOU race condition?
If two threads concurrently drop their references and the evlist refcount
drops to equal the internal evsel back-references, both threads could
observe count =3D=3D 0 and proceed to out_delete, causing a double-free.

Also, is there an asymmetry here? When the final external reference to
an evsel is later dropped via evsel__put(), there doesn't appear to be
a cycle collection mechanism, which might permanently leak both the evsel
and the evlist.


> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 0df13927001b0..47afd8cdc2b77 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2229,9 +2229,10 @@ static int script_find_metrics(const struct pmu_me=
tric *pm,
>  	evlist__for_each_entry(metric_evlist, metric_evsel) {
>  		struct evsel *script_evsel =3D
>  			map_metric_evsel_to_script_evsel(script_evlist, metric_evsel);
> -		struct metric_event *metric_me =3D metricgroup__lookup(&metric_evlist-=
>metric_events,
> -								     metric_evsel,
> -								     /*create=3D*/false);
> +		struct metric_event *metric_me =3D
> +			metricgroup__lookup(evlist__metric_events(metric_evlist),
> +					    metric_evsel,
> +					    /*create=3D*/false);
> =20
>  		if (script_evsel->metric_id =3D=3D NULL) {
>  			script_evsel->metric_id =3D metric_evsel->metric_id;

[Severity: Medium]
This is a pre-existing issue, but does script_find_metrics() leak the
metric_evlist on error paths?

If metric parsing fails or a matching evsel leader is not found, the code
jumps directly to the out label, skipping evlist__put(metric_evlist) and
permanently leaking the evlist and its contents:

tools/perf/builtin-script.c:script_find_metrics() {
    ...
    if (!script_evsel) {
        pr_debug("Skipping metric '%s'...");
        goto out;
    }
    ...
out:
    return 0;
}


> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index e163621769866..d8691a8c1c9de 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -4611,7 +4611,7 @@ int perf_session__write_header(struct perf_session =
*session,
>  					     /*write_attrs_after_data=3D*/false);
>  }
> =20
> -size_t perf_session__data_offset(const struct evlist *evlist)
> +size_t perf_session__data_offset(struct evlist *evlist)
>  {
>  	struct evsel *evsel;
>  	size_t data_offset;
> =20
>  	evlist__for_each_entry(evlist, evsel) {
>  		data_offset +=3D evsel->core.ids * sizeof(u64);
>  	}
> -	data_offset +=3D evlist->core.nr_entries * sizeof(struct perf_file_attr=
);
> +	data_offset +=3D evlist__nr_entries(evlist) * sizeof(struct perf_file_a=
ttr);
> =20
>  	return data_offset;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but is data_offset used
uninitialized here?

It is declared without initialization and immediately used as an accumulator
in the evlist__for_each_entry loop. This could result in the function
returning garbage values and corrupting the perf.data file structure.


> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 5482b68b8c0b3..58d8644bf06a1 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -1782,13 +1796,18 @@ static PyObject *pyrf_evlist__get_pollfd(struct p=
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
>  		PyObject *file;
> -		file =3D PyFile_FromFd(evlist->core.pollfd.entries[i].fd, "perf", "r",=
 -1,
> +		file =3D PyFile_FromFd(evlist__core(evlist)->pollfd.entries[i].fd, "pe=
rf", "r", -1,
>  				     NULL, NULL, NULL, 0);
>  		if (file =3D=3D NULL)
>  			goto free_list;

[Severity: Medium]
This is a pre-existing issue, but does the error path in
pyrf_evlist__get_pollfd() miss a Py_DECREF() on the Python list?

If PyFile_FromFd() fails, the code jumps to the free_list label which
returns PyErr_NoMemory() without calling Py_DECREF(list), leaking the
newly allocated Python list object.


> @@ -2297,7 +2335,7 @@ static PyObject *pyrf__parse_events(PyObject *self,=
 PyObject *args)
>  	cpus =3D pcpus ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
> =20
>  	parse_events_error__init(&err);
> -	perf_evlist__set_maps(&evlist->core, cpus, threads);
> +	perf_evlist__set_maps(evlist__core(evlist), cpus, threads);
>  	if (parse_events(evlist, input, &err)) {
>  		parse_events_error__print(&err, input);

[Severity: Medium]
This is a pre-existing issue, but do pyrf__parse_events() and
pyrf__parse_metrics() leak evlist handles on error paths?

Both functions allocate an evlist via evlist__new(), but if
PyArg_ParseTuple() or subsequent parsing functions fail, they return NULL
or PyErr_NoMemory() without dropping the evlist reference via evlist__put().


> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index bf621202da697..3f897b2e86386 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2651,7 +2655,7 @@ int cmd_stat(int argc, const char **argv)
>  		stat_config.csv_sep =3D DEFAULT_SEPARATOR;
> =20
>  	if (affinity_set)
> -		evsel_list->no_affinity =3D !affinity;
> +		evlist__set_no_affinity(evsel_list, !affinity);
> =20
>  	if (argc && strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
>  		argc =3D __cmd_record(stat_options, &opt_mode, argc, argv);

[Severity: Medium]
This is a pre-existing issue, but does cmd_stat() leak the evsel_list when
delegating to the record or report commands?

The evsel_list is allocated via evlist__new() at the start of the function,
but if the command delegates to __cmd_record or __cmd_report, it directly
returns the result without freeing evsel_list.


> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index ff24ae35c67fc..5933c46ee137e 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1797,7 +1797,7 @@ int cmd_top(int argc, const char **argv)
>  		top.session =3D NULL;
>  		goto out_put_evlist;
>  	}
> -	top.evlist->session =3D top.session;
> +	evlist__set_session(top.evlist, top.session);
> =20
>  	if (setup_sorting(top.evlist, perf_session__env(top.session)) < 0) {
>  		if (sort_order)

[Severity: Medium]
This is a pre-existing issue, but does cmd_top() leak top.sb_evlist on BPF
event initialization failure?

If evlist__add_bpf_sb_event() fails, it jumps to out_put_evlist, which
puts top.evlist but neglects to put top.sb_evlist.


> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index e4fa77a40dacb..ebd3ed0c9b3e8 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -2544,7 +2545,7 @@ static int __cmd_record(struct record *rec, int arg=
c, const char **argv)
>  	 * because we synthesize event name through the pipe
>  	 * and need the id for that.
>  	 */
> -	if (data->is_pipe && rec->evlist->core.nr_entries =3D=3D 1)
> +	if (data->is_pipe && evlist__nr_entries(rec->evlist) =3D=3D 1)
>  		rec->opts.sample_id =3D true;
> =20
>  	if (rec->timestamp_filename && perf_data__is_pipe(data)) {

[Severity: High]
This is a pre-existing issue, but is it possible for pthread_join() to be
called on an uninitialized thread ID during cleanup in __cmd_record()?

If evlist__add_bpf_sb_event() fails in record__setup_sb_evlist(), it
returns an error without setting opts->no_bpf_event =3D true. The cleanup
path in __cmd_record() then falls through and invokes
evlist__stop_sb_thread(), which calls pthread_join() on the
zero-initialized sb_thread.th.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615002812.2234=
795-1-irogers@google.com?part=3D7
