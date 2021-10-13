Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7902BC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 14:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6211A610CB
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 14:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhJMOUH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Oct 2021 10:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235899AbhJMOUH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Oct 2021 10:20:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC0DC061570;
        Wed, 13 Oct 2021 07:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cw9LX5oWo3jXEpGn2jFKdqP5yDiuWs/4Uz5XhmZ11ls=; b=OuoxBzOQZpfQCxF47k6MCjjrP1
        DJ1J8ECPRGByre5xlA4B8SaFF2UKeVnVm80YRhlvMcp9nlAdHhXVaASweUhSFPe+9LyV6tEwm8a/U
        jXbpWn6BaGL8/16aivnJvzvQ3TLuuWqReXqPaosXb6aniyIQXnx7imi5CYdbi9kZON9yP5P+susqT
        xp+6zbyRN36HtpS2xonzWfrVcLsYV+4FtnihYyUrCEjZWRF8S50WYMjWRraImSImTu+F/P1AB/FBM
        hSvszM5lnv4FicOPEIE1ngXhzE+b+MQAqRa+o4nvGZefKxjVbOemEK9qHifSh1LfoPs4Vu8dcwb6/
        FHMazyfw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maf4p-009chw-LE; Wed, 13 Oct 2021 14:17:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C439430026A;
        Wed, 13 Oct 2021 16:17:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AD38C2CA86B38; Wed, 13 Oct 2021 16:17:49 +0200 (CEST)
Date:   Wed, 13 Oct 2021 16:17:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/3] perf/x86: Add new event for AUX output counter
 index
Message-ID: <YWbqjfPVx7AjSe5o@hirez.programming.kicks-ass.net>
References: <20210907163903.11820-1-adrian.hunter@intel.com>
 <20210907163903.11820-2-adrian.hunter@intel.com>
 <ab6f9ec2-2571-de5a-d44a-427851b08d19@linux.intel.com>
 <20210910160409.GI4323@worktop.programming.kicks-ass.net>
 <453b9364-c350-79ca-00fa-b9e6ed6e3367@linux.intel.com>
 <9da4ae5e-3e0e-180e-5bba-1351c08d7df9@intel.com>
 <87k0j7hzaw.fsf@ashishki-desk.ger.corp.intel.com>
 <3211feb9-b8e3-21fc-958c-07c7c7766bf2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3211feb9-b8e3-21fc-958c-07c7c7766bf2@intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Oct 13, 2021 at 12:12:48PM +0300, Adrian Hunter wrote:

> Will anyone takes these patches?  Perhaps Arnaldo if no one objects?
> The patches still seem to apply cleanly.

I've picked up the first. But if acme wants to route the whole lot:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

