Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B53576EA4
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 17:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788889049; cv=none; b=XJXQu+TRwew4I4xlOf9U1g+qL3J53VT5+U/HUNIKOPF8jd9vDN1OTf+D/s9MUihRvAbAvL+wmmQQ/ssrlYITs76KOqob+es+Mq59lZUYHiN9KeNrR6E2fgJXB6k5vWkbhK0ooUM4Vo6AgXwTUYq7uZYZO6qv8uIZX19tqCygD+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788889049; c=relaxed/simple;
	bh=20BKooH4sNQBea+Lfi0HqOLLu9aC0u3JnRN7Y6LiIjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kU65jgp0dgqnOEd8aRNzLv64BM5yss7R/JIISwVMujnypjmdyM9I4Id2sGS8MLOuhJTwZMZK5GXjRVKErZbt/2KrLJgs73GcqTdjWxDhsXn6XlTkgVQ05yJu5h3AlBySGmfW6jCx7tsf0yv+dWy4wjVmPG2s4SwsY64qlUL+baU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRo5uQoE; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRo5uQoE"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f62ccdb1so503203f8f.1
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Sep 2026 10:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788889045; x=1789493845; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dVPKXie00lKV45A1FT/qWsFJolUDuvV+3HtLDaaSE/Q=;
        b=TRo5uQoEo+dZ2i/icFyO0tMI2Y799UnsIklY3yMjzdNZzOBx31+PAkHBpH14gaVjFK
         yHueCKhBvyr8vBVbvX0Rp22ZYLwnVHcc+V7F9fnV0KFLR0hqEVOguZ6w1wbmrkBI2ydE
         QtA2qNEgIMDOPToPj+SVNqu3wpbdKzmSbcaE0TEbaPtiZmUPrsXArnCPG0j8HKiKe9t+
         Hqrgsldv9Irz31GTiFCrU/FsREuKC5v3xXmWbWRKBHVgrVdk+SvB9fAUGkGICLVTyB4n
         xRTTzYmdCL0miwe6gSHoXa5m3JRm6d+9Sh+fpyZSih3u+Sid4WECFJF7YNuktFB47KO3
         G/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788889045; x=1789493845;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dVPKXie00lKV45A1FT/qWsFJolUDuvV+3HtLDaaSE/Q=;
        b=ScXjK4U1TnvxS1Qz14PkNctr30ybI9w72d2+mCDWlEmhXETPGpFL7F49FhHKZWMEL5
         p5brUVxac5t56TDTp0NxZbrolvoH8tmYS6xN4ABE4wsxBpLkL+Bq1mBAI3jL9dTt66nI
         OZayZ+C1dVVPWgGRs/PO63qjcaw8CGyTU/p3f/u15kf5FXbfYhfhTZqCytZ4w7XrXWKv
         IR5WM/mRgbaVqbwmi9xqOP5pNuoDhqxhe/aY+PxgBtH7QTKTSPMfJVy71HYFTGA9Lcn1
         V2kGhZV7vZzU+GV3bZ9JIBIHiXtF+BlygROrg+AGxDsoKW7E3/om0JavLi14xgBiOh7q
         2GOw==
X-Forwarded-Encrypted: i=1; AKwUvBwL/CrOYNAAd171qO/uoq7/5biHz4UBPpIcVl1rVuDA/lusqS/wlTWS5LcCjqZK2+y/BiAqlkBLI4euCwDkXzsz@vger.kernel.org
X-Gm-Message-State: AFuF++ky4mNbx5ojdW9Fl8TNkP0w+W9KFOU7vsH0zyABLQIV3rK1Dl2p
	HtuGmHrutAjIZnHzZgAqwoFKpEfiVKyzer84xnK0y3AjnSAUrJJsSe4x
