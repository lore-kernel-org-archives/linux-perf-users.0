Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7272D7B8;
	Mon, 30 Sep 2024 05:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727675484; cv=none; b=Nyw237CNAHBpadnWMuczVmIL+AUBGoPuVijDXcLXuXMcHhk7GFndv9xz2IoWWkEuvPGi6J0U+TpF6NsIT4QNguLuhtObqK/7ksZ4a1OJGhzB9qpXPuyi+RVGObR8Ze2FAQuWZUsIRq9r5P4F6TwfXc9LQymF7rGc3618Snuz1Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727675484; c=relaxed/simple;
	bh=P3KrUjXmGQU+en/I6RCrcIaTYnE9hsm1t8CbIvIZ3UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ij6DLZouCQEBEe3JmHVPgYiQQdZeyiFn3RuzMYYS1oAvjYXqps4ZQfR5Ic2QjyUIvlbfI2P5UQAQGgHAnswFsdxSs1m7s2AcDhNrQhOadZib8iq11m226ruNoe4uRgI4oN18ZfMKOsEZpD80bePei/I3+YTth3d2EzbZbJYatMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krARsl6A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krARsl6A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3082DC4CECE;
	Mon, 30 Sep 2024 05:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727675483;
	bh=P3KrUjXmGQU+en/I6RCrcIaTYnE9hsm1t8CbIvIZ3UQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=krARsl6An0shxU+nn4e/ctWiAToDUml1Zkb580TGGaW9YGDtlCTFEP74CC1iebvAe
	 wx/45FdeXDQWtACYJQFduGpLS2eDbQdZMc+8wtoPyiHc+8E73+El9gKD8UpU+TvHPN
	 XoDuUWHwqlU4I1NLedAGxYWBrkxll38SKn/hlm2tG1mi1dmdk1kvGhNI3TDuCyyntS
	 Y29PSUxAMezJKAFUmf+45CAHzwYTnbUtKTBquQmZBMqyUKmOG3MbYIEVXfhkSmIb/j
	 MgxqC+KcSjb4PO1V7n+DhY5qYYCuErv8Jlw/HwPSgW33VEnLTqSUix/2RvR6y7gcTu
	 /WpJKwcW1BYoA==
Date: Sun, 29 Sep 2024 22:51:21 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/8] perf record --off-cpu: Parse offcpu-time event
Message-ID: <Zvo8Wa0XvUYMgatn@google.com>
References: <20240927202736.767941-1-howardchu95@gmail.com>
 <20240927202736.767941-4-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240927202736.767941-4-howardchu95@gmail.com>

On Fri, Sep 27, 2024 at 01:27:31PM -0700, Howard Chu wrote:
> Parse offcpu-time event using parse_event, in off_cpu_start(), write
> evlist fds got from evlist__open() to perf_event_array BPF map.
> 
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/util/bpf_off_cpu.c          | 56 +++++++++++++++-----------
>  tools/perf/util/bpf_skel/off_cpu.bpf.c |  9 +++++
>  2 files changed, 41 insertions(+), 24 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
> index eaef643f50e3..f7233a09ec77 100644
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
> @@ -36,41 +37,27 @@ union off_cpu_data {
>  	u64 array[1024 / sizeof(u64)];
>  };
>  
> +u64 off_cpu_raw_data[1024 / sizeof(u64)];
> +
>  static int off_cpu_config(struct evlist *evlist)
>  {
> -	struct evsel *evsel;
> -	struct perf_event_attr attr = {
> -		.type	= PERF_TYPE_SOFTWARE,
> -		.config = PERF_COUNT_SW_BPF_OUTPUT,
> -		.size	= sizeof(attr), /* to capture ABI version */
> -	};
> -	char *evname = strdup(OFFCPU_EVENT);
> -
> -	if (evname == NULL)
> -		return -ENOMEM;
> +	char off_cpu_event[64];
>  
> -	evsel = evsel__new(&attr);
> -	if (!evsel) {
> -		free(evname);
> -		return -ENOMEM;
> +	scnprintf(off_cpu_event, sizeof(off_cpu_event), "bpf-output/no-inherit=1,name=%s/", OFFCPU_EVENT);

Is the 'no-inherit=1' really needed?  I guess that's the default and
you won't need it if you open it as a per-cpu event.


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
>  	if (skel->rodata->has_task && skel->rodata->uses_tgid &&
> @@ -84,6 +71,27 @@ static void off_cpu_start(void *arg)
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

Where's it used?

> +
> +	perf_cpu_map__for_each_cpu(pcpu, i, evsel->core.cpus) {
> +		err = bpf_map__update_elem(skel->maps.offcpu_output,
> +					   &pcpu.cpu, sizeof(__u32),

I understand you used pcpu.cpu as a key to the offcpu_output map because
it's a basically per-cpu array.


> +					   xyarray__entry(evsel->core.fd, pcpu.cpu, 0),

But I suspect you should use 'i' instead of pcpu.cpu as an index to the
xyarray.

Thanks,
Namhyung


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
> diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> index 5ea320aa9a53..e2a887228fd9 100644
> --- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
> +++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> @@ -18,6 +18,8 @@
>  #define MAX_STACKS   32
>  #define MAX_ENTRIES  102400
>  
> +#define MAX_CPUS  4096
> +
>  struct tstamp_data {
>  	__u32 stack_id;
>  	__u32 state;
> @@ -39,6 +41,13 @@ struct {
>  	__uint(max_entries, MAX_ENTRIES);
>  } stacks SEC(".maps");
>  
> +struct {
> +	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> +	__uint(key_size, sizeof(__u32));
> +	__uint(value_size, sizeof(__u32));
> +	__uint(max_entries, MAX_CPUS);
> +} offcpu_output SEC(".maps");
> +
>  struct {
>  	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
>  	__uint(map_flags, BPF_F_NO_PREALLOC);
> -- 
> 2.43.0
> 
