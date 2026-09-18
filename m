Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93134FDA68
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 21:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789767087; cv=none; b=AtHxVtvZFaGoEIe3g3WbXXQSpp7QbLvHHewFgTGzMIxO3AtCHaQmqLB+6VS3T7vj72E2sI1FlYBMmly3CXk//bEUDNtGqBmVEXjhRORUCGnM59W5x9VsC6W8KGejBfYrQBrPsy2MMvVM5jkgByKkZsQvowv64hF7m/kDiJUwhRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789767087; c=relaxed/simple;
	bh=kx980IaPXOHB8Ir8jrsrzv6Xd882UqOc8ptJy3rIFlQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VSb82hUchVvfeePVj9FzAgtgoL4EjX17QKV0wv2JYZfm2FiJ5j/ayzelx0+aoxAPBY0Qp6k0IQLm63g7jYoIoOnDGpqcvKxLj0miODWLpSPKu36yzsjmN/NcgEyu77Qcaw5mkm7/1tlhDVtIrKpjsBNhfJMzjPg6fO1h7DnRqu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFaa+cwz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFaa+cwz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DF91F000FF;
	Fri, 18 Sep 2026 21:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789767085;
	bh=JfItEP0AaIJRhsJsTwzTww48YxgBUrOX+6yGqkqP68I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VFaa+cwzh0BO+Jp+8/agKKw+tKw1W9NFVrb3eWD63EtUoINvuK37rPSfUFZ10OGUt
	 D/nx3zc0tJ8FPggBLhNvWEFYzHuDjkuBKwdiamHp7IgyRsKeoqBeCQsqgqdLLV27Xh
	 Z6fVUz/zAkmDMiaDtPJVeqVY1OG+yBS1P7w3LEbarZNIvdB/OwPxr5400+UqjSh2OQ
	 WHeQcqfziMmtf/fLv1fiIyOO2Hi682MeVGTQU1wWoTXueW3QUV0aFEWLqUv7i0OUQ6
	 IUEXcixLnihMRTvpE7vCi7tVY0cE4P77J52ZR6Sfa47Bd4HLQZW5GzNnQvshipt9ft
	 uezUvlJgIC75A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/18] perf trace: Handle fork and exit directly in
 BPF filter maps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918211932.2966061-9-irogers@google.com>
References: <20260918140659.2501976-1-irogers@google.com>
 <20260918211932.2966061-1-irogers@google.com>
 <20260918211932.2966061-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 21:31:25 +0000
Message-Id: <20260918213125.85DF91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: PID reuse TOCTOU race in sched_process_exec
--

commit d8a2403eb7c48846672bae9851f669ee1a4f9446
Author: Ian Rogers <irogers@google.com>

perf trace: Handle fork and exit directly in BPF filter maps

This commit shifts PID map filtering for fork and exit events from
asynchronous userspace handling directly to BTF-typed BPF programs attached
to scheduler tracepoints. This closes windows where events might be dropped
due to PIDs being recycled before userspace processes the tracking events.

> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tool=
s/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
[ ... ]
> +SEC("tp_btf/sched_process_exec")
> +int BPF_PROG(sched_process_exec, struct task_struct *p, pid_t old_pid)
> +{
> +	pid_t pid =3D p->pid;
> +	bool val =3D true;
> +
> +	if (pid =3D=3D old_pid)
> +		return 0;
> +
> +	/*
> +	 * Drop the old key before adding the new one. The maps are bounded and
> +	 * the move is only ever a rename, but inserting first needs a spare
> +	 * slot for as long as both keys are present: on a full map that insert
> +	 * fails with -E2BIG while the delete still succeeds, which would lose
> +	 * the task rather than move it. Deleting first frees the slot the
> +	 * insert goes on to use. The task is mid exec and issues no syscalls in
> +	 * between, so the gap is not observable.
> +	 *
> +	 * There is no atomic rename for a hash map, so on a map that is exactly
> +	 * full this narrows the window rather than closing it: a fork on
> +	 * another CPU can still take the freed slot before the insert below
> +	 * runs, and the task is then dropped just as any other task is once the
> +	 * map is full.
> +	 */
> +	if (bpf_map_lookup_elem(&pids_to_trace, &old_pid) !=3D NULL) {
> +		bpf_map_delete_elem(&pids_to_trace, &old_pid);
> +		bpf_map_update_elem(&pids_to_trace, &pid, &val, BPF_ANY);
> +	}

[Severity: Medium]
Does this sequence have a TOCTOU race with PID reuse?

When a non-leader thread calls execve, its old PID is released in
de_thread() before the sched_process_exec tracepoint fires. If a concurrent
fork on another CPU recycles this old PID before the tracepoint executes,
could this BPF program inadvertently delete the new process's state from
pids_to_trace, while simultaneously updating the exec'ing task's tracing
state based on the recycled PID's state?

While PID wrap-around in this microsecond window might be rare in practice,
can local userspace trigger this by racing execve and fork under heavy
thread creation load, leading to corrupted trace states and silent drops
for newly created tasks?

> +
> +	if (bpf_map_lookup_elem(&pids_filtered, &old_pid) !=3D NULL) {
> +		bpf_map_delete_elem(&pids_filtered, &old_pid);
> +		bpf_map_update_elem(&pids_filtered, &pid, &val, BPF_ANY);
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918211932.2966=
061-1-irogers@google.com?part=3D8