X-Gm-Gg: AYBFou1DOF2XJ+cUjPk3O/vYOXNMxtrxV7Dl35ymiB132yS9dPqT8qaK1PNvJ6Z9FRX
	oQr3a+0UHRicspmRFrRD5m903D9lfqdWvhyuuk/pCmPMwqa8p/42aPhZVXEk4DtmsDqt29O3M9b
	O+7JwPx+FcoZ/4JL7oSmIe9KhoXsnVcqM8ZBKHk59cXsdPN2FVMcxKZnYa3KzOwEsjQZuHrNa9g
	MbmTvwbCEgObv8htBV3eQeK2WAVX1PoMnDuA67GjcRrGA5XXqlrmGLXrqgqRx5HM51TeVa2lKRm
	ExptgezGbiBacj88yjitN9cRSxR7U8Giq+eSxC9qluOPs0L1pmcs4k/Y/3cHEfDs4WFmWQgew2p
	QeAQU+gc3MLiVJnipcI458x2Idq0wiOtD+Aio3K5HjDdZxglM6XscVfBziC64OL6+UjIizhBC0Q
	T9BhkA5FGWJHSZYTkm+3ibDfYCIVC80YpeBETaU2QwlNudVv9vL7CbS1WIscZQzmiLY3kVvTlX1
	Ja4lBR4nbLgu7AupAdNMZKzF2DwExAZnfrWBdppPeXj
