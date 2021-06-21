Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DD5C48BC2
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 11:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A38D6100A
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 11:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhFUL26 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Jun 2021 07:28:58 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3293 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhFUL25 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Jun 2021 07:28:57 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G7n6P3tHQz6L6WT;
        Mon, 21 Jun 2021 19:16:45 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 21 Jun 2021 13:26:41 +0200
Received: from [10.47.93.67] (10.47.93.67) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 21 Jun
 2021 12:26:41 +0100
From:   John Garry <john.garry@huawei.com>
Subject: perf tool: About tests debug level
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        "irogers@google.com" <irogers@google.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>
Message-ID: <ecd941b3-2fd5-61d8-93a1-76a3a3ee4138@huawei.com>
Date:   Mon, 21 Jun 2021 12:20:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.93.67]
X-ClientProxiedBy: lhreml747-chm.china.huawei.com (10.201.108.197) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi guys,

I noticed that when it was discovered recently that the new icelake JSON 
did not pass "PMU events" test, running the test with -v makes pr_err() 
and pr_debug() come out at the same level, so it's hard to distinguish 
the important logs.

Here is a link:
https://lore.kernel.org/lkml/YLdq%2FH8CXYgHWzCL@kernel.org/

And here is an extract:

parsing '(cpu_clk_unhalted.thread / cpu_clk_unhalted.ref_tsc) * msr@tsc@ 
/ 1000000000 / duration_time'
parsing '( ( 1 * ( fp_arith_inst_retired.scalar_single + 
fp_arith_inst_retired.scalar_double ) + 2 * 
fp_arith_inst_retired.128b_packed_double + 4 * ( 
fp_arith_inst_retired.128b_packed_single + 
fp_arith_inst_retired.256b_packed_double ) + 8 * ( 
fp_arith_inst_retired.256b_packed_single + 
fp_arith_inst_retired.512b_packed_double ) + 16 * 
fp_arith_inst_retired.512b_packed_single ) / 1000000000 ) / duration_time'
parsing 'cpu_clk_unhalted.thread / cpu_clk_unhalted.ref_tsc'
parsing '1 - cpu_clk_unhalted.one_thread_active / 
cpu_clk_unhalted.ref_distributed'
parsing 'cpu_clk_unhalted.thread:k / cpu_clk_unhalted.thread'
parsing '( 64 * ( uncore_imc@cas_count_read@ + 
uncore_imc@cas_count_write@ ) / 1000000000 ) / duration_time'
parsing '1000000000 * ( cha@event\=0x36\,umask\=0x21\,config\=0x40433@ / 
cha@event\=0x35\,umask\=0x21\,config\=0x40433@ ) / ( cha_0@event\=0x0@ / 
duration_time )'
parsing 'cha@event\=0x36\,umask\=0x21\,config\=0x40433@ / 
cha@event\=0x36\,umask\=0x21\,config\=0x40433\,thresh\=1@'
parsing '( 1000000000 * ( 
cha@event\=0x36\,umask\=0x21\,config\=0x40433@_pmm / 
cha@event\=0x35\,umask\=0x21\,config\=0x40433@_pmm ) / cha_0@event\=0x0@ 
)' [pr_debug]
check_parse_fake failed [pr_err]
test child finished with -1
---- end ----

I annotated in [], above

As for another issue, if you consider "Parse and process metrics", debug 
from core code comes out at same level as test code, e.g. with -v, we 
see pr_debug() from test code and core code. Again, this makes it hard 
to distinguish various levels. As an illustration, here I hack the code 
to fail a test:

sudo ./perf test -v 68
68: Parse and process metrics                                       :
--- start ---
test child forked, pid 9747
metric expr inst_retired.any / cpu_clk_unhalted.thread for IPC
found event inst_retired.any verbose=1 pr_debug
found event inst_retired.any verbose=1 pr_err
found event cpu_clk_unhalted.thread verbose=1 pr_debug
found event cpu_clk_unhalted.thread verbose=1 pr_err
adding {inst_retired.any,cpu_clk_unhalted.thread}:W
FAILED tests/parse-metric.c:223 IPC failed, wrong ratio
FAILED tests/parse-metric.c:374 IPC failed
test child finished with -1
---- end ----
Parse and process metrics: FAILED!

Note that the "FAILED" messages from the test code come from pr_debug().

In a way, I feel that pr_debug()/err from the test is more important 
than pr_debug() from the core code (when running a test).

Any opinion on this or how to improve (if anyone agrees with me)? Or am 
I missing something? Or is it not so important?

Thanks,
John
