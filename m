Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246DD1C2DAB;
	Tue,  1 Oct 2024 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727786563; cv=none; b=W1HApvD2Jx87AOmsl3UwibbCqD2HfGHQ2y95j6uZecfF0uSvms2BdNyrYoKIzVfY5ub9ZMPWOsJfLtzLqXOd/YapnaxOoCQKwkM6GRQpMnOUMcG/IeY1twrG84o6Jxj6Dk3IViKTX1M/Usst2sVEwKuH3M7w5NyQbqWUyy3HCSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727786563; c=relaxed/simple;
	bh=/e8ReWSXSGoTJ3bsYfszSve4fpnV5wHTvwyf3dkcHMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hYsnpEb2x/gyVqVPRpaTmDunDiKwws4SBpNQGMOdVO5WUtr2vtdwiWWLPtO9QoFqT86ZNJRpcGMPjFWzS+xTM2PN8yH6yf5lar0PXvYhb+kzB4HROvEiFwT1YIQTwAK3w1v5qsL1Gw5Dy7/YxAG6LdSxnkmrxu5e/B30gPQodhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NXMbDiCQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NXMbDiCQ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491BnMKn007258;
	Tue, 1 Oct 2024 12:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=o2bdT1bWiAa/+YXe53/ZHg1Y+F
	THs9qUTliiUmDu9eA=; b=NXMbDiCQ6S668CD3AO7FcNv+1D/DzPIuSeYPn3/8xT
	WMS6cqBIFz2aJnrnPUxG4zbw83EUEmvEAPM1DcDtAaulM/mJWYWuDZ4N8IJqdtk+
	JgkQPOhuUtd/HTW8uhiZyXbUtV1fxJdpqYVrySGu16Jn9NiCB+fIFLHB/W1A8E77
	V0SfxieA8buR3CqwdkLfpgWU7doDXlsrS4K0N2BKJd1vyiaI/aK8poo9mFys8Y+o
	B6jZVjJkSNHTxlkuzjTRrq0hFnnAqN/QHglNkXzGKjEfawzFfLXNhdvaYpK/qmyx
	pgyckUD+gg3oOU4dGnvAEJ640ut5HVtzyms6E9i6Tm5g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420ckj9m3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 12:42:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 491ARnNt013070;
	Tue, 1 Oct 2024 12:42:36 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xxbjc3y2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 12:42:36 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 491CgXs141156886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Oct 2024 12:42:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15E082004B;
	Tue,  1 Oct 2024 12:42:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE2A820040;
	Tue,  1 Oct 2024 12:42:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Oct 2024 12:42:32 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v2] perf/test: perf test 86 fails on s390
Date: Tue,  1 Oct 2024 14:42:23 +0200
Message-ID: <20241001124224.3370306-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fDsWveOIYyg0pXdwLXQS1NRzvMiDTVrp
X-Proofpoint-GUID: fDsWveOIYyg0pXdwLXQS1NRzvMiDTVrp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_09,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410010081

Command perf test 86 fails on s390:
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

The root cause is a new stack layout, two functions have been added
as seen below.

 # perf script | tac | grep -m1 '^ping' -B9 | tac
 ping  866856 [007] 25979.494921: probe_libc:inet_pton: (3ff8ec48020)
	     3ff8ec48020 inet_pton+0x0 (inlined)
 new -->     3ff8ec5e6e7 text_to_binary_address+0x1007 (inlined)
 new -->     3ff8ec5e6e7 gaih_inet+0x1007 (inlined)
	     3ff8ec5e6e7 getaddrinfo+0x1007 (/usr/lib64/libc.so.6)
	     2aa3fe04bf5 main+0xff5 (/usr/bin/ping)
	     3ff8eb34a5b __libc_start_call_main+0x8b (/usr/lib64/libc.so.6)
	     3ff8eb34b5d __libc_start_main@GLIBC_2.2+0xad (inlined)
	     2aa3fe06a1f [unknown] (/usr/bin/ping)

 #

The new functions in the call chain are:
 - text_to_binary_address()
 - gaih_inet().

Both functions are inlined and do not show up in the output
of the nm command:

  # nm -a /usr/lib64/libc.so.6 | \
	grep -E '(text_to_binary_address|gaih_inet)$'
  #

There is no possibility to add these 2 functions depending on their
existance in the C library.

Add text_to_binary_address() and gaih_inet() to the list of
expected functions in an compatible way and extend the regular
expression. On s390 the backtrace can now be

   Before                   After
   probe_libc:inet_pton     probe_libc:inet_pton
   inet_pton		    inet_pton
   getaddrinfo		    getaddrinfo | text_to_binary_address
   main			    main | gaih_inet

Output after:
 # perf test -F 86
 86: probe libc's inet_pton & backtrace it with ping  : Ok
 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index f38c8ead0b03..47a26f25db9f 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -40,8 +40,8 @@ trace_libc_inet_pton_backtrace() {
 	case "$(uname -m)" in
 	s390x)
 		eventattr='call-graph=dwarf,max-stack=4'
-		echo "(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
-		echo "main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$" >> $expected
+		echo "((__GI_)?getaddrinfo|text_to_binary_address)\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
+		echo "(gaih_inet|main)\+0x[[:xdigit:]]+[[:space:]]\(inlined|.*/bin/ping.*\)$" >> $expected
 		;;
 	ppc64|ppc64le)
 		eventattr='max-stack=4'
-- 
2.46.2

