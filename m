Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD954145355;
	Sat, 11 Oct 2025 01:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760146686; cv=none; b=OMI5k6/7O+i7we3PS7CFKCB2nV1lkw7BsncvzgDSScOz6In//nrDIdc6DcDG1/hZHrVcM2uWEkwNo3HJZD4LXXZtlKTZtgQOLWr4hBoi/NquDuuWupR+pL7T8H/ea5DpxMgjfVzqFkhuD06Zb+UKGVP0WjD+cMq80vNViX+Hias=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760146686; c=relaxed/simple;
	bh=KV4P8Pbbex7tkS+FOkMZuTLiEJIxggXu/zbqfPV2C1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=GVTDs1+uH28Xk1wjkTt/VEJZtl93c3CPEx7twxNJbLMvVH9Hjk6r0NQEXfPZepnJUdBZP6SXdmGgcVKweQZGUN1KqsJ2m5B92wAjfSyKOSiHUiJzCLLJcxmxxSjmKM0YYdeox8jjZ/mEKPN/HLyqmUCZhvK3290nDhtAdQ782p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ck5nx1P9TzYQtqv;
	Sat, 11 Oct 2025 09:37:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 6CE0D1A0A11;
	Sat, 11 Oct 2025 09:38:00 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with SMTP id Syh0CgCHHRL3tOloYNDtCQ--.38750S2;
	Sat, 11 Oct 2025 09:38:00 +0800 (CST)
Message-ID: <dfda7f8b-1803-45c8-b914-4211651aa43c@huaweicloud.com>
Date: Sat, 11 Oct 2025 09:37:58 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf bpf_counter: Fix opening of "any"(-1) CPU events
To: Ian Rogers <irogers@google.com>
References: <20251009132912.141116-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20251009132912.141116-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgCHHRL3tOloYNDtCQ--.38750S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1xCFyUur13Xry3JFWrZrb_yoW5CrWrpr
	4vkr17G34rJrZ0v3W3Ja17WFWrKw1rWF4Yg3s3trWUJFn3XrnIq34rJa45KF1Ygr409F1Y
	qrn0gr4Uua97JrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2025/10/9 21:29, Ian Rogers wrote:
> The bperf BPF counter code doesn't handle "any"(-1) CPU events, always
> wanting to aggregate a count against a CPU, which avoids the need for
> atomics so let's not change that. Force evsels used for BPF counters
> to require a CPU when not in system-wide mode so that the "any"(-1)
> value isn't used during map propagation and evsel's CPU map matches
> that of the PMU.
> 
> Fixes: b91917c0c6fa ("perf bpf_counter: Fix handling of cpumap fixing hybrid")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-stat.c     | 13 +++++++++++++
>  tools/perf/util/bpf_counter.c |  7 ++++++-
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 7006f848f87a..f1c9d6c94fc5 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2540,6 +2540,7 @@ int cmd_stat(int argc, const char **argv)
>  	unsigned int interval, timeout;
>  	const char * const stat_subcommands[] = { "record", "report" };
>  	char errbuf[BUFSIZ];
> +	struct evsel *counter;
>  
>  	setlocale(LC_ALL, "");
>  
> @@ -2797,6 +2798,18 @@ int cmd_stat(int argc, const char **argv)
>  
>  	evlist__warn_user_requested_cpus(evsel_list, target.cpu_list);
>  
> +	evlist__for_each_entry(evsel_list, counter) {
> +		/*
> +		 * Setup BPF counters to require CPUs as any(-1) isn't
> +		 * supported. evlist__create_maps below will propagate this
> +		 * information to the evsels. Note, evsel__is_bperf isn't yet
> +		 * set up, and this change must happen early, so directly use
> +		 * the bpf_counter variable and target information.
> +		 */
> +		if ((counter->bpf_counter || target.use_bpf) && !target__has_cpu(&target))
> +			counter->core.requires_cpu = true;
> +	}
> +
>  	if (evlist__create_maps(evsel_list, &target) < 0) {
>  		if (target__has_task(&target)) {
>  			pr_err("Problems finding threads of monitor\n");
> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> index ca5d01b9017d..a5882b582205 100644
> --- a/tools/perf/util/bpf_counter.c
> +++ b/tools/perf/util/bpf_counter.c
> @@ -460,6 +460,7 @@ static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
>  	struct bperf_leader_bpf *skel = bperf_leader_bpf__open();
>  	int link_fd, diff_map_fd, err;
>  	struct bpf_link *link = NULL;
> +	struct perf_thread_map *threads;
>  
>  	if (!skel) {
>  		pr_err("Failed to open leader skeleton\n");
> @@ -495,7 +496,11 @@ static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
>  	 * following evsel__open_per_cpu call
>  	 */
>  	evsel->leader_skel = skel;
> -	evsel__open(evsel, evsel->core.cpus, evsel->core.threads);
> +	assert(!perf_cpu_map__has_any_cpu_or_is_empty(evsel->core.cpus));
> +	/* Always open system wide. */
> +	threads = thread_map__new_by_tid(-1);
> +	evsel__open(evsel, evsel->core.cpus, threads);
> +	perf_thread_map__put(threads);
>  
>  out:
>  	bperf_leader_bpf__destroy(skel);

LGTM.

Tengda

