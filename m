Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDB73ACF02
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 21:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782250018; cv=none; b=QVgyrpnYpofFHUMA9m/f38eUOrKrVYt7ah1CYCWj+Niw6LX+evayJCmVXATtpqOJVGCDt0D+UfK5qh+k52xLakPJWKWypBP/GUpzMrEdAUXKDVKXviDV0Tly5Ie/0weNMFXH2VRDzB4FEKM/BXKd/USF+RnCqufAhyvTHAWLph4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782250018; c=relaxed/simple;
	bh=nsbXYJLLDEwrv6bo3OzZUa66Tk/U7jm1yc7HNRuDWA8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bj8fXMmx/Zq/O5mdmAC0lmFGuQLzqDqn0fedNAP8xAlS4MDdX4nbQpVHV68nxEpv5BXWvfhlyarPnUntsCdLnYgF1au+eyamyGIjhqx0FY9u5BYwAtq/ZAhd7y0uaglo2yek/at8LqPsd+B3jOPeH2Q/ff8JBUEEZcv74Nd6JF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/xbERlm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/xbERlm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABB11F000E9;
	Tue, 23 Jun 2026 21:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782250017;
	bh=Da7aYzvxSzvM1n0LuAFdJgAk5E6k0bWNSBCM2zlG60c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C/xbERlm1uxNNX0gAoixgTz3heWA94zt6DPz0kBT9y8VR/ilDV7Zqx6LIQBWVx1Kh
	 jLM2Ca2oU57OLwurYV2aWdYLh1GBrOEeCIlGwYbAtep26SddVdnnIJHtt/AYaL5iJS
	 R8UregPTjT9W0f5vIa1lP8GlQhOPE9ikywgVId8Tt2A8HQBmiYy9qizlLljMPXu3ay
	 sNlqyMCpu7+wuO56wvhczrcZiigAmbS3npQhEcKvn/GqS1Cgo+T8Q1JujkyyA1ru3b
	 hGKxCDl3nTEVWkL4zku3QS5ENhpM1ZnlAsC36Ev+rT0R3L5dtuJEKrV7jP/52ujIHv
	 xR3cjTznUIE2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 03/13] perf top: Fix sb_evlist leak
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260623053515.2677888-4-irogers@google.com>
References: <20260623053515.2677888-1-irogers@google.com>
 <20260623053515.2677888-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 21:26:56 +0000
Message-Id: <20260623212657.3ABB11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Error path in `record__setup_sb_evlist()` bypasses state update, l=
eading to a segmentation fault from an uninitialized `pthread_join()`.
- [High] Sideband thread and `sb_evlist` are leaked when using `--switch-ou=
tput-event` together with `--no-bpf-event`.
--

commit 9bc374ffd1b7ae00f5342c051ca479b32bc92942
Author: Ian Rogers <irogers@google.com>

perf top: Fix sb_evlist leak

Fix a memory leak in cmd_top() where top.sb_evlist was not freed if
evlist__add_bpf_sb_event() fails. Note that evlist__start_sb_thread() and
evlist__stop_sb_thread() take ownership of the evlist and free it, so
we must only free it if we fail before starting the thread.

> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 5933c46ee137e..abc74b8ab7599 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1881,6 +1881,7 @@ int cmd_top(int argc, const char **argv)
>  		if (evlist__add_bpf_sb_event(top.sb_evlist, &host_env)) {
>  			pr_err("Couldn't ask for PERF_RECORD_BPF_EVENT side band events.\n.");
>  			status =3D -EINVAL;
> +			evlist__put(top.sb_evlist);
>  			goto out_put_evlist;
>  		}
>  	}

[Severity: High]
This is a pre-existing issue, but does tools/perf/builtin-record.c have a
similar problem where the error path in record__setup_sb_evlist() bypasses
updating the state?

If evlist__add_bpf_sb_event() fails in record__setup_sb_evlist(), it
returns -1 without updating the opts->no_bpf_event flag:

tools/perf/builtin-record.c:record__setup_sb_evlist() {
    ...
	if (evlist__add_bpf_sb_event(rec->sb_evlist, perf_session__env(rec->sessio=
n))) {
		pr_err("Couldn't ask for PERF_RECORD_BPF_EVENT side band events.\n.");
		return -1;
	}
    ...
}

During cleanup in __cmd_record(), the unmodified no_bpf_event flag causes
evlist__stop_sb_thread() to be unconditionally invoked:

tools/perf/builtin-record.c:__cmd_record() {
    ...
	if (!opts->no_bpf_event)
		evlist__stop_sb_thread(rec->sb_evlist);
    ...
}

This could blindly call pthread_join() on the uninitialized thread ID in
evlist__stop_sb_thread():

tools/perf/util/sideband_evlist.c:evlist__stop_sb_thread() {
    ...
	pthread_join(*evlist__sb_thread_th(evlist), NULL);
    ...
}

Could this trigger undefined behavior and a crash?

[Severity: High]
This is also a pre-existing issue, but is there a leak of the sideband
thread and sb_evlist in tools/perf/builtin-record.c when using
--switch-output-event together with --no-bpf-event?

In record__setup_sb_evlist(), the sideband thread is started when using
--switch-output-event, even if BPF events are disabled:

tools/perf/builtin-record.c:record__setup_sb_evlist() {
    ...
	if (evlist__start_sb_thread(rec->sb_evlist, &rec->opts.target)) {
    ...
}

However, cleanup in __cmd_record() is bypassed because opts->no_bpf_event
evaluates to true:

tools/perf/builtin-record.c:__cmd_record() {
    ...
	if (!opts->no_bpf_event)
		evlist__stop_sb_thread(rec->sb_evlist);
    ...
}

Does this permanently strand the background poll thread and leak the
allocated evlist during process teardown?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623053515.2677=
888-1-irogers@google.com?part=3D3
