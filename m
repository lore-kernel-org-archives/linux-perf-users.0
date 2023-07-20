Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C839EB64DD
	for <linux-perf-users@archiver.kernel.org>; Thu, 20 Jul 2023 14:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjGTOpX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 20 Jul 2023 10:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbjGTOpW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 20 Jul 2023 10:45:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C3AC6;
        Thu, 20 Jul 2023 07:45:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 291AC61B1F;
        Thu, 20 Jul 2023 14:45:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9F1C433C8;
        Thu, 20 Jul 2023 14:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689864320;
        bh=GYxbZ9V7Fkq63Zz96wh6w+B4fuq6/5qxNdUP/M4S/1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tUmiJK/OckNFf/iUr7fc2/XxAlzTuC4EaZlkHLH3KbKpb/ypm6CMsfv6C1U+GlqJz
         8q10sLYH2P7LiufKTsqOEHdBbgrD2kx4V5gXs7WPILi3J5Wx5jNp/QPQrWLtyg1YuK
         cF3PFo+3xxzybwIaC+/bB3ZIPxNN8Xyu2mQGsP1HNPaa77a5MA71ORoRJuUELiWL0r
         TbWQD5yZwrTCuPs+8OdrlD2bbEY5V/iDP7h4Jprcidb6JzSRH+PfZoqYKgfk77Y+l0
         8Lc4qqBNhEyPPGd/Q5Zh6TwVZomNMhbGI9ePMbw1O6d8IJmSxJF8LkAtSt1dVlUDSP
         NrNJ6woF+ORPw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9531E40516; Thu, 20 Jul 2023 11:45:17 -0300 (-03)
Date:   Thu, 20 Jul 2023 11:45:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>, luhongfei@vivo.com
Cc:     Rong Qianfeng <rongqianfeng@vivo.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: [PATCH] tools: perf: Two typos have been corrected
Message-ID: <ZLlIfXUB9nd20Lzw@kernel.org>
References: <20230720034022.31937-1-rongqianfeng@vivo.com>
 <CAP-5=fXQY1T2VQxs2ZBX_9ksuVfYvvzA6xSeOUpSQ8Sz1eJv_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXQY1T2VQxs2ZBX_9ksuVfYvvzA6xSeOUpSQ8Sz1eJv_Q@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Jul 19, 2023 at 09:32:57PM -0700, Ian Rogers escreveu:
> On Wed, Jul 19, 2023 at 8:40 PM Rong Qianfeng <rongqianfeng@vivo.com> wrote:
> >
> > When wrapping code, use ';' better than using ',' which is more
> > in line with the coding habits of most engineers.
> >
> > Signed-off-by: Rong Qianfeng <rongqianfeng@vivo.com>
> 
> Snap: https://lore.kernel.org/lkml/20230706094635.1553-1-luhongfei@vivo.com/

Applied the one from luhongfei@vivo.com,

Thanks,

- Arnaldo
 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/builtin-diff.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> > index e8a1b16aa5f8..57d300d8e570
> > --- a/tools/perf/builtin-diff.c
> > +++ b/tools/perf/builtin-diff.c
> > @@ -1915,8 +1915,8 @@ static int data_init(int argc, const char **argv)
> >                 struct perf_data *data = &d->data;
> >
> >                 data->path  = use_default ? defaults[i] : argv[i];
> > -               data->mode  = PERF_DATA_MODE_READ,
> > -               data->force = force,
> > +               data->mode  = PERF_DATA_MODE_READ;
> > +               data->force = force;
> >
> >                 d->idx  = i;
> >         }
> > --
> > 2.39.0
> >

-- 

- Arnaldo
