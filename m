Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B2B3F12D3
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Sep 2026 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947385; cv=none; b=l056RX/iSDfOK64uDFHTHR8Qytd8tVvpEhFL8UbgafRot/3QELMU7UI3gpQO+VtDEa/+KrIKGV6cCztVc2DGHZaXhCrdB/S5GMBwmTq5bXvjqgYmx+3WEg1NCz0HhVdG7neUEZoPQq1fbFW/hHYX5W+t/S2W1oioG66+XUMxK8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947385; c=relaxed/simple;
	bh=5bROc/SQfaB1oKFPcxOKWlzVq7NjYeRMSYqWjeTB2H0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u9o09zL5bkvA5pyYtRfaHPpBM0y0hvwpmCiPO4CvCZPRfvj5Ex7ZvPmQIRou7QK4VFVuoR/gcm8cHpDQzlEZBcpqjZXNH97ZyWcZ6oe/BJBUf1F+BLoc6y//5d8GicsCNkiTn5CWxuBNqhjrRttGuQGziUcTK3j3n1tR7y769+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TziCda1n; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TziCda1n"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c255c58156bso1147339766b.3
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Sep 2026 02:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788947381; x=1789552181; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DcL2wKymjLCYMba/shCJvrNvacCqoGWhxIKQ8YEsqXE=;
        b=TziCda1n5BO3EEEvfu57uanjLlqmNG0E7+cuy5uZEF6zyaT+LIkWfRUMay2zVCQloe
         khVMRQ0mKuur+zf78NQZEj+pXgCXG0cpyCTPQAvr6TuXhHURP0g/m0s0iYITpMFqCb9f
         1TG25WY3KVVdRhBCIY6LKWyJtI90HmWn1srggYsSB8Yr3MrcRfMUg8NDmAD3N2JcuAEB
         uUwglq1F13GCueex2eIsfIPYWK60CjI7S+AWEEpFLfjupcvh/6KIUWuijBYv9msqgUh8
         m72sVgid8tLccru+3EizqxnUwjMMY9miZlAz9pbAKcvi46bLXqPhbRqMvEg4jYf/W/gT
         z/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788947381; x=1789552181;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DcL2wKymjLCYMba/shCJvrNvacCqoGWhxIKQ8YEsqXE=;
        b=L1wIu7+sS0+QJfAshPoBYdKR7y4xJaXltEFbVPle60IMq5bMKpRz7biiPPA426Wkw8
         LbcV/nbE5NsQ8Zh/zPHlhccfSe9s9H+vzbv+5NQmbIbVioD8Zs6RtLxflFuECyjcvTqm
         SIRpYSKryQbzDp+3RBUJDJyJz1+eaYm5GXzEAiu6RAvuFrCPkU5FiOFbBSLHSr8IuwiA
         K5AewyHaETX/RNvJA4qXNynNRyVLQfwoiGnyIPySwHQKFkx9WEpuOg+PTDdkJNGilsOX
         gzS4Lc0CvFASl92Wkw9mLWcMQd+OEu39lXK079mIF5BgH3Yhc56I5FUWqNAitm/epc9s
         OhiQ==
X-Forwarded-Encrypted: i=1; AKwUvBxqjYuPOSPbvObzh0o8tefP7q1kQ6gAMmRli57gADrE5H74GsAMtehl4aWM77xW1vGioyO59vDfmi0Qfxrml3Th@vger.kernel.org
X-Gm-Message-State: AFuF++myWlkPAALypTWumbtR7SNmz9tg21p4c1+rgzNNJwQlHACR8a4r
	cAH7I9uLB+4h2LQVnvK43NGchQrG7/BDL7ZF8cJrdyjjFb9xSiqH2Vw6
