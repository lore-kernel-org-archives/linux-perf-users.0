Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B53EC47082
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Jun 2021 17:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE4FF6135A
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Jun 2021 17:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbhFHRG1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Jun 2021 13:06:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231840AbhFHRG1 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Jun 2021 13:06:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B2476128A;
        Tue,  8 Jun 2021 17:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623171874;
        bh=Vh7B4IpJWK/m3y21Xlv8HM56Ph39nLhlyenrrvJRXLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NX4FEgBJckjzHurPNZOE28t7m6h85/pAZhpXLLG9kTpfHpwbmAD58IXv9sZu+0j1O
         PijzT52nuKq8JtAoU7c7iy/sgWt08A9LJ0zK6k2oYNR5eJZ5ucAIN9+LxzMqwFd7Oe
         utdrwzFvJZI21RhMrGwSoB7mtRzSkMto/qG83CxZ7WNlHp7g2P/xR3pvZYXBFPDdRx
         Z4cpR6VaDqLTXNNEghOvvOyC3g5jBYCeECqdTfc1aLgkQYaqgX4gEeVUdAMQNZBi7+
         DWIHBeE672fi/RWEhDmilTVi/6I6QZbSpT6lsz4DS5EfGWrdZ0DhzcafU1j25KZHNl
         yJlkxq9rW04iA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3E67640B1A; Tue,  8 Jun 2021 14:04:30 -0300 (-03)
Date:   Tue, 8 Jun 2021 14:04:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Leo Yan <leo.yan@linaro.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 7/8] perf auxtrace: Use WRITE_ONCE() for updating
 aux_tail
Message-ID: <YL+jHu4c5rLkKb9i@kernel.org>
References: <20210602103007.184993-1-leo.yan@linaro.org>
 <20210602103007.184993-8-leo.yan@linaro.org>
 <YL47tdD0ygaErZu+@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL47tdD0ygaErZu+@hirez.programming.kicks-ass.net>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Jun 07, 2021 at 05:31:01PM +0200, Peter Zijlstra escreveu:
> On Wed, Jun 02, 2021 at 06:30:06PM +0800, Leo Yan wrote:
> > Use WRITE_ONCE() for updating aux_tail, so can avoid unexpected memory
> > behaviour.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Leo, this one is dependendant on the 6/8, will wait for a resubmission,
keeping 5/8 tho, as was Acked and applies cleanly, perf/core.
 
> > ---
> >  tools/perf/util/auxtrace.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> > index e625bc76cdde..abc4282f5272 100644
> > --- a/tools/perf/util/auxtrace.h
> > +++ b/tools/perf/util/auxtrace.h
> > @@ -458,7 +458,7 @@ static inline void auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
> >  
> >  	/* Ensure all reads are done before we write the tail out */
> >  	smp_mb();
> > -	pc->aux_tail = tail;
> > +	WRITE_ONCE(pc->aux_tail, tail);
> >  }
> >  
> >  int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
> > -- 
> > 2.25.1
> > 

-- 

- Arnaldo
