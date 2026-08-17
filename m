Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65F12D9EFF;
	Mon, 17 Aug 2026 22:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005376; cv=none; b=NSBDhw3u5lT5c++CBU6dRZ3Rp/DkustiatVXItB6Kf/f/pVauAPbEvoupEjty+LU/X5RR5vjjMSZN52rl3q8oA+0HDTAJWDiRyiih53rESp++1AlXWmxlk7uwVPXT0CuaJ9A9vIxTRCJpyUH+Zq5EyTQBSd8Kf+aB74XqUKxRFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005376; c=relaxed/simple;
	bh=QETZxygJiVaVczGTUmxrvvzHpl3GQGlrCvPV97zh9X0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CjVWd+q2jsTARRVR1g4zCHuOIL+oj/NL4kaaO2Xwp39dtXeqJjMBGUFXv1PbLP5D/0WHFoNwz/E5R9cQeEZThNNxFWwBSxPpmNAi1KCKXFgiZP4glx/6KnsMuLrM+8QqPmVLp75bS0Z/cRrt6ihlpaHAPiKJ+QQiyXlXP6d5oCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=S3tumvlC; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="S3tumvlC"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HLo6JW1568585;
	Mon, 17 Aug 2026 15:22:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=QA3sfzUpR36V83Sktub5Y8E5Bqm2HmxtE56t6
	ViakSo=; b=S3tumvlCcRJM9mRtBsAbdgm9S3Iq+Rm9NHqh9GYrAMAvg8fiLyRt1
	1BM66TZ19TWiY3sr14Twa6BQJfOwEuRxEai6EnyDzGtTNcfD7rMIs8MQ1tCJDgEe
	emEzbQWgFDONdUPrQWPgnqJG4zeMKd+VTULYeHW5YIp9aDAV2wP/SnR7VdNu/TF7
	H5FcNy9ighxK7D0jnl8dcWEZr+a9ZhmUFWDjxHH/5zPm4EKpZfAQL4nS3F0wNjCv
	Nm5Nh2b8QG5SpVNMJVWV+JCmrhKQTTl/YUuoCmfEST5WPFkpsGNZYti+3l8aZ1LE
	Bij5ko/ZGXT1jQ13NB66ATo67qm+Krviw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4g2m516h9c-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 17 Aug 2026 15:22:25 -0700 (PDT)
Received: from localhost (2620:10d:c085:108::150d) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.45; Mon, 17 Aug
 2026 22:22:24 +0000
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
Subject: [PATCH v2 5/5] Documentation: coresight: Document context-sensitive PGO workflow
Date: Mon, 17 Aug 2026 15:22:20 -0700
Message-ID: <9c4b59cac4a2cb21ab552398e3deda9e5067fe32.1787005265.git.aaupov@fb.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE3MSBTYWx0ZWRfX86pegc5PAdDS
 oWEyRoxq7fivVx5qZIwUz0sRmNAqBcSoF4RCDS5J2GcXf1RYNcFMtlhyy9fkQvHP3WuxQ4c+8t0
 WgUE4RGDtzwhYWzElzmGqntKNd8eQt4=
X-Authority-Analysis: v=2.4 cv=W9cIkxWk c=1 sm=1 tr=0 ts=6a8389a1 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=tpM8CJlwf7uhpglF1g9U:22 a=FOH2dFAWAAAA:8 a=QDGUGMRHXpoeSueRYaEA:9
X-Proofpoint-GUID: fTOAckTrz00MqZBg9mhMlcohR2Y3XDRT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE3MSBTYWx0ZWRfX8/GrdqnvpG2x
 AiuyLYuERMlADDlBReLE46quACr8JAFy8iL9RbdISgn3ph+gfPuN15d7pv4K++6QfZHlgPDs3I7
 4n4FLVPm97LrZwUgIyYuPL9EdOcusAHH9BZ+YbWudOKG1bhU67X2EaaV8K0dv7IF0Bdx0r/mRhI
 muPpGgvDPEXbClEzAOznouw1mMWevk/k0KXISBVCFYZoG1Up/XxUFOjHfbMzfLTc3/x298Dzjhs
 Uox60eX3lDKfWge5Wqts9Ey4dSAJBv1jngRuJUoHmORCx9zg73TDNSVZFxlk1bjWrpEQgrH8l+y
 GMBlz6U1f3t+xLHbzIbw8+j79vMDE077PDrWrSiBl39Q3Ne3eH4WS6l/Dl4tQe26tLpvGiUVLcm
 ezX+o++X9274EolkeQbn4umZDzxrLjz7b48a8qj3VuetcuQ3h4cJ7vYqH2+tMLsG64irBKv1ySX
 n+fnNgL6EtrN2PMQgsA==
