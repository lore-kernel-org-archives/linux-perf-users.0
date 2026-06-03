Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAC42147E5
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 01:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780449368; cv=none; b=Fu0SYqVzrcyhcvXsroBeQGXVrQ6hQv++hF8+8nl4DIpw8907PVzDb6EeN2nBmxtIrf9pa+U8FovySMbZvaUBVQJ2QXKL+SbcxnYXEmLv7RVT0TU/pvfI8GGIdcT6V7JdcWGO+kq0Cppsw7JkF4R0PSasNSkcnYxCZNlDuT4WdEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780449368; c=relaxed/simple;
	bh=01bbdxlxE6InmTwxksKa0ArlDCXgCGlLaUIDmTDE+Fo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KVkT2J0boDn0Se6YCCjUgAZafZ1lyKkfz8R5nar5O/xywx3IU8rEZPFzs987jwYReNGksxLuhVoDTBSOmrhVCudhzMXtbNut8b2Vb+b1jl+eCGXZkthIc9AiHBB64pmletmF8zFW9IQ+fkR4eDRzXOlkEg8XIgVdf51lDRgy/ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAolILcl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAolILcl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CA41F00893;
	Wed,  3 Jun 2026 01:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780449366;
	bh=dUg3rUPZkJTttr7Vb2KYcMdA9gvpy8nu8f/dtdzQtO8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CAolILcl7F0s4e4rGJUZszPtrPH7Ay68TgxrVG0xdFMRcW/cbEQ1Vr0ll0r6VnqWh
	 zQf83vZBMgQSjxD9zIQuWOMQYoKiBk1wbPGvNdw2iPatMIltYOxVM1Kbn2qRbEBSUB
	 FINtQ3m/a02q43m3xYZJJaE9dkNR22UbBIo4XmejOUR79mjhaaSIKEUSGujPfiJBXC
	 I5GrQI08+B+LCwYIEOw4VdJ23KLzvkbquVwBaqINHhWhbycePhbwjE2PblMCAXnM5D
	 uMTcLV8stbKyg0cp5X7JZhpkRkixORti+A8K41swoKAnLNTfDsPCcuVTP0ThERFymO
	 HFJU07MvRphaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/8] perf sched: Replace BUG_ON on invalid CPU with
 graceful skip
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602235709.1541603-8-acme@kernel.org>
References: <20260602235709.1541603-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 01:16:06 +0000
Message-Id: <20260603011606.86CA41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pre-existing NULL pointer dereference when machine__findnew_thread=
 fails in latency_runtime_event.
- [High] Missing `thread__put()` for `sched_out` and `sched_in` on the erro=
r path of `add_sched_out_event()`.
- [High] Missing bounds check on `sample->cpu` causes out-of-bounds reads i=
n `test_bit()` across multiple perf tools.
--

commit a94415fdfe25f82cda0feb4b93da07a2fcbbe10d
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf sched: Replace BUG_ON on invalid CPU with graceful skip

This commit replaces BUG_ON assertions for invalid sample CPUs with gracefu=
l=20
skips and warnings in latency_switch_event(), latency_runtime_event(), and=
=20
map_switch_event(). It handles cases where PERF_SAMPLE_CPU is absent and=20
initialized to (u32)-1 by evsel__parse_sample().

> The central CPU validation in perf_session__deliver_event() intentionally
> preserves the (u32)-1 sentinel for downstream tools like perf script
> and perf inject, so leaf callbacks must handle it themselves.

[Severity: High]
This isn't a regression introduced by this patch, but do other leaf callbac=
ks
properly handle the (u32)-1 sentinel when using the --cpu list option?

In process_sample_event() in tools/perf/builtin-annotate.c:

    if (ann->cpu_list && !test_bit(sample->cpu, ann->cpu_bitmap))
        goto out_put;

And similarly in hist_iter_cb_cmp() in tools/perf/builtin-diff.c:

    if (cpu_list && !test_bit(sample->cpu, cpu_bitmap)) {
        return -1;
    }

And in process_sample_event() in tools/perf/builtin-report.c:

    if (rep->cpu_list && !test_bit(sample->cpu, rep->cpu_bitmap))
        goto out_put;

If sample->cpu is (u32)-1, could passing this to test_bit() compute an inva=
lid
bit offset and cause a deterministic out-of-bounds read and segmentation fa=
ult?

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 9ec8e049e19b0..81833d1694705 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -1145,7 +1145,12 @@ static int latency_switch_event(struct perf_sched =
*sched,
>  	int cpu =3D sample->cpu, err =3D -1;
>  	s64 delta;
> =20
> -	BUG_ON(cpu >=3D MAX_CPUS || cpu < 0);
> +	/* perf.data is untrusted input =E2=80=94 CPU may be absent or corrupte=
d */
> +	if (cpu >=3D MAX_CPUS || cpu < 0) {
> +		pr_warning("WARNING: at offset %#" PRIx64 ": out-of-bound sample CPU %=
d, skipping sample\n",
> +			   sample->file_offset, cpu);
> +		return 0;
> +	}

[Severity: High]
This isn't a regression introduced by this patch, but does the error path f=
or
add_sched_out_event() further down in latency_switch_event() leak thread
references?

If machine__findnew_thread() successfully acquires references for sched_out=
 and
sched_in, and we later fail here:

    if (add_sched_out_event(out_events, prev_state, timestamp))
        return -1;

Could returning -1 directly bypass the thread__put() cleanup sequence at the
out_put label and leak the thread objects?

[ ... ]

> @@ -1215,7 +1220,13 @@ static int latency_runtime_event(struct perf_sched=
 *sched,
>  	if (thread =3D=3D NULL)
>  		return -1;

[Severity: High]
This isn't a regression introduced by this patch, but could this cause a nu=
ll
pointer dereference before the validation check is reached?

At the start of latency_runtime_event(), atoms is initialized by passing
thread to thread_atoms_search():

    struct thread *thread =3D machine__findnew_thread(machine, -1, pid);
    struct work_atoms *atoms =3D thread_atoms_search(&sched->atom_root, thr=
ead,
                                                   &sched->cmp_pid);
    ...
    if (thread =3D=3D NULL)
        return -1;

If machine__findnew_thread() fails and returns null, would thread_atoms_sea=
rch()
dereference the null pointer before we reach this validation check?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602235709.1541=
603-1-acme@kernel.org?part=3D7
