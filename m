Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE683BBF0
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 14:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736434253; cv=none; b=Im2rAOUWPKPKWeFbTzbbGhTb2W4O1LFUft+41+N1hDE5fp48zUOPYvnjIh8qqYo7X2ZVLmu3JKXIK0xkdB5F+XOA3c6xDo49z0JdJua5w9Ypw9Or5ftBoxl+mnEJALgMG4y0u7J4OFeKI+US7SVR9wVxuZxlDSVB9eecWMJYV5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736434253; c=relaxed/simple;
	bh=q2hm5e03GHcl7yGH+zD8oWdvoCkRIVVhxDbNPxk1hl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tRmzk9KSY5DHgMSPkO/cy667lSX/hnqqIWJAoz1mhpNaOls17INThDb/+wpMZ+XigpbnCgDGhP45oPmL7fWts1ViuSXlbn10arvcSzhKEGY+PFsmfs23j13e5qBX2JRCjxMNVp/6ActA+5eDuT0tqdZR4hH0lUpWrC4KINdZeqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dokM3ndg; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dokM3ndg"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso900450f8f.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jan 2025 06:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736434250; x=1737039050; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L5DpCE96R7nb9vcFrBhf7ly1HvCsEb1jpqWjC9kRG1I=;
        b=dokM3ndg5oRHq1JcWxsdxBVu+abD2Y+/vRG4pfZonJ4SLNo5UAArOLRVHm/bYqNqgo
         HAxXxVJUbLkb29PPIMUwo5dFwsvAt2DmIYGMyjlZq2hlmjc+/3xdN3YfqP/bkIf5z5I+
         N+b7LpdUzglE4oPDA8uW0RMZHelgFbJr5b1Y+wZ3eQdq9umaAP5uTu4A7FYJU8c87biH
         8KXyD9esQAHpmsor9sUgYXGfqIbEY477At/mWfNFxU1TWhP5nwaCYEPDsECZAm3a6P2v
         FNvUAMV/GjivrtbBawl+nyV3DvoDCGEgzkQKLrjfgaYNKgD46kJrSArplW9S5B5NghzP
         eICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736434250; x=1737039050;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L5DpCE96R7nb9vcFrBhf7ly1HvCsEb1jpqWjC9kRG1I=;
        b=NvNUC2z1RGfJmmptVgDnCtG0LvOUP60pcgphBRI03LCrNVSGZnPP+Qi9I3N7/q7jHr
         kCFL9+AyMydXAqusdgE6K6MDJ6xM+qwUBpmDE1V+0yoxT5LkTIhwLF20KXBYrDob6fa2
         lPMjznABDorTWCr1pAJAaM5PZ2z838MbBEkSlPKFyNWEhAZsAxSbOKLJMNV0XG2VIEyL
         p+sCcSzm48wXbaCbIg/D2AQd6orj+oMD1zG98WZOmsP9wXz3+j0gymQNKCnMPdIZxO/u
         IVrGL76yjS0SWOK9fpS25Q/bFfnmHUvk4UpITPqfVsUJIc+HBIxQK0i5QFt7vRNuqiS1
         C5DQ==
X-Gm-Message-State: AOJu0YzEAMRMPQVui6yN2jwPim6+qfJji+TFSKwyV2PRB507IJwCgwrm
	zIGOw4of3PF+TmIQqw3MxE/1dlN5bTPDiOzgv7ZirDLtCu0OI9jlkOTMB6rCXk0=
X-Gm-Gg: ASbGncvsetU5oUkZ9VjBzvhI1po7AdASDlZ4Yrabv85SyZMawA8bNc0UmbAuJX0IV7T
	/KpP93En3VskY7UvpnniI0ejHRpri63BpmYoJTugl2aQRsJ/dGxdi9Eh3ltZzFXaSv1ZA3OEuf3
	bexACWVXkeeM+WjcWT9LXL42D/4fuslBEFy9ETr0bfp9kExaOV1n0tVIPd8HWzqOJ6iOCxJZyjz
	z7UbKE2oQ1mj6YbkebIKaGh3KtY2+oDn1AM/rEZQGp89PtIdWlx4PoNu7EPczOOifI=
X-Google-Smtp-Source: AGHT+IEcH8+Ovf9omwBo2p4K0b2ig9ksDRfs3Jq9Fpco+kBxi3c4aP25riv95a6SHGcGD9NTY6W2Ag==
X-Received: by 2002:adf:c08d:0:b0:38a:87cc:fb42 with SMTP id ffacd0b85a97d-38a87ccfc9cmr5369663f8f.21.1736434250198;
        Thu, 09 Jan 2025 06:50:50 -0800 (PST)
