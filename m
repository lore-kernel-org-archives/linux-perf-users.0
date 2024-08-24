Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DDE1865FF;
	Sat, 24 Aug 2024 16:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724517215; cv=none; b=ZTp/+s5LQsQrdYmei5yjoq69W3qRa3FitxaqTrG52DJlYZ/LXie57xPYGThnr/yi/UM7rL2eEpu6EquKXs8F3nSrogk49RRyIm+KISRhGobg0aKJb4eojc46y8VsuM6nsra1Ayfq3jNcJ9+WWNtU1o/bZZUvzFXQH+eoi/hmnfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724517215; c=relaxed/simple;
	bh=gcLi01rczSi1pkKRDBQ6xxxxrZMo7LjOc717hx9S8po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kaTwMUlmuU+mVBiv7PxCd9WVMEBbhXFSxnEj/luOZ0nxa0Wfo/SLM5C5/3SSk3VSmmNDk4oKxl/A/52+EZOFkcubO9qZYEIM1NfIPQ6IbOonwdIh/kgP1/WYVKYg+obDagAbJI710qi7iE+mfPDFrPkeN1NngxZsbcvBzZPDx/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntWpqYEf; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntWpqYEf"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d427fb7c92so2182801a91.1;
        Sat, 24 Aug 2024 09:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724517213; x=1725122013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEYfaiWN5qgCnRZpAGUw8130UenZvpr/yXa584v7XJA=;
        b=ntWpqYEfH/QCikOET5sK15c+VuOde29wE4XOxHb2qXk1wYxdPSHT70ow/tQAGqcdzK
         JWdrV61TPq9TbrysDKzm0IEyrm05Zv41JbNPvUlCG5BUjOLj0klPmgYsZebpXRMLDzI7
         svS2g+TyuZQDtxDLwWV5QqkDk1FcLxbKdL3I1LMfRuXGjwgjGPHCt+CTXGOxHPn/x4Uy
         rCprL+Y+kQbWHd5My/v/Mn/DklapTUf1CwIV5ZfYJ3wgrOWI7KUkPqZlUeCtnwpIDXV9
         djzvxvTU0DOauATKL6rSLBQx0Wzue3cgeWjrJNnEXnYm3TWjKkQm1yiUOyLmEWT4ZeeS
         YWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724517213; x=1725122013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vEYfaiWN5qgCnRZpAGUw8130UenZvpr/yXa584v7XJA=;
        b=YCrgPAYv5z26+V7CIgo1zZYipgCbTZL2y9sBF3YyY6bP6EZnSXCYNNIOIVt7F123JX
         pO2Hm6jJm9fkaDR2IcaxAysAah+2bgvkDzi480hGvsrbgvL/pMrCIaXf/t5XFfd6H9li
         EWNT9RSzD8NH5si8wIhXvFdOmWM228J5gtLyD4+PM/QGoc8Vkk4acoGtI6EMp4idnfQ0
         BTIthDb05p8kZpd2LYut5b1xvfA87z2AUWXyBv+7TQprx+HqYl/vu1N0qblmO6vunnhq
         6XMlKB+x9Nf/iysZDkE7j5JxCwX0ZVtoyNPEDyZjSXMlc7DHCIhkNKf3epgoM5NyCqOI
         DHuA==
X-Forwarded-Encrypted: i=1; AJvYcCUZsOA3w2BEDPeTccOwL0J0Jxgvizf2eW7OGCiGSBIL/e7pmLHq/ObdxXKLBSs7aZwKxO/WzJmL1hBr7SiqkXP0ng==@vger.kernel.org, AJvYcCV7sjsVfBXWn7N2WPewjQGGH80WABBMaDbVxyENtiLpjTfAUXQUNXFsrn6bOUc3vTaX7U+RP7Je/9B1bok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Pe3NvDrdHQxulQRy6k57hNFLa1HmsbeyWdiVnip7wL/rKBcD
	UmnEmbAZT6ln+EOsK3xezd+NppULVBZ3oG0CoEu6CE9EgyDzgF57
X-Google-Smtp-Source: AGHT+IH9SmN+mw3f0MoP2XjW8DrH+FyJXhlhjjKJkEVNz2e6/WEj35Le79bQCWCPaPpxUV5PXhdSSA==
X-Received: by 2002:a17:90a:c713:b0:2c8:ea7b:8891 with SMTP id 98e67ed59e1d1-2d646d26884mr5566573a91.29.1724517212985;
        Sat, 24 Aug 2024 09:33:32 -0700 (PDT)
Received: from localhost.localdomain (104-58-203-241.lightspeed.sntcca.sbcglobal.net. [104.58.203.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613941ee7sm6376216a91.24.2024.08.24.09.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 09:33:32 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/8] perf trace: Add general tests for augmented syscalls
Date: Sun, 25 Aug 2024 00:33:22 +0800
Message-ID: <20240824163322.60796-9-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240824163322.60796-1-howardchu95@gmail.com>
References: <20240824163322.60796-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this test, augmentation for:

* string
* buffer
* struct

Is tested.

Please use this command:

perf test "perf trace general tests"

Signed-off-by: Howard Chu <howardchu95@gmail.com>
Suggested-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/trace_btf_general.sh | 67 +++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100755 tools/perf/tests/shell/trace_btf_general.sh

diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tests/shell/trace_btf_general.sh
new file mode 100755
index 000000000000..0b4ea8462390
--- /dev/null
+++ b/tools/perf/tests/shell/trace_btf_general.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
+# perf trace general tests
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
+buffer="this is a buffer for testing"
+
+trap cleanup EXIT TERM INT HUP
+
+trace_test_string() {
+  echo "Testing perf trace's string augmentation"
+  if ! perf trace -e renameat* --max-events=1 -- mv ${file1} ${file2} 2>&1 | grep -q -E "renameat[2]*.*oldname: \"${file1}\".*newname: \"${file2}\".*"
+  then
+    echo "String augmentation test failed"
+    err=1
+  fi
+}
+
+trace_test_buffer() {
+  echo "Testing perf trace's buffer augmentation"
+  if ! perf trace -e write --max-events=1 -- echo "${buffer}" 2>&1 | grep -q -E ".*write.*buf: ${buffer}.*"
+  then
+    echo "Buffer augmentation test failed"
+    err=1
+  fi
+}
+
+trace_test_struct_btf() {
+  echo "Testing perf trace's struct augmentation"
+  if ! perf trace -e clock_nanosleep --force-btf --max-events=1 -- sleep 1 2>&1 | grep -q -E ".*clock_nanosleep\(rqtp: \{1,\}, rmtp: \{1,\}\).* = 0"
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
2.45.2

