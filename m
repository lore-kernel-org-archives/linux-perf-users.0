Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E8C157A67;
	Tue, 18 Jun 2024 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719471; cv=none; b=k45vtvsIE3ZQ5S5+VshT8UroBVbZ7iSmFm/a2Ay1b/H159mU47ZzbKt0ixp4zGX1mjslFKQcDzgIG4Z34GgZmHgrt7xPgQSY8fZ4HcLaA0IDFq4uJh135SOIr33HJPYlcBkwfNQR1ZMMd6k/lVf1UZXLZIzHivl0Rl24uaTR+oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719471; c=relaxed/simple;
	bh=IXmQzLRedxpOTo64sXr8+ql9PlWZ+cIk6tAGQLlJ1fU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZnbzNNOUziK43eUNffvExO8G+86nTTDOKDpqQ44nZs5HWdfyb4i6zi+3XzCS5RXrFeHcSCrN2k+ewtgwW0lk5ljVparg9cm7/4w7UkTGlWFZH4Hq1oJHvp0jrjczbKtmHctUR7zytpeC2EXJJQjgPmmM0u2qInRMkHsZ/knP+3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B8hJPBuo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B8hJPBuo"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IDrZGv001561;
	Tue, 18 Jun 2024 14:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=dEa42Smj0LjS2
	H8hmolyYdKaDlyVIpYrh5mx6Giw1Hc=; b=B8hJPBuos7b20Qk4LBxLqBQD5D8sp
	2FlpU9LBWTSYznyyNSnQH9sqn3SmywY7g4hwA/3hflJGVuzz5kpmvb9CUev2Ow4z
	rsO156aU5OC5EBH96i8A+w4KRO2ZH5SWZ9YQlu7xo9V0RsMiblODwUgfhYoSTc4d
	BIxbP94/slXPNE0EonrPUY+/UcJN5ZJ6BxQRPKn2HAz5VwXzhFzpSzxLwR+0O28p
	jvn3bfUGX0sAqrmKajSS57WM1gNNeqIg0AAvPhdgShNuXkD45sUy87+Owt1/PK74
	EEiT7eiElk7so1FFUAuzWCvARZo4pB2aX1bbRyPFx9fhwOYPKk+mDqnFw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yubgyg1es-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 14:04:21 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45IE4L8K020953;
	Tue, 18 Jun 2024 14:04:21 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yubgyg1eq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 14:04:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45ICsZB5006216;
	Tue, 18 Jun 2024 14:04:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysn9um410-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 14:04:20 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45IE4EJw49349108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 14:04:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF2D12006C;
	Tue, 18 Jun 2024 14:04:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FFC720065;
	Tue, 18 Jun 2024 14:04:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.108.117])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Jun 2024 14:04:10 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH V3 3/3] tools/perf: Fix parallel-perf python script to replace new python syntax ":=" usage
Date: Tue, 18 Jun 2024 19:33:54 +0530
Message-Id: <20240618140354.5765-3-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240618140354.5765-1-atrajeev@linux.vnet.ibm.com>
References: <20240618140354.5765-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: od4ffZBW_SO3X_HBerYtr5K6i4Q8i2xD
X-Proofpoint-GUID: PvAT2FTK0SXzvUW4WosZFb1Wg_E_ptbs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180104

perf test "perf script tests" fails as below in systems
with python 3.6

	File "/home/athira/linux/tools/perf/tests/shell/../../scripts/python/parallel-perf.py", line 442
	if line := p.stdout.readline():
             ^
	SyntaxError: invalid syntax
	--- Cleaning up ---
	---- end(-1) ----
	92: perf script tests: FAILED!

This happens because ":=" is a new syntax that assigns values
to variables as part of a larger expression. This is introduced
from python 3.8 and hence fails in setup with python 3.6
Address this by splitting the large expression and check the
value in two steps:
Previous line: if line := p.stdout.readline():
Current change:
	line = p.stdout.readline()
	if line:

With patch

	./perf test "perf script tests"
	 93: perf script tests:  Ok

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
Changelog:
v1 -> v2
Added "Acked-by" from Adrian

 tools/perf/scripts/python/parallel-perf.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/parallel-perf.py b/tools/perf/scripts/python/parallel-perf.py
index 21f32ec5ed46..be85fd7f6632 100755
--- a/tools/perf/scripts/python/parallel-perf.py
+++ b/tools/perf/scripts/python/parallel-perf.py
@@ -439,7 +439,8 @@ def ProcessCommandOutputLines(cmd, per_cpu, fn, *x):
 	pat = re.compile(r"\s*\[[0-9]+\]")
 	p = subprocess.Popen(cmd, stdout=subprocess.PIPE)
 	while True:
-		if line := p.stdout.readline():
+		line = p.stdout.readline()
+		if line:
 			line = line.decode("utf-8")
 			if pat.match(line):
 				line = line.split()
-- 
2.35.3

