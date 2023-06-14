Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9DFEB64D8
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Jun 2023 01:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241747AbjFNB71 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jun 2023 21:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241553AbjFNB70 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jun 2023 21:59:26 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E156106
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 18:59:25 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-665a16cdd97so2406324b3a.3
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 18:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686707964; x=1689299964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CptATqeseRZ9wnta/kqV0RFXggJlBwVL1UgxNIajgOw=;
        b=e2RgK1vxZSlLTPBqtiSaUZBIa1pYX3TyvB9mmgJfYVdBgv+uVbgWNieVfpID4RRcif
         Rh4aKrtEjMQbFQgL/1cBNFSOCLkJIm6gnJlgU8Sm7S9Qx/+9SjPfFVFylYIi6+1lbdK5
         0FjdUzRVBSxTFZj7AMQI1JkSrViqPraYB37ncZ/dv1/2vOTlVEBSHOUgWjQoWLktLHPw
         /p5w1w9Ffg2h+1tGmiEdfa69l4HvRozyl4o+nqtTpc9PvK5kXL1ea0sQsQsIkr/U1ZGm
         jh7Q0ITCO6NXcmc/6b1iRYJlDKFIoNGqKp//s5NetJgOxZdVgPd9tdT656pwTwyYsks8
         7UWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686707965; x=1689299965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CptATqeseRZ9wnta/kqV0RFXggJlBwVL1UgxNIajgOw=;
        b=XgUpa9dcYWx2BKeaTzMwwAlv8KlZk/5sDrQcclXJT3HlXSPCNwfEfeDGj54xKkASF4
         TAbYOkGdONTIXrUa/a+yI1A6rNhwc7VNGWT7nFOePgXSSHX2A24GUAYMRnhfejPyMd1V
         HPDShpxktGzD6k+JP5Djxkw/N4+nJQ9359UtBtJECwghJaqCTvLLdSjUtZprYbATfYfJ
         6V63A2TnJc4R5dtJbh5fXfTIMMnLJvx3pV9Xn7VP4sEKURO28Ag1spmKU/9sT+q+nHEW
         eEbY+RQ7gMcIZwPvQnJ6M6vnaOGFVzP1HgDnslpM6EpJyTIJV3/EJE1SmF/eaijqv1zi
         Nz9g==
X-Gm-Message-State: AC+VfDzMWNdXUDm4SaLtIN+/+k1n6m/ftIZmYBNp9qJjbS3DXy82iev1
        UFKnBU/Ohe1HgIlZEEebjPEPQQ==
X-Google-Smtp-Source: ACHHUZ7fIQKn6w558fr9elLAW7uFGq15RlsXFxAuykUMeZG/0doPLFqGLG+NTvihGA0DQVkqTDU/EQ==
X-Received: by 2002:a05:6a00:1a45:b0:63a:ea82:b7b7 with SMTP id h5-20020a056a001a4500b0063aea82b7b7mr715343pfv.28.1686707964453;
        Tue, 13 Jun 2023 18:59:24 -0700 (PDT)
Received: from leoy-huanghe.lan ([223.104.5.42])
        by smtp.gmail.com with ESMTPSA id n14-20020a635c4e000000b004fbd91d9716sm9813808pgm.15.2023.06.13.18.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 18:59:23 -0700 (PDT)
Date:   Wed, 14 Jun 2023 09:59:14 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>, jolsa@kernel.org,
        irogers@google.com, namhyung@kernel.org, ravi.bangoria@amd.com,
        john.g.garry@oracle.com, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH 01/17] perf: get rid of unused import
Message-ID: <20230614015914.GL217089@leoy-huanghe.lan>
References: <20230613164145.50488-1-atrajeev@linux.vnet.ibm.com>
 <20230613164145.50488-2-atrajeev@linux.vnet.ibm.com>
 <ZIjJYCL38UX9FIl4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIjJYCL38UX9FIl4@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jun 13, 2023 at 04:54:08PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jun 13, 2023 at 10:11:29PM +0530, Athira Rajeev escreveu:
> > From: Sourabh Jain <sourabhjain@linux.ibm.com>
> > 
> > Script doesn't use sys library, so remove it.
> 
> Please Cc the persons working on that file, I added Leo to the CC list
> of this message.

Thanks, Arnaldo & Athira.  The change looks good to me.

> Thanks, applied.

Since have applied this patch, it's no need to give my review tag :)

Thanks,
Leo

> - Arnaldo
>  
> > Report by pylint:
> > W0611: Unused import sys (unused-import)
> > 
> > Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> > Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> > Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> > ---
> >  tools/perf/scripts/python/arm-cs-trace-disasm.py | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> > index 4339692a8d0b..d59ff53f1d94 100755
> > --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> > +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> > @@ -9,7 +9,6 @@
> >  from __future__ import print_function
> >  import os
> >  from os import path
> > -import sys
> >  import re
> >  from subprocess import *
> >  from optparse import OptionParser, make_option
> > -- 
> > 2.39.1
> > 
> 
> -- 
> 
> - Arnaldo
