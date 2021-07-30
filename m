Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D54DC4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jul 2021 12:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23F7861059
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jul 2021 12:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238646AbhG3MUL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Jul 2021 08:20:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48042 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230355AbhG3MUK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jul 2021 08:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627647605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZpJdboMHeuxCJGy2Uim1DHCRXoke156ShhYeaCTcAvA=;
        b=eVKSxikRmYbb18iIsrQzjBnrsh0APE4CM130EDW6oLbtXBXLQSMFe2tl4WBPloP+/ORRL1
        0iOYt/i1s9FrWOZcdyMSEicdszQALLDWGZhddbvCJAs9KJBrB85mk2ZeYmMbopi4o+arpk
        AORIG4oErb1eCvhLUgCgeciyDMopFs8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-rEo64waWO6ilAr3M6reZUQ-1; Fri, 30 Jul 2021 08:20:03 -0400
X-MC-Unique: rEo64waWO6ilAr3M6reZUQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF0D7EC1A0
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jul 2021 12:20:02 +0000 (UTC)
Received: from Diego (unknown [10.39.208.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C23746;
        Fri, 30 Jul 2021 12:20:00 +0000 (UTC)
Date:   Fri, 30 Jul 2021 14:19:58 +0200 (CEST)
From:   Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To:     linux-perf-users@vger.kernel.org
cc:     Eirik Fuller <efuller@redhat.com>, acme@redhat.com,
        jolsa@redhat.com
Subject: Re: [PATCH] perf test: Handle fd gaps in test__dso_data_reopen
In-Reply-To: <alpine.LRH.2.20.2106301043550.27231@Diego>
Message-ID: <alpine.LRH.2.20.2107291608360.27231@Diego>
References: <20210626023825.1398547-1-efuller@redhat.com> <alpine.LRH.2.20.2106301043550.27231@Diego>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, 30 Jun 2021, Michael Petlan wrote:
> On Fri, 25 Jun 2021, Eirik Fuller wrote:
> > https://github.com/beaker-project/restraint/issues/215 describes a file
> > descriptor leak which revealed the test failure described here.
> > 
> > The 'DSO data reopen' perf test assumes that RLIMIT_NOFILE limits the
> > number of open file descriptors, but it actually limits newly opened
> > file descriptors. When the file descriptor limit is reduced, file
> > descriptors already open remain open regardless of the new limit. This
> > test failure does not occur if open file descriptors are contiguous,
> > beginning at zero.
> > 
> > The following command triggers this perf test failure.
> > 
> > perf test 'DSO data reopen' 3>/dev/null 8>/dev/null
> > 
> > This patch determines the file descriptor limit by opening four files
> > and then closing them. The limit is set to the fourth file descriptor,
> > leaving only the first three available because any newly opened file
> > descriptor must be less than the limit.
> > 
> > Signed-off-by: Eirik Fuller <efuller@redhat.com>
> 
> Acked-by: Michael Petlan <mpetlan@redhat.com>

Hi Arnaldo,
kindly reminder, could this get merged?

Thank you.

> 
> > ---
> >  tools/perf/tests/dso-data.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/tests/dso-data.c b/tools/perf/tests/dso-data.c
> > index 627c1aaf1c9e..43e1b01e5afc 100644
> > --- a/tools/perf/tests/dso-data.c
> > +++ b/tools/perf/tests/dso-data.c
> > @@ -308,10 +308,20 @@ int test__dso_data_cache(struct test *test __maybe_unused, int subtest __maybe_u
> >  	return 0;
> >  }
> >  
> > +static long new_limit(int count)
> > +{
> > +	int fd = open("/dev/null", O_RDONLY);
> > +	long ret = fd;
> > +	if (count > 0)
> > +		ret = new_limit(--count);
> > +	close(fd);
> > +	return ret;
> > +}
> > +
> >  int test__dso_data_reopen(struct test *test __maybe_unused, int subtest __maybe_unused)
> >  {
> >  	struct machine machine;
> > -	long nr_end, nr = open_files_cnt();
> > +	long nr_end, nr = open_files_cnt(), lim = new_limit(3);
> >  	int fd, fd_extra;
> >  
> >  #define dso_0 (dsos[0])
> > @@ -334,7 +344,7 @@ int test__dso_data_reopen(struct test *test __maybe_unused, int subtest __maybe_
> >  
> >  	/* Make sure we are able to open 3 fds anyway */
> >  	TEST_ASSERT_VAL("failed to set file limit",
> > -			!set_fd_limit((nr + 3)));
> > +			!set_fd_limit((lim)));
> >  
> >  	TEST_ASSERT_VAL("failed to create dsos\n", !dsos__create(3, TEST_FILE_SIZE));
> >  
> > -- 
> > 2.27.0
> > 
> > 
> 
> 

