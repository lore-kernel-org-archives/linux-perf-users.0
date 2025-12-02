Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08592DC352;
	Tue,  2 Dec 2025 22:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764715159; cv=none; b=qKmotMo/mISmNUcIX6goHOLxX64HgHyfUtQ9Wn45BDnSoxFICtV/ENgXTJBrGGlHOeHvBH6GiAdOPicVaP2x9e9Jx4/eKSSh35tsTzEh8KpTv+7mhhjDBOUWpDa4GSibtcb8f6F/auPR5cGwj+qrLW6mgWQo5u3ooWfm/Xlo6KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764715159; c=relaxed/simple;
	bh=wz3hFok5Hq8CITC0iecI2VWaTAv+ZebOF1TXLNBlYKk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h2exL55uaZLK3vUORx0tOfvsdAzokNBBkIRDq4hyj9MqOBhQ4NwNQLWZNhsX3t8h5fnjE/KOCzhkhQddGQW60VSlQaNSnl/HxxBXLb162ZCYw5PrbM4lasr/3M4JEXrJH5rgEWcsg0Ttz4hjKBmElZmhUnhl6YpCf5+GMZ03wWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=jtWZI5OH; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="jtWZI5OH"
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
	by mx0a-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B2KfSWQ2190902;
	Tue, 2 Dec 2025 21:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=jan2016.eng; bh=sA61KNryxt+en/RkEE5Z
	ijcUTQpdnBvRWWHIr61GQig=; b=jtWZI5OHUj9nGCEQiqB9N48GuJM7uEGJ0Bq+
	Tk5N5Ckv6TbWpauH9r0u/aNJdDPgQ3cnWFxHAvW5Cmjgq6Zr15wny7JuNeqv525s
	a3y9k1ZCtGbMMA4aVXaM9YLyP1Pxw27XS51vq6LjCdlk4fUDeEhFYgCuamIvFnxp
	NpmObfePqW8zdKLw6XnsweO64qiiruF58iudwxagMgnLWhebgh2NelCOWi0HEPP8
	/ve84Q8ecFzsoeCQkUJGdvFubiNj06VhTGn25ggmCOMrDnozKF7Blbt7xJ+fJpWb
	jOME5jjfw93O7rZuYKPLPcAPhRN4FZ+YbRWE0Lf2+QLBVNAbIw==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61])
	by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 4asvftka48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 21:40:55 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
	by prod-mail-ppoint6.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2J5ohA013412;
	Tue, 2 Dec 2025 16:40:54 -0500
Received: from email.msg.corp.akamai.com ([172.27.91.41])
	by prod-mail-ppoint6.akamai.com (PPS) with ESMTPS id 4aqw21fg0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 16:40:54 -0500
Received: from usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) by
 usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 13:40:54 -0800
Received: from usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) by
 usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 2 Dec 2025 16:40:53 -0500
Received: from bos-lhvg4i.bos01.corp.akamai.com (172.28.221.248) by
 usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) with Microsoft SMTP Server
 id 15.2.2562.29 via Frontend Transport; Tue, 2 Dec 2025 13:40:53 -0800
Received: by bos-lhvg4i.bos01.corp.akamai.com (Postfix, from userid 35625)
	id D0AF215FA1B; Tue,  2 Dec 2025 16:40:53 -0500 (EST)
From: Sri Jayaramappa <sjayaram@akamai.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers
	<irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra
	<peterz@infradead.org>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Joshua
 Hunt <johunt@akamai.com>,
        Sri Jayaramappa <sjayaram@akamai.com>
Subject: [PATCH] libsubcmd: Fix null intersection case in exclude_cmds()
Date: Tue, 2 Dec 2025 16:36:32 -0500
Message-ID: <20251202213632.2873731-1-sjayaram@akamai.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=823 mlxscore=0 phishscore=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512020170
X-Authority-Analysis: v=2.4 cv=cYzfb3DM c=1 sm=1 tr=0 ts=692f5ce7 cx=c_pps
 a=WPLAOKU3JHlOa4eSsQmUFQ==:117 a=WPLAOKU3JHlOa4eSsQmUFQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=X7Ea-ya5AAAA:8
 a=-naFw8Ui1DtwFZ36E5wA:9
X-Proofpoint-ORIG-GUID: IuiYulG8Mnoqbz4Y5KIc2gu5R48MtSBs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDE3MCBTYWx0ZWRfX7bOhrBQ5pz4x
 3latGvlnL77+5pX/mFyZ4PtZZG8o20HtyOA+knAxvcNvBDKATjo4mLiiO70TeZGgHcOUTBHvGn2
 oz6tP5SbDWSrKtTiAtIqU+EPdlDLOGLQSNFmi8qOHZaNN8SNZmNJw/yTw/qPELF/x9ZgWYZ0aZQ
 WFesk+KV65DcW9vP1TWTk3m7C2nnqmBVt3LWX6NHIeHFlrBJvk1PLkwmDz3jQaMLzgT7YbtatNP
 i82R8rg5NM/4QQBMg/fZJqjsuaKL4m61aO4Fy2yrV0C2amz41a6y+FtN57Uw+kaulemsRTieP3B
 azij0bQRMEVxFRV+UIaGDtQs2O3mN7y7IDJrq2BpHQDgp++a5nrr2PP5kx9PzFva0LimdJP27YI
 ZhJgFknF1T54qv258tMEYPJwCyMk0w==
X-Proofpoint-GUID: IuiYulG8Mnoqbz4Y5KIc2gu5R48MtSBs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011
 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512020170

When there is no exclusion occurring from the cmds list - for example -
cmds contains ["read-vdso32"] and excludes contains ["archive"] - the
main loop completes with ci == cj == 0. In the original code the loop
processing the remaining elements in the list was conditional:

    if (ci != cj) { ...}

So we end up in the assertion loop since ci < cmds->cnt and we
incorrectly try to assert the list elements to be NULL and fail with
the following error

   help.c:104: exclude_cmds: Assertion `cmds->names[ci] == NULL' failed.

Fix this by moving the if (ci != cj) check inside of a broader loop.
If ci != cj, left shift the list elements, as before, and then
unconditionally advance the ci and cj indicies which also covers the
ci == cj case.

Fixes: 1fdf938168c4d26f ("perf tools: Fix use-after-free in help_unknown_cmd()")

Signed-off-by: Sri Jayaramappa <sjayaram@akamai.com>
---
 tools/lib/subcmd/help.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
index ddaeb4eb3e24..db94aa685b73 100644
--- a/tools/lib/subcmd/help.c
+++ b/tools/lib/subcmd/help.c
@@ -97,11 +97,13 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
 			ei++;
 		}
 	}
-	if (ci != cj) {
-		while (ci < cmds->cnt) {
-			cmds->names[cj++] = cmds->names[ci];
-			cmds->names[ci++] = NULL;
+	while (ci < cmds->cnt) {
+		if (ci != cj) {
+			cmds->names[cj] = cmds->names[ci];
+			cmds->names[ci] = NULL;
 		}
+		ci++;
+		cj++;
 	}
 	for (ci = cj; ci < cmds->cnt; ci++)
 		assert(cmds->names[ci] == NULL);
-- 
2.34.1

