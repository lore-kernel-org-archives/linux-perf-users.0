Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACD1C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Feb 2022 11:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244831AbiBKLhB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 11 Feb 2022 06:37:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240820AbiBKLhB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 11 Feb 2022 06:37:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D106E9B;
        Fri, 11 Feb 2022 03:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=75NWpP1F3muQ7eU77nN0HqewB2XELKQjhwajLBBcmi4=; b=PSN+UiFDV4kXfaO/wz7emyjBKj
        k23Ik9QPVvS3SLNFogCYSikiE7DGGSJHir26m6VUCwHZfVbG4JYkv+wdDf4HhBJ2mGt/PbF4DceIo
        gxAAIsuysAEz+lx8/wv8UO+1fW3FAJA03zGAm2WtR4Wg53ioRsCcbGYnWbloETzZr7H0QWnwp/xlq
        6YeHeMC4s55AlC32NStEhjdxlulhtn5NcSPiRVGG2tOOpoR0xDu6DYsNdyV8Z/tHT8Mx95o9IjHCA
        r5V9bmOCDdcfZqL8u5lb8vfG7uR3qLB+EODQrfE7h0DdQEW/viB9+HXxhGl1WIOdkKnx+pLJhL2Eu
        q+DZThWA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIUEG-00AMT3-DH; Fri, 11 Feb 2022 11:36:44 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 66C149853C7; Fri, 11 Feb 2022 12:36:43 +0100 (CET)
Date:   Fri, 11 Feb 2022 12:36:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wen Yang <simon.wy@alibaba-inc.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] perf/x86: improve the event scheduling to avoid
 unnecessary pmu_stop/start
Message-ID: <20220211113643.GT23216@worktop.programming.kicks-ass.net>
References: <20220210043930.34311-1-simon.wy@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210043930.34311-1-simon.wy@alibaba-inc.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Feb 10, 2022 at 12:39:30PM +0800, Wen Yang wrote:
> This issue has been there for a long time, we could reproduce it as follows:
> 
> 1, run a script that periodically collects perf data, eg:
> while true
> do
>     perf stat -e cache-misses,cache-misses,cache-misses -C 1 sleep 2
>     perf stat -e cache-misses -C 1 sleep 2
>     sleep 1
> done
> 
> 2, run another one to capture the IPC, eg:
> perf stat -e cycles:D,instructions:D  -C 1 -I 1000
> 
> Then we could observe that the counter used by cycles:D changes frequently:
> crash> struct  cpu_hw_events.n_events,assign,event_list,events  ffff88bf7f44f420
>   n_events = 3
>   assign = {33, 1, 32, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
>   event_list = {0xffff88bf77b85000, 0xffff88b72db82000, 0xffff88b72db85800, 0xffff88ff6cfcb000, 0xffff88ff609f1800, 0xffff88ff609f1800, 0xffff88ff5f46a800, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}
>   events = {0x0, 0xffff88b72db82000, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0xffff88b72db85800, 0xffff88bf77b85000, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}
> 
> crash> struct  cpu_hw_events.n_events,assign,event_list,events  ffff88bf7f44f420
>   n_events = 6
>   assign = {33, 3, 32, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
>   event_list = {0xffff88bf77b85000, 0xffff88b72db82000, 0xffff88b72db85800, 0xffff88bf46c34000, 0xffff88bf46c35000, 0xffff88bf46c30000, 0xffff88ff5f46a800, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}
>   events = {0xffff88bf46c34000, 0xffff88bf46c35000, 0xffff88bf46c30000, 0xffff88b72db82000, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0xffff88b72db85800, 0xffff88bf77b85000, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}

The above is unreadable; consider rewriting it in something other than a
raw data dump.

> The reason is that NMI watchdog permanently consumes one FP,
> so cycles can only use one GP, and its hweight is 5,
> but the hweight of other events (cache misses) is 4,
> so the counter used by cycles will be frequently taken away,
> resulting in unnecessary pmu_stop/start.

And the solution..... ? Or should I try and reverse engineer from the
proposed patch? If I do, how do I know it is what you intended?
