Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131801FD4;
	Fri, 10 Jul 2026 23:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783727405; cv=none; b=FUQCGBdWLswmV0HSgEp5mPi26d74j0YSNT9lHYFeZk+XJTxQkKeLS6KBM7/z9TM3NdpXPtUq9PBbljelNdP7+8iNDWoTK13/Z2MPRuxwRpD0F4Xc2iASgHCKeggaaHoIZADprL9Dj5paA9nyh3BOgloG+mUe8XOWnXJj5spZiB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783727405; c=relaxed/simple;
	bh=wAE3GScmnSx8cUptu82juBeE5budC0SK1jc634yvVw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4KpfAO1WRp1IVxUadiwG0/Ie1GTyFKg64Gd1qG3pbTp4D9MIQXAvYtOiHQyscod4Jad/1YXz7R8Tm/ZrI84KNddDgdy0Hpc2e5t7rK8n4y1n20LlQ+u8FPQhHns1EqudoJtNx/rFcLnBBlPc4M4DgCSULqOIoCCpvTJfVpwcgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXrpns38; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXrpns38"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E281F000E9;
	Fri, 10 Jul 2026 23:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783727403;
	bh=FiStxUq/elhQK+Ad9q7/QAEpgfuPON9UpONFPyTC9fI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cXrpns380eHX/ZnIrg95dUgdVjaYrrPAkblDFDJAmMkbrVJhJg8VCclQc+IXT1CXl
	 h/g5iGX8CaeHbpBckblCQPUVmBoOt7ezw8r+0BeG5bq30JEOj6ENcPIVlIMfgdGk0L
	 4uMK4jknr1LNv3Q1iphWQq8BliaTdObPC6TkpeOhKJlQpz1T4BasQOjjXstl2KzSO9
	 otXQs7Cyoc5SrbIJdHrVCF1Kka3zTfhKOihafv9gXpiHzFlc4m650t/N274pfzVihS
	 pj07NxifQGQFJ+ZV/tuFaPxBri6ETTqUZ60j+tbQxvdY3UL59uqqgrj5UtYQxMAmjw
	 iQp6A04JNhNfQ==
Date: Fri, 10 Jul 2026 16:50:02 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf stat: Do not open cgroups for BPF counters
Message-ID: <alGFKjj1oorszo3V@google.com>
References: <20260708200407.1240640-1-namhyung@kernel.org>
 <20260708201434.5C5831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260708201434.5C5831F000E9@smtp.kernel.org>

On Wed, Jul 08, 2026 at 08:14:33PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Fallback from BPF counter mode to standard cgroup mode leaves cgroup file descriptors uninitialized (-1), causing standard perf event opening to fail with -EBADF.
> --
> 
> --- Patch [1]: [PATCH] perf stat: Do not open cgroups for BPF counters ---
> commit 510c63ce03b2362940d1f693b45d5faa86cf3bc1
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf stat: Do not open cgroups for BPF counters
> 
> This commit prevents opening and keeping file descriptors for cgroups
> when using the --bpf-counters and --for-each-cgroup options. BPF mode
> uses a set of shared events and compares cgroup-IDs, so it doesn't need
> individual cgroup file descriptors.
> 
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -2874,7 +2874,8 @@ int cmd_stat(int argc, const char **argv)
> >  			goto out;
> >  		}
> >  
> > -		if (evlist__expand_cgroup(evsel_list, stat_config.cgroup_list, true) < 0) {
> > +		if (evlist__expand_cgroup(evsel_list, stat_config.cgroup_list,
> > +					  !target.use_bpf) < 0) {
> 
> [Severity: Medium]
> Will this break the fallback path when we exceed BPERF_CGROUP__MAX_EVENTS?
> 
> Later in cmd_stat(), we have a fallback that disables BPF counters if there
> are too many events:
> 
> 	if (target.use_bpf && nr_cgroups &&
> 	    (evsel_list->core.nr_entries / nr_cgroups) > BPERF_CGROUP__MAX_EVENTS) {
> 		pr_warning("Disabling BPF counters due to more events...");
> 		target.use_bpf = false;
> 	}
> 
> If this fallback is triggered, target.use_bpf becomes false, but the cgroups
> were already expanded with !target.use_bpf (which was false at the time),
> leaving the cgroup file descriptors uninitialized (-1).

I think it's a false alarm.  The evlist__expand_cgroup() is only used if
stat_config.cgroup_list is set and then it should not have nr_cgroups.
There's a check for that right before the call to the function.

So in that case, it cannot pass the if condition below and never set to
target.use_bpf to false.

Thanks,
Namhyung

