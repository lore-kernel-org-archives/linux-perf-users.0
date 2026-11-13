Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602822;
	b=e7RIXDvmAaVGfAscgvPJjz2S9a8AI3IMriIfopmJL60FLRqxnwBQpbRqSBpmobRW7Tuq
	 D1ApVDqZ4hOYtPSifkbbREMNVFGdVAetlP1E15HvU3w8njQKaylpFSSpKFWrTaazs0AZS
	 RH+nc+AGk7El8UxJ42tJgBm7yTpVDtjl/QbMkrWgtycUWinOgEG5KzAeucGplANIx+h+t
	 wVnicwEU2wfdtH/Mey0UauVK9rEkXo5aNb8F1A3A7f4zv8++R3yNB0xk+QSa28zTzGV34
	 ftpyFtHUXAFno/zKhWWiXgG6eZhs8P03anUfsAEaNt6zNiOmWNC1CFuXmU4gkKNH4wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602822;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eW48Pr7ypqvWUXYKdS7R9JQzCpcpPGZqNBoHi2M9jPs=;
	b=ldvPfaoByb37aH+NoyffgDImwBMQ1sPbpkhHCPgqi/df6eN3Z28yO5FjRwUK2VCUnkTl
	 pIzDmecW092E5Z6HinJ0v+XK9W/V2OgTNRBVbDp1BRsiQarBdYLwL3+e6GVGKzY8ZWWxK
	 adoOy2BvMcKa09j9U884JB7aWvbW4vk2bT9X/E3Fcd5PjeINltmeJlTGBW8/tBol16qpB
	 TnNCuiMe/5Mmz43eE51ti9w+WXAAF7hdECooiR2p2QoLFsiirrm70duij8eMJHLCVJj8O
	 hYTvmWZY5pMyoC2PoTKOaBM0JBRxOAgH09y4JeBBwzCOyMXi3sMOBf4EmJ/ehhLQk8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RlO+cwAR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83BF606A338
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RlO+cwAR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADDB1F000C4;
	Fri, 13 Nov 2026 20:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794602821;
	bh=eW48Pr7ypqvWUXYKdS7R9JQzCpcpPGZqNBoHi2M9jPs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RlO+cwARtFIG0mRIuvpou7qK1ezc2zJnGUvDcMJrUdMAj4Mv/XrHtVwDVxz4wUHQj
	 8uUhKtiqd8eYQXmWZlB8CQN7jwFWfn33LB978ovbXPBu5wiKHGr9cJSisQ+1ilEhyv
	 xPsO87QrHHIsb1V60NwAx1e0y+33TQ+6poOn2ecYFpsOjCMZYC7ODOSdOjKczkI1rj
	 WaVNZCZUErhMiLTsz8boWL4uGITUf1ug1K5q2IkhYsV078vRCklUrmkp3U67xGMVxC
	 soynH1uhU1A0WkZkIWpsJ0Ll0dwrrWPY7s+T6jNAsBkY7ARIrkF3fudJnisl7yt/gP
	 GCuYOOsNNCpjg==
Message-ID: <sashiko-outbox-213677@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/30] perf env: Add host_env() singleton
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113195335.2865725-7-irogers@google.com>
References: <20261113195335.2865725-1-irogers@google.com>
 <20261113195335.2865725-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:47:01 +0000
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
- [Medium] perf header: write_cmdline() conditional host_env() fallback
  corrupts perf inject HEADER_CMDLINE
- [Low] perf trace: direct cmd_trace() call in main() skips host_env()
  setup/exit
--

commit 514f7c0886cdcd7ffafc72b5f2dce5946ffe0612
Author: Ian Rogers <irogers@google.com>

perf env: Add host_env() singleton

