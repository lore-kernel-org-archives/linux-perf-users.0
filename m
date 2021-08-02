Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97B9C4338F
	for <linux-perf-users@archiver.kernel.org>; Mon,  2 Aug 2021 13:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C88AD60FC4
	for <linux-perf-users@archiver.kernel.org>; Mon,  2 Aug 2021 13:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbhHBNCu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 2 Aug 2021 09:02:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233645AbhHBNCu (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 2 Aug 2021 09:02:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80FFC60F6E;
        Mon,  2 Aug 2021 13:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627909360;
        bh=fcfWbj3npt+uCK8+dnLFYbFZCC+I3+WZAGCvZ3EGM/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N1rvWlXlOlznSynVcjcdhISAk3sMbr60mj2b5B4ASPNjB1z+dMGwnbsbC/wNVuGKC
         HypsgxEvLQW7dbL+GABaUIz05hoet+OJ/CONRzCSNTGbAYEjmAPgmZEY7AUEHqDruX
         bgRfpza7sdO3RtKNZbiuvbesjtF0ph7tpW5cBHBGzdMpR+Zqb3NYLTUtavdiBqeIiZ
         S4Z2ZEZ6R11btJlmsqfLXJQv7tbeVaohSIE8yD0VhjLkS3FIpfVfnrI9HYQ2x4U6Y5
         jeC4TSuda4rlW09R7OSWJ0aEITsi9+Y/wdUMPiU/dHPoXUZERgcq+6gqJi2q4uu+a3
         cF8OZCfviaTog==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 12FB7403F2; Mon,  2 Aug 2021 10:02:38 -0300 (-03)
Date:   Mon, 2 Aug 2021 10:02:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Michael Petlan <mpetlan@redhat.com>
Cc:     linux-perf-users@vger.kernel.org,
        Eirik Fuller <efuller@redhat.com>, acme@redhat.com,
        jolsa@redhat.com
Subject: Re: [PATCH] perf test: Handle fd gaps in test__dso_data_reopen
Message-ID: <YQfs7keCFz6P9Oen@kernel.org>
References: <20210626023825.1398547-1-efuller@redhat.com>
 <alpine.LRH.2.20.2106301043550.27231@Diego>
 <alpine.LRH.2.20.2107291608360.27231@Diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.20.2107291608360.27231@Diego>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Jul 30, 2021 at 02:19:58PM +0200, Michael Petlan escreveu:
> On Wed, 30 Jun 2021, Michael Petlan wrote:
> > On Fri, 25 Jun 2021, Eirik Fuller wrote:
> > > https://github.com/beaker-project/restraint/issues/215 describes a file
> > > descriptor leak which revealed the test failure described here.
> > > 
> > > The 'DSO data reopen' perf test assumes that RLIMIT_NOFILE limits the
> > > number of open file descriptors, but it actually limits newly opened
> > > file descriptors. When the file descriptor limit is reduced, file
> > > descriptors already open remain open regardless of the new limit. This
> > > test failure does not occur if open file descriptors are contiguous,
> > > beginning at zero.
> > > 
> > > The following command triggers this perf test failure.
> > > 
> > > perf test 'DSO data reopen' 3>/dev/null 8>/dev/null
> > > 
> > > This patch determines the file descriptor limit by opening four files
> > > and then closing them. The limit is set to the fourth file descriptor,
> > > leaving only the first three available because any newly opened file
> > > descriptor must be less than the limit.
> > > 
> > > Signed-off-by: Eirik Fuller <efuller@redhat.com>
> > 
> > Acked-by: Michael Petlan <mpetlan@redhat.com>
> 
> Hi Arnaldo,
> kindly reminder, could this get merged?

Thanks, applied. Sorry for the delay.

- Arnaldo

 
> Thank you.
> 
> > 
> > > ---
> > >  tools/perf/tests/dso-data.c | 14 ++++++++++++--
> > >  1 file changed, 12 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tools/perf/tests/dso-data.c b/tools/perf/tests/dso-data.c
> > > index 627c1aaf1c9e..43e1b01e5afc 100644
> > > --- a/tools/perf/tests/dso-data.c
> > > +++ b/tools/perf/tests/dso-data.c
> > > @@ -308,10 +308,20 @@ int test__dso_data_cache(struct test *test __maybe_unused, int subtest __maybe_u
> > >  	return 0;
> > >  }
> > >  
> > > +static long new_limit(int count)
> > > +{
> > > +	int fd = open("/dev/null", O_RDONLY);
> > > +	long ret = fd;
> > > +	if (count > 0)
> > > +		ret = new_limit(--count);
> > > +	close(fd);
> > > +	return ret;
> > > +}
> > > +
> > >  int test__dso_data_reopen(struct test *test __maybe_unused, int subtest __maybe_unused)
> > >  {
> > >  	struct machine machine;
> > > -	long nr_end, nr = open_files_cnt();
> > > +	long nr_end, nr = open_files_cnt(), lim = new_limit(3);
> > >  	int fd, fd_extra;
> > >  
> > >  #define dso_0 (dsos[0])
> > > @@ -334,7 +344,7 @@ int test__dso_data_reopen(struct test *test __maybe_unused, int subtest __maybe_
> > >  
> > >  	/* Make sure we are able to open 3 fds anyway */
> > >  	TEST_ASSERT_VAL("failed to set file limit",
> > > -			!set_fd_limit((nr + 3)));
> > > +			!set_fd_limit((lim)));
> > >  
> > >  	TEST_ASSERT_VAL("failed to create dsos\n", !dsos__create(3, TEST_FILE_SIZE));
> > >  
> > > -- 
> > > 2.27.0
> > > 
> > > 
> > 
> > 
> 

-- 

- Arnaldo
