Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6A538F226;
	Tue,  2 Jun 2026 11:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780401439; cv=none; b=byFvHg/+bk/zfxa890CBL5ozO4pwweRS7AA3kLIf/QYKBtHlDXpZPNbjOMxDKqvertKvYwF3E0EuH/pH13tbkdqt2VOleE+TZ6oQH6vGIJuRyRMU5pYLBHB7YFWCXgCbWUhgsLVQi9Uk7r6V0YS8faRrnEeCAG/BjYGBm2Lcqa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780401439; c=relaxed/simple;
	bh=mS0SY5QEddjQoFmC+zuwdJFddvuQVQ3kaQcbQMU1zLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sPW9xna2nPdaANAy9fJwEY68i8Y7XdiGKFwkxGg0JVy2QhRUWIec0g+EaW+65a1BBUgp9p0VRnqfhqeFbDJsYbubyqdZiyEOjx/WSbehXL61fgEEZHxbUUJxJYWaORIek9OfhYj4eagjqHITFXcxCjcBk6RzFb+3wsBUVJywdXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c+UeQER8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c+UeQER8"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6525taaF2292050;
	Tue, 2 Jun 2026 11:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6PQUPOaAetyrLlTlm
	WnVVKNBk26UEiWER0BQiPePzYE=; b=c+UeQER8pakqU1u8w8rBFufWGHM/6LZ7/
	DN63dmaLxLCIMeZszyhAdrZ/xhlfJLQa+tSV5XHLn7qvNJiNSTCSWYPUYcKNVcC1
	L8DWAG6KMcherW6wcpnNK95k3zSJiqTjxptnDZKYRRt9vHxn9FON3aVSWvUdbrle
	xifzDrm5y9NLvzm7L8vOyMh22viov0VxEJyieEF/9DCX2VoM0i1PZrCWH2a5DElT
	0m1J7lG4OV1BgYgxx/Iak9u66e/59XYbgziSsfiyGhXO4Aqqvz/Qd7MTOXFUeHW8
	Hy72S/dCQzeBCELnsIqHgM4uT0tl0ypp+kGrOUEJpiRCfQgfqSjFw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjq5pde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 11:57:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652BsDOY012737;
	Tue, 2 Jun 2026 11:57:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqhaymv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 11:57:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652Buwxt48496932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 11:56:58 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EAD52004D;
	Tue,  2 Jun 2026 11:56:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C13B20043;
	Tue,  2 Jun 2026 11:56:55 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.123.11.154])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 11:56:55 +0000 (GMT)
From: Gautam Menghani <Gautam.Menghani@ibm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
        atrajeev@linux.ibm.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/2] perf script powerpc: Fix a typo in the name of H_DISABLE_AND_GET
Date: Tue,  2 Jun 2026 17:26:41 +0530
Message-ID: <20260602115644.8133-2-Gautam.Menghani@ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260602115644.8133-1-Gautam.Menghani@ibm.com>
References: <20260602115644.8133-1-Gautam.Menghani@ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: xWfA4a7aG2f5HOD6J9wPsw1QTW0_0BZn
X-Proofpoint-GUID: VNgz5t9Hq2RC3WAfOGQFW8zG4k1bsZwB
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a1ec510 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=0NEiFMdzwyS-icdZ:21 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=a3FM_NsKWQufrQQMM-0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDExMSBTYWx0ZWRfX6ULFZyJcg+ld
 4Y7Dj8PcrIe9eRLbgB3pzKuADkbSgUeC1CyNw7TzfvrDjU68J309TqTOe+H7T1TYtZSdxyV7iCg
 lfP0AGnVsiBpZm5QFIyqDFkVMVr4ncNEMYA9/d1PACxxt1l/+TF0W76JIx30nu76SrVuwBEWL+J
 paAoQv6SShOf3zyEyW2ERjNmwMzMRK8WghfulLil0KXUWMA0WLb6F16Hr9Pd5Czv1xecXJKxu7v
 U8uNgacKl6+o8XIk1AQ6/CpoHePpBo65ltLDhIU1Er7NpTf2zkXQYhBmVmvH5Zifxc/EZzWlQJc
 ZudYdTjzlgWmJ8IoQ3gzjV05+v3vgo8GDGWCnfAu2SuTxgzOddqkGu34eXIbR0eEkQKj0fqJeEF
 HeLbKbrmqBMUz2Y4JNaOECAmR8QF1tl6VLarw/iNpO7In7cJHJDhF8z2LlugEoDeirwQj9lt7Zl
 EcJpFu4EgNYNlHNLboA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020111

From: Gautam Menghani <gautam@linux.ibm.com>

The name of the hcall for opcode 432 is "H_DISABLE_AND_GET". This typo
was fixed in the main file [1] in the commit 0f10228c6ff6 ("KVM: PPC: Fix
typo on H_DISABLE_AND_GET hcall").

[1]: arch/powerpc/include/asm/hvcall.h

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
v2:
1. New patch. Separated out from the original patch

 tools/perf/scripts/python/powerpc-hcalls.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/powerpc-hcalls.py b/tools/perf/scripts/python/powerpc-hcalls.py
index f897d6a5e051..4c14bd05da46 100644
--- a/tools/perf/scripts/python/powerpc-hcalls.py
+++ b/tools/perf/scripts/python/powerpc-hcalls.py
@@ -112,7 +112,7 @@ hcall_table = {
 	420: 'H_CREATE_RPT',
 	424: 'H_REMOVE_RPT',
 	428: 'H_REGISTER_RPAGES',
-	432: 'H_DISABLE_AND_GETC',
+	432: 'H_DISABLE_AND_GET',
 	436: 'H_ERROR_DATA',
 	440: 'H_GET_HCA_INFO',
 	444: 'H_GET_PERF_COUNT',
-- 
2.53.0

