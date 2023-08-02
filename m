Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB318C001DF
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Aug 2023 09:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbjHBJrh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 2 Aug 2023 05:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbjHBJrf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 2 Aug 2023 05:47:35 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AA71FFA;
        Wed,  2 Aug 2023 02:47:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VouZ2.I_1690969648;
Received: from 30.221.150.97(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VouZ2.I_1690969648)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 17:47:29 +0800
Message-ID: <eecbdc2a-09b3-78bd-9588-ed395190eb39@linux.alibaba.com>
Date:   Wed, 2 Aug 2023 17:47:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v5 1/5] perf metric: Event "Compat" value supports
 matching multiple identifiers
To:     John Garry <john.g.garry@oracle.com>
Cc:     Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
References: <1690525040-77423-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1690525040-77423-2-git-send-email-renyu.zj@linux.alibaba.com>
 <268b3891-be4b-5f63-eff3-7b6d83e906e9@oracle.com>
 <0801b73c-6649-8c54-8dca-276efc2a4967@linux.alibaba.com>
 <8e207c71-5400-5427-ae83-a1e0b8f95e31@linux.alibaba.com>
 <b471c336-92dc-af42-dfd2-62831fd6dd60@oracle.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <b471c336-92dc-af42-dfd2-62831fd6dd60@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



在 2023/8/2 下午5:43, John Garry 写道:
> On 02/08/2023 10:38, Jing Zhang wrote:
>>>>> n;
>>>>> +
>>>>> +    str = strdup(compat);
>>>> why duplicate this? are you modifying something?
>>>>
>>> This is really a redundant step, I will remove it.
>>>
>> Hi John,
>>
>> I reviewed this code again and found that it still needs to duplicate "compat" because "compat" is a
>> const str* type and cannot be used as a parameter for the strtok_r function. If it is cast to char*,
>> using "compat" as a parameter for strtok_r is also unsafe and can cause a "Segmentation fault" error.
>> Therefore, let's keep the step of duplicating "compat".
> 
> ok, so then please add a small comment on why the strdup() call is needed.
> 

No problem.

Thanks,
Jing
