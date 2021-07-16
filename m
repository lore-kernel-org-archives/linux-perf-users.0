Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A25C12002
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Jul 2021 16:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC18961374
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Jul 2021 16:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhGPQcP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 16 Jul 2021 12:32:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:43318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhGPQcN (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 16 Jul 2021 12:32:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65EA261374;
        Fri, 16 Jul 2021 16:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626452958;
        bh=RPbljYHBe0gfkpEz6K8SRbVUNW/KwEPHQZ7dKTYAA7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qsII8xGeR+hHV1JuAwt94vlkQ/IsqObycM+nj7FtuclDiYrMxXUGYVzuIsxapIuKR
         a7W9C2SUctE9ejQwN5Y4nJniB2M3jMd55IEXE9KEC9m9jEfh6AAeLzkBD/oQsdyK8T
         SlLdop5024U2B5gMTIxLQtEdNxMvFTAHvxDiIUd56ImF6zkMQC2HO/h+CvI1NC0Ryj
         PYwPfgntraC2GUOoi0ZTvD9EyL7pt/A4GHlpS2uGE3bS8INLlHhgnAFs11RCi/qPrj
         dIyQOuqWYMvVmtmS4P0kFW7sjMWwYVQMOaYonTNTeQtcz5CsLmwwG3px1T0OoXd1Hx
         qsQns2c6gPVPA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 85C1F403F2; Fri, 16 Jul 2021 13:29:15 -0300 (-03)
Date:   Fri, 16 Jul 2021 13:29:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Subject: Re: [RFC PATCH 03/10] perf workqueue: add threadpool start and stop
 functions
Message-ID: <YPGz2xTCa/EkvrxY@kernel.org>
References: <cover.1626177381.git.rickyman7@gmail.com>
 <118c988358322b9daf69aeb98ff8986748b0dad2.1626177381.git.rickyman7@gmail.com>
 <CAM9d7chvRswKLmRvW5rd4GApqngN8QeG+nPmVy4zxz_YR0MMxw@mail.gmail.com>
 <5866e3456645659423030339f71f3461659ffe2d.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5866e3456645659423030339f71f3461659ffe2d.camel@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Jul 16, 2021 at 03:53:58PM +0200, Riccardo Mancini escreveu:
> On Thu, 2021-07-15 at 16:48 -0700, Namhyung Kim wrote:
> > On Tue, Jul 13, 2021 at 5:11 AM Riccardo Mancini <rickyman7@gmail.com> wrote:
> > > +++ b/tools/perf/util/workqueue/threadpool.c
> > [SNIP]
> > > +/**
> > > + * wait_thread - receive ack from thread
> > > + *
> > > + * NB: call only from main thread!
> > > + */
> > > +static int wait_thread(struct thread_struct *thread)
> > > +{
> > > +       int res;
> > > +       enum thread_msg msg = THREAD_MSG__UNDEFINED;
> > > +
> > > +       res = read(thread->pipes.from[0], &msg, sizeof(msg));
> > > +       if (res < 0) {

> > Maybe it needs to handle -EINTR.

> Its behaviour should be retry, right?
> Since these reads are used multiple times in the code, maybe I'm better off
> writing a wrapper function handling also EINTR.

Take a look at readn():

tools/lib/perf/lib.c

static ssize_t ion(bool is_read, int fd, void *buf, size_t n)
{
        void *buf_start = buf;
        size_t left = n;

        while (left) {
                /* buf must be treated as const if !is_read. */
                ssize_t ret = is_read ? read(fd, buf, left) :
                                        write(fd, buf, left);

                if (ret < 0 && errno == EINTR)
                        continue;
                if (ret <= 0)
                        return ret;

                left -= ret;
                buf  += ret;
        }

        BUG_ON((size_t)(buf - buf_start) != n);
        return n;
}

/*
 * Read exactly 'n' bytes or return an error.
 */
ssize_t readn(int fd, void *buf, size_t n)
{
        return ion(true, fd, buf, n);
}
 
 
- Arnaldo
