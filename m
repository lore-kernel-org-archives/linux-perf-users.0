Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4BE4071F3
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 23:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780703762; cv=none; b=B9rzVEpAAOq4sOkSyyUPTi/mWZziyu8UVXPZ3Z1qjqHNd5aNs8O7vFNxgdcuDmBGEITYQAKQ9DSgn2kBITUbJEAQtxSwhwZySjYibuF2Qc5HLihZe4xJq/dT3XtfnoTrEiJSjasPV6tpJGbYwnLHEdG0obLa0n10HZke4ynpp8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780703762; c=relaxed/simple;
	bh=7C0YFCM09TYBXfSCpgfjxPS2DPWiajGRMmnyqGlm6QM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dsu0Q11JDsVD5dgR69XnVGh0Lm32uThE0vpxgIlDqUN9x4a7JKPCcPDyOBD3Kuk0YwLkDxG3pr/n1sX6b5A++928Sl7CISuuBO4VvnGk3fZ+oJ8J7m0PngLji11d0za0l16sEd/UB+UMjTkyTKuefCfll3fVEw0Za6NvP6qd8oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPxOVNTo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPxOVNTo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9AE1F00893;
	Fri,  5 Jun 2026 23:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780703761;
	bh=xw8AZSHZlbK5bVoSyKSevN6R7iPp+NaZNxd4TJW7XiM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PPxOVNToREkYOKmDZi1cvGficA3CkwQiUwFSo+60YZDEE7CJqK2mRbCT+XWYu5GhP
	 C9QtfZbAcYHnMbCDrfUWKMMRetx9zzsR7IwAOdek3y2Yj1BnDlU3zdAccyiyoFDDoc
	 dV3wkDCA4wDTBPBPtHmLQD+M+gKgX/z40vE+ao2yy/Yh9ac6n9NnJIaYfOOzYnui6w
	 fst/ZwIUM8mnAPW0d3A+jwlQDgBekurso1ClKHd+OzLTp5D0xhn8QWl3XIHlyPQE1k
	 U5vQRzjU7csM0T+kkQa35A5M2HAQiy6xznU+9VTvQUduMNz+SqWjt2lT3xCtqFmBGE
	 yAFXikBce61kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/9] perf sched: Clean up idle_threads entry on init
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605233837.1773732-6-acme@kernel.org>
References: <20260605233837.1773732-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 23:56:01 +0000
Message-Id: <20260605235601.6A9AE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The perf sched command fails to register the `.feature` callback i=
n its `perf_tool` initialization, which prevents `perf_env` from being popu=
lated in pipe mode.
- [Medium] free_idle_threads() leaks the dynamically allocated nodes of the=
 callchain root attached to the idle thread's private data.
--

commit 22f7015aaa31f156b54bc85f9ec298a36781e9ba
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf sched: Clean up idle_threads entry on init failure

get_idle_thread() allocates a thread via thread__new() and stores it in
idle_threads[cpu], then calls init_idle_thread() to set up the private
data.  If init_idle_thread() fails (e.g. OOM for the idle_thread_runtime
struct), the function returns NULL but leaves the partially initialized
thread in idle_threads[cpu].

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 21fb820b625b4..e4378cc9ab3ed 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -2514,8 +2514,11 @@ static struct thread *get_idle_thread(int cpu)
>  		idle_threads[cpu] =3D thread__new(0, 0);

[Severity: Medium]
This is a pre-existing issue, but does free_idle_threads() leak the
dynamically allocated nodes of the callchain root attached to the idle
thread's private data?

During tool execution, callchain_append() dynamically allocates struct
callchain_node objects and attaches them to itr->callchain (inside struct
idle_thread_runtime).

When free_idle_threads() runs at exit:

tools/perf/builtin-sched.c:free_idle_threads() {
    ...
            itr =3D thread__priv(idle);
            if (itr)
                thread__put(itr->last_thread);

            thread__put(idle);
    ...
}

Because cmd_sched() registers the generic free() function as the private
data destructor (thread__set_priv_destructor(free)), thread__put(idle)
performs a shallow free on itr.

The function free_callchain(&itr->callchain) is never called, resulting in
a leak of all appended callchain nodes at tool exit.

> =20
>  		if (idle_threads[cpu]) {
> -			if (init_idle_thread(idle_threads[cpu]) < 0)
> +			if (init_idle_thread(idle_threads[cpu]) < 0) {
> +				/* clean up so next call doesn't find a half-initialized thread */
> +				thread__zput(idle_threads[cpu]);
>  				return NULL;
> +			}
>  		}
>  	}
> =20

[Severity: High]
This is a pre-existing issue, but does the perf sched command fail to
set up the .feature callback in its perf_tool initialization, preventing
perf_env from being populated in pipe mode?

In pipe mode, perf_env is populated via synthesized feature events from the
stream.  Because perf_sched__timehist (via cmd_sched) assigns callbacks like
.mmap, but completely omits .feature:

tools/perf/builtin-sched.c:perf_sched__timehist() {
    ...
        sched->tool.sample       =3D perf_timehist__process_sample;
        sched->tool.mmap         =3D perf_event__process_mmap;
        /* missing sched->tool.feature =3D perf_event__process_feature; */
    ...
}

Are feature events routed to a default stub and dropped?  This would prevent
proper initialization of tool structures (e.g., env->nr_cpus_online defaults
to 4 rather than the actual topology), breaking analysis functionality.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605233837.1773=
732-1-acme@kernel.org?part=3D5
