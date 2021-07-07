Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D45C07E9E
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jul 2021 17:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8542A61CC9
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jul 2021 17:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhGGRus (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Jul 2021 13:50:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230233AbhGGRus (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Jul 2021 13:50:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9AD061CC1;
        Wed,  7 Jul 2021 17:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625680087;
        bh=ap5K7kbF57CoqctbdRm/5OwQnhcA2+w3bq0omyH6YzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ldSvBPhEtPGfP3JUNLSf85Rdkgs3tckrqUQbdNzh+jgGpbsvZ8EXRJRXvOCLEFmC+
         a/EucSkxQsu35QfZpfTm+850bJJjZmOlw4jHyKsyGiDFSw5Y/CELmCeAf1wzsxZOIY
         igq17KYNF+QqeJBsnbRIPFfWhbQZTyRsnbM522B5eLaVu6qHXcPfsT/yBVY8Cd/JUw
         f7EQnXfpS86LQDIJCQJqKTfoRKdf02P6NFGZBfv1Mj22VMzCEP8hmj+FHsNt5N4We9
         aD+xqSj3DSL4nYapDWW1TKZOfsCNq1hRMzu6Ck1zQlp1YqyGAGz9kCPPINx2HgFJVh
         OXSRjZhKm90Cg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A38B540B1A; Wed,  7 Jul 2021 14:48:04 -0300 (-03)
Date:   Wed, 7 Jul 2021 14:48:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>, nakamura.shun@fujitsu.com,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/7] libperf: Move idx to perf_evsel::idx
Message-ID: <YOXo1F8BlX07JfHC@kernel.org>
References: <20210706151704.73662-1-jolsa@kernel.org>
 <20210706151704.73662-3-jolsa@kernel.org>
 <YOW+3yhgNgMOrE99@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOW+3yhgNgMOrE99@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Jul 07, 2021 at 11:49:03AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Jul 06, 2021 at 05:16:59PM +0200, Jiri Olsa escreveu:
> > Moving evsel::idx to perf_evsel::idx, so we can move
> > the group interface to libperf.

You forgot these:

$ find tools/perf/ -name "*.[ch]" | xargs grep 'evsel->idx'
tools/perf/ui/gtk/annotate.c:							     evsel->idx + i);
tools/perf/ui/gtk/annotate.c:						    evsel->idx);
$

That running 'make -C tools/perf build-test' caught, so I'm adding this
to this patch as well:

diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index a7dff77f20184f1f..c266ed4fa015842d 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -135,12 +135,12 @@ static int perf_gtk__annotate_symbol(GtkWidget *window, struct map_symbol *ms,
 				ret += perf_gtk__get_percent(s + ret,
 							     sizeof(s) - ret,
 							     sym, pos,
-							     evsel->idx + i);
+							     evesl->core.idx + i);
 				ret += scnprintf(s + ret, sizeof(s) - ret, " ");
 			}
 		} else {
 			ret = perf_gtk__get_percent(s, sizeof(s), sym, pos,
-						    evsel->idx);
+						    evesl->core.idx);
 		}
 
 		if (ret)

