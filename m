Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C12547A4C;
	Thu, 15 Aug 2024 01:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723685838; cv=none; b=FRyRfNYrhxCZWWzUAgH/uVRD4Kfx/RdgDv2+CzQwmRXPNL+yscuhSES9UbKYv4fP+J7dl4AGLlB6ixNjD1iuFW5O4gW+MK5bQLBVZn/oNZljruo1mQyJvXqRt/F4H+K+lGdwVxhmBKqYIFl3TK2wjtA02Pv03MqJrBZqNSaSq0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723685838; c=relaxed/simple;
	bh=FAra7IslueJ2M3LeoV4wY0d8qZzY2HkcWrqATM3x3RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=riZ3F6KbyfhtI94CrQyMtA25WJn37qOzYehfCgRpuYSkpGw1o1OkrguTwZLZU77Qit9jQS3YS9FFZJ2a4vmI0QgDMRrjJqpgPpYJNlTMEJq1fmQU0VgOg2SxmAvqE2dUS6p6n+4A7om/Uf84IzjSOE5ktCG7MVlhv6ynPo8sCwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6Rvvufa; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6Rvvufa"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3db14cc9066so304838b6e.3;
        Wed, 14 Aug 2024 18:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723685835; x=1724290635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMGaOVIVwJJwP5Xk416IMkcEFAeT/3CwfvbFdC0BmwM=;
        b=A6RvvufaW/f4PZepkmsF4PYJH9UBInYC2obMOdsKgwd6mn/TRGX12AxSQHMiAHGqT7
         nT4u4jXLpZUaCm4gh5n5iBLhplDsU/C9wiGgi+HaGnTEEL3SRgpGbB8mLlEe4Bc2O6N+
         eyetqS/gLSv/UlODOAuYgvjdvScF16+KFg0Qww12ainr2xmAamMnw/HCPi7yWzcP0fl7
         JnKsAL5WhBYcFwI6P9KgFYokgCZRrW9pXSzWoGrZ12FMnM2z9XtRVydeQv8fXqASsE26
         FGMpM/mJ7a4z1THdEYEyL0+vncIUKPAfNpxuotn7FJeJSiIJZHnFt6mZZjugwg0ig9Yx
         9OSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723685835; x=1724290635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMGaOVIVwJJwP5Xk416IMkcEFAeT/3CwfvbFdC0BmwM=;
        b=FHHj6CVlKkj1IprWf3epbGtzvvu5dwlz9FwaJgTJMgdrwvMHIj0y+9md9vO+jTQDGm
         UsOKyUZkreX07V+V/HHy7SddP1DgWJTLPAwSwOiQ1u1LgKafiIVQfXI4dGqZ3BeCFwqC
         bKA4svfK9iP6psCJtdKdwFnaScIq/O9vTBVxSv1ylE51O5aDQAuRdI/MrAK8CN1tCfxk
         o5pRg3+2g145PYvphMqwBY/CJtEyL8PZA7DMKvUW+MfkSsitjYSpXEDbLGCdUKRsWuiA
         bkBL6wZhfN90DiRAGfhPIuK0TE5uJ1RBSL0Zj1y6B8OLPJGjSx1Wi0t2tknCu9d/wZJm
         a6Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUqPmENO9HXCgW6DFTyRQve+/RhqkAcJZ+ARBYS3HZzfPctkdmI055gRnr/vkHuWwbHhVJxEP2WBhMWQea+QKHqa1CfffVQEigYcwwg787bj37nfCudPdSYhAeZGGdcc686CZAWR72vGqZtsseIhA==
X-Gm-Message-State: AOJu0YyxqKMQo+NMtmGkeVzckiN10U3tItcZM0pXa64vsgEotkrQSgVJ
	9CSyV3D0f+4kyOYxjAHyR4H9olNjiKzDnG1+xjqI+EYUG4olKWAZWCLrf876paA=
X-Google-Smtp-Source: AGHT+IF3VFR6FbD1wRel2opwl5OqQ6FBZmTPd0eL8xF7JXvyUiVAaim/4wAUmzJ69PcagK8hNAu5BA==
X-Received: by 2002:a05:6870:bac8:b0:268:a074:39cf with SMTP id 586e51a60fabf-26fe59dd845mr5141614fac.8.1723685835543;
        Wed, 14 Aug 2024 18:37:15 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef412bsm196842b3a.123.2024.08.14.18.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 18:37:15 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/10] perf trace: Add general tests for augmented syscalls
Date: Thu, 15 Aug 2024 09:36:26 +0800
Message-ID: <20240815013626.935097-11-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240815013626.935097-1-howardchu95@gmail.com>
References: <20240815013626.935097-1-howardchu95@gmail.com>
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

Please use this command to test it out:

perf test "perf trace general tests"

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/tests/shell/trace_btf_general.sh | 59 +++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100755 tools/perf/tests/shell/trace_btf_general.sh

diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tests/shell/trace_btf_general.sh
new file mode 100755
index 000000000000..9c5e9d321b42
--- /dev/null
+++ b/tools/perf/tests/shell/trace_btf_general.sh
@@ -0,0 +1,59 @@
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
+trace_test_string() {
+  echo "Testing perf trace's string augmentation"
+  if ! perf trace -e renameat* --max-events=1 -- mv ${file1} ${file2} 2>&1 | grep -q -E "renameat[2]*.*oldname: \"${file1}\".*newname: \"${file2}\".*"
+  then
+    echo "String augmentation failed"
+    err=1
+  fi
+}
+
+trace_test_buffer() {
+  echo "Testing perf trace's buffer augmentation"
+  if ! perf trace -e write --max-events=1 -- echo "${buffer}" 2>&1 | grep -q -E ".*write.*buf: \"${buffer}.*\".*"
+  then
+    echo "Buffer augmentation failed"
+    err=1
+  fi
+}
+
+trace_test_struct() {
+  echo "Testing perf trace's struct augmentation"
+  if ! perf trace -e clock_nanosleep --max-events=1 -- sleep 1 2>&1 | grep -q -E ".*clock_nanosleep\(rqtp: \{1,\}, rmtp: \{1,\}\).* = 0"
+  then
+    echo "Struct augmentation failed"
+    err=1
+  fi
+}
+
+cleanup() {
+	rm -rf ${file2}
+}
+
+trace_test_string
+
+if [ $err = 0 ]; then
+  trace_test_buffer
+fi
+
+if [ $err = 0 ]; then
+  trace_test_struct
+fi
+
+cleanup
+
+exit $err
-- 
2.45.2

