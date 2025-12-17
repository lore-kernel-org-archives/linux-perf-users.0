Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841451A5B84
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 09:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765963853; cv=none; b=fb10E3TwThn7FGO937p6QYb3E2/pusinxuUOvP9jwI9KL9qJRxth9YG9bw5pQ+i8OzoWzSi1Np5dvOud+hMUq/gvosd690G5Ef77J3pHzzdFeuUoKcwkGBG7lcodAAyDpMeyeZ/87jtFighI6SZLwBn7FPc8fmqeNjfW283ibKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765963853; c=relaxed/simple;
	bh=Md0U83NqjQGkSdCE2vPOD3X3PcjtRdA1M/c3NPnSJkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sAoeCOseXncKFBdyGZQYlHSSACKpg/KscESiTu0OpiatrUG+ar/kvftK0tbaAi88WVXVczd2BPeDyof1qgzi8W585cBPwCzMyw062ex3I9lgJFNMfi5KUa5ynciRufd8L6jZF7N79k1kBxn9hb1n7nM/kQcQa0nHrItQHt+Ljfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=caeV8UIB; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="caeV8UIB"
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-64312565c10so9855763a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 01:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765963850; x=1766568650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=reyxjbWnqQbkZ/PY9ifbYGWOG1VNVTq6TpSbrTRbFzs=;
        b=caeV8UIBQs1QZgnjYpRlOjoCdmqkN2rckVSCW1/PFGwavNSR9RLRff+kxL65dowGYp
         XIZEGRKRQtVadfHhYU8AXiQrajIGB42Z/cxCg578scWEw5vMp92cE+fOnXjxXkO8svyi
         M9si/DKVRMFLkDSmCEIsp5NmSq93cnI6wbw4Kypmd0kgaN7LbhdoTNB+NX1NdHmtK4fE
         X9SqQW+p/50Zjtngrh2D+tsu4f9DmysBYFgpFZXL7aWNApwMO/VyuLMqzP+bKdHQj+Rr
         VFGYR7c1U967O/HapQjdi7EvaCLUuChNczJy69Yzu/64nWjhn3DaXxwJd92pkfJGFpVD
         PFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765963850; x=1766568650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=reyxjbWnqQbkZ/PY9ifbYGWOG1VNVTq6TpSbrTRbFzs=;
        b=OhMUTatRuQQkJII2dukQwptirWCwANYZPzc3o6QpAcMX0FP3WMjzgsVZDNGgrmN3xc
         rNPWl5lJeNPxowouL5COgodGH4POVDt7zX6ODZg8Q40CK9zKq47AePsee/dvov1rQmH7
         aJ4NbzhnZ3Hq3YEtDbBE0MofgtzBm1KauQ9GUJ+Uoe87z9GfS6xPa2xgxVb1LIAAxsf5
         KWnSUYG1u7nXSAH4PZV2stAt77yOg6LG+EdTuMr+U+7lBRAGhh5RIs7iL0yW9Tf2c6x1
         nsN4GvMRXwxgv5t7Ox6xF4qBJzZoduTS5O7YmKzvSLq+FStP3eXeZx11yoj21LFGCxKV
         gkEw==
X-Forwarded-Encrypted: i=1; AJvYcCVAKM3TaILk/STZXAtTO6L7X6i5h6wXQR5C+hp6mwLAHJvIXAJqAHOodLFr7jITNra4My4PYtoSsIIiiuXQft5K@vger.kernel.org
X-Gm-Message-State: AOJu0YxXCUu60n2n90UhNKIN7aJzWxyfh91eFPJOxv3ADYCLiuRryjGr
	OCv1HOKy+J0m1IcEg6eoYfg4MjuA2HXI4kVwyCg1o3LIhbyqT+68hswK51tG/V6Izr0=
X-Gm-Gg: AY/fxX4RaGOeon107Yf60giR41TNWGbUMyzDoihNvsbZv3zOX4j3EZU8/T5p7hColxU
	d+LbvsDdlsQ0joTkN7W8rH5sO178LiPJMnPe71oRJs5yeZJ2Oqr689WhKav/OIbAbp78djPTCUp
	VvgDe6tNkTDIgQZ11fp0GeOSYfZZNhOgKVdSJwAM2HoaBJtM9SJjK5NI9TDPwEIuNtduqzaWZs9
	mGjw2tc7MgtPrYEMFIYotO708uvqzUSScYFRQkCd9EjslXD6djp2+VLk4/A1kX0ln6sVCqkWVER
	BOpQ3V2CFrjFhTd0Du7+aSi50kNND5eh1iJXMVburRBfgR3x9LwTamXnkcJvvlarFp7EJZZTBck
	OZg138QT8f1Jsi4nWkqnaA+Aut7oMaVuw4nmg0viuty6LkKz5lnpBz7TkEr2r/9qIvDf1kOU+so
	tx2tOi6cgmnq9Tm/4rcG0N
