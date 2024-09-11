Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F0D188A14;
	Wed, 11 Sep 2024 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726058159; cv=none; b=GOS5vxnSxgb4M51FXD1pNxkpFOcrPAk9GizCxxTw3uHJiG6dllthlqe6xJhwZs/oAEr+dme4zsqhHVbv9oOvTqKhiDzOjMnc4QSr0vvmeeMbEms9Yo9RmAOH4bqHiHeeT8E4s6/VTCC5nalyvgJda6qlPhpX85hzH1lgnp9UYw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726058159; c=relaxed/simple;
	bh=GRov2z2t8ao75eq6aabojNrtGlc+cdpYJk/6OMi3hQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zjn2LI/95VHEfnwpmZ3wi/h2uQBsBi9BCh+6qGNREja8yDtRJoPMQ9Ibar5G9IZOY1xc6ZVp6VU2PN/MI1ZuJqDwCAST51MzP2FDXui+h92RvMjrvwQZlWfUiW6Llx+bmYiIbvWKx0F8BasNr5QknN/Pto5C0ALa8eLPvF42Gv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anb8Pkoe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anb8Pkoe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0431C4CEC5;
	Wed, 11 Sep 2024 12:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726058159;
	bh=GRov2z2t8ao75eq6aabojNrtGlc+cdpYJk/6OMi3hQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=anb8Pkoe+cr3hcE1fJcLGfgmNjZbCmQ/VKfJV8yA+D+NoAitXVhxsDBhwHvapChNA
	 yvmqBY4gqty5dBQvk1arbNTNqfeOSxioesNFdLKzjtVUfQXz4HjszSkkENLlHLwZj+
	 vgCWzNIDN/TpZHAOMKQR4oBvMiCP0r6xu5OJsEuECu7dltdH8yHtli13fY7j2Sivrb
	 DW6+tlVkF1Qd2NNBgGmemMB+BK1tLQCGQEX3UqdURJL9IXPmHET7mKEn86Q3D/sBG0
	 DAIFdwE7yPajjdvJCeostBORF5uJlFTadjCfYAbGxV5QpnIHGCqDLmekWTfB2Nh4ws
	 3zVs+tX5fxptw==
Date: Wed, 11 Sep 2024 09:35:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Yang Li <yang.lee@linux.alibaba.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>,
	peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org
Subject: Re: [PATCH -next] perf parse-events: Remove duplicated include in
 parse-events.c
Message-ID: <ZuGOq_8StU-ChcE8@x1>
References: <20240910005522.35994-1-yang.lee@linux.alibaba.com>
 <42fd10c1-21fe-48bb-b7ee-c5b42eda7afc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42fd10c1-21fe-48bb-b7ee-c5b42eda7afc@linaro.org>

On Wed, Sep 11, 2024 at 10:50:33AM +0100, James Clark wrote:
> 
> 
> On 10/09/2024 01:55, Yang Li wrote:
> > The header files parse-events.h is included twice in parse-events.c,
> > so one inclusion of each can be removed.
> > 
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=10822
> > Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> > ---
> >   tools/perf/tests/parse-events.c | 1 -
> >   1 file changed, 1 deletion(-)
> > 
> > diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> > index 639e65a9bf61..e228511c85a5 100644
> > --- a/tools/perf/tests/parse-events.c
> > +++ b/tools/perf/tests/parse-events.c
> > @@ -5,7 +5,6 @@
> >   #include <api/fs/fs.h>
> >   #include "tests.h"
> >   #include "debug.h"
> > -#include "parse-events.h"
> >   #include "pmu.h"
> >   #include "pmus.h"
> >   #include <dirent.h>
> 
> Reviewed-by: James Clark <james.clark@linaro.org>

Thanks, applied to perf-tools-next,

- Arnaldo
