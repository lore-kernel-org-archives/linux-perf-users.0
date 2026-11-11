Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794384022;
	b=JlQWFs4BdsHqdrwTNp9c9ARhyEuDUiHAPH5mIQh/paw+0vSSuBrM6VpnKGuEQQ5+DV6t
	 dFbk1DxQf5OLbEYwYMVXxqq+4Scr9M8PRe2D9C4N8zCaAtaAYZmxLQNpCrWR1Y4xyTjPh
	 IRZeHrTv5+8WgcYt+knhTJTX/eloBCAEDykmIsQhpg91zqJxkILMd2ESUF9yzktbR20sP
	 9UTFLIScf/kptxfSHhFABKe4NZo6Pk9bVDLwnb0ztbcZRQdgCnQ/PtXEGUbe6d+JepYP8
	 ILSRq4XTkiwkvGQyXZHzWCSsDBdZVgZGsm9Qihr8ouP+d5UD24b4WleBVShyb5PBWNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794384022;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=+utYUiFFG55mh1WzVyV64A0Uu/qOpXjYDIqt1IDyJpk=;
	b=Gz+uE4TYBZY4Sfhvq5MtEFU/WY6Kvvhiua3efy5aTAPS4HrN77KlccwuzkH4AafTtVXh
	 CRvPtNzChovB/x9G+2q0nG/wBWBie8BeU0ZUuO1uDH+tDtEQyScb7E+R8OKZb2Q8/cZ8Y
	 QCTvKxJuC9Vg36kCXNe8JTNbx9l2wS3UwX+MWgCZNQaGkyUkjslutlVUSAZGWr8aVU7t7
	 v85rdAvCyBrgpWwhmQriGQxcKdoFhVmd9DWM4bfoAH/w90AQbSudprAIsztIcYQbR6Af3
	 TN9IzyRRZ1DwNtpzlT1c3KRXXFTEAbuJjgWWw87Vm8/dmQvuRkycxD9I1nV5+CxiSeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fMUdTuLE;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFA9606A33B;
	Wed, 11 Nov 2026 08:00:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFFA9606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fMUdTuLE
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5iEID218911;
	Wed, 11 Nov 2026 07:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+utYUiFFG55mh1WzV
	yV64A0Uu/qOpXjYDIqt1IDyJpk=; b=fMUdTuLEljeOkOWCjU5S3ko2C1f1tIST2
	nNb1f8yoY66XlMhR/h7eOajcqYYON0YomkX0pRXdPS1GgBYZXbA4OpQF+l/bdJ91
	X+tvpiJRv7dCSRL8FwQP4g6yMrISCfRlYjZyZsWpzN4ecJQ711IBJ5Uy+nwmm7dP
	1Hwsa0hQLqWwXdYag3ZEzBxBSwrUHajbxYz5UpkqTlCf9F6cXlH6D7EN44Ws5Dba
	MMOG9NvMSle5hFc3dZW5lkugx40htRuZAP9xcxA/8vh5ElrOknO4swC/gmEnvxqw
	MOqtRUQ1O35Hg5TRLCQTN6nJ3wgIAf8aIzObCK1VTgSijLMhtB9aA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdks2em-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 07:59:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB77pTK3005864;
	Wed, 11 Nov 2026 07:59:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hvkq0r456-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 07:59:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AB7xuJe43975026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 07:59:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99B6620043;
	Wed, 11 Nov 2026 07:59:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCE0620040;
	Wed, 11 Nov 2026 07:59:52 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.213.92])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Nov 2026 07:59:52 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: linux-kernel@vger.kernel.org, yury.norov@gmail.com,
        linux-perf-users@vger.kernel.org
Cc: sshegde@linux.ibm.com, mingo@kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, tglx@kernel.org,
        sudeep.holla@kernel.org, linux@rasmusvillemoes.dk
Subject: [PATCH 1/5] sched/rt: cpupri_find: Use cpumask_intersects where applicable
Date: Wed, 11 Nov 2026 13:29:41 +0530
Message-ID: <20261111075945.3930230-2-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111075945.3930230-1-sshegde@linux.ibm.com>
References: <20261111075945.3930230-1-sshegde@linux.ibm.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af4207f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=gVD9RvEtEyC2a1f70PkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzMCBTYWx0ZWRfX1vPSN9Djqwtm
 5eLPJtyldQk6//ss8tmtkoA3YTqHfZnmy2bKJaDFOYo9VXT4X6IIbwLvKZxSYlwMReugzZZT8Sd
 IvdtWJrg8rZzafxJ2f7JgYHvmlD2alWRWf0YdVJG9DOLCYtcJOGNWFjVlgGUfPxAsq1M23bGYQh
 Xp9HdolDWI0BMcCWmQvhs5/cIMSBWqLP6LMNc60OrMHPrq0CWg5GS/JDQQAdFXmQxyNgfJxn0r2
 iTjH8QtaKQ/kbODbNtIbwklyh/36MzZEFnNZFcnW9YfF5IoBuIru2wNdbMrkl2OOpfJNCHvmIsv
 cYEjhQ++VOOBLCsHjxrpWMa132L2IKlN1zPjpzLAjH9uJ+u9K9urH4lEpaH9DScWUEwJnNdQAXP
 dPUD+4aNHuztfUJcrxEkSLHHxnprRDMLxjnnRyFVfdANLwVqzRze7pWsvWUZNfjZKyTCGbPz/g9
 A3dS8wFHCMBHISLyM0Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzMCBTYWx0ZWRfX4CJUaEgY/vO6
 uixkfByYl9yXA1fblRMkrtDcrxq9tqWnG8KKuM/bTjWti6cMaCsLj1WKiY5LmW7ckNkKCDMdxTc
 7nPLf4KjiMtuIjyHzz78Cbiv8J9VyYg=
X-Proofpoint-ORIG-GUID: -ZJLocmC9AkxYoAnMfyRxnXtCym-NYuA
X-Proofpoint-GUID: SQnIckA7AjHtr6VrCfG6It8_LRUTx14p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110030

cpumask_any_and returns, usually the first cpu in the intersection
of the two cpumasks. However, if the returned value is not used or
only to check it against nr_cpu_ids, that implies whether the two
cpumask have a bit in common. I.e cpumask_intersects.

cpumask_any_and uses ffs on (addr1[idx] & addr2[idx]) whereas
cpumask_intersects checks only (addr1[idx] & addr2[idx]).

So replace such occurrences.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/cpupri.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index 8f2237e8b484..44d67fbc4ab2 100644
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -97,7 +97,7 @@ static inline int __cpupri_find(struct cpupri *cp, struct task_struct *p,
 	if (skip)
 		return 0;
 
-	if (cpumask_any_and(&p->cpus_mask, vec->mask) >= nr_cpu_ids)
+	if (!cpumask_intersects(&p->cpus_mask, vec->mask))
 		return 0;
 
 	if (lowest_mask) {
-- 
2.52.0

