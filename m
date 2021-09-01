Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC04C432BE
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Sep 2021 13:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 967BD6069E
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Sep 2021 13:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244290AbhIANhk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 1 Sep 2021 09:37:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242520AbhIANhk (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Sep 2021 09:37:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E926260698;
        Wed,  1 Sep 2021 13:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630503403;
        bh=iWV/crwUlweYuuVzke2dYQ+pYgqthMaN8n3LIPnihbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BdiHgCUqNRrhyv6XKd5+/JLMD6es+hkGOHRglz2ISAKzz1WJ6fFLM9bxgWtayYBly
         8eOIJ5JYl0e5OjH7S2HC0ZOJ3TmBWtfEFAK9bzsoItXdJ/6eD3LWEY4VMDXpwWdz+T
         NWAeOKA7uONcCYe6pL86dtFeIFoEkWdWCOxTiJv+sACk//43I1//GsMsACtncQCX7O
         rGbts6KA2/cP8GI4ZXjV15kftYxQ3si7jY3Ztu6csnhhLM0wr6tKemaGos9XJKNXvP
         ZHso8+2YvhzWn3s6qiiKKhw16kmb6nap7OiLhncal5CTFr9AGCMDv7tNYkrw7PXTbr
         8LRonnY0A3VdQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 881B04007E; Wed,  1 Sep 2021 10:36:40 -0300 (-03)
Date:   Wed, 1 Sep 2021 10:36:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nakamura Shun <nakamura.shun@fujitsu.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: libperf: lack of interface
Message-ID: <YS+B6PVHtiTmqZS+@kernel.org>
References: <OSBPR01MB460016842A4310264B1CC5A0F7CD9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB460016842A4310264B1CC5A0F7CD9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Sep 01, 2021 at 09:45:10AM +0000, nakamura.shun@fujitsu.com escreveu:
> Hello.
> 
> I'm trying to change rdpmc test in perf_event_tests[1] to use libperf, but libperf doesn't have enough interfaces.
> Does anyone plan to implement any of these libperf features?
> 
> - Interfaces that can run ioctl (PERF_EVENT_IOC_RESET) from userland
> - Interfaces that can run fcntl (SIGIO) from userland
> 
> [1] https://github.com/deater/perf_event_tests/tree/master/tests/rdpmc

So, while in this specific case you should probably follow PeterZ's
advice, feel free to submit patches moving stuff that is in
tools/perf/util/ to tools/lib/perf/ (libperf) when you have a reasonable
use case, such as Vince's test suite.

We can then discuss if any adjustment is needed, but doing it this
piecemeal way, with justification, should be a good way to enrich
libperf with things that are in quiescent state in tools/perf/util/ and
that have external users.

Thanks,

- Arnaldo
