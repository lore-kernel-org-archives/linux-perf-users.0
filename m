Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794995514;
	b=XkDrXLw9icytbvwW/zzW0dOjreUGndkd8Ao9q/7Yh7tCCuLSdJQXkFNGwaxizpCIMzxN
	 uLpkGiTC6tRQHAVb3h3QURAI15Ar/oKUszsJ3y/VlZto+iA6HxT6BFbkihevDChsrkTzO
	 eJCsu36+NnQW5663zI7jR/otk1JMbALpyLiYD7UA1FMMyhEtVybJnUFKLWPoasZZo2Q1r
	 LG8p6Cc3E5v5TQ81NU8ZNVXIZu9IhSx4ZSlYZUJVW04RIz/W+oPXog1kda645gH3DdHY8
	 h1u3E0qdZrOTVZnO28E4r2l/t8Gipu6p8ZRQTbjXz8Sz/uEfBpHVEU3KJ+INFc8Qrmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794995514;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=hkHdrBlSWNdrtbI6i4NRuNvPpDLzRhd3t4RF/vKfxUw=;
	b=xpZTHoFW8vzkuc10Z9Lz+B14p6wklc88s8cpIlz6f8kAbIfzXvbz0Fvp25TRe70H9hXX
	 LKiDpEJRhxd8aE5pan5JvTcfe8/xwTr2jk+zJCLRaAPB34YsixxXymITbtSc/d0IpFwm4
	 kTTzLlWmYCmGe1lEGtCw8t1tIgIVla3u4GkXiWg5bN3nVpPM+o7EDT5pB5/lJCUtvPNbl
	 NDKBtPQFRO3D/vv+AAsucr00pbTc8KFhUiExtQ5MPlY7hQMzLuRq9OmcQfwOa6oxrCQL0
	 WfT9LO8uSaFKp14J+lEXgB2oZZ97aeBJpq7oWxIa637L4OaTMy5FNy7rvk3J23OdwRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kubDhdaC;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49EA606A32A;
	Wed, 18 Nov 2026 09:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A49EA606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kubDhdaC
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI9kQ1q2930629;
	Wed, 18 Nov 2026 09:51:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=hkHdrBlSWNd
	rtbI6i4NRuNvPpDLzRhd3t4RF/vKfxUw=; b=kubDhdaChjY/ENIMJgJbfQJrU+R
	Wx4q7l/XSIMoe4DxGSwS4qYG441ooZPTcyGy1bAzwz6hx7hSyHENcRZCfEpYz3CF
	rsU0I0Y46/5PPqRuN/aexNnAlIgJcS99ADfJMEYkZWO99zHy3EvoK4cxZfhBywUj
	J53NASYQFaI2296UQ2svRlZLKhRMk0iygEDw1aILdq6hlEhbAgjuEdkpOlnmQzJ5
	qoRrMqOFk9mZj8whDk/0ABfNVt3hO2O5GzLkT+cXtVGKwR1/NllQw52c6fTpHKtI
	pWhIcuPxqL4PPIRwtYUILJZEEK/Nzh7hpQ4wlaEKCWjsae7mt3y1IDHNe9w==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv9jcpj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 09:51:11 +0000 (GMT)
Received: from pps.filterd (apblrppmta02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI9p9Dr375523;
	Wed, 18 Nov 2026 09:51:09 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-vikrsi-blr.qualcomm.com [10.190.111.249])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AI9p8hX375516
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 09:51:09 +0000 (GMT)
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 4853235)
	id 2662224881; Wed, 18 Nov 2026 15:21:08 +0530 (+0530)
From: Vikram Singh <vikram.singh3@oss.qualcomm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
        atishp@rivosinc.com, anup.patel@oss.qualcomm.com, will@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        beeman@rivosinc.com
Cc: Vikram Singh <vikram.singh3@oss.qualcomm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org,
        Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH v5 1/7] perf: Increase the maximum number of branches remove_loops() can process.
