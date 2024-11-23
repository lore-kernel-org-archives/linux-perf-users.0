Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC73633CA;
	Sat, 23 Nov 2024 00:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732323319; cv=none; b=Y8yfx1hNXc1gSSo6MXbkRoQHB/i7UCro4zjpZTzCLyVxsVhGKsOTj2j9bGjSmtLt4HJjcTQS7vjsSF0rJgVHNzpZtJ78pFWYJTBYSD9t/+AYsoaMesGdPphsblZCWlSVbKqfwrS2BnOKZB5wKemNijYtoDEmPgOrNDRyenbGOhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732323319; c=relaxed/simple;
	bh=ZELMqUxSMS5L2VRgPfYPExyjo8Dd7Hn80gjtiWrvQXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7qvDTpVn88plLr7ec/mHlmcwPUWFSmHFwQ1/AC4+V2E3udZnd24QkK0bmhFCKBjSFjg7VzeVS2ujL3sTnj7xL/EQwzXvwn3bv1ejFetS4O+Do49+iabxdMb5jjaXvLDI9rbvgTyuSQPNQxSImVtnRf1NHrzE7poUVQP/3zO5UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3n3P5SI; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3n3P5SI"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-724d57a9f7cso2063721b3a.3;
        Fri, 22 Nov 2024 16:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732323317; x=1732928117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ylEP5NEMX6Gjh501UBumaT2c/H2toXVxFjaH68g1n0=;
        b=l3n3P5SIdyf4fFoQBeNkheCT9qjL4iFabzbpedpDyFyzvHaWiDxl+zAYdYeGrjCUhD
         Ab/rjxFuSWztYYebGB/vA15BFeUmYUiHWhNcDHstMuWxuxWL1/DrzmofzRQt9BcPF2Ge
         Ji6laMJbsPEoJg0tOUGJ9nAFG+tI5Ts+9CWlu8rdVL+ewhiLs/atScf9KC5vADAagBJ+
         MHlulijSqwgMR3UR3/oyzeoCBb8PSi1gtseMH+IJ7hayRcoPNaO73xxLWd6XDOMIk/Gf
         yiA9NsJnOJFCtKuUdeWm2pBzgrh32uxXa8tWM9O3h6YlOFucP3dCnPJEL8trb/MAo1HF
         iUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732323317; x=1732928117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ylEP5NEMX6Gjh501UBumaT2c/H2toXVxFjaH68g1n0=;
        b=VyUpuMMshfSL1Z9BYeg/APg9QyGkREFX/0HLnyOFnaPJtzUeOMXN6nos5qlcWbxBIi
         M521qElJIJDhEH6K+dJe11n5Nz86Dd5w66HjSje7cG5zG3GRwulpHiL+IF+Q+rvUMqq8
         7Pu5hIIapoBddKx8IGk2Ot228qHoCubFAYLVF/pe6oPoLlU4Pxx2MU2VHniCQRwzu4DF
         2l1ykiwVvRcGEtjZPi1ouImWFzEfuhYm3aYrVOXNKm9+dHkdjd/+hHITKOTUQPJ4fPoT
         tgJG+tfOer0eg6oBgjuJv59zzTRWetbsKnAmnQztqSj8zQO1pU1Z4v90rWDDbJ2G3f9M
         +ETQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmQK9HS2U0R07otVJVJjssGvS02zTIpq8v1nmZlld16oR70YpzV11yCWBv4Y6ijTGRagSVNKdDAFYAXSTLIbutQQ==@vger.kernel.org, AJvYcCXAUCrv4AwtyRhxzBVpmany9wsJpDaKsqq0d3KJTvZfR4i+gTT41QxFq8KcN9Cx4f1LowdHmlWJZiRrH3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt2FsLBsyEIJJj4wGdGRm7KJsVzySKUUwYWQYQ6DHZkrCZt9Lp
	YPZg6Cq5xhfZJWcaOf6swV1B0xyNZytX1EcyR3P7KkDf9uNA0Dm8
X-Gm-Gg: ASbGnctYIfVvlzOi/M4mAw1kjvYkl0hKI8bBh0xXxWpMbpIoknj+d8r+RoZ/DeUidPA
	4kdOM225hwAqYEWz/TQnHB8wbQXRNO8hqXlICMP6Q9WsscIkBuvi8cq0aPi3tymp+Ft7f+/HL9q
	Xu5at5tW+WYmrfMbIVXzZ6jU0Oj3hyV69/2+WkqW8V8aub+HZPoAZOykwp5BLjvGXXSkH+S2Dmb
	sCfSzwTrcA3PqM9hEc6c1HkPNeBeBiuIpRTr9YxZNpCBegEJ+VO+yT3NznRE4AEDNnAA8EI29bJ
	IfrICc5eJf4=
