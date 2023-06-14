Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D7CEB64D7
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Jun 2023 02:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjFNCeR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jun 2023 22:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbjFNCeR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jun 2023 22:34:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565F4135
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 19:34:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7E5963CAA
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jun 2023 02:34:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C5EC433C0;
        Wed, 14 Jun 2023 02:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686710055;
        bh=w7/hjp74M5k10lemadePXsJ6+7tGg2bQSNiH38IcPzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rM5qjYa581zcC45wLWv+565oftbsSSLj1TiwJmu/vg2KplZl7waD7JlOrT0oDP4ZB
         3Vg+vuODEFWahqNtTMgM+YO23WTK03RX36pdML0FTJxgmjNfgZvwwv/0D8ixU3c2oo
         75kglZ7RyhysptyCkeXVYXSn3CwpzAYMUpp2wU29Pdh1SQfxXUl5PWL+vcABOJKFwG
         +fp2RY2fiBK9SqXGqRMQreCREQhlxXa8VLhMeJZs5+g6VNibNJeGx9WoXa3BqG9a+4
         D+iHBtzttrMkeOk+4Rh8m4T3MLXk1js2fsTV44/pcsZt2Y/r3E9Xp8st2cMeiVYnVW
         gOE+i4Qt2jhPA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 08C5940692; Tue, 13 Jun 2023 23:34:12 -0300 (-03)
Date:   Tue, 13 Jun 2023 23:34:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>, jolsa@kernel.org,
        irogers@google.com, namhyung@kernel.org, ravi.bangoria@amd.com,
        john.g.garry@oracle.com, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH 01/17] perf: get rid of unused import
Message-ID: <ZIknI2imecS5doHN@kernel.org>
References: <20230613164145.50488-1-atrajeev@linux.vnet.ibm.com>
 <20230613164145.50488-2-atrajeev@linux.vnet.ibm.com>
 <ZIjJYCL38UX9FIl4@kernel.org>
 <20230614015914.GL217089@leoy-huanghe.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614015914.GL217089@leoy-huanghe.lan>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Jun 14, 2023 at 09:59:14AM +0800, Leo Yan escreveu:
> On Tue, Jun 13, 2023 at 04:54:08PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Jun 13, 2023 at 10:11:29PM +0530, Athira Rajeev escreveu:
> > > From: Sourabh Jain <sourabhjain@linux.ibm.com>
> > > 
> > > Script doesn't use sys library, so remove it.
> > 
> > Please Cc the persons working on that file, I added Leo to the CC list
> > of this message.
> 
> Thanks, Arnaldo & Athira.  The change looks good to me.
> 
> > Thanks, applied.
> 
> Since have applied this patch, it's no need to give my review tag :)

No, I usually can  add a Reviewed-by tag even after having applied it to
my local tree, as I still need to run tests before making it available
via perf-tools-next, when I should not make any further changes.

- Arnaldo
 
> Thanks,
> Leo
> 
> > - Arnaldo
> >  
> > > Report by pylint:
> > > W0611: Unused import sys (unused-import)
> > > 
> > > Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> > > Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> > > Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> > > ---
> > >  tools/perf/scripts/python/arm-cs-trace-disasm.py | 1 -
> > >  1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> > > index 4339692a8d0b..d59ff53f1d94 100755
> > > --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> > > +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> > > @@ -9,7 +9,6 @@
> > >  from __future__ import print_function
> > >  import os
> > >  from os import path
> > > -import sys
> > >  import re
> > >  from subprocess import *
> > >  from optparse import OptionParser, make_option
> > > -- 
> > > 2.39.1
> > > 
> > 
> > -- 
> > 
> > - Arnaldo

-- 

- Arnaldo
