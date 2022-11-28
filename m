Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DF3C43217
	for <linux-perf-users@archiver.kernel.org>; Mon, 28 Nov 2022 11:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiK1LC7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 28 Nov 2022 06:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiK1LC6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 28 Nov 2022 06:02:58 -0500
Received: from mail.bsc.es (mao.bsc.es [84.88.52.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9046B178A0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Nov 2022 03:02:56 -0800 (PST)
Received: from [84.88.51.51] (bsccs560.int.bsc.es [84.88.51.51])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.bsc.es (Postfix) with ESMTPSA id 5C0A74061462;
        Mon, 28 Nov 2022 12:02:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsc.es; s=20191012;
        t=1669633374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MucTL+Z/CHw940Bszu5S6YOHg2Ib4ySFM0fZ+QXulIQ=;
        b=m1vCgrWKbH5+Q30xaFkUmbdWTPyVe86znJX7kgpKtiW4Vi3Ua8RVuPzNO+eUMigLT2YMfO
        bYsxHr2droizLMWanPSWRogbIz91hSxDIfIsl//5y1Mn2TsdRYaBQQobU4uluoxG56hrIT
        CJREvOK/YUw2eqOxsmC/Xael/rdA87vulITwlVqEnQsL87N/eB58OS3p7jJqdwU8J5WGNi
        FPqjxWo33cSvLqYxgeqTA9z3CQ33dcuObmsUtq3S1zQuhI8Yb6uaGYAoO2G6Eq9LC1HY+F
        58LrCdkqHx6BvLulRsk7VqWj3Lfcg3Y8Gi5tJ3rq7e08l0kb/KNHWDyKMMEbEQ==
Message-ID: <01b0d585-9de3-d1f1-727b-b2a69daa20f4@bsc.es>
Date:   Mon, 28 Nov 2022 12:02:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: Available Arm CPUs with SPE
Content-Language: en-US
To:     Al Grant <Al.Grant@arm.com>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        James Clark <James.Clark@arm.com>
Cc:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
References: <2695ecbe-816e-eab7-8da2-30e0f62ae926@bsc.es>
 <Y4C0RkbpGP4KX36C@leoy-yangtze.lan>
 <DB9PR08MB75125CC4EBA5F21EE3B5D33D860E9@DB9PR08MB7512.eurprd08.prod.outlook.com>
From:   Marc Jorda <marc.jorda@bsc.es>
In-Reply-To: <DB9PR08MB75125CC4EBA5F21EE3B5D33D860E9@DB9PR08MB7512.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Copyrighted-Material: Please visit http://www.bsc.es/disclaimer
X-Rspamd-Server: opsmail02.bsc.es
X-Rspamd-Queue-Id: 5C0A74061462
X-Spamd-Result: default: False [-13.10 / 15.00];
         ARC_NA(0.00)[];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[4];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[bsc.es:s=20191012];
         NEURAL_HAM(-0.00)[-1.000];
         WHITELIST_SENDER_DOMAIN(-9.00)[bsc.es];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:13041, ipnet:84.88.0.0/16, country:ES];
         MID_RHS_MATCH_FROM(0.00)[];
         BAYES_HAM(-4.00)[100.00%]
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


On 25/11/22 22:06, Al Grant wrote:
> Leo Yan wrote:
>> On Fri, Nov 25, 2022 at 12:17:18PM +0100, Marc Jorda wrote:
>>> Hello,
>>>
>>> I am trying to know which currently available Arm CPUs implement the
>>> Statistical Profiling Extension (SPE), does anyone know where can I
>>> find such information?
>> I don't know we have such kind of info, usually the most safe way is to check
>> SoC vendor's spec and confirm if Arm SPE is supported or not.
>>
>>> As far as I know, it is an optional extension in Armv8.2, but I don't
>>> know if it is mandatory for newer versions. Is it correct to assume
>>> that all Arm Neoverse CPUs have this extension?
>> Yes, since SPE is an optional extension, my understanding is we cannot 100% say
>> SPE is implemented in Armv8.2 and upwards CPUs (though it's unlikely not to
>> implement SPE in Arm standard CPUs).
>>
>> To avoid to mislead you, I would like loop in James and Al for more reliable
>> answer.
> Generally SPE has gone into the server cores but not the mobile cores,
> partly for power/area reasons. Neoverse N1 has SPE, but Cortex-A76,
> which is the same v8.2 architecture and a similar microarchitecture but
> optimized for mobile, does not have SPE. It's not entirely a Neoverse
> vs. Cortex thing though. You can use the PMU event repo to get a list,
> since all CPUs with SPE, and only those, will implement SAMPLE_POP:
>
> $ git clone https://ARM-software/data
> $ grep SAMPLE_POP data/pmu/*
> data/pmu/common_armv8.json:            "name": "SAMPLE_POP",
> data/pmu/common_armv9.json:            "name": "SAMPLE_POP",
> data/pmu/cortex-a715.json:            "name": "SAMPLE_POP",
> data/pmu/cortex-x3.json:            "name": "SAMPLE_POP",
> data/pmu/neoverse-n1.json:            "name": "SAMPLE_POP",
> data/pmu/neoverse-n2.json:            "name": "SAMPLE_POP",
> data/pmu/neoverse-v1.json:            "name": "SAMPLE_POP",
> data/pmu/neoverse-v2.json:            "name": "SAMPLE_POP",
>
> That is believed to be up to date and correct, but to be absolutely sure
> you would need to check the documentation for each core. Third-party
> implementations may also feature SPE, again you would need to check
> documentation. (We'd be happy to include additional PMU event JSON in
> the repo.)
>
> Also, keep in mind that even if SPE is on the CPU, some action is needed
> from firmware, hypervisor OS etc. to make it available to the end user.
> It might or might not be available to a guest OS for example.
>
> Al

Ok, thank you all for the tips, I will check these references.

Regards,
Marc

>
>> Thanks,
>> Leo
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

-- 
Accelerators and Communications for HPC
Computer Sciences Department
Barcelona Supercomputing Center (BSC)

