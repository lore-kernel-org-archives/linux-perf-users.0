Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF766C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 13:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B89ED60E94
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 13:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355108AbhIINWi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 09:22:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355402AbhIINNm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Sep 2021 09:13:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B61560FDA;
        Thu,  9 Sep 2021 12:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631191333;
        bh=laRVYVuDgyl6pUUGhtgE2ffQq061G7xDKK4KK8DRMp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FAtmdsvWx0eoSFpsBvbMkg+lZu6MpAo0lXWpEBvUjTPRU9iNHMQmM+LWEzVG5kQFL
         GHWGIg7YZ97QdWn73Vxs2POtx0eJE8o+AP0K87oT7eIvzH639a1VQKqZQWxvcxwtz2
         OPWKJD8MhnIvoQsm8NzGYJZwHinJbZ6XgJygOlW4n1LHPDmMpjplOANS7251DUVlYG
         +pvKGH/3N+j8aciDxpU3ZLwSroR7MMf815dz1JbDW92cM94AZpU7gq50Pj/mMvj3rB
         83K+m3MGTdjsVTWPydikCFD09ZdfcuGVOfezmU8+X9xTbrAl4LjjUUQbEu2aZOJKtt
         Wh0q8RGv+Gmcg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E12374038F; Thu,  9 Sep 2021 09:42:09 -0300 (-03)
Date:   Thu, 9 Sep 2021 09:42:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Michael Petlan <mpetlan@redhat.com>
Cc:     acme@redhat.com, linux-perf-users@vger.kernel.org,
        jolsa@redhat.com, sumanthk@linux.ibm.com
Subject: Re: [PATCH] perf test: Fix bpf test sample mismatch reporting
Message-ID: <YToBIaDvsW0BQKTE@kernel.org>
References: <20210805160611.5542-1-mpetlan@redhat.com>
 <alpine.LRH.2.20.2109061625540.27231@Diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.20.2109061625540.27231@Diego>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Sep 06, 2021 at 04:26:31PM +0200, Michael Petlan escreveu:
> Hi Arnaldo, please have a look.
> This is still valid.
> Thanks.
> Michael

Looks correct, thanks for resending, applied.

- Arnaldo
 
> On Thu, 5 Aug 2021, Michael Petlan wrote:
> > When the expected sample count in the condition changed, the message
> > needs to be changed too, otherwise we'll get:
> > 
> >   0x1001f2091d8: mmap mask[0]:
> >   BPF filter result incorrect, expected 56, got 56 samples
> > 
> > Fixes: 4b04e0decd25 ("perf test: Fix basic bpf filtering test")
> > 
> > Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> > ---
> >  tools/perf/tests/bpf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
> > index dbf5f5215abe..fa03ff0dc083 100644
> > --- a/tools/perf/tests/bpf.c
> > +++ b/tools/perf/tests/bpf.c
> > @@ -192,7 +192,7 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
> >  	}
> >  
> >  	if (count != expect * evlist->core.nr_entries) {
> > -		pr_debug("BPF filter result incorrect, expected %d, got %d samples\n", expect, count);
> > +		pr_debug("BPF filter result incorrect, expected %d, got %d samples\n", expect * evlist->core.nr_entries, count);
> >  		goto out_delete_evlist;
> >  	}
> >  
> > -- 
> > 2.18.4
> > 
> > 

-- 

- Arnaldo
