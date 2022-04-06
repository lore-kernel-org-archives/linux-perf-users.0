Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F7EC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Apr 2022 21:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbiDFVSM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Apr 2022 17:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236338AbiDFVRu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Apr 2022 17:17:50 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AB72EF86F
        for <linux-perf-users@vger.kernel.org>; Wed,  6 Apr 2022 13:05:47 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id k25so4313412iok.8
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Apr 2022 13:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vCgsdofueDzmclBeFxqo6aKHtjsWdXLi6JiPYoFCmoc=;
        b=cR+5rsgYLkhZXAAFxLpza6qfB2xOzcJNUAIYelWplokZAKThWScNamgWLpMmkHBhgA
         R1+F1qKd7EG/GEu8cxmj1P80ibmXO1V5w96lKod+E60ujDAa/xCZ0xLxp4Nsp/y1+zNj
         pGI4QVenIIYqNlvjtSBl1t5pMtIx0NmwB3jyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vCgsdofueDzmclBeFxqo6aKHtjsWdXLi6JiPYoFCmoc=;
        b=yQ3CzpZcL1cxO4al4zu/JVPJBydGwn+PJtuvWjqiDkxOc+rRnvtrltRs4BsdXgRr6c
         zV1L8U+sSn50LJuRcOia32Iu5c99O/uaOE2EhRj7zmzi4JV74+ctDabaXRA0pVK8+CRv
         Sus91sHst658iAHhIVZK+tHy0fHzUWkPUoampn6tUmq5ePbI5ijtr9eg3xqejSPw8Dra
         NjZh5JUtu8GUpkZlyTqJsshPTPZMNX41XRFT7ITtg/3fz26oQdty+MWbJA2mwP3Of9hq
         LcOIxAuFlafoEs6WnD4T9d5CmD5RTrKoaM7AvTES6Hwh2odetZAqMc93yo0MgkD0t414
         90NA==
X-Gm-Message-State: AOAM5313kQz2tMx3O7rkvcVBT7rh1YnSSFh/NtXXLSyUMXSx3JW4kFXn
        ht/BD04ShGebR3NzyjIE3CsiAg==
X-Google-Smtp-Source: ABdhPJwZyiBF+1MJR1ViEYkDA/OLIZOqcFI6CqmqutLKLEchEzixjki5nX6+7D+OjxHw9lBwnsyheA==
X-Received: by 2002:a05:6638:41a0:b0:323:d771:8146 with SMTP id az32-20020a05663841a000b00323d7718146mr5494354jab.193.1649275547223;
        Wed, 06 Apr 2022 13:05:47 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id d14-20020a056602184e00b00649673c175asm11534641ioi.25.2022.04.06.13.05.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 13:05:46 -0700 (PDT)
Subject: Re: [PATCH] testing/selftests/mqueue: Fix mq_perf_tests to free the
 allocated cpu set
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, disgoel@linux.vnet.ibm.com
Cc:     acme@kernel.org, jolsa@kernel.org, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, maddy@linux.vnet.ibm.com,
        kjain@linux.ibm.com, srikar@linux.vnet.ibm.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220406175715.87937-1-atrajeev@linux.vnet.ibm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ad0648a9-0252-2d1f-cc48-7e14846fc0af@linuxfoundation.org>
Date:   Wed, 6 Apr 2022 14:05:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220406175715.87937-1-atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 4/6/22 11:57 AM, Athira Rajeev wrote:
> The selftest "mqueue/mq_perf_tests.c" use CPU_ALLOC to allocate
> CPU set. This cpu set is used further in pthread_attr_setaffinity_np
> and by pthread_create in the code. But in current code, allocated
> cpu set is not freed. Fix this by adding CPU_FREE after its usage
> is done.
> 

Good find.

> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>   tools/testing/selftests/mqueue/mq_perf_tests.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/mqueue/mq_perf_tests.c b/tools/testing/selftests/mqueue/mq_perf_tests.c
> index b019e0b8221c..17c41f216bef 100644
> --- a/tools/testing/selftests/mqueue/mq_perf_tests.c
> +++ b/tools/testing/selftests/mqueue/mq_perf_tests.c
> @@ -732,6 +732,7 @@ int main(int argc, char *argv[])
>   		pthread_attr_destroy(&thread_attr);
>   	}
>   
> +	CPU_FREE(cpu_set);
>   	if (!continuous_mode) {
>   		pthread_join(cpu_threads[0], &retval);
>   		shutdown((long)retval, "perf_test_thread()", __LINE__);
> 

CPU_ALLOC() is called very early on in main() and there are a
few error paths that exit without calling CPU_FREE. This change
doesn't fully fix the problem.

Review the other exit paths where CPU_FREE is needed.

thanks,
-- Shuah
