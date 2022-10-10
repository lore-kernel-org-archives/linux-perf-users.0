Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F316DC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 Oct 2022 20:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJJUwT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 Oct 2022 16:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJJUwS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Oct 2022 16:52:18 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424AC659EE
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Oct 2022 13:52:17 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id r17so27304421eja.7
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Oct 2022 13:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMCdZsgDT6lSEa4yNENSrXv8jGmGdcVyTlFDM83Wjjs=;
        b=hs6aPu62O1qNKak5PIOSldtOcEGWNOcc7PkU3A+LLI7CTzFlKbtDKUd71kE7tr6/rj
         JLHmezBCaCAvBubQyHUJbIvinRUZ7VdfXV1TfmppLNMgB9cMUo9hOhZEl5Bl8AutXQW0
         YFEmlrrvGiCV8pvEDcJ9aRdFsU1DJLS3RPSDBCLNPv4aq9xiFgywt4K5ibVn/QcsEZn/
         DBFFCN+ZIN6ovBkGfVC2C43+0YGrSe5t7wTWefBsutOtnprpz2i3tJkdYk0i+VFACLW3
         yTkaFUw/69wrjLxsCf3gThFawfeu2o0XeKl3sfd62G4TrrOhZGAJcbJHsV7I3AFEgGr+
         WL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMCdZsgDT6lSEa4yNENSrXv8jGmGdcVyTlFDM83Wjjs=;
        b=Dq+eaTjRn/faOF1hnLh9Q57TjUkX6TVsJyv0gxil8FAjVJgCYDFDAtuxIOjw3w7JRT
         YnbhYQ65HbFjC1z3DiF9/CMHpu6BIlD2386IpkrKnUZpAVvBqCunIPuv/lQus+ivILjU
         dnIx2bkQey35e9h9I5fpb+aAJYA+RNPyUL8YhxYlJxjmfu+Y/JXDtlBECmb9cMY8ozpp
         1URZqcMWaQs5KyFZrkMlgJ8KC4QBDirmCYwMlcbdPasrOzEMHYhRUtd/xTyoLTrS4paK
         qlNmo5XJ0aE7M8RpuOBWj+H1aJa7ubF0qUJBRbcAvup3va/t6441unOWzuyqmAVpALFs
         /yMg==
X-Gm-Message-State: ACrzQf1DEK58eyf8gpRP72ImNaMf6Y9DbeaRu6KBkR0DEYCJhYMSFLVV
        hcaxDoaTazGy+KEPsMIJPfO7/HVEiO/ZUg==
X-Google-Smtp-Source: AMsMyM5au/LCSyZWt4fcGj1z/38PaFB+06Vn9Kvp1Q0WjpNp6tPuKtGY9KP/Nd/YLiJRBfRsLA5l8g==
X-Received: by 2002:a17:907:75f8:b0:78d:9f95:bddf with SMTP id jz24-20020a17090775f800b0078d9f95bddfmr8880685ejc.588.1665435135679;
        Mon, 10 Oct 2022 13:52:15 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:a8e9:58ad:3b85:de40])
        by smtp.gmail.com with ESMTPSA id c18-20020aa7d612000000b0045720965c7asm7692314edr.11.2022.10.10.13.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 13:52:15 -0700 (PDT)
Date:   Mon, 10 Oct 2022 22:52:08 +0200
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] perf: Fix missing SIGTRAPs
Message-ID: <Y0SF+Gkdl4YSqFF4@elver.google.com>
References: <20220927121322.1236730-1-elver@google.com>
 <Yz7ZLaT4jW3Y9EYS@hirez.programming.kicks-ass.net>
 <Yz7fWw8duIOezSW1@elver.google.com>
 <Yz78MMMJ74tBw0gu@hirez.programming.kicks-ass.net>
 <Yz/zXpF1yLshrJm/@elver.google.com>
 <Y0Ak/D05KhJeKaed@hirez.programming.kicks-ass.net>
 <Y0AwaxcJNOWhMKXP@elver.google.com>
 <Y0BQYxewPB/6KWLz@elver.google.com>
 <Y0E3uG7jOywn7vy3@elver.google.com>
 <Y0FwC1yo1pcyL9J/@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0FwC1yo1pcyL9J/@hirez.programming.kicks-ass.net>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, Oct 08, 2022 at 02:41PM +0200, Peter Zijlstra wrote:
> On Sat, Oct 08, 2022 at 10:41:28AM +0200, Marco Elver wrote:
> > The below patch to the sigtrap_threads test can repro the issue (when
> > run lots of them concurrently again). It also illustrates the original
> > problem we're trying to solve, where the event never gets rearmed again
> > and the test times out (doesn't happen with the almost-working fix).
> 
> Excellent, that helps. Also, I'm an idiot ;-)
> 
> The below seems to fix it for me.
> 
> ---
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3441,7 +3448,8 @@ static void perf_event_context_sched_out
>  			perf_pmu_disable(pmu);
>  
>  			/* PMIs are disabled; ctx->nr_pending is stable. */
> -			if (local_read(&ctx->nr_pending)) {
> +			if (local_read(&ctx->nr_pending) ||
> +			    local_read(&next_ctx->nr_pending)) {
>  				/*
>  				 * Must not swap out ctx when there's pending
>  				 * events that rely on the ctx->task relation.

Yup, that fixes it.

Can you send a v2 with all the fixups? Just to make sure I've tested the
right thing.

I'll also send the patch for the selftest addition once I gave it a good
spin.

Thanks,
-- Marco
