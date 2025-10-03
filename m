Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655502DEA6F
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Oct 2025 12:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759493011; cv=none; b=QwTN2IgvJAeWajUHaLvjBC9ey6orpVdRN97ra2e+Y/8bgB9r2ABP/ztT6FZhsVmdg7XJOlldLLBgyw16qQZb4GM4x0uwjbaVYj75WPDJE/DdedJAPonqb9dYzodkugfYK//7c53Cg60/XPDp1j8n4r1IXRshQKr66a+JTzJIXe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759493011; c=relaxed/simple;
	bh=yv+S/jnE7az3NpTH9ALrZjC5rcuBgoQb8XWCpPhTDX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Vu1ozlecPJXPoGumZj1s+SJIdeRMEJKQIeG3VBFIgEc6PUfZ2cIJpkQyEydBxlZJx1HQhY8jAxV6lnIj2h28Eq/tABIRmtxTcl768AKSppyCfye652wbJsmPmQx19GCz2XnozlmH7QrbRwTuIcUOtVtRTFNZtmOAOAN3aGB+UOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kRMU8Afg; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kRMU8Afg"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e4473d7f6so13208175e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Oct 2025 05:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759493008; x=1760097808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g/yPmNq+D49WFMiq3UChUnkB5ipVol1o/yzWT8SNKXA=;
        b=kRMU8AfgRRK87vuHOX7G+UB5Ylrl213q5v+XEh4opBsf2sV9nSRM7cDcrFj68UrOfW
         OhFa9uywsFhFGn2WySOwHQ9WSqwiuw2YhQdMjNwstzS1Za2xVKu3ki4QRF606BVZPBJe
         IbSgC1ZU3I5jvruBmJ7YQKbHsC3kt7V3+UfzAK05Et4zBcdyIhAIQeG1bKiqhbNUAX+D
         K7d4BkqV6HoO2N22t9/4zgUROftgfmqhUxZxQ4ipQo37Bl6UhO0vEHcD/2x5HzYydVnn
         troPh00PfQD2qtqYWgK5q0rE/JoGyLk1ZOVO3g5A6kYuG0Ei2GADbKFYVRWXztiXw70b
         8eCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759493008; x=1760097808;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g/yPmNq+D49WFMiq3UChUnkB5ipVol1o/yzWT8SNKXA=;
        b=ES7jjFk9l3p9B1nOO23Y26mnvXytdwn8Ho/Itn2tXWTrRDH0WkgYdtq5CgWQEDw556
         LTZuQlsZyXWVmYKCh2emV7HNCxc8t0jY8ncP5Gd0mO7LYGjffFh/yPlZwOCqsJygYgaF
         qPqf3ear4MMi0qOqR1xy6QyObewh9BOLipD0xf7XQZjffbLMBuKiBgnT6H11E0+6UMd4
         Smy9AosnQuHq+8r1ZfrVuVKeonfEMPbOqQDiG4tXw9Bxa0t12+l+rrpb37xn0jqA31GM
         JM+TwcQZvUYYsUNWl5jyPeb/OoR+Y1A4WgjLA7sol7bkxNyl/p697tDCkLs+VwlBeApX
         +hfw==
X-Forwarded-Encrypted: i=1; AJvYcCXX7m0kBF1cFR0xExLC2dCMKtWqy3wc3aqkO/HFeuVL6NwyU94nW83reVjnfKu1mAAZwXbNmvFk+jYALcn6mErH@vger.kernel.org
X-Gm-Message-State: AOJu0Yz71JfGpq2Hvi4rEzJkPBnwlBhP8UQcogTvzF2zxz2pFgFSVPY7
	uzJwzf1tJATDs8VE5wG7H0Kp4ShPb28Nu7RogStbR3RF/IQITII7VnRmai6AXpa/9DY=