X-Gm-Gg: AYBFou3xVuL5ySsp+q/TjrmJ9qqlk/yhjBvypxP/w5598/wNMiCuQ3Y5OXQN1Jk7D1U
	h5lKe30zZKNoE6cQTbPFta94MfYDzGk4NEIeDaymSxr1uuBhQRg1be09L7NAtz6VlynWeGZtuYk
	InsMt2bJO7C7iH4Mp26v6Oaai4DIeY5EGindVGwhH65aI6sxgSyAVcRXDZGEBhm5kueuFQ66ypn
	L9nkaRNp75o6i9C5gpRQV8cX5sYm/gg+KQiPLaMMfgW7j10ATa8EeTyAByWUVkt+JQ6aKZW21LG
	tfOL1jzMTqFTlHRTXYFZYAywE6OJoEPEY+Gs1QZ01dMzSmrji5mQvYvfp1juKXyXKDB93JXitdh
	VHCr1O3kKcDRvBJHkNIODwrhOLfq1yJXSPD1BjMHNp/42oq/HXYFYWGcIbtmjAc1xfhQ/j4PrOF
	Tgw3SWpud27Fm/G0s3bQcMRnNkUKWXvstrtMM1khqHBRK2e4TBhahSSdEL7efDj6RBW2IzdzRqj
	8mHICTCT2QRpEyKRZTzNh81PAczvENhzNEDeg9zkgwzwSTbNNMod/vNzw==