X-Proofpoint-ORIG-GUID: fTOAckTrz00MqZBg9mhMlcohR2Y3XDRT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01

Document combining callchain-bearing AUX pause samples with the ETM
branch history that precedes them, which is the pairing that
context-sensitive PGO tools consume, and the --itrace=L64 decode with the
non-empty branch-stack dlfilter.

Assisted-by: Devmate:GPT-5.6
Signed-off-by: Amir Ayupov <aaupov@fb.com>
---
 .../trace/coresight/coresight-perf.rst        | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/Documentation/trace/coresight/coresight-perf.rst b/Documentation/trace/coresight/coresight-perf.rst
index 0a77741a431ef..c0c82b3d26ea8 100644
--- a/Documentation/trace/coresight/coresight-perf.rst
+++ b/Documentation/trace/coresight/coresight-perf.rst
@@ -109,6 +109,68 @@ Example for triggering AUX pause and resume with PMU event::
         -e cycles/aux-action=pause,period=10000000/ \
         -e cycles/aux-action=resume,period=1050000/ -- sleep 1
 
+Context-sensitive sampled PGO (CSSPGO) profiling
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+A callchain-bearing pause event can be combined with the branch history from
+its preceding ETM trace window. This provides the synchronized callchain and
+branch stack consumed by context-sensitive PGO tools without continuously
+recording ETM trace for a long-running process.
+
+For example, record user-space ETM trace, resume it periodically, and pause it
+with a cycle event that also captures a frame-pointer callchain::
+
+  perf record -T \
+        -e cs_etm/aux-action=start-paused,timestamp/u \
+        -e cycles/aux-action=resume,period=8350251/u \
+        -e cycles/aux-action=pause,period=100003,call-graph=fp/u \
+        -- ./workload
+
+The two cycle events count independently. With pause period ``P`` and resume
+period ``R``, each trace window is approximately 0 to ``P`` cycles long, so the
+average duty cycle is ``P / (2 * R)``. The periods above give about 0.6% duty.
+
+Do not make ``R`` an integer multiple of ``P``: coincident pause and resume
+interrupts can produce zero-length windows. Choosing ``R`` near
+``(k + 1/2) * P``, as above, moves the resume phase across the pause interval.
+Pause events that fire while ETM is already paused have no branch history; the
+dlfilter below removes those samples.
+
+The ``-T`` option timestamps the pause samples, while ``timestamp`` enables
+ETM timestamp packets. Both are required to correlate the sample with ETM
+trace. This mode also requires virtual ETM timestamps correlated to perf time
+and a callchain on the pause event. Use ``call-graph=dwarf`` instead of
+``call-graph=fp`` when the workload does not preserve frame pointers.
+
+Tuning duty cycle
+^^^^^^^^^^^^^^^^^
+
+The example above favors low recording overhead for fleet collection. With
+independent counters, ``P / R`` is the nominal window ratio while
+``P / (2 * R)`` is the expected average ETM-on duty. For ``P = 100003``, two
+measured Neoverse V2 operating points are:
+
+- Fleet collection: ``R = 8350251``, 1.2% nominal ratio and 0.6% average duty.
+- Targeted profiling: ``R = 1050031``, 9.5% nominal ratio and 4.8% average duty.
+
+AUX buffer size must also scale with trace volume. A 128 KiB AUX buffer worked
+at 0.6% duty but was unstable at some higher-duty points, where it increased
+output size or overran and reduced useful-sample yield. Use 4 MiB as a
+conservative starting point around ``R/P = 6.7`` to ``12.5``. These values are
+workload and platform dependent; verify useful samples per MiB and lost AUX
+records when tuning another system.
+
+Add up to 64 decoded ETM branches to each existing pause sample and emit the
+hybrid samples in the regular perf-script format::
+
+  perf script -i perf.data --itrace=L64 \
+        --dlfilter=dlfilter-nonempty-brstack.so > perf.script
+
+The ``dlfilter-nonempty-brstack.so`` filter drops samples that ended up with
+no branch history at all, for example samples from a thread that was never
+traced, or samples recorded before the first or after the last trace window.
+It is built and installed with perf's other dlfilters.
+
 Perf test - Verify kernel and userspace perf CoreSight work
 -----------------------------------------------------------
 
-- 
2.52.0

