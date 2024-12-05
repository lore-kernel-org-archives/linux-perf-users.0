Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7921BC9E6;
	Thu,  5 Dec 2024 21:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733432885; cv=none; b=SR2NXdbTkXZqfGyOhKKHPgYCbysWL2cEjjhTmgd+nBc7XpzCZKGc1Mi45Tx3Vybnt3vQUcBjTheoX7AT41FCAEWTXACKeHgAz+ZNUXAZsIi8n96rX4h2FM/sKJWKrTJdjj7ZVMFMs4kjMjvUQvZkcecKQn/gNjRYTWSgySi3Usc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733432885; c=relaxed/simple;
	bh=tCUOmXVTpbr3ET1gv/NLvDF/lIGUV2cRX+9cn2TabeA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dTi+XOlOzwXR5HSUY+xJOZ3bQoXkrKHxfoC091YWdGKOHesVCoZdDrkKGu0kQdxGu5XmCl7dbAvvX94OyEygdWwiNXR6E/f+C6Ihc9oD6MBAk246oipPULe7FvuwlVTJwbclRW489/R9DfuFERq6IvjFZT7ce8kI94iOcUCHRik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=S3QFfenO; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="S3QFfenO"
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5KSAa0025348;
	Thu, 5 Dec 2024 21:07:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pps0720; bh=rQ/Sooz6gQjqta7E+P2ay5WmTnEqQNkXQ73GB
	cBPjcU=; b=S3QFfenO2tlW7ZbEZkaqhSt3MZOD0F9/mprdGC1Z7ISf48jHEZvDe
	/PTk05CPmiWYSLu/R1u4edDPWqCMQ51vNeujFJNWmYWjqq+SSDzm8OIuy9lFxEmS
	mCftDd477jwgWr9/vpo2ThlPrsPOR68iu3teCnJBbRcde8rb3reGSss+c46iQLTX
	hap+1vZJSjS7BobLP3NKKWpmnoKUOaMExsifU/oSTbKpHkcTyEQrsuNNCVlPWjmK
	Sx2EoULH5ISFtEVdKsBxKfFmKf71JiVrH0eYWsqjOuMKPxK1Y88ot8mJqnv7OxRa
	lEQnHF84oKOD1Sf0HlPXt4hxDxzjQxb3g==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 43bk82gaf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 21:07:44 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 41186806B72;
	Thu,  5 Dec 2024 21:07:42 +0000 (UTC)
Received: from cat.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 8448D80EA31;
	Thu,  5 Dec 2024 21:07:41 +0000 (UTC)
Received: by cat.eag.rdlabs.hpecorp.net (Postfix, from userid 48777)
	id 80903B4907; Thu,  5 Dec 2024 15:07:40 -0600 (CST)
From: Kyle Meyer <kyle.meyer@hpe.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Kyle Meyer <kyle.meyer@hpe.com>
Subject: [PATCH v2] perf: Increase MAX_NR_CPUS to 4096
Date: Thu,  5 Dec 2024 15:04:44 -0600
Message-Id: <20241205210444.84894-1-kyle.meyer@hpe.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: JiPcFjzpInRQd5PvI-m2IeWzsdkhMYbw
X-Proofpoint-GUID: JiPcFjzpInRQd5PvI-m2IeWzsdkhMYbw
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxscore=0 phishscore=0 clxscore=1011 suspectscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050157

Systems have surpassed 2048 CPUs. Increase MAX_NR_CPUS to 4096.

Bitmaps declared with MAX_NR_CPUS bits will increase from 256B to 512B,
cpus_runtime will increase from 81960B to 163880B, and max_entries will
increase from 8192B to 16384B.

Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
---

v1 -> v2:
  * Increase MAX_NR_CPUS in tools/perf/util/bpf_skel/kwork_top.bpf.c, as
    suggested by Ian Rogers.
  * https://lore.kernel.org/all/20241205165118.153148-1-kyle.meyer@hpe.com/

 tools/lib/perf/include/internal/cpumap.h | 2 +-
 tools/perf/perf.h                        | 2 +-
 tools/perf/util/bpf_skel/kwork_top.bpf.c | 4 +++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
index 49649eb51ce4..3cf28522004e 100644
--- a/tools/lib/perf/include/internal/cpumap.h
+++ b/tools/lib/perf/include/internal/cpumap.h
@@ -22,7 +22,7 @@ DECLARE_RC_STRUCT(perf_cpu_map) {
 };
 
 #ifndef MAX_NR_CPUS
-#define MAX_NR_CPUS	2048
+#define MAX_NR_CPUS	4096
 #endif
 
 struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus);
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index c004dd4e65a3..3cb40965549f 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -3,7 +3,7 @@
 #define _PERF_PERF_H
 
 #ifndef MAX_NR_CPUS
-#define MAX_NR_CPUS			2048
+#define MAX_NR_CPUS			4096
 #endif
 
 enum perf_affinity {
diff --git a/tools/perf/util/bpf_skel/kwork_top.bpf.c b/tools/perf/util/bpf_skel/kwork_top.bpf.c
index 594da91965a2..73e32e063030 100644
--- a/tools/perf/util/bpf_skel/kwork_top.bpf.c
+++ b/tools/perf/util/bpf_skel/kwork_top.bpf.c
@@ -18,7 +18,9 @@ enum kwork_class_type {
 };
 
 #define MAX_ENTRIES     102400
-#define MAX_NR_CPUS     2048
+#ifndef MAX_NR_CPUS
+#define MAX_NR_CPUS     4096
+#endif
 #define PF_KTHREAD      0x00200000
 #define MAX_COMMAND_LEN 16
 
-- 
2.35.3

