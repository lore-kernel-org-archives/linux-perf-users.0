Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAF12F7EF4
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 17:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780595155; cv=none; b=uV5M7I7jTOzvhHsbuwkzZ2T/FWvEuJwLvzKzSrFiM3maDvKshEpKflawdxNqndYkpJHW+asC/9UuK8ZERbdhWJkBWk8+VGOjD/DEcd/s+pNQSsqBrXr3g74cOQGFfIQWG6OmPWHLaERK5blWZ2fXM0VGFPw9EbxRuBgzDRNf8Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780595155; c=relaxed/simple;
	bh=4/eklowOAWh0twVdCI/FZxvgr3gyEfqVEyfG+RJX/8Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ItUkzKU92MgF4cI9Kzf7+V5nahWRf6rTeGvHmJlsvvpdCQ4u0KUMxvZyUKMwVFBXn7wOHaerYsB7XOSAYT8HHUqHq5b9EWZ6d0eCkJQ6H/z/NHq/j3IlHsXZuC9sSrMR0LiEUtFewkozniUXnOByvSaKmEIWXT4LLqJHdfdLRaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSmZMNkC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSmZMNkC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC5D1F00893;
	Thu,  4 Jun 2026 17:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780595154;
	bh=OKL3R2kMY6/wQSLViinbqoHDnatqbvcsk0czIIEzjJk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TSmZMNkCrY3Jhu38D7mYCrHwPSdRDlRwWI8zcThvAWoM559T/owNAgY8gGowJbZOD
	 MOoO2yUZKZhXo/WtGJj+D8azXq9p0bpNLyLLuSkdMR/W26vS14BT3gRjbgzpz44qP2
	 uyLnYkiibSM7OP5SXiwgvc7PDabyQVI0OGvTW8vjcnhivTBNUXdHaKfpW5dBXEak9i
	 B0yqUBCopWSDPoUwGaGHL5mbrwFA+/Od5mvwJ78sd6OLQt5qlBr0/qshtg3yeDaL6f
	 UY86Rz80J2cJ/U+JvTac7YpOtDtLtcs3MVRycUoEoUvRLps9mjA4PMM0zX4ynWpUNV
	 0+Qif2gB64iSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/5] perf inject/aslr: Add ASLR tool infrastructure
 and MMAP tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260604172850.683329-3-irogers@google.com>
References: <20260604172850.683329-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 17:45:54 +0000
Message-Id: <20260604174554.7CC5D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Breakpoint addresses and register masks leak when `--itrace` is co=
mbined with `--aslr` in pipe mode due to missing attribute zeroing.
- [High] Auxiliary trace events (`auxtrace`, `auxtrace_info`, `auxtrace_err=
or`) are silently dropped when `--aslr` is used, breaking `--itrace` decodi=
ng.
--

commit 54e7ffb94c135676309f30095bfd44c906c79590
Author: Ian Rogers <irogers@google.com>

perf inject/aslr: Add ASLR tool infrastructure and MMAP tracking
   =20
If perf.data files are taken from one machine to another they may
leak virtual addresses and so weaken ASLR on the machine they are
coming from. Add an aslr option for perf inject that remaps all
virtual addresses, or drops data/events, so that the virtual address
information isn't leaked.

> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index d8cb1f562f690..a9f0a3901e7bc 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c

[ ... ]

> @@ -276,6 +295,8 @@ static int perf_event__repipe_attr(const struct perf_=
tool *tool,
> =20
>  	attr.size =3D sizeof(struct perf_event_attr);
>  	attr.sample_type &=3D ~PERF_SAMPLE_AUX;
> +	if (inject->aslr)
> +		attr.sample_type &=3D ASLR_SUPPORTED_SAMPLE_TYPE;

[Severity: High]
Does this alternative synthesis path for itrace also need to clear bp_addr,
sample_regs_user, and sample_regs_intr?

When perf inject is run in pipe mode with both the aslr and itrace options,
perf_event__repipe_attr takes this path. The non-itrace path correctly clea=
rs=20
the breakpoint addresses and register masks for ASLR sanitization, but this=
=20
path only masks the sample type.

Could this leak sensitive kernel virtual addresses encoded in breakpoint=20
attributes into the output stream, bypassing the ASLR protections?

> =20
>  	if (inject->itrace_synth_opts.add_last_branch) {
>  		attr.sample_type |=3D PERF_SAMPLE_BRANCH_STACK;

[ ... ]

> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> new file mode 100644
> index 0000000000000..be7280f884308
> --- /dev/null
> +++ b/tools/perf/util/aslr.c

[ ... ]

> +static s64 aslr_tool__process_auxtrace(const struct perf_tool *tool __ma=
ybe_unused,
> +				       struct perf_session *session,
> +				       union perf_event *event)
> +{
> +	if (perf_data__is_pipe(session->data)) {
> +		/* Copy behavior of the stub by reading all pipe data. */
> +		int err =3D skipn(perf_data__fd(session->data), event->auxtrace.size);
> +
> +		if (err < 0)
> +			return err;
> +	}
> +	return event->auxtrace.size;
> +}

[ ... ]

> +static void aslr_tool__init(struct aslr_tool *aslr, struct perf_tool *de=
legate)
> +{
> +	delegate_tool__init(&aslr->tool, delegate);
> +	aslr->tool.tool.ordered_events =3D true;

[ ... ]

> +	/*
> +	 * event_update, tracing_data, finished_round, build_id, id_index,
> +	 * auxtrace_info, auxtrace_error, time_conv, thread_map, cpu_map,
> +	 * stat_config, stat, feature, finished_init, bpf_metadata, compressed,
> +	 * auxtrace - no virtual addresses.
> +	 */
> +	aslr->tool.tool.auxtrace =3D aslr_tool__process_auxtrace;
> +	aslr->tool.tool.auxtrace_info =3D aslr_tool__process_auxtrace_info;
> +	aslr->tool.tool.auxtrace_error =3D aslr_tool__process_auxtrace_error;
> +}

[Severity: High]
Will overwriting the auxtrace delegate callbacks cause silent data loss?

The auxtrace, auxtrace_info, and auxtrace_error callbacks are overridden he=
re=20
with internal stubs. As seen in aslr_tool__process_auxtrace above, the stub=
=20
consumes the pipe data but returns without forwarding the event to the=20
delegate tool.

Does this mean raw hardware traces like Intel PT are silently dropped,=20
preventing them from reaching perf_event__process_auxtrace to generate=20
synthetic samples? This looks like it would break itrace decoding.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604172850.6833=
29-1-irogers@google.com?part=3D2
