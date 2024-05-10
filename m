Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CE012C46B;
	Fri, 10 May 2024 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715349250; cv=none; b=n6RQyPlFuTNgnO5R2dDZbP4EfOCfxm64EhRm9o4Uzuhd6/eczKCYRQP17ayRd/lJOgNKi+PsFlPO/r2f4qoAJrEiNEj4oJQk1yVHcw98EdE+wNxaDSG5KEblXXEE3kI/we/9o6bJIhHQUc06lCbyNegoQXpEKugjQrsrWGE8igU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715349250; c=relaxed/simple;
	bh=JykUQXVZnA9s05U9WJm3I8AGGS491GmkM8kocE4qnpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkWIVJggcY5ymRYZanZGPn+L6aheoDPqTPS7J/MQuVZYrXVszQMUUxszTNiPGnPTjb4pdGes/bliF9W4iZCTO2UyC1mNvjFaFjhGiEXBti7rb8SF/waB7ABoejzNPCxy5cUtO+S3aRXSfLgCa+sxMWVyL9XW0CfV0zisKgolMM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfhZINet; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfhZINet"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10557C2BBFC;
	Fri, 10 May 2024 13:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715349250;
	bh=JykUQXVZnA9s05U9WJm3I8AGGS491GmkM8kocE4qnpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TfhZINetWAppiYJSpUU15y4ofywLmWA44autqYr1VIuwdzpv6JdWGvkHR1v5Y5vVa
	 KtSU9ohVTJWtu4sKjk8wxgv6QJzgZICVXw1o08Ft39frocdEavTw1OaJCPiazvjYkQ
	 zPoXXMvZkfjF50z9Z1c3ozMBKe4wl80zB/rNOhnRp8vyokr7HtaxZfQBHuO7Rb3oOM
	 HMTEbTJFmVFDuTd9j++6RZQkw/39aPQBnYMxWXqhfaR8VomSOUQkOi6j6tOFVyj8uV
	 fSQN0GqnIoYYpOQpTTZc8QkpVwdRyPCE781v4wSUWCL4w5onowxstu2qht+WHdTy+m
	 zv3r23SrWeNXg==
Date: Fri, 10 May 2024 10:54:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf tools: Ignore deleted cgroups
Message-ID: <Zj4m_v5uEjmSLMb0@x1>
References: <20240509182235.2319599-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509182235.2319599-1-namhyung@kernel.org>

On Thu, May 09, 2024 at 11:22:35AM -0700, Namhyung Kim wrote:
> On a large system, cgroups can be created and deleted often.  That means
> there's a race between perf tools and cgroups when it gets the cgroup
> name and opens the cgroup.  I got a report that perf stat with many
> cgroups failed a quite often due to the missing cgroups on such a large
> machine.
> 
> I think we can ignore such cgroups when expanding events and use id 0 if
> it fails to read the cgroup id.  IIUC 0 is not a vaild cgroup id so it
> won't update event counts for the failed cgroups.

Thanks, applied to perf-tools-next,

- Arnaldo
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/bpf_counter_cgroup.c | 5 ++---
>  tools/perf/util/cgroup.c             | 4 +++-
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
> index 1c82377ed78b..ea29c372f339 100644
> --- a/tools/perf/util/bpf_counter_cgroup.c
> +++ b/tools/perf/util/bpf_counter_cgroup.c
> @@ -136,9 +136,8 @@ static int bperf_load_program(struct evlist *evlist)
>  		cgrp = evsel->cgrp;
>  
>  		if (read_cgroup_id(cgrp) < 0) {
> -			pr_err("Failed to get cgroup id\n");
> -			err = -1;
> -			goto out;
> +			pr_debug("Failed to get cgroup id for %s\n", cgrp->name);
> +			cgrp->id = 0;
>  		}
>  
>  		map_fd = bpf_map__fd(skel->maps.cgrp_idx);
> diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
> index fcb509058499..0f759dd96db7 100644
> --- a/tools/perf/util/cgroup.c
> +++ b/tools/perf/util/cgroup.c
> @@ -465,9 +465,11 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str,
>  		name = cn->name + prefix_len;
>  		if (name[0] == '/' && name[1])
>  			name++;
> +
> +		/* the cgroup can go away in the meantime */
>  		cgrp = cgroup__new(name, open_cgroup);
>  		if (cgrp == NULL)
> -			goto out_err;
> +			continue;
>  
>  		leader = NULL;
>  		evlist__for_each_entry(orig_list, pos) {
> -- 
> 2.45.0.118.g7fe29c98d7-goog
