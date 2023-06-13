Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A254EB64D7
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jun 2023 19:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238663AbjFMTyP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jun 2023 15:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjFMTyO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jun 2023 15:54:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD8BE3
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 12:54:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C46B261800
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 19:54:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F50C433F0;
        Tue, 13 Jun 2023 19:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686686052;
        bh=mJcFbNoDMdxbnPLxc2sZOLisx0d5+7qqgKOXtrG66l0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dc6JxEdUkpZAq7X/cRuQMyFR6uHQlB5DVykYfyn66zkco3SNaI5unn9Nlu5MBeWux
         amAVvzmP5rsOd2GnOcvjKpJgeWpm5bjHxGVxF0NdIV0LKZe9oxw5JNVtz+JKIydyVd
         MxgCXAdYR0RFrI/uCX2fNfYqOlRg1D8q2MDP/839+e00IDZ3+rfkIt8woZm+Eog1zS
         RGNNv3KY2rrMDPT1CizsbJgcpXE9m+mAPfuvbOTLS/ZUSoiPwSkuwkHrkkIntZ3QWv
         C30uCT6v0qnMQPDZq0DToI3Y2pjehZUtu3dYhx39XWmTEhuOVdcmOwUf+I5nWuamNW
         wbfoJtjNDfJLA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0FFAC40692; Tue, 13 Jun 2023 16:54:09 -0300 (-03)
Date:   Tue, 13 Jun 2023 16:54:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Leo Yan <leo.yan@linaro.org>
Cc:     jolsa@kernel.org, irogers@google.com, namhyung@kernel.org,
        ravi.bangoria@amd.com, john.g.garry@oracle.com,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH 01/17] perf: get rid of unused import
Message-ID: <ZIjJYCL38UX9FIl4@kernel.org>
References: <20230613164145.50488-1-atrajeev@linux.vnet.ibm.com>
 <20230613164145.50488-2-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613164145.50488-2-atrajeev@linux.vnet.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Jun 13, 2023 at 10:11:29PM +0530, Athira Rajeev escreveu:
> From: Sourabh Jain <sourabhjain@linux.ibm.com>
> 
> Script doesn't use sys library, so remove it.

Please Cc the persons working on that file, I added Leo to the CC list
of this message.

Thanks, applied.

- Arnaldo
 
> Report by pylint:
> W0611: Unused import sys (unused-import)
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  tools/perf/scripts/python/arm-cs-trace-disasm.py | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> index 4339692a8d0b..d59ff53f1d94 100755
> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> @@ -9,7 +9,6 @@
>  from __future__ import print_function
>  import os
>  from os import path
> -import sys
>  import re
>  from subprocess import *
>  from optparse import OptionParser, make_option
> -- 
> 2.39.1
> 

-- 

- Arnaldo
