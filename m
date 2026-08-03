Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D1D3B895B;
	Mon,  3 Aug 2026 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785748034; cv=none; b=lcPAISFV56kaIRmas6JZskG/HcwG21vhl8VPCVYL4vn7OcOdm6URZoJMalSBb9IrAp5Cr3xhWDk/KOMKlO9iliGw3W82AniFuqWqROw1eg9TCZFmR5lcDUY/5aqjSQXL0dKN5r87qypELyf5iq4+NGX939T6VIQIoPXIZMWio1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785748034; c=relaxed/simple;
	bh=p9Z9jiRRy/WgbsXt7DAHC04Dre4ydmtx0o79AA2jVzw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OY+XKgL8Qa0BqQmFXqMxfi1dGJiMOPx9SSgKeYTMLkPKfV2rYYKdrR887lBeZ/cqH3tLT1dGvVjJGlEKvQ7AY9HJKYz98munPyG/zYeiMm5lqqK9t1Mnm9nO5BFboL+QcgpwHx3vUILKILizs8Y9+wwu5RNDR8yU25kSG/ncqjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=LLSPnSOv; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="LLSPnSOv"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673390NJ4181636;
	Mon, 3 Aug 2026 02:06:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=IKWoAB+Hv68SqtguaPfGo8heCnp03xOBT1l1Y
	35v0oM=; b=LLSPnSOvRa1hTtWnru+pFxFQ2BJr0nlDa/asLs89ZIfJNk8AxcOPm
	4tki/18+hUWkcKJTWlPAoXwBslEykNOvRNpJ8zqvuMn6ruypF2UWB+R/zOFgYBfO
	GJQSNcqi99kvZ+KJbtd/LdGEIgDoo9AhBuFFRU456BxMUDz0T7Y4nLrj+RNTMdwH
	Okg+fXfxdsWLOrod8AS/5toXZg9Xr/Lns05QYGDWSQbiH0TdX/xn87VbEEQMqVIx
	gaxEo5JO0oHi9PU6kcxhw82OH07+RBZ1r/RPk3vt4RtzVTPr2KOvbOKUwlPhd77L
	qn2sQvJLRZFYQfPN6OO3rDbDEqhv+KtnQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fscu0rj6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 03 Aug 2026 02:06:48 -0700 (PDT)
Received: from localhost (2620:10d:c085:208::7cb7) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.45; Mon, 3 Aug
 2026 09:06:48 +0000
From: Amir Ayupov <aaupov@fb.com>
To: <linux-perf-users@vger.kernel.org>, <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Suzuki K Poulose
	<suzuki.poulose@arm.com>,
        James Clark <james.clark@linaro.org>, Leo Yan
	<leo.yan@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim
	<namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander
 Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>
CC: <linux-doc@vger.kernel.org>, Mike Leach <mike.leach@arm.com>,
        Jonathan
 Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Swapnil
 Sapkal <swapnil.sapkal@amd.com>
Subject: [PATCH 8/9] perf cs-etm: Consume branch history when attaching it to a sample
Date: Mon, 3 Aug 2026 02:06:39 -0700
Message-ID: <20260803090640.2412336-8-aaupov@fb.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260803090640.2412336-1-aaupov@fb.com>
References: <20260803090640.2412336-1-aaupov@fb.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _gaIApHwxhvFH32BbfUu_MIlncnuTUoq
X-Authority-Analysis: v=2.4 cv=Fto1OWrq c=1 sm=1 tr=0 ts=6a705a28 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=JX5eeHWyqfutqg6f:21 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=tpM8CJlwf7uhpglF1g9U:22 a=FOH2dFAWAAAA:8
 a=oMKByweLQ60yn3b1VYsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA4MSBTYWx0ZWRfXybzRRewq0SPl
 AC2aaGJBgP6F4n+AKFVg/7wWR5vNnT5ONRoQ4Wooxqil++XlTwiKLLplDMlrPIZE4efBTzjCgal
 S4EpCAK7jJv0MN83hY9YjCbUfgl7bVZLiFVhsB1sG8cYmkaKm6hfpmyFUoFjpXQKEqF4tfn8dvj
 pYKxnkT09krW265lu3uQ+Jt9xUg6/GAteIaaDv9fFXfhTbMCIUhcnRSceoqrNvk3qbKAcqdWF8f
 t5E1xPlWCsbt/P/dYf+c57VJDntXTQfZwezEvwr3+ySeEsQFVbAbOZNGcbJqfZaeDTncQflHyB8
 RM20Rs4qwVZYAxOiIhRHVenI3hxlgDvSBbuvTWtqrFbXHD9vDyCSaV6Cwl3lRZbWOawCE8ARwec
 Wv46a26Oq/o5+es9y+HBmrOlEMvf7P6WlY8HjMc4G0t2zfIZU1HOWO3/mQOuRLgshPTl0JBuCKc
 DpvsdVcMQD3NkHRD2Uw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA4MSBTYWx0ZWRfX3iNKszwg6Feb
 3Z9dkepwVLr8BdTb2GsakQFpE41DqV5CysmaK8gyqNQCWR/HbrzTyHypYIokli6JrSWwtN0uP+Z
 BAt7a7cNgTScsuHSLMETf01yXeEnnD4=