Date: Wed, 18 Nov 2026 15:20:47 +0530
Message-ID: <20261118095053.3871267-2-vikram.singh3@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118095053.3871267-1-vikram.singh3@oss.qualcomm.com>
References: <20261118095053.3871267-1-vikram.singh3@oss.qualcomm.com>
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=QenzLcbv c=1 sm=1 tr=0 ts=6afd7510 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=W-_n0kkjAAAA:8 a=2zCBcJ1iLv046vL4Bg8A:9 a=qeNa2pbTr82C0GpJEZFS:22
X-Proofpoint-ORIG-GUID: BthAq8_YuJL-H_CqjVbhwE_LU-6q8rB_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAzOSBTYWx0ZWRfX88w04IQrZzVa
 B3ZoB4eOoteCkQ0ieE4TGbKjjjULk5S96ftUEkufIf5nOlHssr3qbOXK4N9OOFoezEUgFOuv97E
 tckIbAchsnDuGRHoMVKrIzVJD3UO+dtk86rAG/0WsJg7u1S5YgWwO5zZnTuR9i6dVkd3tC8wIwD
 D1EQA1bq1kgy7+fdJ6MqcOWTCF2ZGmTrUYDZwCcsrFiCHy+/j8kM8unX4F1+t9hu7eyioY5kjWk
 N6Fsp4PXSVcSVtyg+jjX0Qpo5OYgqQnIKjsC6d4WMmq3RPhS1sdm49t1RhiziykRvEZ2DTUrrVU
 M+rfTP9V9IyqMCkrpGB94gCQ4q06XUUHnOxIIJbrNvnHQ0Or1+gkqaLxSl4bdHuozxklHZr7QKH
 idee5TwAuNKIJAf4+ePIVEFZUOfxun4SFdq3a9wV/zpvBpoMIg7WSdoBNnniXSkJaZZf4prfcjQ
 zM07znsBQtNn1dQDfcg==
X-Proofpoint-GUID: BthAq8_YuJL-H_CqjVbhwE_LU-6q8rB_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAzOSBTYWx0ZWRfXx/XkrVlXNRD5
 YTXeX4NuUkPdD7ZoN4tYDG2Gh46hPl9WAH0oVSVxKVpVZF6hLdZjev5NscMvnuTxF1lhMniGlb0
 RGSsUEKa9538MumTqvVOUNPkD6ZOAAA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1011 suspectscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180039

RISCV CTR extension supports a maximum depth of 256 last branch records.
Currently remove_loops() can only process 127 entries at max. This leads
to samples with more than 127 entries being skipped. This change simply
updates the remove_loops() logic to be able to process 256 entries.

Co-developed-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
Signed-off-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
Signed-off-by: Vikram Singh <vikram.singh3@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20261106173942.3175069-2-vikram.singh3@oss.qualcomm.com
Signed-off-by: Anup Patel <anup@brainfault.org>
---
 tools/perf/util/machine.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 076d167380f2..f1efd1120a95 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2334,25 +2334,32 @@ static void save_iterations(struct iterations *iter,
 		iter->cycles += be[i].flags.cycles;
 }
 
-#define CHASHSZ 127
-#define CHASHBITS 7
-#define NO_ENTRY 0xff
+#define CHASHBITS 8
+#define NO_ENTRY 0xffU
 
-#define PERF_MAX_BRANCH_DEPTH 127
+#define PERF_MAX_BRANCH_DEPTH 256
 
 /* Remove loops. */
+/* Note: Last entry (i==ff) will never be checked against NO_ENTRY
+ * so it's safe to have an unsigned char array to process 256 entries
+ * without causing clash between last entry and NO_ENTRY value.
+ */
 static int remove_loops(struct branch_entry *l, int nr,
 			struct iterations *iter)
 {
 	int i, j, off;
-	unsigned char chash[CHASHSZ];
+	unsigned char chash[PERF_MAX_BRANCH_DEPTH];
 
 	memset(chash, NO_ENTRY, sizeof(chash));
 
-	BUG_ON(PERF_MAX_BRANCH_DEPTH > 255);
+	BUG_ON(PERF_MAX_BRANCH_DEPTH > 256);
 
 	for (i = 0; i < nr; i++) {
-		int h = hash_64(l[i].from, CHASHBITS) % CHASHSZ;
+		/* Remainder division by PERF_MAX_BRANCH_DEPTH is not
+		 * needed as hash_64 will anyway limit the hash
+		 * to CHASHBITS
+		 */
+		int h = hash_64(l[i].from, CHASHBITS);
 
 		/* no collision handling for now */
 		if (chash[h] == NO_ENTRY) {
-- 
2.43.0

