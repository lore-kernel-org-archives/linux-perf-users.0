Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C82AC636C8
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 19:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6091261360
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 19:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245589AbhGOTtF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 15:49:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245675AbhGOTrK (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 15:47:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1A8061285;
        Thu, 15 Jul 2021 19:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626378255;
        bh=iDWh59cM2afPoMa/66sIp2JlggYfn/qurVOjSaXYYrw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bkgpzawRXfwgGySx8MEzW+SSTY8MZx0yIJidGVnAqIkChgDrZTJEZtQNgPQl9dlw9
         cCXrhytc/aQ+5j1zwQwopNmWQ9jQynGnGHZOG+cBolujPrqMmPbnwgawd5D/RIS0M0
         yuDe80Tg1rxYqqxMQKaL4YQeJGf61XZchwcHWaCELGIpeXrmjxWD3zBTV1SBNYM8Aw
         axKSGElARKH8dGBIwvU4de7Of9CGaNlhPLjBzUNGeH9OFc+Y/gurQ/b+QThpQgzgpw
         IUxIUh/RxPH+Q/J8jqqyw+Om+ZuTpNEkmai5jzg0IuOtz8D4u4ZRtshyfqK/C/rxKg
         U4EJfqMUuX9pw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A2E79403F2; Thu, 15 Jul 2021 16:44:12 -0300 (-03)
Date:   Thu, 15 Jul 2021 16:44:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Krister Johansen <kjlx@templeofstupid.com>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 01/20] perf nsinfo: fix refcounting
Message-ID: <YPCQDK7dQhLNAWGT@kernel.org>
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
> > 
> > This patch makes sure that the refcnt of nsinfo is decreased whenever
> > a refcounted variable is replaced with a new value.
> 
> So, there are multiple fixes in just one patch, I'll split it into
> three, no need to resend.
> 
> I'll try and check if finding Fixes: for the three is easy, that way
> stable@vger.kernel.org will figure out which of the supported releases
> need each of them.

3rd:

commit 7416120498f83963f4c5662847a1a0556e771b89
Author: Riccardo Mancini <rickyman7@gmail.com>
Date:   Thu Jul 15 18:07:06 2021 +0200

    perf probe: Fix dso->nsinfo refcounting
    
    ASan reports a memory leak of nsinfo during the execution of:
    
     # perf test "31: Lookup mmap thread".
    
    The leak is caused by a refcounted variable being replaced without
    dropping the refcount.
    
    This patch makes sure that the refcnt of nsinfo is decreased whenever
    a refcounted variable is replaced with a new value.
    
    Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
    Fixes: 544abd44c7064c8a ("perf probe: Allow placing uprobes in alternate namespaces.")
    Cc: Ian Rogers <irogers@google.com>
    Cc: Jiri Olsa <jolsa@redhat.com>
    Cc: Krister Johansen <kjlx@templeofstupid.com>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Link: http://lore.kernel.org/lkml/55223bc8821b34ccb01f92ef1401c02b6a32e61f.1626343282.git.rickyman7@gmail.com
    [ Split from a larger patch ]
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index c14e1d228e56b1c6..e05750cea34c3a95 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -179,8 +179,10 @@ struct map *get_target_map(const char *target, struct nsinfo *nsi, bool user)
 		struct map *map;
 
 		map = dso__new_map(target);
-		if (map && map->dso)
+		if (map && map->dso) {
+			nsinfo__put(map->dso->nsinfo);
 			map->dso->nsinfo = nsinfo__get(nsi);
+		}
 		return map;
 	} else {
 		return kernel_get_module_map(target);
