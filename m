Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD77EC432BE
	for <linux-perf-users@archiver.kernel.org>; Sun, 15 Aug 2021 14:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91DA261159
	for <linux-perf-users@archiver.kernel.org>; Sun, 15 Aug 2021 14:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238676AbhHOOuN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 15 Aug 2021 10:50:13 -0400
Received: from one.firstfloor.org ([193.170.194.197]:53748 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238541AbhHOOuJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 15 Aug 2021 10:50:09 -0400
X-Greylist: delayed 556 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Aug 2021 10:50:07 EDT
Received: by one.firstfloor.org (Postfix, from userid 503)
        id 5893D870CD; Sun, 15 Aug 2021 16:40:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1629038411;
        bh=azAF6tdlRERJnJMOPZFhCDXRn1/H4qSvoDeGxPIaHP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=owe9lDdY0GP8p5E9fWfvA9cpuUbO9raxRl84mcHZVTSA31mTb5lplKJ4I3VJCLe+C
         0L8UoU7Woysh70ydIVxTJMWtUJt1ySBfrlgzrIG9aB5JOQiND06fC0K1BCOGVMbVKv
         onZ+YWxO+xItbtGTLaNtI/wSEq88tBL03wM5tCJ4=
Date:   Sun, 15 Aug 2021 07:40:10 -0700
From:   Andi Kleen <andi@firstfloor.org>
To:     Claire Jensen <cjense@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, yao.jin@linux.intel.com,
        song@kernel.org, andi@firstfloor.org, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, james.clark@arm.com,
        alexander.antonov@linux.intel.com, changbin.du@intel.com,
        liuqi115@huawei.com, irogers@google.com, eranian@google.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        clairej735@gmail.com
Subject: Re: [PATCH v2 1/1] perf stat: Add JSON output option.
Message-ID: <20210815144007.3e7cwiecbre2nt6y@two.firstfloor.org>
References: <20210813220754.2104922-1-cjense@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="33mn4et7ecvdwvtw"
Content-Disposition: inline
In-Reply-To: <20210813220754.2104922-1-cjense@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


--33mn4et7ecvdwvtw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> CSV output example:
> 
> 1.20,msec,task-clock:u,1204272,100.00,0.697,CPUs utilized
> 0,,context-switches:u,1204272,100.00,0.000,/sec
> 0,,cpu-migrations:u,1204272,100.00,0.000,/sec
> 70,,page-faults:u,1204272,100.00,58.126,K/sec

The difficult part of such changes to perf stat is that it has
so many different output modes that all need to be tested.
Unfortunately the unit tests in perf test are not really
enough for it.

I have an older script (attached) that tests a lot of these outputs. It just
exercises them, you still need to check the output manually

Can you check that all these modes work correctly both
with and without json?

-Andi

--33mn4et7ecvdwvtw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=STAT-REGR-TEST

#!/bin/sh
# test perf stat output combinations with --metric-only
# output has to be manually verified

[ ! -d obj-perf ] && cd ..

set -x

PERF=${PERF:-./obj-perf/perf}

run() {
	$PERF stat -a "$@" sleep 2
}

runprog() {
	$PERF stat "$@" true
}


run
run -x, 
run --per-core
run --per-socket
run -e cycles,instructions
run -dddd

# topdown
# instructions

run -I 500
run -I 500 --per-core 
run -I 500 --per-socket 
run -I 500 -e cycles,instructions
run -I 500 -dddd

run -I 500 -x, 
run -I 500 --per-core -x, 
run -I 500 --per-socket -x, 
run -I 500 -e cycles,instructions -x, 
run -I 500 -dddd -x, 

runprog -r3
runprog -r3 -x, 
$PERF stat -r3 true
$PERF stat -r3 -x,  true

sleep 3 & 
$PERF stat --per-thread -p $! sleep 1
$PERF stat --per-thread -t $! sleep 1


--33mn4et7ecvdwvtw--
