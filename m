Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D90F1A23B8
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Mar 2025 14:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741356507; cv=none; b=UloKfncwBLS1QgF+mggGGchRIRAkADpYG4YjtStWvTO6UFO9cTUUxm/4utrZ7cFyoxnKSLO0MYQiqgKm9q90pNyVFySwOjqyCD2+dJEsY3BYZMcP51E3m+Z+q+tLFknMzh1JkequvveXt6aSt92izEOxG8XTZv201MiJBOf640k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741356507; c=relaxed/simple;
	bh=xTJsAQjEfhkaY1kiPlh7eyQzcSk18qAvoQRgwAESJiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GloNnu1dqaLG9KmnvmoMex39APXgdsRsBKhuUK257eNuXMFkfKaW0VInUALA9YIhHitOy9tRU8YDosROymSHMrxJvkPn3yEPgTJyL7cfoJX1zjunAHUqCmpIPq1u1ErdlNSbzQdEPXLl9LAkzGQbNCjAGLODOzM5hXK5A4VOYNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CcmhBtjS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CcmhBtjS"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so15886995e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Mar 2025 06:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741356503; x=1741961303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R5ecyPn7/nwX7bRM6QxZMgRy3/lK1hOfCo5lNcV5pZY=;
        b=CcmhBtjSPY5DgoF1y9CapgyQ0sfAlLULvWb+4QkbrjnDS6KwjGCUWNzD0QddnwLPu6
         q3pLAuL4/MbKv916y0pb+jRcF4/hbrd6JBSKf39GnJGKyyxaAiPX1jiDLyA74xaA2GtP
         hH0a/UzhMlmAkTfgkkou2jJ/2NvzYYx0eC5E0nyN8xA/BYg+YA1prtLrmnah7GKvEPqn
         vZ+ypNC09RCDFwhetnQ5Fva85b4R6tQXK+0noKL/tHokgpzn5U6nw0JuP7b1hL95xxnu
         CFsJw/nrYPuJqzozAF6QKe+kbG/nQYR+mmQGUYINgYfPVF7e62gPxK82TCUQh+Byng+K
         xQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741356503; x=1741961303;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R5ecyPn7/nwX7bRM6QxZMgRy3/lK1hOfCo5lNcV5pZY=;
        b=WjImJ1kzjyAaF6gv6KOQGXTCruVTk6OOmqJxBj4tZVAekM+I2i0/oU8FPFHrVSNjb/
         99mudKQwhgxowET08G1a038Y1unJIONjv+ZPrsXB6b4j9NI5cHP33sm0WLDwBwmJHgRn
         nd7pyZc6+gZ4TXjxJEMzElwYc55S651qZLxYGFRbrEIr+LlJa0m4FJSA6MpLI/L1ZKqN
         8rP6H8djyefY0a6ODnUtmCQC8ZNxAAaKEwq2XkDZlVvMbpVIqXOXgoX5U+HauiuNPXHy
         uepQUDj2vYAqyHgpmJj2ojr3q2d+nsaUIolMNszafDvRsn9E/J14FHJTcBWXtn2zuKz3
         Vymw==
X-Forwarded-Encrypted: i=1; AJvYcCX3FbrqHAUhcdTK5pTfMLNd5xrzv7eCATVe54L3AP8npLHKHhmnnNCN8TQ+hYLywUXasm6i8255/2s7nm9kRo/W@vger.kernel.org
X-Gm-Message-State: AOJu0YxURXf/icktF03TVUTrtbhe1FVMfepz6+J4b6U4n9XA2tUDz0MQ
	M3aDpRvXC2XP11rLhPJThETUdIBTinQ+UxUtCpacxLC9K3tFX8lNREH/J1fVw1c=
X-Gm-Gg: ASbGncu7+nRUjFCy3K42qfuxlt6jtF6ofPwzuv8EjUbZxtQhOmmVwagq1KX4QRttNWc
	5igcOgicseT4Bsjh03jrKk6SHxKDTMqTblgDDVvqs/IsVo8dbZ+HbsKdqB8g1UHiHxBMRFwPhvL
	9lgSlzsb3ccLemHs9AA4k3lYjEIIiTkvdXrWzF1qQDNDuXHx8lUx/fWQq3QFk3x0EU55c7lf7d+
	CJnoq7/50F0uHtVuZtno8vTKonwFwhPOs67tiiqVcczS35xaKVsCs1DV0trcl2MSq0cxaoMjBg2
	dVeD27a5s7FZW3pr+/XgzrAK39Kt2K8EcAAF962sVDyJqdPIGy94wQ==
X-Google-Smtp-Source: AGHT+IGNB/FF2hwXTsWwAqyKR4fwzkz5uhw+jSyQAtxugqnyV2VEQWX/qzkA+QktBmcg25uzfzp+dA==
X-Received: by 2002:a05:600c:3586:b0:43b:c0fa:f9dc with SMTP id 5b1f17b1804b1-43c5cb69562mr28563695e9.10.1741356503065;
        Fri, 07 Mar 2025 06:08:23 -0800 (PST)