X-Google-Smtp-Source: AGHT+IHo8MFKKOZcL4dFoI0ohz3Jq9DYwnbOFUbkPu3ssXHjV+PQjNsSYu4MEOkNhQs6nFW7YSQgzA==
X-Received: by 2002:a05:6402:26cf:b0:649:6c78:dc48 with SMTP id 4fb4d7f45d1cf-6499b1e1a0fmr16912267a12.26.1765963849665;
        Wed, 17 Dec 2025 01:30:49 -0800 (PST)
Received: from [192.168.0.108] ([130.185.218.160])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b3f4ea39csm1870183a12.6.2025.12.17.01.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 01:30:49 -0800 (PST)
Message-ID: <58d9f452-c075-4499-8975-387f3cdb052a@linaro.org>
Date: Wed, 17 Dec 2025 11:30:47 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/12] perf evsel: Add a helper to get the value of a
 config field
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
References: <20251212-james-perf-config-bits-v3-0-aa36a4846776@linaro.org>
 <20251212-james-perf-config-bits-v3-5-aa36a4846776@linaro.org>
 <CAP-5=fUbr56hFd7e7yt33-gnhEGGa72GLmShQ5bCHxQjFAbFCQ@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fUbr56hFd7e7yt33-gnhEGGa72GLmShQ5bCHxQjFAbFCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/12/2025 22:44, Ian Rogers wrote:
> On Fri, Dec 12, 2025 at 7:32 AM James Clark <james.clark@linaro.org> wrote:
>>
>> This will be used by aux PMUs to read an already written value for
>> configuring their events and for also testing.
>>
>> Its helper pmu_format_unpack() does the opposite of the existing
>> pmu_format_value() so rename that one to pmu_format_pack() so it's clear
>> how they are related.
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   tools/perf/util/evsel.h |  2 ++
>>   tools/perf/util/pmu.c   | 77 ++++++++++++++++++++++++++++++++++++++++++-------
>>   2 files changed, 68 insertions(+), 11 deletions(-)
>>
>> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
>> index a08130ff2e47a887b19f6c47bfa9f51e0c40d226..092904a61ec7afdc59253f9b78a9fe8b7cb5bfa7 100644
>> --- a/tools/perf/util/evsel.h
>> +++ b/tools/perf/util/evsel.h
>> @@ -575,6 +575,8 @@ void evsel__uniquify_counter(struct evsel *counter);
>>          ((((src) >> (pos)) & ((1ull << (size)) - 1)) << (63 - ((pos) + (size) - 1)))
>>
>>   u64 evsel__bitfield_swap_branch_flags(u64 value);
>> +int evsel__get_config_val(struct perf_pmu *pmu, struct evsel *evsel,
>> +                         const char *config_name, u64 *val);
>>   void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
>>                                  const char *config_name, u64 val);
>>
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 514cba91f5d99b399d2d6a1e350971660c54a9fc..ef7358ad1fb955f29f2e68b3d0ce711754e4d67c 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -144,8 +144,8 @@ struct perf_pmu_format {
>>   };
>>
>>   static int pmu_aliases_parse(struct perf_pmu *pmu);
>> -static void pmu_format_value(unsigned long *format, __u64 value, __u64 *v,
>> -                            bool zero);
>> +static void pmu_format_pack(unsigned long *format, __u64 value, __u64 *v,
>> +                           bool zero);
>>   static struct perf_pmu_format *pmu_find_format(const struct list_head *formats,
>>                                                 const char *name);
>>
>> @@ -1377,6 +1377,61 @@ bool evsel__is_aux_event(const struct evsel *evsel)
>>          return pmu && pmu->auxtrace;
>>   }
>>
>> +/*
>> + * Unpacks a raw config[n] value using the sparse bitfield that defines a
>> + * format attr. For example "config1:1,6-7,44" defines a 4 bit value across non
>> + * contiguous bits and this function returns those 4 bits as a value.
>> + */
>> +static u64 pmu_format_unpack(u64 format, u64 config_val)
>> +{
>> +       int val_bit = 0;
>> +       u64 res = 0;
>> +       int fmt_bit;
>> +
>> +       for_each_set_bit(fmt_bit, &format, PERF_PMU_FORMAT_BITS) {
>> +               if (test_bit(fmt_bit, &config_val))
>> +                       res |= BIT_ULL(val_bit);
>> +
>> +               val_bit++;
>> +       }
>> +       return res;
>> +}
>> +
>> +int evsel__get_config_val(struct perf_pmu *pmu, struct evsel *evsel,
>> +                         const char *config_name, u64 *val)
> 
> nits:
> This is an evsel__ function but the evsel is the 2nd argument not the first.
> Why pass the PMU and not just read evsel->pmu (or better evsel__find_pmu) ?

That makes sense, I can do that.

> Why not place this in evsel.c to match the header file declaration?

