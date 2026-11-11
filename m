Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794384018;
	b=hBUP7fEfeVMSucJhoxFNkCDVy9piVsACF8OhSTGUBybA2c9F2Wd/XOsnmfvf3jbhZm/R
	 ZKkhADFqe+dtkOzp7G34oFo1g7V5OTPxCKH5hd/vcGPYS1TDZtlMvOakIsdU0euWLjZKQ
	 aKrIYIc4Eib330argWFvSvGUzaIlM3w9jZ1eT2HlQCBPKQvgrra775uvB23QBzcbiAR9n
	 3mBsCO3uPMcJCYqbiE7sHZuOW/WhzYVkZBbZ+ue5jUz9hoPcnROog9PL7MnFi5SNdt6rj
	 hBubmmc/3aiAUG7A9qT576Qdi57g6zO8zkZKR2UcAtMVHrPqfSK6z1BOT/vhDQx/YXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794384018;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=mwdHhjdlDib5NgWmYfWsD87FwCbJFpBRCA8fSUjYuck=;
	b=5XVxKHRIGSdYKHI7E9Q4A4FMmbqdlx9rrl8fcSCJQgZ8Xrv0M6ovgf5RIa3oAa9jeoEX
	 XsK+f+DP4TlWlnXq3tAbA7I9Z/UcW5P1r5FCGGZwR2kzcMebQcmBjCxlQXLaxgUOjR6Nu
	 CftuuMsJoWtUEspzS2OjQihw+WGtsNn30tQIO+BKczou4rpoQlh0a9QUfnfj4I4I0GQI4
	 DbBtOLMcKyLjtxdnzQxyA37XdmAfOZhlzr5rw/kW1EQYkFvgKXU4rPtoP+S/+xcb69WbV
	 UiqBOaEubx+Jcu2AM/lCw1YGQXnQxcm4pB2zId9aPLA808aK0BATdKIaVuTMGAmi6KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fYDsg8IW;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E81606A33B;
	Wed, 11 Nov 2026 08:00:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0E81606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fYDsg8IW
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5iamw286389;
	Wed, 11 Nov 2026 08:00:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mwdHhjdlDib5NgWmY
	fWsD87FwCbJFpBRCA8fSUjYuck=; b=fYDsg8IW8zBXRMsfrPMRUXUMoO2It55U0
	Z8yfXfxZv8btii1vAv/33GlmpwbyusSnc8p75gLMPZtnqDHjaOdcDyXHp5uXlqtK
	nal30PD5Rh9HvcxkcSHayFmnPjuklK9V5Lmxo1IY6E4nYLtqMlxcFaa1bQkcIyFT
	u1D5FA1nYatIFR1uPO7FjEgltUB4j+qkBFh9/WX8x8z+UAI9bb9NvflgVbdbhuU0
	EtH7G6Jtw1oD+q69Z8/FAWyTWVxl3auzYSg9TWJo8sN7k7xlS/jWjNhDN13fK7+z
	iw4nuWFphLfGQ5CLimxWMQuH3wc0MWVCPvk3q+GwAtawxsD527ZZw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumv092q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 08:00:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5K4m81747929;
	Wed, 11 Nov 2026 08:00:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hvd51s95r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 08:00:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AB802RM42139976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 08:00:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E478020043;
	Wed, 11 Nov 2026 08:00:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AF4320040;
	Wed, 11 Nov 2026 07:59:57 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.213.92])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Nov 2026 07:59:56 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: linux-kernel@vger.kernel.org, yury.norov@gmail.com,
        linux-perf-users@vger.kernel.org
Cc: sshegde@linux.ibm.com, mingo@kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, tglx@kernel.org,
        sudeep.holla@kernel.org, linux@rasmusvillemoes.dk
Subject: [PATCH 2/5] cpu/hotplug: Use cpumask_intersects where applicable
Date: Wed, 11 Nov 2026 13:29:42 +0530
Message-ID: <20261111075945.3930230-3-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzMCBTYWx0ZWRfX72IDnRlk1GvK
 XGCNr3PrZ2pLx2kmkHjAtrBwM2E2YEEw7Jz6rRkz/8LN3aOx8z1iqfiGF9jLKPix8MLlspLYCLV
 HkaA+t7MdrT3nKOAvc386hOheEAh3tM=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af42084 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=515Tmr3Vc-2sszKO7bAA:9
X-Proofpoint-GUID: omRYtXz9G0WvT922SFZaayrivsjaSUhE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzMCBTYWx0ZWRfX0YuwH2e2aNXp
 WUySZmeY75cCDaOIitz7eSzxELKBUGLAuXXomQsdl73CHN7jPu0aUPHd4ON66hHKaJ6cYxxaWBH
 j+zKfvxDyFGs1WDzUTUFEiSMFpz5EObPZdmIK6/iTu3aRQ7IPhMXiVF5/0ySqiXbCwRi9pEZPdY
 qJ4wYY8+D9/k+6lVYKAPtk1xssUNM9Z28FNIU1ZRjgBQ1dKoXPFUSrIilksMhleSd6p+NY/vEz4
 u6DOmRJwF3GXmuHgaornbPseYiOpXa95WYj8QVpoNVCt2Z+YUgX2sSjwIzSh6GrHSKf0nIekhQE
 f9TgULcC1TFa5ujkOg3tWp+GfJ7TElWFI3OoniJCTXhcukVQW4tb4wYyK4CPZuXYsDEW0KZWK4m
 S8CVsyxOFpPb8BgOUvV6VVAwf2dvV69mUyNlnHDqtt/YYe42NLCAaWTn0xXOLGldRisYzSiUAK3
 F63BGLVHz2P1L5/8Mrg==
X-Proofpoint-ORIG-GUID: omRYtXz9G0WvT922SFZaayrivsjaSUhE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110030

cpumask_any_and returns, usually the first cpu in the intersection
of the two cpumasks. However, if the returned value is not used or
only to check it against nr_cpu_ids, that implies whether the two
cpumask have a bit in common. i.e cpumask_intersects.

cpumask_any_and uses ffs on (addr1[idx] & addr2[idx]) whereas
cpumask_intersects checks only (addr1[idx] & addr2[idx]).

So replace such occurrences.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/cpu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 376d297a6292..e39245d9bffe 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1418,8 +1418,7 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
 	 * Keep at least one housekeeping cpu onlined to avoid generating
 	 * an empty sched_domain span.
 	 */
-	if (cpumask_any_and(cpu_online_mask,
-			    housekeeping_cpumask(HK_TYPE_DOMAIN)) >= nr_cpu_ids) {
+	if (!cpumask_intersects(cpu_online_mask, housekeeping_cpumask(HK_TYPE_DOMAIN))) {
 		ret = -EBUSY;
 		goto out;
 	}
-- 
2.52.0

