Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E6FC433EF
	for <linux-perf-users@archiver.kernel.org>; Sat, 11 Sep 2021 18:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E8E5610A3
	for <linux-perf-users@archiver.kernel.org>; Sat, 11 Sep 2021 18:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbhIKS6e (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 11 Sep 2021 14:58:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233408AbhIKS6d (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 11 Sep 2021 14:58:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CF9260FA0;
        Sat, 11 Sep 2021 18:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631386640;
        bh=iJtjQpB0WLfHe68sJLU9XAit0LKU/8FKeRG2V5HUJGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P6zzEkux+SvZT4SmyV6p66txBk067ipMH5OvdboTi2i7zeVTA218piNFqsnPnekoS
         6XFpdIHTGHRfTmyRBsT6Cu1TDbQ68wWXHcznmIs9h4MhbD98eMGla9WxeuwG3Cdjw5
         D4NsFLdhWuIaN2mVZNWXLBpCREjeMoqHITbYK74e06F930YFKVc4FF+0hANnzle5eP
         C0TW7wCRhIoWSlofzGOddwfw5BviGPL0GPwaOf9RQgOTz5KwKQRAxrzwIdmwlkc1iM
         RZYRD3qgZ2x+MYxq+oYhzcTGM/E3GsD2VyuFvKlQuS2XO5gTmP2Zc1RJoo/3bkSQHl
         XF2ADsjmC5s6g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 080BA4038F; Sat, 11 Sep 2021 15:57:17 -0300 (-03)
Date:   Sat, 11 Sep 2021 15:57:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] perf tools: Ignore Documentation dependency file
Message-ID: <YTz8DL1Nuwp+XmzE@kernel.org>
References: <20210910232249.739661-1-irogers@google.com>
 <YTz3YFXpJ0UT3R7z@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTz3YFXpJ0UT3R7z@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sat, Sep 11, 2021 at 03:37:20PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Sep 10, 2021 at 04:22:49PM -0700, Ian Rogers escreveu:
> > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Fixes: a81df63a5df3 ("perf doc: Fix doc.dep")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Thanks for the patch, but you forgot to mention _why_ we should ignore
> that file, I'll try to figure out.

Added this, probably anodine, but better than nothing :-)

---
When building directly on the checked out repository the build process
produces a file that should be ignored, so add it to .gitignore.
---

 
- Arnaldo
> 
> > ---
> >  tools/perf/.gitignore | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
> > index e555e9729758..8e0163b7ef01 100644
> > --- a/tools/perf/.gitignore
> > +++ b/tools/perf/.gitignore
> > @@ -39,3 +39,4 @@ pmu-events/jevents
> >  feature/
> >  fixdep
> >  libtraceevent-dynamic-list
> > +Documentation/doc.dep
> > -- 
> > 2.33.0.309.g3052b89438-goog
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