X-Gm-Gg: ASbGnct5a2Y2brnHjU1jjR8zOcboPeY5auBg9HerPnxWz07SiglL0i7MfzBTW9lZYeO
	F03Efh5JUhhAWFWIjeYUZsCAy8PVZHY4BVB8CGBgLW2h3iRrTpbEfQJVWrtOaKibroccbJ6G2aK
	jwf6aStOZVuBNsT0LUU/0iyJBb25/v/kUOH1szoPd/K55+xuVNE2x43NxAAd1ZSj4vAJ2HQn+uw
	uT5jvQNLTapi25OtG4G8wEzYDRHRYLXL4dd9NmPnIwbMDzyKaNjt9MXefjnLR/OOHAzTvRdsmOO
	3g18xcnzL2XKBqhKRmt0sWV2JOoQoObdnjYE2DSZRSOpsIeCTMhGEqhf7m/SjPf1EJqDc6feCka
	qkgawDY0INGlxh9N0W0sfZevuhOSe3Q8wtZkSFld+dE4q1taYuluf7o5Z
X-Google-Smtp-Source: AGHT+IGiDvKHZeSwoGJi2fPM5QafQx+012inaI/gsWAWOkcZnCRwqejgLweqHyQP6YdFfaxSjF9h8g==
X-Received: by 2002:a05:600c:4e01:b0:450:cabd:b4a9 with SMTP id 5b1f17b1804b1-46e711465d9mr19121825e9.29.1759493007359;
        Fri, 03 Oct 2025 05:03:27 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5c4afd27sm74467365e9.7.2025.10.03.05.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 05:03:26 -0700 (PDT)
Message-ID: <4a49c58a-4b07-456c-a2e6-67d04b905944@linaro.org>
Date: Fri, 3 Oct 2025 13:03:25 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] perf stat: Refactor retry/skip/fatal error
 handling
To: Ian Rogers <irogers@google.com>
References: <20251002220727.1889799-1-irogers@google.com>
 <20251002220727.1889799-2-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>,
 Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251002220727.1889799-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/10/2025 11:07 pm, Ian Rogers wrote:
