Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596025;
	b=P90PAJIBNf07F130w3gURXCJkTD89iiL9ZVofy5wMgtgXijzHrw+Ww7pfV0NaIyjzOPL
	 2GV3DDcd6RpaV+dqHKqMoom4r3FUMTGDmzR1dvyTcWsJLMtgE/WqcMEDj97N72OkdbUPB
	 UWHkzF3cfnyyDvrrajd7Lb+jQFDiTqHvxr+D3RnoEIZ0HK4rNCv/cWYu2lGrw/hZKypHG
	 vfTvCsHqbXTwWcnKc2ykNLhEeX1/yWJNIhPbjZ4ykB577pbgxozT241SljVKxs3P/L691
	 3xPMPao5I7aJuWFTHMEZwnGywWKewSXxR7+cI38yXonQVdhshg7GLqShcdUjFe06H/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596025;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=+CYlxJv/+7kxW65PjdmkWtemuwvXOPTUbGz8x45rSY0=;
	b=rCuryfcNDVdSZd5uNs+uCrsojCxUdzyEvtTsJa3gZ6rcRl4Yx2KWi93Orp2ATQbiO8yW
	 SEKQsq8y5MxsBYVZzz6Dr4iQ0WxjRC1iXZpa41QNJTj8iSzxyNptR3bnmJ40ji2O3SWii
	 AXxpuiooTx6JsVURDYrLywSSpbm0qDC17ApFaAe61pbhTcgGtqZx+GKEhOlgsJowMrIzs
	 /EmLtb3O2uZNor+tx2fJV/MCoy+De6RViqqyHPOmc4WhR0ixTOa46MNryLVOuvMkDiNQa
	 sL9EfasldbXqtpoiuBMvxpudQ0AytCKpz3iYBRtd6KYPJLO4EyvISHc7/705LxvPiuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CIkcstcG;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685D9606A321;
	Wed, 25 Nov 2026 08:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 685D9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CIkcstcG
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP68oD93807889;
	Wed, 25 Nov 2026 08:39:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+CYlxJv/+7k
	xW65PjdmkWtemuwvXOPTUbGz8x45rSY0=; b=CIkcstcG1eCL95y17AIGDOoLokc
	+SlodkfUi/veP6fgzhOdGgwKQzkvNX1jCsFvpExb5Wl+07qHJHweyTLqW1cvDaoB
	EIEZ/2UMozskaUVSgRT2zQUO0A0plMdBNKhlNukBt0pTsNOfvCNsDI8WoHiYVLyo
	khcYYQy0x/gq9HlK3x/NqI9lfcrDmITRNU5H4/dHLKPBjl5skcwM0AlsJjZEhRYa
	BXlzJruB4zVENtHeDHWCI/xGUhey69hAbbmGofs2kFmexL4KhEuWSslBoQ1F6azR
	Kbi/hYAnKOYe09MublFIwg0QCi23M/Rs8uyi08KkXnc5Lx76xFrPlQpWF5A==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5cxkbuc6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 08:39:55 +0000 (GMT)
Received: from pps.filterd (apblrppmta02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP8dqhS1864255;
	Wed, 25 Nov 2026 08:39:52 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-vikrsi-blr.qualcomm.com [10.190.111.249])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AP8dqfv1864248
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 08:39:52 +0000 (GMT)
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 4853235)
	id 8EA6F248A5; Wed, 25 Nov 2026 14:09:51 +0530 (+0530)
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
        Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
Subject: [PATCH v6 1/7] perf: Increase the maximum number of branches remove_loops() can process.
Date: Wed, 25 Nov 2026 14:09:36 +0530
Message-ID: <20261125083942.3695072-2-vikram.singh3@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125083942.3695072-1-vikram.singh3@oss.qualcomm.com>
References: <20261125083942.3695072-1-vikram.singh3@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAzNCBTYWx0ZWRfX2MwXRxPZzT0M
 c4BsXPWATTBMTdw+CksLOSPymQWpURtmYPh0nEE+DAymOtUIfUaEZoFmt64ygd7niLTcRKDjb/5
 edGG1g0YAPEvG3v1dK9MQ3cnDjuYQz+gdRvZQzlMLj6RNZj4lr9YUJeC5mf9vQvRGBUTVVQp0UP
 VQfpz0FBMJGruLRTxgZT7ryyqlQBng/4AiUdkLm08PnHZgPA340IuYKh3QJplDmjkWJcRFspE9k
 Eewh5zMXgyopg9Y4Mwt9m2Hf28nxiXS8oN2y1gkhvwGrN+LDiSNuYIxhR3NfUnNUHzIPWF055+T
 Gffe7VvLWOjSsBirxFSvAOVxQIsJhKgTlC3k2reuK8BV+FDLv5sb4h4dNA9fT41JodcAO8F1OZc
 4IdlEi9VrF6yOY3wOd/lSDYzInrmsryCxlnWCiMVy0yPitsTo5yGgcztByYLCCKrrdR65VsOlry
 lBzkGdTyEhRZ+JI4PGQ==
X-Proofpoint-GUID: NTR8F6V8MNWl_u_jtgN6ktwiJ-TgThVr
X-Proofpoint-ORIG-GUID: NTR8F6V8MNWl_u_jtgN6ktwiJ-TgThVr
X-Authority-Analysis: v=2.4 cv=TLbQ2Fla c=1 sm=1 tr=0 ts=6b069edb cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=n97FEv7m5ct7woqeUIsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAzNCBTYWx0ZWRfX9XnF8OobrHDZ
 PUlSDz9dwUarRfZ7aWJsBTXUArzoO8syAxs2LU0R7ze7QnhC8/slib5x/bks0rJeMjc72yxHFz5
 +2P7oSpCTOEpI6yYOdOyBSkzIcPZAgI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250034

RISCV CTR extension supports a maximum depth of 256 last branch records.
Currently remove_loops() can only process 127 entries at max. This leads
to samples with more than 127 entries being skipped. This change simply
updates the remove_loops() logic to be able to process 256 entries.

Co-developed-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
Signed-off-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
Signed-off-by: Vikram Singh <vikram.singh3@oss.qualcomm.com>
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