X-Google-Smtp-Source: AGHT+IFpdx9YJkpZA5dPCv+925nHB0zRyoPrCideIx/5n1l5fKotGr/tuel0WCBA3TlUL0EXENnx7A==
X-Received: by 2002:a17:90b:2f0b:b0:2ea:7cd5:4adf with SMTP id 98e67ed59e1d1-2eb0e890892mr5507804a91.31.1732323317091;
        Fri, 22 Nov 2024 16:55:17 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724e0fca304sm2082867b3a.175.2024.11.22.16.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 16:55:16 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v1 1/2] perf trace: Add tests for BTF general augmentation
Date: Fri, 22 Nov 2024 16:55:10 -0800
Message-ID: <20241123005512.342079-2-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241123005512.342079-1-howardchu95@gmail.com>
References: <20241123005512.342079-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we only have perf trace augmentation tests for enum
arguments. This patch adds tests for more general syscall arguments,
such as struct pointers, strings, and buffers.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/tests/shell/trace_btf_general.sh | 68 +++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100755 tools/perf/tests/shell/trace_btf_general.sh

diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tests/shell/trace_btf_general.sh
new file mode 100755
index 000000000000..7bcca81a40d8
--- /dev/null
+++ b/tools/perf/tests/shell/trace_btf_general.sh
@@ -0,0 +1,68 @@
+#!/bin/bash
+# perf trace BTF general tests
+# SPDX-License-Identifier: GPL-2.0
+
+err=0
+set -e
+
+. "$(dirname $0)"/lib/probe.sh
+skip_if_no_perf_trace || exit 2
+
+file1=$(mktemp /tmp/file1_XXXXX)
+file2=$(echo $file1 | sed 's/file1/file2/g')
+
+buffer="the content of the buffer"
+
+trap cleanup EXIT TERM INT HUP
+
+trace_test_string() {
+  echo "Testing perf trace's string augmentation"
+  if ! perf trace -e renameat* --max-events=1 -- mv ${file1} ${file2} 2>&1 | grep -q -E " +[0-9]+\.[0-9]+ +\( *[0-9]+\.[0-9]+ ms\): +mv\/[0-9]+ renameat(2)?\(olddfd: .*, oldname: \"${file1}\", newdfd: .*, newname: \"${file2}\", flags: .*\) += +[0-9]+$"
+  then
+    echo "String augmentation test failed"
+    err=1
+  fi
+}
+
+trace_test_buffer() {
+  echo "Testing perf trace's buffer augmentation"
+  # echo will insert a newline (\10) at the end of the buffer
+  if ! perf trace -e write --max-events=1 -- echo "${buffer}" 2>&1 | grep -q -E " +[0-9]+\.[0-9]+ +\( *[0-9]+\.[0-9]+ ms\): +echo\/[0-9]+ write\(fd: [0-9]+, buf: ${buffer}.*, count: [0-9]+\) += +[0-9]+$"
+  then
+    echo "Buffer augmentation test failed"
+    err=1
+  fi
+}
+
+trace_test_struct_btf() {
+  echo "Testing perf trace's struct augmentation"
+  if ! perf trace -e clock_nanosleep --force-btf --max-events=1 -- sleep 1 2>&1 | grep -q -E " +[0-9]+\.[0-9]+ +\( *[0-9]+\.[0-9]+ ms\): +sleep\/[0-9]+ clock_nanosleep\(rqtp: \(struct __kernel_timespec\)\{\.tv_sec = \(__kernel_time64_t\)1,\}, rmtp: 0x[0-9a-f]+\) += +[0-9]+$"
+  then
+    echo "BTF struct augmentation test failed"
+    err=1
+  fi
+}
+
+cleanup() {
+	rm -rf ${file1} ${file2}
+}
+
+trap_cleanup() {
+	echo "Unexpected signal in ${FUNCNAME[1]}"
+	cleanup
+	exit 1
+}
+
+trace_test_string
+
+if [ $err = 0 ]; then
+  trace_test_buffer
+fi
+
+if [ $err = 0 ]; then
+  trace_test_struct_btf
+fi
+
+cleanup
+
+exit $err
-- 
2.43.0

