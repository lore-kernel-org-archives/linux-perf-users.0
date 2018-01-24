From: ufo19890607 <ufo19890607@gmail.com>
Subject: perf stat: Add support to print counts for fixed times
Date: Wed, 24 Jan 2018 03:43:19 +0100
Message-ID: <1516761799-25350-1-git-send-email-ufo19890607@gmail.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:37361 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752043AbeAXCng (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Jan 2018 21:43:36 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com, adrian.hunter@intel.com, wangnan0@huawei.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com

From: yuzhoujian <yuzhoujian@didichuxing.com>

Hi Jirka
And how can you control the output for perf stat, if I don't want to use the 
"sleep" workload, like some user programs. I want to check the "cycles"
for this program when it just begin to run.

root@node10:/home$ gcc -g -o malloc malloc.c
root@node10:/home$ ./perf stat -e cycles -I 1000 --times-print 3 ./malloc &
[1] 32586
#           time             counts unit events
     1.000094153      2,914,162,979      cycles                                                      
     2.000323667      3,062,832,799      cycles                                                      
     3.000443807      3,063,146,609      cycles

Best wishes
