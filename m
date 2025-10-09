Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF552BE7A7;
	Thu,  9 Oct 2025 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996350; cv=none; b=F+JrDYYNrRuTVnFHNdiCqRukEZYzCNNNfJaRkOnrY0bKonxY2BIbm2ixOFTSnhtAh5vMTd0yG6/B7Hlrnre+1cxabTa2Dn2led1tD6EMkg9oxqEuaoe4ZFQKqfnX9JRPv6B3TYRXfEYtzpFvdfRbldPALV6ups6TOIu4hU/ewYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996350; c=relaxed/simple;
	bh=8kwwddGg4oMEWNPflqm4C7Fd2mOvwuYEWTUuJXSTDEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nk2gYar3ETiOzMHqhWoogWsGUjHFaFKfgWROhW0OFMIo6DOVg1T06WK/2rdPeCCyM8t77TXhSKjOtTAHTDrNAnu0Fyt2OrII49JHbeR+jL0Y71m2JF/FMg8yljnYIaDmGm70vQkSX9qbq6ER1MTLUD9ZnukRtewYtOjPjyI87sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cj2Bz0bDmzKHLvG;
	Thu,  9 Oct 2025 15:51:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 98CDA1A13FE;
	Thu,  9 Oct 2025 15:52:23 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with SMTP id Syh0CgCX4RW2aedo1u4pCQ--.63468S2;
	Thu, 09 Oct 2025 15:52:23 +0800 (CST)
Message-ID: <02ac6916-7bfa-4b6b-8bae-64fe02580731@huaweicloud.com>
Date: Thu, 9 Oct 2025 15:52:22 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf bpf_counter: Fix opening of "any"(-1) CPU events
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251008162347.4005288-1-irogers@google.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20251008162347.4005288-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgCX4RW2aedo1u4pCQ--.63468S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1xCFyUur13Xry3JFWrZrb_yoWrXFWUpr
	4vkr13KryrXr90y3W3tF42ga4kCws5ZryYgwn8trWUGFsxX3sIqa17Ja45KryUWr1v9a4Y
	q34qgr4Uuay8JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2025/10/9 0:23, Ian Rogers wrote:
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
>  tools/perf/util/bpf_counter.c |  1 +
>  2 files changed, 14 insertions(+)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 7006f848f87a..0fc6884c1bf1 100644
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
> +		 * the bpf_counter variable.
> +		 */
> +		if (counter->bpf_counter)
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


I must point out that `requires_cpu + evsel__open(evsel, evsel->core.cpus, evsel->core.threads)` 
is not equivalent to the original `evsel__open_per_cpu(evsel, all_cpu_map, -1)`. The former
specifies a pid, while the latter does not. This will lead to inaccurate final event counting.


For `evsel__open_per_cpu(evsel, all_cpu_map, -1)`:

$ ./perf stat -vv --bpf-counters -e task-clock ./perf test -w sqrtloop
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 13
sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 14
sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 15
[...]
 Performance counter stats for './perf test -w sqrtloop':

     1,016,156,671      task-clock                       #    1.000 CPUs utilized             

       1.016294745 seconds time elapsed

       1.005710000 seconds user
       0.010637000 seconds sys


For `requires_cpu + evsel__open(evsel, evsel->core.cpus, evsel->core.threads)`:

$ ./perf stat -vv --bpf-counters -e task-clock ./perf test -w sqrtloop
sys_perf_event_open: pid 75099  cpu 0  group_fd -1  flags 0x8 = 13
sys_perf_event_open: pid 75099  cpu 1  group_fd -1  flags 0x8 = 14
sys_perf_event_open: pid 75099  cpu 2  group_fd -1  flags 0x8 = 15
[...]
 Performance counter stats for './perf test -w sqrtloop':

        16,184,507      task-clock                       #    0.016 CPUs utilized             

       1.018540734 seconds time elapsed

       1.009143000 seconds user
       0.009497000 seconds sys


As you can see, after specifying a pid, the task-clock count has significantly decreased.
So to correct the counting, we may also need to keep the pid as -1 without specifying it.

Thanks,
Tengda

