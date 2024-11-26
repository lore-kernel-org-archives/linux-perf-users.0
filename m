Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEFB1C07EA;
	Tue, 26 Nov 2024 22:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732660384; cv=none; b=ieZ+VD+/LqZfm7QrD6GSyxw6tIhx2d2vHgATk1myHmY4MAvSnRs74kphs1LVW9Atl8cQFqOLFWyUnfY+bDvawXPxYYa8V/AVvfnpJon/olMr2eXkfvZlDjB9Fx1clUyzKe9WslKSbzPvxNzD1cMrmCKT2+beANd9cDdU5AsHK20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732660384; c=relaxed/simple;
	bh=eb5UcN2m+bLBqJqaJlKNgwpK0257qbGYaBa5bsQWl9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvVT054o4r1N33OhAsFx2ECIRU+65iv/pFc4uEFqizB5DZKcHj7jRmRk3/5OF1IA7DijXlDWHmi2PrgRWBrIP8r2WyyTiXi85LyJQGQpW6+270+ZS2iBm+mAMIVTEu6jJPZHBUtEXLuM6RWSVR/UTusagPWwZ4hXhOCy1fshPlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=at7xtGTl; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="at7xtGTl"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7fc41b4c78bso1005036a12.3;
        Tue, 26 Nov 2024 14:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732660382; x=1733265182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEHXcY7YX+C+Hi5w5eTeovZONiwwNT+ZiU9qfibL2oU=;
        b=at7xtGTlDEkZnKANXNNqX8xi+7mLm/3ocsofHqg4tJF5huCpBhqxeayZdkn3pzbi+E
         iUA5EoFqCn1fFG05TRbQcsxbLwdxGHh/ntuKpXjTIVQYapEVYUsPLPOchWBRw7/0F4Ii
         /vAWpEMlI5ZM8dkg+mNjwZkZp9cVg4SOWeMY8gQJDHhFa8Z1SElM/wALjqJ5idjWlmg8
         0zXtwEjyGrNOuC8NIfzJjaOzeG5nMWQdQ1zAWzlnWirN63RNkBoT+iWSUHf3OdkvL7l1
         puwH+rRv5O72ioinHMuTsjrPQs3HPcuvwmvJsebSGomZlAgMfZkn5ZrnZxaMXOdHSSPH
         DE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732660382; x=1733265182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEHXcY7YX+C+Hi5w5eTeovZONiwwNT+ZiU9qfibL2oU=;
        b=XY9P+nFhHoZ106c6qPt6CPeubDkxuawEZiKpPcipPMV9IvPKouce+VDkX+RUVmB4cg
         00jvIZtJNRwShT5xsDA0Nd4DfBShQlbRcVQYnlZxLu9g8U9aWx/8j1G0iNe28NzsoWi+
         hFgLuDeP1dqBx28s9IXQZvDyIp/5q++jTJ1+mauVzzwRYkSwpbbyZeyrwTNB9Ou5S8Uf
         pHcmE/hx90CE+L42RgulxBUNC44Ixa/dAdnIskbAbmETkVCzcUsWHXwZIqQpiKPbNyxa
         Q0dU/r8js/xwgP+yfV5CZB66AYrJcsixyghDSo0dsME74sFr/PZkACAyahTZeU3p6rSb
         Vv8w==
X-Forwarded-Encrypted: i=1; AJvYcCUWwd8+zm8X3EqKUAUHmJpUnrrDb6dfZbskVic4+YsEVOxZFlSOvS2SnmwFjMdcuhu9Zs9HdGPiwwk5vq+dyIyVOQ==@vger.kernel.org, AJvYcCXtjDXJbtSBCc9xouPYj308JM0FuTw2UFXgfuSGSEpaSEbxIkCu4aq9IW/t70l7lNQHUhg5nZqwBtkmlWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDS/MYipFLvNluwj4dfxkR16ZxNhZvqG3zKyrJ4DMNfqRvrqsJ
	AJOkfyT/Vpt5DSMEYG4OqSqQsyzYYJsTDGXdBJjsPSUzZ+NDYc6Y
X-Gm-Gg: ASbGnctCnQ9wYnGIANLWo0IpVNM27OqraiBuZcv99GoYBcA26t1Q5S8O1Or2sQm1jfx
	+0KAkfid7546LJ6kryyK/HLYSVJ09H8zwisyOHmZXjAbVkshYw8LWsvmeGZh7Lxiq3gQe9w6j5W
	DvpK+keYNPTjL8sQCk1uANHBBEc8Tq2IJC77h8hoaO5UppPXFldg8eavlghbWEeQRv7MtAW3+HH
	gP1vAoF+YOXClkwKCxe4zPU4YVb51dKF+JIYIrNYSwec7PHq1IKCaLm/GJMTdx3DE12AIUZ8tdU
	c2j9qjs88sA=
X-Google-Smtp-Source: AGHT+IGGSK886aQYYJOu845r5D0cV+ASQo82w9rf/FglI1Rw3IEzMj4MqAsKWiPIjwKofrt8TuosZw==
X-Received: by 2002:a05:6a20:6a09:b0:1e0:d9ab:27f with SMTP id adf61e73a8af0-1e0e0b853d0mr1837505637.37.1732660381825;
        Tue, 26 Nov 2024 14:33:01 -0800 (PST)
Received: from mbp.. (157-131-33-111.fiber.dynamic.sonic.net. [157.131.33.111])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc406de3sm7948861a12.81.2024.11.26.14.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 14:33:01 -0800 (PST)
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
Subject: [PATCH v2 1/2] perf trace: Add tests for BTF general augmentation
Date: Tue, 26 Nov 2024 14:32:56 -0800
Message-ID: <20241126223257.22465-2-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241126223257.22465-1-howardchu95@gmail.com>
References: <20241126223257.22465-1-howardchu95@gmail.com>
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
Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/tests/shell/trace_btf_general.sh | 81 +++++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100755 tools/perf/tests/shell/trace_btf_general.sh

diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tests/shell/trace_btf_general.sh
new file mode 100755
index 000000000000..903310b355c4
--- /dev/null
+++ b/tools/perf/tests/shell/trace_btf_general.sh
@@ -0,0 +1,81 @@
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
+buffer="buffer content"
+perf_config_tmp=$(mktemp /tmp/.perfconfig_XXXXX)
+
+trap cleanup EXIT TERM INT HUP
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

