Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08214C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Sep 2021 16:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF1586162E
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Sep 2021 16:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351345AbhI3Qc1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 30 Sep 2021 12:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351304AbhI3QcY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Sep 2021 12:32:24 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED18C06176A
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Sep 2021 09:30:41 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s75so6838343pgs.5
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Sep 2021 09:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ciyh0EVHcl3WRsnW2ZREWfVT9JlEKA9hfP6r96v0iyo=;
        b=KLa5TC+QH0mRltEWVuTIoKEr3I5WlJ5ps07gPtG+fFyGEdV1U/dfQymhN/OCTfFMB9
         Y7+88FcoTDrTJg23LJDHozJMKKBrw1K+Cf1qDSuKJe+iDC2e4yju2MKv7h+5KATiNn51
         0z+EpCXkz4hgoHRq2xu2wdBaorGBdI+Cw8KN08f2UQfJlPBfTclLpIjTHLKaIMhCUz1F
         B+TvY7+bfat4KzRY/LvcdNCxOYpJD0qZUuZI0K4VtD+g1iLDQrTqBm2oSCndAtEeQStQ
         AFKlCWAbvVu1NDaQ251VibzsX3vBLQtFql8481C2fo8BdtOorsLXcCp6Ce7kavuT+nro
         WpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ciyh0EVHcl3WRsnW2ZREWfVT9JlEKA9hfP6r96v0iyo=;
        b=mUyYEHHTocuFisjoMTXl2r7ZsyC2uPyMfqd+cFoPLcrf7h6sBZz1B1EO8ru22X29H7
         rgxADXWFsW99q0HRR/C1QHaThi9DdO3xMjVbsJm2fnJzEz2nQg/7ujCG9S8ad7hElFlr
         0T44rYwaAieublB7qlrOcDIWhrPiCy8wCtRFFm5c/0A09WiAn5ZDln6FMdzfnzVQ+/Ec
         DibCq2pRIFPapAxCfml08zyEqieFsBBsa2yiSqydXVZx25xLOVMH9PtpsSKSUCpcT+K/
         hm8pwz9tM9ewil5TNpHa/3NShC4ctAmEhmMw8Ln7MMohAvYicExoIj4l3MX4lzZpnGvo
         5C1A==
X-Gm-Message-State: AOAM531kqximYKQRw3zrazf1dOo6fAhRajYAfxXks3W2IW3Rf34eUZSh
        wZi4jfwUKP19iPWyiNrkMs/WLLRv937fLg==
X-Google-Smtp-Source: ABdhPJwypV3JkcUF52yFwFeC0CYHKTJzN0cIsYLiSO0D2ExL+no2wARl/7UePGspmFaRIyeVnclmmw==
X-Received: by 2002:a62:1d4d:0:b0:443:eac2:8a1b with SMTP id d74-20020a621d4d000000b00443eac28a1bmr5281219pfd.2.1633019440914;
        Thu, 30 Sep 2021 09:30:40 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id 127sm3663367pfw.10.2021.09.30.09.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 09:30:39 -0700 (PDT)
Date:   Thu, 30 Sep 2021 10:30:37 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Subject: Re: [PATCH 1/5] perf cs-etm: Print size using consistent format
Message-ID: <20210930163037.GA3047827@p14s>
References: <20210916154635.1525-1-german.gomez@arm.com>
 <20210923162434.GA2189675@p14s>
 <67a54101-a514-6077-96ba-8809226181eb@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67a54101-a514-6077-96ba-8809226181eb@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Sep 30, 2021 at 01:09:16PM +0100, German Gomez wrote:
> Hi Mathieu,
> 
> Thanks for your feedback. I will keep these points in mind for future
> submissions.
> 
> On 23/09/2021 17:24, Mathieu Poirier wrote:
> > Hi German,
> > 
> > On Thu, Sep 16, 2021 at 04:46:31PM +0100, German Gomez wrote:
> > > [...]
> > Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > 
> > A couple of things to improve for your next interactions with the Linux community:
> > 
> > 1) Using a cover letter, even for small changes, is always a good idea.
> > 2) RB tags should be picked up publicly rather than done internally and added to
> > a patchset.
> > 3) Keep patches semantically grouped.  Here patches 04 and 05 have nothing to do
> > with 01, 02 and 03.
> Did you perhaps mean separating 01 and 02 from the rest? I grouped 03 to 05
> because
> they were related to snapshot mode.

Yes - you are correct.  It should have been 01 and 02 in one set and the rest in
another set.

> 
> Thanks,
> German
> 
> > 
> > Moreover Arnaldo queues changes to the perf tools but I don't see him CC'ed to
> > this patchset.  As such he will not see your work.  Ask James about how to
> > proceed when submitting patches to the perf tools.
> > 
> > Thanks,
> > Mathieu
> > 
> > >   		     cs_etm_decoder__get_name(etmq->decoder), buffer->size);
> > >   	do {
> > > -- 
> > > 2.17.1
> > > 
