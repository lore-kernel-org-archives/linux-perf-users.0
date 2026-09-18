Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1473E370D69
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 14:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742879; cv=none; b=eePhwGVG4lu6e6IjiGsEAKxOx6u6PQ2lh8cqly/7iBXQOqALHOS/84BbUsWycoB2zMEqbKTolMoIcL8K7fhEd6CmiD2+dbmToI0ea3jfhDlfTBi/ZgRQ8LiAZmQ1SFG0c2XHbGc8IbXsJQUOVqhelv2+7nRi2iiOMXV/Vae82sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742879; c=relaxed/simple;
	bh=kheTfvHUDz6u/7G/OrFmtyzoSBl9bCkPkdpTCU9GgXE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DAOpWUhvk5+DCAaPONbJhpMWvsdbRPiJ4nd07DCV/7rWccRuNghndK80dy9YRCm6v710F6fsC32ex6bsxHmvlv4z+ICXt/k6qIeyloeIg+70AAf4r9XbMv7QLhxt4xKyiGq+S1nr63IL5OGFkJKavckR//2RGhNxIOqqFT06SN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oy1+iQ7O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oy1+iQ7O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604D41F000FF;
	Fri, 18 Sep 2026 14:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789742877;
	bh=3hVatRDuMnTC5sYm269D0a5KysmDFWqO+zrE7MzccoI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oy1+iQ7O3h5OU16CreW9rEL90IDzTL9qXBksFRp3lqrjSod/UGcM6CJd1c0eJ3oiA
	 AkeUfSwKx96MoLsvAA2cTt5hA1vA//Xu049nz65/Z5WBpungqka1ELMikdntNF5e6k
	 5XUN3gqIc0juYGdPkU1545Z5NQY6YG42f3rzAtFIKFIGzfzAMPMg9YmmkKmd5cjlfD
	 heROO4lTr4huAvqnk0aQdXiuSTe1ggzPc5tuTkjxqT9tbx60kjeIQBFxxR49mtVm3X
	 OkzLbrLDcgPqbmuDUfzSvLv/mdYmE34SfiiVCcFMY/cKD2kVXtGdaMdtlLGcP70ygi
	 PWTPH7bEyowiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/16] perf trace: Enumerate the target again once
 BPF is attached
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918140659.2501976-9-irogers@google.com>
References: <cover.1789662556.git.irogers@google.com>
 <20260918140659.2501976-1-irogers@google.com>
 <20260918140659.2501976-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:47:56 +0000
Message-Id: <20260918144757.604D41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf trace: TOCTOU race in startup PID collection leaks dead PID=
s in BPF map
--

commit 1da31ce50a5973414bbbad29076bca00f6ff0aae
Author: Ian Rogers <irogers@google.com>

perf trace: Enumerate the target again once BPF is attached

This commit updates perf trace to enumerate target tasks again after BPF
programs are attached. This ensures that any tasks created between the
initial /proc read and the BPF attachment are discovered and not missed by
the BPF sched_process_fork program.

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 914e6e4b34f80..56bec2dfeb4eb 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
[ ... ]
> @@ -4638,6 +4643,224 @@ static int trace__set_filter_pids(struct trace *t=
race)
[ ... ]
> +static int trace__set_startup_pids(struct trace *trace)
> +{
> +	struct pid_list pids =3D {};
> +	int err;
> +
> +	/*
> +	 * Nothing to do without a target: 'perf trace -a' does not filter on
> +	 * pid at all, and evlist__prepare_workload() keeps a workload blocked
> +	 * on a pipe until evlist__start_workload(), well after the attach.
> +	 */
> +	if (!target__has_task(&trace->opts.target))
> +		return 0;
> +
> +	err =3D trace__collect_target_pids(trace, &pids);
> +	if (!err)
> +		err =3D augmented_syscalls__set_target_pids(pids.nr, pids.entries);

[Severity: Medium]
Could this sequence result in dead PIDs leaking into the pids_to_trace BPF
map?

If a newly created task is discovered by trace__collect_target_pids() readi=
ng
/proc, and that task exits immediately after being read, the BPF
sched_process_exit hook will fire. However, the hook cannot evict the task
because it is not yet in the map.

Next, user-space completes trace__collect_target_pids() and calls
augmented_syscalls__set_target_pids(), which unconditionally inserts the
now-dead PID into the BPF map. Since the task is already dead, the
sched_process_exit hook will never fire for it again.

Since the map has a fixed limit, could repeated leaks from quickly exiting
tasks exhaust the map capacity and prevent new threads from being traced?
Also, if a leaked PID is reassigned by the OS to an unrelated task, might
perf trace incorrectly trace that unrelated task instead?

> +
> +	pid_list__exit(&pids);
> +	return err;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918140659.2501=
976-1-irogers@google.com?part=3D8
