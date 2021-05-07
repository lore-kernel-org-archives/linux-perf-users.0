Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC43C433ED
	for <linux-perf-users@archiver.kernel.org>; Fri,  7 May 2021 16:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C207661460
	for <linux-perf-users@archiver.kernel.org>; Fri,  7 May 2021 16:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbhEGQak (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 7 May 2021 12:30:40 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3042 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238172AbhEGQak (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 7 May 2021 12:30:40 -0400
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FcG0p4DLpz6snrx;
        Sat,  8 May 2021 00:21:30 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 7 May 2021 18:29:37 +0200
Received: from [10.47.82.108] (10.47.82.108) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 7 May 2021
 17:29:36 +0100
Subject: Re: [PATCH] perf jevents: Silence warning for ArchStd files
To:     Ian Rogers <irogers@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Kim Phillips <kim.phillips@amd.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210506225640.1461000-1-irogers@google.com>
 <4f9a4f20-82ac-dd68-4aee-b560396755f2@huawei.com>
 <CAP-5=fUGRU+vi5NfYLBV9dXgZcG0WY45srsi3Q75T7pPLBLnMQ@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <946c888e-7918-3692-ecdd-9f4706cbc764@huawei.com>
Date:   Fri, 7 May 2021 17:29:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAP-5=fUGRU+vi5NfYLBV9dXgZcG0WY45srsi3Q75T7pPLBLnMQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.82.108]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 07/05/2021 16:46, Ian Rogers wrote:
> On Fri, May 7, 2021 at 2:00 AM John Garry<john.garry@huawei.com>  wrote:
>> On 06/05/2021 23:56, Ian Rogers wrote:
>>> json files in the level 1 directory are used for ArchStd events (see
>>> preprocess_arch_std_files), as such they shouldn't be warned about.
>>>
>>> Signed-off-by: Ian Rogers<irogers@google.com>
>>> ---
>>>    tools/perf/pmu-events/jevents.c | 6 ++++--
>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
>>> index ed4f0bd72e5a..7422b0ea8790 100644
>>> --- a/tools/perf/pmu-events/jevents.c
>>> +++ b/tools/perf/pmu-events/jevents.c
>>> @@ -1123,8 +1123,10 @@ static int process_one_file(const char *fpath, const struct stat *sb,
>>>                        mapfile = strdup(fpath);
>>>                        return 0;
>>>                }
>>> -
>>> -             pr_info("%s: Ignoring file %s\n", prog, fpath);
>>> +             if (is_json_file(bname))
>>> +                     pr_debug("%s: ArchStd json is preprocessed %s\n", prog, fpath)
>> We could get more elaborate and add the same first debug print in
>> process_one_file() to preprocess_arch_std_file() to give the allusion
>> that they are preprocessed, and change the logic not print that for arch
>> std files (in process_one_file()). But not sure it's worth it.
>>
>> Or else we could also just omit any print here for archstd files here.
> I thought about just dropping the print in the json case but then a
> comment would be nice, the pr_debug is a comment and is somewhat
> intention revealing. If you think it is overkill then it is ok to
> change.

I don't think it's a big deal either way.

Reviewed-by: John Garry <john.garry@huawei.com>
