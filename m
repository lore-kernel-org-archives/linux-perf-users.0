Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E5E33F6
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Dec 2024 08:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733906401; cv=none; b=EPM+nbMa1RUAHqYKrG2VEUYDcbZh+WbFAEsyl/R+VH369X9gw7/5UedDmnouFXgk/4YKmKtiT0y2a8U4TWEn6YFr59S942asm86DdGfse73lBxXK/+bBnUFsfxEoq54tp8eQ8kRljbnLLIuJz89MBcX4vP+LCuubz6vsgONxxDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733906401; c=relaxed/simple;
	bh=kIWrg3KSpOyDbnrZlH2FQiv66peDmFlBUHq7UQwtICs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQpG00xOcxPVii8yc1zPEsN1ChJgwRy3NYodBZW5zNeKXl8F8bBcsdfPjktdKB3I9Q4iYZczr6rZ+2qpbuw7QTonWmcoNB/1Kc3OG3BCzuiwKlqVMh7C2va4Ydn8+DTtljhx/l0z/XYNaGPcHLUwzCN0PilzKYF4tNg2r9sAuYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NRLfvgLQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NRLfvgLQ"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43618283d48so8681975e9.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Dec 2024 00:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733906397; x=1734511197; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WiN5zNmlr+UoYjkxWV6ZTSSbXqyBYacLtMs961cCxng=;
        b=NRLfvgLQCN6wCgdeJaxtq/o4CeJIi8uz/VJjYxdVnPNdFILdlEUolJCnwaO4vBq4Ll
         eiqrzWMgPXtehRcq4IA7wT1j3/Ecl1FcBrJn4MGB9GuEaZNyQ01K2UBdODupMQfbr4yh
         4k8HYglzDSQrVROx5EWtnQToXn9AgBuBmEHZv5bBJLeGl7wyZegberfwyNKD6OxjOfA+
         A3rtCUw2mCu9WdDeSrxgPImraU5++Ay5P3idweDuYvVdLyYqW+/Ii/sLf38tCoRldjp8
         oqtyiL2g1/NMhlyVC/iiMl4/bAn5vxYr7XnBL1Y+T6D6FrO70dPXN7NCeCN80YU+XpCM
         he1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733906397; x=1734511197;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WiN5zNmlr+UoYjkxWV6ZTSSbXqyBYacLtMs961cCxng=;
        b=dSIl2XdgT785oOS8QXqaHlQeM48WS8ue9mI8HOTy5Y4yWMMT3kzYaJix2UMaTN4Isp
         cFeeuFF0bMU/KXmiOOB+A1U2OTTTAIbgdEaqOJNQE/L4q4TVVvwAL6dg1CB6VuhtucUP
         hLh0UgrvjL1ILoIvi3z4oAkrpBgBlZLnWiVXW2YG8+eZ+23a+r/VlLpPydqQRePc8Jon
         VvXvftcVEsPxiOUBjIbzPYWIRPlm8Cr7OninsPrviPL5UGeKL8B0kLgMyiQRXazJwg83
         TCXsLZTkevvrViTYB36SCop8MPvE7SX+Inxwr0fQ8B3F3BwbxNMxz10mpTHL5j6SA29p
         EMaA==
X-Gm-Message-State: AOJu0YxKgMCWwlQDXB3g1CnssLHu0xrU5/4+LODJ63hd37I+0oitIdtX
	Re+hychB9dTiRCRh1/dvQ0UkkPZkvVAyK32jH9xNAs3H9dZklS0souHiCaAEhIJB+Rsc04bn88S
	5
X-Gm-Gg: ASbGncvdO9wtYGYQTOI3wQFukx2QxVTvmD/roN5Y8kbFnCtxW/hogFzEe7fZMYwpSW8
	2iEGhaPXXa8UmV1kUQy/LUUsmg0R5Iz/SUWToNi6gl+4117GzTaNeqAzUhPOpSltyQfqy7u24/d
	QVO0/xYMokxRZgGKduDK7F8PIamXJQdIj1lqiNR8u+yp8G7bJvEeeRxFftXiqK7xyO9G7FaD4Sn
	sIrHPm0wk0bZd2CvlDhfcxJTXb+yJTjIsZG//6jxg9wJA8c1L/OTdOf7HhxPYoP/A==
X-Google-Smtp-Source: AGHT+IG632TmiPJaoyDGB4vW7o1ATYlaVMdaB35oacxOuyQFo3BTQkCwZSwUNZR2kkZt9Hh4Xgp1tQ==
X-Received: by 2002:a05:600c:1c1c:b0:434:a350:207c with SMTP id 5b1f17b1804b1-4361c3f4cbcmr12594755e9.23.1733906397395;
        Wed, 11 Dec 2024 00:39:57 -0800 (PST)
