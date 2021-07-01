Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B8CC11F64
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jul 2021 18:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D345660232
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jul 2021 18:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbhGASFo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 1 Jul 2021 14:05:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233289AbhGASFo (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Jul 2021 14:05:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D5DD61417;
        Thu,  1 Jul 2021 18:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625162593;
        bh=eBef7UYGwVG2VJSwniI+dg3s1oug80U03mwQG161Yco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J5ViUQVsLV06jcs85c68IALmlehGXj4v8ccKbnew4cffkv9gM65OHwqMAc8FoKKau
         rJUUj+Eo/jqPa91vm15gRxdf2w6A5Y2JmTwhMvy9Nq+12cJ2YuSXb1xH070JI7ucnt
         IKeLChHD/EgpSOlwhWKBFfPyh0CtyRQQqaKdcJmQG2y4N4aEfqOUkC5smZ1vz4krWd
         vOTPRo5GIcV9PEghaYAbXZpsRF547w6UU0oCRnwMqCrUMhF/o3fVbLuqqDzf8cJgI1
         sdTrTPJxsxHDIs0/IIs7lZ3UKG7QsXuWRv92NZR+rr3A3sSnaHpD1IDYZYJhqsBiuM
         VCJBroCyghdbw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 22A1B40B1A; Thu,  1 Jul 2021 15:03:10 -0300 (-03)
Date:   Thu, 1 Jul 2021 15:03:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Riccardo Mancini <rickyman7@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Martin Liska <mliska@suse.cz>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf annotate: allow 's' on source code lines
Message-ID: <YN4DXp1u5kvP6AH9@kernel.org>
References: <20210624223423.189550-1-rickyman7@gmail.com>
 <CAP-5=fXWFvcvNOA+wJMSCp2Qz7EVruufvFBLWEXfdezeEJGUTA@mail.gmail.com>
 <f3bf33bfe2365241fc872ca781109f1b69374840.camel@gmail.com>
 <CAP-5=fVxdwOKWN2oOv7+hr2Vr0wD4jzizzK4x4W8jM8bwZ7u-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVxdwOKWN2oOv7+hr2Vr0wD4jzizzK4x4W8jM8bwZ7u-w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Jun 29, 2021 at 08:00:31AM -0700, Ian Rogers escreveu:
> On Fri, Jun 25, 2021 at 8:53 AM Riccardo Mancini <rickyman7@gmail.com> wrote:
> > On Thu, 2021-06-24 at 22:37 -0700, Ian Rogers wrote:
> > > On Thu, Jun 24, 2021 at 3:37 PM Riccardo Mancini <rickyman7@gmail.com> wrote:
> > > comment nit, perhaps prefer "closest" rather than "next" due to
> > > searching backward.
> >
> > The backward search is just a fallback in case the forward one finds no asm
> > line, which I believe is unlikely. Maybe it's also impossible, but I don't
> > really know how those lines are generated, so I put a fallback in place.
> > Furthermore, "closest" would imply that a previous asm line could be chosen over
> > a subsequent one if closer, even if the latter is present.
> >
> > Thanks,
> > Riccardo
> 
> Agreed, thanks for thinking about this.
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

