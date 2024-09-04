Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722EE1DC05C
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Sep 2024 13:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457009; cv=none; b=gT6p4LsTCtuXDWjwG82I2GSfEW6IV/Vj2KlivuD+TA++hUCx6Tan2twiNnTk0Vbems8ReCNI9vjTGW4DjfQHgvb3qTVRPrR8fxLt38PZjqd8TFRmF9swQiBgC948g9ESnSajHVjIP5tYpFLGxjctZzSVzFx1+mYUi0Ai3sMTsJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457009; c=relaxed/simple;
	bh=qtJkX2PqoVFYdBdlWbYyp5mzAidzj4chLb44Ln6lBOg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JMN32mvkDLQTie4XryIwKOAz2RAj0u8WdrKsJZeR54UgBnLypL29MS+2Ens+ibCAJszGOUMQWYjlsDDbUAEOUv7Lrx75qfosmyfjBLMUfhIYRQRVzehP4ZBamvHJpNiKiABiYFbxMHar8D5ZvJlTUWXzHTwtSB4mxObdlIaeBIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aZaUrtjU; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aZaUrtjU"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-374b25263a3so2928290f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Sep 2024 06:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725457006; x=1726061806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B86/UPLKVaKSm0EPiBkbujK3A4YitMx5WggFUmn8Coo=;
        b=aZaUrtjUoiOKODP03m0E1QtWt25s3due8GXQtYB1sJPlfv0HkN1Ih8yT2frU/NJBzX
         MybB9/dQfc3eotODJn1Fml6VMsS9giwkTxj4Byzh7GWUuPUnDqfAO3NQrkMwcYYjkRHq
         h/FORv+gyMX9o6uo9kckP0XBhz5jU2s7TDs53QUD2rJJcGZB0upothlZ6cTEQ3vbUkJ/
         dtYkKcrV8xndg1NNXlcDmu+QBLyx7E2iEyCCiIen7V0tP/H8fT4fqwcjs1/6vAIBxVAg
         dghXeVAHnLeU6PNon9kNIACRj4NOOFN1+z/TBWYHkGlWwB4NhmIZPu7+HPPRvfZqYK/K
         wquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725457006; x=1726061806;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B86/UPLKVaKSm0EPiBkbujK3A4YitMx5WggFUmn8Coo=;
        b=s6bMZK26+ud65rrzUYWoJyejr63b9CrF9k7Mrr63E8KxK9ygENsPz+Ou7H4eYA/Y7L
         yiDStS8lQ1NM4TzEwKtoGlKoW+iB2WxcCBdaLMfyApwsfP3T7xntlQ8zgDxdjRTPF4ic
         pXfBuz1gFLzFQooq66uwgEQEkLwMC3oh4xWk04EuxNqf0sjRQWEQ4RhpUsU9X+O0bbaA
         Jyia51cQkyD28RLk/xSMnrz6IuJDZK9NmgwCEyUqlEIfGGeK7Q/7i0ySxFOkisJPOsrk
         anRPjD2G5jROa71/M/2a1mhiQr77kPyas8TvmsvpGM9s2uHQiRHYUUyn+qllZhmCts/m
         P5lQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQkZCrubkBCJlILdJhsqNcKmY4aoNTekM//ojMmbzUR62KsmpBllNVCZcHkgtl6PyukbtRp3EdI62ztOZ37U+Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm0965dAsV7nXLk8g1gdRRVpUYTVe9bTqZuHqFNWWupyRQgsuo
	jHMbDC5sN0pc9d9Vgdiybq+rhV/THXUNM1qZ9JXuyFHQRM5VxWIGQqRq6heOBvk=
X-Google-Smtp-Source: AGHT+IGCca6VtkCUEewJ04oZM5OKZlmILREvFYANBtzDYBJo5Pgpzgh/80aH7ezyMm1sRLB/m6/1WA==
X-Received: by 2002:adf:f2d1:0:b0:374:c3f7:6af1 with SMTP id ffacd0b85a97d-374c3f76cd2mr7592505f8f.15.1725457005502;
        Wed, 04 Sep 2024 06:36:45 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee71616sm17094656f8f.31.2024.09.04.06.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 06:36:45 -0700 (PDT)
Message-ID: <251acd21-7d0d-451c-b581-cdb74b4096ed@linaro.org>
Date: Wed, 4 Sep 2024 14:36:43 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] perf tools: Add fallback for exclude_guest
From: James Clark <james.clark@linaro.org>
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, Mark Rutland <mark.rutland@arm.com>,
 James Clark <james.clark@arm.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kajol Jain
 <kjain@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Atish Patra <atishp@atishpatra.org>, Palmer Dabbelt <palmer@rivosinc.com>,
 Mingwei Zhang <mizhang@google.com>, Ian Rogers <irogers@google.com>,
 Kan Liang <kan.liang@linux.intel.com>
References: <20240904064131.2377873-1-namhyung@kernel.org>
 <20240904064131.2377873-8-namhyung@kernel.org>
 <8c47cb2a-2bea-422d-b16c-f304ab4ff470@linaro.org>
Content-Language: en-US
In-Reply-To: <8c47cb2a-2bea-422d-b16c-f304ab4ff470@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 04/09/2024 2:28 pm, James Clark wrote:
> 
> 
> On 04/09/2024 7:41 am, Namhyung Kim wrote:
>> It seems Apple M1 PMU requires exclude_guest set and returns EOPNOTSUPP
>> if not.  Let's add a fallback so that it can work with default events.
>>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: James Clark <james.clark@linaro.org>
>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>> ---
>>   tools/perf/util/evsel.c | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index 0de0a72947db3f10..8c4d70f7b2f5b880 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -3400,6 +3400,27 @@ bool evsel__fallback(struct evsel *evsel, 
>> struct target *target, int err,
>>                 "to fall back to excluding hypervisor samples", 
>> paranoid);
>>           evsel->core.attr.exclude_hv = 1;
>> +        return true;
>> +    } else if (err == EOPNOTSUPP && !evsel->core.attr.exclude_guest &&
>> +           !evsel->exclude_GH) {
>> +        const char *name = evsel__name(evsel);
>> +        char *new_name;
>> +        const char *sep = ":";
>> +
>> +        /* Is there already the separator in the name. */
>> +        if (strchr(name, '/') ||
>> +            (strchr(name, ':') && !evsel->is_libpfm_event))
>> +            sep = "";
>> +
>> +        if (asprintf(&new_name, "%s%su", name, sep) < 0)
>> +            return false;
>> +
>> +        free(evsel->name);
>> +        evsel->name = new_name;
>> +        /* Apple M1 requires exclude_guest */
>> +        scnprintf(msg, msgsize, "trying to fall back to excluding 
>> guest samples");
>> +        evsel->core.attr.exclude_guest = 1;
>> +
>>           return true;
>>       }
> 
> Not sure if this is working, for some reason it doesn't try the 
> fallback. With exclude guest made mandatory in the Arm PMU, then:
> 

Looks like you change this, but it's not obvious why the stat behavior 
is different to perf record anyway:

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 8b9889873d3e..6f2ee3032f5f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -639,7 +639,7 @@ static enum counter_recovery 
stat_handle_error(struct evsel *counter)
          * (behavior changed with commit b0a873e).
          */
         if (errno == EINVAL || errno == ENOSYS ||
-           errno == ENOENT || errno == EOPNOTSUPP ||
+           errno == ENOENT ||
             errno == ENXIO) {
                 if (verbose > 0)
                         ui__warning("%s event is not supported by the 
kernel.\n",


