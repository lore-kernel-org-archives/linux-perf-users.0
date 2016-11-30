From: Kim Phillips <kim.phillips@arm.com>
Subject: [PATCH 1/2] perf annotate: use arch->objdump.comment_char in
 dec__parse()
Date: Wed, 30 Nov 2016 09:23:33 -0600
Message-ID: <20161130092333.1cca5dd2c77e1790d61c1e9c@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49952 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752845AbcK3PXg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 30 Nov 2016 10:23:36 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Chris Ryder <chris.ryder@arm.com>, Pawel Moll <pawel.moll@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-perf-users@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org

Presume neglected in commit 786c1b5 "perf annotate: Start supporting
cross arch annotation".  This doesn't fix a bug since none of the
affected arches support parsing dec/inc instructions yet.

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 3e34ee0..191599e 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -408,7 +408,7 @@ static int dec__parse(struct arch *arch __maybe_unused, struct ins_operands *ops
 	if (ops->target.raw == NULL)
 		return -1;
 
-	comment = strchr(s, '#');
+	comment = strchr(s, arch->objdump.comment_char);
 	if (comment == NULL)
 		return 0;
 
-- 
2.10.2
