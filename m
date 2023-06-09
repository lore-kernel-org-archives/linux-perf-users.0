Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43220C7EE29
	for <linux-perf-users@archiver.kernel.org>; Fri,  9 Jun 2023 08:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240728AbjFIIjj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 9 Jun 2023 04:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240987AbjFIIj0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 9 Jun 2023 04:39:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B4A3588
        for <linux-perf-users@vger.kernel.org>; Fri,  9 Jun 2023 01:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686299862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rR8fywPwRtyfJmihJnn8NzH4PZYiEhORvDsUjX9xfDQ=;
        b=N8Fat/3nGrfdf1V9o3/bNx2rWCphDgf+rl5vXBreHZVyXH5kdbqJITW44R7eHKOmU12/Yp
        YckpmTBXRLyBV9rsi/gcjOk5eCZqRCPXCGXF1L8GAJt+bcjAQWUEhLaaatDAxonm0QWW0S
        ILTLW9j8AX1UkKO2jIBQlo9H2Yp+ANY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-198-T9NDEMyCNFm2bR-hrOzDug-1; Fri, 09 Jun 2023 04:37:35 -0400
X-MC-Unique: T9NDEMyCNFm2bR-hrOzDug-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2DF068030CF;
        Fri,  9 Jun 2023 08:37:35 +0000 (UTC)
Received: from samus.usersys.redhat.com (unknown [10.43.17.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A02D51121314;
        Fri,  9 Jun 2023 08:37:33 +0000 (UTC)
Date:   Fri, 9 Jun 2023 10:37:31 +0200
From:   Artem Savkov <asavkov@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] perf tools: annotation browser from c2c tui
Message-ID: <20230609083731.GA168559@samus.usersys.redhat.com>
References: <20230608084407.140323-1-asavkov@redhat.com>
 <CAM9d7cgvtuqMeQx8ehLCLw_Ur9Ju-VzDrakzFJxnxvFjdsWk_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cgvtuqMeQx8ehLCLw_Ur9Ju-VzDrakzFJxnxvFjdsWk_g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jun 08, 2023 at 02:09:06PM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Jun 8, 2023 at 1:44 AM Artem Savkov <asavkov@redhat.com> wrote:
> >
> > These patches add ability to start annotation browser from c2c report
> > tui. The idea comes from Arnaldo's "Profiling Data Structures" talk [1].
> 
> I was thinking about how it works and realized that it didn't collect
> samples by symbol.  Then I'm not sure if the result is meaningful.
> I think it'd show a random symbol that touched the cache line
> first.  The same cache line can be accessed from other locations
> but it cannot know where they are.
> 
> Also different instructions in a function (symbol) would access a
> different cache line.  The annotate output just shows any memory
> access.  So it might be good to check the instruction at the point
> but others should not be considered related.
> 
> Hmm.. I suspect even the same instruction will hit the different
> cache lines at different times.  Then probably the annotation
> won't work well in terms of correlating cache lines.

The annotation hotkey is only added to the cacheline detailed view where
we do have symbol instruction information. The idea is to give the user
ability to quickly jump to source code/disassembly directly from c2c
TUI.

The hit percentages in annotation view don't make much sense in this
case though, so maybe it is better to use dummy evsel so that none are
shown.

> Thanks,
> Namhyung
> 
> >
> > [1]: http://vger.kernel.org/~acme/prez/linux-plumbers-2022/
> >
> > v1->v2: Addressed comments from Namhyung Kim
> > - No longer saving evsel for each hist entry, using evlist__first
> >   instead.
> > - Factored out preparations to call annotation browser to do_annotate()
> >   function
> > - Other small fixes and adjustments.
> >
> > Artem Savkov (2):
> >   perf util: move symbol__new_unresolved() to util/symbol.c
> >   perf tools: allow running annotation browser from c2c-report
> >
> >  tools/perf/builtin-c2c.c       | 73 +++++++++++++++++++++++++++++++---
> >  tools/perf/ui/browsers/hists.c | 22 ----------
> >  tools/perf/util/symbol.c       | 22 ++++++++++
> >  tools/perf/util/symbol.h       |  1 +
> >  4 files changed, 91 insertions(+), 27 deletions(-)
> >
> > --
> > 2.40.1
> >
> 

-- 
 Artem