Received: from [192.168.68.163] ([209.198.129.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824a609esm763361f8f.40.2024.12.11.00.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 00:39:56 -0800 (PST)
Message-ID: <9003cbc9-bc53-4fb7-a35e-d416c22df4ca@linaro.org>
Date: Wed, 11 Dec 2024 08:39:55 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf probe: Fix uninitialized variable
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>,
 Dima Kogan <dima@secretsauce.net>, "Dr. David Alan Gilbert"
 <linux@treblig.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20241209171222.1422577-1-james.clark@linaro.org>
 <20241211075510.ea7924b5b80bf0d95993086b@kernel.org>
 <CA+JHD90Brn_jLxPPMr1M0RB6+ms1O3+OvOPWJ0wkUe+MXYpH1A@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CA+JHD90Brn_jLxPPMr1M0RB6+ms1O3+OvOPWJ0wkUe+MXYpH1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/12/2024 12:43 am, Arnaldo Carvalho de Melo wrote:
> On Tue, Dec 10, 2024, 7:55 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
>> Hi,
>>
>> On Mon,  9 Dec 2024 17:12:21 +0000
>> James Clark <james.clark@linaro.org> wrote:
>>
>>> Since the linked fixes: commit, err is returned uninitialized due to the
>>> removal of "return 0". Initialize err to fix it, and rename err to out
>>> to avoid confusion because buf is still supposed to be freed in non
>>> error cases.
>>>
>>> This fixes the following intermittent test failure on release builds:
>>>
>>>   $ perf test "testsuite_probe"
>>>   ...
>>>   -- [ FAIL ] -- perf_probe :: test_invalid_options :: mutually exclusive
>> options :: -L foo -V bar (output regexp parsing)
>>>   Regexp not found: \"Error: switch .+ cannot be used with switch .+\"
>>>   ...
>>>
>>> Fixes: 080e47b2a237 ("perf probe: Introduce quotation marks support")
>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>> ---
>>>   tools/perf/util/probe-event.c | 20 ++++++++++----------
>>>   1 file changed, 10 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/tools/perf/util/probe-event.c
>> b/tools/perf/util/probe-event.c
>>> index 6d51a4c98ad7..35af6570cf9b 100644
>>> --- a/tools/perf/util/probe-event.c
>>> +++ b/tools/perf/util/probe-event.c
>>> @@ -1370,7 +1370,7 @@ int parse_line_range_desc(const char *arg, struct
>> line_range *lr)
>>>   {
>>>        char *buf = strdup(arg);
>>>        char *p;
>>> -     int err;
>>> +     int err = 0;
>>
>> I think only this is required, and others are just cleanups by renaming
>> err -> out (usually for-next).
>> But Arnaldo is OK to combine these changes, I'm OK too.
>>
>> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>
> 
> I agree, almost mentioned that, but since you mentioned this, yes, I'd
> prefer to have as small as possible a patch.
> 
> - Arnaldo
> 
> 

Sure, I'll split it

>> Thank you,
>>
>>>
>>>        if (!buf)
>>>                return -ENOMEM;
>>> @@ -1383,20 +1383,20 @@ int parse_line_range_desc(const char *arg,
>> struct line_range *lr)
>>>                if (p == buf) {
>>>                        semantic_error("No file/function name in '%s'.\n",
>> p);
>>>                        err = -EINVAL;
>>> -                     goto err;
>>> +                     goto out;
>>>                }
>>>                *(p++) = '\0';
>>>
>>>                err = parse_line_num(&p, &lr->start, "start line");
>>>                if (err)
>>> -                     goto err;
>>> +                     goto out;
>>>
>>>                if (*p == '+' || *p == '-') {
>>>                        const char c = *(p++);
>>>
>>>                        err = parse_line_num(&p, &lr->end, "end line");
>>>                        if (err)
>>> -                             goto err;
>>> +                             goto out;
>>>
>>>                        if (c == '+') {
>>>                                lr->end += lr->start;
>>> @@ -1416,11 +1416,11 @@ int parse_line_range_desc(const char *arg,
>> struct line_range *lr)
>>>                if (lr->start > lr->end) {
>>>                        semantic_error("Start line must be smaller"
>>>                                       " than end line.\n");
>>> -                     goto err;
>>> +                     goto out;
>>>                }
>>>                if (*p != '\0') {
>>>                        semantic_error("Tailing with invalid str '%s'.\n",
>> p);
>>> -                     goto err;
>>> +                     goto out;
>>>                }
>>>        }
>>>
>>> @@ -1431,7 +1431,7 @@ int parse_line_range_desc(const char *arg, struct
>> line_range *lr)
>>>                        lr->file = strdup_esq(p);
>>>                        if (lr->file == NULL) {
>>>                                err = -ENOMEM;
>>> -                             goto err;
>>> +                             goto out;
>>>                        }
>>>                }
>>>                if (*buf != '\0')
>>> @@ -1439,7 +1439,7 @@ int parse_line_range_desc(const char *arg, struct
>> line_range *lr)
>>>                if (!lr->function && !lr->file) {
>>>                        semantic_error("Only '@*' is not allowed.\n");
>>>                        err = -EINVAL;
>>> -                     goto err;
>>> +                     goto out;
>>>                }
>>>        } else if (strpbrk_esq(buf, "/."))
>>>                lr->file = strdup_esq(buf);
>>> @@ -1448,10 +1448,10 @@ int parse_line_range_desc(const char *arg,
>> struct line_range *lr)
>>>        else {  /* Invalid name */
>>>                semantic_error("'%s' is not a valid function name.\n",
>> buf);
>>>                err = -EINVAL;
>>> -             goto err;
>>> +             goto out;
>>>        }
>>>
>>> -err:
>>> +out:
>>>        free(buf);
>>>        return err;
>>>   }
>>> --
>>> 2.34.1
>>>
>>
>>
>> --
>> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>
> 

