Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792448790;
	b=fvlDejv4yNwbcNjNTN+GwO1Fg/tTanyLIaaqYxDsBwIQH8slNZjbyna3DATep0TrrWrf
	 3ajY0fFu0L+hvSdaV4FYvywjtFXt3g+c4HHqdM7/dKGwxHafS3qq5/rzSKTdunaFBlxFz
	 gly1TfrtYqCyCyz2GtbzPoyK9nGCZVPTtwXEs7nTquOVrfX9C1KjMRzYoFeYo34fzd14d
	 xg1h+JIY+8mxN03g3OrpwoVEuHP7snNHn2DlvWkm5M/w1jRuhWDN2ot0xPDt64JJ4VZmJ
	 PwC2tBV+X+alFds7m4f5QWrE41+ybDKS4jW7fF9YTOrgeumbdRGFd7DcEOnNNXN6gWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792448790;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dTtnaT78ro5AZgqgliMkSL6eOPrjhw6DZO8r93iQ7J4=;
	b=RbTntP3WjK51KiTwWq6/5tmwR+fWP1OO0endUy4VIUtXv4LAWRkFUtN9vdooGcjUnQiR
	 XzI2HvoveNxsQtnhJUrfw6/gVTQQdT3bATXH6hJYsuanxMW55EUMoGxq7Fs9gG6hL5AcR
	 yotwGagDhkj2bKiw4zFgI4lX84OrEJxg9JBgB4yHK0OKRbjEaJR1NJrobl60hbwDgtPxH
	 1FLaatehFPYo6VyCW7qFMCQX22yjah2CXdh1lm3f0giVIbfMjbur4Bmyr5xPTZrqac/dt
	 KofsRhvWTMxaP0coLhYoArNr9QW2NzQ4rLT041Ibk62Y1Dz/u8JhRvf5S2cINmqv+Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gySsT5Pe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8A9606A31B
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 22:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gySsT5Pe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B117B1F000C4;
	Mon, 19 Oct 2026 22:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792448789;
	bh=dTtnaT78ro5AZgqgliMkSL6eOPrjhw6DZO8r93iQ7J4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gySsT5PeLb5+NF8mmqxaHYV2LRmLBpBVtLdnlNf8gXzUMJhMsvDbomjUwUtIBhoZG
	 cgMp0A3q8THZnBHnp3jjCAEGUOUSBPZuUARIoEBcrlNVjPMipVoCWBSe8ly2sAhcMo
	 2PhY2M2LkY3tFYuQJW0SrSSLbHyhy9kynyZqcQPqCbBIkc9R6L32w/sffsAma6CEWH
	 MlXkL9uBnPUrjQ6Q/HQiJbk5DoXqgCcCbukB/CjR0gGsWpKCDDsdLIFkYslxYbbB8M
	 lpFz59+n9cc2IBVCVS/4xhZvpHi43L9RtUYOCESmzJsDSfsG8OpbthIogg09WGIouM
	 RAHKdx43yGphQ==
Message-ID: <sashiko-outbox-178318@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/7] perf bpf-filter: Support BPF sample filters on
 tracepoint events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261019220915.3943592-3-irogers@google.com>
References: <20261018053710.2572636-1-irogers@google.com>
 <20261019220915.3943592-1-irogers@google.com>
 <20261019220915.3943592-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 22:26:29 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf bpf-filter: double close of tracepoint fd via perf_bpf_filt=
er__prepare()
- [Medium] perf bpf-filter: missing tracepoint BPF terms in is_possible_tp_=
filter()
--

commit d87f98375f9a6f9592030472ebfbf88f3edd6fdd
Author: Ian Rogers <irogers@google.com>

perf bpf-filter: Support BPF sample filters on tracepoint events

This commit adds a tracepoint BPF program (perf_tp_sample_filter) to
evaluate context-independent filter terms (uid, gid, tid, cpu, time,
cgroup) on PERF_TYPE_TRACEPOINT events, and attaches it once to the
shared trace_event_call in perf_bpf_filter__prepare().

> diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
> index 72e83ac1d6a4b..4e99af4764f1d 100644
> --- a/tools/perf/util/bpf-filter.c
> +++ b/tools/perf/util/bpf-filter.c
> @@ -123,15 +123,26 @@ static int check_sample_flags(struct evsel *evsel, =
struct perf_bpf_filter_expr *
>  {
>  	const struct perf_sample_info *info;
> =20
> -	if (expr->term >=3D PBF_TERM_SAMPLE_START && expr->term <=3D PBF_TERM_S=
AMPLE_END &&
> -	    (evsel->core.attr.sample_type & (1 << (expr->term - PBF_TERM_SAMPLE=
_START))))
> -		return 0;
> -
>  	if (expr->term =3D=3D PBF_TERM_UID || expr->term =3D=3D PBF_TERM_GID) {
>  		/* Not dependent on the sample_type as computed from a BPF helper. */
>  		return 0;
>  	}
> =20
> +	if (evsel->core.attr.type =3D=3D PERF_TYPE_TRACEPOINT) {
> +		if (expr->term =3D=3D PBF_TERM_TID || expr->term =3D=3D PBF_TERM_CPU ||
> +		    expr->term =3D=3D PBF_TERM_TIME || expr->term =3D=3D PBF_TERM_CGRO=
UP)
> +			return 0;

[Severity: Medium]
Can standalone tracepoint BPF filters using gid, tid, pid, cpu, time, or
cgroup actually reach perf_bpf_filter__parse() from --filter?

In tools/perf/util/parse-events.c, set_filter() checks
is_possible_tp_filter(str) before deciding whether to route a
PERF_TYPE_TRACEPOINT filter to evsel__append_tp_filter() or
perf_bpf_filter__parse():

tools/perf/util/parse-events.c:is_possible_tp_filter() {
	return strstr(str, "uid") =3D=3D NULL;
}

tools/perf/util/parse-events.c:set_filter() {
	...
	if (evsel->core.attr.type =3D=3D PERF_TYPE_TRACEPOINT && is_possible_tp_fi=
lter(str)) {
		if (evsel__append_tp_filter(evsel, str) < 0) {
	...
}

Because is_possible_tp_filter() only checks for "uid" in this commit,
passing --filter 'gid =3D=3D 0' or --filter 'cpu =3D=3D 0' on a tracepoint =
event
routes the expression to the ftrace tracepoint predicate filter via
evsel__append_tp_filter(), which fails with -EINVAL in
PERF_EVENT_IOC_SET_FILTER when the tracepoint lacks matching format fields.

Although a later commit in the series ("perf bpf-filter: Add lock_held()
sample filter") adds "gid" and "lock_held" to is_possible_tp_filter(), the
tid, pid, cpu, time, and cgroup terms supported here in check_sample_flags()
and perf_get_common_sample() still remain unrouted to perf_bpf_filter__pars=
e()
unless combined with uid, gid, or lock_held in the same filter string.

Should is_possible_tp_filter() also check for gid, tid, pid, cpu, time, and
cgroup?

> +		if (expr->op !=3D PBF_OP_GROUP_BEGIN) {
> +			pr_err("Error: %s tracepoint event does not support BPF sample term %=
d\n",
> +			       evsel__name(evsel), expr->term);
> +			return -1;
> +		}
> +	}

[ ... ]

> @@ -501,15 +528,35 @@ int perf_bpf_filter__prepare(struct evsel *evsel, s=
truct target *target)
>  		goto err;
>  	}
> =20
> -	prog =3D skel->progs.perf_sample_filter;
> -	for (x =3D 0; x < xyarray__max_x(evsel->core.fd); x++) {
> -		for (y =3D 0; y < xyarray__max_y(evsel->core.fd); y++) {
> -			link =3D bpf_program__attach_perf_event_opts(prog, FD(evsel, x, y),
> -								   &pe_opts);
> -			if (IS_ERR(link)) {
> -				pr_err("Failed to attach perf sample-filter program\n");
> -				ret =3D PTR_ERR(link);
> -				goto err;
> +	if (is_tracepoint) {
> +		/*
> +		 * For PERF_TYPE_TRACEPOINT, PERF_EVENT_IOC_SET_BPF attaches the
> +		 * BPF program to event->tp_event->prog_array on the shared
> +		 * trace_event_call, which perf_trace_run_bpf_submit() executes
> +		 * for all CPUs and tasks before iterating the per-CPU perf
> +		 * events. Attach once on the first FD so tp_event->prog_array
> +		 * does not get duplicate copies for each per-CPU FD.
> +		 */
> +		prog =3D skel->progs.perf_tp_sample_filter;
> +		link =3D bpf_program__attach_perf_event_opts(prog, FD(evsel, 0, 0),
> +							   &pe_opts);
> +		ret =3D libbpf_get_error(link);
> +		if (ret) {
> +			pr_err("Failed to attach perf tracepoint sample-filter program\n");
> +			goto err;
> +		}
> +		skel->links.perf_tp_sample_filter =3D link;

[Severity: Medium]
Does storing link in skel->links.perf_tp_sample_filter cause FD(evsel, 0, 0)
to be closed twice during teardown?

In tools/lib/bpf/libbpf.c, bpf_program__attach_perf_event_opts() takes
ownership of the passed perf_event_fd without duplicating it, and its
detach callback closes that descriptor when the bpf_link is destroyed:

tools/lib/bpf/libbpf.c:bpf_link_perf_detach() {
	struct bpf_link_perf *perf_link =3D container_of(link, struct bpf_link_per=
f, link);
	int err =3D 0;

	if (ioctl(perf_link->perf_event_fd, PERF_EVENT_IOC_DISABLE, 0) < 0)
		err =3D -errno;

	if (perf_link->perf_event_fd !=3D link->fd)
		close(perf_link->perf_event_fd);
	close(link->fd);
	...
}

During teardown (for example in evlist__put()), evlist__close() closes all
descriptors in evsel->core.fd, including FD(evsel, 0, 0), before
evlist__purge() destroys the evsels:

evlist__put()
  -> evlist__close()
       -> perf_evsel__close_cpu()
            -> perf_evsel__close_fd_cpu()  /* closes FD(evsel, 0, 0) */
  -> evlist__purge()
       -> evsel__put()
            -> evsel__exit()
                 -> perf_bpf_filter__destroy()
                      -> sample_filter_bpf__destroy()
                           -> bpf_link__destroy(skel->links.perf_tp_sample_=
filter)
                                -> bpf_link_perf_detach()  /* ioctls and cl=
oses FD(evsel, 0, 0) again */

In the non-tracepoint branch below, the returned link is not stored in
skel->links, or if skel->links.perf_tp_sample_filter is kept, should
FD(evsel, 0, 0) be duplicated before passing it to
bpf_program__attach_perf_event_opts()?

[ ... ]

>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019220915.3943=
592-1-irogers@google.com?part=3D2
