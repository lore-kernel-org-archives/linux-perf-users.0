Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D70155392;
	Mon, 16 Sep 2024 12:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726491458; cv=none; b=WrrctQtJRMmKQPdqPFaunBGqjh9dxQpq7cLG/l2inNjojCvVz/ZGo+qJuRwX8s46l1QT4Tip5z4jFVaKYB6hnCrS0DA9j7wYXC7XKdVIO/2+ebfO4g8I8rHm7Dk4ILN8aJKBYnHrwxePdK2hyjMxOuEYd/EoTsDVUrqoVbJieUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726491458; c=relaxed/simple;
	bh=gA89W1nynIjGy12J0nmJFgKEu5Encxd4oSRyP4WUHl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fr6gGYuesW/gfC78nvpOaNOo9DummoKyrRNdMDBcJiu9bY4xu0mSLV4lbv9FjXZFg7cTWedQPY9RTReL6n8adXVIPhPs70rHWHJYfA/DfcV2QBaTzGbV94btlYLpD29hfAopF6ghIhCnNJkW6Sl11Dv6PSY50n42WBgboNAnfZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aswC42Xo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aswC42Xo"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GCb2jg005694;
	Mon, 16 Sep 2024 12:57:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=jQ+8TPexO5T8e+V0qFd6/RpZSe
	tZ9RkxOs8TOyfZ4xY=; b=aswC42XofSlRSLt6KVKa1e7g0dbLz91h7KEPySESl0
	6W+O5MpbxzSJwjjCYUHGUEE/ONjnpvmuAOVon2DZlMLjimLY7rkpCN6fdubju9F2
	gYsfRzy9582+yh4D+jnlkotF1zt1XpK7RcR7Q9azo5SUtfX7is7Zcq34guUWT7Lg
	CQpV+L1d5zDXd3kjAwWugnSbjqnlgnO1TbT8TcbITl0r55mUnqejbbOiq11QgYbn
	SNRpKu0dduIyn7tDpWWCksc8Pey67gJShJT9oNHuvjDuRjqxZQjt9rS4XhxVm64C
	5HK1SHj6axPV6cAzrqQUUZ6VDC2xqLcdNvZMiBY0bJvw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3vnhs3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 12:57:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48GCBAQj024627;
	Mon, 16 Sep 2024 12:57:30 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41nq1mq756-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 12:57:30 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48GCvRfQ36372822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 12:57:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C36F20043;
	Mon, 16 Sep 2024 12:57:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2E9B20040;
	Mon, 16 Sep 2024 12:57:26 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Sep 2024 12:57:26 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf/test: perf test 86 fails on s390 repo linux-next
Date: Mon, 16 Sep 2024 14:57:18 +0200
Message-ID: <20240916125718.3024270-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: T2Ld0KKiq2QoP3MDIZmQNJgTZCj_WLth
X-Proofpoint-GUID: T2Ld0KKiq2QoP3MDIZmQNJgTZCj_WLth
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-16_09,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409160081

Command perf test 86 fails on s390 using linux-next repository:
 # perf test -F 86
 ping 868299 [007] 28248.013596: probe_libc:inet_pton_1: (3ff95948020)
 3ff95948020 inet_pton+0x0 (inlined)
 3ff9595e6e7 text_to_binary_address+0x1007 (inlined)
 3ff9595e6e7 gaih_inet+0x1007 (inlined)
 FAIL: expected backtrace entry \
	 "main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
	 got "3ff9595e6e7 gaih_inet+0x1007 (inlined)"
 86: probe libc's inet_pton & backtrace it with ping  : FAILED!
 #

The root cause is a new stack layout, some functions have been added
as seen below. Add text_to_binary_address and friends to the
list of expected functions.

 # perf script | tac | grep -m1 '^ping' -B9 | tac
 ping  866856 [007] 25979.494921: probe_libc:inet_pton: (3ff8ec48020)
	     3ff8ec48020 inet_pton+0x0 (inlined)
	     3ff8ec5e6e7 text_to_binary_address+0x1007 (inlined)
	     3ff8ec5e6e7 gaih_inet+0x1007 (inlined)
	     3ff8ec5e6e7 getaddrinfo+0x1007 (/usr/lib64/libc.so.6)
	     2aa3fe04bf5 main+0xff5 (/usr/bin/ping)
	     3ff8eb34a5b __libc_start_call_main+0x8b (/usr/lib64/libc.so.6)
	     3ff8eb34b5d __libc_start_main@GLIBC_2.2+0xad (inlined)
	     2aa3fe06a1f [unknown] (/usr/bin/ping)

 #

Output after:
 # perf test -F 86
 86: probe libc's inet_pton & backtrace it with ping  : Ok
 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index f38c8ead0b03..bc6e2fe1d999 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -40,6 +40,8 @@ trace_libc_inet_pton_backtrace() {
 	case "$(uname -m)" in
 	s390x)
 		eventattr='call-graph=dwarf,max-stack=4'
+		echo "text_to_binary_address\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
+		echo "gaih_inet\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
 		echo "(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
 		echo "main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$" >> $expected
 		;;
-- 
2.46.0