This commit introduces a statically initialized host_env() singleton to
represent the live host environment and drops the struct perf_env *
parameter from machine__new_host(), machine__new_kallsyms(),
machine__new_live(), and __perf_session__new().

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 4094141461f91..fb02fa6dd4377 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
[ ... ]
> @@ -2121,20 +2120,14 @@ static char *trace__machine__resolve_kernel_addr(=
void *vmachine, unsigned long l
>  	return machine__resolve_kernel_addr(vmachine, addrp, modp);
>  }
> =20
> -static int trace__symbols_init(struct trace *trace, int argc, const char=
 **argv,
> -			       struct evlist *evlist)
> +static int trace__symbols_init(struct trace *trace, struct evlist *evlis=
t)
>  {
>  	int err =3D symbol__init(NULL);
> =20
>  	if (err)
>  		return err;
> =20
> -	perf_env__init(&trace->host_env);
> -	err =3D perf_env__set_cmdline(&trace->host_env, argc, argv);
> -	if (err)
> -		goto out;
> -
> -	trace->host =3D machine__new_host(&trace->host_env);
> +	trace->host =3D machine__new_host();
>  	if (trace->host =3D=3D NULL) {
>  		err =3D -ENOMEM;
>  		goto out;
> @@ -2155,10 +2148,8 @@ static int trace__symbols_init(struct trace *trace=
, int argc, const char **argv,
>  					    /*mmap_data=3D*/false,
>  					    /*nr_threads_synthesize=3D*/1);
>  out:
> -	if (err) {
> -		perf_env__exit(&trace->host_env);
> +	if (err)
>  		symbol__exit();
> -	}
>  	return err;
>  }
> =20
> @@ -2167,7 +2158,6 @@ static void trace__symbols__exit(struct trace *trac=
e)
>  	machine__delete(trace->host);
>  	trace->host =3D NULL;
> =20
> -	perf_env__exit(&trace->host_env);
>  	symbol__exit();
>  }
[ ... ]
> diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> index d60bc929c2572..bcbc12295a387 100644
> --- a/tools/perf/perf.c
> +++ b/tools/perf/perf.c
> @@ -380,12 +381,14 @@ static int run_builtin(const struct cmd_struct *p, =
int argc, const char **argv)
>  		use_pager =3D 1;
>  	commit_pager_choice();
> =20
> +	perf_env__set_cmdline(host_env(), argc, argv);
>  	status =3D p->fn(argc, argv);
>  	perf_config__exit();
>  #ifdef HAVE_LIBTRACEEVENT
>  	trace_event__exit();
>  #endif
>  	exit_browser(status);
> +	perf_env__exit(host_env());
> =20
>  	if (status)
>  		return status & 0xff;

[Severity: Low]
Does moving perf_env__set_cmdline() and perf_env__exit() from
trace__symbols_init() and trace__symbols__exit() into run_builtin() miss
the direct cmd_trace() invocation in main()?

tools/perf/perf.c:main() {
	...
	if (strstarts(cmd, "trace")) {
		setup_path();
		argv[0] =3D "trace";
		return cmd_trace(argc, argv);
	}
	...
}

When invoked via the trace alias, main() calls cmd_trace() directly
without going through run_builtin(), leaving host_env()->cmdline_argv
unpopulated for trace record and skipping perf_env__exit(host_env()) on
exit.

[ ... ]

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 9eec6deee190f..b6f86f557cafe 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -670,6 +670,9 @@ static int write_cmdline(struct feat_fd *ff,
>  	char pbuf[MAXPATHLEN], *buf;
>  	int i, ret, n;
> =20
> +	if (!env->cmdline_argv)
> +		env =3D host_env();
> +
>  	/* actual path to perf binary */
>  	buf =3D perf_exe(pbuf, MAXPATHLEN);
> =20

[Severity: Medium]
Can checking !env->cmdline_argv here corrupt HEADER_CMDLINE when perf
inject regenerates the output header?

When perf inject reads the input perf.data header, process_cmdline()
populates ff->ph->env.cmdline_argv from the input file, with the perf
binary path already stored at cmdline_argv[0].  Because keep_feat()
returns false for HEADER_CMDLINE, perf_session__inject_header() calls
write_cmdline() to update the feature section.  With env->cmdline_argv
already non-NULL, write_cmdline() will not switch to host_env(), so it
reuses the input file's command line instead of recording the perf inject
invocation and prepends perf_exe() a second time.  As noted above,
invoking trace directly via main() -> cmd_trace() also bypasses
perf_env__set_cmdline(host_env(), ...), leaving host_env()->cmdline_argv
NULL when write_cmdline() falls back to host_env().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113195335.2865=
725-1-irogers@google.com?part=3D6