X-Proofpoint-GUID: _gaIApHwxhvFH32BbfUu_MIlncnuTUoq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01

--itrace=L attaches whatever the thread stack holds when a sample is
processed. With a duty cycled trace most samples fire while the trace is
off. Those samples have nothing newly decoded, but the thread stack still
holds the previous window, so they were being given branches that ran an
arbitrary amount of time earlier as if they immediately preceded the
sample.

The reconstruction is discarded on a trace discontinuity, but that does
not help here: the discontinuity that ends a gap is only decoded once
trace resumes, which is after the samples in the gap have been processed.

A trace window belongs to exactly one sample. With AUX pause and resume
the sample is what stops the trace, so the pairing is one to one by
construction. Take the branch history when attaching it instead of
copying it, and a later sample with nothing newly decoded then finds an
empty branch stack, which dlfilter-nonempty-brstack.so removes.

This is not a small correction. On a 12 s single-threaded capture with
pause period 100003 and resume period 8350251, of 335291 samples that
previously received branch history only 3371 were backed by trace decoded
for that sample; the other 331920 repeated an earlier window. The
proportion follows the ETM duty cycle, so it holds for any low duty cycle
configuration.

Note that thread_stack__br_sample(), used by lowercase --itrace=l, still
copies, so synthesised instruction samples keep the overlapping branch
stacks they have today.

Signed-off-by: Amir Ayupov <aaupov@fb.com>
---
 tools/perf/util/cs-etm.c       | 17 ++++++++---------
 tools/perf/util/thread-stack.c | 17 +++++++++++++++++
 tools/perf/util/thread-stack.h |  1 +
 3 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 048ff97caa936..a3498a0a96a05 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -3123,19 +3123,18 @@ static int cs_etm__process_sample(struct cs_etm_auxtrace *etm,
 		return -ENOMEM;
 
 	/*
-	 * The thread stack is emptied when the decoder reports a
-	 * discontinuity and when a queue runs out of trace, so branches from
-	 * before either of those are never reported.
-	 *
-	 * Note that a sample landing in a gap between two trace windows is
-	 * not covered by that: the discontinuity that ends the gap has not
-	 * been decoded at this point, so the preceding window is still in
-	 * the thread stack and gets attached. Filtering those out needs a
-	 * per-window end time that the decoder does not currently expose.
+	 * Take the branch history rather than copying it. The trace window
+	 * belongs to the sample that ends it, so once it has been attached a
+	 * later sample with nothing newly decoded finds an empty stack rather
+	 * than being given an earlier window's branches. That is the common
+	 * case whenever the trace is duty cycled, by AUX pause/resume or by
+	 * ETM strobing.
 	 */
 	thread_stack__br_sample_late(thread, sample->cpu, etm->br_stack,
 				     etm->br_stack_sz, sample->ip,
 				     machine__kernel_start(machine));
+	thread_stack__br_stack_consume(thread, sample->cpu);
+
 	if (etm->br_stack->nr)
 		sample->branch_stack = etm->br_stack;
 
diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 51eaedb47bb1d..374a291aa48fe 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -614,6 +614,23 @@ void thread_stack__sample_late(struct thread *thread, int cpu,
 	}
 }
 
+/*
+ * Branch history belongs to the sample that ends the trace window, so a
+ * decoder that attaches it to an existing sample should take it rather than
+ * copy it. A later sample with no newly decoded trace then finds an empty
+ * branch stack instead of the previous window's branches.
+ */
+void thread_stack__br_stack_consume(struct thread *thread, int cpu)
+{
+	struct thread_stack *ts = thread__stack(thread, cpu);
+
+	if (!ts || !ts->br_stack_rb)
+		return;
+
+	ts->br_stack_pos = 0;
+	ts->br_stack_rb->nr = 0;
+}
+
 void thread_stack__br_sample(struct thread *thread, int cpu,
 			     struct branch_stack *dst, unsigned int sz)
 {
diff --git a/tools/perf/util/thread-stack.h b/tools/perf/util/thread-stack.h
index b3cd09beb62f0..2aec292bd1bcb 100644
--- a/tools/perf/util/thread-stack.h
+++ b/tools/perf/util/thread-stack.h
@@ -88,6 +88,7 @@ void thread_stack__sample(struct thread *thread, int cpu, struct ip_callchain *c
 void thread_stack__sample_late(struct thread *thread, int cpu,
 			       struct ip_callchain *chain, size_t sz, u64 ip,
 			       u64 kernel_start);
+void thread_stack__br_stack_consume(struct thread *thread, int cpu);
 void thread_stack__br_sample(struct thread *thread, int cpu,
 			     struct branch_stack *dst, unsigned int sz);
 void thread_stack__br_sample_late(struct thread *thread, int cpu,
-- 
2.52.0

