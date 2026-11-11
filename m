Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794384024;
	b=x5k6B2XVyUf92Lmz/Q6AOAk+K1F0oRz7Jl9TlmuNsvY3wZjDzq29t1B2lJ1fLUZiE9RT
	 af+wGALdwDM5p8usegzhsxlx1z8Gzi4ki3V5nKKQ4DdwpaVWhDK9LXsfu++k4E5RJacUY
	 jUmn68RrvnmWCaueoJqsWeDZrDS/A4pugW/Zyaj5nWv0/OdqBo9yLUaNvYdP0M+Lmyn8z
	 HnCUyA8ZCwIoef7qPVNfP8KvD+1x6syKnWdekX5IZyDaqe656iSIO1Fg6BmfbfQVc2X+o
	 TF9zA3eCaJ+dVIVOMasvnFecSWHorwtZ03LbfRR6GKxjyRHqhKdQKDjBGfS/Dm+JwrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794384024;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=5GktyTgf7sJb3mvryjSrxWJfEelInPOqjTDeFRyFE64=;
	b=kjDxV1dmzjpkqO/T1TD4Q9CWkLo7V73zgRU1jF+VoEnnrruI/F0VeB1OzmSzoztG7u3P
	 HkbdAqBqXiiLtipGI83EruddkkiNGXJWND7uK4lOMYuWNF5QxwZrIEY6jbKvMJu95AJEd
	 NlFfb2bpIfQDoilQK6GIgtfd6lionKG6ZjhhdJFYLkXa0Kbag4iiubfhfny25RptREObp
	 +LX4KBr3i/3s0mnrMMIkKLKC0vPsgASMS5r+/pRzjTwuKyf+I+ffmxdfWHpixKu/y68Ep
	 DFOL+wEpeVs8pDlg486m7LZOfjEvCF8VHBfu3J+t/WxdUiKIFGRoN1PhN8F93DNdUwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=adHXnpMm;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CF560A263C;
	Wed, 11 Nov 2026 08:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78CF560A263C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=adHXnpMm
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5ivdJ219674;
	Wed, 11 Nov 2026 08:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5GktyTgf7sJb3mvry
	jSrxWJfEelInPOqjTDeFRyFE64=; b=adHXnpMmhiXImSsVQL2y7Aj8SRXOIElLK
	+7aAA3fer0ReW+yZj6Nh137iNVo+J6hf1VNDXHj24YnqE8GLphUxa1nv1x0U/xAe
	MErOl3N+2cb2tRt9H5dd5HBqcsrH8DnPyzUyDfSXpqw5rUqzYcP9vhvdZO1vzaGm
	muwzooAg/efzh53x93gaVUPKy2yrPqNdhKEURdHstG6KSfPNUjfV1vhSQYoQrIsO
	5O91FTgpE22SiWQnwlzWAvbqWc6FK91dcamxIE92NJ8f6VNuN9pF6LSCbypDgyEo
	GaOyunLtI6cd6xqm6TeL0/jHFlaNA1v8feZE3HnqZJrwArP+OSO/g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdks2gv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 08:00:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5Jvo92859414;
	Wed, 11 Nov 2026 08:00:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hv309kkv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 08:00:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AB809W131392486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 08:00:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C4142004D;
	Wed, 11 Nov 2026 08:00:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF7B820040;
	Wed, 11 Nov 2026 08:00:05 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.213.92])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Nov 2026 08:00:05 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: linux-kernel@vger.kernel.org, yury.norov@gmail.com,
        linux-perf-users@vger.kernel.org
Cc: sshegde@linux.ibm.com, mingo@kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, tglx@kernel.org,
        sudeep.holla@kernel.org, linux@rasmusvillemoes.dk
Subject: [PATCH 4/5] cpuidle: Use cpumask_intersects_and where applicable
Date: Wed, 11 Nov 2026 13:29:44 +0530
Message-ID: <20261111075945.3930230-5-sshegde@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af4208c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=ti0QXwtRaSYbIWswJqAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzMCBTYWx0ZWRfX7EhJZ9qaTAAc
 55H4CqaT+WGYGOEfNXd1yv2y3fXFLFykrDrSt57y0zRkD1hdrHDybxRs3FnRe92AinY5kwjENMo
 z2bJ8E/y4L09rn5+wpIT6tq9xwTNaL+jeuhyd9Avh5CpI5Klmb10XhfNO6lDf0oimNdIdncwmB9
 bE6ibXzXq6oUobJnvhTyjifTJogOn8BRMu3G55r2NlnxnQwpf+wljk6X8A+EWdsoSHIYd3N/kRG
 XCwa5CVITp7RQLNhwdacA1H1mRpNwksQKKWS6Vn1ASmQH2rtFxxVnU4tow9QSvHt2nBQrT0deNY
 S3NMQSyqNvcJGE4hgkc//GGYNM9KwQXO1ec9U9M/5x4v5hmuNGb5OcnPX/cA6RVYlR1NZL1Alte
 1EmguUlF8NI40E1u+eENevYRSL2RNrpddwGEjYhGUUP9j3zb1lW4XqN5g4L4PL7GHUwrH6288nN
 C2aK4GwzoHM/RG1AHtA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzMCBTYWx0ZWRfX+sbA2RNkMfiO
 LYAELyk1qXdzPsn16Ja8ZV7mmTwdzFBWGfr2RckMOS8evhoeyQ35sINBbE3AySshjFWGFERDkqv
 lfdequoHwNn5TpE3ArUZOAPbf/SjLvk=
X-Proofpoint-ORIG-GUID: YxO-0mUsHXh3pV2XTnWM-19jGLbJdl8I
X-Proofpoint-GUID: Bu0PHeWca4e6yxDdnOcxNdQ0yaE8GulV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110030

cpumask_first_and_and returns, usually the first CPU in the intersection
of the three cpumasks. However, if the returned CPU is not used or
only to check it against nr_cpu_ids, that implies to check whether the
three cpumasks have a bit in common. I.e use cpumask_intersects_and.

cpumask_first_and_and uses ffs on (addr1[idx] & addr2[idx] & addr3[idx])
whereas cpumask_intersects_and checks only
(addr1[idx] & addr2[idx] & addr3[idx]).

So replace such an occurrence.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 drivers/cpuidle/coupled.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
index fb91a9e0e3c2..40db5c86a466 100644
--- a/drivers/cpuidle/coupled.c
+++ b/drivers/cpuidle/coupled.c
@@ -439,8 +439,8 @@ static int cpuidle_coupled_clear_pokes(int cpu)
 
 static bool cpuidle_coupled_any_pokes_pending(struct cpuidle_coupled *coupled)
 {
-	return cpumask_first_and_and(cpu_online_mask, &coupled->coupled_cpus,
-				     &cpuidle_coupled_poke_pending) < nr_cpu_ids;
+	return cpumask_intersects_and(cpu_online_mask, &coupled->coupled_cpus,
+				      &cpuidle_coupled_poke_pending);
 }
 
 /**
-- 
2.52.0

