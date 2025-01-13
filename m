Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51231240223
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736781594; cv=none; b=XUvGm0NE3pRJe5uUzVseL/uSdZVUqBP9eakCTytUHGbiMvFY+htDbbgTFSCUeiT+ycY61zPLCtlTZo26VT+1S0O2Cb0/QsJlfmDuPy/Ke/2fAm887XMQyzvuTPw6Gs1s6zQok8FyU4z7qB1FQTqgHKdZ4VEd4Dt0DMqCRxW+3GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736781594; c=relaxed/simple;
	bh=wpBUo0e7dn7YAhx9HXJYJyFpbI2TZVFrNf0vcogHcPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CU76SjIM5jsjYFjDdjCbqSzv/gE/H6lkFSb7doUhWmJaAa7S0Ze0O8zr5zCVpEO7in9lPxz0x/FpeYA/72TvNDJi76VaiI0u6mPbWz3cr1tJ+ipLp+tpEVpkP7uVe41ox5Fcrj48t1jG8BzkpCqP87Gt4FryrFddykroQsqIBE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wGSe7rEQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wGSe7rEQ"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4362f61757fso42407645e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 07:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736781590; x=1737386390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cVenH7nswJordeMtcUBKf5eyxS1L8wsCNNzck2rItTQ=;
        b=wGSe7rEQH1yVBxUIQlIlv9RYeOpOFupoL8UvUZVl03wtguRdw7fmwFSGlzNli+s0dw
         TVmBb/GzCpj+Gc+dCus3enal/4fot01JeRfnNojH7KuMv9oQQ9geC2Qv3gqCehufbZ1P
         7lbb3Vr+RfjH7e2ouBljkTxWaN2NknyFdG54ZJQW+7CKLrLvfHoyIxnvPTWsjhNT6rGD
         leDQVhHZWwKQKZUDnaN0E93dFJARpKg6n97CH+GgsrlnK5ne1i/vaxtIRg11CmXt2oBC
         49021AEPbBNDJSCoTNw+77TMsQcM+i9cGA5TtYuYXdsfOK2jhDoA4KJ0U795oaWbYYfa
         gBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736781590; x=1737386390;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cVenH7nswJordeMtcUBKf5eyxS1L8wsCNNzck2rItTQ=;
        b=pQHoezrtHwlYKC+8vd0X8VtRIXWbloWN4+BprZeFOItCThmegLlV3ESOk+GrpI1sGs
         IWkYeKxoI0VTMWxLIkm9CpbxNHHzadVsz6Pgh5eqi18nofns95tM/QkOJ3BSTqBYvwHP
         GnAgFwAptbHd5Y3N5bMcnB6ZAaT5JTdC3Hkhkx1IYZ13d2RnkL131WkXqLORizwySzu4
         uIR0KxnxPQ62gq5x4nWov12pcHsnDQtLKNnvVOV18QKUWOJzbKK6qnN5RFNAXNl648hx
         RqLTP2s/v5JkuwYW+foCyPrZ78QhMq4GmPA1QG/MNGPoqRkMMnA+bl//6KvOYz9CGXZg
         zCFg==
X-Gm-Message-State: AOJu0Yz5E0IxRsTZK2SR/OpT5+MD8T8iMKMTIyOK7mce8/cwAvhMiHZS
	YRAihYINRX/zEOuwsNkCwbNzFJByVer2KiB6PunDZAlXh5B08IshIIAVCzimDBg=
X-Gm-Gg: ASbGncs+huJso9KOLrWLh/KCd0Ck5P+4ovCkESADqGROzwQyREAvSj/sjYkUNp06PZN
	tY9d6HCbTU9xuEJ7nEwww+mLwo3fzYaVb0R/5/2Ln4awfZNqLALIITSuZYUBvTIGWnbHECGzZxD
	h1cGaCvCAi6fw8M0NTqbs9IPakHhua8Iq+VD+1q4pLQZ8e01upWFIS0HriouE+JN8vi/skDdQ/k
	r8Rf1VVzqHP/nvRVHghcl1ciaO/XH08toMNtW0XA/a6GxZqZ/HIjJhNb88Nwb8dqMOK
X-Google-Smtp-Source: AGHT+IHYO6rBWxot0WjCrgOIXoLf7Hb6Vaz9FC4ZRGTO+KwdByGhDjWfQU1esAzSwfVJV0nnQldhIg==
X-Received: by 2002:a05:600c:5246:b0:434:feb1:adbb with SMTP id 5b1f17b1804b1-436e271d5d6mr196307345e9.31.1736781590527;
        Mon, 13 Jan 2025 07:19:50 -0800 (PST)