> For the sake of Intel topdown events commit 9eac5612da1c ("perf stat:
> Don't skip failing group events") changed perf stat error handling
> making it so that more errors were fatal and didn't report "<not
> supported>" events. The change outside of topdown events was
> unintentional.
> 
> The notion of "fatal" error handling was introduced in commit
> e0e6a6ca3ac2 ("perf stat: Factor out open error handling") and refined
> in commits like commit cb5ef60067c1 ("perf stat: Error out unsupported
> group leader immediately) to be an approach for avoiding later
> assertion failures in the code base. This change fixes those issues
> and removes the notion of a fatal error on an event. If all events
> fail to open then a fatal error occurs with the previous fatal error
> message. This seems to best match the notion of supported events and
> allowing some errors not to stop perf stat, while allowing the truly
> fatal no event case to terminate the tool early.
> 
> The evsel->errored flag is only used in the stat code but always just
> meaning !evsel->supported although there is a comment about it being
> sticky. Force all evsels to be supported in evsel__init and then clear
> this when evsel__open fails. When an event is tried the supported is
> set to true again. This simplifies the notion of whether an evsel is
> broken.
> 
> In the get_group_fd code, fail to get a group fd when the evsel isn't
> supported. If the leader isn't supported then it is also expected that
> there is no group_fd as the leader will have been skipped. Therefore
> change the BUG_ON test to be on supported rather than skippable. This
> corrects the assertion errors that were the reason for the previous
> fatal error handling.
> 
> Fixes: 9eac5612da1c ("perf stat: Don't skip failing group events")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> v2: Missed setting supported for weak groups. When no supported
>      events, report the error on the first event in the evlist.
> 
> An earlier version of this fix exists in:
> https://lore.kernel.org/lkml/20250923223312.238185-2-irogers@google.com/
> This version is more thorough and tries to make the overall code base
> more consistent.
> ---

Reviewed-by: James Clark <james.clark@linaro.org>

>   tools/perf/builtin-record.c |   2 -
>   tools/perf/builtin-stat.c   | 123 +++++++++++++++---------------------
>   tools/perf/util/evsel.c     |  40 +++++++-----
>   tools/perf/util/evsel.h     |   1 -
>   4 files changed, 76 insertions(+), 90 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 7ea3a11aca70..d76f01956e33 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1408,8 +1408,6 @@ static int record__open(struct record *rec)
>   			ui__error("%s\n", msg);
>   			goto out;
>   		}
> -
> -		pos->supported = true;
>   	}
>   
>   	if (symbol_conf.kptr_restrict && !evlist__exclude_kernel(evlist)) {
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 75b9979c6c05..7006f848f87a 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -610,22 +610,13 @@ static int dispatch_events(bool forks, int timeout, int interval, int *times)
>   enum counter_recovery {
>   	COUNTER_SKIP,
>   	COUNTER_RETRY,
> -	COUNTER_FATAL,
>   };
>   
>   static enum counter_recovery stat_handle_error(struct evsel *counter, int err)
>   {
>   	char msg[BUFSIZ];
>   
> -	if (counter->skippable) {
> -		if (verbose > 0) {
> -			ui__warning("skipping event %s that kernel failed to open .\n",
> -				    evsel__name(counter));
> -		}
> -		counter->supported = false;
> -		counter->errored = true;
> -		return COUNTER_SKIP;
> -	}
> +	assert(!counter->supported);
>   
>   	/*
>   	 * PPC returns ENXIO for HW counters until 2.6.37
> @@ -636,19 +627,16 @@ static enum counter_recovery stat_handle_error(struct evsel *counter, int err)
>   			ui__warning("%s event is not supported by the kernel.\n",
>   				    evsel__name(counter));
>   		}
> -		counter->supported = false;
> -		/*
> -		 * errored is a sticky flag that means one of the counter's
> -		 * cpu event had a problem and needs to be reexamined.
> -		 */
> -		counter->errored = true;
> -	} else if (evsel__fallback(counter, &target, err, msg, sizeof(msg))) {
> +		return COUNTER_SKIP;
> +	}
> +	if (evsel__fallback(counter, &target, err, msg, sizeof(msg))) {
>   		if (verbose > 0)
>   			ui__warning("%s\n", msg);
> +		counter->supported = true;
>   		return COUNTER_RETRY;
> -	} else if (target__has_per_thread(&target) && err != EOPNOTSUPP &&
> -		   evsel_list->core.threads &&
> -		   evsel_list->core.threads->err_thread != -1) {
> +	}
> +	if (target__has_per_thread(&target) && err != EOPNOTSUPP &&
> +	    evsel_list->core.threads && evsel_list->core.threads->err_thread != -1) {
>   		/*
>   		 * For global --per-thread case, skip current
>   		 * error thread.
> @@ -656,24 +644,17 @@ static enum counter_recovery stat_handle_error(struct evsel *counter, int err)
>   		if (!thread_map__remove(evsel_list->core.threads,
>   					evsel_list->core.threads->err_thread)) {
>   			evsel_list->core.threads->err_thread = -1;
> +			counter->supported = true;
>   			return COUNTER_RETRY;
>   		}
> -	} else if (err == EOPNOTSUPP) {
> -		if (verbose > 0) {
> -			ui__warning("%s event is not supported by the kernel.\n",
> -				    evsel__name(counter));
> -		}
> -		counter->supported = false;
> -		counter->errored = true;
>   	}
> -
> -	evsel__open_strerror(counter, &target, err, msg, sizeof(msg));
> -	ui__error("%s\n", msg);
> -
> -	if (child_pid != -1)
> -		kill(child_pid, SIGTERM);
> -
> -	return COUNTER_FATAL;
> +	if (verbose > 0) {
> +		ui__warning(err == EOPNOTSUPP
> +			? "%s event is not supported by the kernel.\n"
> +			: "skipping event %s that kernel failed to open.\n",
> +			evsel__name(counter));
> +	}
> +	return COUNTER_SKIP;
>   }
>   
>   static int create_perf_stat_counter(struct evsel *evsel,
> @@ -746,8 +727,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>   	bool is_pipe = STAT_RECORD ? perf_stat.data.is_pipe : false;
>   	struct evlist_cpu_iterator evlist_cpu_itr;
>   	struct affinity saved_affinity, *affinity = NULL;
> -	int err;
> -	bool second_pass = false;
> +	int err, open_err = 0;
> +	bool second_pass = false, has_supported_counters;
>   
>   	if (forks) {
>   		if (evlist__prepare_workload(evsel_list, &target, argv, is_pipe, workload_exec_failed_signal) < 0) {
> @@ -787,14 +768,17 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>   		if (target.use_bpf)
>   			break;
>   
> -		if (counter->reset_group || counter->errored)
> +		if (counter->reset_group || !counter->supported)
>   			continue;
>   		if (evsel__is_bperf(counter))
>   			continue;
> -try_again:
> -		if (create_perf_stat_counter(counter, &stat_config,
> -					     evlist_cpu_itr.cpu_map_idx) < 0) {
>   
> +		while (true) {
> +			if (create_perf_stat_counter(counter, &stat_config,
> +						     evlist_cpu_itr.cpu_map_idx) == 0)
> +				break;
> +
> +			open_err = errno;
>   			/*
>   			 * Weak group failed. We cannot just undo this here
>   			 * because earlier CPUs might be in group mode, and the kernel
> @@ -802,29 +786,19 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>   			 * it to later.
>   			 * Don't close here because we're in the wrong affinity.
>   			 */
> -			if ((errno == EINVAL || errno == EBADF) &&
> +			if ((open_err == EINVAL || open_err == EBADF) &&
>   				evsel__leader(counter) != counter &&
>   				counter->weak_group) {
>   				evlist__reset_weak_group(evsel_list, counter, false);
>   				assert(counter->reset_group);
> +				counter->supported = true;
>   				second_pass = true;
> -				continue;
> -			}
> -
> -			switch (stat_handle_error(counter, errno)) {
> -			case COUNTER_FATAL:
> -				err = -1;
> -				goto err_out;
> -			case COUNTER_RETRY:
> -				goto try_again;
> -			case COUNTER_SKIP:
> -				continue;
> -			default:
>   				break;
>   			}
>   
> +			if (stat_handle_error(counter, open_err) != COUNTER_RETRY)
> +				break;
>   		}
> -		counter->supported = true;
>   	}
>   
>   	if (second_pass) {
> @@ -837,7 +811,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>   		evlist__for_each_cpu(evlist_cpu_itr, evsel_list, affinity) {
>   			counter = evlist_cpu_itr.evsel;
>   
> -			if (!counter->reset_group && !counter->errored)
> +			if (!counter->reset_group && counter->supported)
>   				continue;
>   
>   			perf_evsel__close_cpu(&counter->core, evlist_cpu_itr.cpu_map_idx);
> @@ -848,34 +822,29 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>   
>   			if (!counter->reset_group)
>   				continue;
> -try_again_reset:
> -			pr_debug2("reopening weak %s\n", evsel__name(counter));
> -			if (create_perf_stat_counter(counter, &stat_config,
> -						     evlist_cpu_itr.cpu_map_idx) < 0) {
> -
> -				switch (stat_handle_error(counter, errno)) {
> -				case COUNTER_FATAL:
> -					err = -1;
> -					goto err_out;
> -				case COUNTER_RETRY:
> -					goto try_again_reset;
> -				case COUNTER_SKIP:
> -					continue;
> -				default:
> +
> +			while (true) {
> +				pr_debug2("reopening weak %s\n", evsel__name(counter));
> +				if (create_perf_stat_counter(counter, &stat_config,
> +							     evlist_cpu_itr.cpu_map_idx) == 0)
> +					break;
> +
> +				open_err = errno;
> +				if (stat_handle_error(counter, open_err) != COUNTER_RETRY)
>   					break;
> -				}
>   			}
> -			counter->supported = true;
>   		}
>   	}
>   	affinity__cleanup(affinity);
>   	affinity = NULL;
>   
> +	has_supported_counters = false;
>   	evlist__for_each_entry(evsel_list, counter) {
>   		if (!counter->supported) {
>   			perf_evsel__free_fd(&counter->core);
>   			continue;
>   		}
> +		has_supported_counters = true;
>   
>   		l = strlen(counter->unit);
>   		if (l > stat_config.unit_width)
> @@ -887,6 +856,16 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>   			goto err_out;
>   		}
>   	}
> +	if (!has_supported_counters) {
> +		evsel__open_strerror(evlist__first(evsel_list), &target, open_err,
> +				     msg, sizeof(msg));
> +		ui__error("No supported events found.\n%s\n", msg);
> +
> +		if (child_pid != -1)
> +			kill(child_pid, SIGTERM);
> +		err = -1;
> +		goto err_out;
> +	}
>   
>   	if (evlist__apply_filters(evsel_list, &counter, &target)) {
>   		pr_err("failed to set filter \"%s\" on event %s with %d (%s)\n",
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 1a29d4f47bbf..fe93f11cf3d1 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -407,6 +407,7 @@ void evsel__init(struct evsel *evsel,
>   	evsel->collect_stat  = false;
>   	evsel->group_pmu_name = NULL;
>   	evsel->skippable     = false;
> +	evsel->supported     = true;
>   	evsel->alternate_hw_config = PERF_COUNT_HW_MAX;
>   	evsel->script_output_type = -1; // FIXME: OUTPUT_TYPE_UNSET, see builtin-script.c
>   }
> @@ -1941,7 +1942,7 @@ static int get_group_fd(struct evsel *evsel, int cpu_map_idx, int thread)
>   	struct evsel *leader = evsel__leader(evsel);
>   	int fd;
>   
> -	if (evsel__is_group_leader(evsel))
> +	if (!evsel->supported || evsel__is_group_leader(evsel))
>   		return -1;
>   
>   	/*
> @@ -1955,7 +1956,7 @@ static int get_group_fd(struct evsel *evsel, int cpu_map_idx, int thread)
>   		return -1;
>   
>   	fd = FD(leader, cpu_map_idx, thread);
> -	BUG_ON(fd == -1 && !leader->skippable);
> +	BUG_ON(fd == -1 && leader->supported);
>   
>   	/*
>   	 * When the leader has been skipped, return -2 to distinguish from no
> @@ -2573,12 +2574,14 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>   	enum rlimit_action set_rlimit = NO_CHANGE;
>   	struct perf_cpu cpu;
>   
> -	if (evsel__is_retire_lat(evsel))
> -		return evsel__tpebs_open(evsel);
> +	if (evsel__is_retire_lat(evsel)) {
> +		err = evsel__tpebs_open(evsel);
> +		goto out;
> +	}
>   
>   	err = __evsel__prepare_open(evsel, cpus, threads);
>   	if (err)
> -		return err;
> +		goto out;
>   
>   	if (cpus == NULL)
>   		cpus = empty_cpu_map;
> @@ -2598,19 +2601,22 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>   	display_attr(&evsel->core.attr);
>   
>   	if (evsel__is_tool(evsel)) {
> -		return evsel__tool_pmu_open(evsel, threads,
> -					    start_cpu_map_idx,
> -					    end_cpu_map_idx);
> +		err = evsel__tool_pmu_open(evsel, threads,
> +					   start_cpu_map_idx,
> +					   end_cpu_map_idx);
> +		goto out;
>   	}
>   	if (evsel__is_hwmon(evsel)) {
> -		return evsel__hwmon_pmu_open(evsel, threads,
> -					     start_cpu_map_idx,
> -					     end_cpu_map_idx);
> +		err = evsel__hwmon_pmu_open(evsel, threads,
> +					    start_cpu_map_idx,
> +					    end_cpu_map_idx);
> +		goto out;
>   	}
>   	if (evsel__is_drm(evsel)) {
> -		return evsel__drm_pmu_open(evsel, threads,
> -					   start_cpu_map_idx,
> -					   end_cpu_map_idx);
> +		err = evsel__drm_pmu_open(evsel, threads,
> +					  start_cpu_map_idx,
> +					  end_cpu_map_idx);
> +		goto out;
>   	}
>   
>   	for (idx = start_cpu_map_idx; idx < end_cpu_map_idx; idx++) {
> @@ -2689,7 +2695,8 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>   		}
>   	}
>   
> -	return 0;
> +	err = 0;
> +	goto out;
>   
>   try_fallback:
>   	if (evsel__ignore_missing_thread(evsel, perf_cpu_map__nr(cpus),
> @@ -2728,6 +2735,9 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>   		thread = nthreads;
>   	} while (--idx >= 0);
>   	errno = old_errno;
> +out:
> +	if (err)
> +		evsel->supported = false;
>   	return err;
>   }
>   
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 03f9f22e3a0c..1ad0b3fcd559 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -121,7 +121,6 @@ struct evsel {
>   	bool			forced_leader;
>   	bool			cmdline_group_boundary;
>   	bool			reset_group;
> -	bool			errored;
>   	bool			needs_auxtrace_mmap;
>   	bool			default_metricgroup; /* A member of the Default metricgroup */
>   	bool			needs_uniquify;

