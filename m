Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9047D33FE39;
	Wed,  5 Nov 2025 19:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762370205; cv=none; b=VLGamY8ed98/tFV+GwZKJ8b6m5zEB8s8XwvZMeISRavdThVeGMn5t6iYKSt1XnGsS2B1iGlQRANKHtjs11p8YkTYYxw/FHyiebLeJtdYySo/VAoMPvOJ5n93xJoZY/XfLH9ZbV2EjMoXBGj45jihoxR526PrAvT8y6fhCkjTYLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762370205; c=relaxed/simple;
	bh=CVnuPNeI2KxsnGTMc+rTKU5SJQwtdJOppjAzw/UjhvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbQ3Oi/LO4L7LIOkp9IuSiSVP6ZCbeywXnH3MYGNIykgJ3sRQMqASOuPKVofl/+7Mv0sXbVp18DqOOakD5r4Pg5nZ64PyczUzoRrF/3rhB2ALMTTuUER7Llg6moOknfvaRZoVE7SPgGNBpn2Sx5TgOYRopt5TnTrZDbwPALHF8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kCN9ZCrd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kCN9ZCrd"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5IYW1F002663;
	Wed, 5 Nov 2025 19:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cudy57Kz+/xsCe4vk
	vDXHBNWEy1XnPcnS0mHwL/7slk=; b=kCN9ZCrd4lGpP8fO25UyadPeVgx25VzOn
	bWFtus3AAnQq/xxBOdEsZq/F5YYJIxQl/i6VokNHsWDMSVvCeB38/s86woFYKJYH
	qz2O0Upk9yfxVDmRvTu7QqpyruqhJKkANmgaNPbEG1ejt2TJbHMh7r2ZiDaLRCmQ
	rjAyBwF22aOb+tS4C/i86BjUOCcCPjmI8e+1i7XMo9MCCwpxEVERJSxjabiEvmHu
	iSfX2d7ljmkaZo/7EVkFxBCRBa5tmAORHogT5ht1WK5ySJoUC52YaGyNBP2S+Fl4
	nS9GIOmyiDkimx9yOq9Ki7MNIUgGL/1pTMIEpIF/W5jKjE+qdSH0A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a57mraxhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 19:16:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5IWpvJ027416;
	Wed, 5 Nov 2025 19:16:39 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5vwyhxdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 19:16:39 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A5JGZHu23134926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Nov 2025 19:16:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7945920043;
	Wed,  5 Nov 2025 19:16:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F325720040;
	Wed,  5 Nov 2025 19:16:34 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.87.135.254])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Nov 2025 19:16:34 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 4/5] perf test java symbol: Fix a false negative in symbol regex
Date: Wed,  5 Nov 2025 20:10:27 +0100
Message-ID: <20251105191626.34998-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251105191626.34998-1-iii@linux.ibm.com>
References: <20251105191626.34998-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Xo7ivwsg7DKxB7QieEb-qDgVk3tx50ij
X-Authority-Analysis: v=2.4 cv=MKhtWcZl c=1 sm=1 tr=0 ts=690ba298 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=Tfjndf6In5KXQWtPGGIA:9
X-Proofpoint-ORIG-GUID: Xo7ivwsg7DKxB7QieEb-qDgVk3tx50ij
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAwMSBTYWx0ZWRfXzXfeARG1L11I
 aqvfq8j9e1HoF0SjYcEKF2LOPq6O03hYEXibMC7WEU7PochIhyX8s+dSi23OlSJ65/v/oI9ssUI
 0neqMrPDdmsZBLcVYFYfW0pPuyH3/rrXD4hT2Yct3YV9/kERgZ2H3g8b2H0PJZ8Y4XyTRxuCTRK
 0NyA3KEFM/6peWE2CuQT0nzJZyakPxAsIcOcLViD3C8sgEV/bypYtpUYPgyCQpfKcJFRuYki2gk
 Ww87pTIK5QFlhi+EtnGkzxi5pmH4nKRzcKbENRC7pgNAUcCIQw+W7IEKJwU5Hzlzs20G+Ou6Mzx
 rZdbPNSS0wCGc5hk2pDIGlLVx54u1b3fOLmb0+J7wQdpefe3mBCTgn6oXIwdVKvzuWrYZPvEsLj
 R1+3cyTE1/V5A6QirSe0C5u/cBKo1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_07,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010001

There are a lot of symbols like InterpreterRuntime::resolve_get_put()
in the perf report output, so the existing regex unfortunately always
matches something. Replace it with a more precise one.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/perf/tests/shell/test_java_symbol.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/test_java_symbol.sh b/tools/perf/tests/shell/test_java_symbol.sh
index f36c9321568c5..4c6bc57b87181 100755
--- a/tools/perf/tests/shell/test_java_symbol.sh
+++ b/tools/perf/tests/shell/test_java_symbol.sh
@@ -55,8 +55,10 @@ fi
 # Below is an example of the instruction samples reporting:
 #   8.18%  jshell           jitted-50116-29.so    [.] Interpreter
 #   0.75%  Thread-1         jitted-83602-1670.so  [.] jdk.internal.jimage.BasicImageReader.getString(int)
+# Look for them, while avoiding false positives from lines like this:
+#   0.03%  jshell           libjvm.so             [.] InterpreterRuntime::resolve_get_put(JavaThread*, Bytecodes::Code)
 perf report --stdio -i "$PERF_INJ_DATA" 2>&1 |
-	grep -E " +[0-9]+\.[0-9]+% .* (Interpreter|jdk\.internal).*" >/dev/null 2>&1
+	grep ' jshell .* jitted-.*\.so .* \(Interpreter$\|jdk\.internal\)' &>/dev/null
 
 if [ $? -ne 0 ]; then
 	echo "Fail to find java symbols"
-- 
2.51.1