Received: from [192.168.68.163] ([212.105.145.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6401sm182484945e9.2.2025.01.13.07.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 07:19:49 -0800 (PST)
Message-ID: <20d97acb-bcf8-481e-a898-a13580c566b0@linaro.org>
Date: Mon, 13 Jan 2025 15:19:49 +0000
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
 <89e678bc-f0af-4929-a8a6-a2666f1294a4@linaro.org>
 <CACT4Y+ayg0oo0sX54DuJ9n+L4MJJU5LsEJtEDS13Zu7ifOyq3g@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CACT4Y+ayg0oo0sX54DuJ9n+L4MJJU5LsEJtEDS13Zu7ifOyq3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/01/2025 12:19 pm, Dmitry Vyukov wrote:
> On Thu, 9 Jan 2025 at 15:50, James Clark <james.clark@linaro.org> wrote:
>> On 08/01/2025 3:35 pm, Dmitry Vyukov wrote:
>>> On Wed, 8 Jan 2025 at 16:23, James Clark <james.clark@linaro.org> wrote:
>>>>
>>>> On 08/01/2025 6:36 am, Dmitry Vyukov wrote:
>>>>> Currently the code checks that there is no "ipc" in the sort order
>>>>> and add an ipc string. This will always error out on the second pass
>>>>> after input reload/switch, since the sort order already contains "ipc".
>>>>> Do the ipc check/fixup only on the first pass.
>>>>>
>>>>
>>>> Hi Dmitry,
>>>>
>>>> A reproducer with before and after behavior might be helpful for the review.
>>>>
>>>> It might be unrelated to your change here, but the input switch thing
>>>> didn't seem to do anything for me. If I record two files, open the first
>>>> one, press S and select the second file nothing seems to change. I
>>>> assumed it would show the other file but nothing changes?
>>>>
>>>>     $ perf record -- true
>>>>     $ perf record -o 2.data -- ls
>>>>     $ perf report
>>>>     S key
>>>>     load 2.data
>>>
>>> Yes, sure. This needs "--sort symbol":
>>>
>>> perf report --sort symbol
>>>
>>> then press 's', select file, and it terminates.
>>>
>>> Affects fewer cases then I initially assumed, since I happened to run
>>> with "--sort symbol" when I discovered it.
>>>
>>>
>>
>> Ah yeah I can reproduce the bug with --sort, which is fixed by the
>> patch. But 's' doesn't actually reload a new histogram for me, I just
>> get the original file again. Maybe I'm misunderstanding what 's' is
>> supposed to do?
> 
> As far as I understand, 's' allows you to select and load a new
> profile w/o existing (fwiw, if you select a different file). If the

By 'without existing' do you mean running perf report with no perf.data 
file? It won't run like that it just says "failed to open perf.data"

> file has changed, I guess you can also reload it and see the changes.
> 

I wasn't able to make that work. How do you reload? If I change screen 
between different events I still get the old file and I didn't see 
'reload' mentioned in the keybinding popup.

I suppose my point is maybe it's not worth fixing the sort order bug if 
we can just remove input file switching. The behavior doesn't seem any 
different to v5.8 in case its a regression. Maybe I'm just doing 
something wrong though.

> 
>>>>> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
>>>>> Fixes: ec6ae74fe8f0 ("perf report: Display average IPC and IPC coverage per symbol")
>>>>    > Cc: Namhyung Kim <namhyung@kernel.org>> Cc: Ian Rogers
>>>> <irogers@google.com>
>>>>> Cc: linux-perf-users@vger.kernel.org
>>>>> Cc: linux-kernel@vger.kernel.org
>>>>> ---
>>>>>     tools/perf/builtin-report.c | 30 ++++++++++++++++--------------
>>>>>     1 file changed, 16 insertions(+), 14 deletions(-)
>>>>>
>>>>> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
>>>>> index 048c91960ba91..42d7dfdf07d9b 100644
>>>>> --- a/tools/perf/builtin-report.c
>>>>> +++ b/tools/perf/builtin-report.c
>>>>> @@ -1721,22 +1721,24 @@ int cmd_report(int argc, const char **argv)
>>>>>                 symbol_conf.annotate_data_sample = true;
>>>>>         }
>>>>>
>>>>> -     if (sort_order && strstr(sort_order, "ipc")) {
>>>>> -             parse_options_usage(report_usage, options, "s", 1);
>>>>> -             goto error;
>>>>> -     }
>>>>> -
>>>>> -     if (sort_order && strstr(sort_order, "symbol")) {
>>>>> -             if (sort__mode == SORT_MODE__BRANCH) {
>>>>> -                     snprintf(sort_tmp, sizeof(sort_tmp), "%s,%s",
>>>>> -                              sort_order, "ipc_lbr");
>>>>> -                     report.symbol_ipc = true;
>>>>> -             } else {
>>>>> -                     snprintf(sort_tmp, sizeof(sort_tmp), "%s,%s",
>>>>> -                              sort_order, "ipc_null");
>>>>> +     if (last_key != K_SWITCH_INPUT_DATA) {
>>>>> +             if (sort_order && strstr(sort_order, "ipc")) {
>>>>> +                     parse_options_usage(report_usage, options, "s", 1);
>>>>> +                     goto error;
>>>>>                 }
>>>>>
>>>>> -             sort_order = sort_tmp;
>>>>> +             if (sort_order && strstr(sort_order, "symbol")) {
>>>>> +                     if (sort__mode == SORT_MODE__BRANCH) {
>>>>> +                             snprintf(sort_tmp, sizeof(sort_tmp), "%s,%s",
>>>>> +                                      sort_order, "ipc_lbr");
>>>>> +                             report.symbol_ipc = true;
>>>>> +                     } else {
>>>>> +                             snprintf(sort_tmp, sizeof(sort_tmp), "%s,%s",
>>>>> +                                      sort_order, "ipc_null");
>>>>> +                     }
>>>>> +
>>>>> +                     sort_order = sort_tmp;
>>>>> +             }
>>>>>         }
>>>>>
>>>>>         if ((last_key != K_SWITCH_INPUT_DATA && last_key != K_RELOAD) &&
>>>>>
>>>>> base-commit: 09a0fa92e5b45e99cf435b2fbf5ebcf889cf8780
>>>>
>>

