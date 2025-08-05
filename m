Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6840B23F40C;
	Tue,  5 Aug 2025 12:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754395918; cv=none; b=leYAvmBma/IiCFc2syKEMk6nW3Nw6fLspdrdmqUckyuMb9OvCqyEnY7gkxSJF2mh1f8dh2/2sJV6CdT91GfuaSW6HpCpa3Wfclo7bV1Khsj6rP3rQ/5sknXa6ZjIb6LQPMZZTJ+v4cqZRnkp4DeXWBjYhApw71RUGVTRlXSG6DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754395918; c=relaxed/simple;
	bh=0oDVDBQc6FPyUkh0LwIGXFxrP6HB7Zxj+MYYUU41S7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dIoPanCjwSLGq3GVIr9Z0ASCboLZOeGkEI4wblJHqL6edaIRqw+xPc7X8myGeysTxSIRj/DLNhUvrB+1TZq/FW1rANKOPB/lONJ/JAiffDw1NO/59DDpXBNmZzCtB1PlLPx407skS7W20tolDGs2ApjAe95TSvX3uaBmNypRsBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s1nW3ICo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s1nW3ICo"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575AnqSM029445;
	Tue, 5 Aug 2025 12:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=/kohu+v1FOAz4DkmPdu08m4lsClpQS2Dv4JC55CyY
	AM=; b=s1nW3ICoE6nw48+1HAWfodM0yYR8M6ZSBnIJtOYuJqQpd9zeTtJ8Yw7AT
	LQsMxIyOfektWVnCdBWTC+HEnIAwL9K6TqNKey1LlP/MNkESkI1XMP7mHpuSIG7p
	k5eqwUUZRHxi5vUgASvaagCQ58mWzAm3JnAaU8a3x2PHjGH1+x49vEkRBlMxZNKf
	RBlHz+1UPdx9LpmzGvoJScWDHJSUR7BOEMyi900HGLvrkMQWIdfHvZOysR/WpGym
	7k2UMym6yEqW0u56vzPC1ujdJeCop1BZKKDrC3JhaQDP0yu4DJUO6FGaW7Mhtdfp
	ypsdVd2YaqXvuNT1ICQK4AFgx7GHA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 489ac0x8e1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 12:11:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 575AYAS6004450;
	Tue, 5 Aug 2025 12:11:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 489yq2j1v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 12:11:53 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 575CBnuW15532312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Aug 2025 12:11:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C5CD2004B;
	Tue,  5 Aug 2025 12:11:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF2E620040;
	Tue,  5 Aug 2025 12:11:48 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.87.141.116])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Aug 2025 12:11:48 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] perf build: Allow using compiler wrappers with CLANG
Date: Tue,  5 Aug 2025 14:09:34 +0200
Message-ID: <20250805121143.1224807-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QLWhg2QJPhkya_LMW8ImXwhHfdlNp570
X-Proofpoint-ORIG-GUID: QLWhg2QJPhkya_LMW8ImXwhHfdlNp570
X-Authority-Analysis: v=2.4 cv=GNoIEvNK c=1 sm=1 tr=0 ts=6891f50a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=uRFscEWZ48GPqj20UDoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA4NiBTYWx0ZWRfXy7PBNkTOLGmh
 TrmcZ986RVQrUe7xavXUJ8X6cGgnzUNiaPjAjP6Eg7Wgv/fgchqpZcMH87Br+LVWogSGT0rPY75
 oOdUchdk/R5VPJ+y8r9TkAg9EtvpWXE/Wv8DRAcXbkcSxNf+fJYnVKgkklvciRkrE8ZSKH4C4LT
 711+0cZnfxyOnFsAIbIuxYVFDAakgaoumZiA+b2wSVYy6YjLkAv+xhN4ikdWKTzDtyELb4JLf9B
 QLNGTZxgt1DpH5DGU5napoa9vJYK6iDTxOt0TkNNNsOw5VLRQxXj1mqQj/1uar9LdN4LLId9CPU
 hfnJT1OdMAkCRVcBQKbyOY4dP++9jo6BGXsiVYHWDRHjAhOxYTdBRPVRxwzyZbRytM901QAXgqP
 N9HxQSd41QblD1W2cE5bkl59rkdmT+9S69WzCCeiME/GgBNAUwn+WuYwfQ84yOw8rj8mB5QQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508050086

It is useful to specify CLANG="ccache clang" in order to speed up
builds. Unfortunately perf's compiler detection logic does not like
this:

    Makefile.config:704: Warning: Disabled BPF skeletons as clang (ccache clang) is missing

We don't need to know the full path to $(CLANG), so using
get-executable is not necessary. Fix by trying to run
`$(CLANG) --version` instead.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 5a5832ee7b53..4bc11db5aa4d 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -700,7 +700,7 @@ ifeq ($(BUILD_BPF_SKEL),1)
   else ifeq ($(filter -DHAVE_LIBBPF_SUPPORT, $(CFLAGS)),)
     $(warning Warning: Disabled BPF skeletons as libbpf is required)
     BUILD_BPF_SKEL := 0
-  else ifeq ($(call get-executable,$(CLANG)),)
+  else ifneq ($(shell $(CLANG) --version >/dev/null 2>&1; echo $$?),0)
     $(warning Warning: Disabled BPF skeletons as clang ($(CLANG)) is missing)
     BUILD_BPF_SKEL := 0
   else
-- 
2.50.1

