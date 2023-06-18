Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F50EB64D7
	for <linux-perf-users@archiver.kernel.org>; Sun, 18 Jun 2023 09:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjFRJ2Q (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 18 Jun 2023 05:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFRJ2Q (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 18 Jun 2023 05:28:16 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC7210D2
        for <linux-perf-users@vger.kernel.org>; Sun, 18 Jun 2023 02:28:15 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-77e2f2ad553so49155739f.2
        for <linux-perf-users@vger.kernel.org>; Sun, 18 Jun 2023 02:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687080494; x=1689672494;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EuXqpMyFDJYC4ZJBWArLuhSdut0CoLr8yYbP5MX9A2U=;
        b=urlyPw0IJdY3qyjOy5cg0GyjxRtyHWCOeZFH05Ca3RsIXJS1t2PJp1GOUSLxHrZr+8
         LxtuLAM2mCoZzCgzp1MrPdPwcD7enWhsqmZDi0UnRzaqdFgcaLGwjfyAXJyLQmegKlAG
         nfzIP0+X/JTpKzEsQIUu1FclRtq7yTCE2gk+mfpNNcNuv/NsVJ+ksLDLpweFWL/4pGCj
         Nr+GpmX35tj+lQa8eSO2kYvLtdGuGCKBVDcLwilX6uE8SxYDUK0HUx0Uu0Y3R2bxrovU
         EYTcUWNwtoVYqRzrq6JHXsjV/Ke53saobofmQcndEa2aClIUVcICUND4NzAGS8OZd+9v
         ZozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687080494; x=1689672494;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EuXqpMyFDJYC4ZJBWArLuhSdut0CoLr8yYbP5MX9A2U=;
        b=CbwzfGOAyG56F7c66T6TtotYMYI+yMxiBxKF0CO6G/L0ittp6YxBpp0905/QpLNRY3
         6rR/WO51dgiC8onXdblhdFjyluNkptTzh7Q7tsEhHBk3GjT9rg2rEP3YOnniMpFnMPhL
         ARXxABDyBW+fbXyqSJgF+cPZmb292p4WO0QMiVewCxaz6chgBfjf8BU2FyuWabafYLD2
         3F/rBQUx+m/jTfcdbd+ULTRqTvkEi3R5RZvsGS0mcJUoa/sm8m8FAkjM4zDe5s4yDhV7
         UT7huTSvSk8/Oq72tGOQge3PcgpSrF18dEUNFTKZq8MPGUQDDBGIvC12DkDq13fEbt3C
         PsUQ==
X-Gm-Message-State: AC+VfDxZROoSrZx1GzQMKzb9D/PrMao3lG5mATvIkNzK05hWCEICUXcR
        V4d/8DN1PW+vmgyAtN+loMVOLA==
X-Google-Smtp-Source: ACHHUZ6T+8yfudkOXZ8hVfgZjRUK2IF/GD7A3Cja7Lhrpf21sVPO7/42evqEdiKIlkUUXTvApBetRg==
X-Received: by 2002:a6b:f102:0:b0:763:b459:a701 with SMTP id e2-20020a6bf102000000b00763b459a701mr6417433iog.1.1687080494364;
        Sun, 18 Jun 2023 02:28:14 -0700 (PDT)
Received: from leoy-huanghe.lan ([107.151.177.132])
        by smtp.gmail.com with ESMTPSA id s2-20020aa78282000000b0065017055caasm15926482pfm.210.2023.06.18.02.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 02:28:13 -0700 (PDT)
Date:   Sun, 18 Jun 2023 17:28:06 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     =?utf-8?B?6JSh5rKF5L+h?= <fissure2010@gmail.com>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
Subject: Re: Some questions about using the perf tool in ARM-SPE
Message-ID: <20230618092806.GA245455@leoy-huanghe.lan>
References: <CALDTKqiVNLHM8b21T-zikuNvhfE0N_-kEinpZGSRjSO-04R96w@mail.gmail.com>
 <874963e2-f97e-b463-1351-b00640b0f67b@arm.com>
 <CALDTKqg01+xJ2xu218c_QH2PbX9wdhYOiJfDieCXL5PHWV-6FQ@mail.gmail.com>
 <77773641-26e5-a754-63cf-e7d3443e11fc@arm.com>
 <CALDTKqgek3Bicxkvnq3BQnSaS2keQG6UK8S6_0oJn26r0D00MA@mail.gmail.com>
 <20230614012102.GJ217089@leoy-huanghe.lan>
 <CALDTKqgz6=WFs=bMvnFkKv5kt5OP5wtUqQ2uekVbumCxNqeRXw@mail.gmail.com>
 <CALDTKqiy7h+SiCsUhpgFNzUoYUPdq3e8EpAEbDgcH3ePbGOV3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALDTKqiy7h+SiCsUhpgFNzUoYUPdq3e8EpAEbDgcH3ePbGOV3w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 14, 2023 at 02:08:36PM +0800, 蔡沅信 wrote:
> "Fix mail to text modeFix mail to text mode"
> 
> Hi,
> How do I add NUME nodes (or CPU topology) to the kernel config?

Below configurations are enabled in my testing kernel:

root@leoy-huangpu:/home/leoy# zcat /proc/config.gz | grep NUMA
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_NUMA=y
CONFIG_ACPI_NUMA=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_GENERIC_ARCH_NUMA=y
CONFIG_OF_NUMA=y
CONFIG_DMA_PERNUMA_CMA=y

> After I modified arm-spe.c. Snoop is working but Locked&Blocked&Local
> INSTR Latency their results are always No&N/A&0

I cannot understand this ... What's you have modified for arm-spe.c?

If you don't share more complete perf log then it would be difficult to
understand and locate issue.

> I merged 3 Cluter into one and have been able to record the whole system.
> user_shell:/sys/bus/event_source/devices/arm_spe_0 # cat cpumask
> 0-7

This seems to me fine to me.

> On the c2c side:
> user_shel:/data/local/tmp # ./perf c2c report -vvv
> coalesce sort   fields: offset,iaddr
> coalesce resort fields: offset,tot_peer
> coalesce output fields:
> cl_num_empty,percent_rmt_peer,percent_lcl_peer,percent_stores_l1hit,percent_stores_l1miss,percent_stores_na,offset,offset_node,dcacheline_count,iaddr,mean_rmt_peer,mean_lcl_peer,mean_load,tot_recs,cpucnt,symbol,dso,cl_srcline,node
> Failed setup nodes

Before diving into "perf c2c" tool, please use "perf script" tool to
decode the perf data file and check if you have captured any SPE trace
data, and it's good to dump header info.  This would be useful to
analyze the issie.

$ ./perf script --header -I

> On the other hand, the perf I use is statically compiled with the
> aarch64 cross-compiler. I can't open all the features

This would be fine.  At my side, I built perf statically on x86_64
machine with the command:

$ make LDFLAGS=-static NO_LIBELF=1 NO_JVMTI=1  VF=1 DEBUG=1 NO_LIBTRACEEVENT=1

And then I copied the perf binary on my Arm64 machine, it works pretty
well for Arm SPE.

Thanks,
Leo
