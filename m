Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280393BBFDB;
	Mon,  3 Aug 2026 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785748033; cv=none; b=hOsyj0r8uDfaAaz0MJNpM6Lfu1o+YIKe7VQoSmLlpPJ5a1hCWk32cKY90OVhu/Gitgpv18tSDkuthL8ONOBzBQ/2P9g1xuylnAEnNJs6/r9CUCGfHGB8EvIMn0sFiU7eEvuVZhdKpiFfYLDXTl1KqSd2KiuJo79zb42XKitUjmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785748033; c=relaxed/simple;
	bh=cix1caSpagdVM2y/iGCVCvWdWm7iaPq/7TOVY3O6Iao=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b2Dz5URkn3bSgTGk7tCsd+FpaAoV4vUDIDOPLT4/wj6FvQdnfZC3b73fUYPtLlieZu9hba74uUFEZ2CRqzA+1eXtnN3xs8q4Gjm6gOf95p1Zr+icfAq0BUF+2eemDSs5c8baNUP3nNopUlvJfBrpkY/injVNhhNgeVvwC0BsWcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=AuGMxT/O; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="AuGMxT/O"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6735hHdG490521;
	Mon, 3 Aug 2026 02:06:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=0ghK/bHWVhFAELNGljeYZIiXRp8blDDlnVpWM
	9nrKUg=; b=AuGMxT/OosoD3V1q6XpdaQRjk6YZhmYHz/qx9mi22quude+fmaCWj
	1MbQNK11gk9bq5+fDfAQJi+VGAEoH7M/cnu6GhfeJgTjZpSt4fqNmhMdFqXHg8V6
	IkkvqPgii9gFVc0VuD5UXYp0FrJ8EeiuJpgeyuGjbaRwvyMNIn9gNb6WObU/XPc8
	gC8wlfhrTShNEwrkZ3C9uoJrPnl7VL0NAQ1sX5y7U50wzV4/oy9D+xkA3Ci4JpEs
	ynSyefCgLmSJnMBGCIQnd2i6L/5jw5gsx1WF9xcEK5eeCSzAZPpf8lG4LWUbMMEk
	VPqhJLparUvE+24NbQpglC2Q8ertu7luA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fsdw80c3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 03 Aug 2026 02:06:43 -0700 (PDT)
Received: from localhost (2620:10d:c085:208::f) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.45; Mon, 3 Aug
 2026 09:06:42 +0000
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
Subject: [PATCH 2/9] perf thread-stack: Report branch stack hw_idx as not available
Date: Mon, 3 Aug 2026 02:06:33 -0700
Message-ID: <20260803090640.2412336-2-aaupov@fb.com>
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
X-Proofpoint-ORIG-GUID: pvrznZBnpB91_2NTEiNB_sZCTbJZ0Ta0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA4MSBTYWx0ZWRfXzV2QmRQ0/eSt
 6AQVobwJUgaY2hfKbvuBVDtNXVQKGQvgvYmSGcCgmqWo//nVJXy7KnJ9811c8nsvz+GgeiOKvlI
 5dcK9xDSpgEqxcL0kSeOiXoVFRbBJOs=
X-Proofpoint-GUID: pvrznZBnpB91_2NTEiNB_sZCTbJZ0Ta0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA4MSBTYWx0ZWRfX306oAGCw+eZQ
 PoccYJzHNQqelf5HYONXdUjJ7cLcjM8DcVp4I8FuziGoTCUXRG/wj+xy95DBqhvcI0kqo0KntVo
 7hg1xQCoouWmg69gCtZY4+LUUHeszpAMVSbesrkOeVzeAszj4pJwtUbLgGHENyKBLkI35JqMPJK
 B0ce3WFrTKZW3HMbMEqy+axdk1aR3RWLh3tmpOXrs8q9mMYzfU7IdrYnH8iEFyrm3Yf5qREW97C
 /HzNFx9SfYBa/81jg9apntldSsfTL1YmkkB8AlO+u7li0GF4yLYe6C6Ciz+VXuCFilksBv8URm9
 AXpR9ketFfk2mVCLSqhYS24u9uncP3+GiiyYIOFBPmjAEbMdCqKOZKC/ZwZXZG4atb3wyv29VWB
 p9pef/tCJV74M//hbnXzOfHitYtts0BCMQ9PQCQhW/OlfWmpLoQaWjiy4A2ekYm0QidfhzQsfXH
 2TRrce7Jo8PPs58Y4AA==
X-Authority-Analysis: v=2.4 cv=auGCzyZV c=1 sm=1 tr=0 ts=6a705a23 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=03ozwUkBphtHgyqjj1sw:22 a=FOH2dFAWAAAA:8 a=tFPw7G4F2t7FTvsiR7UA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01

thread_stack__br_sample() and thread_stack__br_sample_late() fill a
caller-supplied branch_stack that is typically allocated with zalloc(),
leaving hw_idx as 0. Zero is a valid hardware index, so consumers that
honour PERF_SAMPLE_BRANCH_HW_INDEX see a reconstructed branch stack
claiming to start at LBR TOS entry 0.

These branch stacks are reconstructed from instruction trace and have no
hardware index at all. Set hw_idx to -1ULL, which is the established way
to say "not available" and matches what intel-pt and cs-etm already put
in the branch stacks they synthesise directly.

Signed-off-by: Amir Ayupov <aaupov@fb.com>
---
 tools/perf/util/thread-stack.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index c5ce741b07446..1a3dffa83bde2 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -624,6 +624,7 @@ void thread_stack__br_sample(struct thread *thread, int cpu,
 	unsigned int nr;
 
 	dst->nr = 0;
+	dst->hw_idx = -1ULL;
 
 	if (!ts)
 		return;
@@ -686,6 +687,7 @@ void thread_stack__br_sample_late(struct thread *thread, int cpu,
 	bool start = false;
 
 	dst->nr = 0;
+	dst->hw_idx = -1ULL;
 
 	if (!ts)
 		return;
-- 
2.52.0

