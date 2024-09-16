Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9E3194138
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Sep 2024 13:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495145; cv=none; b=HcNyRHgnIKRS1W9xDtmFaS0a6+FI2iO3wOTaH6pmdjInP6evVf9cFXhmUr1jmYoA8NpiZFlJomPb/WwxpVQyOHX4jZ4hIikWH2yAsd+6t56JnCcnNNqKl23B2Ci+0PAC00fPsQtNEWLjUOt1dUHjc4KraerYtVnQYyE/pO+6+q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495145; c=relaxed/simple;
	bh=LpbrfoAMw8cIGP9OaIf+Z3dR5YKTR9A/lE/Ry4NDj4k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vb0+TBTCDKou+tTLJ0v1xN9ac6z6iVWGUQvnZp2f3xPEdhReLHVpyJYLYVtyZNtpKpl4qP/CcN9PiDcApObYmWc0PcBinKmPTCgVHwaanUZHkB4p0dPl0YL+wDViNgLc+ic2WKOIvnKrRQgDaJHrnc0s2YtacJgrrNO2NndxwHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UKTYoE/B; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UKTYoE/B"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cbbb1727eso37040345e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Sep 2024 06:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726495142; x=1727099942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHXcyBY1OfnYqyQEUkR+bbmX4p4XqE9ZVvOmdb+dg98=;
        b=UKTYoE/BR0G71Jd8TivJs8j5a/4xfnH/0UVAj4JNRcx75XtxGRHN/lCNnISbnDTOuz
         90+prIFL+NDH8G19mwMbJXWKHiXGddFzLhGVOGyDsQyhydY0ETsLppanCQX/9JUoKQXe
         uLBPCaVbDbrHv7/j/FX56SFUEyheHNVYZkDLnWUstGybZSRAJukGB5pGeVznmq2Vm+MN
         VMS2HPcwBtUbhKSn4X/86Ff+rpLejcndLcS11LmZsR3RUxyM+0QRzq6okOHlsFjgbI9e
         WqF5EztiZFQjaqLzDwZY/IhNPNkhio6sohUGLUH7h8VbjuZjPrSMFal2oDsmJKU5UN80
         6IPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726495142; x=1727099942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHXcyBY1OfnYqyQEUkR+bbmX4p4XqE9ZVvOmdb+dg98=;
        b=DZdRniLlCf0R/SrLjxr7dQY8V7oi8y5NHeP2Jxn7QQBs0I/cFijFov4RUfjC6uRV4/
         oeqhSWkLAs95KDDQxwKCw+ZqDzRr2vzLF4fSZbQHK1oiJZCCOnFNAbl02L9cjQ9UMNUo
         pd1Cfw87E5B1JpKzPEhoof3hCLA96hpGlb6JYjHdvm/Am3zXyT175a9/E9KRUMjyt1/q
         odxITBP+/GIsl1zfSfQv0jEOyjccOe63iLkeqfYj5sNh3EPNVacrsxIyl9TemaIb8y9N
         hsQATiR3JcTzSLLOXMW0IGeJquuZHCvQGmGimvdLxEjjdzzy5PUEy9qdCapANaDHANbb
         ZK0A==
X-Gm-Message-State: AOJu0Yy6ECVPV9msAK5ZPq+FrSx5nt9xPsPPB8grcQxbeySEtCi2FFEz
	+fc1vMKc2Pg8PzKi1CMQ6bfuW25VU/sCwMA++OGX9DD5mNZG63HlIJ9ZjwAxr7KBz0vdpfo8AeS
	YKeIvLA==
X-Google-Smtp-Source: AGHT+IFfOYzBBBIIYNJK+kjCt+IJF25ig0AQEKRujrUPMLsjU/dSM9qgZ9BqDjeZ87bsAcUXX6zC2g==
X-Received: by 2002:a05:600c:1d23:b0:428:eb6:2e73 with SMTP id 5b1f17b1804b1-42cdb58db62mr120870925e9.29.1726495141678;
        Mon, 16 Sep 2024 06:59:01 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f62dasm7285098f8f.49.2024.09.16.06.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 06:59:01 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	gankulkarni@os.amperecomputing.com,
	coresight@lists.linaro.org,
	leo.yan@arm.com,
	scclevenger@os.amperecomputing.com
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>,
	Ben Gainey <ben.gainey@arm.com>,
	Ruidong Tian <tianruidong@linux.alibaba.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 7/7] perf test: cs-etm: Test Coresight disassembly script
Date: Mon, 16 Sep 2024 14:57:38 +0100
Message-Id: <20240916135743.1490403-8-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916135743.1490403-1-james.clark@linaro.org>
References: <20240916135743.1490403-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Run a few samples through the disassembly script and check to see that
at least one branch instruction is printed.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../tests/shell/test_arm_coresight_disasm.sh  | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_arm_coresight_disasm.sh

diff --git a/tools/perf/tests/shell/test_arm_coresight_disasm.sh b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
new file mode 100755
index 000000000000..af63e3757cb0
--- /dev/null
+++ b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
@@ -0,0 +1,65 @@
+#!/bin/sh
+# Check Arm CoreSight disassembly script completes without errors
+# SPDX-License-Identifier: GPL-2.0
+
+# The disassembly script reconstructs ranges of instructions and gives these to objdump to
+# decode. objdump doesn't like ranges that go backwards, but these are a good indication
+# that decoding has gone wrong either in OpenCSD, Perf or in the range reconstruction in
+# the script. Test all 3 parts are working correctly by running the script.
+
+skip_if_no_cs_etm_event() {
+	perf list | grep -q 'cs_etm//' && return 0
+
+	# cs_etm event doesn't exist
+	return 2
+}
+
+skip_if_no_cs_etm_event || exit 2
+
+# Assume an error unless we reach the very end
+set -e
+glb_err=1
+
+perfdata_dir=$(mktemp -d /tmp/__perf_test.perf.data.XXXXX)
+perfdata=${perfdata_dir}/perf.data
+file=$(mktemp /tmp/temporary_file.XXXXX)
+# Relative path works whether it's installed or running from repo
+script_path=$(dirname "$0")/../../scripts/python/arm-cs-trace-disasm.py
+
+cleanup_files()
+{
+	set +e
+	rm -rf ${perfdata_dir}
+	rm -f ${file}
+	trap - EXIT TERM INT
+	exit $glb_err
+}
+
+trap cleanup_files EXIT TERM INT
+
+# Ranges start and end on branches, so check for some likely branch instructions
+sep="\s\|\s"
+branch_search="\sbl${sep}b${sep}b.ne${sep}b.eq${sep}cbz\s"
+
+## Test kernel ##
+if [ -e /proc/kcore ]; then
+	echo "Testing kernel disassembly"
+	perf record -o ${perfdata} -e cs_etm//k --kcore -- touch $file > /dev/null 2>&1
+	perf script -i ${perfdata} -s python:${script_path} -- \
+		-d --stop-sample=30 2> /dev/null > ${file}
+	grep -q -e ${branch_search} ${file}
+	echo "Found kernel branches"
+else
+	# kcore is required for correct kernel decode due to runtime code patching
+	echo "No kcore, skipping kernel test"
+fi
+
+## Test user ##
+echo "Testing userspace disassembly"
+perf record -o ${perfdata} -e cs_etm//u -- touch $file > /dev/null 2>&1
+perf script -i ${perfdata} -s python:${script_path} -- \
+	-d --stop-sample=30 2> /dev/null > ${file}
+grep -q -e ${branch_search} ${file}
+echo "Found userspace branches"
+
+glb_err=0
-- 
2.34.1

