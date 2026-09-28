Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8406F3A6F09
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621203; cv=none; b=f7y0nmkQiJjqWY9A0wkKNMI1j8QOLGQNpFIp7ap+s7UnNEtpkvPGiZVWKRFkdAGE/wQU7uiDWXyKyGFgIZzJTnM920Z6JoVKrAYF+nMC2Hz6kq//PsnfM8QXabJkMDhwoinLhmDA7bSV10HBpLBlbnlJIVrsp0+ocDmK5YaYC4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621203; c=relaxed/simple;
	bh=OkkZjbcYhiUqB0yh5W+UkMlWV4n0d7tOXiWcMGqxe/Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uej4JWizlrInOA9aH8sChkMgA0D/cI60IYDbcx3c9EoaecJkxW9rpF8U7IX2jdUGJ5ItCkhVOeaCNAX3tGjhbqFffHFXmXflihYEGhWjALLDLHiLb8b+YSGHJ9KUNkL1rkfjM6bz1nO33ErB+lQWsB8321mXd04TQWRqLQ2pnPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFFIM0At; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFFIM0At"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53151F000FF;
	Mon, 28 Sep 2026 18:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790621201;
	bh=8eKsl47V4+trkd44qSJHG71c8D/M6L6+5x644sbhumg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bFFIM0At/WqZ5D0DnJz4bQb2pxbLkbid1J1mpqER853Jtsth1tsOxRe7Nakaq8RlZ
	 IwNGpE16yoyE2qfPdXYytPgHu2IG5WHpojpj9VVpCsJHWnEUmuufC8WY29qGvGEjzj
	 vFWnOdWUnt73A07XeCA1tr/npixN9kaPRIYliVOJ6LJJGTylpDsOY5lA5NXRXj3PLS
	 +8gdOtuv8xVha3xxj/xg4inE3YHd0gjjUWk14hTsmk9MaAnEr+7x1Ki+llO5R6M6pa
	 FVfDQYwmKZwDJjhl/49oFscu/nSnPsmYPGPygtHLNPUEWX5v4rrmBbNotol7gyk91O
	 M2JMGMOiRGe6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 17/26] perf trace: Do not return 0 from syscall
 tracepoint BPF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928182605.3649015-18-irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-18-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:46:40 +0000
Message-Id: <20260928184640.E53151F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] bpf: perf trace silently loses syscall events on BPF augmenter fai=
lure paths
- [Medium] perf: out-of-bounds read in trace__bpf_output due to missing bou=
nds check
--

commit 662e5192e10694c169bbb2fe60bc8a7182517dbe
Author: Namhyung Kim <namhyung@kernel.org>
Subject: perf trace: Do not return 0 from syscall tracepoint BPF

This commit transitions perf trace to exclusively use the bpf-output event
for both augmented and normal syscall arguments, omitting the standard
raw_syscalls:sys_{enter,exit} tracepoints. It identifies whether the
bpf-output data belongs to an enter or exit event by repurposing the
common_type field.

Link: https://lore.kernel.org/r/20250814071754.193265-4-namhyung@kernel.org

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index d327603ae4540..3dd40f3c3cbb7 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
[ ... ]
> +/* The BPF output event carries both entry and exit, tagged in common_ty=
pe. */
> +static int trace__bpf_output(struct trace *trace, union perf_event *even=
t,
> +			     struct perf_sample *sample)
> +{
> +	u16 type =3D *(u16 *)sample->raw_data;

[Severity: Medium]
Does this code safely dereference sample->raw_data?

If the bpf-output event is missing the PERF_SAMPLE_RAW flag,
sample->raw_data could be NULL. Alternatively, if sample->raw_size is less
than sizeof(u16), could this lead to an out-of-bounds read when processing
corrupted or malicious perf.data files?

> +
> +	if (type =3D=3D SYSCALL_TRACE_ENTER)
> +		return trace__sys_enter(trace, event, sample);
> +
> +	return trace__sys_exit(trace, event, sample);
> +}
[ ... ]
> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tool=
s/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> index 3bc9e28a9b8a3..d16e55706335b 100644
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
[ ... ]
> @@ -408,7 +424,9 @@ int sys_enter_perf_event_open(struct syscall_enter_ar=
gs *args)
> =20
>  	return augmented__output(args, augmented_args, len + size);
>  failure:
> -	return 1; /* Failure: don't filter */
> +	if (augmented_args)
> +		augmented__output(args, augmented_args, sizeof(augmented_args->args));
> +	return 1;
>  }
> =20
>  SEC("tp/syscalls/sys_enter_clock_nanosleep")
>  int sys_enter_clock_nanosleep(struct syscall_enter_args *args)
>  {
[ ... ]
> -	bpf_probe_read_user(&augmented_args->arg.value, size, rqtp_arg);
> +	err =3D bpf_probe_read_user(&augmented_args->arg.value, size, rqtp_arg);
> +	if (err)
> +		size =3D 0;
> +	augmented_args->arg.size =3D size;
> +	augmented_args->arg.err =3D err;
> =20
>  	return augmented__output(args, augmented_args, len + size);
>  failure:
>  	return 1; /* Failure: don't filter */
>  }

[Severity: High]
Does returning 1 here without explicitly calling augmented__output() result
in silently dropping the syscall event?

Since this patch drops the raw_syscalls:sys_{enter,exit} tracepoints and
now relies entirely on bpf-output, returning 1 on BPF augmenter failure pat=
hs
(like in sys_enter_clock_nanosleep and sys_enter_nanosleep) appears to
completely lose the trace record.=20

Should these failure paths be updated to emit the unaugmented payload,
similar to the fix applied above for sys_enter_perf_event_open?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928182605.3649=
015-1-irogers@google.com?part=3D17
