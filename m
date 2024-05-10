Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22595ECF;
	Fri, 10 May 2024 00:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715301333; cv=none; b=LrVWlbq6fm++20+XktlxmLOdGxD85a/csdTp+FGMOeCTSP1V6+ZfD5/clBprqcqhYAAIL3fVpHusnZkxta2NcoYy5aI0HwO3PcQBeHQIiykTitqo1uEgMDkG6OHx1P0Qk2TuHBQmmV9yGtvzgd6iDcaH2nFD5DyIO6HVJUlzKBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715301333; c=relaxed/simple;
	bh=JJZKe2t0kamyMzVROuPedbDxFm+zHMjxwqHfKjv86Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BAG+8ob9d7zlilE031i/2ZQSb6BJBcibSThwv5J03/G+Y4EheYNA2MnQfNxI1jqzLuGXT4b/xQV1/bujgvpelGOCs7C+KvzVkh4wXGoDKNnwDN4Qe0Iywhfr4NXtjONnRabe/AR8wGulrnHrKj1dTuOfAIybD7IypJUql6sEUE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L1jQ/h+2; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L1jQ/h+2"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44A0J0xi002256;
	Fri, 10 May 2024 00:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=ukCGGXI9Jxb1GstaggI2PMFSAmqWV+ZT0DPIrBgA8Ns=;
 b=L1jQ/h+2fhCTmuZ25GA3iapSMQbWow1nNDIQenSfqKOQy8+Qixe2ScOBteDgAYKN47ma
 GW5NfNVXChmz22KuVNOGVt4k3ZtoRWUBz6VMjSi2sk17Ql8TncNNzrXUJ8ngYSsd3fId
 Rv+JU7BnzmeM1lTQTkEvCbcxN6bmIG+xuyme4CyZs/3neFQQohNrysyOMnfto8+Sgkue
 xKn+UOk/9vhOfK6ZM7Qbhv85HEg7iauXCG1dRL/z10pysFHjs07tKdiOq8I61U6F7f+F
 ZDQTeA6UVDrsbjcTllaby4wgodepU6xVE67g1sthM/YGwstxfkSe0st5ffu3ThBkQDKh ug== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y17qwg263-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 00:34:53 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 449NSV0t020216;
	Fri, 10 May 2024 00:34:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfp9693-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 00:34:27 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44A0XcEe035161;
	Fri, 10 May 2024 00:34:26 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xysfp968q-1;
	Fri, 10 May 2024 00:34:26 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: namhyung@kernel.org, acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        samasth.norway.ananda@oracle.com
Subject: [PATCH RESEND] perf daemon: Fix file leak in daemon_session__control
Date: Thu,  9 May 2024 17:34:24 -0700
Message-ID: <20240510003424.2016914-1-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_12,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405100002
X-Proofpoint-GUID: NFJhzcK27C6HUsDn3dol3madTVv9GZFb
X-Proofpoint-ORIG-GUID: NFJhzcK27C6HUsDn3dol3madTVv9GZFb

The open() function returns -1 on error.
'control' and 'ack' both initialized with open() and further
validated with 'if' statement. 'if (!control)' would evaluate
to 'true' if returned value on error were '0' but it is actually '-1'.

Fixes: edcaa47958c7 ("perf daemon: Add 'ping' command")
Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
---
Found this error through static analysis. This has only been compile
tested.
---
 tools/perf/builtin-daemon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 83954af36753..de76bbc50bfb 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -523,7 +523,7 @@ static int daemon_session__control(struct daemon_session *session,
 		  session->base, SESSION_CONTROL);
 
 	control = open(control_path, O_WRONLY|O_NONBLOCK);
-	if (!control)
+	if (control < 0)
 		return -1;
 
 	if (do_ack) {
@@ -532,7 +532,7 @@ static int daemon_session__control(struct daemon_session *session,
 			  session->base, SESSION_ACK);
 
 		ack = open(ack_path, O_RDONLY, O_NONBLOCK);
-		if (!ack) {
+		if (ack < 0) {
 			close(control);
 			return -1;
 		}
-- 
2.42.0

