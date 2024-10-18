Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5619517BB25;
	Fri, 18 Oct 2024 08:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729239464; cv=none; b=lLNw8rQbBz5fv5GUeso9/UeA95JIM8UuPmJCISpeigWky2thD6zbsAh+jsuJ61+4cbzGqwkMTF0WFh4v3bDkBlwL/VjKbPBE4trznt1OKUgVuRDfYTU0BGlWq5QJNUPa+kyH9VVFzgFHgFY642/41feere6TmGkJSUPlVtgfqZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729239464; c=relaxed/simple;
	bh=J3tV5Gy31a2yB7qDOBj9sThq/F6IZAcsrdG9/FCxDlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p0HhGjznH8rx2a3N3P5jX3r5hCwbJ7ggtvQUlYKz+XPlEDUngWn99ZU4jKZrnCKUxKOfYrrJeB6CNAyOg922dVtnzK8MkLBgusiscmrw+ydH2BcY6XPRn3Ra5t1Hxu+uRPORnixfIV/SPq0KY4LNHv5cYjuqWN5AMP5wB1Ony2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AM6sDn7J; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AM6sDn7J"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HJSAQb014401;
	Fri, 18 Oct 2024 08:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=i7Z3I+1Oj6I3MkxPI09cn7YcsRpCG2gl9B5x6nXa3
	24=; b=AM6sDn7Jfxop8hDoIgZKZfbbq4wPY3IXHtpFWJMXfUEjhXSKanwYpMeLw
	JTS+v/bTymf6ynOrflMQvxn/0/QuEBy1lXq1lt7p5mjIii6i96MSQjfjcdlhQ4Kv
	ujtyeE71ePOqtadk5eapuiL/FlLx6xxY2KriotwydxcV/PUKkUa4MIWCMNWkSJJg
	dpjPk0jrJ1ASd14jL2q+DS2H3CSu86c5eKYNNFFvn+iJD1lcfktcLYmQTGz33PlT
	HHUSG38fqtmIUKnCSJa6ietQsNyeWVa309el+N4qY5b5u0yfIXz/uKrGz5w7uMnf
	/WndEzujxxVHr1hH4iDw2RqKII7Kw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42aqgr7ka7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 08:17:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49I6IZAj005937;
	Fri, 18 Oct 2024 08:17:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 428651b040-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 08:17:37 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49I8HYQt54395370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 08:17:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 531DD2004E;
	Fri, 18 Oct 2024 08:17:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 096F92004B;
	Fri, 18 Oct 2024 08:17:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Oct 2024 08:17:33 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v2] perf test: Fix perf test case 84 on s390
Date: Fri, 18 Oct 2024 10:17:32 +0200
Message-ID: <20241018081732.1391060-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xaTqMpR9ZuIx956cgTdi_ejaXt-deGrD
X-Proofpoint-GUID: xaTqMpR9ZuIx956cgTdi_ejaXt-deGrD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410180052

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

