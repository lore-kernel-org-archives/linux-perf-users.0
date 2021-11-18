Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D02C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Nov 2021 13:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8341461ABA
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Nov 2021 13:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbhKRNTe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 18 Nov 2021 08:19:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:56806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229461AbhKRNTc (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 18 Nov 2021 08:19:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF06D61547;
        Thu, 18 Nov 2021 13:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637241392;
        bh=cPAF16SBowIODw3FuSRAWX7tX6zRNrTh0gOArqArR3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RSm5pTiT3O/wUDfsCjlTZdHBV5UfpO96wvxn7Q7+Iw9l9QKuyspXNo6u/MxH5NnS2
         72O4JdM3Lr9E3pUdHAW1NIJ/AeH2DwsJ+PrRALv6PAyZR9vsMAByS1ycaGIcDRWuDI
         +8D6zQ2ISq6yAtHRwIhF8k1FrAEKLwmPfNz2MTQb9IqLz3rRpZHLFfsLqIJ/Tq3I9n
         vVuV/7IuLJ0AucmFhKU4amWHUXl5o2bNWDVWfoSceIDT5lJDXBCIHFFfUwh/SPIXZY
         /TPPTlPByX0uluyS8Gh3y6W4AQ6UqYXvy1syKPhMgQydU2isKj6AtbajkSM2gz2J3N
         e/aOC+CP14hvg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E63424088E; Thu, 18 Nov 2021 10:16:30 -0300 (-03)
Date:   Thu, 18 Nov 2021 10:16:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kajoljain <kjain@linux.ibm.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf hist: Fix memory leak of a perf_hpp_fmt
Message-ID: <YZZSLlhHjuDz8sSu@kernel.org>
References: <20211118071247.2140392-1-irogers@google.com>
 <b4ad6246-b402-ebe7-d35a-2f485dccbaf4@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4ad6246-b402-ebe7-d35a-2f485dccbaf4@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Nov 18, 2021 at 01:28:11PM +0530, kajoljain escreveu:
> 
> 
> On 11/18/21 12:42 PM, Ian Rogers wrote:
> > perf_hpp__column_unregister removes an entry from a list but doesn't
> > free the memory causing a memory leak spotted by leak sanitizer. Add the
> > free while at the same time reducing the scope of the function to
> > static.
> 
> Patch looks good to me.
> 
> Reviewed-by: Kajol Jain<kjain@linux.ibm.com>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Kajol jain
> 
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/ui/hist.c   | 28 ++++++++++++++--------------
> >  tools/perf/util/hist.h |  1 -
> >  2 files changed, 14 insertions(+), 15 deletions(-)
> > 
> > diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
> > index c1f24d004852..5075ecead5f3 100644
> > --- a/tools/perf/ui/hist.c
> > +++ b/tools/perf/ui/hist.c
> > @@ -535,6 +535,18 @@ struct perf_hpp_list perf_hpp_list = {
> >  #undef __HPP_SORT_ACC_FN
> >  #undef __HPP_SORT_RAW_FN
> >  
> > +static void fmt_free(struct perf_hpp_fmt *fmt)
> > +{
> > +	/*
> > +	 * At this point fmt should be completely
> > +	 * unhooked, if not it's a bug.
> > +	 */
> > +	BUG_ON(!list_empty(&fmt->list));
> > +	BUG_ON(!list_empty(&fmt->sort_list));
> > +
> > +	if (fmt->free)
> > +		fmt->free(fmt);
> > +}
> >  
> >  void perf_hpp__init(void)
> >  {
> > @@ -598,9 +610,10 @@ void perf_hpp_list__prepend_sort_field(struct perf_hpp_list *list,
> >  	list_add(&format->sort_list, &list->sorts);
> >  }
> >  
> > -void perf_hpp__column_unregister(struct perf_hpp_fmt *format)
> > +static void perf_hpp__column_unregister(struct perf_hpp_fmt *format)
> >  {
> >  	list_del_init(&format->list);
> > +	fmt_free(format);
> >  }
> >  
> >  void perf_hpp__cancel_cumulate(void)
> > @@ -672,19 +685,6 @@ void perf_hpp__append_sort_keys(struct perf_hpp_list *list)
> >  }
> >  
> >  
> > -static void fmt_free(struct perf_hpp_fmt *fmt)
> > -{
> > -	/*
> > -	 * At this point fmt should be completely
> > -	 * unhooked, if not it's a bug.
> > -	 */
> > -	BUG_ON(!list_empty(&fmt->list));
> > -	BUG_ON(!list_empty(&fmt->sort_list));
> > -
> > -	if (fmt->free)
> > -		fmt->free(fmt);
> > -}
> > -
> >  void perf_hpp__reset_output_field(struct perf_hpp_list *list)
> >  {
> >  	struct perf_hpp_fmt *fmt, *tmp;
> > diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> > index 5343b62476e6..621f35ae1efa 100644
> > --- a/tools/perf/util/hist.h
> > +++ b/tools/perf/util/hist.h
> > @@ -369,7 +369,6 @@ enum {
> >  };
> >  
> >  void perf_hpp__init(void);
> > -void perf_hpp__column_unregister(struct perf_hpp_fmt *format);
> >  void perf_hpp__cancel_cumulate(void);
> >  void perf_hpp__setup_output_field(struct perf_hpp_list *list);
> >  void perf_hpp__reset_output_field(struct perf_hpp_list *list);
> > 

-- 

- Arnaldo
