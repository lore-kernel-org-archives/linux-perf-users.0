Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB981B87D2;
	Sun, 15 Dec 2024 19:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734289642; cv=none; b=d8WPdMBdHmlCZE9SLUViChQatV2wy/aY3Iw9ypZRgpR3ccnw9HzrqFtNfZRiRQi+e8neHexIgxW+5X+jEEbnfOFjsjiLCN1L5PZzNlZgSJSmktZxpOBk3aBD/fkE1oA6E4+zHUgut/DFr6H2oCo3BNgmlFZQUaivh0aU6yF8qW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734289642; c=relaxed/simple;
	bh=TwL/5VAcIZnY2ANbWPVZUCYjN+wBtohoFZi/fVoZH3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ouImo76YUr4ifWf0uw0j7zUp5LIjxn8RNUUIF959pQ3F/gBPEiChMkRz8/MCpH3HGHAyDdTQTHd0rqTQxy/PacVxJVLtLOoslNCEQuzDDHwd7BAP4wjPCqaErlXA/vW72xbf147JmMUYhkIh5iQDyvh9wu0D6LztPhCT8VQK3Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgG3WH5W; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgG3WH5W"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-728ec840a8aso3640010b3a.0;
        Sun, 15 Dec 2024 11:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734289639; x=1734894439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xzl9UDraYelF+Mi4pN3KN81FbVJtb2Uuye3lCkhND04=;
        b=JgG3WH5W46sb4iYZu/FD8SOMa1dlBt4efdhgLWYxPYdcmGOsOzu+P+Kq1CcHIku4Of
         WTFbfHz7OJnj/roAlERBoI+rwdsgnYlwI3D3tMNOVxkPPFVR8xvqxOSQ2moIlUJcbdnh
         6ualXGDDbn36xYKckXkF4/1FsHR1KkljcpjWLJlRkCL6FjZyKSZt6g35FmkzZv6GNukq
         K35XujcSVUjJhdH/Hm5+RDjTE4bwYpaTUqJdUnnWxOPkmEf2Sjn0v1o1QY6qMQQmzNy9
         JMpOmLDBuST6+V8V3MGHGkH8CiEfRi9SaRmDYITx4OxNfufVPMg4wDld+IP4W/ek8cTg
         FG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734289639; x=1734894439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xzl9UDraYelF+Mi4pN3KN81FbVJtb2Uuye3lCkhND04=;
        b=FuT0bGQggf5V9sPZukbIpjM0kB0T/CkEW4+BG7glKv6Fu2eYT5hiTND/AzSclGrVKn
         0rL54/RB9xm/5g/4GpflmMkSJblBnC6yIBkdbcjfljPPVw5qPaei3kMgq9Lcy5VJe6Y0
         Dr3V3S0AsJBRJwNcqQ/Z5fDNfi31IAix5e8Xvn3QBqA8SkWAqaxTU76UbNaURLEclEbB
         rz6f1AgIjDiPKgx+o9ls2M4CF+l5UI71ohpuYLrgencgPQBGyUT9MYWeQcM32GKOK7C9
         lF3q7hUn1LtefemRtZ79B+QYeVlZHubSlvRdIADiMnMbANDTTzNl0H4xR9Qp0vTCL+Rm
         WbTw==
X-Forwarded-Encrypted: i=1; AJvYcCXJKG8wqD10FxmcrzAT0ulnCCJt2EkejQbQFCWc+SfTQGaSRfegl3/muqV9QI4U40PqnYhX7Gi9ejh7ewdP6JOqsg==@vger.kernel.org, AJvYcCXjpTiQoIvATRz5k5CiCpIRhC4Pa8ftkkE3hsE5cbtdUG3jgXIXLwQcSM0/gulU0DQZ2zH4PeafJd9/lVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrcMk1NlI+xWAzF659DtyRhv10TyJb46bS4P2ZrH7GCbwWKv5K
	GZnE6xR/sRmCFzY0lT9+drJQKABp+bviTeqY1F5cYNL7FBZ3WN0v
X-Gm-Gg: ASbGncvj2vCa/QZ1SzawlnaH9evOD2uvArUCJ70z8znoScS67t5rCjO3j6kBTqHRCi7
	ree+hF9uOVytLsnyY3r0th0UldeeCd7xWt2ed3H3/1WzWJGCcTbkqX3RyB9SfIbqWT40F5YQZAk
	OQqfaHiUF4rWos90IvuSVJIdTLGox+pGBGKtrysO4q9hjw5iLsOQ8LGioobkbYp3YzGUUnda9Gj
	FeUTWlQILMjJEEbvEIk/wSxFy1vC6YH7YR9v32vR1rpjYNFDRgwZZ2h8QzCp4s6u3xyyAMomsf5
	5RuTJgcWg3Wx
