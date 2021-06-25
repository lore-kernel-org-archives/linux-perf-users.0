Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F995C48BC2
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Jun 2021 12:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52F956162B
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Jun 2021 12:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhFYMJ3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Jun 2021 08:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhFYMJ3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Jun 2021 08:09:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A06C061574;
        Fri, 25 Jun 2021 05:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CTtko/L51BmcqdwFpZLsEm07UAuI6Le1yXyls1OwuUk=; b=pWSj5BQzzo+iuxVYR7z/14sJ4T
        mj3lwCXd+TV7lxRDuKhKK9ptBZ2XBvBoPqTvNLRFy4ksKY3e7hrdpsyXmOSZ/qR0+R8quu8YM0Nl0
        /V0bbPywlSlVaeTZt/3ujWwDy6wkfnxkRcx48ANLYQLWQu+MqKCddaT94iv8icAiXKK2KNQrt3/DZ
        RjxnOag0WnTgzGvpk35KT22Tk5Vy3onlEmJ+WT4rxxUHYs/nAYWIK7tcjnjMGKCeSqEgP4BRnTZE8
        kTbogoQ0Hqory5Idt1I1bdMWQbONOQOGMqEJiOFU62ZGNXVTpcm74Vf2JCQS/Oh9n7bH8IPZiRQQn
        IsAFCT3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwkbW-0003ZS-Nl; Fri, 25 Jun 2021 12:06:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4732A300233;
        Fri, 25 Jun 2021 14:06:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1CBB2211C6618; Fri, 25 Jun 2021 14:06:37 +0200 (CEST)
Date:   Fri, 25 Jun 2021 14:06:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] perf/x86: Add new event for AUX output counter index
Message-ID: <YNXGzWDUb2rbUhEr@hirez.programming.kicks-ass.net>
References: <20210609142055.32226-1-adrian.hunter@intel.com>
 <20210609142055.32226-2-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609142055.32226-2-adrian.hunter@intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 09, 2021 at 05:20:53PM +0300, Adrian Hunter wrote:
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index f5a6a2f069ed..18bfa05537ab 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -141,6 +141,7 @@ struct hw_perf_event {
>  			unsigned long	event_base;
>  			int		event_base_rdpmc;
>  			int		idx;
> +			int		idx_reported;
>  			int		last_cpu;
>  			int		flags;
>  

This is sad, it blows up the largest element in that union from 96 to
104 bytes.

Is there really no better place for this?
