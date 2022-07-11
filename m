Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805FAC433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 11 Jul 2022 12:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiGKMTt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 11 Jul 2022 08:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiGKMTt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 11 Jul 2022 08:19:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC04F10FCE;
        Mon, 11 Jul 2022 05:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1CaIHvL6+nEQiaxlPjcnhiQDIyPph3HufPUEFJD4tcs=; b=qjg7byljdhcZB8kF+/eLvqe5dL
        cH1rDfjnkhClhOZbLZJ4IhL+vcs8SDHIBOwePJnTD/Uajz5mhWGhGb31Q/9lh/yUHLf/gOHqb+KL6
        XHA0c1/of9Fpag0nVee6WlgehTKwOdHF2EJU8zRxy9w0vpPimSdl+r0DUKqmQNBBJ+y8yrBCMHshu
        tg2TYsKX+67Aj8dUB3HcNuTwBgpOnjPsxGWGRY/6ZUSvumRax33j13gwcHcjBGIoThgpZelfwXBch
        Sy+YVYibjcGZ5ggwnDFO8Eyx6vDPx2k03r69Vg48zF0KzO5dtAZfjFHoJLV836gZ6wu6EuYbCZZnX
        /40xKG/w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oAsO6-005wbz-42; Mon, 11 Jul 2022 12:19:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E321F3001F3;
        Mon, 11 Jul 2022 14:19:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8BB1020D264F2; Mon, 11 Jul 2022 14:19:39 +0200 (CEST)
Date:   Mon, 11 Jul 2022 14:19:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf/core: Add macros for possible
 sysctl_perf_event_paranoid values
Message-ID: <YswVWwwXi6zWaEAy@hirez.programming.kicks-ass.net>
References: <20220701063949.1769434-1-anshuman.khandual@arm.com>
 <b9da8d22-6896-68a3-b4e5-e8fd7b82b711@arm.com>
 <Ysgxzxl0N7+J8Vbt@worktop.programming.kicks-ass.net>
 <d03e334a-ec7e-cd87-7f0b-ac7564266d3a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d03e334a-ec7e-cd87-7f0b-ac7564266d3a@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jul 11, 2022 at 02:55:12PM +0530, Anshuman Khandual wrote:
> Enumerating [-1, 0, 1, 2] paranoid range values in kernel too, does not add
> much value as well ?

That's what the user-interface requires as well. How is obscuring the
values the user has to explicitly poke in help things?
