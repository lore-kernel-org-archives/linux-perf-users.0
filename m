Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64C9C7EE23
	for <linux-perf-users@archiver.kernel.org>; Thu,  8 Jun 2023 10:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236107AbjFHK0F (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 8 Jun 2023 06:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235821AbjFHK0E (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 8 Jun 2023 06:26:04 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6CFE2
        for <linux-perf-users@vger.kernel.org>; Thu,  8 Jun 2023 03:26:03 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-65299178ac5so370286b3a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jun 2023 03:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686219962; x=1688811962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3xkH3r1pvwgUrEo7Gtm0dIWmSa6nSh/lG9Vqe1Of73g=;
        b=nCZY15shRf0+YCOaFOuY8X6w310iPAZUYi5ASkQz/GUc+4dSc2cReU0+52jpmuft1b
         zgRskJqRB9fkL8XXnZXtSGXpDEiQT3BsO1De6EkspTxOfkC7L1/My9JygCq3fEI5DVi3
         gIZ8n1z9SzT8oR85zl9AJLdkOhhKpzMKA38CfDUFMNh3BPtoHjzUjRbbrn29AMGqT0F/
         zu2wsnbm1hwaE4pjxWEmVcbQkkPkVGvF5UzRSs4IG0HYp0380HCk0LZjOxYvbLkanv/1
         2eahg6XTZb7T4cCEZtQIc/e0qfI3USBtTHh1PlSGPKru2u9a+yQrVvaFuDoJ9Ic/yvd4
         s/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686219962; x=1688811962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xkH3r1pvwgUrEo7Gtm0dIWmSa6nSh/lG9Vqe1Of73g=;
        b=CEMaCm92c5J2yZ1e8xUCqAIf1q9JmIIHuXJ7oFacveJQT2Wb8uH217dq3S2wymHmWx
         GCqnhn+BAorpi6c0m+1jidab6D/QDPWWKz+c2FdPxQhr8VUKYfSnfThROIUfWYosYCUB
         yQZTWXhcvQyV2d7ofKgDbAErasyInZleIJP+gbCR+sDQOBlZ+9FGUuTHUXw3HQGwK0dr
         UJPUJYAbXxh17C1xr8M3tFQh9zOnwfVUDgmouYK+6qe1tPJjq1gBPAt4iYbKvskCHXkP
         45fdCJuyhw7csMTA2kYLAIcwZ22FEqomKEXVCzfTmoGJZ/JxLdDEXur1s2nTfasTwpGH
         Vo+g==
X-Gm-Message-State: AC+VfDyWatB0fT7NcwL8ezploKKudWacPArPYci6sjUpmtmNIcuqt/7F
        onvHO9/CNhd76pzZG6nHGHwK9w==
X-Google-Smtp-Source: ACHHUZ5JTCRE7fcyNWts+H2vn0LEXWHBO6ClckfueGh8B+IzoyS9r/drZKEBPVRJZZdzupk6aKns1w==
X-Received: by 2002:a05:6a00:3a26:b0:659:3031:5037 with SMTP id fj38-20020a056a003a2600b0065930315037mr9799968pfb.3.1686219962556;
        Thu, 08 Jun 2023 03:26:02 -0700 (PDT)
Received: from leoy-huanghe ([156.59.39.101])
        by smtp.gmail.com with ESMTPSA id m23-20020aa79017000000b006410f4f3ecdsm822251pfo.83.2023.06.08.03.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 03:26:02 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:25:55 +0800
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
Message-ID: <20230608102555.GB123723@leoy-huanghe>
References: <20230524131958.2139331-1-james.clark@arm.com>
 <20230524131958.2139331-3-james.clark@arm.com>
 <20230527090635.GB886420@leoy-yangtze.lan>
 <630ab636-107d-4b12-5454-2ee91ad43543@arm.com>
 <1e7aa657-6d1e-9e7c-95cb-b32d307abe93@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e7aa657-6d1e-9e7c-95cb-b32d307abe93@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jun 08, 2023 at 10:34:42AM +0100, James Clark wrote:

[...]

> >>> @@ -616,6 +618,8 @@ static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
> >>>  		tmp = tidq->packet;
> >>>  		tidq->packet = tidq->prev_packet;
> >>>  		tidq->prev_packet = tmp;
> >>> +		thread__put(tidq->prev_thread);
> >>> +		tidq->prev_thread = thread__get(tidq->thread);
> >>
> >> Maybe cs_etm__packet_swap() is not the best place to update
> >> "tidq->prev_thread", since swapping packet doesn't mean it's necessarily
> >> thread switching; can we move this change into the cs_etm__set_thread()?
> >>
> > 
> > Yeah that might make more sense. I can move it there if we decide to
> > keep this change.
> > 
> 
> Unfortunately I don't think I can make this change. It seems like
> putting the previous thread swap in  cs_etm__set_thread() has different
> semantics to keeping all the swaps together in cs_etm__packet_swap().

Thanks for trying this.

> This is because if you swap the thread in cs_etm__packet_swap() the
> previous packet and next packet can have the _same_ thread if there
> happened to be no change. However if you only swap previous thread in
> cs_etm__set_thread(), that means that the previous thread is always
> different to the next one. This has a huge difference on the decoding
> because two adjacent packets on the same thread will say they branched
> from the previous thread that ran, not the previous thread on the
> previous packet.

Seems to me, this is a synchronization issue between the field
'tidq->prev_thread' and 'tidq->prev_packet'.

It's still hard for me to understand "two adjacent packets on the same
thread will say they branched from the previous thread that ran", IIUC,
even we move thread swapping into cs_etm__set_thread(), if the two
adjacent packets are in the same thread context, we can skip to update
fields 'tidq->prev_thread' and 'tidq->prev_packet'.

So I am curious if below cs_etm__set_thread() works or not?

static void cs_etm__set_thread(struct cs_etm_auxtrace *etm,
			       struct cs_etm_traceid_queue *tidq, pid_t tid)
{
	struct machine *machine = &etm->session->machines.host;

	/* No context switching, bail out */
	if ((tidq->thread->tid != tid)
		return;

	/* If tid is -1, we simply use idle thread context */
	if (tid == -1)
		goto find_idle_thread;

	/*
	 * The new incoming tid is different from current thread,
	 * so it's to switch to the next thread context.
	 */

	/* Swap thread contexts */
	thread__put(tidq->prev_thread);
	tidq->prev_thread = thread__get(tidq->thread);

	/* Find thread context for new tid */
	thread__zput(tidq->thread);
	tidq->thread = machine__find_thread(machine, -1, tid);

find_idle_thread:
	/* Couldn't find a known thread */
	if (!tidq->thread)
		tidq->thread = machine__idle_thread(machine);
}

Thanks,
Leo