This was for consistency with evsel__set_config_if_unset() that Arnaldo 
moved to pmu.c because of an issue with the Python bindings [1]. That 
doesn't seem to be an issue any more so I could move both to evsel.c. 
That would require making the following things public:

   struct perf_pmu_format
   pmu_format_pack()
   pmu_format_unpack()
   pmu_find_format()

Probably not the end of the world though?

[1]: https://lore.kernel.org/all/ZEbAS2yx2fguW60w@kernel.org/

> The evsel could be likely be const.
> 

Will do

> Thanks,
> Ian
> 
>> +{
>> +       struct perf_pmu_format *format = pmu_find_format(&pmu->format, config_name);
>> +       u64 bits = perf_pmu__format_bits(pmu, config_name);
>> +
>> +       if (!format || !bits) {
>> +               pr_err("Unknown/empty format name: %s\n", config_name);
>> +               *val = 0;
>> +               return -EINVAL;
>> +       }
>> +
>> +       switch (format->value) {
>> +       case PERF_PMU_FORMAT_VALUE_CONFIG:
>> +               *val = pmu_format_unpack(bits, evsel->core.attr.config);
>> +               return 0;
>> +       case PERF_PMU_FORMAT_VALUE_CONFIG1:
>> +               *val = pmu_format_unpack(bits, evsel->core.attr.config1);
>> +               return 0;
>> +       case PERF_PMU_FORMAT_VALUE_CONFIG2:
>> +               *val = pmu_format_unpack(bits, evsel->core.attr.config2);
>> +               return 0;
>> +       case PERF_PMU_FORMAT_VALUE_CONFIG3:
>> +               *val = pmu_format_unpack(bits, evsel->core.attr.config3);
>> +               return 0;
>> +       case PERF_PMU_FORMAT_VALUE_CONFIG4:
>> +               *val = pmu_format_unpack(bits, evsel->core.attr.config4);
>> +               return 0;
>> +       default:
>> +               pr_err("Unknown format value: %d\n", format->value);
>> +               *val = 0;
>> +               return -EINVAL;
>> +       }
>> +}
>> +
>>   /*
>>    * Set @config_name to @val as long as the user hasn't already set or cleared it
>>    * by passing a config term on the command line.
>> @@ -1432,7 +1487,7 @@ void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
>>                  return;
>>
>>          /* Otherwise replace it */
>> -       pmu_format_value(&bits, val, vp, /*zero=*/true);
>> +       pmu_format_pack(&bits, val, vp, /*zero=*/true);
>>   }
>>
>>   static struct perf_pmu_format *
>> @@ -1477,8 +1532,8 @@ int perf_pmu__format_type(struct perf_pmu *pmu, const char *name)
>>    * Sets value based on the format definition (format parameter)
>>    * and unformatted value (value parameter).
>>    */
>> -static void pmu_format_value(unsigned long *format, __u64 value, __u64 *v,
>> -                            bool zero)
>> +static void pmu_format_pack(unsigned long *format, __u64 value, __u64 *v,
>> +                           bool zero)
>>   {
>>          unsigned long fbit, vbit;
>>
>> @@ -1595,23 +1650,23 @@ static int pmu_config_term(const struct perf_pmu *pmu,
>>                  switch (term->type_term) {
>>                  case PARSE_EVENTS__TERM_TYPE_CONFIG:
>>                          assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
>> -                       pmu_format_value(bits, term->val.num, &attr->config, zero);
>> +                       pmu_format_pack(bits, term->val.num, &attr->config, zero);
>>                          break;
>>                  case PARSE_EVENTS__TERM_TYPE_CONFIG1:
>>                          assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
>> -                       pmu_format_value(bits, term->val.num, &attr->config1, zero);
>> +                       pmu_format_pack(bits, term->val.num, &attr->config1, zero);
>>                          break;
>>                  case PARSE_EVENTS__TERM_TYPE_CONFIG2:
>>                          assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
>> -                       pmu_format_value(bits, term->val.num, &attr->config2, zero);
>> +                       pmu_format_pack(bits, term->val.num, &attr->config2, zero);
>>                          break;
>>                  case PARSE_EVENTS__TERM_TYPE_CONFIG3:
>>                          assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
>> -                       pmu_format_value(bits, term->val.num, &attr->config3, zero);
>> +                       pmu_format_pack(bits, term->val.num, &attr->config3, zero);
>>                          break;
>>                  case PARSE_EVENTS__TERM_TYPE_CONFIG4:
>>                          assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
>> -                       pmu_format_value(bits, term->val.num, &attr->config4, zero);
>> +                       pmu_format_pack(bits, term->val.num, &attr->config4, zero);
>>                          break;
>>                  case PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG:
>>                          assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
>> @@ -1749,7 +1804,7 @@ static int pmu_config_term(const struct perf_pmu *pmu,
>>                   */
>>          }
>>
>> -       pmu_format_value(format->bits, val, vp, zero);
>> +       pmu_format_pack(format->bits, val, vp, zero);
>>          return 0;
>>   }
>>
>>
>> --
>> 2.34.1
>>

