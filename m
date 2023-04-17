Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC89DC77B70
	for <linux-perf-users@archiver.kernel.org>; Mon, 17 Apr 2023 11:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjDQLFC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 17 Apr 2023 07:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjDQLEv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 17 Apr 2023 07:04:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28967EFA;
        Mon, 17 Apr 2023 04:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CmUMYWJumzC4QK/ilEvYwuU3CWm6HOdwzIyko3EpK6Y=; b=dW/diDIHM1rqsAukLeo9a6UU1M
        03PFy1w3O8OT0p+pc094e9hZG2AmSn5A5P40aOT3ib+U+g0GEUKAUHttKV5b1KRaDkIHghRSzjqM6
        E+SH3soezQXg/0zrqw6OmI6kVp+0b4IF4FZ5pCQjpqvpWJnfm8S0HfpQe+ui1xSEXBKuERwP/lEkj
        lhgaEvSg3TwsqCE972QA8VRf16Lc+UTDZTdWfwMT8ccoiUq38l/TaTk9J2kYrsXKtdnO5JaEKpWPB
        P+8iIKUvGtoP8NzupqwC/XttVL22/caGgXPLJ+wazsJN65xerzqXVDXivH25VEJdJ1j2dsf7pTNI/
        K8tnmy3g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1poMcp-00BGhi-1L; Mon, 17 Apr 2023 11:02:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 141E33001E5;
        Mon, 17 Apr 2023 13:02:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E6E6524248706; Mon, 17 Apr 2023 13:02:21 +0200 (CEST)
Date:   Mon, 17 Apr 2023 13:02:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/5] perf: Add ioctl to emit sideband events
Message-ID: <20230417110221.GH83892@hirez.programming.kicks-ass.net>
References: <20230414082300.34798-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414082300.34798-1-adrian.hunter@intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Apr 14, 2023 at 11:22:55AM +0300, Adrian Hunter wrote:
> Hi
> 
> Here is a stab at adding an ioctl for sideband events.
> 
> This is to overcome races when reading the same information
> from /proc.

What races? Are you talking about reading old state in /proc the kernel
delivering a sideband event for the new state, and then you writing the
old state out?

Surely that's something perf tool can fix without kernel changes?
