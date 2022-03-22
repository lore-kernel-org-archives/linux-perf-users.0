Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78132C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Mar 2022 21:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbiCVV3p (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Mar 2022 17:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbiCVV3o (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Mar 2022 17:29:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1B3252AA;
        Tue, 22 Mar 2022 14:28:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E83CC61742;
        Tue, 22 Mar 2022 21:28:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB98C340EC;
        Tue, 22 Mar 2022 21:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647984495;
        bh=z7sSQuBtQBxbMwccDOoXZ0fsZlSrkrwm+R7uLjpsZqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kJQs58PG2xFMwpCfzlHvter4+rQt7+Anxjz8Cdb6PYGs0PTJKQFaMBVwM4EBGuEZ7
         y0PubNL0ZbFOYydBjNgLVrYjOGzzpibmJC/Uwlv187LKSBU2eJ85RyEGqKHzCDINb8
         46FNnre2jGHfcxn787J6nFvH0gg/CRKE8iLBfT3pQn9EPNO9yp6y7zWWVcad6mXuCv
         o8OF8z+vyXpA/22l1uST9VhRZwggKduAvhkpvpZampH/ngdmtX7Yw9ngC7Okqw0dbF
         +x03E9Bsi02HPskRBUfgiGa6WOfiAtjg2rWs3jl66rMrpzw255ykZVcBVdlkHlxbXP
         lTVeR2BsYWxpw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D677540407; Tue, 22 Mar 2022 18:28:12 -0300 (-03)
Date:   Tue, 22 Mar 2022 18:28:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf build-id: Fix spelling mistake "Cant" -> "Can't"
Message-ID: <Yjo/bPt+elQNM2WR@kernel.org>
References: <20220316232452.53062-1-colin.i.king@gmail.com>
 <CAP-5=fWA=OGggwz730ScghTmUqeWGSG3hXv2swCRKGafOOSiDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWA=OGggwz730ScghTmUqeWGSG3hXv2swCRKGafOOSiDg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Mar 16, 2022 at 08:10:28PM -0700, Ian Rogers escreveu:
> On Wed, Mar 16, 2022 at 4:25 PM Colin Ian King <colin.i.king@gmail.com> wrote:
> >
> > There is a spelling mistake in a pr_err message. Fix it.
> >
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/util/build-id.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> > index 7a5821c87f94..82f3d46bea70 100644
> > --- a/tools/perf/util/build-id.c
> > +++ b/tools/perf/util/build-id.c
> > @@ -762,7 +762,7 @@ build_id_cache__add(const char *sbuild_id, const char *name, const char *realnam
> >
> >                 len = readlink(linkname, path, sizeof(path) - 1);
> >                 if (len <= 0) {
> > -                       pr_err("Cant read link: %s\n", linkname);
> > +                       pr_err("Can't read link: %s\n", linkname);
> >                         goto out_free;
> >                 }
> >                 path[len] = '\0';
> > --
> > 2.35.1
> >

-- 

- Arnaldo