X-Received: by 2002:a05:6000:24c7:b0:484:482d:dce4 with SMTP id ffacd0b85a97d-485a232c8c7mr9789969f8f.0.1788889045218;
        Tue, 08 Sep 2026 10:37:25 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:d30:32e5:e05c:2aae? ([2a02:8109:a307:d900:d30:32e5:e05c:2aae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48594172546sm29278996f8f.15.2026.09.08.10.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 10:37:24 -0700 (PDT)
Message-ID: <c0c8d167-80a1-4782-ad98-3cbbbd18e536@gmail.com>
Date: Tue, 8 Sep 2026 18:37:23 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 3/3] bpftool: Scale counters and report cycles
 per run
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, kernel-team@meta.com,
 eddyz87@gmail.com, memxor@gmail.com, qmo@kernel.org,
 linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Cc: yatsenko@meta.com, martin.lau@kernel.org, yonghong.song@linux.dev,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260908-bpftool_cyles_per_run-v3-3-60e86f325c35@meta.com>
 <cc417e4dba25ded6b33afcdfa4cd4a69de3e9c8ab7ca351c131ae92bc7430d86@mail.kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <cc417e4dba25ded6b33afcdfa4cd4a69de3e9c8ab7ca351c131ae92bc7430d86@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/8/26 5:21 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
>> index 8c2f9255b36d..9e126f3823ad 100644
>> --- a/tools/bpf/bpftool/prog.c
>> +++ b/tools/bpf/bpftool/prog.c
> 
> [ ... ]
> 
>> @@ -2182,9 +2199,39 @@ static int profile_parse_metrics(int argc, char **argv)
>>  	return selected_cnt;
>>  }
>>
>> +/*
>> + * Filter out CPUs that have any selected metric not scheduled for them. This makes sure all
>> + * metrics are using the same CPU set, as a result ratio metrics are consistent.
>> + */
>> +static void profile_filter_cpus(__u32 num_cpu,
>> +				struct bpf_perf_event_value vals[MAX_NUM_PROFILE_METRICS][num_cpu],
>> +				__u64 *counts)
>> +{
>> +	__u32 m, cpu, key = 0;
>> +
>> +	for (m = 0; m < ARRAY_SIZE(metrics); m++) {
>> +		if (!metrics[m].selected)
>> +			continue;
>> +
>> +		for (cpu = 0; cpu < num_cpu; cpu++) {
>> +			/*
>> +			 * CPU has hits, but this metric never scheduled, set counts[cpu] to 0
>> +			 * so other metrics ignore this CPU too
>> +			 */
>> +			if (counts[cpu] && !vals[key][cpu].running) {
>> +				p_info("%s not scheduled on CPU %u; excluding %llu runs from all metrics",
>> +				       metrics[m].name, cpu, counts[cpu]);
>> +				counts[cpu] = 0;
>> +			}
>> +		}
>> +		key++;
>> +	}
>> +}
> 
> [ ... ]
> 
>> @@ -2194,38 +2241,61 @@ static void profile_read_values(struct profiler_bpf *obj)
>>  	count_map_fd = bpf_map__fd(obj->maps.counts);
>>  	if (reading_map_fd < 0 || count_map_fd < 0) {
>>  		p_err("failed to get fd for map");
>> -		return;
>> +		return min(reading_map_fd, count_map_fd);
>>  	}
>>
>>  	err = bpf_map_lookup_elem(count_map_fd, &key, counts);
>>  	if (err) {
>>  		p_err("failed to read count_map: %s", strerror(errno));
>> -		return;
>> +		return err;
>> +	}
>> +
>> +	for (m = 0; m < ARRAY_SIZE(metrics); m++) {
>> +		if (!metrics[m].selected)
>> +			continue;
>> +
>> +		err = bpf_map_lookup_elem(reading_map_fd, &key, values[key]);
>> +		if (err) {
>> +			p_err("failed to read reading_map: %s", strerror(errno));
>> +			return err;
>> +		}
>> +		key++;
>>  	}
>>
>>  	profile_total_count = 0;
>>  	for (cpu = 0; cpu < num_cpu; cpu++)
>>  		profile_total_count += counts[cpu];
>>
>> +	profile_filter_cpus(num_cpu, values, counts);
>> +
>> +	profile_valid_count = 0;
>> +	for (cpu = 0; cpu < num_cpu; cpu++)
>> +		profile_valid_count += counts[cpu];
>> +
>> +	key = 0;
>>  	for (m = 0; m < ARRAY_SIZE(metrics); m++) {
>> -		struct bpf_perf_event_value values[num_cpu];
>> +		double scale;
>>
>>  		if (!metrics[m].selected)
>>  			continue;
>>
>> -		err = bpf_map_lookup_elem(reading_map_fd, &key, values);
>> -		if (err) {
>> -			p_err("failed to read reading_map: %s",
>> -			      strerror(errno));
>> -			return;
>> -		}
>>  		for (cpu = 0; cpu < num_cpu; cpu++) {
>> -			metrics[m].val.counter += values[cpu].counter;
>> -			metrics[m].val.enabled += values[cpu].enabled;
>> -			metrics[m].val.running += values[cpu].running;
>> +			/* Skip CPUs with no runs or with an unscheduled metric. */
>> +			if (!counts[cpu])
>> +				continue;
>> +
>> +			val = &values[key][cpu];
>> +
>> +			metrics[m].val.enabled += val->enabled;
>> +			metrics[m].val.running += val->running;
>> +			metrics[m].val.counter += val->counter;
>> +			/* Scale counter values to account for perf event multiplexing. */
>> +			scale = (double)val->enabled / val->running;
>> +			metrics[m].scaled_val += val->counter * scale;
>>  		}
>>  		key++;
>>  	}
>> +	return 0;
>>  }
> 
> Does this correctly handle the case where one metric is never scheduled
> on any CPU?
> 
> The CPU-set filter in profile_filter_cpus() zeroes counts[cpu] for every
> CPU where any selected metric has running == 0:

This would be an unusual edge case, perf counter normally get 
scheduled for some fraction of time, even when multiplexed.

