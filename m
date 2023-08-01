Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E679EC0015E
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Aug 2023 03:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjHADdF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 31 Jul 2023 23:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjHADc4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 31 Jul 2023 23:32:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D4D1BC7
        for <linux-perf-users@vger.kernel.org>; Mon, 31 Jul 2023 20:32:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 332E761386
        for <linux-perf-users@vger.kernel.org>; Tue,  1 Aug 2023 03:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662D2C433C8;
        Tue,  1 Aug 2023 03:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690860774;
        bh=GgyquySW031NzJSZTo0h9xUSD72lX00C077HbyVzIqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BmMBNodQmtfcmd1nuov8mOVZABXCVZWEsV2GPE40+iw5avU3j6IGEYk8xbfsKP6VP
         WntsvvNnXWKdMfsdbIFDs1oeqdXLRIevRzrfNQVPttHdtkm+py2vN/o/zDNxUhZU1W
         1kSWwofhZvKYiUxg9/SktDZm4Ei93SBy4hete523w4TpbQhqnl9llXdILgT6n956mx
         D4ldfodqVhKl3gXQg2/bhMhyWjkvIuyTzkqWAAo2FLMNA5Is9ek195rUwmltRIcDqK
         6amn1Dbpa+PFfVRtCzVmkhMUI343DjH3R1AklW3cHHw5lxLNhnNSk3tLJGyBJgmlCW
         RtKqAMzqg2Fxw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DBF8640096; Tue,  1 Aug 2023 00:32:51 -0300 (-03)
Date:   Tue, 1 Aug 2023 00:32:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     Ian Rogers <irogers@google.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>
Subject: Re: perf test case 6 dumps core on s390 without PMU
Message-ID: <ZMh84/oSgmzsiNz0@kernel.org>
References: <f0508123-780b-3370-e64a-c78a350d76fa@linux.ibm.com>
 <CAP-5=fVKbHc5K4LmmD0aCsB5xt_JAFBNKx7COvoSUEKQx2OzYQ@mail.gmail.com>
 <128916c0-23f1-9e34-3488-906d6df6116f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <128916c0-23f1-9e34-3488-906d6df6116f@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Jul 31, 2023 at 11:42:31AM +0200, Thomas Richter escreveu:
> On 7/28/23 17:32, Ian Rogers wrote:
> > On Fri, Jul 28, 2023 at 7:30 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> >>
> >> Using Linux 6.5.0rc3 perf test case 6 dumps core on an s390 without
> >> configured PMU (this can happen depending on customer machine configuration).
> >>
> >> In this configuration several perf test cases fail:
> >>  # ./perf test 2>&1 | grep FAIL
> >>   6.1: Test event parsing                                : FAILED!
> >>  10.3: Parsing of PMU event table metrics                : FAILED!
> >>  10.4: Parsing of PMU event table metrics with fake PMUs : FAILED!
> >>  28: Use a dummy software event to keep tracking         : FAILED!
> >>  35: Track with sched_switch                             : FAILED!
> >>  66: Parse and process metrics                           : FAILED!
> >>  #
> >>
> >> Even worse the test case 6 dumps core:
> >>
> >>  # ./perf test -F 6
> >>   6: Parse event definition strings                      :
> >>   6.1: Test event parsing                                :
> >>  Segmentation fault (core dumped)
> >>  #
> > 
> > Thanks for reporting this!
> > 
> >> The root cause for these failures and core dump is a missing
> >> PMU, as can be seen by the debug output:
> >>    ...
> >>    Event test failure: test 57 'instructions:uep'
> >>    running test 58 '{cycles,cache-misses,branch-misses}:e'
> >>    No PMU found for 'cycles' <-- Here no PMU is found, because there is none!
> >>    FAILED tests/parse-events.c:1516 wrong number of entries
> >>    Event test failure: test 58 '{cycles,cache-misses,branch-misses}:e'
> >> Here no PMU is found, because there is none!
> >>
> >>    ....
> >>    running test 59 'cycles/name=name/'
> >>    No PMU found for 'name'
> >>    Segmentation fault (core dumped)
> >>
> >> Here the root cause in in function test__term_equal_term() variable
> >> evsel->name is NULL:
> >>
> >>  # gdb ./perf
> >> ....
> >> Breakpoint 1, test__term_equal_term (evlist=0x1542c00) at\
> >>                        tests/parse-events.c:1688
> >> (gdb) p evsel->name
> >> $3 = 0x3fff7fe3dc0 ""
> >> (gdb) n
> >>  691 TEST_ASSERT_VAL("wrong type", evsel->core.attr.type == PERF_TYPE_HARDWARE);
> >> (gdb) n
> >> 1692 TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
> >> (gdb) n
> >> 1693 TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "name") == 0);
> >> (gdb) n
> >>
> >> Program received signal SIGSEGV, Segmentation fault.
> >>
> >> I could fix this by checking for NULL pointer, but I have the
> >> feeling that there is more to it. However I do not fully understand
> >> the latest rework on the event handling.
> >>
> >> The other test cases listed above fail due to the same root cause,
> >> no PMU found.
> >>
> >> Please advise. What should all these test return when a system does
> >> not have any PMU defined at all?
> > 
> > So I was writing a response then figured out I've already fixed this
> > but it looks like the patch hasn't been taken yet:
> > https://lore.kernel.org/lkml/20230706183705.601412-1-irogers@google.com/
> > 
> > Arnaldo, could you take a look?
> > 
> > Thanks,
> > Ian
> > 
> 
> Ian, 
> 
> thanks a lot. I applied both patches you mentioned above and the
> test cases work fine.
> You have my 
> Tested-by: Thomas Richter <tmricht@linux.ibm.com>

Thanks, applied.

- Arnaldo

