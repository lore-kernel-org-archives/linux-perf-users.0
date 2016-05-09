From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [RFC 1/2] tools/perf: Handle EOPNOTSUPP for sampling events
Date: Mon, 9 May 2016 15:07:39 +0530
Message-ID: <1462786660-2900-2-git-send-email-vgupta@synopsys.com>
References: <1462786660-2900-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462786660-2900-1-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org, peterz@infradead.org, acme@redhat.com
Cc: linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@kernel.org, vincent.weaver@maine.edu, Vineet Gupta <Vineet.Gupta1@synopsys.com>
List-Id: linux-perf-users.vger.kernel.org

This allows (with next change to perf core) for calling out in userspace
the exact reason for perf record failing when PMU doesn't support
overflow interrupts

Note that this needs to be put ahead of existing precise_ip check as
that gets hit otherwise for the sampling fail case as well.

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 tools/perf/util/evsel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 738ce226002b..8bd220c63e19 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2403,6 +2403,9 @@ int perf_evsel__open_strerror(struct perf_evsel *evsel, struct target *target,
 	 "No such device - did you specify an out-of-range profile CPU?\n");
 		break;
 	case EOPNOTSUPP:
+		if (evsel->attr.sample_period != 0)
+			return scnprintf(msg, size, "%s",
+	"PMU Hardware doesn't support sampling/overflow-interrupts.");
 		if (evsel->attr.precise_ip)
 			return scnprintf(msg, size, "%s",
 	"\'precise\' request may not be supported. Try removing 'p' modifier.");
-- 
2.5.0
