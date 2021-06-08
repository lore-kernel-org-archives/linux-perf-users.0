Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B74FC47082
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Jun 2021 11:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53862610C7
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Jun 2021 11:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbhFHLbC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Jun 2021 07:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbhFHLbB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Jun 2021 07:31:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68F8C061574;
        Tue,  8 Jun 2021 04:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zD2ExAJSzKWT1fRzORsMdPpoWV1NnIEMM18+LgdwN5c=; b=t/0M9Yxf4QMDT5+XGU+7u6mdaF
        u/0jpmk/FzUCYhvTW01w/pRduj49SPqBAduc022BsFFgTTa2pTyiZ+3HIA9RJbNycW3BGb0sQAM0V
        sqxTTfXZ/lGjxGJDon0ruO8SgCn3jIbyBAH8r9XGbqPye0amChsyMG1f663dmzS1+JZBGqrHaKoXo
        h/LL/Kr6vcZiWkmkKczq2MuL4TCwm809ZRo4kWWgcVjxmKnHXAws68ZT0cCc7H474kwxD7Lm4PhgC
        4bbPQikbiUk7F76/OosiXm61I16j5tAuntUalj0xPYEartkuyYkYBHfTKDoexGPbEwEicv2ZLeUlR
        UgBtV5QQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lqZuR-00GsP0-Rk; Tue, 08 Jun 2021 11:28:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 79781300258;
        Tue,  8 Jun 2021 13:28:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3A8CF20245F9F; Tue,  8 Jun 2021 13:28:39 +0200 (CEST)
Date:   Tue, 8 Jun 2021 13:28:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] tools/perf: Do not set a variable unless it will be used
Message-ID: <YL9UZzjqz8gHLbfo@hirez.programming.kicks-ass.net>
References: <20210604092638.985694-1-ribalda@chromium.org>
 <YLn0D+1R2QHZYRVV@hirez.programming.kicks-ass.net>
 <CANiDSCu4Brz7FZX5oa57kNLG9h_1EASX=bdQij4+apg0ZwW8QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiDSCu4Brz7FZX5oa57kNLG9h_1EASX=bdQij4+apg0ZwW8QA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 04, 2021 at 09:24:23PM +0200, Ricardo Ribalda wrote:
> Hi Peter
> 
> On Fri, 4 Jun 2021 at 11:36, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Jun 04, 2021 at 11:26:38AM +0200, Ricardo Ribalda wrote:
> > > clang-13 triggers the following warning:
> > >
> > > bench/inject-buildid.c:351:6: error: variable 'len' set but not used [-Werror,-Wunused-but-set-variable]
                                                                         clue here: ^^^^^^^^^^^^^

> > >         u64 len = 0;
> > >
> > > This patch sets the value to len only if it will be used afterwards.
> >
> > My vote would be to kill that warning, what absolute shite.
> 
> My knowledge of llvm codebase is close to NULL, so it is much easier
> for me to "fix" the code.

That's what -Wno-unused-but-set-variable is for, which is trivial to add
to the Makefile.
