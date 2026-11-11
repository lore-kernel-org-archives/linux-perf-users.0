Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794384019;
	b=vD7KTF1F2ZIOM5tft0u5ITIJONK+yvaQYgPZTYX4G/jv1F91nUkFTZYMtqArEl614xje
	 UtUvoP1Yf9/c7CuOm+pQu0oSGdqvfGMLaopI4Hy303HtzQFyk1T1ftVLTH2mJcA9sszEZ
	 Xj0C8GFD9svctgCUjpDVAmMsMownuKapN4mH27fYc0PjFOTze9pbX5g2kIZsiT8NbSLec
	 5ifa06uZYr4K/S32bMpApXksZy0Bx2Qx0P58ksXJ+85zjnLeKPgyUZTalZquGXRmd1uB/
	 qu57b7jrM4GJySMJIUF31bc7LYaCKp/Vpk/SuZv16zGvtk8gN2550ZT0XbOhf2XZjjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794384019;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=woGTuOQF6sgceNcGTTCsJ5ol5XKQC1dVcx8vvLW3Ql8=;
	b=Nfzjy3x7L2lD2IcfZWW0QFGxM4kFjoKGsjOhi+Rgp8VlYRJhNo7n5B0pB9y/NYK10xtW
	 lHAPzojJeERv+/hauc6DnxYqVc7nkhwZacKcUdW3VJpV4lJEC3UrzzNhldAhvRZZ+evak
	 K+/K4DIfCip6W6Xl79/IbfCjCyz31GrwbXXZQUrecelfx7bl/dVb0qYXws6UmMjucs7mE
	 cHjPP07aRBFpXAEgqt9qM7G2BEIeLaaRSRYZacWjtWRntj+6d8inZTHe2dNq4mdX/bEaz
	 EMiz+LZ286qpwZrLW1+tNj4LdtTYU7X9bFiJ2iAql5p3p0UqyDbnFdB3XDTwcdgeC0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iHuGtLzt;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E5760A260C;
	Wed, 11 Nov 2026 08:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36E5760A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iHuGtLzt
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5iTop286306;
	Wed, 11 Nov 2026 08:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=woGTuOQF6sgceNcGT
	TCsJ5ol5XKQC1dVcx8vvLW3Ql8=; b=iHuGtLztM3C7QLlGXzyOCxkxAWGtFq8g6
	T7yjtOPx5XkICB9g9rjU7rQwm9S8HI0tgXOMp6QghJQJykGBHGzlqOfrtam/zBYS
	dYSTbvUkqUS20byVdIn+aLpl6+gmQNx8TASu4i71c07FKRQwYfouh9XNVSwoJVGJ
	9PdA0ammD16HmLvkmqkuiXZn4rmZnxKlX6+gtbm3MErLivr8z6Di77tdOPAWKpqx
	rPhVjHUi2XhIN2zdcv2YWBkzt1CYD7Ze3rSub2x0cdglt0K88VdUPfVl82PLGSPx
	3QMPCIbbAZQttd6/x3wzfOtFGwwjy9ebWi8jYv3YC4l4gOV507/Cg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumv093b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 08:00:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5K2O12913824;
	Wed, 11 Nov 2026 08:00:07 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hv4nsu8w9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 08:00:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AB8057J50856294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 08:00:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4ACD92004D;
	Wed, 11 Nov 2026 08:00:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CBD520040;
	Wed, 11 Nov 2026 08:00:01 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.213.92])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Nov 2026 08:00:01 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: linux-kernel@vger.kernel.org, yury.norov@gmail.com,
        linux-perf-users@vger.kernel.org
Cc: sshegde@linux.ibm.com, mingo@kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, tglx@kernel.org,
        sudeep.holla@kernel.org, linux@rasmusvillemoes.dk
Subject: [PATCH 3/5] perf: Use cpumask_intersects where applicable
Date: Wed, 11 Nov 2026 13:29:43 +0530
Message-ID: <20261111075945.3930230-4-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzMCBTYWx0ZWRfX9HUt9bAOXVTi
 7wwavZ6KsIrNkW/Gy1ugKba5iZ6m6Ha8Jad0hBkZoe9fSFFUE45qzOy013AEmm9aLXIf7maRFZA
 uV93D96bi93pnArdoVwkfK03iZqv8L8=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af42088 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=515Tmr3Vc-2sszKO7bAA:9
X-Proofpoint-GUID: WDlNZdzKnf6xOwlw6xW646P2rMlDBBRi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzMCBTYWx0ZWRfX3OAESfSRNTZd
 +95gkvslBkXaD27zItiRurmMHNrGNOdh96fbzuxQe4g6FOUHfcIRXdaKZhS5Q+ls40F3X6F7jOU
 AZl3Klzx5e8JloQwMF+HPS8XPLGgvfoxL0At8sQloincCytHNJdkOMIFUQYKq33ig7YknK0jy/u
 /s4sBFcqnNaU8B5KK7I2WI6bf/DBWTzwXfgGpm1cnKEt6I4XIO6Jr0AJEv42WyfCcQrvZK28YEv
 68c5DGnUFGOwJm7C8JXQKJAfjIJvylQYAJoijG+tKJk7XcKFMutU5a2T5BWGNiwFFNDVfJFCpiH
 KEmMcv0JUvnKK+baOfeHNtmTp8RJSRlcBmJWvk9RH+Tr1RVUeJaXO/xb0X88U/FZxIuVahVmur1
 nnho9JNCDRCjAXBCBuirp3brsgqJepMt7Wcogf3EsRhnB5Q1v3ffvOC25/ZZGDTieMPYayBUFSL
 1Ly5dN+du8Jsc1ebb9A==
X-Proofpoint-ORIG-GUID: 0Gyhd9kZTBswYaRYrA5zj9pGa8Q1rV0C
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
 kernel/events/core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index a6c8e38a3110..f9fa1b47ddf4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13159,7 +13159,6 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 	if (pmu->scope != PERF_PMU_SCOPE_NONE && event->cpu >= 0) {
 		const struct cpumask *cpumask;
 		struct cpumask *pmu_cpumask;
-		int cpu;
 
 		cpumask = perf_scope_cpu_topology_cpumask(pmu->scope, event->cpu);
 		pmu_cpumask = perf_scope_cpumask(pmu->scope);
@@ -13168,8 +13167,7 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 		if (!pmu_cpumask || !cpumask)
 			goto err_destroy;
 
-		cpu = cpumask_any_and(pmu_cpumask, cpumask);
-		if (cpu >= nr_cpu_ids)
+		if (!cpumask_intersects(pmu_cpumask, cpumask))
 			goto err_destroy;
 
 		event->event_caps |= PERF_EV_CAP_READ_SCOPE;
@@ -15312,8 +15310,7 @@ static void perf_event_setup_cpumask(unsigned int cpu)
 		if (WARN_ON_ONCE(!pmu_cpumask || !cpumask))
 			continue;
 
-		if (!cpumask_empty(cpumask) &&
-		    cpumask_any_and(pmu_cpumask, cpumask) >= nr_cpu_ids)
+		if (!cpumask_empty(cpumask) && !cpumask_intersects(pmu_cpumask, cpumask))
 			cpumask_set_cpu(cpu, pmu_cpumask);
 	}
 end:
-- 
2.52.0

