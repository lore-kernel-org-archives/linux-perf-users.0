Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA2DC4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 27 Jul 2021 15:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34CCE61B73
	for <linux-perf-users@archiver.kernel.org>; Tue, 27 Jul 2021 15:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236978AbhG0Pza (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 27 Jul 2021 11:55:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhG0Pza (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 27 Jul 2021 11:55:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15C9561B7B;
        Tue, 27 Jul 2021 15:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627401330;
        bh=o7uBBDueqmfKFRgrSD0hRrTWj9k3+Z2/9NrSr7B+xIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oytkAef+RhMgCe2MZ9L8cAtlDoPyIY5nY/UtjVI0r1b05zNEUIcNhAG/MK2iwtRvS
         L839QhnO83TjXx2sYwsT1wP5PKGsLkvMvrzfHhzh5kqSjMdlPBoLQjNwZ8LZxhExr4
         rQDbTiGQyVWyGbRwd9DedTMFhrn6bSxWlSL/YpH9nrxtmaXmYwlf0dOWuv1foAz2VI
         u1UR3GslArb9WKd5cMG2afUVt/lkVPyGYCcx6cgsxY3xYMIcOYmxIe9g1pPKKRHY1F
         tJe8ylSzC8pff9A1W+2dKDDPLWT5/YNJ9Pi8/OCGZ6t47kdSXhex8j2SdEz5WgWDLI
         NexLydZy7BKUA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F30D4403F2; Tue, 27 Jul 2021 12:55:26 -0300 (-03)
Date:   Tue, 27 Jul 2021 12:55:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     Li Huafei <lihuafei1@huawei.com>, jolsa@kernel.org,
        peterz@infradead.org, mark.rutland@arm.com, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        mliska@suse.cz, irogers@google.com, dzhu@wavecomp.com,
        rickyman7@gmail.com, yao.jin@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangjinhao2@huawei.com
Subject: Re: [PATCH 2/2] perf annotate: Add error log in symbol__annotate()
Message-ID: <YQAsbprd0sl7gya4@kernel.org>
References: <20210726123854.13463-1-lihuafei1@huawei.com>
 <20210726123854.13463-2-lihuafei1@huawei.com>
 <7106d95c-2a97-cd8b-b361-7f498a1b0a5f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7106d95c-2a97-cd8b-b361-7f498a1b0a5f@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Jul 26, 2021 at 04:19:26PM +0100, James Clark escreveu:
> 
> 
> On 26/07/2021 13:38, Li Huafei wrote:
> > When users use the perf annotate feature on unsupported machines, error
> > logs should be printed for user feedback.
> > 
> > Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> > ---
> >  tools/perf/util/annotate.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > index aa04a3655236..cb280de3369f 100644
> > --- a/tools/perf/util/annotate.c
> > +++ b/tools/perf/util/annotate.c
> > @@ -2192,8 +2192,10 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
> >  		return errno;
> >  
> >  	args.arch = arch = arch__find(arch_name);
> > -	if (arch == NULL)
> > +	if (arch == NULL) {
> > +		pr_err("%s: unsupported arch %s\n", __func__, arch_name);
> >  		return ENOTSUP;
> > +	}
> >  
> >  	if (parch)
> >  		*parch = arch;
> > 
> 
> This one is missing the v2 in the summary so it doesn't work with tools like b4,
> but I applied it manually and it works.
> 
> Reviewed-by: James Clark <james.clark@arm.com>

Thanks, applied.

- Arnaldo
