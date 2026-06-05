Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520103A9DB9
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 06:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780640867; cv=none; b=i1m+NotS/5bIq44ChFtpxb5c+TmCMYI64DaBayikhE5a+cw6C5FXS79lRXyDweHUP+FVA5xx06jc6SevU/pcRZe2UiPYp3CtGK3crpmMlGYjoPPKc9En4+pQX1lgAe3WkKGyY0DzJD41CHKOhPyZLaamRphAUCJqUHngcgcV5Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780640867; c=relaxed/simple;
	bh=B65SGlsrFDC6LA0nk/rRJftiDWuOr1DbI/EZgVz7JWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BrXTXVGFhrN12YZhHkw8jrj7+peM9iw0Bx5GsIQDf34EGWbwQB+7deh9T2mL0Nis7MMNNaBJ6QikBUIfWER3AyodFhR2Sj3SSQc44hzSRSOPP0XBvuHhNTrpt581/d593RCA0eSmYWWcYrhRKZA+1cKrCgp8MfbaClM4xi2c6+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FfdHPFD8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FfdHPFD8"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6551Ja5A518996;
	Fri, 5 Jun 2026 06:27:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=/TvZyBYfiwgAkrVUxgA0davqC3k8R0etHNYu91uIS
	Xo=; b=FfdHPFD8Sijh0bHJFbBO+JERYb1Tb3fDpmDsFBtPIN3Os568f+zJUO8um
	AID60E8p7UDI+tQEuCNM5PltK6A8nxJrzNrm3IyHsID8sAbyp/KBqB4cNYzOLvMx
	MQi7GoUPQPNtc9k7VraeeelrsScBH80Eyt90WMt0dJnVsnx9bC3uylCesaOn2f1u
	OT+XQGR2v1KDSmp7AnFV7yDjxEMfur5XK4WCOsVa9GEGGqragftq2yObbovmBRA5
	zNiNatVV2DBArcyJOxor06IjsQYgkZsByoRnLnhfkyB1jFj23m90ghdE4M965eyP
	h+Xin/yBWQra1lWDd7XpSBr4j21Gg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqm5b3vy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 06:27:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6556OWZr030735;
	Fri, 5 Jun 2026 06:27:36 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egceh07qd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 06:27:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6556RWLO47645116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jun 2026 06:27:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64D4F20040;
	Fri,  5 Jun 2026 06:27:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D74720043;
	Fri,  5 Jun 2026 06:27:28 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.39.24.40])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Jun 2026 06:27:27 +0000 (GMT)
From: Shivani Nittor <shivani@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
        irogers@google.com, namhyung@kernel.org, ravi.bangoria@amd.com
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, shivani@linux.ibm.com
Subject: [PATCH] perf scripts: Add configurable sorting option to powerpc-hcalls
Date: Fri,  5 Jun 2026 11:57:17 +0530
Message-ID: <20260605062717.24982-1-shivani@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: eSijdZ5xjZt9X6PM_LH0xsgP54uN9xO0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA1NiBTYWx0ZWRfX+el2/2x+rrlq
 TBte7qdtniS9Nfmmg0f7AfDK9f/PE9zRnb/D+ofwI2FbfWjnAg6tEWJK+/eE3ouqPYzmYiKclo+
 TWBNbzlR3MK5rW+RkUPQvqHrp6M93OAHZDnX3WvtTI+b0faWp+TkUW8pRq/+mhaeScDht2IYMgq
 5JX69bWJmlDxdWjCe8QB/mcq94p8ZQv1EZigvHpEdBXPKzszyswcIdnHi33TgTLB1XKgDZSX/3C
 sPp8s4eIUqM5ngzK1dBRuZOAr0nWDzV5OF2UR19RNjyhRwtfJo5EZ2T74hf8SwgQq/GNZZzMrKQ
 CuONBcUi/dP8UmYrn3ArroHIBLkcrrEPZRSuaRXdI/PMk92UF83AyDGthEJwYwrt3Hto0liQenT
 Ht8ExIDUnOvE70IifEWVfg9VFezHsTgiYlh+Fuqg7uM8bx6ZJn9OGh0WO2fqaTrtMNdOVAlsplj
 Rie3tlLYjj5iCClsLEQ==
