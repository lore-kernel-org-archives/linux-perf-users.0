Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359891946BC
	for <linux-perf-users@vger.kernel.org>; Sun, 26 Jul 2026 03:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785037047; cv=none; b=nulEPRMCP2/Attyw3db2/po9fYG01mQpqk0/epChoPhCmqi545RQ7HJ7wg2AAe5NeHvGNJVa0P3Ts9jPqdc9Ex7WB/gkjqtf4yL/DqO7bkSOzid5792NKytReTet0MsMWzPVQfBtTaD6+WAN2YN+IglRSC3Sk7hCb7IEnZrcyfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785037047; c=relaxed/simple;
	bh=1+Hhg1U26QY7RDO39RMMn7+FAVtTbiYNrODmaUHczrE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HSIbtNiGrfSV+SS2S0+nCC6OfbLJHE3GE9C2OTK6k12mHAgVSd+wV3vvOqYyE1N36IpKjnVgadfFiKBaId9PLwftD/Ze85gO2+U4OzbD4qYUauORurndPZujohLUpNW+j0E+1Yujhbyn0luLnrKYc2KnbcfRSXnWCLrnEYMGyws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzGPd+wT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzGPd+wT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C765A1F000E9;
	Sun, 26 Jul 2026 03:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785037046;
	bh=xJ5sTrLTAT1EW8QFa+sBQq8VPQsq2YFsB98mnzV8xgw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WzGPd+wTraghyK1iRWP97ZXWHpC9ZS2VKuFnzfGW825NQRcjwLKPcjmWrEspHLvCe
	 6FDZnoa5HzgivAhNT6b0G4SYEvuX4jQICMJV6eBBaPCRB1N72OVu/O9f7VR0MFEUW2
	 VAfkde6/qHl/u06ajp+Zs8c2QXFKgD+gwy9Ys8GBlop78K6gDvImNpEDfMfoUDJ21h
	 RUHtne+/KCFOjlCdZZ5HDToiA4s1+XMytD2GaNnwr7sjfbUsWRRAv16JBks8nYxRQ8
	 5YAztXD8kQGHlGsxBDaKiELXrccTrSxyp9KjRm6WBqmpUdFAmR2O0WSi42zXgecZDV
	 Pb1drcIudbrSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] perf sched: Suppress latency table output when
 trace samples are missing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260726032533.712462-2-atomlin@atomlin.com>
References: <20260726032533.712462-1-atomlin@atomlin.com>
 <20260726032533.712462-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 03:37:25 +0000
Message-Id: <20260726033725.C765A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing NULL pointer check after calling `thread__get_runtime()` i=
n `map_switch_event()` could lead to a segmentation fault.
- [Medium] The default `sched.tool` initialization for `perf sched` subcomm=
ands omits the `.attr` and `.feature` callbacks, preventing `evlist` popula=
tion in pipe mode.
--

--- Patch [1]: [PATCH v3 1/3] perf sched: Suppress latency table output whe=
n trace samples are missing ---
commit 74145a7e4615a4aa12c0b60a699cc17c4a941dd7
Author: Aaron Tomlin <atomlin@atomlin.com>

perf sched: Suppress latency table output when trace samples are missing

This commit updates perf_sched__read_events() to abort early and return an
error if perf_session__has_traces() evaluates to false. This suppresses
empty latency table outputs when no tracepoint samples are present in the
perf.data file.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 7fd63a9db4574..b3cf678573e0a 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
[ ... ]
> @@ -2018,18 +2018,19 @@ static int perf_sched__read_events(struct perf_sc=
hed *sched)
>  	if (perf_session__set_tracepoints_handlers(session, handlers))
>  		goto out_delete;
> =20
> -	if (perf_session__has_traces(session, "record -R")) {
> -		int err =3D perf_session__process_events(session);
> -		if (err) {
> -			pr_err("Failed to process events, error %d", err);
> -			goto out_delete;
> -		}
> +	if (!perf_session__has_traces(session, "record -R"))
> +		goto out_delete;

[Severity: Medium]
This is a pre-existing issue, but does this patch now cause pipe mode to
always fail and return an error code?

Because sched.tool is initialized in cmd_sched() without the mandatory
.attr and .feature callbacks:

	perf_tool__init(&sched.tool, /*ordered_events=3D*/true);
	sched.tool.sample	 =3D perf_sched__process_tracepoint_sample;
	sched.tool.comm		 =3D perf_sched__process_comm;
	sched.tool.namespaces	 =3D perf_event__process_namespaces;
	sched.tool.lost		 =3D perf_event__process_lost;
	sched.tool.fork		 =3D perf_sched__process_fork_event;

In pipe mode, PERF_RECORD_HEADER_ATTR events are silently dropped by the
fallback stub handler, which prevents evlist population. As a result,
perf_session__has_traces() always evaluates to false when reading from a
pipe.

With this patch adding an early abort, does this mean commands like
'perf sched latency -i -' will now unconditionally fail instead of processi=
ng
what they can?

[ ... ]

While reviewing the rest of the file, I noticed another pre-existing issue
in map_switch_event() that might surface under memory pressure:

	sched_out:
		if (sched->map.task_name) {
			tr =3D thread__get_runtime(sched->curr_out_thread[this_cpu.cpu]);
			if (strcmp(tr->shortname, "") =3D=3D 0)
				goto out;

[Severity: High]
This is a pre-existing issue, but could this lead to a segmentation fault?

If memory allocation fails inside thread__init_runtime(), thread__get_runti=
me()
returns NULL. Unlike other places in map_switch_event() that verify the
returned pointer, the tr pointer is immediately dereferenced by strcmp() he=
re
without a NULL check.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726032533.7124=
62-1-atomlin@atomlin.com?part=3D1
