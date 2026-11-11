Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794384029;
	b=LbJeRwGF4s/rYJ9prpcIpOCPPNHpFmQasIUT+NDXlbrqmB59ctgBS9SzziUShW78GfUZ
	 /6kncF3N2yrPwmhGPhbTfZX8wNIR5fMOb4i2HZwVtSGJDTCmhI75VQjEgzNewqHSJYuHA
	 Yb5Nc21pJ1XdsvJ58g5ziClXDRZcVGFbAR0HWUmMx+UZUIYP0ASPnOMfoLvGUL4sVaQXf
	 CMGEhgeKTvRZhk3zS+R4dRIMtzhzh0ArNl5bd/Fot0ZTbWoUb7SqDlQkSLBiPoMvASUZK
	 HimYkqujmwfLQuQBzqxV0T7Y4QqdqWdT/jzKy8sPKNLVdgiZ9Yc3Ufcm1BMuzzJUVVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794384029;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=VVgfYhKSlvT/Z9xxYw/ObHRFba264r9sTRwl4Gba0Rc=;
	b=epY59SS0jqkIabmMp3GdV+2mcARjQkQsKtKNssAtn6Z4Kx5f2hAvmsKwj6yLVEx98fQt
	 ZB2B4HNtMdwC+in7XHdAwNtoD4Wb0ZdR9bjA9eeQ1amGW4fRHBC/ptRLRm/h3VDGzZB2/
	 QAmZ97t7e6sLyITPx+6iS6IId+HGlH+q5GGiF7L/nHo0Bvrnx4U08Zn/qjEdOzZW2u+hX
	 wIYAFamTxHBgJ0jPqPY+sRKGT2h2lcsd29XmJK3eTVAQCFw/et6ULxZFyQbHFNHT7y/n1
	 nMm5YVD/jfme46DAMcq3dnYDMtplZXnhpX6Q6T9qVqvisYn9I6PLmkXMWowAQUEfD8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=G9OJUnhh;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE07606A333;
	Wed, 11 Nov 2026 08:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEE07606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=G9OJUnhh
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5iC20285234;
	Wed, 11 Nov 2026 08:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VVgfYhKSlvT/Z9xxY
	w/ObHRFba264r9sTRwl4Gba0Rc=; b=G9OJUnhhabdsOQkA3GmRcP8+W3JiH5Cdi
	vV2P7e/vzs8THVzp2l8oaCSu/E/bZSaau+akeV0z7pRGL6VnFvYdUIBKQr7xV+0y
	Gh72xh8QZOEyEtiNWnl8KeuWN0uBTsxeIZlvcRSzX4+oWpHD4UzLnHU1IyxKrAiy
	C/Z5jDAE2M3diuCANosh5TiB4Ug1QOHg3oMv2w5AseQJuQ00mfhcPXIxIAGUKpOp
	wYlhFj2LG2UdBa1nD047hkT9P71JfOI184nly5qcQ77hLHgYH0KqplKwcCIlVsim
	TEk7Oq9rnZ0LIWRx+FpYL/D9Snyp0nd2Apkp9Z5VMC6D9PiWL2Pkw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq71412-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 08:00:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5JvoC2859414;
	Wed, 11 Nov 2026 08:00:15 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hv309kkvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 08:00:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AB80DxK48890172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 08:00:13 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B13F20040;
	Wed, 11 Nov 2026 08:00:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EDC920043;
	Wed, 11 Nov 2026 08:00:10 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.213.92])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Nov 2026 08:00:09 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: linux-kernel@vger.kernel.org, yury.norov@gmail.com,
        linux-perf-users@vger.kernel.org
Cc: sshegde@linux.ibm.com, mingo@kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, tglx@kernel.org,
        sudeep.holla@kernel.org, linux@rasmusvillemoes.dk
Subject: [PATCH 5/5] arch_topology: Use cpumask_intersects where applicable
Date: Wed, 11 Nov 2026 13:29:45 +0530
Message-ID: <20261111075945.3930230-6-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzMCBTYWx0ZWRfXzZmDdS0aT/ed
 CfKpFbXGSm2eJCoyHBYCE4galpN8Ld6k7Ts0ImVHyaHwySu3V2d3MDQmwkExknOEX8ujOFk7l0r
 x6WEfvo9hUMfxmikxnE/iPDw5gQpVzc=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af42090 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=uJxkfRzq51vS_ux11qQA:9
 a=zgiPjhLxNE0A:10
X-Proofpoint-ORIG-GUID: 7zP5uU-1Aa0LTOcyOQdoFvxlg2JizBXk
X-Proofpoint-GUID: B1KQ_xpQKmmMDNf16mZgISFFsqLBMyp0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzMCBTYWx0ZWRfXxGXnak6fxP04
 5B62j4qfi0+O8+HNequ7Y2KX/W0YSXOmL8qX90tDHVHjp2kWrnChGFAIKN7D/Rg6YZyIU7cOQiS
 AXYOlpS289EBa2PrduiE1xeVdc+7FtRTEjB7zHJA+m3e2ddfTI/UC93naVj1ppV1DFzyKukcafK
 gyO7LTRodAt9FXTAfcXiAmM8VOJzwW91zkOm86+5V711lVji3w0IFsnhpvFi0VoXbA/T+7oPfSb
 8CJdvCDoJx1o8vpDzPiS256RPyUpXcg7myJC+03GdU79ey65FixWr9r/Mdq9/VABWSEB46uoBqk
 5UafKu5dTss6wWCMdTJtXfOMi8fNZ4E37rMsfFj54eIu8i8iS3HGGqLbmtCsP1Zw0sUP0hoKilD
 nrmieUih6Kf76lQZVyRG9vRkydIbhXjiiHVi7RtEzRgzCJ9HMILyCPvTKtLO2/ETKd8cdOCVn1e
 gD6BscttuuVr9HUJWXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110030

Looping over one cpumask and checking if any bit is set in another
cpumask is same as evaluating if two cpumasks intersects or not.

So use cpumask_intersects instead. It is probably faster too.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 drivers/base/arch_topology.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 8c5e47c28d9a..aba86e9c2516 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -34,14 +34,7 @@ EXPORT_PER_CPU_SYMBOL_GPL(capacity_freq_ref);
 
 static bool supports_scale_freq_counters(const struct cpumask *cpus)
 {
-	int i;
-
-	for_each_cpu(i, cpus) {
-		if (cpumask_test_cpu(i, &scale_freq_counters_mask))
-			return true;
-	}
-
-	return false;
+	return cpumask_intersects(cpus, &scale_freq_counters_mask);
 }
 
 bool topology_scale_freq_invariant(void)
-- 
2.52.0