X-Received: by 2002:a17:906:4786:b0:c21:450d:cd88 with SMTP id a640c23a62f3a-c260c7a9a41mr1226599766b.6.1788947381172;
        Wed, 09 Sep 2026 02:49:41 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:dabd:d9e2:64b7:dfc3? ([2a02:8109:a307:d900:dabd:d9e2:64b7:dfc3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c293eaf1ae8sm7331666b.40.2026.09.09.02.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 02:49:40 -0700 (PDT)
Message-ID: <0e948aae-bdbd-4a18-bb87-bdc00d147ef4@gmail.com>
Date: Wed, 9 Sep 2026 10:49:39 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 3/3] bpftool: Scale counters and report cycles
 per run
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com,
 memxor@gmail.com, qmo@kernel.org, linux-perf-users@vger.kernel.org,
 acme@kernel.org, namhyung@kernel.org, Mykyta Yatsenko <yatsenko@meta.com>
References: <20260908-bpftool_cyles_per_run-v3-0-60e86f325c35@meta.com>
 <20260908-bpftool_cyles_per_run-v3-3-60e86f325c35@meta.com>
 <CAEf4BzZ0GwQS3vHDywzkLPo_FspsuPYeYEXsZ9q5c5Mp6nWVjQ@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzZ0GwQS3vHDywzkLPo_FspsuPYeYEXsZ9q5c5Mp6nWVjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/9/26 1:02 AM, Andrii Nakryiko wrote:
> On Tue, Sep 8, 2026 at 7:27 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Perf counters can report too few events when the PMU multiplexes them.
>> Scale each per-CPU value before aggregation.
>>
>> Use the same CPU set for derived ratios. Report cycles per included
>> program run, and preserve the total run count in JSON.
>>
>> Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>  tools/bpf/bpftool/Documentation/bpftool-prog.rst |  13 +-
>>  tools/bpf/bpftool/prog.c                         | 159 +++++++++++++++++------
>>  2 files changed, 133 insertions(+), 39 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
>> index 90fa2a48cc26..0108a1c8be4d 100644
>> --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
>> +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
>> @@ -217,7 +217,16 @@ bpftool prog run *PROG* data_in *FILE* [data_out *FILE* [data_size_out *L*]] [ct
>>  bpftool prog profile *PROG* [duration *DURATION*] *METRICs*
>>      Profile *METRICs* for bpf program *PROG* for *DURATION* seconds or until
>>      user hits <Ctrl+C>. *DURATION* is optional. If *DURATION* is not specified,
>> -    the profiling will run up to **UINT_MAX** seconds.
>> +    the profiling will run up to **UINT_MAX** seconds. Plain output scales each
>> +    per-CPU metric value to correct for perf event multiplexing. When
>> +    **cycles** is selected, it also reports cycles per included program run. If
>> +    a selected metric was not scheduled on a CPU, all metric values exclude
>> +    that CPU so that ratios use a consistent CPU set. The **run_cnt** value
>> +    still includes all recorded runs.
>> +
>> +    In JSON output, **value** is raw, **value_scaled** is scaled, **run_cnt**
>> +    includes all runs, and **run_cnt_valid** includes only runs used for metric
>> +    values.
>>
>>  bpftool prog help
>>      Print short help message.
>> @@ -360,7 +369,7 @@ EXAMPLES
>>  ::
>>
>>           51397 run_cnt
>> -      40176203 cycles                                                 (83.05%)
>> +      40176203 cycles          # 781.68 cycles per run                (83.05%)
>>        42518139 instructions    #   1.06 insns per cycle               (83.39%)
>>             123 llc_misses      #   2.89 LLC misses per million insns  (83.15%)
>>
>> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
>> index 8c2f9255b36d..9e126f3823ad 100644
>> --- a/tools/bpf/bpftool/prog.c
>> +++ b/tools/bpf/bpftool/prog.c
>> @@ -2062,37 +2062,52 @@ static int do_profile(int argc, char **argv)
>>
>>  #include "profiler.skel.h"
>>
>> +enum ratio_metric {
>> +       METRIC_NONE = -2,
>> +       METRIC_RUN_CNT = -1,
>> +       METRIC_CYCLES = 0,
>> +       METRIC_INSTRUCTIONS = 1,
>> +       METRIC_L1D_LOADS = 2,
>> +       METRIC_LLC_MISSES = 3,
>> +       METRIC_ITLB_MISSES = 4,
>> +       METRIC_DTLB_MISSES = 5,
>> +};
>> +
>>  struct profile_metric {
>>         const char *name;
>>         struct bpf_perf_event_value val;
>> +       __u64 scaled_val;
>>         struct perf_event_attr attr;
>>         bool selected;
>>
>>         /* calculate ratios like instructions per cycle */
>> -       const int ratio_metric; /* 0 for N/A, 1 for index 0 (cycles) */
>> +       const enum ratio_metric ratio_metric;
>>         const char *ratio_desc;
>>         const float ratio_mul;
>>  } metrics[] = {
>> -       {
>> +       [METRIC_CYCLES] = {
>>                 .name = "cycles",
>>                 .attr = {
>>                         .type = PERF_TYPE_HARDWARE,
>>                         .config = PERF_COUNT_HW_CPU_CYCLES,
>>                         .exclude_user = 1,
>>                 },
>> +               .ratio_metric = METRIC_RUN_CNT,
>> +               .ratio_desc = "cycles per run",
>> +               .ratio_mul = 1.0,
>>         },
>> -       {
>> +       [METRIC_INSTRUCTIONS] = {
>>                 .name = "instructions",
>>                 .attr = {
>>                         .type = PERF_TYPE_HARDWARE,
>>                         .config = PERF_COUNT_HW_INSTRUCTIONS,
>>                         .exclude_user = 1,
>>                 },
>> -               .ratio_metric = 1,
>> +               .ratio_metric = METRIC_CYCLES,
>>                 .ratio_desc = "insns per cycle",
>>                 .ratio_mul = 1.0,
>>         },
>> -       {
>> +       [METRIC_L1D_LOADS] = {
>>                 .name = "l1d_loads",
>>                 .attr = {
>>                         .type = PERF_TYPE_HW_CACHE,
>> @@ -2102,8 +2117,9 @@ struct profile_metric {
>>                                 (PERF_COUNT_HW_CACHE_RESULT_ACCESS << 16),
>>                         .exclude_user = 1,
>>                 },
>> +               .ratio_metric = METRIC_NONE,
>>         },
>> -       {
>> +       [METRIC_LLC_MISSES] = {
>>                 .name = "llc_misses",
>>                 .attr = {
>>                         .type = PERF_TYPE_HW_CACHE,
>> @@ -2113,11 +2129,11 @@ struct profile_metric {
>>                                 (PERF_COUNT_HW_CACHE_RESULT_MISS << 16),
>>                         .exclude_user = 1
>>                 },
>> -               .ratio_metric = 2,
>> +               .ratio_metric = METRIC_INSTRUCTIONS,
>>                 .ratio_desc = "LLC misses per million insns",
>>                 .ratio_mul = 1e6,
>>         },
>> -       {
>> +       [METRIC_ITLB_MISSES] = {
>>                 .name = "itlb_misses",
>>                 .attr = {
>>                         .type = PERF_TYPE_HW_CACHE,
>> @@ -2127,11 +2143,11 @@ struct profile_metric {
>>                                 (PERF_COUNT_HW_CACHE_RESULT_MISS << 16),
>>                         .exclude_user = 1
>>                 },
>> -               .ratio_metric = 2,
>> +               .ratio_metric = METRIC_INSTRUCTIONS,
>>                 .ratio_desc = "itlb misses per million insns",
>>                 .ratio_mul = 1e6,
>>         },
>> -       {
>> +       [METRIC_DTLB_MISSES] = {
>>                 .name = "dtlb_misses",
>>                 .attr = {
>>                         .type = PERF_TYPE_HW_CACHE,
>> @@ -2141,13 +2157,14 @@ struct profile_metric {
>>                                 (PERF_COUNT_HW_CACHE_RESULT_MISS << 16),
>>                         .exclude_user = 1
>>                 },
>> -               .ratio_metric = 2,
>> +               .ratio_metric = METRIC_INSTRUCTIONS,
>>                 .ratio_desc = "dtlb misses per million insns",
>>                 .ratio_mul = 1e6,
>>         },
>>  };
>>
>>  static __u64 profile_total_count;
>> +static __u64 profile_valid_count;
>>
>>  #define MAX_NUM_PROFILE_METRICS 4
>>
>> @@ -2182,9 +2199,39 @@ static int profile_parse_metrics(int argc, char **argv)
>>         return selected_cnt;
>>  }
>>
>> -static void profile_read_values(struct profiler_bpf *obj)
>> +/*
>> + * Filter out CPUs that have any selected metric not scheduled for them. This makes sure all
>> + * metrics are using the same CPU set, as a result ratio metrics are consistent.
>> + */
>> +static void profile_filter_cpus(__u32 num_cpu,
>> +                               struct bpf_perf_event_value vals[MAX_NUM_PROFILE_METRICS][num_cpu],
>> +                               __u64 *counts)
>> +{
>> +       __u32 m, cpu, key = 0;
>> +
>> +       for (m = 0; m < ARRAY_SIZE(metrics); m++) {
>> +               if (!metrics[m].selected)
>> +                       continue;
>> +
>> +               for (cpu = 0; cpu < num_cpu; cpu++) {
>> +                       /*
>> +                        * CPU has hits, but this metric never scheduled, set counts[cpu] to 0
>> +                        * so other metrics ignore this CPU too
>> +                        */
>> +                       if (counts[cpu] && !vals[key][cpu].running) {
>> +                               p_info("%s not scheduled on CPU %u; excluding %llu runs from all metrics",
>> +                                      metrics[m].name, cpu, counts[cpu]);
>> +                               counts[cpu] = 0;
>> +                       }
>> +               }
>> +               key++;
>> +       }
>> +}
> 
> was this suggested by AI or we actually ran into issues due to this in
> practice? this looks perculiar
> 

Suggested by AI is a bit of a simplification:
The initial problem was scaling counters, the counters are collected 
and accounted per CPU, so it sounds like a right thing to scale per
CPU as well(?) Because we divide by running, we need to check it for 0.
Now it is possible that some counters have running 0 on some CPU, but
others dont, will it make ratios biased?

this is easy to repro:
in tab 1 run:
```
sudo ./build/tools/bpf/bpftool/bpftool prog profile name myprog duration 80 itlb_misses dtlb_misses cycles instructions
```
in tab 2 run:
```
sudo ./build/tools/bpf/bpftool/bpftool prog profile name myprog duration 1 itlb_misses dtlb_misses cycles instructions
cycles not scheduled on CPU 36; excluding 1 runs from all metrics
instructions not scheduled on CPU 6; excluding 4 runs from all metrics
instructions not scheduled on CPU 39; excluding 1 runs from all metrics
instructions not scheduled on CPU 72; excluding 1 runs from all metrics
itlb_misses not scheduled on CPU 50; excluding 1 runs from all metrics

               330 run_cnt
           3601259 cycles              # 11184.03 cycles per run                (73.57%)
            682448 instructions        #     0.19 insns per cycle               (80.85%)
               132 itlb_misses         #   193.42 itlb misses per million insns (73.66%)
              2189 dtlb_misses         #  3207.57 dtlb misses per million insns (72.24%)
```

>> +
>> +static int profile_read_values(struct profiler_bpf *obj)
>>  {
>>         __u32 m, cpu, num_cpu = obj->rodata->num_cpu;
>> +       struct bpf_perf_event_value values[MAX_NUM_PROFILE_METRICS][num_cpu], *val;
>>         int reading_map_fd, count_map_fd;
>>         __u64 counts[num_cpu];
>>         __u32 key = 0;
>> @@ -2194,38 +2241,61 @@ static void profile_read_values(struct profiler_bpf *obj)
>>         count_map_fd = bpf_map__fd(obj->maps.counts);
>>         if (reading_map_fd < 0 || count_map_fd < 0) {
> 
> this can't happen if skeleton loaded successfully, just remove this
> check instead of weird min() over fds/errors
> 
>>                 p_err("failed to get fd for map");
>> -               return;
>> +               return min(reading_map_fd, count_map_fd);
>>         }
>>
>>         err = bpf_map_lookup_elem(count_map_fd, &key, counts);
>>         if (err) {
>>                 p_err("failed to read count_map: %s", strerror(errno));
>> -               return;
>> +               return err;
>> +       }
>> +
>> +       for (m = 0; m < ARRAY_SIZE(metrics); m++) {
>> +               if (!metrics[m].selected)
>> +                       continue;
>> +
>> +               err = bpf_map_lookup_elem(reading_map_fd, &key, values[key]);
>> +               if (err) {
>> +                       p_err("failed to read reading_map: %s", strerror(errno));
>> +                       return err;
>> +               }
>> +               key++;
>>         }
>>
>>         profile_total_count = 0;
>>         for (cpu = 0; cpu < num_cpu; cpu++)
>>                 profile_total_count += counts[cpu];
>>
>> +       profile_filter_cpus(num_cpu, values, counts);
>> +
>> +       profile_valid_count = 0;
>> +       for (cpu = 0; cpu < num_cpu; cpu++)
>> +               profile_valid_count += counts[cpu];
>> +
>> +       key = 0;
>>         for (m = 0; m < ARRAY_SIZE(metrics); m++) {
>> -               struct bpf_perf_event_value values[num_cpu];
>> +               double scale;
>>
>>                 if (!metrics[m].selected)
>>                         continue;
>>
>> -               err = bpf_map_lookup_elem(reading_map_fd, &key, values);
>> -               if (err) {
>> -                       p_err("failed to read reading_map: %s",
>> -                             strerror(errno));
>> -                       return;
>> -               }
>>                 for (cpu = 0; cpu < num_cpu; cpu++) {
>> -                       metrics[m].val.counter += values[cpu].counter;
>> -                       metrics[m].val.enabled += values[cpu].enabled;
>> -                       metrics[m].val.running += values[cpu].running;
>> +                       /* Skip CPUs with no runs or with an unscheduled metric. */
>> +                       if (!counts[cpu])
>> +                               continue;
>> +
>> +                       val = &values[key][cpu];
>> +
>> +                       metrics[m].val.enabled += val->enabled;
>> +                       metrics[m].val.running += val->running;
>> +                       metrics[m].val.counter += val->counter;
>> +                       /* Scale counter values to account for perf event multiplexing. */
>> +                       scale = (double)val->enabled / val->running;
>> +                       metrics[m].scaled_val += val->counter * scale;
>>                 }
>>                 key++;
>>         }
>> +       return 0;
>>  }
>>
>>  static void profile_print_readings_json(void)
>> @@ -2239,9 +2309,11 @@ static void profile_print_readings_json(void)
>>                 jsonw_start_object(json_wtr);
>>                 jsonw_string_field(json_wtr, "metric", metrics[m].name);
>>                 jsonw_lluint_field(json_wtr, "run_cnt", profile_total_count);
>> +               jsonw_lluint_field(json_wtr, "run_cnt_valid", profile_valid_count);
> 
> aren't we just overcomplicating things for no good reason?..
> 
>>                 jsonw_lluint_field(json_wtr, "value", metrics[m].val.counter);
>>                 jsonw_lluint_field(json_wtr, "enabled", metrics[m].val.enabled);
>>                 jsonw_lluint_field(json_wtr, "running", metrics[m].val.running);
>> +               jsonw_lluint_field(json_wtr, "value_scaled", metrics[m].scaled_val);
>>
>>                 jsonw_end_object(json_wtr);
>>         }
>> @@ -2250,24 +2322,34 @@ static void profile_print_readings_json(void)
>>
>>  static void profile_print_readings_plain(void)
>>  {
>> -       __u32 m;
>> +       __u32 i;
>>
>>         printf("\n%18llu %-20s\n", profile_total_count, "run_cnt");
>> -       for (m = 0; m < ARRAY_SIZE(metrics); m++) {
>> -               struct bpf_perf_event_value *val = &metrics[m].val;
>> +       for (i = 0; i < ARRAY_SIZE(metrics); i++) {
>> +               struct profile_metric *m = &metrics[i];
>> +               struct bpf_perf_event_value *val = &m->val;
>>                 int r;
>> +               __u64 ratio;
>>
>> -               if (!metrics[m].selected)
>> +               if (!m->selected)
>>                         continue;
>> -               printf("%18llu %-20s", val->counter, metrics[m].name);
>> +               printf("%18llu %-20s", m->scaled_val, m->name);
>>
>> -               r = metrics[m].ratio_metric - 1;
>> -               if (r >= 0 && metrics[r].selected &&
>> -                   metrics[r].val.counter > 0) {
>> +               r = m->ratio_metric;
>> +               switch (r) {
>> +               case METRIC_RUN_CNT:
>> +                       ratio = profile_valid_count;
>> +                       break;
>> +               case METRIC_NONE:
>> +                       ratio = 0;
>> +                       break;
>> +               default:
>> +                       ratio = metrics[r].scaled_val;
>> +               }
>> +               if (ratio) {
>>                         printf("# %8.2f %-30s",
>> -                              val->counter * metrics[m].ratio_mul /
>> -                              metrics[r].val.counter,
>> -                              metrics[m].ratio_desc);
>> +                              m->scaled_val * m->ratio_mul / ratio,
>> +                              m->ratio_desc);
>>                 } else {
>>                         printf("%-41s", "");
>>                 }
>> @@ -2423,9 +2505,12 @@ static int profile_open_perf_events(struct profiler_bpf *obj)
>>
>>  static void profile_print_and_cleanup(void)
>>  {
>> +       int err;
>> +
>>         profile_close_perf_events(profile_obj);
>> -       profile_read_values(profile_obj);
>> -       profile_print_readings();
>> +       err = profile_read_values(profile_obj);
>> +       if (!err)
>> +               profile_print_readings();
>>         profiler_bpf__destroy(profile_obj);
>>
>>         close(profile_tgt_fd);
>>
>> --
>> 2.53.0-Meta
>>