X-Google-Smtp-Source: AGHT+IGiS7ZIGvJmO8brxQv1Zwgbc2ltzyTXnURscFBvkU+jr3zbXZ0o8iN0vElTYZiMqBYml//vXA==
X-Received: by 2002:a05:6a00:c8c:b0:725:db34:6a8c with SMTP id d2e1a72fcca58-7290c1b276cmr13625784b3a.13.1734289639633;
        Sun, 15 Dec 2024 11:07:19 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5aaf3e6sm2800453a12.23.2024.12.15.11.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 11:07:19 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v4 1/2] perf trace: Add tests for BTF general augmentation
Date: Sun, 15 Dec 2024 11:07:10 -0800
Message-ID: <20241215190712.787847-2-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190712.787847-1-howardchu95@gmail.com>
References: <20241215190712.787847-1-howardchu95@gmail.com>
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

These tests utilize the perf config system to configure the perf trace
output, as suggested by Arnaldo Carvalho de Melo <acme@kernel.org>

Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/tests/shell/trace_btf_general.sh | 93 +++++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100755 tools/perf/tests/shell/trace_btf_general.sh

diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tests/shell/trace_btf_general.sh
new file mode 100755
index 000000000000..005c93e6c770
--- /dev/null
+++ b/tools/perf/tests/shell/trace_btf_general.sh
@@ -0,0 +1,93 @@
+#!/bin/bash
+# perf trace BTF general tests
+# SPDX-License-Identifier: GPL-2.0
+
+err=0
+set -e
+
+. "$(dirname $0)"/lib/probe.sh
+
+file1=$(mktemp /tmp/file1_XXXX)
+file2=$(echo $file1 | sed 's/file1/file2/g')
+
+buffer="buffer content"
+perf_config_tmp=$(mktemp /tmp/.perfconfig_XXXXX)
+
+trap cleanup EXIT TERM INT HUP
+
+check_vmlinux() {
+  echo "Checking if vmlinux BTF exists"
+  if [ ! -f /sys/kernel/btf/vmlinux ]
+  then
+    echo "Skipped due to missing vmlinux BTF"
+    return 2
+  fi
+  return 0
+}
+
+trace_test_string() {
+  echo "Testing perf trace's string augmentation"
+  if ! perf trace -e renameat* --max-events=1 -- mv ${file1} ${file2} 2>&1 | \
+    grep -q -E "^mv/[0-9]+ renameat(2)?\(.*, \"${file1}\", .*, \"${file2}\", .*\) += +[0-9]+$"
+  then
+    echo "String augmentation test failed"
+    err=1
+  fi
+}
+
+trace_test_buffer() {
+  echo "Testing perf trace's buffer augmentation"
+  # echo will insert a newline (\10) at the end of the buffer
+  if ! perf trace -e write --max-events=1 -- echo "${buffer}" 2>&1 | \
+    grep -q -E "^echo/[0-9]+ write\([0-9]+, ${buffer}.*, [0-9]+\) += +[0-9]+$"
+  then
+    echo "Buffer augmentation test failed"
+    err=1
+  fi
+}
+
+trace_test_struct_btf() {
+  echo "Testing perf trace's struct augmentation"
+  if ! perf trace -e clock_nanosleep --force-btf --max-events=1 -- sleep 1 2>&1 | \
+    grep -q -E "^sleep/[0-9]+ clock_nanosleep\(0, 0, \{1,\}, 0x[0-9a-f]+\) += +[0-9]+$"
+  then
+    echo "BTF struct augmentation test failed"
+    err=1
+  fi
+}
+
+cleanup() {
+  rm -rf ${file1} ${file2} ${perf_config_tmp}
+}
+
+trap_cleanup() {
+  echo "Unexpected signal in ${FUNCNAME[1]}"
+  cleanup
+  exit 1
+}
+
+# don't overwrite user's perf config
+trace_config() {
+  export PERF_CONFIG=${perf_config_tmp}
+  perf config trace.show_arg_names=false trace.show_duration=false \
+    trace.show_timestamp=false trace.args_alignment=0
+}
+
+skip_if_no_perf_trace || exit 2
+check_vmlinux || exit 2
+
+trace_config
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

