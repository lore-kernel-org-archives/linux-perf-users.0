Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A751A0B06;
	Fri, 14 Jun 2024 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386083; cv=none; b=MONai/VRDOjdz8oSW7U66AYUs9u2GWVJoWi5GKMpPhbXZlYX9Gli38HD906GHKBhRq8toOKQeKTP9dV46AjKb/HV/EkTHH8l3Uwa64s1U7zQ5q3UDFclcBa785eHi5sptWPG4MnrqfMt7BiUcfnQyAVdBkkUaGRiYFJvUjq+EW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386083; c=relaxed/simple;
	bh=ARZFA4y/9uwLTB3MdL3MTgkr1diITeL0LLNBiW47wT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PynNQT9Z+mveDWEFc2YvXJwxIO2ULRNWJil7RGsU/CQ1AsMRx1F+HjFJKYVYriAtRe3YdVbwnqNRwsWEeYitb9RxfpEuc5j1fIheBKe5OgyEnainRV4URfunl+zRcvQFqwQysk6Kq1EgXt4euf8VI0ShrrM2ow4R96EKPd61AcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J+WbIdRx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J+WbIdRx"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45EHR5OL029770;
	Fri, 14 Jun 2024 17:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=J39yxlvbP0yKB
	JnLw2grb5us5I6tyJ4PFtaeuOyYn04=; b=J+WbIdRxbxQkuPmm7gT459Jqdo9kk
	YeYzalW5e3nG0VHE0NwyklOb6Ng1mWlhzcyjK6EVVDqPSaWl7HbSgtQJTqIBe+u7
	gbk1lrILYTzCvc+W8A9SU8y/fBoaYLBF0rocL0FFPq9kzuAPO2+7cvHtrp4y0OUW
	RNgGd3aJqAtDjotXttns5rfOUDyyZoWba76RuBnkCISI+U4JjdeBTU3P023Jzf0K
	UijtEBNfE8mv4emHR3qHQaSq1jOiT5MQ7ZotPY5iTfjbgrwXuJYuNdOkxh1/v0G3
	rfHyKywcoruf0hrJzqa9ykNLZaO2WoYy2pzyKNuOAa5/WenTBmAQg9HOA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yrryk05nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 17:27:57 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45EHRv2F031035;
	Fri, 14 Jun 2024 17:27:57 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yrryk05nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 17:27:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45EGWJbU027267;
	Fri, 14 Jun 2024 17:27:56 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn211km5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 17:27:55 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45EHRoP433489448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 17:27:52 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40ADC2004D;
	Fri, 14 Jun 2024 17:27:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A706420040;
	Fri, 14 Jun 2024 17:27:47 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.82.18])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Jun 2024 17:27:47 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH 2/2] tools/perf: Fix parallel-perf python script to replace new python syntax ":=" usage
Date: Fri, 14 Jun 2024 22:57:42 +0530
Message-Id: <20240614172742.56976-2-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240614172742.56976-1-atrajeev@linux.vnet.ibm.com>
References: <20240614172742.56976-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pGwEYCnSDPcD3FvjaSlIoOBSnVV70lEK
X-Proofpoint-ORIG-GUID: uLuJWEu8xRSWAMWgx45eDHejLO7LQxr2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_15,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 spamscore=0 mlxscore=0 adultscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406140119

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
---
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

