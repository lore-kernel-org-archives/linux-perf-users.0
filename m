Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07DD2F1FE1;
	Wed,  8 Oct 2025 07:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759908930; cv=none; b=ug0p2UNoHVSAlG/Gxsg9VLuVbTSF2nPNu8j+Ae7daoTMQRTl5RGWGy8ukRP75hELtzxNJZTSUiVpt54uEik5iscA/bI5USNocGMZENPFDo22gJwmHyhiMXnrse3umgyFdEwEdS7NWQMOH8qLQzvqsFfL5l5SOml08syoODigL40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759908930; c=relaxed/simple;
	bh=TK/uviFFMNE2V5+nUNwLfxLce1AfY4qZki5torwTTps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lE5Ao6WbcL4sSjP6BIvQftTu3HvXFLXZaVF/4jipP7bhfrcVVNOExudvBOqDGz4fwXFs6nox7nqA5YchIba9w7bzhyjQ5+nEq71w56i33ELYIsq6T/VYXT7CSo4Yxxg/7NcbRW2DOQ9BYQdJovgTncSRH8pHVA7Pe9N951RvrVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFGpnXtO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFGpnXtO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2E9C4CEF4;
	Wed,  8 Oct 2025 07:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759908930;
	bh=TK/uviFFMNE2V5+nUNwLfxLce1AfY4qZki5torwTTps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qFGpnXtOc8YuoR+y6MRQe46Fys5QvoydJirLuBJgyGloesWHI6IX9HBK55k/JvVmb
	 PRq4BN8UuNfq/JmEHcviCpKN49AMJwBA2z+v/JYDaWVj2YpjAl4Ew9ylHZ1Suq95N3
	 gMZK9Ezt5ySbtGv7n5mpfiuvZVfGplY07C6FqW31382NUUbekcNALxROz4+fd+LBUe
	 RwBVIpxluBYk3anMepAc7iPcnVSWtLpMftJcOHQ0gmUtQ0w/SRrQzCA8ITPWzRRFXP
	 8druukSrY+uoB2utMWjnKFJT/Pr+8neIKaK/7ukWicVosm6dh6F9ywfC0X379owwQH
	 wPa/9A2h3/AeA==
Date: Wed, 8 Oct 2025 16:35:25 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Tengda Wu <wutengda@huaweicloud.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf bpf_counter: Fix opening of "any"(-1) CPU events
Message-ID: <aOYUPWbyQv53hrjE@google.com>
References: <20251007185826.3674908-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251007185826.3674908-1-irogers@google.com>

Hi Ian,

On Tue, Oct 07, 2025 at 11:58:26AM -0700, Ian Rogers wrote:
> The bperf BPF counter code doesn't handle "any"(-1) CPU events, always
> wanting to aggregate a count against a CPU, which avoids the need for
> atomics. Force evsels used for BPF counters to require a CPU when not
> in system-wide mode so that the "any"(-1) value isn't used during map
> propagation and evsel's CPU map matches that of the PMU.
> 
> Fixes: b91917c0c6fa ("perf bpf_counter: Fix handling of cpumap fixing hybrid")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-stat.c     | 12 ++++++++++++
>  tools/perf/util/bpf_counter.c |  1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 7006f848f87a..7fdc7f273a48 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2797,6 +2797,18 @@ int cmd_stat(int argc, const char **argv)
>  
>  	evlist__warn_user_requested_cpus(evsel_list, target.cpu_list);
>  
> +	if (target.use_bpf && !target.system_wide) {

The target.use_bpf only checks the --bpf-counters option.  But IIUC it's
possible to use BPF only for selected events with ':b' modifier.  I
think you need to check each evsel with evsel__is_bperf().

Also system_wide might not be set for -C/--cpu option.  Probably you
want target__has_cpu() instead of target.system_wide.

Thanks,
Namhyung


> +		/*
> +		 * Setup BPF counters to require CPUs as any(-1) isn't
> +		 * supported. evlist__create_maps below will propagate this
> +		 * information to the evsels.
> +		 */
> +		struct evsel *counter;
> +
> +		evlist__for_each_entry(evsel_list, counter)
> +			counter->core.requires_cpu = true;
> +	}
> +
>  	if (evlist__create_maps(evsel_list, &target) < 0) {
>  		if (target__has_task(&target)) {
>  			pr_err("Problems finding threads of monitor\n");
> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> index ca5d01b9017d..d3e5933b171b 100644
> --- a/tools/perf/util/bpf_counter.c
> +++ b/tools/perf/util/bpf_counter.c
> @@ -495,6 +495,7 @@ static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
>  	 * following evsel__open_per_cpu call
>  	 */
>  	evsel->leader_skel = skel;
> +	assert(!perf_cpu_map__has_any_cpu_or_is_empty(evsel->core.cpus));
>  	evsel__open(evsel, evsel->core.cpus, evsel->core.threads);
>  
>  out:
> -- 
> 2.51.0.710.ga91ca5db03-goog
> 
