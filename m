Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC6618C33E;
	Fri, 18 Oct 2024 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729239419; cv=none; b=h59KdWFzTmhqLaFge7i8I147pnp4dT/YCtAIG5frZ+BH0vCnrMDExFTN/FjMgbEB4Zdm3ydQV4xp7uCmolpUWskZa4ZfUkg0TvIQNF1dGoksWev8Oo49pwhcuHhYwIsICU/GRPR5B054prXzv4Du9rC9VSiet5/VSNpLJ0hqGDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729239419; c=relaxed/simple;
	bh=J3tV5Gy31a2yB7qDOBj9sThq/F6IZAcsrdG9/FCxDlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fXyGMPV6qm63gk87zRJFOodDLqQQSnT6OOlBXqD+s6NTwWDteQneIBvl8JR6gy7yHr+Lrsa0jiB/k4aViJ3pPxRNILvQ/lO9Y9kFWRcJn89EmH05cZv4QO1qMyFned90tfvhGcLCIkjGt5mDNv/0PvsJDXUOkq1uOAcVssQ6LYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fpXoVo1f; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fpXoVo1f"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HJSBPx008096;
	Fri, 18 Oct 2024 08:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=i7Z3I+1Oj6I3MkxPI09cn7YcsRpCG2gl9B5x6nXa3
	24=; b=fpXoVo1fPNyxSUZUKOYfHMKC0EZ0tmVK33PWEMDTzdNc+Cl2s3ezcEowC
	ey4CWiSFNcejWyznuKMqD6E/W4dn6WjgQZ97+v70klLEtv6J3wn5+rrWQSpg9dVR
	mwyxImXoofRPaKFf/kYgmMs/VPzc2pYA7rLGXKI4VYSbq1ZygFxoY4oyuIJ/+dfa
	OUCOhwrQXh8bHwBAzI78C7DEjNFLknjdbh7eFtkiopG3AKqYNUemKdDAHyXGyy51
	W9gxou++/D+NHfok6+Ki9AiFDUkjHZbrq+6CPmgVpeMtyGjXHsS08QuDlZcc4SY9
	6B70vLnm74wdUksICdhH0Sk6TnzOA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42as8a7881-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 08:16:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49I63E8o005286;
	Fri, 18 Oct 2024 08:16:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4285njk35a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 08:16:52 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49I8Gmnh11010492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 08:16:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD17F2004F;
	Fri, 18 Oct 2024 08:16:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B39E32004B;
	Fri, 18 Oct 2024 08:16:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Oct 2024 08:16:48 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Fix perf test case 84 on s390
Date: Fri, 18 Oct 2024 10:16:40 +0200
Message-ID: <20241018081640.1388661-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: REk3_O-sUp8lr57AjoBe3pZdIfsgm3Cm
X-Proofpoint-ORIG-GUID: REk3_O-sUp8lr57AjoBe3pZdIfsgm3Cm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180052

Perf test case 84 'perf pipe recording and injection test'
sometime fails on s390, especially on z/VM virtual machines.

This is caused by a very short run time of workload

  # perf test -w noploop

which runs for 1 second. Occasionally this is not long
enough and the perf report has no samples for symbol noploop.

Fix this and enlarge the runtime for the perf work load
to 3 seconds. This ensures the symbol noploop is always
present. Since only s390 is affected, make this loop
architecture dependend.

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
Suggested-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/pipe_test.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/shell/pipe_test.sh b/tools/perf/tests/shell/pipe_test.sh
index d4c8005ce9b9..e459aa99a951 100755
--- a/tools/perf/tests/shell/pipe_test.sh
+++ b/tools/perf/tests/shell/pipe_test.sh
@@ -13,6 +13,7 @@ skip_test_missing_symbol ${sym}
 data=$(mktemp /tmp/perf.data.XXXXXX)
 data2=$(mktemp /tmp/perf.data2.XXXXXX)
 prog="perf test -w noploop"
+[ "$(uname -m)" = "s390x" ] && prog="$prog 3"
 err=0
 
 set -e
-- 
2.47.0

