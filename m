Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6DBC636C9
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 19:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00752610F9
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 19:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243224AbhGOT04 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 15:26:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244114AbhGOTXV (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 15:23:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B364613EE;
        Thu, 15 Jul 2021 19:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626376827;
        bh=9A8L60acZh/ranYawGu7poVBjCxHO7CttpSh7b6fvAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MLPz6UvPpVSeTEhG7DRMMhNw6AHfa9/UtedLxtdI765oz9xHp0Y7Vc6oIRnLMEH2p
         Fmq50zUt/KEYpcOiFfbORKuj2G6CFQi7y8gKVuudePvhFqM5ZCWL8mJt+74sT/XNQG
         JxmbvLetoXG3W6DE0uGSLlWHagOHbR3XL5yWROgsY1jDVXfimz6QKvgakDa0vdRYXH
         bKUfUZRs29q/qCkyNgkLDUUzzkoPAArzPz0DmCvSBAB1gmd0ru539NarR6k0e4ESfR
         UG/Y79sPimS9kV2Cr2PHYnG24inRtzJWi8coHmYY+7GVAjIoUfg+anVYr8oknDC8hZ
         YTU7GyIQxu/Ag==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D1788403F2; Thu, 15 Jul 2021 16:20:24 -0300 (-03)
Date:   Thu, 15 Jul 2021 16:20:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>,
        Krister Johansen <kjlx@templeofstupid.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 01/20] perf nsinfo: fix refcounting
Message-ID: <YPCKeDvyLOQzKTln@kernel.org>
References: <cover.1626343282.git.rickyman7@gmail.com>
 <55223bc8821b34ccb01f92ef1401c02b6a32e61f.1626343282.git.rickyman7@gmail.com>
 <YPCGONcQx5SxEKdY@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPCGONcQx5SxEKdY@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jul 15, 2021 at 04:02:16PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Jul 15, 2021 at 06:07:06PM +0200, Riccardo Mancini escreveu:
> > ASan reports a memory leak of nsinfo during the execution of the perf
> > test "31: Lookup mmap thread".
> > The leak is caused by a refcounted variable being replaced without
> > dropping the refcount.

> > This patch makes sure that the refcnt of nsinfo is decreased whenever
> > a refcounted variable is replaced with a new value.

> So, there are multiple fixes in just one patch, I'll split it into
> three, no need to resend.

> I'll try and check if finding Fixes: for the three is easy, that way
> stable@vger.kernel.org will figure out which of the supported releases
> need each of them.

The second is at the end of this message, and looking at it I think
there is a problem with where this nsinfo reference is stored, it should
be in the 'struct map', that is per-thread, not in the 'struct dso',
that may be shared by multiple 'struct map's in different cgroups, so we
can't set dso->nsinfo in map__new(), right? Kristen?

- Arnaldo

commit 280f3933661f9ca9563ed04ce82313fdbcbb8f75
Author: Riccardo Mancini <rickyman7@gmail.com>
Date:   Thu Jul 15 18:07:06 2021 +0200

    perf map: Fix dso->nsinfo refcounting
    
    ASan reports a memory leak of nsinfo during the execution of
    
      # perf test "31: Lookup mmap thread"
    
    The leak is caused by a refcounted variable being replaced without
    dropping the refcount.
    
    This patch makes sure that the refcnt of nsinfo is decreased whenever a
    refcounted variable is replaced with a new value.
    
    Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
    Fixes: bf2e710b3cb8445c ("perf maps: Lookup maps in both intitial mountns and inner mountns.")
    Cc: Ian Rogers <irogers@google.com>
    Cc: Jiri Olsa <jolsa@redhat.com>
    Cc: Krister Johansen <kjlx@templeofstupid.com>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Link: http://lore.kernel.org/lkml/55223bc8821b34ccb01f92ef1401c02b6a32e61f.1626343282.git.rickyman7@gmail.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 8af693d9678cefe0..72e7f3616157ead4 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -192,6 +192,8 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 			if (!(prot & PROT_EXEC))
 				dso__set_loaded(dso);
 		}
+
+		nsinfo__put(dso->nsinfo);
 		dso->nsinfo = nsi;
 
 		if (build_id__is_defined(bid))
