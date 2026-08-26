Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E9838F633
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Aug 2026 19:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787771458; cv=none; b=pelDc4r4xVNK1eqEXzbR36RD41FIPbO105qYPz6udkASoghutdTdDg08G222KY2OVDbmlvtUAC1BHtCytlOy7/iAbltMNhParPXBTbmq1EsHQYANF3vd8LInVF4h3s7DPbclzBsdVglShFwy9F2Sy0iK3opQ3OG7BbKxmt8yOUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787771458; c=relaxed/simple;
	bh=si+nauMcFM0d+mAr3D0VRNNoSEgYCiurB9sKqmBenvo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h/zutzd61yuzPetd8HvIE4OhK0ghKbvMO26RG5WY1Ez9bnAwezqWnXEZgDkdojN5noT9nBuOsuG5lxuJ2uX3w5PLbiLJhuwRNxycVBqWJMpqjnCCNx28DjKFfM/i8Dq4EboUX+u7LPzh3mxuSGJEPuS8DpTzaogdudFu/JK8wYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feaC22nB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feaC22nB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F131F000E9;
	Wed, 26 Aug 2026 19:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787771449;
	bh=iUbwqRfk0eWbB2QZqzGGGZyp5niHyZXM4sv97SeKsZ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=feaC22nBy7omm5fKuYFbzwyb96NLn7jKrX77wKDJtNchSat2tOuRtN5MJP0WNs7vo
	 E4o96BtArU3DGH1Ofom82n2sAtY/pnFHgJ+435YTzT/7Nx2NTYOT3mOjm8EKMhpEjM
	 O+dlllb3kj9E36Wng0rd+woXP+oXB2vSSQEE6j+aK+H90YX+LvWuTdQLCurUDN4TRh
	 z2fWLVEIZvw7bYz+7BAlobTMGmaIxDreIPJWbOGtJ+7cSTaKT2cQ8jPrrktt+91JXL
	 /KSSgaWwaS4xQgr4CqDfq5Z86uwiNa6lHtBLR+ZCtU2Z2PpT3jdFhWtu3FOFnJ+p/H
	 wjshMCFaRzj0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf ftrace latency: Do not read trace files when BPF
 is used
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260826185815.280451-1-namhyung@kernel.org>
References: <20260826185815.280451-1-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 19:10:48 +0000
Message-Id: <20260826191049.49F131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] API misuse where `IS_ERR()` is used to check libbpf attachment fun=
ctions that return `NULL` on error, leading to completely bypassed error ha=
ndling.
- [High] A Time-of-Check to Time-of-Use (TOCTOU) race condition between che=
cking the `done` flag and blocking in `poll()` causes the `perf ftrace` too=
l to hang indefinitely.
--

commit 005a20a206112aa28a48619fcb3cf2e39a48a24a
Author: Namhyung Kim <namhyung@kernel.org>

perf ftrace latency: Do not read trace files when BPF is used

This commit modifies the perf ftrace latency command to avoid reading traci=
ng
files when BPF is in use, as the tracing files are not set up and poll()
returns immediately. Instead, it introduces a small sleep loop to wait for
the target process to exit or a signal to arrive.

> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 4f881a40c311a..e61b9de11e1e4 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -1146,6 +1146,11 @@ static int __cmd_latency(struct perf_ftrace *ftrac=
e)
> =20
>  	line[0] =3D '\0';
>  	while (!done) {
> +		if (ftrace->target.use_bpf) {
> +			usleep(1000);
> +			continue;
> +		}
> +
>  		if (poll(&pollfd, 1, -1) < 0)
>  			break;

[Severity: High]
This isn't a bug introduced by this patch, but does this main loop have a
race condition between checking the done flag and blocking in poll?

If a terminating signal (like sigchld from a completed workload or sigint
from the user) is handled immediately after the while (!done) check but
before the poll(&pollfd, 1, -1) syscall, the done flag will be set but the
signal is consumed.=20

The main thread then executes poll() with an infinite timeout (-1).=20

Since the workload has exited, no new trace events will arrive on trace_fd,
causing poll() to block forever and freeze the tool until killed manually.

Could this be avoided by using ppoll() with a signal mask, or by using a
timeout instead of blocking indefinitely?=20

This same pattern also appears to be present in the standard trace command
loop in __cmd_ftrace().


While reviewing the BPF functionality for ftrace, I also noticed a potential
issue in perf_ftrace__latency_prepare_bpf():

tools/perf/util/bpf_ftrace.c:perf_ftrace__latency_prepare_bpf() {
	...
	if (func) {
		skel->links.func_begin =3D bpf_program__attach_kprobe(skel->progs.func_be=
gin,
								    false, func->name);
		if (IS_ERR(skel->links.func_begin)) {
			pr_err("Failed to attach fentry program\n");
			err =3D PTR_ERR(skel->links.func_begin);
			goto out;
		}
	...
}

[Severity: High]
This is a pre-existing issue, but does this error check work as intended?

Functions like bpf_program__attach_kprobe() and
bpf_program__attach_raw_tracepoint() typically return NULL on error and set
errno.

If the attachment fails, IS_ERR(NULL) evaluates to false, which bypasses
this error handling path entirely.=20

This would cause the tool to falsely report success while silently failing
to collect data.

Should these attachment checks compare against NULL instead?=20

A similar check is also used for skel->links.event_begin later in the same
function.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826185815.2804=
51-1-namhyung@kernel.org?part=3D1