Received: from [192.168.1.247] ([145.224.67.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e222dsm5444435f8f.72.2025.03.07.06.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 06:08:22 -0800 (PST)
Message-ID: <9a3cd3ea-6352-455a-b883-f8f3488002bd@linaro.org>
Date: Fri, 7 Mar 2025 14:08:21 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] perf list: Don't deduplicate core PMUs when listing
 events
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Leo Yan <leo.yan@arm.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250304-james-perf-hybrid-list-v1-0-a363ffac283c@linaro.org>
 <20250304-james-perf-hybrid-list-v1-3-a363ffac283c@linaro.org>
 <CAP-5=fVHE41=RuBf2fS6anTmNOy3DXZbUSw6p+SBaCM9oD-YOA@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fVHE41=RuBf2fS6anTmNOy3DXZbUSw6p+SBaCM9oD-YOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 05/03/2025 9:51 pm, Ian Rogers wrote:
> On Tue, Mar 4, 2025 at 5:50 AM James Clark <james.clark@linaro.org> wrote:
>>
>> Commit 7afbf90ea2e2 ("perf pmu: Don't de-duplicate core PMUs") fixed a
>> display mismatch related to deduplication within a single PMU, but it
>> didn't fix the case where deduplicated PMUs aren't listed at all.
>>
>> Fix it by using the same function which takes is_core into account,
>> except in the use_core_pmus block where it's always going to be true.
>> Before this change, -v would be required to get the same behavior for
>> core PMUs. Now it's no longer required:
>>
>> Before:
>>   $ perf list | grep br_indirect_spec -A 1
>>   br_indirect_spec
>>      [Branch speculatively executed,indirect branch. Unit: armv8_cortex_a53]
>>
>> After:
>>   $ perf list | grep br_indirect_spec -A 2
>>      [Branch speculatively executed,indirect branch. Unit: armv8_cortex_a53,
>>       armv8_cortex_a57]
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   tools/perf/util/pmu.c  | 5 +++--
>>   tools/perf/util/pmu.h  | 2 ++
>>   tools/perf/util/pmus.c | 8 +++++---
>>   3 files changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 57450c73fb63..caff0d309012 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -834,9 +834,10 @@ static int is_sysfs_pmu_core(const char *name)
>>    *
>>    * @skip_duplicate_pmus: False in verbose mode so all uncore PMUs are visible
>>    */
>> -static size_t pmu_deduped_name_len(const struct perf_pmu *pmu, const char *name,
>> -                                  bool skip_duplicate_pmus)
>> +size_t pmu_deduped_name_len(const struct perf_pmu *pmu, const char *name,
>> +                           bool skip_duplicate_pmus)
> 
> nit: I think the name should be perf_pmu__deduped_name_len for
> consistency with the other non-static functions.
> 

Will change.

>>   {
>> +       name = name ?: "";
> 
> nit: Should this just use pmu->name ?
> 

I can keep this part at the callsite in 
perf_pmus__scan_skip_duplicates() to avoid any confusion about this 
function accessing pmu->name or not. The only reason this function takes 
a separate name parameter is to allow it to work with struct 
pmu_event_info elsewhere as well.

>>          return skip_duplicate_pmus && !pmu->is_core
>>                  ? pmu_name_len_no_suffix(name)
>>                  : strlen(name);
>> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
>> index b93014cc3670..ce6a394a695d 100644
>> --- a/tools/perf/util/pmu.h
>> +++ b/tools/perf/util/pmu.h
>> @@ -297,5 +297,7 @@ struct perf_pmu *perf_pmus__find_core_pmu(void);
>>
>>   const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config);
>>   bool perf_pmu__is_fake(const struct perf_pmu *pmu);
>> +size_t pmu_deduped_name_len(const struct perf_pmu *pmu, const char *name,
>> +                           bool skip_duplicate_pmus);
>>
>>   #endif /* __PMU_H */
>> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
>> index cb1b14ade25b..1acc27af4d02 100644
>> --- a/tools/perf/util/pmus.c
>> +++ b/tools/perf/util/pmus.c
>> @@ -358,12 +358,14 @@ static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
>>          if (!pmu) {
>>                  pmu_read_sysfs(PERF_TOOL_PMU_TYPE_ALL_MASK);
>>                  pmu = list_prepare_entry(pmu, &core_pmus, list);
>> -       } else
>> -               last_pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "");
>> +       } else {
>> +               last_pmu_name_len = pmu_deduped_name_len(pmu, pmu->name,
>> +                                                        /*skip_duplicate_pmus=*/true);
>> +       }
>>
>>          if (use_core_pmus) {
>>                  list_for_each_entry_continue(pmu, &core_pmus, list) {
>> -                       int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "");
>> +                       int pmu_name_len = strlen(pmu->name ?: "");
>>
>>                          if (last_pmu_name_len == pmu_name_len &&
>>                              !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_len))
> 
> Can this code be removed given there shouldn't be core PMUs with
> identical names? ie:
> ```
> if (use_core_pmus) {
>      list_for_each_entry_continue(pmu, &core_pmus, list)
>          return pmu;
> 
>      pmu = NULL;
>      pmu = list_prepare_entry(pmu, &other_pmus, list);
> }
> ```
> 
> Thanks,
> Ian
> 

Even better, yes it probably can.

Thanks
James

>>
>> --
>> 2.34.1
>>

