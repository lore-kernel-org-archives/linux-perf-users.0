Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0A6C433B4
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 May 2021 11:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 991B861623
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 May 2021 11:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbhEJLv5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 May 2021 07:51:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2550 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbhEJLeY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 May 2021 07:34:24 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FdzPl6DFkzkYFF;
        Mon, 10 May 2021 19:30:35 +0800 (CST)
Received: from [10.67.110.237] (10.67.110.237) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Mon, 10 May 2021 19:33:08 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <linux-perf-users@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>,
        <zhangjinhao2@huawei.com>
Subject: Fwd: Perf kmem usage
Message-ID: <e3c695c4-0ae4-a1c8-833c-2eb17cbca3cf@huawei.com>
Date:   Mon, 10 May 2021 19:33:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.237]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi everyone,

I failed to use perf with the following command:
  # perf kmem record --slab --page
   Error: unknown option `slab'

  Usage: perf record [<options>] [<command>]
     or: perf record [<options>] -- <command> [<options>]

     -a, --all-cpus        system-wide collection from all CPUs
     -b, --branch-any      sample any taken branches
     -B, --no-buildid      do not collect buildids in perf.data
     -c, --count <n>       event period to sample
     -C, --cpu <cpu>       list of cpus to monitor
     -d, --data            Record the sample addresses
     ...

This is because commit be8299e4a2e2("perf kmem: Pass additional 
arguments to 'perf record'") no longer parses the arguments after the 
subcommand and passes them to 'perf record'. Perhaps the correct usage 
should be:

  # perf kmem --slab --page record

That is, use the method given in 'perf kmem -h':

  perf kmem [<options>] {record|stat}

But we tend to use it the following way(perhaps I'm wrong):

  perf kmem {record|stat} [<options>]

and I've seen some places where it's used, like commit 
c9758cc45699("perf kmem: Implement stat --page --caller"), or "man perf 
kmem" help information. So I'd like to confirm whether this is allowed. 
If allowed, we may need a fix for commit be8299e4a2e2("perf kmem: Pass 
additional arguments to 'perf record'").

Regards,
Huafei
