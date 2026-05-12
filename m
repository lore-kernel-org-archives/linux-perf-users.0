Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE6A3CE48F;
	Tue, 12 May 2026 12:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778587490; cv=none; b=S7suB9AkcGHtQFKQ60GaRurjkTVMwnvwBIAPFkJqlCCDqRIfMQHbUUgKcQDHv1+b34rK5wz94N2WC6Rabp6RGM7OLmXs7alMf+BQpPAmCex4lJoaMKvXIguGQK7/dElAoc9gAYtuiRO/ejzJdrcAf/EzHVAnf/fjo+7wlUV/lR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778587490; c=relaxed/simple;
	bh=reeqemfuk8v2PgoaMfArAkJNZ5xEgcQW/BZnomsyWmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ut2ZhpTZ8vufQ0kykWHVj/mS/aEJoefDjRmHkQ1qMThH8/f3GzglHwLBAJgCGGXy6lgy51fNNa1ifN5X0WEkiyTfNGLGYkjDJ6yp6SeUgbk5/2HPrcHLscX1Re1QJi5uoGJYFvviG+wKI44CFgnORLYxDTeKTL5kfE/arBaYveg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r9vhwUbn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r9vhwUbn"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CBtiaS2760070;
	Tue, 12 May 2026 12:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=xHCGhTntmdV1niqJ8tYMp4ToWBMYixr3TqtVlHjkM
	Ho=; b=r9vhwUbnI4U3Ea2ml7DpzsIIrNItZodK8eqBopELlS3wXJOFYUEAoER6P
	w1c5FtRXCKYz0K/0qK6BBgY2HnNRpMiJZO+33uL6gELAv/YsWMUgWlkTzlbJ0JUh
	Q/YuDRh4lxB5HE4UU0T8u2fue2Lgy7tMVQB0a5Co6q16QWBqlTvWkDU6adzr7c1+
	HR0iGd5/tFxM+AN0S8Mj1/6scLKmG1BWDEskzfJIEIElxuauxxVnqzNHLa+Ux6Bs
	3a7K2EROP9UqusnG+KDdwywU/+gzBs8X4p4dO3gQhPHrCvHCWQNUkeY0HSgBmG15
	INIwqNO2QhwQLietiRl8wrHT+y80A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6jrm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 12:04:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64CBsPOD025047;
	Tue, 12 May 2026 12:04:15 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgk0m4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 12:04:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64CC4D5r18809242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 12:04:13 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F8A12004D;
	Tue, 12 May 2026 12:04:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DACB220043;
	Tue, 12 May 2026 12:04:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.72.48])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 May 2026 12:04:10 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gautam Menghani <gautam@linux.ibm.com>
Subject: [PATCH] perf kvm stat: Update the exit reason mappings
Date: Tue, 12 May 2026 17:34:08 +0530
Message-ID: <20260512120408.59332-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: TBNpVcm0XtYf8dGLxDNQIhSUCU6wiyN7
X-Proofpoint-GUID: a1r_1dHVlvEUzM8nr6HDLXjspW79riU-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDEyMCBTYWx0ZWRfXyrDLb4KhjCac
 kK6MRQV2Ntb4ZxaARO43Dnz+FNkZ56e8nvwpDl5Ae1MfYe2zNtpEITazCI4cjskkdrAlyt2wtmI
 GDAMNS88gTIaJJf2+dKATk5Rv+wKTF/aG3pIIowwH9bHtA9Enh9PIK70cs3cfRsVtoUlcc1tf33
 yG3C/bYcvJauo27lSZQiGjLQNYtV51g5Igk/Ckb6lxk8Agsr/Njd3LF2Ya71G1fJKz2eDVbou9J
 6idyRRmZKOP01zSkYonO+DWG4QdDeGD3jCMGLUKT0Ujqj3JoD6+CIXcye9tERka1R4zOSr4W5ZE
 dCjIlH5YO6zn50dhabzpNvny9zwd/qEirbZXtdyVkyiNjzP7aU4srqsLHuKB3y+cMLllfSeINqg
 ZWbqGiwGmYoUzzlZ7LA+1jw+aX3sn5clgjvIn4iO7u+C/64T94gFRhyYRUeENnsnJSdaq2oDe2A
 FkHJQV8pweLA5zMig7Q==
X-Authority-Analysis: v=2.4 cv=P8UKQCAu c=1 sm=1 tr=0 ts=6a031740 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=MCstC3mokZZmnnjwFFUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1011
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120120

Sync the exit reason mappings with the mappings in trace_book3s.h

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 tools/perf/util/kvm-stat-arch/book3s_hv_exits.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/kvm-stat-arch/book3s_hv_exits.h b/tools/perf/util/kvm-stat-arch/book3s_hv_exits.h
index 2011376c7ab5..2688ca7d0399 100644
--- a/tools/perf/util/kvm-stat-arch/book3s_hv_exits.h
+++ b/tools/perf/util/kvm-stat-arch/book3s_hv_exits.h
@@ -26,8 +26,10 @@
 	{0xe00, "H_DATA_STORAGE"}, \
 	{0xe20, "H_INST_STORAGE"}, \
 	{0xe40, "H_EMUL_ASSIST"}, \
+	{0xea0, "H_VIRT"}, \
 	{0xf00, "PERFMON"}, \
 	{0xf20, "ALTIVEC"}, \
-	{0xf40, "VSX"}
+	{0xf40, "VSX"}, \
+	{0xf80, "H_FAC_UNAVAIL"}
 
 #endif
-- 
2.53.0

