From: Arun Sharma <asharma@fb.com>
Subject: Re: [PATCH 2/2] perf: Add a new sort order: SORT_INCLUSIVE
Date: Wed, 7 Mar 2012 15:13:15 -0800
Message-ID: <20120307231315.GA24736@dev3310.snc6.facebook.com>
References: <1331160079-13821-1-git-send-email-asharma@fb.com>
 <1331160079-13821-3-git-send-email-asharma@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from intmgw001.ash2.facebook.com ([66.220.155.178]:50012 "EHLO
	intmgw003.ash2.facebook.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1030654Ab2CGXNS (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 7 Mar 2012 18:13:18 -0500
Content-Disposition: inline
In-Reply-To: <1331160079-13821-3-git-send-email-asharma@fb.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <asharma@fb.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Arnaldo Carvalho de Melo <acme@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Mike Galbraith <efault@gmx.de>, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Namhyung Kim <namhyung.kim@lge.com>, Tom Zanussi <tzanussi@gmail.com>, linux-perf-users@vger.kernel.org


Further testing showed one more bad memory reference when using
sort inclusive. Fixed by the patch below.

commit 799f80b6e8168d4813de094f2327367d6d226a8c
Author: Arun Sharma <asharma@fb.com>
Date:   Wed Mar 7 15:05:00 2012 -0800

    perf: fix some bad memory references in tui
    
    Check for he->ms.sym since that's what we're dereferencing
    
    Signed-off-by: Arun Sharma <asharma@fb.com>

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index b9d0fb2..d4e0ec5 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -86,7 +86,7 @@ static int perf_evsel__add_hist_entry(struct perf_evsel *evsel,
 	 * so we don't allocated the extra space needed because the stdio
 	 * code will not use it.
 	 */
-	if (al->sym != NULL && use_browser > 0) {
+	if (he->ms.sym != NULL && use_browser > 0) {
 		struct annotation *notes = symbol__annotation(he->ms.sym);
 
 		assert(evsel != NULL);
