Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F8F3AFAE4;
	Mon,  3 Aug 2026 09:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785748033; cv=none; b=A1WP0IEeaIirRabGusXvTsWERNhSZA3amAGHMlFMP710fWK2SuZ8ooDbH/ctEkg7SPJTic3zlrV4fgw5Ve99uzrO+oiMw8B+lE41Cuj44Q4fwDNTFk0ZoiADglYzZKVin9z8o6fMdYQAXg/uLfwd4z3PJxVh2NSAzkAjaO+JPwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785748033; c=relaxed/simple;
	bh=JfiZgDWS8pyWeZ9WkI03G6Sd45FIcPt+bN8lvDW+LBk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sqirmx7CFT2W0l+CjXPIEBDxNujyQ6TjkBByR0n3nF+UoXsY28LwA2aYnFU3lIetjxhTqfsG6qYTkLNMK+9U5k72InOfzeMG0u9YDN4GLB+tUyPjYbjoBOSCCwywk+ZmkX+SQXY5uWLziEbHe6vhZkqyEY1bQBZd9K9oqY46RF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=D8492wkh; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="D8492wkh"
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673397RE014245;
	Mon, 3 Aug 2026 02:06:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=tiyOmtBwKFcxS8DiEx/nBUGoJzHwVrrKHwtU1
	sqSgug=; b=D8492wkhk7AcbaozxmOCQz9jrgwizHkgnqC8K6g5DiGwHO/H804mF
	qK9EwC9TwHNB0Pkw4vw7FovnE3nppF4e9Q4fDpbpYWEdUGqnEBTcTHrCrtgdWmS6
	4dFoBjsaQZ6Igs1cdUCPeU+r1jRvJURCbBu2GbbyaQ1bZDG9CRRRWS6bMFiAqPtr
	04/I0S2xNuqbN6J7rJso29s1evtn7cPftQntiQFKVHxukyx1dHvPe6qPQFE5bihF
	5oFpTNuoH0UDB5gy6d8KFH67OsOJAvD5n61/67ZOwV2tClv2VToyycA+50S/eddC
	UibZI5JYSYStVcAue7wlsh69Rf8Qa9Zmw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ft2edmdjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 03 Aug 2026 02:06:44 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1b::2d) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.45; Mon, 3 Aug
 2026 09:06:43 +0000
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
Subject: [PATCH 3/9] perf thread-stack: Bound wrapped branch stack copy
Date: Mon, 3 Aug 2026 02:06:34 -0700
Message-ID: <20260803090640.2412336-3-aaupov@fb.com>
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
X-Authority-Analysis: v=2.4 cv=WYY8rUhX c=1 sm=1 tr=0 ts=6a705a24 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=GbPsI2Ihf5RTnMjR_gZv:22 a=FOH2dFAWAAAA:8 a=kuOsLC8opfz3ArVD95IA:9
X-Proofpoint-ORIG-GUID: kASkysqwMcx_ZDyBJy9rZ_01UDOf-Fpn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA4MSBTYWx0ZWRfX8Rut+l/luVkR
 BMrMd3Id17QClSWoQRwO7DU2xVcp8AJzPoX36rBhol0y6Xy1OQkVm5pYRCWQic74qq8ZMGamPb1
 JnOrgh+kSYh2w8pucBh8DunkJpBYufT2tgl9JuOmmrBZAW0n2OXHF+0CONyh5ce6jfFxcK6wJPZ
 m6NalIRqlOp6bmbnwzjurUKhTX3+1fvrMoNSGjfwf8pWJoWAhvJKLlqrbKQ6WlHZmD/HYfjOX4z
 gXos7akx+kkCxmyiNiJVTR6ksld18tN2esVgF9xsLUY0GvUoRb5Ksxvy6CLTp9objrXKjGjYPQG
 64YpbiTi/sg4SmTa8TTm7XA5vUVEQqZqQtnoXZDuaD1ez1BPuh72m8H8S0OfGI6f7Bxg1XR6Ek8
 5FsDy1yB79SjtJfhCYam5L+Q113QuINba5mKHR2FuqxrCdFMMM3peGfKjiFNtuqXMkpvLyA/EV4
 DRwvfY/r9ksjEZz2B8Q==
X-Proofpoint-GUID: kASkysqwMcx_ZDyBJy9rZ_01UDOf-Fpn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA4MSBTYWx0ZWRfX2DX7hkHpVtf1
 OZWsPDIhHYx2ngvFpQG7OcrroQezuk7dcwoLyYMNY/WQl3RGSNaS7ldsXc0lE1Y+viFxZ8xTl3o
 8fNH023RSOv80ha8yswEajs1yVoQPoY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01

When the internal branch ring has wrapped, thread_stack__br_sample()
computes the number of entries that still fit in the destination:

	nr = min(ts->br_stack_pos, sz);

but then copies ts->br_stack_pos entries regardless, overrunning the
destination whenever sz is smaller than ts->br_stack_pos.

No caller can trigger this today: both intel-pt and cs-etm size the
thread stack ring and the output buffer from the same
synth_opts.last_branch_sz, so sz is never less than ts->br_stack_sz and
the two values always agree. It becomes reachable as soon as a caller
keeps a larger reconstruction ring than the requested output depth,
which is what --itrace=L does for late branch sampling.

Copy nr entries instead, so the destination bound is honoured whatever
the caller asks for.

Signed-off-by: Amir Ayupov <aaupov@fb.com>
---
 tools/perf/util/thread-stack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 1a3dffa83bde2..51eaedb47bb1d 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -643,7 +643,7 @@ void thread_stack__br_sample(struct thread *thread, int cpu,
 		sz -= nr;
 		be = &dst->entries[nr];
 		nr = min(ts->br_stack_pos, sz);
-		memcpy(be, &src->entries[0], bsz * ts->br_stack_pos);
+		memcpy(be, &src->entries[0], bsz * nr);
 	}
 }
 
-- 
2.52.0

