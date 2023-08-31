Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FABC83F2F
	for <linux-perf-users@archiver.kernel.org>; Thu, 31 Aug 2023 19:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjHaTZ1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 31 Aug 2023 15:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjHaTZ0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 31 Aug 2023 15:25:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F9C1BF;
        Thu, 31 Aug 2023 12:25:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C44F56252F;
        Thu, 31 Aug 2023 19:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BDFC433C9;
        Thu, 31 Aug 2023 19:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693509923;
        bh=iIRc5Ix5Kg1oYFJwWyasGAi6WX06E00nlXjSEafSnHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VsjV+o/JAqZq+CCMHKZfiBYRQ51+nE9UzY5/cJTQSathbLQLEx+t00NfsUJ2f2XwF
         rhdPaZacBAzcefKT+rNMvssS/fst3C6HPVJ8ldCvV/2lFTrmZsDg3H+BwoqyY3wTCZ
         9zysaic6amGMKfOqayEF6+59gq5qSKrIJvF7r795V3O1kAca484eekGF2CyzUhf9ic
         alTjnMOytH2yXCfgwUIyDn8i9rNpLxIWhcZwFVDssJRZbhxaL2+Xz+AQ+6yYyta4i8
         LhQaBooyXkF1ruMSZeiLZezE2BkaNmm39flmWtmEmtMk5On0X7WXuDT+hNqJbx3nOE
         Re191jYcsOiTA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 106D640722; Thu, 31 Aug 2023 16:25:20 -0300 (-03)
Date:   Thu, 31 Aug 2023 16:25:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh@kernel.org>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] perf list/debug output fixes
Message-ID: <ZPDpH2HauctN2nwo@kernel.org>
References: <20230831071421.2201358-1-irogers@google.com>
 <c2affcc9-468f-bf4c-a080-65b31e05a83f@linux.intel.com>
 <CAP-5=fWdH_1or1yhH3pqFymnK=-w=OTzx63mVgknFNgqxf6T+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWdH_1or1yhH3pqFymnK=-w=OTzx63mVgknFNgqxf6T+A@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Aug 31, 2023 at 11:41:51AM -0700, Ian Rogers escreveu:
> On Thu, Aug 31, 2023 at 11:28 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
> >
> >
> >
> > On 2023-08-31 3:14 a.m., Ian Rogers wrote:
> > > Fix a long standing parse_events_term cloning bug so that the bad
> > > display of terms can be fixed and the code somewhat more intuitive:
> > > https://lore.kernel.org/lkml/20230830070753.1821629-2-irogers@google.com/
> > >
> >
> > Tested-by: Kan Liang <kan.liang@linux.intel.com>
> 
> Thanks Kan!
> Ian

Thanks, applied.

- Arnaldo
 
> > Thanks,
> > Kan
> >
> > > Fix a bug caused by the rename of 'cpu' to 'default_core' in perf list.
> > >
> > > Add more documentation, increase type safety and fix some related bugs
> > > where terms weren't initialized properly.
> > >
> > > Ian Rogers (3):
> > >   perf list: Don't print Unit for default_core
> > >   perf parse-events: Name the two term enums
> > >   perf parse-events: Fix propagation of term's no_value when cloning
> > >
> > >  tools/perf/builtin-list.c      |   2 +-
> > >  tools/perf/util/parse-events.c | 203 +++++++++++++++++++++++----------
> > >  tools/perf/util/parse-events.h |  60 +++++++---
> > >  tools/perf/util/parse-events.l |   2 +-
> > >  tools/perf/util/parse-events.y |  27 +++--
> > >  tools/perf/util/pmu.c          |   2 +-
> > >  6 files changed, 207 insertions(+), 89 deletions(-)
> > >

-- 

- Arnaldo
