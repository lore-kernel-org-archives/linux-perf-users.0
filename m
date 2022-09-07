Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DC2C38145
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Sep 2022 12:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiIGMjl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Sep 2022 08:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiIGMjj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Sep 2022 08:39:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB7929839;
        Wed,  7 Sep 2022 05:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WaLVUa/zzUyERr1LanHZCtjpzRsLTFPoqJHLp72GAJE=; b=kvlGRcc+Pe35py6MEV94CEVoJ3
        9faTnKOOv3kuL5cn1BvvkmeTmzt0p74/jezdoY1FrHpI123QctDsNNsVzuYorGlKvwbiXXD7hhx/8
        YSbCE2NAQ5LUmmKBE6nokQIPlX+ArAu5JWohQ9Zicpo7unWPYTFlGJCfPZ8EGkwRGhF5bHPSwWrMQ
        DdUC19JPwMbuKy8JHjiFmhqSqlX1CpwkWd/PAZxMu2KHPlCbelwOEr3gJr9jw+cXvacVzogzutHsO
        yTstqrP47fqFnTbYqg6HO2io1vT9heTpxQEJgtqjR8agoBzZj1gcy8po44vvLLJbZqSIquMn7Kpyj
        rIvZ/suQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVuKq-00ARLH-Uc; Wed, 07 Sep 2022 12:39:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 79FC83002A3;
        Wed,  7 Sep 2022 14:39:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 35009207AB808; Wed,  7 Sep 2022 14:39:15 +0200 (CEST)
Date:   Wed, 7 Sep 2022 14:39:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] perf: Allow restricted kernel breakpoints on user
 addresses
Message-ID: <YxiQ87X1eUB2rrtF@hirez.programming.kicks-ass.net>
References: <20220902100057.404817-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902100057.404817-1-elver@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Sep 02, 2022 at 12:00:57PM +0200, Marco Elver wrote:

> +/*
> + * Check if unprivileged users are allowed to set up breakpoints on user
> + * addresses that also count when the kernel accesses them.
> + */
> +static bool perf_allow_kernel_breakpoint(struct perf_event_attr *attr)
> +{
> +	if (attr->type != PERF_TYPE_BREAKPOINT)
> +		return false;
> +
> +	/*
> +	 * The sample may contain IPs, registers, or other information that may
> +	 * disclose kernel addresses or timing information. Disallow any kind of
> +	 * additional sample information.
> +	 */
> +	if (attr->sample_type)
> +		return false;

This feels a bit weird; should that perhaps be is_sampling_event()?

> +
> +	/*
> +	 * Only allow kernel breakpoints on user addresses.
> +	 */
> +	return access_ok((void __user *)(unsigned long)attr->bp_addr, attr->bp_len);
> +}
> +
> +int perf_allow_kernel(struct perf_event_attr *attr)
> +{
> +	if (sysctl_perf_event_paranoid > 1 && !perfmon_capable() &&
> +	    !perf_allow_kernel_breakpoint(attr))

I'm on the fence about this; one the one hand it feels weird to have a
breakpoint exception here and not a pmu specific callback for instance;
OTOH, leaving security policy like that up to pmu drivers sounds like a
really bad idea too.

Keep it as is I suppose, just me thinking out loud or so.

> +		return -EACCES;
> +
> +	return security_perf_event_open(attr, PERF_SECURITY_KERNEL);
> +}


