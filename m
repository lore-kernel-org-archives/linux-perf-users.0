Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8396F3BBFDE;
	Mon,  3 Aug 2026 09:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785748042; cv=none; b=JNzQMNL+IbIxLGK2wNfqXNLYRcoNRt5MYFsSYnww6DVDecTQ5cOsd4nI8RClxNuqt+W0KOMF23S9s+Xm2fkX6sVuhfse6hpXdf9v1SJrGDFrJjtzhArfj6itc/Q1CU3I+wzXSEGBmmNIJ8PuvBB6klohgHdZEW7P69Lrk4T3Dbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785748042; c=relaxed/simple;
	bh=GyE6FZLjav3R4aETg2YusA0YagUWDmkt3Apcbxt8rn8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QtDMWvsxH1F7FTzcSDZFreN/rvEoruYCkK9raRBzGtKlOjTWXgFIG3nuahcIrvGMHe+c461/ScDSvj9UdMcn/dpxgFIi82DeXOGNv3jiNOBijtaImk4Q+u+UzhB4yYp/J9+EWsuL9kaQfp0EfFG3T8zxSt81ts1xbfypy9wYQhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=SWLcAKd0; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="SWLcAKd0"
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6733rHUQ163426;
	Mon, 3 Aug 2026 02:06:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=jOiASshXSGNOrQbG7iUlsXOHA6KnTV+FugoXN
	4etdkY=; b=SWLcAKd0Y14AdMrKmXDMRgnLo6R5XimLqlf/tS6ac+g9tsD6WePQF
	c0TyaLP3J9iEYws50rlWUtLOIKTe340asZsN5Wr923sZ2Rz98MHtgn7QoE8zOdtd
	M/RaZwolEqM4xmy6oDcPY1ECvChcZfJSwgeiOvtUztGgddG6W0DOE23Av0UEgmKZ
	vxWrVS7kfAAQRifE8RaIEFHwF9pvPTq10H+aCX8l2q0SgUKyOGjTlD1bpW1TI497
	H5SM3S9sr+zFg8xRifHjoo8xSYwIuikrcU4I/CJiyEn+LaHqdWC/yvWhzvd3OQmC
	DsT8VFJa5BDGNc2LVRvoAD+78Xa5L00cw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ft4tsv1nj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 03 Aug 2026 02:06:55 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:fe::f072) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.45; Mon, 3 Aug
 2026 09:06:54 +0000
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
Subject: [PATCH 9/9] Documentation: coresight: Document context-sensitive PGO workflow
Date: Mon, 3 Aug 2026 02:06:40 -0700
Message-ID: <20260803090640.2412336-9-aaupov@fb.com>
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
X-Proofpoint-ORIG-GUID: o7oN519_Altz3M3Gh8SCSWSS8yO-rHmj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA4MSBTYWx0ZWRfXwK31pUOZLfci
 Kq/eRub8HKPtvx/ipqjat5jv2WqtswBDm1Z8YklCGKsBlPUxr2lrEujqCi1O9bWaaMZgheNPHXG
 FVmKie8rjAB+naKUSpxCpuh44oDL56y8tNSnZfU0aWc2m8ONfzq0W4tFUB1M93EKh+wVfyPTJJa
 XvndH0fnUvfdrfTYkFtRQKOEAWpiyaUsqrkSlQaSFyNLViW6wZiVV3dxipn0mzRuQfmEtud2+GA
 nv7tl/YEPl2f9EgFaEuqvupWlFswDRY7MQ76+stX8gk+ZyUxCWAHd433r4O3RqaSM1lxvKbAUD9
 kn0O4B2uK1ll7vJuWy3wCH3gqLotINhxAnZzJxiz4UbCTmqVBRNGg1vWRKs8J5rcFKoPSQgJSOQ
 N9BZAoeZyJdm2gSQOmmMV9QwOJjWK4onHqOPA7bGU2JyQC/0fEBHbW2hJjD7lXCP6JuPap1Je5L
 4YMqleqHAZAGnwxNvsg==
X-Authority-Analysis: v=2.4 cv=fYidDUQF c=1 sm=1 tr=0 ts=6a705a2f cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=4h92JMTCafKA-fb_NiOh:22 a=FOH2dFAWAAAA:8 a=QDGUGMRHXpoeSueRYaEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA4MSBTYWx0ZWRfXwyTI5tCyGdcg
 0v/F63zt8mZNaY886S+U5BRI/BxEMebMQdll5mdR0JTJTIimLXfPvyyfNDQF+w6QZdxY78GT6Al
 v/OvglASeOX+sOFdWIjAK7AMuQV3GnQ=
X-Proofpoint-GUID: o7oN519_Altz3M3Gh8SCSWSS8yO-rHmj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01

Document combining callchain-bearing AUX pause samples with the ETM
branch history that precedes them, which is the pairing that
context-sensitive PGO tools consume, and the --itrace=L64 decode with the
non-empty branch-stack dlfilter.

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

