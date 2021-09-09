Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5515C4332F
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 13:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE1B961051
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 13:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355314AbhIINWj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 09:22:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355931AbhIINNp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Sep 2021 09:13:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53B4A61026;
        Thu,  9 Sep 2021 12:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631191435;
        bh=gf1Yz38pjEQr8uqcMRj5Uui/wZpMgHr/zcx66eFUvnQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZxMwoZkHXdESQvUHu89vdEwrV85LgIwdz9w54Vz6ksmdyhOEvm21Uh+q/ciR+rg5+
         ZQKIPRsA6qXH7aqwkCjj+GVUp9pcXeJ8FqwZSeACU/Wu4qf+3SViOWybJewGhRIN1R
         WL9iuf+HDFIHhJXMy36NggdHSZeYxb2JR3fzAuS6gVHnOcD9TD1tkL/4Kbog2ezzAD
         X/jmi2Vs1XSr5GoA9lFRND1s6MzRZo51WWKzybpY4YJtDhsOQZ813pkyHxhIo5XGIo
         Aq55YvEYSZSAKHB9VEa2gtTg3Vm/JYqSdPW6lhnDquletgjTB86mD+hwUMBPKrqpjN
         LXWnnQTlZOEtQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E4F014038F; Thu,  9 Sep 2021 09:43:52 -0300 (-03)
Date:   Thu, 9 Sep 2021 09:43:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Michael Petlan <mpetlan@redhat.com>
Cc:     acme@redhat.com, linux-perf-users@vger.kernel.org,
        jolsa@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH] perf scripts python: fix passing arguments to
 stackcollapse report
Message-ID: <YToBiGjqMP9wVKpQ@kernel.org>
References: <20200427142327.21172-1-mpetlan@redhat.com>
 <alpine.LRH.2.20.2109061615390.27231@Diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.20.2109061615390.27231@Diego>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Sep 06, 2021 at 04:16:21PM +0200, Michael Petlan escreveu:
> Hi Arnaldo, could you merge this?
> It seems still valid.

Next time please reply to the original patch, that way b4 will find it
from the Message-ID from your reply message.

I'm digging it from my inboxes, thanks for resending!

- Arnaldo
 
> Thank you.
> Michael
> 
> 
> On Mon, 27 Apr 2020, Michael Petlan wrote:
> > The '--' prevented arguments from being passed to the script, such as:
> > 
> >   $ perf script report stackcollapse -i my_perf.data
> > 
> > Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> > ---
> >  tools/perf/scripts/python/bin/stackcollapse-report | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/scripts/python/bin/stackcollapse-report b/tools/perf/scripts/python/bin/stackcollapse-report
> > index 356b9656393d..21a356bd27f6 100755
> > --- a/tools/perf/scripts/python/bin/stackcollapse-report
> > +++ b/tools/perf/scripts/python/bin/stackcollapse-report
> > @@ -1,3 +1,3 @@
> >  #!/bin/sh
> >  # description: produce callgraphs in short form for scripting use
> > -perf script -s "$PERF_EXEC_PATH"/scripts/python/stackcollapse.py -- "$@"
> > +perf script -s "$PERF_EXEC_PATH"/scripts/python/stackcollapse.py "$@"
> > -- 
> > 2.18.1
> > 
> > 

-- 

- Arnaldo
