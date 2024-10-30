Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2726A1DED7D
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Oct 2024 09:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730281004; cv=none; b=K2B5DthsEacLFbKJACks0JebzfJtbFY6L8vKEJwYnZ/JEVve0Lmd7x7zi1C115iDC6Av1E70NPnBATgjzBIy+3mUbdf1QSUwJA4l4kq4ce4SCQbNtDm8V062STwXcvQES6ycYm+cHVFxxMiQlmJfqVPQq+2paSq8NkNR6QmXyV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730281004; c=relaxed/simple;
	bh=g144MaWQXpBZiXVb5U4Dg70dwQdFHSoPZzIlHrCc1Ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bt6MdksWqnJYwpZEKxzoOohX2tCVaZi88eRqTkzhjnSkH3cNAtTM1t2UU+PEtZpE07VeuUr5e7t/qnXXZ6WCx2hX2stMpHZ32yFYNJXD7ocjby9lB0qD6iohdaFl0acXZeiU/LbETl5O9wL3uvx0XxftcEcDFOC4BwS8T1k2JD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gRFx/I7E; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gRFx/I7E"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d4b0943c7so4180397f8f.1
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Oct 2024 02:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730280999; x=1730885799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ELYC2gVZ99VwEOWagCjCy5Ob4XCFiyaVZTZYU7wE3hQ=;
        b=gRFx/I7EceBLGmb12ZX6i/BlvGkSRCOWrGGkcP536HyqzXPZnzld4d/sXYih03mXSp
         AfGGo41D4FKwFpPRu11Mh/hsP1iTQ688WwPsyYL0e5BhmXLs/V+EticHz0UwVGsVHKUO
         QQJHGurLLSJ8S57zpUeE8Mcfs9baVGGpLa6DA9Nw/UUdO3d2SwVUeqJPaxARk3vd1JVj
         uW+CwM3MRWjyW45ZUp4WKI6CNpPtZ7+1QhP3N+6p/mSfV9YEpeJzJ3zfU/ZAEaSDXAdp
         fIxy5RoII2+gca2jwK+M4NddY4uanPJz2W++RZf5hgqb9bpSMYKtYf7srjCH5gpjUhS7
         UtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730280999; x=1730885799;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ELYC2gVZ99VwEOWagCjCy5Ob4XCFiyaVZTZYU7wE3hQ=;
        b=w0AvCbfv5IWWP7UN/34ds6fR7D36ZzSuJOmlxN2iAqys1iimMOotOgWVPewRVDzxAx
         1d7SlBe32wB0Ud9RZ9+MSChrzZ2mAiPO+KcqFHVwXPl9/2TpG/xiyEWgtR3GY5cG1HQU
         3BVEYm+PiXv244xcE1zTAuOBIVnDvvocsyeecZc1CkkhcEO9uzi4MzMy41f/ScG9hDzR
         gfUNrlgizaoj3qVyftrdLerLwCp3bEfqjB9nMyfpP7LQNv+N1HIdqUuaEtKu2gAG6+/o
         u45HZAvNguEm1D0YiG2ZxI3fzIFgJFCQTN5xd1DWFHwC0wBW6CJT3NaGGhCbfKI9PI0q
         FwkQ==
X-Gm-Message-State: AOJu0YwU8hex4JNPRm1EW9bERLwqhOEPevOxDWsbf1OEAA7fxxsz4CGu
	Dvhe5R/4ERF3PjA9k8NCE5+BsDbm7MRJ+9ZNVUjmulw5/2i4xctBXYjys8Rrso8=
X-Google-Smtp-Source: AGHT+IEat8vDlw0b+jhMPlZN07cwDFRJB0AuzwWd5k/uXRcvUNp5TgoboENX1jvNvW/hZfV/nzNwTg==
X-Received: by 2002:adf:ea06:0:b0:37d:45f0:dd08 with SMTP id ffacd0b85a97d-380610f212emr10643342f8f.11.1730280999474;
        Wed, 30 Oct 2024 02:36:39 -0700 (PDT)