Received: from [192.168.68.163] ([145.224.67.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b8214sm2013068f8f.78.2025.01.09.06.50.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 06:50:49 -0800 (PST)
Message-ID: <89e678bc-f0af-4929-a8a6-a2666f1294a4@linaro.org>
Date: Thu, 9 Jan 2025 14:50:48 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf report: Fix input reload/switch functionality
To: Dmitry Vyukov <dvyukov@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 namhyung@kernel.org, irogers@google.com
References: <20250108063628.215577-1-dvyukov@google.com>
 <384d6c4b-d2ce-47f8-9030-6225758b5923@linaro.org>
 <CACT4Y+bUrZHD5H+z5-+dKGbtBPO9EQNzBoOwYGhp7zHGrHYrQg@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CACT4Y+bUrZHD5H+z5-+dKGbtBPO9EQNzBoOwYGhp7zHGrHYrQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/01/2025 3:35 pm, Dmitry Vyukov wrote:
> On Wed, 8 Jan 2025 at 16:23, James Clark <james.clark@linaro.org> wrote:
>>
>> On 08/01/2025 6:36 am, Dmitry Vyukov wrote:
>>> Currently the code checks that there is no "ipc" in the sort order
>>> and add an ipc string. This will always error out on the second pass
>>> after input reload/switch, since the sort order already contains "ipc".
>>> Do the ipc check/fixup only on the first pass.
>>>
>>
>> Hi Dmitry,
>>
>> A reproducer with before and after behavior might be helpful for the review.
>>
>> It might be unrelated to your change here, but the input switch thing
>> didn't seem to do anything for me. If I record two files, open the first
>> one, press S and select the second file nothing seems to change. I
>> assumed it would show the other file but nothing changes?
>>
>>    $ perf record -- true
>>    $ perf record -o 2.data -- ls
>>    $ perf report
>>    S key
>>    load 2.data
> 
> Yes, sure. This needs "--sort symbol":
> 
> perf report --sort symbol
> 
> then press 's', select file, and it terminates.
> 
> Affects fewer cases then I initially assumed, since I happened to run
> with "--sort symbol" when I discovered it.
> 
> 

Ah yeah I can reproduce the bug with --sort, which is fixed by the 
patch. But 's' doesn't actually reload a new histogram for me, I just 
get the original file again. Maybe I'm misunderstanding what 's' is 
supposed to do?

>>> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
>>> Fixes: ec6ae74fe8f0 ("perf report: Display average IPC and IPC coverage per symbol")
>>   > Cc: Namhyung Kim <namhyung@kernel.org>> Cc: Ian Rogers
>> <irogers@google.com>
>>> Cc: linux-perf-users@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>> ---
>>>    tools/perf/builtin-report.c | 30 ++++++++++++++++--------------
>>>    1 file changed, 16 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
>>> index 048c91960ba91..42d7dfdf07d9b 100644
>>> --- a/tools/perf/builtin-report.c
>>> +++ b/tools/perf/builtin-report.c
>>> @@ -1721,22 +1721,24 @@ int cmd_report(int argc, const char **argv)
>>>                symbol_conf.annotate_data_sample = true;
>>>        }
>>>
>>> -     if (sort_order && strstr(sort_order, "ipc")) {
>>> -             parse_options_usage(report_usage, options, "s", 1);
>>> -             goto error;
>>> -     }
>>> -
>>> -     if (sort_order && strstr(sort_order, "symbol")) {
>>> -             if (sort__mode == SORT_MODE__BRANCH) {
>>> -                     snprintf(sort_tmp, sizeof(sort_tmp), "%s,%s",
>>> -                              sort_order, "ipc_lbr");
>>> -                     report.symbol_ipc = true;
>>> -             } else {
>>> -                     snprintf(sort_tmp, sizeof(sort_tmp), "%s,%s",
>>> -                              sort_order, "ipc_null");
>>> +     if (last_key != K_SWITCH_INPUT_DATA) {
>>> +             if (sort_order && strstr(sort_order, "ipc")) {
>>> +                     parse_options_usage(report_usage, options, "s", 1);
>>> +                     goto error;
>>>                }
>>>
>>> -             sort_order = sort_tmp;
>>> +             if (sort_order && strstr(sort_order, "symbol")) {
>>> +                     if (sort__mode == SORT_MODE__BRANCH) {
>>> +                             snprintf(sort_tmp, sizeof(sort_tmp), "%s,%s",
>>> +                                      sort_order, "ipc_lbr");
>>> +                             report.symbol_ipc = true;
>>> +                     } else {
>>> +                             snprintf(sort_tmp, sizeof(sort_tmp), "%s,%s",
>>> +                                      sort_order, "ipc_null");
>>> +                     }
>>> +
>>> +                     sort_order = sort_tmp;
>>> +             }
>>>        }
>>>
>>>        if ((last_key != K_SWITCH_INPUT_DATA && last_key != K_RELOAD) &&
>>>
>>> base-commit: 09a0fa92e5b45e99cf435b2fbf5ebcf889cf8780
>>

