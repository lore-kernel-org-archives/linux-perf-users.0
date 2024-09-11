Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DA118FDC5;
	Wed, 11 Sep 2024 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057753; cv=none; b=rbNPgL6dQExYlDADg0+O7SrnJlh7ctrt0CKDyd+XmuakzqYXByR4Q0agCkRN1HkGyJobhezR8JhMCQeOs5u9qCBB+q0/t3AXunkFVCtihTLFx5ucgpUzZ0J0JYOypR2pKivWDCO4HlDtlfNyN26nYS296ei/6cSx3S4qIDFa2WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057753; c=relaxed/simple;
	bh=Z7rE4+zD3fmyG6rWCOy5DOeJ5ATZJa9DH9aKX4L82ps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pLXBHyV0nbsy/PRiu2XDGCJaGdZZ0Mp1aXTxrfwhgmWzVAhPip80JrVbW21YGpxogcLhDbLR3dcLgq3Lk4Hd+965ItZAIEbhXRHRYTNaC/MDuEuec5lym6pVWOnWGYBkhbsz2+bf0p6VvFU6KL15xD1tZD6OeOwsYVlCB+s26HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E8hDSchC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E8hDSchC"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BCA3Td006405;
	Wed, 11 Sep 2024 12:29:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=aAL0X3AwCZdEmfFAA25eaqh/5l
	ycL7ZBUyXEACWNUqM=; b=E8hDSchCCtQ7rMYr7qC/Xzsecj6Ad6ohjOatn3pdxu
	NqfwAjU6eHapmRPgSw/rv8SfpZaNQ0mMdG51HYyO7A8scB78zGe0K1Jbw8jtbLYt
	MJug0nCmGMd/432FJMVGxE43b2UDc0GffQNe1COtO3zVD87w/ycIbIOzKRU30Cfo
	wp1oJLR+z8UlwA3WactJdHi5/G+g4K2RBpHAiwX0noNe3Ny0JSD+e9Pc6yy7DARO
	qtVz/6v9exMa1eSDwszpyLMh4E6+w/8sRKS9pL/7H4yZfULR2G8tgp1M86v6p/zZ
	sBd9DYkEXKrNKuvDWV7aS86Vg6NRv/p01tMjxp2spgww==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gefyne4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 12:29:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48BAFS3e019843;
	Wed, 11 Sep 2024 12:29:05 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h25q1fc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 12:29:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48BCT1Pl49807852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 12:29:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DC0720043;
	Wed, 11 Sep 2024 12:29:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4299020040;
	Wed, 11 Sep 2024 12:29:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Sep 2024 12:29:01 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Silence perf check subcommand when not supported
Date: Wed, 11 Sep 2024 14:28:49 +0200
Message-ID: <20240911122850.926303-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Eq-IcTSw_y9urbdS1hknhfIE4thPurOv
X-Proofpoint-ORIG-GUID: Eq-IcTSw_y9urbdS1hknhfIE4thPurOv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=951 priorityscore=1501
 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409110090

Perf subcommand check might not be supported and prints an
error message when used:

 # perf check feature -q libtraceevent
 perf: 'check' is not a perf-command. See 'perf --help'.

 Did you mean one of these?
        c2c
        sched
 #

Drop this error message, the return code is sufficient.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/shell/lib/probe_vfs_getname.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index 5c33ec7a5a63..697fbe296a62 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -32,7 +32,7 @@ skip_if_no_debuginfo() {
 # check if perf is compiled with libtraceevent support
 skip_no_probe_record_support() {
 	if [ $had_vfs_getname -eq 1 ] ; then
-		perf check feature -q libtraceevent && return 1
+		perf check feature -q libtraceevent >/dev/null 2>&1 && return 1
 		return 2
 	fi
 }
-- 
2.46.0

