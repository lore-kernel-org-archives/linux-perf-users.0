Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAF5231C95;
	Tue, 15 Oct 2024 07:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978472; cv=none; b=XtrfScH2CzLpuzSeX7i72qvpN2YOSIiV6BXtxi9w3PQsh0jhtvCKJq+lHX38EDDAl0Oc9kKtVG1K0Ioym2lWSDaKtyt/MxrJ5KjcExKoSNr5HiFcns+F1W4bXxxdLR/xF5mok+n58/JTxeIMisVGXJ+k8ptXIoqM41ID/23xhH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978472; c=relaxed/simple;
	bh=bjQqn46aGvfBXM/1EuRak8ND/FNHrfXMzpYKGjs4ayA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fztQynlVM1vOYtqZUzlgyQrd6TmL/EYIm/xtRalqTd9KWvlG4bak4Ca2xVJlaSHa3AkprQuCaDZjuw67NzfjqMXiuHnM3dc/oclF2Y+cdRYKec85kgRAAlyI9oyNFC5uZA9qhjbx/+DKW1SeIq7flV3bqn7pEfDJ57lwsTHUtrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D5l+JJGI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D5l+JJGI"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F7KOrt031017;
	Tue, 15 Oct 2024 07:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=FUw6yiePSnsbQ/cW85U02YPjxHS0W4rGT9lOjxkPw
	Q4=; b=D5l+JJGIeOiFviFBWtOx6wxD2qbT2mD5HRitZjq7dTrbYpa8tREgC8gVn
	K3cn+RBbz2nHD69ifyx4MhZDcv195tdBUKmvbxsz3a7Tzy5W3XOyPvEsGq1OcOGR
	PatXbwpI2Lf1WqSUNMczczdGRUgu/lVJY0HvtxE+AErVKTXcCES4JruWwA4f4kY7
	kve/v7jn1jmFNAPLlj9QVM7UjUc86sAX/CO3LwR9CmSQQQJuD7TFSLVJ6SsGHh9l
	UBJOcMxDR8dzkWPTtpqf5Iibq8PBdW+WnZRv51m2CnrOOB4k64QJZqKme5Gfwy3B
	po/xYQxReVQz/Zp+roZJ3HOT5t6uw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429kwvr470-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 07:47:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49F4800l006401;
	Tue, 15 Oct 2024 07:47:39 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284xk2evx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 07:47:39 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49F7laDr31588922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 07:47:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A3B120049;
	Tue, 15 Oct 2024 07:47:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0018820040;
	Tue, 15 Oct 2024 07:47:35 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Oct 2024 07:47:35 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Fix perf test case 84 on s390
Date: Tue, 15 Oct 2024 09:47:26 +0200
Message-ID: <20241015074726.268029-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: x_9bzKsb9YCoEXrhLBvQ5ikC6DjQNHa4
X-Proofpoint-ORIG-GUID: x_9bzKsb9YCoEXrhLBvQ5ikC6DjQNHa4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1011 phishscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150049

Perf test case 84 'perf pipe recording and injection test'
sometime fails on s390, especially on z/VM virtual machines.

This is caused by a very short run time of workload

  # perf test -w noploop

which runs for 1 second. Occasionally this is not long
enough and the perf report has no samples for symbol noploop.

Fix this and enlarge the runtime for the perf work load
to 3 seconds. This ensures the symbol noploop is always
present.

Output before:
 Inject -b build-ids test
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.195 MB - ]
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.277 MB - ]
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.195 MB - ]
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.160 MB
			 /tmp/perf.data.ELzRdq (4031 samples) ]
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.195 MB - ]
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.195 MB - ]
 Inject -b build-ids test [Success]

 Inject --buildid-all build-ids test
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.195 MB - ]
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.014 MB - ]
 Inject --buildid-all build-ids test [Failed - cannot find
				noploop function in pipe #2]

Output after:
Successful execution for over 10 times in a loop.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 tools/perf/tests/shell/pipe_test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/pipe_test.sh b/tools/perf/tests/shell/pipe_test.sh
index d4c8005ce9b9..02d9ef27c8e7 100755
--- a/tools/perf/tests/shell/pipe_test.sh
+++ b/tools/perf/tests/shell/pipe_test.sh
@@ -12,7 +12,7 @@ skip_test_missing_symbol ${sym}
 
 data=$(mktemp /tmp/perf.data.XXXXXX)
 data2=$(mktemp /tmp/perf.data2.XXXXXX)
-prog="perf test -w noploop"
+prog="perf test -w noploop 3"
 err=0
 
 set -e
-- 
2.47.0

