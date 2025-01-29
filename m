Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F82418C31;
	Wed, 29 Jan 2025 07:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738134726; cv=none; b=bOGmo6DpNDgpm4Fbiz8nN8NrcRkkbhZ3eXhm5yIUHkkwnLlmWQovWnDN0X1BlZGtMh44zZ86STEXvtdJpQLl+Wy7YXJpGQqJzlv94Wv6N5KKpz9B/fIS3pjcQqesp51tANHkwSOdnt3+jIz0L/zL7+VBTpbmdm1YPIbngSPfFDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738134726; c=relaxed/simple;
	bh=Isr4jTT7bwvmT959kmjlYfMo90nR8YdxmUUil/eBxTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZ+eIavEFSPcqtiyoykQptzxL/pVt82zSzXIPkU/7owauc2f7l2hG01dw8tvu884bTT+lBKtrIy3cWmaZabgDcyRMJZHStR4xcQBKJDzJ74PBu6QJoHO0QrIiePXenN6seLkyfTkYNS6fl8aoTJAhiD81JWUT6uT7cWUb45r6VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U2Cwfwzv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U2Cwfwzv"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T20gTh028578;
	Wed, 29 Jan 2025 07:11:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Xi1/T0Wfi56TIZuwN
	1NOgCWJsHIedAaMpTRxVEZ3o5Q=; b=U2CwfwzvEGY2qGjVIljXwWoWls+AtkiYU
	PJ1WExDP2bl/Bm3ZrqpADAADFixl0+IENVcu0a2iVkibC9ZPToyax+6KevnkF9bj
	hD1RGekPnwVkzci0TefujY62RemifBYEMHGFr6H6p6vh7wfaj18KC5nXRu55o5bG
	GoYvjvXXf60o0o3t2WuNMwN+GXmYpSv/Tcqusa33sfKtDGJnwcllsvH6qlvgI6rh
	sb58dDB5O8lBLaDYiEoWb4zv7ga8cC7r/7h2bmMNP9LbHKCyCNKNtPqyX1zpKGZA
	dAQolnec/Nt4fUHAh/qZeeVRBFXee2z3FN4a+9zLARdFggNoyi87A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44fb608vge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 07:11:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50T72Ek4018889;
	Wed, 29 Jan 2025 07:11:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44dd01f1hf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 07:11:54 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50T7BoGk56099122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 07:11:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1C9F200D1;
	Wed, 29 Jan 2025 07:11:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A735200D0;
	Wed, 29 Jan 2025 07:11:50 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jan 2025 07:11:50 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 2/2 v2] perf test: Skip perf test 114 perf record test subtest test_leader_sampling for s390
Date: Wed, 29 Jan 2025 08:11:34 +0100
Message-ID: <20250129071134.4024430-2-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250129071134.4024430-1-tmricht@linux.ibm.com>
References: <20250129071134.4024430-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jDLP5Phj1lt8b-Mc-Qj5FCRn65k9bWOG
X-Proofpoint-ORIG-GUID: jDLP5Phj1lt8b-Mc-Qj5FCRn65k9bWOG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=986
 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290056

On s390 the event instructions can not be used for recording.
This event is only supported by perf stat.

Omit subtest test_leader_sampling on s390.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/shell/record.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 957ee10aff44..9e645eb09d9e 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -307,7 +307,8 @@ test_system_wide
 test_workload
 test_branch_counter
 test_cgroup
-test_leader_sampling
+# On s390 event instructions can not be used for recording
+[ $(uname -m) != s390x ] && test_leader_sampling
 test_topdown_leader_sampling
 test_precise_max
 
-- 
2.48.1

