From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH-REBASED 1/2] tools/perf: Handle EOPNOTSUPP for sampling events
Date: Mon, 30 May 2016 17:01:45 +0530
Message-ID: <1464607906-16012-2-git-send-email-vgupta@synopsys.com>
References: <alpine.DEB.2.20.1605121903470.18777@macbook-air>
 <1464607906-16012-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:58294 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933060AbcE3LcQ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 30 May 2016 07:32:16 -0400
In-Reply-To: <1464607906-16012-1-git-send-email-vgupta@synopsys.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: peterz@infradead.org, acme@redhat.com, linux-kernel@vger.kernel.org, mingo@kernel.org, vincent.weaver@maine.edu, linux-snps-arc@lists.infradead.org, Alexey.Brodkin@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>

This allows (with next change to perf core) for calling out in userspace
the exact reason for perf record failing when PMU doesn't support
overflow interrupts

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 tools/perf/util/evsel.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5d7037ef7d3b..1578e67c7357 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2372,6 +2372,13 @@ int perf_evsel__open_strerror(struct perf_evsel *evsel, struct target *target,
 	 "No such device - did you specify an out-of-range profile CPU?");
 		break;
 	case EOPNOTSUPP:
+		/*
+		 * Needs to be tested ahead of precise_ip check as
+		 * that seems to be true for this case as well
+		 */
+		if (evsel->attr.sample_period != 0)
+			return scnprintf(msg, size, "%s",
+	"PMU Hardware doesn't support sampling/overflow-interrupts.");
 		if (evsel->attr.precise_ip)
 			return scnprintf(msg, size, "%s",
 	"\'precise\' request may not be supported. Try removing 'p' modifier.");
-- 
2.5.0
