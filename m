Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25F83B8412;
	Mon,  3 Aug 2026 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785748033; cv=none; b=Ybsn4TrQWlcx66r9aAnlbFbFI/xPQR7qsqv6Qwu+uim0DOgP9VT2C6KMimlRsjY064JVZ4zdQAcixbOvOXYoYhM22OjYyt8ixu7BiLUa2zN5KYcJccP6dtxGbMNXkNfsvuhrlFs9tcuAO0b12zPvVBV3ZcO9WD4ZPOYmt17C7ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785748033; c=relaxed/simple;
	bh=YQ00c8i8V2FurjXU1b5HIXKK7YVEKkhiCgG2UjpQoZQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a6+tbXFax62MT9jGMABFMi770aQcMFj4OXl6FYR7D3gcLLiaOEQ138k3JXJrgO9YZGXkok5gTuKyjqWRjqyRIPMoLvQ0v9vpOTvLazCvuHH2WulSY765Leim7nJ5lqpHIV8lYAF8NMM7hQfyfvL/Z1xROFlQE5LTxe/8b7ha3xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=qLsY1Q1q; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="qLsY1Q1q"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6735Dkfs283605;
	Mon, 3 Aug 2026 02:06:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=qhvvUEtEfWoODdofTIYNfBNSRpCWZhs8L4PbC
	BJfhZw=; b=qLsY1Q1qOCiKaYj9Z/QvYscJxaQCvcFHioJsduwZzhU+0ArF6QQc/
	HMmygM34x/jC5lkm5FO9o5IiFVincA60sBG9/39osKmuQaJvjhJ526MyO009chTp
	Rn00/VsHOb36MnprwRwo+ovxSwOSElMpBQT7vBi4cgkXdMYIFVfKhZ4rxptyQzrM
	dz3+yXmHD790EZBUj3TVVRVaK7JBYx5yWTqMSYhwvb/65NDcfI1IH5duk6lrvrZl
	Xy54CZWEpMC1b8t/JrcDRaIGVCaAB3D2wKbnOkzIKu8clc8WEbKWFPWJTenniaos
	mPSS2uOUwJ5WABdx6CnTDqcrw2xtWNstQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fsg3h00de-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 03 Aug 2026 02:06:44 -0700 (PDT)
Received: from localhost (2620:10d:c085:208::7cb7) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.45; Mon, 3 Aug
 2026 09:06:44 +0000
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
Subject: [PATCH 4/9] perf dlfilter: Add non-empty branch stack filter
Date: Mon, 3 Aug 2026 02:06:35 -0700
Message-ID: <20260803090640.2412336-4-aaupov@fb.com>
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
X-Authority-Analysis: v=2.4 cv=PtSjqQM3 c=1 sm=1 tr=0 ts=6a705a24 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=crHB47gyY4rKiduisYu9:22 a=FOH2dFAWAAAA:8 a=xLaWpbBnj8biFduWQD8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA4MSBTYWx0ZWRfX35tavSruDhN6
 mnO5AkbkYWqB2syzU28Jjm2nkZABQSpcpA6DFyV0vm6Q0HPt99cYA8gEdkFBT2c5RshrAFm12uA
 lQ9GrUonqN1Dwm/MrVsEqz/KTdCL0Uc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA4MSBTYWx0ZWRfX7wp/MPWxfm7s
 8/gHwq13e4ODH40iYpbWlPZMbNzS9pWdV0ZVQShHhoLhyX7gY+1uKW/kk13HY2tYx+Rr5aRh47+
 EmMfhOxkw91yJzDsQn16flb9zqAqlCf+GTDzrNApHwusZXCauFWD51O1YBvPg80Z9b9/hOHUHur
 62SG7z4iUPjA42YCV28VAtIi3lIvSy2PVjYJyas8qQcA0ca/uHmH8e9kxUbDScC+XyMTIRvbEiS
 oMXrAqqPVHP6AHeVrn8+pxaDjwrccosda5iyL8e+vMDVEvz8V6CDS/aMEQsdzVOMOXez11STlYc
 QmqNcXtBUS3ETXytojoEdOK5MKjYBYN4nPJ6lEzqr+xlPtFQXFmWmPHPu8vRRLSyGz+RT3JclwO
 fC/pfVujro8G/xHQREP/eisV8TMfHV+GA2Q7Ht3iyLsaLU6dNmBlfxepwyPTGTVbO2rNZZ5+ppV
 /Eelj4QNMxtfTXdyW+A==
X-Proofpoint-ORIG-GUID: jxuHbwdfb23KNCIq2bmwgCYgrm9jxTU1
X-Proofpoint-GUID: jxuHbwdfb23KNCIq2bmwgCYgrm9jxTU1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01

--itrace=L adds decoded branch history to existing samples, but a sample
that was recorded while the decoder had no trace for that thread keeps an
empty branch stack. Consumers of the resulting perf script output, such
as profile generators for context-sensitive PGO, have no use for those
samples.

Add an opt-in dlfilter that drops samples whose parsed branch stack is
empty, so users can exclude them without changing default sample
semantics. Build and install it alongside perf's existing dlfilters.

Signed-off-by: Amir Ayupov <aaupov@fb.com>
---
 tools/perf/Makefile.perf                      |  1 +
 .../dlfilters/dlfilter-nonempty-brstack.c     | 26 +++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 tools/perf/dlfilters/dlfilter-nonempty-brstack.c

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 0031112c036e8..aeb8085b0756d 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -427,6 +427,7 @@ PROGRAMS += $(OUTPUT)$(LIBJVMTI)
 endif
 
 DLFILTERS := dlfilter-test-api-v0.so dlfilter-test-api-v2.so dlfilter-show-cycles.so
+DLFILTERS += dlfilter-nonempty-brstack.so
 DLFILTERS := $(patsubst %,$(OUTPUT)dlfilters/%,$(DLFILTERS))
 
 # what 'all' will build and 'install' will install, in perfexecdir
diff --git a/tools/perf/dlfilters/dlfilter-nonempty-brstack.c b/tools/perf/dlfilters/dlfilter-nonempty-brstack.c
new file mode 100644
index 0000000000000..9e66205b841d5
--- /dev/null
+++ b/tools/perf/dlfilters/dlfilter-nonempty-brstack.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dlfilter-nonempty-brstack.c: Filter out samples with no branch stack
+ * Copyright (c) 2026, Meta Platforms, Inc.
+ */
+#include <stddef.h>
+
+#include <perf/perf_dlfilter.h>
+
+int filter_event(void *data, const struct perf_dlfilter_sample *sample, void *ctx)
+{
+	/* Return 1 to filter out the sample, 0 to keep it */
+	return !sample->brstack_nr;
+}
+
+const char *filter_description(const char **long_description)
+{
+	static char *long_desc =
+		"Instruction trace decoders can add branch history to existing "
+		"samples, but samples that were recorded while no trace was "
+		"being collected get an empty branch stack. Filter those out so "
+		"that only samples carrying branch history remain.";
+
+	*long_description = long_desc;
+	return "Keep only samples with a non-empty branch stack";
+}
-- 
2.52.0

