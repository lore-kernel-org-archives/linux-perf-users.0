Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28881C47080
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Jun 2021 03:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E660A61027
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Jun 2021 03:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbhFADX3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 31 May 2021 23:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbhFADX3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 31 May 2021 23:23:29 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B471CC061574
        for <linux-perf-users@vger.kernel.org>; Mon, 31 May 2021 20:21:48 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id g18so10333872pfr.2
        for <linux-perf-users@vger.kernel.org>; Mon, 31 May 2021 20:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=skJAYaCf/cTTPQrhk4Hu7mlxrudsdI1zPPPau14eyio=;
        b=DfjVL8ycxqvaZu/8PoWK5hjvjI4tIrN4wTyAwkQVcrMx4SzMoHKBbPZmvpZ+J//H/q
         dTYJ5d3HlS3re7DsVvsivKnDb/dGiyBD0VKyGBNsUp9lqxncxvnTMBDZj7JHQyFzdOjw
         wwiH2WQ1PPSyMnPA/WIqpP6TPoyafB/rjajGsaHc9fS6lIDPdkbNPm1VYxKHjXl2kjVe
         c3kRuKi7y0d1mFtgYsrl6mXhVqxvyFG4cMVV90hOT2kUOzPKbAvFal3Suce6WN+v3GnR
         ay5DaCNG5cfA2W0R4rrGpjHnBu8lMdUX6/ax3G7FOgoz8AH+0Va1BF0qPRGkETKpeN7p
         AkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=skJAYaCf/cTTPQrhk4Hu7mlxrudsdI1zPPPau14eyio=;
        b=unkOAq/EWZ/5Ks47wlbdtsLSohp4A7kU1fBdC2qzJy02wQIfUEbqdXLMoEon/Lwh70
         dwgDmPfsavIdE5cuSIA0nREO1PTzTtaMQfl2f8yrDA9EZXVlb6aoK7z3O+x9xo/WQ7NW
         Ey/c8UYaS//ONuDDlv8tqoJUc7AehIGoNthQja8kPVdnhr69fPaWKvdsomO40ZEv/gk+
         LfB9BWwwKqDCpUbKaT3g8FY8ak3DX0FG042UNPtfUIsvmcoKcRlMwC0vRp4N6wPUeb/N
         VWkJREcKS6Gdp8DJA4qbQ/hbzYIxU7h+1Y5/UqQ0Me6rZGPS9g9kga7dYxwi6/TvZ0KO
         HWSw==
X-Gm-Message-State: AOAM5338tpF4Xv6Q04iyV5PrDmIlrjPsQLwuuvmM15v7LW5jjYYVUXGD
        li59pTi3sNX+mX8wxQizvY9Q7w==
X-Google-Smtp-Source: ABdhPJz8vUKTrjja2YCnATvr1S6IXxg1MTto8pwG6eafwNS4Xm8e36flvIcqUeWEAv8+GgXDL0HxIQ==
X-Received: by 2002:aa7:83c1:0:b029:2e9:6822:69ef with SMTP id j1-20020aa783c10000b02902e9682269efmr18463204pfn.23.1622517708218;
        Mon, 31 May 2021 20:21:48 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id u4sm12638544pgl.43.2021.05.31.20.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 20:21:47 -0700 (PDT)
Date:   Tue, 1 Jun 2021 11:21:43 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf auxtrace: Change to use SMP memory barriers
Message-ID: <20210601032143.GA10026@leoy-ThinkPad-X240s>
References: <20210519140319.1673043-1-leo.yan@linaro.org>
 <d1fc3dd3-e79a-4e93-1083-6b08e0cabe59@intel.com>
 <YK9UFl7Grv/mwmVc@hirez.programming.kicks-ass.net>
 <3c7dcd5d-fddd-5d3b-81ac-cb7b615b0338@intel.com>
 <7cdc3578-a50e-89ef-477a-3dc1f84f96bb@intel.com>
 <YK9tEQmk4Q+M5yJh@hirez.programming.kicks-ass.net>
 <20210531145302.GC9324@leoy-ThinkPad-X240s>
 <YLUFMzxin1PpgIdZ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLUFMzxin1PpgIdZ@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, May 31, 2021 at 05:48:03PM +0200, Peter Zijlstra wrote:
> On Mon, May 31, 2021 at 10:53:02PM +0800, Leo Yan wrote:
> > Hi Peter, Adrian,
> > 
> > On Thu, May 27, 2021 at 11:57:37AM +0200, Peter Zijlstra wrote:
> > > On Thu, May 27, 2021 at 12:24:15PM +0300, Adrian Hunter wrote:
> > > 
> > > > > If all we want is a compiler barrier, then shouldn't that be what we use?
> > > > > i.e. barrier()
> > 
> > Sorry for a bit late.  Just bring up one question before I respin
> > this patch set.
> > 
> > > > I guess you are saying we still need to stop potential re-ordering across
> > > > CPUs, so please ignore my comments.
> > > 
> > > Right; so the ordering issue is real, consider:
> > > 
> > > 	CPU0 (kernel)		CPU1 (user)
> > > 
> > > 	write data		read head
> > > 	smp_wmb()		smp_rmb()
> > > 	write head		read data
> > 
> > One thing should be mentioned is the Linux kernel has _not_ used an
> > explict "smb_wmb()" between writing AUX trace data and updating header
> > "aux_head".  Please see the function perf_aux_output_end():
> 
> I think we pushed that into the driver. There is nothing the generic
> code can do here.
> 
> It is the drivers responsibility of ensuring the data is stable before
> calling perf_aux_output_end() or something along those lines.

Thanks for explaination.  I reviewed the drivers, some of them have
used memory barriers (e.g. Intel-PT, Arm SPE), but some drivers miss
to use memory barriers before calling perf_aux_output_end() (Like Arm
CoreSight, Intel-bts).

Will address this issue in next patch set.

Thanks,
Leo
