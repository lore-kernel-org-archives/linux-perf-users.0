Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB51C07E94
	for <linux-perf-users@archiver.kernel.org>; Fri,  4 Jun 2021 13:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F0D4610C9
	for <linux-perf-users@archiver.kernel.org>; Fri,  4 Jun 2021 13:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhFDNCm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 4 Jun 2021 09:02:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230004AbhFDNCm (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 4 Jun 2021 09:02:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5391D61107;
        Fri,  4 Jun 2021 13:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622811656;
        bh=BJsetL4SUhorJv06M9mPfb8Edmqe8ztcraguJgIeMRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nONJ9Ao2Qnhn7thGdWURRYH2mLumcjw0Z0R0G/BxnMmhcJmxASwKknGifiVp/G669
         AFqa9tz4p5ZfTsvBWpEjyQRatGY/ZtT2P6UmuTi9gsiE3XotB/CczQcxZFWkCVKcyR
         EsIlOvTDR4Bcaqu+rCZKTZUCFR1iVqbtEN/OK/kIObBAr6TWJKDboi2H+aKuplflt3
         D9WDnp8QH5HdjEH5e7YSENADifOagK/CKMNlTsdGpLDKuGdxJIkDeU7Mxe5UHcChI6
         gEGf65cpmb4dWC5QWP7GAFzVqTwVmKf/CiaGCwu8Aj2BDKACnyqenEyl14j8PNyy9u
         GK0ieD3FBA7Vw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 07D0A40EFC; Fri,  4 Jun 2021 10:00:52 -0300 (-03)
Date:   Fri, 4 Jun 2021 10:00:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Riccardo Mancini <rickyman7@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Fabian Hemmer <copy@copy.sh>,
        Remi Bernon <rbernon@codeweavers.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf symbol-elf: fix memory leak: free sdt_note.args
Message-ID: <YLokBBmh2+vd9E9d@kernel.org>
References: <20210602220833.285226-1-rickyman7@gmail.com>
 <CAP-5=fVp4xGd8wxLc1eFfTUPn3Urp23RmHBha2kgiJGvfysgZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVp4xGd8wxLc1eFfTUPn3Urp23RmHBha2kgiJGvfysgZg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jun 03, 2021 at 09:08:46PM -0700, Ian Rogers escreveu:
> On Wed, Jun 2, 2021 at 3:12 PM Riccardo Mancini <rickyman7@gmail.com> wrote:
> >
> > Reported by ASan.
> 
> Did you have a reproducer for getting this to fail?
> 
> > Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/util/symbol-elf.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> > index 4c56aa8374344..a73345730ba90 100644
> > --- a/tools/perf/util/symbol-elf.c
> > +++ b/tools/perf/util/symbol-elf.c
> > @@ -2412,6 +2412,7 @@ int cleanup_sdt_note_list(struct list_head *sdt_notes)
> >
> >         list_for_each_entry_safe(pos, tmp, sdt_notes, note_list) {
> >                 list_del_init(&pos->note_list);
> > +               zfree(&pos->args);
> >                 zfree(&pos->name);
> >                 zfree(&pos->provider);
> >                 free(pos);
> > --
> > 2.31.1
> >

-- 

- Arnaldo
