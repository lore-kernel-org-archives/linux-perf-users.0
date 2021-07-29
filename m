Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0920FC4338F
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 13:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D37DA60F00
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 13:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237725AbhG2Nt6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 29 Jul 2021 09:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237759AbhG2Nt4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 29 Jul 2021 09:49:56 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E06C061765;
        Thu, 29 Jul 2021 06:49:51 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id m1so10416837pjv.2;
        Thu, 29 Jul 2021 06:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+t3sniSKOc3BRa9Xn6DUU+HnDxTzlw5NGRXexej3vbQ=;
        b=WyW+3/Qfmu8NRAxgJfsR6dTZsEHx4ozTXiOHkPWMgbdIvK0JqV+sCNm1huZZ7iyK43
         jj1iHlxIc9nYdV5sM2X7h88IYAvKacYg/L/azBRKKCzOqL1XUPmefuSMf9kfjoEHTI6X
         EVL5sdLyAs7Y6m/IqjulcFsHaVGN0wLM51hiPWyhgkYgb1n/iZlPwUYk33NOyiVymNud
         D/gj32jkNb/VDefplk7aBWLuleCrf46xzStOIq/ZApQM6GccLx1aWYO0OzRbupMwhhy3
         aszJMVNGHgz+qdIffJVXBY94REWsBcU70+NwGbPu/gEG6+Z9yl/JFQx0wl1NrhSe4xS2
         JQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+t3sniSKOc3BRa9Xn6DUU+HnDxTzlw5NGRXexej3vbQ=;
        b=NR55MKm1OV0IP2lIchCieT8gH3buBAvWnvHxUqCMSYrFztasGDwlvTGbP49g7GJeyp
         gaD2EIBHwLhREd0CAxusyVxDabpADrUxrGoN2R09WY3ovb3JQQdxCJ6cAsQ+POCMN/Ie
         8rbxypTdjGgYsQnKnKFfXIiYBD5duZ6gXxVPOKUYK3l524d0iEMMCvIx00EaYSyLv5+n
         egHvBCpGVtLVMJNtdD+6GdTUWPAi6HBoPKHuGes5fvY4XypaFffyKKMowzdByj/meXus
         8xfckkIqmwSq+s8qpUD805wi6HTRLf4xBKPGF6kEF2Trp6Fe3nb2HcGcftJzpacrsuh+
         RJtg==
X-Gm-Message-State: AOAM530GiZQGC++ZieW8uSqO5W3MSww1fbNbL4XrXrr810W5buKdEIY6
        r5Rii5R6nrOlquB9vu04v9Y=
X-Google-Smtp-Source: ABdhPJwEt26sYE4kRfr190XgRWgzWdUbj6jn25osbrGUSi+GUHqos/waQFvv3wKaXfO1IUcy/CkpaQ==
X-Received: by 2002:a63:6e83:: with SMTP id j125mr3844782pgc.12.1627566591071;
        Thu, 29 Jul 2021 06:49:51 -0700 (PDT)
Received: from Likes-MacBook-Pro.local ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id gk5sm9942061pjb.51.2021.07.29.06.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 06:49:50 -0700 (PDT)
Subject: Re: [RESEND PATCH] perf/x86/amd: Do not touch the
 AMD64_EVENTSEL_HOSTONLY bit inside the guest
To:     Peter Zijlstra <peterz@infradead.org>,
        Kim Phillips <kim.phillips@amd.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Richter <rrichter@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20210720112605.63286-1-likexu@tencent.com>
 <c49b7e74-5b34-745c-a3dc-55bb2e83474a@amd.com>
From:   Like Xu <like.xu.linux@gmail.com>
Message-ID: <173cb541-fa2e-494c-f1b7-e9894bd4f25b@gmail.com>
Date:   Thu, 29 Jul 2021 21:49:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <c49b7e74-5b34-745c-a3dc-55bb2e83474a@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 24/7/2021 4:16 am, Kim Phillips wrote:
> +Tom L., Robert R.
> 
> On 7/20/21 6:26 AM, Like Xu wrote:
>> From: Like Xu <likexu@tencent.com>
>>
>> If we use "perf record" in an AMD Milan guest, dmesg reports a #GP
>> warning from an unchecked MSR access error on MSR_F15H_PERF_CTLx:
>>
>> [] unchecked MSR access error: WRMSR to 0xc0010200 (tried to write
>> 0x0000020000110076) at rIP: 0xffffffff8106ddb4 
>> (native_write_msr+0x4/0x20)
>> [] Call Trace:
>> []  amd_pmu_disable_event+0x22/0x90
>> []  x86_pmu_stop+0x4c/0xa0
>> []  x86_pmu_del+0x3a/0x140
>>
>> The AMD64_EVENTSEL_HOSTONLY bit is defined and used on the host,
>> while the guest perf driver should avoid such use.
>>
>> Signed-off-by: Like Xu <likexu@tencent.com>
>> ---
> 
> Tested-by: Kim Phillips <kim.phillips@amd.com>

Thanks Kim.

Hi Peter, should I post a new version with the fix tag ?

> 
> If we were to add a Fixes: tag, would this be the right commit?:
> 
> commit 1018faa6cf23b256bf25919ef203cd7c129f06f2
> 
> Author: Joerg Roedel <joerg.roedel@amd.com>
> 
> Date:   Wed Feb 29 14:57:32 2012 +0100
> 
> 
> 
>      perf/x86/kvm: Fix Host-Only/Guest-Only counting with SVM disabled
> 
> 
> Thanks,
> 
> Kim
