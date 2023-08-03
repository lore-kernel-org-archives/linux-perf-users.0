Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08863C04A6A
	for <linux-perf-users@archiver.kernel.org>; Thu,  3 Aug 2023 08:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjHCI7l (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 3 Aug 2023 04:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjHCI7k (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 3 Aug 2023 04:59:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35CAE43;
        Thu,  3 Aug 2023 01:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DFxy+9MsOX2CxBRtThLgeCAlgtgs8UAOqnC7kEA2lOc=; b=v+ZU04CXJ+36isCG8CyhFHBxf2
        C0GXo4/GeS8WZ6FbmRYUXWs6W6Qa9nwFCgwwI82ZRLXXqBWjh5WoKzVogIjscqRQk+2G2EBitjazk
        SA7mjowqGzWsaskGT8Gan3X0ho6LLi9LnZi+dHuhz2t7rnDj7JgGSnIQPF0muPUVX4e8teR1ovVdN
        8Uhvr3yZ6pMK6Q/EVaujSQKZbN4TiVegBwhEs482iRVrFK+ltOFLsd1WptufEc9lxOSDgaodwAlLG
        8r1cTnFCt7P6gTskD3MSc5tu5ZCj3xQJeOFMggA/2cgtZVFKGmb64gWqngI3gjfj8TGUqE5LZyPFr
        XL5YVebQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRUAn-002dqs-Qf; Thu, 03 Aug 2023 08:59:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 558F930007E;
        Thu,  3 Aug 2023 10:59:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 161022066B20B; Thu,  3 Aug 2023 10:59:09 +0200 (CEST)
Date:   Thu, 3 Aug 2023 10:59:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ze Gao <zegao2021@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: Re: [RFC PATCH v6 4/5] sched, tracing: add to report task state in
 symbolic chars
Message-ID: <20230803085909.GH212435@hirez.programming.kicks-ass.net>
References: <20230803083352.1585-1-zegao@tencent.com>
 <20230803083352.1585-5-zegao@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803083352.1585-5-zegao@tencent.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Aug 03, 2023 at 04:33:51AM -0400, Ze Gao wrote:
> Internal representations of task state are likely to be changed
> or ordered, and reporting them to userspace without exporting
> them as part of API is basically wrong, which can easily break
> a userspace observability tool as kernel evolves. For example,
> perf suffers from this and still reports wrong states as of this
> writing.
> 
> OTOH, some masqueraded states like TASK_REPORT_IDLE and
> TASK_REPORT_MAX are also reported inadvertently, which confuses
> things even more and most userspace tools do not even take them
> into consideration.
> 
> So add a new variable in company with the old raw value to
> report task state in symbolic chars, which are self-explaining
> and no further translation is needed. Of course this does not
> break any userspace tool.
> 
> Note for PREEMPT_ACTIVE, we introduce 'p' to report it and use
> the old conventions for the rest.
> 
> Signed-off-by: Ze Gao <zegao@tencent.com>
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Acked-by: Ian Rogers <irogers@google.com>

I'm not sure you've actually read any of the things I've written. I hate
this. Not going to happen.
