Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DD53EBF16;
	Mon, 17 Aug 2026 22:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005379; cv=none; b=cNi36+68Pn/qJid/pDaQVNgYdUq3MqV7TtHNJbPnGF0/4QDzeUGpw2yQK9LJ9q52xBVxzakj3AHS27X+M9X49hdr4YZbbuhmhoqYQBd/e3Xy+Pc74+0DhJOs8dWmCG+kiNYcWWrf7bpOIjMRJB/CJ5jgy+GK4+V766/6Uomj+TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005379; c=relaxed/simple;
	bh=qBwGeM0IuAteooUuYw0N76x2sCp6Xaglj+gNgKcXhXw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QqSBywFt/BCCGyiXps7Vg+uHtrbWcS2EtU3lsS4GI5BasXOIU9PwfYBuydA3LFXOapRw+Ki7Tr/ISY/Td0a3VRIdOJR/OOgI4iZ2pQ9XBAzE5WsZLgIEqjz9stal2PcUrSTCpKShdkhF5ucMg3fi5rwTgXwPKiZrEuKZ9gDlA/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=acy0N6Ib; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="acy0N6Ib"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HLoD5w1568991;
	Mon, 17 Aug 2026 15:22:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=fcOjNh83Gg6HFDGJpbZwAA6h6Wl/YrAEepi9Z
	g4D8Ok=; b=acy0N6IbraVT/NecS434c3ymxGbUWtkhBvwJH310BmkalZHvn4K7j
	Bd9mbIcIYItD3L43GY2Pj9jOTR7Am3GW7H58mSOqitioNBjDOda6stU6cWWr+J3A
	jiRdBeXEIkCgWURuo5Mu8PsrBTGu8/YhovWd9YGsIsuccLGyNfRWLAl8AngJD56W
	2Ak4a6K6x7t+HepkH0T/p/M0kY4cXp8lH5dVOB/gJYVwCULSI/P56T3doRgDM46F
	LGE1KMCFvTk/HKZw4EiAvD/Qzm6op+tfWuMW89sbqqPBJDubkLDAPmBKE3002XVW
	+3mGRoHVqSvXYK08KPZauvkONmfdniEBA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4g2m516h9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 17 Aug 2026 15:22:22 -0700 (PDT)
Received: from localhost (2620:10d:c085:208::f) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.45; Mon, 17 Aug
 2026 22:22:22 +0000
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
Subject: [PATCH v2 1/5] perf dlfilter: Add non-empty branch stack filter
Date: Mon, 17 Aug 2026 15:22:16 -0700
Message-ID: <58f96797f94467859fec160320a7b9426be8cce7.1787005265.git.aaupov@fb.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787005265.git.aaupov@fb.com>
References: <cover.1787005265.git.aaupov@fb.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE3MSBTYWx0ZWRfX+2mldDsupIRo
 1lIsmoKUEegP8JvhX2XHnWW27TKbEyyzvrWKsMNwqno23F3qQ1iKrMlucv3uM5eC4kAk/bi5Wwi
 s3b5H4x4C8se/H5VOmlUsGQImOWYFkw=
X-Authority-Analysis: v=2.4 cv=W9cIkxWk c=1 sm=1 tr=0 ts=6a83899e cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=tpM8CJlwf7uhpglF1g9U:22 a=FOH2dFAWAAAA:8 a=KKAkSRfTAAAA:8
 a=V9ESVAem-2N_HGRc-uMA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: vE5hBX1EEVsbfIHBGa-MQBuLixTyL6WD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE3MSBTYWx0ZWRfXxCROpaD7YfDG
 gHmeABRCoFSbVXlW7Qh1mI7z3HrQgLu0viiABMkF56My67jZGbh+u/YzEpH29Y/2ECyQpEtoOF8
 pG3DSWVNk9IvKN+infIdj9yoe9S9YRKb3OKtT/o2As337RelASj70SJHNbE+J1gt3fyMsiECCe2
 c0ohp9hFVUsBBdifup5ydKFCqxSoQw/PRzIsYtfvYLCm9fo+kODPfY/BF4WuGws8gWtdRKftoLA
 mSN7jLVvh9B9+ps7srRkGghCeg+B+j8S1dd6WqJSUB49MlCxhsDmL50RNmJxi4OrJmbaTPrc4/U
 4FvARLCAwJfXc0V6yOf/Guei0FhGJT4CCCrhHD+iUVRs+D1/TnBCauQd37gI4LK0yEPR5uX6Tzm
 ZD5cnc0jAfjISDEhTFb4mBL3WA4V6Di+D70t4meoMVRR64MUc7IC1DAWR9e69lg9GgBvr8HoIkA
 RyKD/ourwaKLrKhNVWA==
X-Proofpoint-ORIG-GUID: vE5hBX1EEVsbfIHBGa-MQBuLixTyL6WD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01

--itrace=L adds decoded branch history to existing samples, but a sample
that was recorded while the decoder had no trace for that thread keeps an
empty branch stack. Consumers of the resulting perf script output, such
as profile generators for context-sensitive PGO, have no use for those
samples.

Add an opt-in dlfilter that drops samples whose parsed branch stack is
empty, so users can exclude them without changing default sample
semantics. Build and install it alongside perf's existing dlfilters.

Assisted-by: Devmate:GPT-5.6
Signed-off-by: Amir Ayupov <aaupov@fb.com>
Reviewed-by: James Clark <james.clark@linaro.org>
---
 tools/perf/Makefile.perf                      |  1 +
 .../dlfilters/dlfilter-nonempty-brstack.c     | 26 +++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 tools/perf/dlfilters/dlfilter-nonempty-brstack.c

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 29cfd44c427f3..750bd1cce1287 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -425,6 +425,7 @@ PROGRAMS += $(OUTPUT)$(LIBJVMTI)
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

