Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7614F202F8F
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Jul 2025 20:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752093499; cv=none; b=TIwo3VZmdm+nipXCNCHPxKIYezFSr1Q/IotdF4s2e9K0VHro546QTzq9dlOW0LVo25EwP2sageBUx80Q9bNgIKQIJ76De1ZBictr/bNXA5DwwLufkKvreGO90+EoafDqofGEC1PXp41Cg9BCzbTTZe2PtDdcFHdsJoLP+Eybin4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752093499; c=relaxed/simple;
	bh=Z0LHwX9J9MBCzqD5Jc5ykCwoGHHTErm1baZ04GGDE5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=prvdsowPhMJESNYOQw1nTc/j99n/pFjgGGv0yR6kRqQvpQOA7RV/VzyK09fzXIZ816UvYDMYj1ilujXX/oVYZBim4hATrACkKODtt7qNKGaf59wHAYfn2SoG6ahWtBIKr5tuibcGQAj3p/qbwlixsGi56fzh79ufVJIDswB9CSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GfBYYoKP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GfBYYoKP"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569Bsx3L026048;
	Wed, 9 Jul 2025 20:38:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=QnzBg1+c/qHU8P5r3tPax01BWGdNwq0YYpDFT6ukF
	BM=; b=GfBYYoKPOygCPwBeMmT4Sy/TNw3zq14wcKZY1pKSQ9G2byiT6X97c8ncw
	b6XJTEZ52hTfZA+yzDoUlSQ/MSZtNRWnGNurXgS/nt3dTHYI2uovPvhvhK2B1XZu
	UUpbgc4dlwdBvgbQuKvY/5GiuVPg4q0OviyKu/vXYd1scrahHHcPOLZJx+BfVGuC
	QxvjtKeqXmzq6XGj/h6+nafwX0iUXIH8CBGPnGPRZz0hBYU1toN2+3WfjOkXPXmr
	kHtK1FCDO+6ci4AJv7K9rpDqLF5aw0G4OUbSWQJvX2Uouu96YBpDckJ4ke3NCpC0
	NJxljgd7koGrJQ7/CDwOT3w5YNyog==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47pur78n3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 20:38:14 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 569KcE01017179;
	Wed, 9 Jul 2025 20:38:14 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47pur78n3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 20:38:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 569J6VOo002865;
	Wed, 9 Jul 2025 20:38:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfvmhxjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 20:38:12 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 569KcAZp58130798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Jul 2025 20:38:11 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE4DD2004D;
	Wed,  9 Jul 2025 20:38:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBE792004B;
	Wed,  9 Jul 2025 20:38:10 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Jul 2025 20:38:10 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: adrian.hunter@intel.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org
Subject: [RFC PATCH v1 1/1] perf test: Increase load in lock contention test on low-activity systems
Date: Wed,  9 Jul 2025 22:38:09 +0200
Message-ID: <20250709203809.3211178-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE4MiBTYWx0ZWRfX8duddsHqpORH VsMR5HLKM1QhJJOsk9ZbuaV6bb7XZd7iUnM4ChuGmwUAKk6LaPZGJyDkRMDNfKmkobeDCsVZO58 0PDxZrkHkeuXdpCtODxo76j67knvph5NYAAPIQTeSDwL4+OkjuRE1R5D2URprTRYOtZ4pv7Szvv
 nKYU+RFf/YWyCQ0S+JAi+MtG9KNKSSdlFrXLXWPKguMejMh6b23P4NKJ0wPmDiJX2oO6P2rrNpm SunxSHHT01hGcyOVymVmMmWsUIv2g5xSKR0hXO0YnKJHjtEsm7Bp8IUyfn94MdxmVXRBUcJ4uNr MFBsBBHciitjaPbArRZzjo8wsFVk8w7jkhNMaTDGr8VsOC3R7/iwGbRj9cSDrwkG0+Eic+9paO7
 84JkBqIIaV6vCAJJl5wvIu/qzSZtn4RNquMrJpaGIQvwf+WLXQ4Z4iWG9z/EK/ZJG2cIyHry
X-Proofpoint-GUID: 3aB9jvtP74FrABC646sRvEQe2ddmtJxw
X-Proofpoint-ORIG-GUID: 2wWI5Bx3RqpTYYMZ94CRkzpPb5Ue1U4f
X-Authority-Analysis: v=2.4 cv=W/M4VQWk c=1 sm=1 tr=0 ts=686ed336 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=Q_qaQDnRWyw_8FNobJAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1011 suspectscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090182

On low-activity systems, the 'kernel lock contention analysis test'
often fails due to insufficient system load. To address this, the test
now increases load by using multiple groups and threads in 'perf bench
sched messaging', scaled to the number of available CPUs.

Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 tools/perf/tests/shell/lock_contention.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
index 30d195d4c62f..e859e1503b5c 100755
--- a/tools/perf/tests/shell/lock_contention.sh
+++ b/tools/perf/tests/shell/lock_contention.sh
@@ -44,7 +44,8 @@ check() {
 test_record()
 {
 	echo "Testing perf lock record and perf lock contention"
-	perf lock record -o ${perfdata} -- perf bench sched messaging > /dev/null 2>&1
+	perf lock record -o ${perfdata} -- perf bench sched messaging \
+		--group "$(nproc)" --thread "$(nproc)" > /dev/null 2>&1
 	# the output goes to the stderr and we expect only 1 output (-E 1)
 	perf lock contention -i ${perfdata} -E 1 -q 2> ${result}
 	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
--
2.48.1

