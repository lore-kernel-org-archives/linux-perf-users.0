Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8828438FEA
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Jun 2026 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707251; cv=none; b=lQYvMT2SuRa5vb+0tDNJ6Xe8COBQAdzvdy9j8yHXesh9CWC9mTaYnrDT3uJtQ02gTQDRC1JaLDbG7XS0vM27GLuRpMnwOJ51wuBhaK1Pp9C94ObJPlTky7LHa9JoNV5OKQemxcB+N3xoJXEsG1jK2xjNjj5WfG+kuAS2hMaRwOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707251; c=relaxed/simple;
	bh=dX2/CMSEEM+zQi0NU9GX9uuErcJ8awlB2cu5W/vIo+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c2+mLRKUZQjY2G3e6KDSF/bBUYprukjx1c1FxIbHjAC8FQ9WVTTYGu1iehgVieTHkY5jVincPzT/rl0EtHCEf17rT5CsPL/UmXRqp/UedpX0phInY50n+FuA+yw1dj+8E7sOIe3KRIt3QoYaMEpwYkdBgsFcOJCx4DMTjVpNn5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g2hNqRw9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g2hNqRw9"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HEINDx789654;
	Wed, 17 Jun 2026 14:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=HeGPIPeqtVpN0fN3nQP6DcjhjIUixOgxFktO4XZ/R
	3g=; b=g2hNqRw9gwWwyq1MJ0RgQCzMfa4UIhsKzQy7YnY6GsbeV+yz0C652Na2a
	Q5et/HToPNSJRYmNuK3JpNhmKAgRmOJphXB+yJtM+NIW26oI0U0M0nrVd33A6CNN
	i0zXIGbMicEijuRWslzirf09jEyVLLxZsbeASV6Sjtju5hV42ckhgn45fvyOCoFG
	a2HA0S8arhxhKHv4ZfX5pz/nuywEkFs5K0oEznAqrDkPr+mR33iePKaUxxvzM8q5
	SG4CSzHvDEESyHckaqrOl+5t9RcdmbEWoVNET3+TdbXKl697dUb3y5Cfg4pwbu23
	eumfsFU3By6TPiWm0oCam8yXtAutw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4euequ3ebp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 14:40:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65HEYkdE006778;
	Wed, 17 Jun 2026 14:40:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eudvakjxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 14:40:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65HEeX0S29688322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jun 2026 14:40:33 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A98BB2004D;
	Wed, 17 Jun 2026 14:40:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD11F2004B;
	Wed, 17 Jun 2026 14:40:28 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.124.217.32])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Jun 2026 14:40:28 +0000 (GMT)
From: Shivani Nittor <shivani@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
        irogers@google.com, namhyung@kernel.org, ravi.bangoria@amd.com
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, shivani@linux.ibm.com
Subject: [PATCH v2] perf scripts: Add configurable sorting option to powerpc-hcalls
Date: Wed, 17 Jun 2026 20:10:11 +0530
Message-ID: <20260617144011.17359-1-shivani@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDEzNyBTYWx0ZWRfX8mqXrcn+xVlX
 mDyrV79td9T3GyN7NmVU3boTUQaG3DRgvQJMT3wGIR9hrM0XWQ5HXUK4n6zKEP2AkA+Pe5aYIPY
 mUOhrxpfLfKXlHxF9e3PcbMLfak5v2c=
X-Proofpoint-ORIG-GUID: CsdKZnBiWlh0GdDXAtR9unc9M08tvnD4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDEzNyBTYWx0ZWRfX9vU97JB0Lmfg
 ccjt1eNm/UdJyBvborTId974ZT/RJ7QT0oqexd37yBoQdBoNFVsUhVt2CkTNbG2+TpZ0NQw4lNO
 aq9/WSiyaQeXnmli4yA8tWjmkcWK0JNlwp4Jve73EMjqrqGcxLK9y36RnJaf2ECOC8VHmvJZDQC
 cM+c5mlMFICz384wVrlTJ7997cGqKn8v+E45IL5w7mas2iBRMxi8ODdz3lmZicQ82kXntOfGlqk
 hqE0tGpd5cFcpx9tgKFrXQwM9a/1zoXy3GKmwWkZXt7bSlDrlx3/dKCkeVDwyFLJMNUsZp+PV3k
 NrSsuy4Z68pC3yp6AoZZiYu6toyuLJtT9wz+FF1VtlL5IBq5ibl2GawRWZBpp8zAjFqK3FTRh2p
 Kx5grY/nkAcbVIQNKVqLh1d/VsuzU5iSjVFeLQXON3BOf4XuQqctZIkBM10NxfMp2cR+32yYrj2
 DJBQ6b4nqYpZSxCouHQ==
X-Proofpoint-GUID: cx2724GWrKo4EEIWI7BngnO4Z8JjSwAu
X-Authority-Analysis: v=2.4 cv=L9gtheT8 c=1 sm=1 tr=0 ts=6a32b1e7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=-UTqftxNVshRFOYItwsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170137

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
Changelog:
v1 -> v2
- Add bounds check for --sort argument handling
- Prevent IndexError when sort key is omitted

---
tools/perf/scripts/python/powerpc-hcalls.py | 38 ++++++++++++++++++++-
1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/powerpc-hcalls.py b/tools/perf/scripts/python/powerpc-hcalls.py
index 8b78dc790adb..e5b0c1bee65f 100644
--- a/tools/perf/scripts/python/powerpc-hcalls.py
+++ b/tools/perf/scripts/python/powerpc-hcalls.py
@@ -25,6 +25,7 @@ from Util import *
 #	} ...
 # }
 output = {}
+sort_key = 'count'
 
 # d_enter: {
 #	cpu: {
@@ -158,10 +159,45 @@ def hcall_table_lookup(opcode):
 
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
+            if i + 1 >= len(sys.argv):
+                print("Error: -s/--sort requires a sort key argument")
+                sys.exit(1)
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
2.54.0

