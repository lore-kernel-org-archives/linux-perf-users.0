Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3875C11F64
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jul 2021 18:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFD6B613FE
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jul 2021 18:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhGASHe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 1 Jul 2021 14:07:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:34874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229958AbhGASHd (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Jul 2021 14:07:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0D74611F1;
        Thu,  1 Jul 2021 18:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625162703;
        bh=3kyu4JepJJ9a+p12n/faYnLEi5XmJZwv9CoyN/fgGOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gen8sslU9tVVnAuVtQzAuzXNas9mcOi4ydYSzlRgBqOEtDDboJ5AxjdZ2Mp6hFU4C
         DGqixb9hQ/ITKq00sVSn9ZkipsR4o/ct9y1NlLntxNCMKtBq1mj3sUHeSXBcJzJvY8
         fOJPrR6aOqN4KaehgXXFKmuFx2mk4Tt3N3e3yxGpwYd+/Nol7lBGQHEligxocykoLz
         BSBSoyJmD0QiQje4ANS52lauDaf8IVzuO7n2k6xMeFs8kk317uGrEUdyY6CXZZZalz
         ZzhAR5GSlbmer1yLeNuoUYhwhlKOD0TFaBoKJiXsqASApb66/dFNZ2545Cj/o8oxTf
         /KpChIY1ViHQQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0F0E040B1A; Thu,  1 Jul 2021 15:05:00 -0300 (-03)
Date:   Thu, 1 Jul 2021 15:04:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf session: add missing evlist__delete when
 deleting a session
Message-ID: <YN4Dy9qLrop4pM+9@kernel.org>
References: <20210624231926.212208-1-rickyman7@gmail.com>
 <CAP-5=fVbGZbV3qp27DPD_7r0z-v9hr2m34H294angaEsssKB0Q@mail.gmail.com>
 <YNXD2xN2wrZgdbwO@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNXD2xN2wrZgdbwO@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Jun 25, 2021 at 01:54:03PM +0200, Jiri Olsa escreveu:
> On Thu, Jun 24, 2021 at 10:39:34PM -0700, Ian Rogers wrote:
> > On Thu, Jun 24, 2021 at 4:20 PM Riccardo Mancini <rickyman7@gmail.com> wrote:
> > >
> > > ASan reports a memory leak caused by evlist not being deleted on exit in
> > > perf-report, perf-script and perf-data.
> > > The problem is caused by evlist->session not being deleted, which is
> > > allocated in perf_session__read_header, called in perf_session__new if
> > > perf_data is in read mode.
> > > In case of write mode, the session->evlist is filled by the caller.
> > > This patch solves the problem by calling evlist__delete in
> > > perf_session__delete if perf_data is in read mode.
> 
> ugh, I'm surprised we did not free that.. and can't find
> in git log we ever did ;-) I briefly check commands using
> sessions and looks like it's correct
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> 
> > 
> > Acked-by: Ian Rogers <irogers@google.com>
> > 
> > It is messy that in read mode the session owns the evlist, but
> > otherwise not. Imo, it'd be nice to make the ownership unconditional.
> 
> yep, would be nice

Thanks, applied.

Riccardo, next time please consider adding a Fixes: tag so that the
stable@kernel.org guys can pick this for stable releases.

- Arnaldo

