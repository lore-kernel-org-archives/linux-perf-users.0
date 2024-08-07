Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F71E145FF5;
	Wed,  7 Aug 2024 23:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723073151; cv=none; b=XYJ/VhYYZP9nt7Aj4vjVMqyUib477m2aVEyaXbS1SPBILG4CkvOdGH+tersv7Hs8ppGyqKFhdHtXbddwP4+KgSNaOLoJKhYdlUWYspNCV9bbYNNndOWciQ9fW20A/5FhsjEMMwPJgx2Btwu3m974TrZoqDLNCHYNQvNhZGgw1xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723073151; c=relaxed/simple;
	bh=fHY76M/H9pGxgX2OPWiXt01007xTeEUbz2O/iNpJrLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAZCW0rPco3MFDqrf4R3kIusAQFFl1MLj6zLCs+Z7/VB+B7iOyHgCYleuRZq8LxOaFdtmiQzggmvPHm1Y8cVw4Pl4Pa4fbFZC8Vzxis5srNwzD2B0gcDAVhMsoFNYOy/JiKTiexF0p76TjWOZqHPpf0fKZK0cC85QZV5HiG6s34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoabwbnZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoabwbnZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CA1C32781;
	Wed,  7 Aug 2024 23:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723073151;
	bh=fHY76M/H9pGxgX2OPWiXt01007xTeEUbz2O/iNpJrLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OoabwbnZ0rnouuqReNKKoPsfbdHQi0Izea3hLk+l30DOVO3YrH1PVTWLNb1dtcLV8
	 ILD2q9iJf+IsgzYk+XEWPlN7X5Caisjspd/Fgu/uT9GLHm+ZLgfd8WpQ+34fc64WGm
	 STUtBQNRCMadv1avtK8VFfe0GMr7DJx68hfDCWZnEmhg0rXMj3lDO/iERbGkiQsFZc
	 sphBpmqZg6oW1lnRlpDOTygmL6h0SHwFeFdYYgYv8UkEN28uXOJdBk22FyxSmPoXdp
	 P+bGPEfNeOEeaA851o9XaakGpQBGumL4TmHneLjwq15Y6FlpTIOEFOR0A5K+2jO+r/
	 F9GkB1C2l1frA==
Date: Wed, 7 Aug 2024 16:25:49 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com,
	jolsa@kernel.org, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/9] perf record --off-cpu: Parse offcpu-time event
Message-ID: <ZrQCfQOzWpfr6SNT@google.com>
References: <20240807153843.3231451-1-howardchu95@gmail.com>
 <20240807153843.3231451-4-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240807153843.3231451-4-howardchu95@gmail.com>

On Wed, Aug 07, 2024 at 11:38:37PM +0800, Howard Chu wrote:
> Parse offcpu-time event using parse_event, in off_cpu_start(), write
> evlist fds got from evlist__open() to perf_event_array BPF map.
> 
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/util/bpf_off_cpu.c | 55 ++++++++++++++++++++---------------
>  tools/perf/util/evsel.c       |  2 +-
>  2 files changed, 32 insertions(+), 25 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
> index 1e0e454bfb5e..fae0bb8aaa13 100644
> --- a/tools/perf/util/bpf_off_cpu.c
> +++ b/tools/perf/util/bpf_off_cpu.c
> @@ -13,6 +13,7 @@
>  #include "util/cgroup.h"
>  #include "util/strlist.h"
>  #include <bpf/bpf.h>
> +#include <internal/xyarray.h>
>  
>  #include "bpf_skel/off_cpu.skel.h"
>  
> @@ -38,39 +39,24 @@ union off_cpu_data {
>  
>  static int off_cpu_config(struct evlist *evlist)
>  {
> -	struct evsel *evsel;
> -	struct perf_event_attr attr = {
> -		.type	= PERF_TYPE_SOFTWARE,
> -		.config = PERF_COUNT_SW_BPF_OUTPUT,
> -		.size	= sizeof(attr), /* to capture ABI version */
> -	};
> -	char *evname = strdup(OFFCPU_EVENT);
> +	char off_cpu_event[64];
>  
> -	if (evname == NULL)
> -		return -ENOMEM;
> -
> -	evsel = evsel__new(&attr);
> -	if (!evsel) {
> -		free(evname);
> -		return -ENOMEM;
> +	/* after parsing off-cpu event, we'll specify its sample_type in evsel__config() */
> +	scnprintf(off_cpu_event, sizeof(off_cpu_event), "bpf-output/no-inherit=1,name=%s/", OFFCPU_EVENT);
> +	if (parse_event(evlist, off_cpu_event)) {
> +		pr_err("Failed to open off-cpu event\n");
> +		return -1;
>  	}
>  
> -	evsel->core.attr.freq = 1;
> -	evsel->core.attr.sample_period = 1;
> -	/* off-cpu analysis depends on stack trace */
> -	evsel->core.attr.sample_type = PERF_SAMPLE_CALLCHAIN;
> -
> -	evlist__add(evlist, evsel);
> -
> -	free(evsel->name);
> -	evsel->name = evname;
> -
>  	return 0;
>  }
>  
>  static void off_cpu_start(void *arg)
>  {
>  	struct evlist *evlist = arg;
> +	struct evsel *evsel;
> +	struct perf_cpu pcpu;
> +	int i, err;
>  
>  	/* update task filter for the given workload */
>  	if (!skel->bss->has_cpu && !skel->bss->has_task &&
> @@ -86,6 +72,27 @@ static void off_cpu_start(void *arg)
>  		bpf_map_update_elem(fd, &pid, &val, BPF_ANY);
>  	}
>  
> +	/* sample id and fds in BPF's perf_event_array can only be set after record__open() */
> +	evsel = evlist__find_evsel_by_str(evlist, OFFCPU_EVENT);
> +	if (evsel == NULL) {
> +		pr_err("%s evsel not found\n", OFFCPU_EVENT);
> +		return;
> +	}
> +
> +	if (evsel->core.id)
> +		skel->bss->sample_id = evsel->core.id[0];
> +
> +	perf_cpu_map__for_each_cpu(pcpu, i, evsel->core.cpus) {
> +		err = bpf_map__update_elem(skel->maps.offcpu_output,
> +					   &pcpu.cpu, sizeof(__u32),
> +					   xyarray__entry(evsel->core.fd, pcpu.cpu, 0),
> +					   sizeof(__u32), BPF_ANY);
> +		if (err) {
> +			pr_err("Failed to update perf event map for direct off-cpu dumping\n");
> +			return;
> +		}
> +	}
> +
>  	skel->bss->enabled = 1;
>  }
>  
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index b961467133cf..ccd3bda02b5d 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1379,7 +1379,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
>  		evsel__reset_sample_bit(evsel, BRANCH_STACK);
>  
>  	if (evsel__is_offcpu_event(evsel))
> -		evsel->core.attr.sample_type &= OFFCPU_SAMPLE_TYPES;
> +		evsel->core.attr.sample_type = OFFCPU_SAMPLE_TYPES;

I don't think we need this.  It should check what you requested.
IOW you don't need to put cgroup info when user didn't ask.

Thanks,
Namhyung

>  
>  	arch__post_evsel_config(evsel, attr);
>  }
> -- 
> 2.45.2
> 
