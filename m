Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29AB48CFC;
	Mon,  8 Jun 2026 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931751; cv=none; b=BCapIVluQuUkjWY3IdbsKvk4Ku74KFnZaQ5lAt/afsFzoJ6D3nbnvO0Hov49n84LCGOi+XVYSRJvKB5Hz5uzYuOpKn0D7LsCykJSaajjy336N77XXiL9uckDcF1/vHTMlyQdRAHuUmLbMTT+T0Eiejl8SMgmx1kqvEjG2zt09RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931751; c=relaxed/simple;
	bh=sIUlmBkpVrsWNyJr+xouFtTz4tdHHoYoAOBNiQOWoMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZRnGckCBeU1+GZnPbut/0WND6tV9KfCTW9LnVAafYwJmBeu5Ir4yiq9H4lnygl2SksnEXmXWFPiAYMuArMZ0MH10fJytd/Ih0hhj3c/Dbje4b6aaFxz0fKfBWob+uhaXkiMyJi6L885LkREFtnVPoD3h3TmQX2KHKgkQMQ/RvJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M1hayfGJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M1hayfGJ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6589kjlf3546333;
	Mon, 8 Jun 2026 15:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=bRfodzbgf/Z/E8Wv/IEchHHTMN8q1ZSQv4uxWNWnW
	8E=; b=M1hayfGJj0Of6HJYq1rpWSQXbQutTO6h27MTAt9fQeu/LkHJe8D/U5PD6
	XxsHCIwzcFTKj1lJHgtXla+ld/KB4OBwueUAAVniYVmBN87w6qARhYyc7blLWgqs
	RVMF+cUwY0fe2MQUAkIg5eWvpqyFCgsd4FtjDTUzRyBHGaA4L+JFQsbIL26Nz29N
	X7B1gE4Y4S5XJ9vVs0DdcuhThIWeBwLucOw5PA2t9fLbtzYDvtAxC726kj7K0IoJ
	VfMnIo4FNX9ILrL5OGcpRS7tp8KwejNk/m82EWJ/Euhx2XQvW19BSyL/n13BH63R
	xYFg3qiOA6fO1buXlVahfX1buQ+dw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ydyx46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 15:15:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658F4a15001966;
	Mon, 8 Jun 2026 15:15:31 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03fwnyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 15:15:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658FFRx521954946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 15:15:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 628EC20043;
	Mon,  8 Jun 2026 15:15:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33C4420040;
	Mon,  8 Jun 2026 15:15:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jun 2026 15:15:27 +0000 (GMT)
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
Subject: [PATCH] perf build: Respect V=1 for Python extension builds
Date: Mon,  8 Jun 2026 17:15:25 +0200
Message-ID: <20260608151525.2358438-1-jremus@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE0NCBTYWx0ZWRfXymDprVsIGkZt
 a3t7Uotp3VSheDMlsIIZU1y+9AptAY36t2VqE5UKmL08XVdNWBfgLcZSqWhrp3CdHwPosUIjuT6
 uifkxFKUbmMG8/zJjrfc5dTzz2Ypp5wm5cShn3tT0RTvHDiRzhBhw5B8L6bq8TSSHM3IWZyWJsS
 2krGz2hDyFOUHH3XDx6JM3Jz5uo8AhAp00AhybpURUybHvV2tdDcZFmWqSAlLd7dTpKNLLowZYe
 IvA5UEXK7AG57oJzqa5Rahn3085gpi/aK76ufWPEXKt+Ym6BiblVfudhuFiRWQYUMgj+FYY6oyA
 gMIEpGU2ic4m32ZyscU1XFKElw9cNJLFcmT7+YT6uCPi8S2qiURK3nSJN6HNyYmWqx0NYXyJ8Fi
 EnyOS6MdlWVm8C5Rd5kLy6Hbjnt5fefxpObpf059+XUxB6htF1DjlywBWAep/gZn5MEd01Gkjp7
 j5v2VNUbXI/Fh3Z6dvw==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a26dc95 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=pQLAS0GI1xQXXxtTi7cA:9
X-Proofpoint-GUID: zNKM3vW-v_NzJVpRUtBH5ZUzmkrevtt6
X-Proofpoint-ORIG-GUID: zEzAAA7aL1fbbHZ0ydQNzV1rcD7RgUU6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080144

Make util/setup.py respect the verbose build flag (V=1) by conditionally
passing --quiet only when not in verbose mode.

This eases debugging of Python extension compilation issues and aligns
with the existing perf build system behavior.

Tested-by: Jan Polensky <japo@linux.ibm.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    This patch applies on top of tip:perf/core:
    
      git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  perf/core

 tools/perf/Makefile.perf | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index cee19c923c06..c5a338ada6f1 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -402,6 +402,10 @@ export PYTHON_EXTBUILD_LIB PYTHON_EXTBUILD_TMP
 
 python-clean := $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD) $(OUTPUT)python/perf*.so
 
+ifneq ($(quiet),)
+setup_quiet=--quiet
+endif
+
 # Use the detected configuration
 -include $(OUTPUT).config-detected
 
@@ -747,7 +751,7 @@ $(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): util/python.c util/setup.py $(PE
 	$(QUIET_GEN)LDSHARED="$(CC) -pthread -shared" \
         CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS) $(LIBS_PY)' \
 	  $(PYTHON_WORD) util/setup.py \
-	  --quiet build_ext; \
+	  $(setup_quiet) build_ext; \
 	cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/
 
 python_perf_target:
@@ -1152,7 +1156,7 @@ install-bin: install-tools install-tests
 install: install-bin try-install-man
 
 install-python_ext:
-	$(PYTHON_WORD) util/setup.py --quiet install --root='/$(DESTDIR_SQ)'
+	$(PYTHON_WORD) util/setup.py $(setup_quiet) install --root='/$(DESTDIR_SQ)'
 
 # 'make install-doc' should call 'make -C Documentation install'
 $(INSTALL_DOC_TARGETS):
-- 
2.53.0

