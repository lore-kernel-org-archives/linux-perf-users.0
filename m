Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747D9C636CA
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 19:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55515613F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 19:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243579AbhGOTLo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 15:11:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243936AbhGOTKP (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 15:10:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A25A613CC;
        Thu, 15 Jul 2021 19:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626376037;
        bh=Cp8Xo+M1Hv5LVvgaQlisb6BnnD3o1fyiu8cNcRc/rs8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qYfPIA4imxrbMHV4D9Mm/6TI+eaBxbox0eBQg0R3gmFU+ce/f7ICQjv5PNpYHq/54
         szbQAqpeNUnWoDDh/BQLX5yJUgxRDDRn8LHhoS6eWZlwXsGL9gXWT5xt2k0tgPhfXG
         zeTf/MrySkQYIQ4KeidGrqq+2MrqHzsh713tA2KjkLOo1TZpUzayp8o85hE4swtZQj
         QNrA3UQqKXiXRaeyiiuAUc9/nFBiu++1gmsER27WkSCXxx8l3xfAApZMw5jDThaSak
         QLhOGfVSaac1iXERtY78DsIGXbHYoL1c34ciTjZdu0KDOh5LoLOPTE0qwb+828SO6U
         OPe+baJxgihwA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8C9BC403F2; Thu, 15 Jul 2021 16:07:14 -0300 (-03)
Date:   Thu, 15 Jul 2021 16:07:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 01/20] perf nsinfo: fix refcounting
Message-ID: <YPCHYiZexSnyTnYg@kernel.org>
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

The first patch becomes:

commit b36bbdefec297ee5b6e278904360ad14fa3b09de
Author: Riccardo Mancini <rickyman7@gmail.com>
Date:   Thu Jul 15 18:07:06 2021 +0200

    perf inject: Fix dso->nsinfo refcounting
    
    ASan reports a memory leak of nsinfo during the execution of the perf
    test "31: Lookup mmap thread".
    
    The leak is caused by a refcounted variable being replaced without
    dropping the refcount.
    
    This patch makes sure that the refcnt of nsinfo is decreased when a
    refcounted variable is replaced with a new value.
    
    Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
    Fixes: 27c9c3424fc217da ("perf inject: Add --buildid-all option")
    Cc: Ian Rogers <irogers@google.com>
    Cc: Jiri Olsa <jolsa@redhat.com>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Link: http://lore.kernel.org/lkml/55223bc8821b34ccb01f92ef1401c02b6a32e61f.1626343282.git.rickyman7@gmail.com
    [ Split from a larger patch ]
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 5d6f583e2cd35be0..ffd2b25039e36e1d 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -361,9 +361,10 @@ static struct dso *findnew_dso(int pid, int tid, const char *filename,
 		dso = machine__findnew_dso_id(machine, filename, id);
 	}
 
-	if (dso)
+	if (dso) {
+		nsinfo__put(dso->nsinfo);
 		dso->nsinfo = nsi;
-	else
+	} else
 		nsinfo__put(nsi);
 
 	thread__put(thread);
