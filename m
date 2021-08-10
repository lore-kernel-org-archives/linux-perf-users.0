Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AE1C4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Aug 2021 20:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CEE46101E
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Aug 2021 20:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbhHJUY0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 10 Aug 2021 16:24:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233151AbhHJUYZ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 10 Aug 2021 16:24:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F71560F94;
        Tue, 10 Aug 2021 20:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628627043;
        bh=yYKQhPsS+9XZipxTRUgp1k54tHTu9xHb9DIX7R3d+pY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KvIco6IUfRtZjwqogT+o2n99HoFNKdLDyrDW0Q08kPes8b1My8dgPuY833OBukfsI
         8TtNj1tdLGsca7SFbeKeTUHA+TrVlyUrmkDPwZ2Hz6PeAMR6sHQHakLCScxL/CdxYq
         nWrKpqetpVB+mKrSnGHPe+zf2VHA0S7H4/xWAr5TfDVreT8KJT+wUPsMuLba9yxHAS
         pujmXkrNPkXdjDCiH9Dfv7KUn9AOMADELg0i+NLvUgHY4AhCXgcX577SZTPVZyMq6C
         ldfHb9pLdNXqAqdlJeNaUsyeArfH727Q1T6TCA6CUCR394EhFUrybbZowFVW6FYAIb
         D0jx8GZzA1VOg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CB47F403F2; Tue, 10 Aug 2021 17:24:00 -0300 (-03)
Date:   Tue, 10 Aug 2021 17:24:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Riccardo Mancini <rickyman7@gmail.com>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Subject: Re: [RFC PATCH v2 01/10] perf workqueue: threadpool creation and
 destruction
Message-ID: <YRLgYDKRUfwLSyHF@kernel.org>
References: <cover.1627657061.git.rickyman7@gmail.com>
 <4f0cd6c8e77c0b4f4d4b8d553a7032757b976e61.1627657061.git.rickyman7@gmail.com>
 <CAM9d7ci0LcdTZyDu5sxGkaS07Z-m4hvr2xU4TDK_aTRAJm7b7A@mail.gmail.com>
 <25278c08762593a5b0bd1873f6c0745c7ad97016.camel@gmail.com>
 <CAM9d7chuFG+cYPx34abvmciN0afUDqJ3uWo9Bsh-9jjLtQmWqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chuFG+cYPx34abvmciN0afUDqJ3uWo9Bsh-9jjLtQmWqQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Aug 10, 2021 at 11:54:19AM -0700, Namhyung Kim escreveu:
> On Mon, Aug 9, 2021 at 3:30 AM Riccardo Mancini <rickyman7@gmail.com> wrote:
> > On Fri, 2021-08-06 at 19:24 -0700, Namhyung Kim wrote:
> > > > +/**
> > > > + * threadpool__strerror - print message regarding given @err in @pool
> > > > + *
> > > > + * Buffer size should be at least THREADPOOL_STRERR_BUFSIZE bytes.
> > > > + */
> > > > +int threadpool__strerror(struct threadpool *pool __maybe_unused, int err,
> > > > char *buf, size_t size)
> > > > +{
> > > > +       char sbuf[STRERR_BUFSIZE], *emsg;
> > > > +
> > > > +       emsg = str_error_r(err, sbuf, sizeof(sbuf));
> > > > +       return scnprintf(buf, size, "Error: %s.\n", emsg);
> > > > +}
> > > > +
> > > > +/**
> > > > + * threadpool__new_strerror - print message regarding @err_ptr
> > > > + *
> > > > + * Buffer size should be at least THREADPOOL_STRERR_BUFSIZE bytes.
> > > > + */
> > > > +int threadpool__new_strerror(struct threadpool *err_ptr, char *buf, size_t
> > > > size)
> > > > +{
> > > > +       return threadpool__strerror(err_ptr, PTR_ERR(err_ptr), buf, size);
> > > > +}

> > > Why two different functions?

> > Since when new fails you don't have a err number, just an err_ptr so it's not
> > very clear how to call threadpool__strerror. Therefore I made a wrapper to
> > remove any ambiguity.
> 
> What do you mean by "when new fails"?

I think 'new' is 'constructor', i.e. something__new() returns a newly
created object and this not an error number, so he uses ERR_PTR() and
then he needs to pass it to the 'strerror' specific to the
threadpool__new, which will use PTR_ERR() to get an integer, and then
map that to a proper error string, right?

- Arnaldo
