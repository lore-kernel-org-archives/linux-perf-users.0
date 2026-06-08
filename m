Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E161D32FA14;
	Mon,  8 Jun 2026 16:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934795; cv=none; b=pLNABc4RcnRRl9ROup7icYIN/kxyRrT1L5fkc/nS/dnarn9eiX/23hsmBiBHKFkHJdMsho9xizxv1HhHeSdmGQJP3fowBXkFlHQZBGg+gTpvymCBWCYsV0a/AvjzGJDJ2KZM43Emvkv/y8UWqWcvuo4ge8b6B7jpB22o5R+SQyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934795; c=relaxed/simple;
	bh=YcHYg4zAoofWCpRI0NBG/apJqcBsFavETOTZqimHbgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eXl+qcWMH9LpY8yUhFURmkLNxXiO0y/jU6q5/omgeKlPikw8vtqMjDtx6U/GvN7I58P9ssfKA00K3mXJDHditKmI6hNBSBqJBSk7hX1qj1w/MTRv+2JLO0aHl8tVsinwIKmjtUZmOYKN5R4ikM8JQBOO+WZjNRN93dTd7XMnHOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lsKVfucL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lsKVfucL"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6587tHxL1029990;
	Mon, 8 Jun 2026 16:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=8VNf37BXIxR05bVfsRYLWcleg2ddVTa/RaOlby/oz
	wE=; b=lsKVfucLt1GkG3Lsh/mlJRGpozjBrBDJqN5DtA0ZuuD16JjXW1rdEABWR
	Ealo26zvVH7nh4gHzeAmExjgn7IodT+/+Ep3utVCKrLBrumEVF0K68QpmrLeUwfO
	D+NSuJfggS6IVnLZiXgGsVUmcghRLN6XN60XuBhWaUKkq4DjUnnKuCU5kLLwxHUk
	M6f5ZZ0pYwFu9bIKrCKp7PmVjux8wH3l8ElTQmu+5eHk3S9oGbqCgFaq9CFp/zYF
	EwyPfnoBSV5eT2FA8b/rwU35XBOqEKIfuA/h5tL+WUOvmbsXmKb0cFQihjqWvGvB
	PK1tsh14JaghKbvPFr1iBewtw5WcQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb9584u4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 16:06:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658FnqJw021611;
	Mon, 8 Jun 2026 16:06:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvpx7mq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 16:06:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658G6FF550332154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 16:06:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B1B120043;
	Mon,  8 Jun 2026 16:06:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 314DE20040;
	Mon,  8 Jun 2026 16:06:15 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jun 2026 16:06:15 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Jens Remus <jremus@linux.ibm.com>, Jan Polensky <japo@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH v2] perf build: Respect V=1 for Python extension builds
Date: Mon,  8 Jun 2026 18:06:13 +0200
Message-ID: <20260608160613.3153795-1-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a26e87c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=C_PVQYQ-2070qOwDPPgA:9
X-Proofpoint-ORIG-GUID: Emb7_YLrIvhYALR2QMC10hxPa0lsUwhQ
X-Proofpoint-GUID: -mAtHJv5qnOAcBf2g577zPmL0vZCle6r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE1MyBTYWx0ZWRfXxcJx5Axv/aDY
 Zb2/PXJbkoNwojHWm8hNgwAMFy4OvTjAL0QIM6Mf8a42oKK69MNaV04K8Gkm3yPf+f4RYh8COtY
 mUpXqnjZKXB4JwmW50049B+moH6jfMP3FcQjl5DV9leH6MTi2iYX9DYfiZQVDQzi5wWhcGxBZ7H
 frZI/K620ABfRg10784s8IRLBtP8RpYrJELbH/qEEnQZ4s+H7Jxs/Lk0I61pKs2j/HDsV7QVFTh
 OPeO39zKHv2VP+DKLaPwOmVJNx4EoD3j+nklMlNnfGy6wX3KjuNPl+8jDizwJa7KVU949AEsrGW
 BgPFY6wfhYD0t7JJ3x4qYsAN3Y2bj5zl+1eyhgDWnWqZ42OuNK/z25tZSwvh6b89+0GM55HCeSg
 1Dl5pxM7HHjd+wed6oWORqbINnXHdwqyOlej+YRzxPgX2e0gLbTmX0c6ROJO5QHfqcZpOTndDQ/
 gtjp6zUJF//2oLF2nEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080153

Make util/setup.py respect the verbose build flag (V=1) by conditionally
passing --quiet only when not in verbose mode.

This eases debugging of Python extension compilation issues and aligns
with the existing perf build system behavior.

Tested-by: Jan Polensky <japo@linux.ibm.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    This patch applies on top of the perf-tools-next tree:
    
      git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git  master
    
    Changes in v2:
    - Rebase on perf-tools-next tree. (Ian)
    - Use descriptive variable name python_setup_quiet. (Ian)

 tools/perf/Makefile.perf | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 76b35ac19acb..137fc4386625 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -401,6 +401,10 @@ export PYTHON_EXTBUILD_LIB PYTHON_EXTBUILD_TMP
 
 python-clean := $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD) $(OUTPUT)python/perf*.so
 
+ifneq ($(quiet),)
+python_setup_quiet=--quiet
+endif
+
 # Use the detected configuration
 -include $(OUTPUT).config-detected
 
@@ -752,7 +756,7 @@ $(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): util/python.c util/setup.py $(PE
 	$(QUIET_GEN)LDSHARED="$(CC) -pthread -shared" \
         CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS) $(LIBS_PY)' \
 	  $(PYTHON_WORD) util/setup.py \
-	  --quiet build_ext; \
+	  $(python_setup_quiet) build_ext; \
 	cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/
 
 python_perf_target:
@@ -1158,7 +1162,7 @@ install-bin: install-tools install-tests
 install: install-bin try-install-man
 
 install-python_ext:
-	$(PYTHON_WORD) util/setup.py --quiet install --root='/$(DESTDIR_SQ)'
+	$(PYTHON_WORD) util/setup.py $(python_setup_quiet) install --root='/$(DESTDIR_SQ)'
 
 # 'make install-doc' should call 'make -C Documentation install'
 $(INSTALL_DOC_TARGETS):
-- 
2.53.0

