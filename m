Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644F2366DB9;
	Thu,  4 Jun 2026 20:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780605741; cv=none; b=r9VnKMUpQoWi98sSQAUH8jdslXKGLnmR3Ag+rvJ2/VS/2SEuCumb6ebKzNfYAlSMszABCdpoCMqTfD6oTMWZa2efodc2iR7sB18TYSxaMZ3N4onHgeh//UN49Tsp0A6AYLrKXLEl/Jf42nswlw4CB3FjgtAMcDuyuzvODqUEo/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780605741; c=relaxed/simple;
	bh=Z3fxOrbgiFCujm61gNgwZ5fCkgCxx+qtp67/u1z2ioU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avfm9V/+fu+H3wM07VR3yY0J8PcnbZz2FYRBKHruDK8KxIQ5UmZ5H9+l0Zvdc2HatCc6UhZKI42AWBe4Uyij8QXLs3BG1dVs4fjbdTBY59lCD7cuNGlWEsdtApKFttl1TPjwxWqhTysq6XGOgGJJlAUWRkmaOUCSXlGZzXn7XHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sf8UGZEx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sf8UGZEx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCAE1F00893;
	Thu,  4 Jun 2026 20:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780605740;
	bh=txq3vHUfagQTEfXkHZ/xabBiG7M8uCFwxdCufHVEUxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Sf8UGZExx5VsV4oE3wXe1TinXWW2SgtH/8LusiU1lJTbMJEtKXfITMYRkOwXDPkCn
	 OP7Gbo80rAxygBUsPpdcKQB695s397RPdNNnqUAt4rJQdYjj0G4uEgcRRn/cGd12rT
	 tPa4I0wqYuj1g0dCmldUIhgXcMBZxdusKHv1/xg8/BH4+RFxKJ/yX3YrJwfEddhgDV
	 ZmB4H6KH5eQX5Vy/HuOKDkXQrRYtep4W6gkztGLBO1eavPkze7k2VUq1lXJaqWa0Fq
	 SWZAJwWcD614Rbhtl0kB1UA2lksSP5Dkmu9OQ1l1jETARGfCMnfU3w10xzMxi/ndis
	 qzaADYZtR7tSA==
Date: Thu, 4 Jun 2026 17:42:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 4/4] perf sched: Fix comp_cpus heap overflow with
 cross-machine recordings
Message-ID: <aiHjKUD8Ks1BJ_Hc@x1>
References: <20260604201119.1702338-5-acme@kernel.org>
 <20260604202605.99EFC1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260604202605.99EFC1F00898@smtp.kernel.org>

On Thu, Jun 04, 2026 at 08:26:05PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Removing the `sched->max_cpu.cpu` initialization introduces a severe off-by-one error, causing `perf sched map` to truncate the highest CPU from its output and print nothing for single-CPU traces.
> --
> 
> commit 4c1487bde6fa91cfb4bca7de01bfd611065c7c9a
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> perf sched: Fix comp_cpus heap overflow with cross-machine recordings
> 
> This commit fixes a heap buffer overflow by allocating comp_cpus with
> MAX_CPUS and the correct element size. It also removes the initial assignment
> of max_cpu from the host's CPU count.
> 
> > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> > index 36da451447b5e..80e42536400a9 100644
> > --- a/tools/perf/builtin-sched.c
> > +++ b/tools/perf/builtin-sched.c
> > @@ -3573,10 +3573,8 @@ static int perf_sched__lat(struct perf_sched *sched)
> >  
> >  static int setup_map_cpus(struct perf_sched *sched)
> >  {
> > -	sched->max_cpu.cpu  = sysconf(_SC_NPROCESSORS_CONF);
> > -
> 
> [Severity: Medium]
> Does removing this initialization cause an off-by-one error when rendering
> the schedule map?
> 
> Without this initialization, sched->max_cpu.cpu tracks the maximum 0-based
> CPU index seen in the trace. However, when compact mode is disabled,
> map_switch_event() assigns this 0-based index directly to cpus_nr:
> 
> tools/perf/builtin-sched.c:map_switch_event() {
>         ...
>         } else
>                 cpus_nr = sched->max_cpu.cpu;
>         ...
> }
> 
> Then print_sched_map() iterates strictly less than cpus_nr:
> 
> tools/perf/builtin-sched.c:print_sched_map() {
>         ...
>         for (int i = 0; i < cpus_nr; i++) {
>         ...
> }
> 
> Will this skip the highest CPU column entirely, and print nothing for 
> single-CPU traces where cpus_nr becomes 0?

Legit, v2 will have a fix for this, the sysconf() was just masking a
pre-existing problem.

- Arnaldo
 
> >  	if (sched->map.comp) {
> > -		sched->map.comp_cpus = calloc(sched->max_cpu.cpu, sizeof(int));
> > +		sched->map.comp_cpus = calloc(MAX_CPUS, sizeof(*sched->map.comp_cpus));
> >  		if (!sched->map.comp_cpus)
> >  			return -1;
> >  	}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260604201119.1702338-1-acme@kernel.org?part=4