>     if (counts[cpu] && !vals[key][cpu].running) {
>         p_info("%s not scheduled on CPU %u; ...");
>         counts[cpu] = 0;
>     }
> 
> The aggregation loop then skips those CPUs for all metrics:
> 
>     for (cpu = 0; cpu < num_cpu; cpu++) {
>         if (!counts[cpu])
>             continue;
>         ...
>         metrics[m].val.counter += val->counter;
>         ...
>         metrics[m].scaled_val += val->counter * scale;
>     }
> 
> If a selected metric is never scheduled on any CPU (the scenario this
> series targets - commit 44f919dd1fbc describes profiling iTLB misses on
> a long-running program with a full PMU), then every CPU with counts[cpu]
> != 0 gets zeroed.
> 
> For example, `bpftool prog profile <prog> cycles itlb_misses`:
> 
>   * profile_valid_count becomes 0
>   * cycles' val.counter and scaled_val stay 0 even though the cycles
>     event was measured correctly on every CPU
>   * plain output prints "run_cnt 51397" followed by "0 cycles" and
>     "0 itlb_misses" with no ratio column
> 
> Before this patch the same run reported the real cycles count and 0 for
> itlb_misses, so the healthy metric's data is lost.
> 
> In JSON mode there is no diagnostic at all. The p_info() call in
> profile_filter_cpus() returns immediately when json_output is set, so
> a consumer sees run_cnt=51397 with value=0, value_scaled=0, enabled=0,
> running=0, and only run_cnt_valid=0 as a hint.
> 
> The commit message scopes the change to ratios ("Use the same CPU set
> for derived ratios"), and the .rst says "all metric values exclude that
> CPU so that ratios use a consistent CPU set" but neither documents that
> a single unscheduled metric collapses the whole report to zeros, and
> JSON gives no warning.
> 
> Would it make sense to exclude only the affected metric, or keep the raw
> per-metric aggregation intact and restrict only the ratio denominators?
> 
>> @@ -2250,24 +2322,34 @@ static void profile_print_readings_json(void)
>>
>>  static void profile_print_readings_plain(void)
>>  {
>> -	__u32 m;
>> +	__u32 i;
>>
>>  	printf("\n%18llu %-20s\n", profile_total_count, "run_cnt");
>> -	for (m = 0; m < ARRAY_SIZE(metrics); m++) {
>> -		struct bpf_perf_event_value *val = &metrics[m].val;
>> +	for (i = 0; i < ARRAY_SIZE(metrics); i++) {
>> +		struct profile_metric *m = &metrics[i];
>> +		struct bpf_perf_event_value *val = &m->val;
>>  		int r;
>> +		__u64 ratio;
>>
>> -		if (!metrics[m].selected)
>> +		if (!m->selected)
>>  			continue;
>> -		printf("%18llu %-20s", val->counter, metrics[m].name);
>> +		printf("%18llu %-20s", m->scaled_val, m->name);
>>
>> -		r = metrics[m].ratio_metric - 1;
>> -		if (r >= 0 && metrics[r].selected &&
>> -		    metrics[r].val.counter > 0) {
>> +		r = m->ratio_metric;
>> +		switch (r) {
>> +		case METRIC_RUN_CNT:
>> +			ratio = profile_valid_count;
>> +			break;
>> +		case METRIC_NONE:
>> +			ratio = 0;
>> +			break;
>> +		default:
>> +			ratio = metrics[r].scaled_val;
>> +		}
>> +		if (ratio) {
>>  			printf("# %8.2f %-30s",
>> -			       val->counter * metrics[m].ratio_mul /
>> -			       metrics[r].val.counter,
>> -			       metrics[m].ratio_desc);
>> +			       m->scaled_val * m->ratio_mul / ratio,
>> +			       m->ratio_desc);
>>  		} else {
>>  			printf("%-41s", "");
>>  		}
> 
> Plain output prints profile_total_count as "run_cnt" but the new "cycles
> per run" column divides by profile_valid_count, and profile_valid_count
> is never printed in plain mode (it is only exposed as the JSON
> run_cnt_valid field).
> 
> Whenever profile_filter_cpus() excludes at least one CPU the two differ,
> so the displayed numbers cannot be reconciled. The user sees run_cnt and
> a scaled cycles value, and "# <x> cycles per run" where
> x != cycles/run_cnt, with no way to see the denominator that was
> actually used.
> 
> The only signal is the p_info() lines on stderr, which are easy to miss
> when stdout is redirected and are suppressed entirely under --json.
> 
> Would it make sense to print the valid run count in plain mode (as JSON
> now does) or label the ratio with the CPU set it was computed over?
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34246064212

