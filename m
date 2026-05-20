Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69C63E275F;
	Wed, 20 May 2026 12:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779281838; cv=none; b=LN7W40b5TeCw9vDMgbyubcWApNDISXUpF3A3TbylaQjRFh1cML9loswbLpkIT0Yu/Kz95Za5nfkOB09g7V/px4xz5eXzZFMwnFqwZD6v8ad7ClTj3CwT6Jx5S6mJKNGcHmnjiDhazybzvTkG7I7k2btmqICQQroPvYaxMtmKQKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779281838; c=relaxed/simple;
	bh=tRcXdh4KlP6nur+ndfrHB76TXeuEEvedvf+Ef9QwBJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kC1L0b67mnIM87d7QJF+mzUpEysjBwmAKyljRjEmVyq3AkGsP6ku2CCGsAP0f50oD6QKRp/Hihcs7yV5wlD2KTNQc2VVQ9NdgA6KJNFts6jfGWfD/0BtniJW+O8tepSfd028rBPDv7IcbylsEOaihyR64nWNDq4S3PYtTtEr6ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IpVLpw+5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IpVLpw+5"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K5ItcE271835;
	Wed, 20 May 2026 12:56:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=oZDWSFTwZMq5+xqXGz4ywKE55za8Ur32lcEqkICOW
	wI=; b=IpVLpw+5rgRtano782WPmf5hD3MQy32U0L1UCHC40xSHNzJXLzsWnSC/o
	FU4KXxCRJn0gcc3lYjMk+m4XoS8qDPiOKIwT22a9OiOzeLNk3/mZNbK9D/XD26bX
	djmbhzjS2GXTBHRSetD9rKpCIU1w6f1pAeXsLr+YkUbR9tko84DzZTTkx9/AlO4A
	Ox9AQog1oUZwd2jMaBXVSoFuUO6lA/5ziGllXRVKlTXFAthyz4f+AXq9rVLhv5XD
	smvi0cClzKsLGmJRftLmfxNovbEp0FPJAhkJcYkaryaJogxKDsvld8tYlSiLIz/8
	/n8/JNJk1Uhj+1hyZr3S5oY+NYjbQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h752336-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 12:56:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KCdOqA028150;
	Wed, 20 May 2026 12:56:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75ky73vv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 12:56:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KCud4P50528746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 12:56:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 850432004B;
	Wed, 20 May 2026 12:56:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4903520043;
	Wed, 20 May 2026 12:56:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 12:56:39 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
        tmricht@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] perf build: Fix Python extension build with GCC 16 hardening
Date: Wed, 20 May 2026 14:56:37 +0200
Message-ID: <20260520125637.105681-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0daf8c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=m2xt6vH2UB2CAm34afMA:9
X-Proofpoint-ORIG-GUID: 33qOUNenD4asW3gO7f4pYa_KR0e1EoS5
X-Proofpoint-GUID: 3mTvReuXuIiSmUeiSsNZFUNkrduh6EBa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEyMiBTYWx0ZWRfX1UYxaCkkgKrk
 aoRS6QbY2oIhLPJrF0QOSoIpNm/8a0jTizSnnBiF5LtMqkcFFkNNSkZ8HDA6MHD/yl/fexwJr0/
 awy4Q++3KklGizlzoofT5g790Ay/T3iklZtM84S5USRUZ6by1JXDsGKIemJhpiqcfyMmHx2o1Pi
 8f47gl5x8gCDHjENcaUYQhTZ5PUvaBw03I/t7OtFmxa+YVAVdaOCCBHOB7sJJ2UUCFjsBRc5B5G
 q352AE9+ZnwuA00hgwtB3Hkn9VLjgzinDhaXrMm08iOosS/8oC4PAi0LlTyyDdIFjgl+T2uNtxZ
 xUmLdpjy5ijg0N4B55JRe3lfAHxNQB9uRms72BKYIzpPXR3EN3o4CFDHlIjHpuc5GFMLjdDRvxa
 mpV1U2GFFAOMlgxP7mzmWiDHqOIn12JOdyt/0jkC+omFSGkFPLQ2x5ADlhNzeIoDfD9aXeSIF9i
 LO9r+TyH0uPXfQV0LCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200122

The Python extension build fails with modern GCC versions (16+) due to
the new hardening feature that prevents dynamic relocations in read-only
segments:

  /usr/bin/ld.bfd: error: read-only segment has dynamic relocations
  collect2: error: ld returned 1 exit status

This occurs when building the perf Python bindings because the linker
enforces stricter security policies by default.

Add -Wl,-z,notext to LDSHARED to explicitly allow text relocations in
the Python extension shared object. This is necessary for the Python
C extension to link successfully while maintaining compatibility with
the Python build system.

The flag only affects the Python extension build and does not impact
the security of the main perf binary or other components.

Tested on Fedora 44 with GCC 16.1.1 20260501 (Red Hat 16.1.1-1) and
Python 3.14.4 on s390x architecture.

Reported-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index bfb37f527241..12af424dd5c1 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -749,7 +749,7 @@ all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
 $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
 
 $(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): util/python.c util/setup.py $(PERFLIBS_PY)
-	$(QUIET_GEN)LDSHARED="$(CC) -pthread -shared" \
+	$(QUIET_GEN)LDSHARED="$(CC) -pthread -shared -Wl,-z,notext" \
         CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS) $(LIBS_PY)' \
 	  $(PYTHON_WORD) util/setup.py \
 	  --quiet build_ext; \
-- 
2.51.0

