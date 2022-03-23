Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE574C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Mar 2022 15:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245205AbiCWPqk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Mar 2022 11:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245202AbiCWPqj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Mar 2022 11:46:39 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DA54A3E2
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Mar 2022 08:45:09 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id t5so1795862pfg.4
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Mar 2022 08:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1vTW3PCwU+T2pUtBqAx/4fRcqe+IVyWi5wPimWqOIX8=;
        b=3hKXikPCM3UOeO1Tu9SgwrBM+ohjgXXLurHTCVrXZsVqaucksaMLNgQZ9Tq/4sWWe4
         0iyOGqHTvUKFtGKg7QVaRIt+L8Log/adQ76trUIbWgcNA22CfgZdRWZj/eXkvw9YIEqi
         MAV/x58FHuu4NdSV4GmavtJtbYx7DpSxSnXkbAk5nXLffxrwbXD5Vtg7NjWXqnpRr/lh
         mj0KSGR1pdkgzJk3bBufqguGRKZEfscPXcUQHBmUPIN78U3r++JfxfijLHE1A24u5044
         3BicnWwdm4OnRIijyf0tXa/aZE6s7oHEeauTevfqutItALhYt7XM3rFCyJWjTZ1/WzzB
         /NMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1vTW3PCwU+T2pUtBqAx/4fRcqe+IVyWi5wPimWqOIX8=;
        b=yfZbtLDSv2EmNRyZbSJXJNYLX5Cm73jIJ8Slw8dJOE5VStVVHFK54Qqxn9NYDnqrsT
         evI4bS4FM5I9aeVJ3j3gW4uBcja6f6tnNcvaJ/1VtXsAHweDMomea2x9Ikh3Yi00/k8l
         leqNBedTPFXktoI2swnPUcGS/GiBmDZytuiKLdgML0HrUhTSI3I6E/eLGbt5gnxVcT3N
         TtOHbsL+kp69JuHyJToVC9U/FC5DDZMmsaVNkOO7QV18p7Ben+gWx31HqT4wD/tYNyxx
         p+H1Zf5hkP7TTMixoUFJ5ELPhb8NkWLeapQYEieCeT7MIuCYzY1qqkKqOHNk4L60ooE0
         xOnQ==
X-Gm-Message-State: AOAM533K7RC4iCh7bMVNtdYADFdNhSBvoRH1PCMl9rrN8x90P7ZzPc0m
        kFAw6UyLIwXIS0wgN6xkCwzUBA==
X-Google-Smtp-Source: ABdhPJyK0hPmqqzUM4OyZvHvejQRLOjBiBHz8HKHMyDfEP0z3oqLOwqgYAGNZo6s6nMCNoXpDj/z/A==
X-Received: by 2002:a05:6a00:4107:b0:4fa:ac90:f299 with SMTP id bu7-20020a056a00410700b004faac90f299mr584289pfb.58.1648050309228;
        Wed, 23 Mar 2022 08:45:09 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e62:3990:257e:c5d2:cab0:ca98? ([2409:8a28:e62:3990:257e:c5d2:cab0:ca98])
        by smtp.gmail.com with ESMTPSA id l2-20020a637c42000000b003644cfa0dd1sm185069pgn.79.2022.03.23.08.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 08:45:08 -0700 (PDT)
Message-ID: <cb2e81ac-a106-3162-7d93-936eb051e241@bytedance.com>
Date:   Wed, 23 Mar 2022 23:44:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [External] Re: [PATCH v2 2/6] perf/core: Introduce percpu
 perf_cgroup
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
References: <20220322120834.98637-1-zhouchengming@bytedance.com>
 <20220322120834.98637-3-zhouchengming@bytedance.com>
 <20220323125116.GX8939@worktop.programming.kicks-ass.net>
 <f6a46509-a373-5c7a-8694-8eaf0ebc69ab@bytedance.com>
 <20220323131744.GY8939@worktop.programming.kicks-ass.net>
 <c4fea458-b0e1-9842-91ea-5a1c6f7e8387@bytedance.com>
 <YjspMR6gJ5AWjE8Q@hirez.programming.kicks-ass.net>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <YjspMR6gJ5AWjE8Q@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 2022/3/23 10:05 下午, Peter Zijlstra wrote:
> On Wed, Mar 23, 2022 at 09:37:16PM +0800, Chengming Zhou wrote:
> 
>> But you are right, having cpuctx->cgrp and cpu_perf_cgroup make things confused..
>> maybe we can delete cpuctx->cgrp, change to use percpu cpu_perf_cgroup?
> 
> I'm hoping to soon (*finally*!) have some time for this again:
> 
>   https://lkml.kernel.org/r/20220113134743.1292-1-ravi.bangoria@amd.com
> 
> That should get us a single cpuctx.

I just seen the patch description, the new design is clearer than
the current code. But it may take a long time to upstream and test
since it changed the whole design and so much code.

Anyway, I will reorganize this patchset, fix reviewed bugs, improve
the commit message and send next version for review.

Thanks.
