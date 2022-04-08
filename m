Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7563FC433FE
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Apr 2022 18:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiDHSdP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 8 Apr 2022 14:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238723AbiDHSca (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Apr 2022 14:32:30 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F152C1834D
        for <linux-perf-users@vger.kernel.org>; Fri,  8 Apr 2022 11:30:25 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id b16so11656162ioz.3
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Apr 2022 11:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8c4w2SqV3Zwtk6hjN9XQDs1ojn8rP0mcUHvQvhzuNaU=;
        b=YpRUx5naQgJOrPJtNsmh78aDsmIIkswFS8lXDrNYheqXIeJEK2ARoLdZkPcn+nfw5T
         oYiFN+5ZvBke8G2w+I4t1ThEG9QAMUoMMfn3SprosOFXtLJQ9uLglI+1t3LYKARK0RE9
         fZFK0+HB8gFFQwUCeNj0/qHoPWD0MoYjgz6Nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8c4w2SqV3Zwtk6hjN9XQDs1ojn8rP0mcUHvQvhzuNaU=;
        b=AJDtlYC0LQfJfTQwI+xYNZw9YXE0HvH65gaWow71556kQjt6oFN04mpu5YUeXCFWiM
         8AeRFAjjCiHBhorNBTz2PFN9WUcIdAm/VLytx+cGuLjhC8WR4l1GEx5P3en5IQ1V+MTc
         EpfB3XsdMZ4Cr0iQS/4DBDg83fJLYvGnuztQw2TT6Y3hKQaY6dA8D43hyQt57UmybVyK
         AOHB64nM1DK07pXlJShR58x4WnRBjRK6ixJu85nYI/MSH5e3S4/fLOWJ0ui1tz8/cJ3s
         3s7UnBqfa8Ta5TGPRz3+YbN6iLDm6dlvFYtigtYhERcuWvaQv/c4QWzntlzMFvoQSkUx
         qB5g==
X-Gm-Message-State: AOAM533tgLUUGubeOrOyDL2QOWp1ML6Xqwg0G3prJ8C+FYUfiSZvQAB1
        zWcGQM9chg6lclNa0uhOn8hcWQ==
X-Google-Smtp-Source: ABdhPJz0knJI2EvKgFMOby7OjCoRi/HEQHXa7piPfbIdw92oEo/ocHWDiLbO7mI1s1H7DgX30ZuY4g==
X-Received: by 2002:a05:6638:2643:b0:323:c3e3:fcec with SMTP id n3-20020a056638264300b00323c3e3fcecmr10003722jat.289.1649442625269;
        Fri, 08 Apr 2022 11:30:25 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id y6-20020a056e02174600b002c7f247b3a7sm14985188ill.54.2022.04.08.11.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 11:30:24 -0700 (PDT)
Subject: Re: [PATCH V3] testing/selftests/mqueue: Fix mq_perf_tests to free
 the allocated cpu set
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, disgoel@linux.vnet.ibm.com
Cc:     acme@kernel.org, jolsa@kernel.org, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, maddy@linux.vnet.ibm.com,
        kjain@linux.ibm.com, srikar@linux.vnet.ibm.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220408072431.94947-1-atrajeev@linux.vnet.ibm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1a1d119a-e68e-a590-a518-cfb3c78ed888@linuxfoundation.org>
Date:   Fri, 8 Apr 2022 12:30:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220408072431.94947-1-atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 4/8/22 1:24 AM, Athira Rajeev wrote:
> The selftest "mqueue/mq_perf_tests.c" use CPU_ALLOC to allocate
> CPU set. This cpu set is used further in pthread_attr_setaffinity_np
> and by pthread_create in the code. But in current code, allocated
> cpu set is not freed.
> 
> Fix this issue by adding CPU_FREE in the "shutdown" function which
> is called in most of the error/exit path for the cleanup. There are
> few error paths which exit without using shutdown. Add a common goto
> error path with CPU_FREE for these cases.
> 
> Fixes: 7820b0715b6f ("tools/selftests: add mq_perf_tests")
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
> Changelog:
>   From v2 -> v3:
>    Addressed review comment from Shuah Khan to add
>    common "goto" error path with CPU_FREE for few exit
>    cases.
>   From v1 -> v2:
>    Addressed review comment from Shuah Khan to add
>    CPU_FREE in other exit paths where it is needed
> 

Thank you. I will queue this up for Linux 5.18-rc3

thanks,
-- Shuah
