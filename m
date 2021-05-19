Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3FEC433B4
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 17:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C0F66124C
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 17:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355459AbhESRUF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 May 2021 13:20:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242519AbhESRUF (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 May 2021 13:20:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68DB0611BF;
        Wed, 19 May 2021 17:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621444725;
        bh=P2cFRK+r8KNGRdThzlW/+mPJHBEppUh2xmYFaaiXpps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d9sdZo2ySCCQR27VWZvLKQt7eozS5PcmCD5Z41mD6Ae2Pk/vwha7W77nxr5WzvbOt
         0wvG55UkhTzK4N74mCDJn8JayJvY+o8HbrqDcwOGyJU3nR6/nPk7VQ6VDJrO2fvqAM
         VqC3asHDq1L5HNd4Ghy99SX7oGqKZRXBWdVa5imdkTDPIdSIISMWoyj4vhq43ZF4mv
         rnzRA/Oh+44dC1y5RZY/dx+rz+p5BAdB/Hy9RIMAyaGfNJHITDtMeXMK61M2A6BKMB
         ietRLaZ+Zdosy3FwZ+ebfzNfrgzFHrsW7UJ9HsrPrVU2gFa7t9MfDNcKMLMljl+AsD
         ovIZRFgZXkJxg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 321DE41084; Wed, 19 May 2021 14:18:42 -0300 (-03)
Date:   Wed, 19 May 2021 14:18:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: perf list dumps core using 5.13.0.rc2
Message-ID: <YKVIciYdoooQNfsS@kernel.org>
References: <555b92bd-1884-58a7-76fd-7dd197978436@linux.ibm.com>
 <CAP-5=fX_+GY38s0imLNDzq9_xjn3qiGC0pFEpSV1U-TzF_UoMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fX_+GY38s0imLNDzq9_xjn3qiGC0pFEpSV1U-TzF_UoMg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, May 19, 2021 at 09:27:14AM -0700, Ian Rogers escreveu:
> On Wed, May 19, 2021 at 7:57 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> >
> > Using kernel 5.13.0.rc2 command perf list dumps core on my x86
> > virtual machine:
> >
> > [root@f34 perf]# ./perf list
> > Segmentation fault (core dumped)
> > ^C
> > [root@f34 perf]#
> >
> > The root case this this change in file ../include/uapi/linux/perf_event.h:
> > enum perf_sw_ids {
> >         PERF_COUNT_SW_CPU_CLOCK                 = 0,
> >         ...
> >  --->   PERF_COUNT_SW_CGROUP_SWITCHES           = 11,
> >
> >         PERF_COUNT_SW_MAX,                      /* non-ABI */
> > };
> >
> > This change increases PERF_COUNT_SW_MAX to 12. However this
> > change is not reflected in file util/parse-events.c where data structure
> >
> > struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
> >         ....
> > }
> >
> > is defined and it misses the symbol name and alias for this new software
> > event. So when command 'perf list' is called, the call chain sequence
> > is
> >   cmd_list()
> >     print_events()
> >       print_symbol_events(event_glob, PERF_TYPE_SOFTWARE,
> >                           event_symbols_sw, PERF_COUNT_SW_MAX, name_only);
> >
> > where PERF_COUNT_SW_MAX is 12 and  structure event_symbols_sw[] contains
> > only 11 elements. This ends up with the last element of the array being
> > all zeroes and the line:
> >
> >     if (!name_only && strlen(syms->alias))
> >
> > dumps core because syms->alias is a NULL pointer.
> >
> > Is this dummy event PERF_COUNT_SW_CGROUP_SWITCHES simply missing in the
> > event_symbols_sw[] array or is there more to it (which I am missing).
> >
> > Thanks.
> >
> > PS: I can sent a patch if needed....
> 
> I believe Namhyung's pending change will fix this:
> https://lore.kernel.org/lkml/20210210083327.22726-3-namhyung@kernel.org/

Ok, I'll pick that one instead of the one I did, similar one.

- Arnaldo
