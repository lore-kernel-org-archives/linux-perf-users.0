Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CDEC7EE23
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Jun 2023 00:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjFFAom (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 5 Jun 2023 20:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjFFAol (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 5 Jun 2023 20:44:41 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E977DEA
        for <linux-perf-users@vger.kernel.org>; Mon,  5 Jun 2023 17:44:39 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-75d4dd6f012so330342585a.2
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Jun 2023 17:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686012279; x=1688604279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QwXkWl+7MQW6GzGU3J2RZHBvZFwshO4sBu7pWGFeYvo=;
        b=vwScrcjXbyq6LpzyZ1bhrn8PcIqJno1ASzFEyfSvfFoB1XwgKyzD6L1B9b+QSlWQHC
         D7Bpl8U0B+yZQ8iVrpKCnEC1ib2i5LoG9p9NiEjhGUiRajTjWFGdf6lNa3I/NIA/pWLq
         SuspPkFWaskic/SYcVFV/IDWldL+PyxSZWQz0vq/dhjBD2eEDYxc9PkkdsD+XM/F9k1D
         EfYlzxhWOuehThvDuH8uNlPXbaUOwjoyqTPSwN9f9+EfYX3DC68EqeR5UYg6DK71ZugE
         mtD/HGgtyjOwTjaEwvqSY6K+qnVE3UFfdgTP1mPf3fhu0l0ky7QtSPGXsKolZoBsclvG
         HuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686012279; x=1688604279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwXkWl+7MQW6GzGU3J2RZHBvZFwshO4sBu7pWGFeYvo=;
        b=egO4XTIYYhMe0nwBpoxBTdJzZ32E1hr8KovU7UlvT8d0mMizHF3XoAdmD8LfUF+K1Y
         J2HdeST/sR4PANhrlNdgCuvt1jYMTGw4nyRsxGk3LWMEsKeoq+uJcRpJ3J/MLri3SQbg
         9PzK1zRpN/S07CZv8UKev/DKOu7XNUJ8xqfP0Gcf8Kx6tzA50NpAZdgVI/J24bTRcUyA
         zl0yETfRtQfDjvkEmIFYymk4CIVrTK7cn+YAC+5zRXaDp/K8Nxdi8iTcW4DoWyhXGsL9
         smUcwYr7H0GbzHqDlviDGIsda4VP/4ZvW9SnVxmtrdN9ZzoaWbocv7Hn3gQA59MW58sF
         T5OA==
X-Gm-Message-State: AC+VfDw3mO1m/TmziPbSQ0amDHTuRMJqq86cYtrc0T5vWhIotuwrswss
        XQumvEQhHftavPUdHXHjRziBBg==
X-Google-Smtp-Source: ACHHUZ6CcyK00SR6UmeBHYlbP3/C6TgEnZeMgQsozw24ilXFNavcd5CVDJd+AOdm0DjBLZNHAsTN0g==
X-Received: by 2002:a05:620a:8b12:b0:75e:badf:fde3 with SMTP id qw18-20020a05620a8b1200b0075ebadffde3mr343883qkn.75.1686012278982;
        Mon, 05 Jun 2023 17:44:38 -0700 (PDT)
Received: from leoy-huanghe ([156.59.96.151])
        by smtp.gmail.com with ESMTPSA id 6-20020a17090a194600b0025977e25290sm1617484pjh.3.2023.06.05.17.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 17:44:38 -0700 (PDT)
Date:   Tue, 6 Jun 2023 08:44:31 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, denik@chromium.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] perf cs-etm: Use previous thread for branch sample
 source IP
Message-ID: <20230606004415.GA18315@leoy-huanghe>
References: <20230524131958.2139331-1-james.clark@arm.com>
 <20230524131958.2139331-3-james.clark@arm.com>
 <20230527090635.GB886420@leoy-yangtze.lan>
 <630ab636-107d-4b12-5454-2ee91ad43543@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <630ab636-107d-4b12-5454-2ee91ad43543@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, May 30, 2023 at 03:28:09PM +0100, James Clark wrote:

[...]

> > On Wed, May 24, 2023 at 02:19:56PM +0100, James Clark wrote:
> >> Branch samples currently use the IP of the previous packet as the from
> >> IP, and the IP of the current packet as the to IP. But it incorrectly
> >> uses the current thread. In some cases like a jump into a different
> >> exception level this will attribute to the incorrect process.
> > 
> > It's about the timing that branch has taken or not taken :)
> > 
> > If we think the branch sample as 'branch has taken', then current code
> > is doning right thing, otherwise, we need this fix.
> > 
> 
> If you diff the outputs side by side you can see it mainly has an effect
> where there is a discontinuity. At this point we set either the from or
> the to IPs to 0.
> 
> For example here is a before and after perf script output. Without the
> change it looks like stress was running before it actually was. The
> schedule function that was attributed to ls on the first line hasn't
> finished running yet. But it's attributed to stress on the second line
> even though the destination IP is 0 meaning we don't even know where it
> went.

Yeah, this is a good improvement for me.  Thanks for sharing the
detailed comparison result.

> Before:
> 
>     ls  8350 [006] ... __schedule+0x394 => schedule+0x5c
> stress  8357 [006] ... schedule+0x84 => 0 [unknown]
> stress  8357 [006] ... 0 [unknown] => __unix_dgram_recvmsg+0x130
> 
> After:
> 
>     ls  8350 [006] ... __schedule+0x394 => schedule+0x5c
>     ls  8357 [006] ... schedule+0x84 => 0 [unknown]
> stress  8357 [006] ... 0 [unknown] => __unix_dgram_recvmsg+0x130
> 
> I didn't see any decode differences that weren't around these
> discontinuity points, so it seems like a low risk change.

[...]

> >> @@ -480,6 +481,7 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
> >>  	tidq->trace_chan_id = trace_chan_id;
> >>  	tidq->thread = machine__findnew_thread(&etm->session->machines.host, -1,
> >>  					       queue->tid);
> >> +	tidq->prev_thread = machine__idle_thread(&etm->session->machines.host);
> >>  
> >>  	tidq->packet = zalloc(sizeof(struct cs_etm_packet));
> >>  	if (!tidq->packet)
> >> @@ -616,6 +618,8 @@ static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
> >>  		tmp = tidq->packet;
> >>  		tidq->packet = tidq->prev_packet;
> >>  		tidq->prev_packet = tmp;
> >> +		thread__put(tidq->prev_thread);
> >> +		tidq->prev_thread = thread__get(tidq->thread);
> > 
> > Maybe cs_etm__packet_swap() is not the best place to update
> > "tidq->prev_thread", since swapping packet doesn't mean it's necessarily
> > thread switching; can we move this change into the cs_etm__set_thread()?
> > 
> 
> Yeah that might make more sense. I can move it there if we decide to
> keep this change.

Please refine the patch for this.  Thanks and sorry my late replying.

Leo
