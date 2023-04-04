Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF0DC761A6
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 Apr 2023 19:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbjDDTyt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 4 Apr 2023 15:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjDDTyp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 4 Apr 2023 15:54:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823891A8;
        Tue,  4 Apr 2023 12:54:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78E23636DD;
        Tue,  4 Apr 2023 19:54:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE09C4339B;
        Tue,  4 Apr 2023 19:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680638082;
        bh=7/s9n05OHIGD/qOsNeyGERi0KHyb10bjvH7QNbEWhjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YvWargS25YyRSp1HopTogmNtHQOOl8CdaNycdknJyhRG9cu7Qn0aN4HWlj+WkObDp
         Mxd21mOr9rXmKOsuue5bC0GFhKLkzA0XQ1PAy5ttJFsc8/NR64dSl1sAPcAnVhIPD+
         kWEgc37/XtTIN9v7TB0WzAD2ZgJx7s3qQbT/69GqzVt3XIPLKxahWQgi3ULEWJrbhC
         dMaEVX2j32DydBagRLZlCFPwe2wHIPzQoMjAN82qZVKjHMIaAp4QomdPWphli+95nB
         5i/NLFVJltg3ZZpha9H4n/Indo1UyfCPvBDmISu+xIYNjsxToDE8uPzTE/nLiVv37e
         tqa2lUNlDJrDA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1D02B4052D; Tue,  4 Apr 2023 16:54:40 -0300 (-03)
Date:   Tue, 4 Apr 2023 16:54:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hao Luo <haoluo@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v5 00/17] Reference count checker and related fixes
Message-ID: <ZCyAgASMBfMtFGLq@kernel.org>
References: <20230320212248.1175731-1-irogers@google.com>
 <CAP-5=fX4=pUmcFpRZ5xFds1awSr7HSo1F9rH4=D7NJXW9OXXVQ@mail.gmail.com>
 <7443d427-783b-44b6-85e6-5e667bb83a94@intel.com>
 <CAP-5=fUvCYHLaecCKMnFwMEcbqj=UcfgHSKAtmYEtk+sJT26nQ@mail.gmail.com>
 <ZCx5EyhgwZNWomfD@kernel.org>
 <ZCyAJiEGui9JmULO@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCyAJiEGui9JmULO@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Apr 04, 2023 at 04:53:10PM -0300, Arnaldo Carvalho de Melo escreveu:
> Applied to:
> 
> perf map: Add accessor for start and end

> +++ b/tools/perf/util/machine.c
> @@ -903,7 +903,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
>  		}
>  
>  		map->start = event->ksymbol.addr;
> -		map->end = map__start(map) + event->ksymbol.len;
> +		map__end(map) = map__start(map) + event->ksymbol.len;

Ditch this one, duh.

>  		err = maps__insert(machine__kernel_maps(machine), map);
>  		map__put(map);
>  		if (err)
