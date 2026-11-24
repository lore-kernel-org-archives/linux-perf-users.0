Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546962;
	b=iWPUfv0deEhy4guMCf5G5R4HAEAg51FJPWkiscRUUbgQR86JUaNQH9K8JDW+CGsmevjj
	 vZIzpAWeIsQL8wgtBPdpZRkOrPR1dYcC/q5Zo9bkOfQSomXumA7eUrQxFJyIOLsyccgy9
	 6VIdcP5rIJ3P/sGMD9HBroSTfD5xXYkDlS2hEgMG/Q+xce1O9ScPCEGJT6SQw0ioYc/Cs
	 SlVdXi6ISBiSGIEzyCDsyiDHVDYZoXZCW6mjrhoXLlVRKnTIzd9O+D/I0UjFlnl6Ka+Pn
	 59IKD0oMwe2fgDha3XkZ+GPHSMgavb66ED2KpHrT+V/lCj8C/5VaKDRPjfPpbfoWU7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546962;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3Va2r8LemA4Gi7AT8k19KX9tcxRrGr4JhkPhPNeNJTU=;
	b=xF7soKPwFZhY3gPkBnIYSnKvyeXLdcd7s/+XyrTod8hR+YjnWh6yX+YATDr3lbN9aWj1
	 FXg0j2jntlYmKUvPG7yaMmSFtKP2EJ5Y1eg+Ph7JnR9lPIuwHlNGKzpUKTt7KYuIw5rjn
	 G8J85bsc99GWj6bt1CRJyIT5qnJSIuurpIQE0e4XDFJbo1LTvuRmLTw+7846Vx77iqN8F
	 RAtsI6J3Xm4BRoN5pBINfWHonTUKi2/j2JlX4Jd8FrQaduIIona1ZwPXli3DmiWpSZ3jy
	 DFa+8KkZ8rF4DsRu9Crio5cLObgfEdSQ8rShIYJ+Ijw5NoimDep/hMY0qNL49N2xIKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c7SlTj4c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4731E606A31E
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 19:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c7SlTj4c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57EAE1F000CF;
	Tue, 24 Nov 2026 19:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795546956;
	bh=3Va2r8LemA4Gi7AT8k19KX9tcxRrGr4JhkPhPNeNJTU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c7SlTj4cXOQv2dBI80nRJzbTpGRgV99tGyyLgvborrkab6Uuzc6l0fOkYx4XROf/R
	 hAW+Mt1GM7N7pPajLjIOUc0rBYOr3tK2+KGRA5Y4gcwYHySYtXKfKKvR5D0da6EaGL
	 Pl9nYMkvJu1utPkeD83l3VLKkDA+TxFQqJDiZTpoHfu0I2S+gxsXYLGxDdnLpQLqBL
	 uoQlVberk8NJtybyfA0CHRwvkVJeelPedEpWuL75Cub/M/uKvk0FuGf1BIxCNiI8uR
	 9Ydj/fIIOZPbHFwhgBmlc7XPEVJqz9eijP1qP3C9LUG//UrY81QBkDErqxhfrs1oiC
	 z9V1VKlfv8yYA==
Message-ID: <sashiko-outbox-231872@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 11/17] perf tests trace: Exercise the tracing options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261124184604.24983-12-acme@kernel.org>
References: <20261124184604.24983-1-acme@kernel.org>
 <20261124184604.24983-12-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 19:02:35 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] perf tests trace: multiple -e syscall flags overwrite
  ev_qualifier
- [Low] perf tests trace: missing bpf_skeletons check before -u uid
  subtest
--

commit 8d2dfbecd217c63b535805ea0723b5374531748c
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tests trace: Exercise the tracing options

This commit adds a shell test exercising various perf trace command-line
options including page faults, scheduler stats, summaries, and filters.

> diff --git a/tools/perf/tests/shell/trace_options.sh b/tools/perf/tests/s=
hell/trace_options.sh
> new file mode 100755
> index 0000000000000..3f686a293bb9d
> --- /dev/null
> +++ b/tools/perf/tests/shell/trace_options.sh
> @@ -0,0 +1,97 @@

[ ... ]

> +run_trace "syscalls" "" --syscalls -- true
> +run_trace "events" "openat" -e openat -e read -e write -- cat /dev/null

[Severity: Medium]
Does passing separate -e flags for syscalls cause "openat" and "read" to
be overwritten by "write", failing the grep for "openat"?

Each -e syscall flag calls trace__parse_events_option(), which overwrites
trace->ev_qualifier with strlist__new() and calls
trace__validate_ev_qualifier() to allocate a new
trace->ev_qualifier_ids.entries array without preserving earlier entries:

tools/perf/builtin-trace.c:trace__parse_events_option() {
    ...
		trace->ev_qualifier =3D strlist__new(lists[1], &slist_config);
		if (trace->ev_qualifier =3D=3D NULL) {
			fputs("Not enough memory to parse event qualifier", trace->output);
			goto out;
		}

		if (trace__validate_ev_qualifier(trace))
			goto out;
    ...
}

Only "write" remains enabled in trace->ev_qualifier_ids, so openat is
filtered out and the test fails.  Passing a comma-separated list (-e
openat,read,write) or accumulating syscall qualifiers across multiple -e
options would avoid this.

[ ... ]

> +run_trace "no inherit" "" --no-inherit -- sleep 0.1
> +run_trace "uid" "" -u "$(id -un)" -- true

[Severity: Low]
Will the "uid" subtest fail when perf is built without BPF skeleton
support?

In cmd_trace(), -u calls parse_uid_filter(trace.evlist, uid) before
trace__run() populates non-BPF syscall tracepoints.  parse_uid_filter()
applies a BPF sample filter to the last evsel in trace.evlist via
perf_bpf_filter__parse(), which fails when HAVE_BPF_SKEL is disabled or
augmented_syscalls__prepare() cannot load the skeleton.  Guarding this
subtest with "perf check feature -q bpf_skeletons" would avoid false
failures on builds without BPF skeletons.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124184604.2498=
3-1-acme@kernel.org?part=3D11