X-Proofpoint-ORIG-GUID: eRtIVGCl-PVjeJxsz9qjGpi1YbeIv0AC
X-Authority-Analysis: v=2.4 cv=Vf3H+lp9 c=1 sm=1 tr=0 ts=6a226c59 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=PuGCGJEl-EjltSXZxTIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050056

The powerpc-hcalls.py script currently prints hypercall
statistics in a fixed sort order based on the number of
hcall occurrences, making it difficult to analyze hcalls
from different execution characteristics.

Add support for runtime-configurable sorting so users
can order hypercall statistics by count, minimum
latency, maximum latency, or average latency using
a --sort option.

Parse arguments through sys.argv to support perf script
argument passing semantics.

Example:

perf record -a -e powerpc* sleep 10

perf script -s ./powerpc-hcalls.py -i ./perf.data -- --sort=max

SORT KEY = max
hcall                            count   min(ns)   max(ns)   avg(ns)

H_SEND_LOGICAL_LAN                  47      7380     40148      8739
H_VIO_SIGNAL                       706       880     17454      1911
H_RANDOM                             1     15176     15176     15176
H_PUT_TCE_INDIRECT                   4      3032     10444      4956
H_ADD_LOGICAL_LAN_BUFFER           363      1250      8716      1534
H_SEND_CRQ                           8      2086      6846      3044
H_PUT_TCE                            9      1284      4932      2646
H_STUFF_TCE                         13      1620      3962      2358

This makes it easier to identify frequently occurring
or high-latency hypercalls depending on the analysis
being performed.

Signed-off-by: Shivani Nittor <shivani@linux.ibm.com>
---
 tools/perf/scripts/python/powerpc-hcalls.py | 35 ++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/powerpc-hcalls.py b/tools/perf/scripts/python/powerpc-hcalls.py
index 8b78dc790adb..df7b83ab0b6e 100644
--- a/tools/perf/scripts/python/powerpc-hcalls.py
+++ b/tools/perf/scripts/python/powerpc-hcalls.py
@@ -25,6 +25,7 @@ from Util import *
 #	} ...
 # }
 output = {}
+sort_key = 'count'
 
 # d_enter: {
 #	cpu: {
@@ -158,10 +159,42 @@ def hcall_table_lookup(opcode):
 
 print_ptrn = '%-28s%10s%10s%10s%10s'
 
+def sort_output(opcode):
+	stats = output[opcode]
+
+	if sort_key == 'min':
+		return stats['min']
+	if sort_key == 'max':
+		return stats['max']
+	if sort_key == 'avg':
+		return stats['time'] // stats['cnt']
+
+	return stats['cnt']
+
+def trace_begin():
+    global sort_key
+
+    i = 1
+    while i < len(sys.argv):
+        arg = sys.argv[i]
+
+        if arg == '-s' or arg == '--sort':
+            sort_key = sys.argv[i + 1]
+            i += 2
+            continue
+
+        if arg.startswith('--sort='):
+            sort_key = arg.split('=', 1)[1]
+
+        i += 1
+
+    print("SORT KEY =", sort_key)
+
 def trace_end():
 	print(print_ptrn % ('hcall', 'count', 'min(ns)', 'max(ns)', 'avg(ns)'))
 	print('-' * 68)
-	for opcode in output:
+	for opcode in sorted(output, key = sort_output,
+                            reverse=True):
 		h_name = hcall_table_lookup(opcode)
 		time = output[opcode]['time']
 		cnt = output[opcode]['cnt']
-- 
2.53.0

