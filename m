Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCB9C04A6A
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Aug 2023 03:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjHBDtf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Aug 2023 23:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjHBDte (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Aug 2023 23:49:34 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B211BC3;
        Tue,  1 Aug 2023 20:49:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VotPUuX_1690948167;
Received: from 30.221.150.97(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VotPUuX_1690948167)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 11:49:28 +0800
Message-ID: <2883fc41-1f33-c2c7-ef7e-1e69dc57dc41@linux.alibaba.com>
Date:   Wed, 2 Aug 2023 11:49:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v5 3/5] perf test: Add pmu-event test for "Compat" and new
 event_field.
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
References: <1690525040-77423-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1690525040-77423-4-git-send-email-renyu.zj@linux.alibaba.com>
 <abeaafbe-2290-d272-ddd1-f358f7271edc@oracle.com>
 <2dc21269-2fa0-ea39-454d-5f12a414bc13@linux.alibaba.com>
 <bbf54737-ed49-5be8-722d-85906c803410@oracle.com>
 <f863dcf3-d7a5-48f6-a07c-94f6f709c238@linux.alibaba.com>
 <5d69fa17-bf8c-cabe-3417-8bbd11c48b40@oracle.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <5d69fa17-bf8c-cabe-3417-8bbd11c48b40@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



在 2023/8/1 下午11:10, John Garry 写道:
> On 01/08/2023 10:19, Jing Zhang wrote:
>>>> I need to double check because I was testing against 6.3-rc2.
>>> That 6.3-rc2, was for the the kernel? Or baseline for this series? See see maintainers for git/branch to base perf tool dev on.
>>>
>> I have now developed based on the latest perf tool, but I'm still confused.
>> "matching_pmu" does not seem to have any effect. No matter what value matching_pmu
>> is, it will not affect the final test result.
> 
> Yeah, that is what I was saying - matching_pmu is not used. Can you fix that up (to be used), please?
> 

Ok, let me try :)

Thanks,
Jing
