Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94697C4338F
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 18:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DFAA61186
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 18:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237269AbhHFSVF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 Aug 2021 14:21:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232144AbhHFSVF (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Aug 2021 14:21:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCBF361179;
        Fri,  6 Aug 2021 18:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628274048;
        bh=4dzvj1LJ8CUwWcLu3xUW7Kz4Lrg9+BzX0Dekc45jKQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SCL62wQ4kzQMkUSV9Ebq/cAzJHzGySUKmE13GsaVqvuI2zqNv4Qt3L4M/QdzdMfrn
         oXHWS1C+3SSK0kjg3YhDgf0z+hh4mCuj4ggM0MO1oBwL38Ua6hDt2kdIyGDeAuwwUN
         lP0zOSQxyX4KaDjqjYoRaZLGyyBh46O6iLA84cfRdpV+telDKqmrvsmBwO1tTi3WWy
         HdisDQvZZwp5xRVYAXreZEjuN1bnmW2EPl6ABQz1JKyA7EIRK5XExbu5GmBRFjwCLj
         lEfvgaMYVZndMQYo73jri/GaMc21BocFis6NYIsMsEFhudykEMiho4nAv6dKI+xVO1
         5yv3+qPkq2XhA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C8926403F2; Fri,  6 Aug 2021 15:20:45 -0300 (-03)
Date:   Fri, 6 Aug 2021 15:20:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>, "Jin, Yao" <yao.jin@intel.com>
Subject: Re: [PATCH v4] perf vendor events: Add metrics for Icelake Server
Message-ID: <YQ19fS3NkkLkDaKz@kernel.org>
References: <20210806075404.31209-1-yao.jin@linux.intel.com>
 <CAP-5=fVQBDtt4aDVvbB+u663QGihMcajePAMh+rTk_sRFvd32A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVQBDtt4aDVvbB+u663QGihMcajePAMh+rTk_sRFvd32A@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Aug 06, 2021 at 01:16:57AM -0700, Ian Rogers escreveu:
> On Fri, Aug 6, 2021, 12:55 AM Jin Yao <yao.jin@linux.intel.com> wrote:
> >
> > Add JSON metrics for Icelake Server to perf.
> >
> > Based on TMA metrics 4.21 at 01.org.
> > https://download.01.org/perfmon/
> >
> > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > Reviewed-by: Andi Kleen <ak@linux.intel.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