Received: from [192.168.68.136] ([145.224.65.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3c625sm14884531f8f.37.2024.10.30.02.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 02:36:39 -0700 (PDT)
Message-ID: <1ab9d5be-b31b-4f76-9ccd-001603a55e53@linaro.org>
Date: Wed, 30 Oct 2024 09:36:37 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf stat: Also hide metric from JSON if units are an
 empty string
To: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org,
 tim.c.chen@linux.intel.com, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org
References: <20241025090307.59127-1-james.clark@linaro.org>
 <20241025090307.59127-3-james.clark@linaro.org> <ZyGA9cjrtbE_eWik@google.com>
 <CAP-5=fW=DfWK9qvrtxp7z+N7aELar2xMts_=twUjWbfEQ_9vHg@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fW=DfWK9qvrtxp7z+N7aELar2xMts_=twUjWbfEQ_9vHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 30/10/2024 2:45 am, Ian Rogers wrote:
> On Tue, Oct 29, 2024 at 5:42 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>
>> Hello,
>>
>> On Fri, Oct 25, 2024 at 10:03:05AM +0100, James Clark wrote:
>>> We decided to hide NULL metric units rather than showing it as "(null)",
>>> but on hybrid systems if the process doesn't hit a PMU you get an empty
>>> string metric unit instead. To make it consistent also remove empty
>>> strings.
>>>
>>> Note that metric-threshold is already hidden in this case without this
>>> change.
>>>
>>> Where a process only runs on cpu_core and never hits cpu_atom:
>>> Before:
>>>   $ perf stat -j -- true
>>>   ...
>>>   {"counter-value" : "<not counted>", "unit" : "", "event" : "cpu_atom/branch-misses/", "event-runtime" : 0, "pcnt-running" : 0.00, "metric-value" : "0.000000", "metric-unit" : ""}
>>>   {"counter-value" : "6326.000000", "unit" : "", "event" : "cpu_core/branch-misses/", "event-runtime" : 293786, "pcnt-running" : 100.00, "metric-value" : "3.553394", "metric-unit" : "of all branches", "metric-threshold" : "good"}
>>>   ...
>>
>> I guess you're talking about "metric-unit", not plain "unit", right?
>> Then please update the subject line to reduce the config.
>>

Yep I'll update it.

>> Ian, can you please review?
> 
> It'd be nice to see the stack trace for when metric-unit is "" as I'm
> not seeing the logic in stat-shadow.c. If we know the caller than it
> seems logical the unit can be passed as NULL rather than "".
> 
> Thanks,
> Ian
> 


Here's the stack:

print_metric_json() (stat-display.c:516)
printout() (stat-display.c:912)
print_counter_aggrdata() (stat-display.c:1110)
print_counter() (stat-display.c:1224)
evlist__print_counters() (stat-display.c:1734)
print_counters() (builtin-stat.c:1016)
cmd_stat() (builtin-stat.c:2872)
run_builtin() (perf/perf.c:351)
handle_internal_command() (perf.c:404)
run_argv() (perf.c:448)
main() (perf.c:560)

The empty string is from printout():

   pm(config, os, METRIC_THRESHOLD_UNKNOWN, /*format=*/NULL, /*unit=*/"",
      /*val=*/0);

Changing it to NULL seems to work, so is probably a bit neater. I can do 
that if you think that makes sense?

There's another one for --metric-only that I didn't run into, but it 
could also make sense to change:

   if (config->metric_only) {
     pm(config, os, METRIC_THRESHOLD_UNKNOWN, "", "", 0);

>> Thanks,
>> Namhyung
>>
>>>
>>> After:
>>>   ...
>>>   {"counter-value" : "<not counted>", "unit" : "", "event" : "cpu_atom/branch-misses/", "event-runtime" : 0, "pcnt-running" : 0.00}
>>>   {"counter-value" : "5778.000000", "unit" : "", "event" : "cpu_core/branch-misses/", "event-runtime" : 282240, "pcnt-running" : 100.00, "metric-value" : "3.226797", "metric-unit" : "of all branches", "metric-threshold" : "good"}
>>>   ...
>>>
>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>> ---
>>>   tools/perf/util/stat-display.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
>>> index a5d72f4a515c..9b7fd985a42a 100644
>>> --- a/tools/perf/util/stat-display.c
>>> +++ b/tools/perf/util/stat-display.c
>>> @@ -506,7 +506,7 @@ static void print_metric_json(struct perf_stat_config *config __maybe_unused,
>>>        struct outstate *os = ctx;
>>>        FILE *out = os->fh;
>>>
>>> -     if (unit) {
>>> +     if (unit && strlen(unit)) {
>>>                json_out(os, "\"metric-value\" : \"%f\", \"metric-unit\" : \"%s\"", val, unit);
>>>                if (thresh != METRIC_THRESHOLD_UNKNOWN) {
>>>                        json_out(os, "\"metric-threshold\" : \"%s\"",
>>> --
>>> 2.34.1
>>>

