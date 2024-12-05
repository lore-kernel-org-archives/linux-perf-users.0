Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EBA1773A;
	Thu,  5 Dec 2024 17:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418111; cv=none; b=FBvgJBpd7aZ+mDhkrq46MPNP/E4aNlGMl5fwZiBdlyWi0a+Gq3ubSZ1lGCQDrsCQHRfBcq2Xl7w+4A2XEOgZK6U/UELo1Ho3Bq/PpUiphVD3EblD1UAFExVHP0RGtSdrSs9LhQR6pP2FQd3egTGGM9ROhGo4YBCuCPDuKADIBS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418111; c=relaxed/simple;
	bh=hcQ6mXQOWIv6H5d6++tX4TOzw8pDSNVnchrEUZQXGPg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UA72K08l6L8vgPw4xsEgLrn9/y21I4Tft96CY9b+qp73nUd5/DiVzITmIfyyv7I/ESL1Cwwp1Yu0dgsRgA8hjUPaLxpX73ROCTigpooys2ftuMR9QQ/aIneTWHgWcUEbBdWcybQVVnmt6O+8xO1VecLY7RrQ2aAYyXBNWFx2bN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=WmB+XT4n; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="WmB+XT4n"
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5GhU39005366;
	Thu, 5 Dec 2024 17:01:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pps0720; bh=orMNpXH0v4LAkoIc9LBZaYFX7lBg0GF4pdD6C
	HoKKzg=; b=WmB+XT4naguhdYLv3rRqzLvh8aTtjG/Kk9HOTn3UOMnHddcApnvKM
	D9R1R8cL9VQbEkHmU2iYqrM5LQ1MJ0uhqyNV6CFUUgq/StU0BDxivRQRu7/F5/1J
	Dq3ImzEWTdTYXaf+wH2WzyB3VKXgzTRhy+eCEc3aE8NvdeC197owdTrZO8Sc54Bl
	rKk7l8HgJ93CtFsqgX3RGx25tNLXPkfUkNvTxg2b+Tecwp6rFExAVuNtI+9cBL+O
	vMkJs5h3xGI7VU1Efoly9dm2qX4e+tR9pJdw6H9krQWIVWdZ3vEgrQ7tJNCE0+M6
	97zG7PHJlSX0qlh41+mJ68Bpx94AXQIJg==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 43bfxn072d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 17:01:30 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id F0714D1DE;
	Thu,  5 Dec 2024 17:01:27 +0000 (UTC)
Received: from cat.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id A83A7811A60;
	Thu,  5 Dec 2024 17:01:27 +0000 (UTC)
Received: by cat.eag.rdlabs.hpecorp.net (Postfix, from userid 48777)
	id 02161B4907; Thu,  5 Dec 2024 10:52:41 -0600 (CST)
From: Kyle Meyer <kyle.meyer@hpe.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Kyle Meyer <kyle.meyer@hpe.com>
Subject: [PATCH] perf: Increase MAX_NR_CPUS to 4096
Date: Thu,  5 Dec 2024 10:51:18 -0600
Message-Id: <20241205165118.153148-1-kyle.meyer@hpe.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: guLFV4dQ1QhUEb0DDpivF4gdg3nYTPx9
X-Proofpoint-ORIG-GUID: guLFV4dQ1QhUEb0DDpivF4gdg3nYTPx9
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 clxscore=1011 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412050124

Systems have surpassed 2048 CPUs. Increase MAX_NR_CPUS to 4096.

Bitmaps declared with MAX_NR_CPUS bits will increase from 256B to 512B,
and cpus_runtime will increase from 81960B to 163880B.

Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
---

Tested on a 32 socket Sapphire Rapids system with 3840 CPUs.

 tools/lib/perf/include/internal/cpumap.h | 2 +-
 tools/perf/perf.h                        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
-- 
2.47.1

