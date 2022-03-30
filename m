Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8996AC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 30 Mar 2022 14:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346961AbiC3Oh5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 30 Mar 2022 10:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346950AbiC3Ohy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 30 Mar 2022 10:37:54 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140F041FB4
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Mar 2022 07:36:07 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id c10so23535703ejs.13
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Mar 2022 07:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mZKE0EPCBwY/E3JJQqpe71EQkJdNuH5EijWeXNvdI8U=;
        b=mZCAGfvV+XQfRPSI/PMRRBEqKpC4OXoT10QKeGkmb3S7h5fuyr162N5YyJMXpGx/1w
         2w9YsQAF+L6O20U/n23T1aOGVtmGc37h7EWmMKQ4qo/rWqoVHieSL5ythR2kLVrxIK5f
         thayEWEbVPlDmAokSeCh3BhMOsUxFgAptEhrMfbvggkn1uOQATKokHdaY35px9YVg+fi
         og6wSdKx2/m+AxHplCPc1jH784Rk9vhEMvFYZPfdlcjYt+tazmh5lGpweI5emG7SR2RJ
         Eh41o8NRRcqJ5TlpAR46wUnAnSr0lHrz+gSoAZR3tCKF4Q7NQNYftRsvy/7uNzdihV62
         /U0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mZKE0EPCBwY/E3JJQqpe71EQkJdNuH5EijWeXNvdI8U=;
        b=xvu45lJORrPmLTbSifXrXnOm60YbUQJdx9eqtXYiinUGsFueTfcUpG7zh9WOK547rZ
         z3ISdLJQsc1iDvEEi+OSzMFxl+ee0vgtYY3rY1bBCcTap7xgMsOphyAR6OR4GbCCmqsn
         aNJmIZs+XVDTVp7UVrNFEFnh8VyoVZ7jhSXE6C00yKt1MARRzCJRU6NNb6H+bCYtTL9B
         UaJ6c1Y/IMx6VK7S4+Gm2A9TMod7L3GThqoxkI90TW5pqUQk3ePsVmh4SfXV4W3doM25
         svf2UVDT3hvELxuSxhnbh3CBdZiHOaKrzcXU2NgPM+MIqyH50VorDCyCrFIXCr1HlJmE
         Ldig==
X-Gm-Message-State: AOAM530q9XnkebUcWuJvAuKFRUE3yXP+cZcNzR/yw/VVLxDhH3YEZ9Sn
        XaJbn9IvZS2E32T/HVWyiDN4dQ==
X-Google-Smtp-Source: ABdhPJwdWG8sBJyr3JqFQBHPHzbJlGmU8Tf0ULSmR/KGw5gR8AYBM9fQ7HGHozDkp2SU4in4HQqDpA==
X-Received: by 2002:a17:907:6d2a:b0:6df:e513:5410 with SMTP id sa42-20020a1709076d2a00b006dfe5135410mr39194588ejc.544.1648650966162;
        Wed, 30 Mar 2022 07:36:06 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id w2-20020a50d982000000b00410dc0889b9sm10006826edj.63.2022.03.30.07.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 07:36:05 -0700 (PDT)
Message-ID: <caed045b-4286-3663-0e71-8a0f5f7f0bc6@tessares.net>
Date:   Wed, 30 Mar 2022 16:36:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] perf tools: Stop depending on .git files for building
 PERF-VERSION-FILE
Content-Language: en-GB
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     John Garry <john.garry@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1648635774-14581-1-git-send-email-john.garry@huawei.com>
 <3a72702f-6cf9-2b6e-0f9c-bf6857ab7ed2@tessares.net>
 <YkRlZhaEgmJ5Q4k/@kernel.org>
 <634d9682-dc78-e09a-865c-9eed28aee667@tessares.net>
 <YkRo/PtIf9aOqpZV@kernel.org> <YkRpcW4PkVH59axm@kernel.org>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <YkRpcW4PkVH59axm@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 30/03/2022 16:30, Arnaldo Carvalho de Melo wrote:
> Em Wed, Mar 30, 2022 at 11:28:12AM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Wed, Mar 30, 2022 at 04:22:35PM +0200, Matthieu Baerts escreveu:
>>> On 30/03/2022 16:12, Arnaldo Carvalho de Melo wrote:
>>>>> Thank you for your patch, I just tested it and it also fixes the issue I
>>>>> reported!
> 
>>>> I'm taking this as a:
> 
>>>> Tested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
>>>> Ok?
> 
>>> Yes, OK for me, thank you!
> 
>>> I never know what maintainers prefer when there is already a
>>> "Reported-by" tag so I didn't specify it but I will do next time.
> 
>> Right, I'll stick both R-by and T-by.
> 
>> There are cases where people just report and don't test, or just ack.
> 
> But when you actually provide the:
> 
> Tested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
> It makes the lives of maintainers using b4 easier, as it'll collect
> those.

I agree it is clearer having both tags.
On my side, some people are often asking not to their name in multiple
tags but instead combining tags, e.g. Reported-and-tested-by. But
Patchwork doesn't like that and I have to add the tag manually when
applying the patch. I guess many tools don't like these combined tags!

Anyway, next time I add it and let the maintainer drop / modify it if
they prefer :)

> About b4: https://people.kernel.org/monsieuricon/introducing-b4-and-patch-attestation

Excellent and very useful tool, I agree :-)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
