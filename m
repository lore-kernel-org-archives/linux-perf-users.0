Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532C6C77B75
	for <linux-perf-users@archiver.kernel.org>; Fri,  5 May 2023 08:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjEEIaK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 5 May 2023 04:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjEEI25 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 5 May 2023 04:28:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4101814A
        for <linux-perf-users@vger.kernel.org>; Fri,  5 May 2023 01:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wtsT3el5XQOB42nPQ1QzQK95akpe5aJoeY1XXGifUlk=; b=EhsV2DSIxQnxOMhVgsm/AjWHqC
        prpu+2dA39KT7zuiNXcN8Ak8MyDo8Ub7VFW8vpexuSuFfL0CksQnLmv//YXwIfnGmxOBdNy2YbTkP
        t1ZWboGPH3y0+ivX0xFa+Eft4BwSVNlZliMno4j0fpMpHkSDgDe7DTz3ReBedwlN2uxv2cT0lDkQQ
        /Zed7bP8hSFdbs9lP4LUhu1SnnOkeJ4/I5RcPhzswrJ95tsWnOknPXtmB15axyXQdGtxZykjo2uQn
        2XmxX7mRzYYr4/AFShFbaXlBE4b+K8SpA3oI4fHEZh/7MpXHEQYZb6h06otKOfi5Nj4FW4eoosKIA
        xEY3Ky4Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1puqnq-003CIN-2y;
        Fri, 05 May 2023 08:28:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1301A300635;
        Fri,  5 May 2023 10:28:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E7FB723CC0167; Fri,  5 May 2023 10:28:32 +0200 (CEST)
Date:   Fri, 5 May 2023 10:28:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ian Rogers <irogers@google.com>
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: uapi vs kernel headers
Message-ID: <20230505082832.GA1770668@hirez.programming.kicks-ass.net>
References: <CAP-5=fXKi+VAr-_n5tAaJ7Z2fvU7jc5N-CKCjkCAh_01_pzMfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXKi+VAr-_n5tAaJ7Z2fvU7jc5N-CKCjkCAh_01_pzMfA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, May 04, 2023 at 03:36:48PM -0700, Ian Rogers wrote:
> Hi,
> 
> when the C compiler builds perf the priority of the "-I" flags is left
> to right. This means that in the perf build:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/Makefile.config?h=perf-tools-next#n355
> if the build is looking for <linux/types.h> then whereas most projects
> would expect that to come from /usr/include/linux/types.h (which
> matches the uapi version) perf actually builds with the kernel version
> (tools/include/linux/types.h). The kernel version will declare types
> like u64 that are __u64 in the uapi code, so reversing the include
> order massively breaks the build as u64 and many associated types are
> missing.
> 
> It almost feels accidental that perf does things this way, and it
> feels more obvious if perf were to reverse the include order and deal
> with the fall-out in the code (ie perf's linux/types.h would agree
> more with what normal projects have). Perhaps perf needs its own
> types.h to minimize the fallout. I wondered what more general opinions
> on this were? Is this something that should be fixed?

Doesn't perf have to prioritize the kernel headers because it needs the
latest version of the perf uapi -- and not some random old version the
system headers might have?
