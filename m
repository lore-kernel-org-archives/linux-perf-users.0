Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70A33C09E4
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jul 2026 20:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783541676; cv=none; b=agPUz+DXYXs5bRbN7+VkH+II7kEBGx2vBCz1/wh2pOJZXlIM2QPcp+2D+x/7MNd/lcj7C1ks4Gr9eIWqJYztTUpq6iZquZRS2I1eEO6cbkRDEQmdx8azYN32B9dXJVpPBaxmGtipcgYfotuMsVtjz1yxlEo5RlQq5+qZogvzO4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783541676; c=relaxed/simple;
	bh=KB7xuMsmpM+swXL9l+mY7UE0yt4HW+2Pn+FFgixCAQw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BfaQ59JQ4y8t4GBAn/Ug48dIe2N+L/MxXLLCFVzZrT9HnUi426/PSLDSDur2S6pCNXn5A0JE3EZKXNcMq8SiOSdPwRKIxpRqbjqOl6DqZpisXCFUHGmD2Z+rnlWZs2MSpaR1Ejt0LnN3Bu3mf23NppSOlFbtRWscVLurh1+UDMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgQWR1u1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgQWR1u1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5831F000E9;
	Wed,  8 Jul 2026 20:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783541674;
	bh=J2HVAZy0jFRzIcH2V++Ph+l/YS/GWKkd/8DgoFPoELM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JgQWR1u1dlMqwEKbSu2/36tGUUTru7W9uk/F3oLxxMqqw6K7KOsbAmVeBe9o0gxez
	 7FvUQCk0mUM8M2AcLC8oZqK1C+4LU23SJXoS15R+tD1prqR5ji/pBLlMQcG+QYigs5
	 2/6ffb7fJY8Pp4YK6ZXnnwr/6A71Cu/YCPi0suqZURjvv3BTBbJEOTamx2nlz3I11/
	 Z+BSq2y/s6AGK7eiQ/o0yoGV7OMTIsxJDDSnfBAp1divKsCSSEsz5NXfptjhwzeKMl
	 OCtr7jwceZdM2Bdimu24YrvLIATAYzemoEdXCJvT6oTyW+NDPecp86CPvda8hTuHhs
	 Z3QAQCJi1+xrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf stat: Do not open cgroups for BPF counters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260708200407.1240640-1-namhyung@kernel.org>
References: <20260708200407.1240640-1-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 20:14:33 +0000
Message-Id: <20260708201434.5C5831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Fallback from BPF counter mode to standard cgroup mode leaves cg=
roup file descriptors uninitialized (-1), causing standard perf event openi=
ng to fail with -EBADF.
--

--- Patch [1]: [PATCH] perf stat: Do not open cgroups for BPF counters ---
commit 510c63ce03b2362940d1f693b45d5faa86cf3bc1
Author: Namhyung Kim <namhyung@kernel.org>

perf stat: Do not open cgroups for BPF counters

This commit prevents opening and keeping file descriptors for cgroups
when using the --bpf-counters and --for-each-cgroup options. BPF mode
uses a set of shared events and compares cgroup-IDs, so it doesn't need
individual cgroup file descriptors.

> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2874,7 +2874,8 @@ int cmd_stat(int argc, const char **argv)
>  			goto out;
>  		}
> =20
> -		if (evlist__expand_cgroup(evsel_list, stat_config.cgroup_list, true) <=
 0) {
> +		if (evlist__expand_cgroup(evsel_list, stat_config.cgroup_list,
> +					  !target.use_bpf) < 0) {

[Severity: Medium]
Will this break the fallback path when we exceed BPERF_CGROUP__MAX_EVENTS?

Later in cmd_stat(), we have a fallback that disables BPF counters if there
are too many events:

	if (target.use_bpf && nr_cgroups &&
	    (evsel_list->core.nr_entries / nr_cgroups) > BPERF_CGROUP__MAX_EVENTS)=
 {
		pr_warning("Disabling BPF counters due to more events...");
		target.use_bpf =3D false;
	}

If this fallback is triggered, target.use_bpf becomes false, but the cgroups
were already expanded with !target.use_bpf (which was false at the time),
leaving the cgroup file descriptors uninitialized (-1).

When the standard event opening later calls evsel__open_cpu() in
tools/perf/util/evsel.c:

	if (evsel->cgrp)
		pid =3D evsel->cgrp->fd;

Could it attempt to use the uninitialized cgroup file descriptor (-1) with
the perf_event_open syscall, causing it to fail with -EBADF? Should the
cgroup file descriptors be reopened if the fallback to standard mode is
taken?

>  			parse_options_usage(stat_usage, stat_options,
>  					    "for-each-cgroup", 0);
>  			goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708200407.1240=
640-1-namhyung@kernel.org?part=3D1
