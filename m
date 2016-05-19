From: Chris Ryder <chris.ryder@arm.com>
Subject: [PATCH 1/7] perf annotate: Fix identification of ARM blt and bls instructions
Date: Thu, 19 May 2016 17:59:45 +0100
Message-ID: <560e196b7c79b7ff853caae13d8719a31479cb1a.1463676839.git.chris.ryder@arm.com>
References: <cover.1463676839.git.chris.ryder@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1463676839.git.chris.ryder@arm.com>
In-Reply-To: <cover.1463676839.git.chris.ryder@arm.com>
References: <cover.1463676839.git.chris.ryder@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Chris Ryder <chris.ryder@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-perf-users@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-perf-users.vger.kernel.org

The ARM blt and bls instructions are not correctly identified when
parsing assembly because the list of recognised instructions must
be sorted by name. Swap the ordering of blt and bls.

Signed-off-by: Chris Ryder <chris.ryder@arm.com>
Acked-by: Pawel Moll <pawel.moll@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 tools/perf/util/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 4db73d5..d197571 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -372,8 +372,8 @@ static struct ins instructions[] = {
 	{ .name = "bgt",   .ops  = &jump_ops, },
 	{ .name = "bhi",   .ops  = &jump_ops, },
 	{ .name = "bl",    .ops  = &call_ops, },
-	{ .name = "blt",   .ops  = &jump_ops, },
 	{ .name = "bls",   .ops  = &jump_ops, },
+	{ .name = "blt",   .ops  = &jump_ops, },
 	{ .name = "blx",   .ops  = &call_ops, },
 	{ .name = "bne",   .ops  = &jump_ops, },
 #endif
-- 
2.1.4
