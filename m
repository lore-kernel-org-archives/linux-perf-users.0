Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A1EC07E9C
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jul 2021 14:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8887561CCB
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jul 2021 14:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbhGGO7W (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Jul 2021 10:59:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232111AbhGGO7K (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Jul 2021 10:59:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55AE561CC0;
        Wed,  7 Jul 2021 14:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625669610;
        bh=pCKlkTHOpu5ebAsad4ORFKOze2QVQFXuuEFQrZdGe8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FU4ipSKNRH60SWnpFhgXJuv88QAf0pZjUxvaMp3NJ4s+8CfPWHk0PUrNbEGiK3I/E
         C77Vt3WW+pVGeqyZi5XxwDar10f2xh9kkal/Q+5djrfvtrXVX7GF0s4xiFcL3u/NIb
         xiAP4WGOkYypX2VvTQ/rraviB9OVFirt3itZ6lPsbwHdzNZ4vwLb0oIBgbs4lt/ChA
         QvQdYM4bX9ptMeFEB4T9S2Fyl8hT7zHAE2d+beAFqLLu+jqBLFdSORaRPQ0QtQFFhc
         3hlkNqJY/G4CZw7326I5ojU6ikPgXY7ztJAla6XoGygmLicH/XZ+o3EUylTY36u0RY
         iB9X0XsIb4cQQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 60BFD40B1A; Wed,  7 Jul 2021 11:53:27 -0300 (-03)
Date:   Wed, 7 Jul 2021 11:53:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>, nakamura.shun@fujitsu.com,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/7] libperf: Move leader to perf_evsel::leader
Message-ID: <YOW/5+Ep7JpL4qLL@kernel.org>
References: <20210706151704.73662-1-jolsa@kernel.org>
 <20210706151704.73662-4-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706151704.73662-4-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Jul 06, 2021 at 05:17:00PM +0200, Jiri Olsa escreveu:
> Moving evsel::leader to perf_evsel::leader, so we can move
> the group interface to libperf.

I also had to apply this, because you didn't build with
BUILD_BPF_SKEL=1, right?

diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index 1d0b9742f7271966..8150e03367bbafad 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -353,7 +353,7 @@ static int bperf_check_target(struct evsel *evsel,
 			      enum bperf_filter_type *filter_type,
 			      __u32 *filter_entry_cnt)
 {
-	if (evsel->leader->core.nr_members > 1) {
+	if (evsel->core.leader->nr_members > 1) {
 		pr_err("bpf managed perf events do not yet support groups.\n");
 		return -1;
 	}
