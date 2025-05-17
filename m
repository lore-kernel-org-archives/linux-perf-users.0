Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B2620E033;
	Sat, 17 May 2025 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747499563; cv=none; b=smfaEKpeU8or5yHLaYEdv85uPTZuUxwm29eNKFpj0p5fqF+nxbJjk4bP/dVuFDuFOVfRAjEI6J2JGzPuJvqYwhrwIYd/TftKj3UPEEbr84gdWUyhtYkBIqh0RFJ3N+EuvjiQNoe5hVdkHa9nauLIw3uLgj4Ko7/MpgrXd5PEqOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747499563; c=relaxed/simple;
	bh=HGl5/1C+PePacGkaulqAAE63eATlJ5yTexSJ13I7erw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qfzu6gkG1+bm67fVKbGBrxzWT4gChhFcVLuqenZY2fIY0B019VE2OxucnVUKsMsH6y8/5U6diWVLNZ4IqYTP3vGbUkSKqnfCOep0KiRZk7q7Y8b2htKuHq6IRSqAAko9qGrPlpiiaoLyT9OEof7BkCUBHexnzJstJmb41STWPAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQIObIWB; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQIObIWB"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso3176306b3a.2;
        Sat, 17 May 2025 09:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747499560; x=1748104360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3m04i5CpY17sULHpU46/kb/9C20sfEkyj4cyY5wnvww=;
        b=IQIObIWB+eCcM7nOYopVYUlAQgfjnJIs2+yyGL7RafmNQb2G2tTvu+d+BCL5Dbq2vl
         0CmnnnkpOTEzaaksPl0yny2cWdpCVItK8dubWxDshliGPCN40T3+tS5nmzCeJiKSu7Lx
         /4a0iYFltAePoNXjJ7MFsI+5sx0o2apxY3GrUiDBsT7xUwlsmzjEPXvpUahW9a1c3qnH
         2GwWS3ESAEZSj8uhP8oDh/Ad8mFX30FVL9xj9a46ZyTQUrufNfufv6cmLJ0hWTuGiLTS
         KwmuC/SPlUgp8e2Y0Gqscgru9IZn4gnpd5eRgbIPGnIaYLPS/aLsA6xaSM1YX+n+eAYV
         mqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747499560; x=1748104360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3m04i5CpY17sULHpU46/kb/9C20sfEkyj4cyY5wnvww=;
        b=VvVLS9vwCiadgnUL6DbqpaImSqeqoiTnP171m5ezgZVeXwOAY1e+YCWCMSN6xuvJaY
         Aq0z/sYfQ4sI5NToNvDHJTi1qPhJq1U5/8NUlavJ3KoIajl0ZYF6IAQKv2cheRSv3rZ5
         vfzjhgsWbTrc2Gx6i3bmUG7MpOoAkkCZalDy/4gqQvX7vwTcqiawb7qnLPIXyt/n5nOK
         +8cYzUL1amFFXNm/m5Zcyz7stgvGE6hVHqW744zhVfc9j4WJdLzZgJ8zdrHx8U78pDkV
         2Jz9K+AjRLjfss2lwWGThpA8EogUNQbuYgs+9zOpdocxBnJ6Vs2TRUEflTacBgfZE7sX
         DajQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNKIu4UoZ5045SzLTN/uKdk+YV4Pi+a6uHOCMPv/S31QVde7PC55d1c7ua0iPsfxjXQUDEyNTafndL0sR6dpyv5w==@vger.kernel.org, AJvYcCXKKKh/BQucDSn/zh/06mJqz/gpPGLyh9v4sqnfKEWkB32k0Yfa464SwzVNwoEbMhWJoRzI+31b3lnycUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YymmDFP9s2DdFGgo7Yee394rYXX3X6gPWwZf93eAhrQjQxSNeC3
	Llk5mpvCmxYJpUtGju58JkB/nRhB5hQWofYLuXguPhBJX1EwH7gSe7RG
X-Gm-Gg: ASbGnctsk2L4YIHggM/m4RHbLM/B+wRrzQhR0XHsEDJej54F3ofZE8TK1Imn84KGZIf
	zXCzPTsSlSkbQWu5B5sJGOhbQB5uDYLkug7iRoM5g3fRqVal9S0V/HrIjMVJdu54RZse2p6F7rq
	pNchKad7Zun0Wb2fa79G0R+qs3OZdNRrI68+9Bu+kGKyl4PEct96sT/46rZRTL6jYBlq7hj+qTt
	j0wdl4WtlHgUc9Gg6pKtT8ENkFLC6vMS6SjJ0kLKGgYW+7t0xpMAFlcE/fyCauu7Hl0gIUy6lhF
	r0VdRHZX6vlR2U/0hgCG3Td9qLEdq7PQZ362Hkwf3q+quwnF8faKQ9ZRORy7swey5ibs8Hx6F/r
	9nVqAZybpODeN3B4Dmm6QhZe47FM33fQ=
X-Google-Smtp-Source: AGHT+IHCRl5jY/TsTkh7gQnEOTXbYQetSvinEsMw/lQo+CvDS/qm+Guemjo9FM6LYGeiZdT3pWcu9w==
X-Received: by 2002:a05:6a00:4106:b0:740:9d6f:a73b with SMTP id d2e1a72fcca58-742acd509c3mr8207212b3a.17.1747499560023;
        Sat, 17 May 2025 09:32:40 -0700 (PDT)
Received: from howard-ubuntu.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb085ad4sm3330321a12.59.2025.05.17.09.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 09:32:39 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	peterz@infradead.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v1 4/5] perf test trace: Remove set -e for BTF general tests
Date: Sat, 17 May 2025 09:32:29 -0700
Message-ID: <20250517163230.1237469-5-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250517163230.1237469-1-howardchu95@gmail.com>
References: <20250517163230.1237469-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove set -e and print error messages in BTF general tests.

Before:
    $ sudo /tmp/perf test btf -vv
    108: perf trace BTF general tests:
    108: perf trace BTF general tests                                    : Running
    --- start ---
    test child forked, pid 889299
    Checking if vmlinux BTF exists
    Testing perf trace's string augmentation
    String augmentation test failed
    ---- end(-1) ----
    108: perf trace BTF general tests                                    : FAILED!

After:
    $ sudo /tmp/perf test btf -vv
    108: perf trace BTF general tests:
    108: perf trace BTF general tests                                    : Running
    --- start ---
    test child forked, pid 886551
    Checking if vmlinux BTF exists
    Testing perf trace's string augmentation
    String augmentation test failed, output:
    :886566/886566 renameat2(CWD, "/tmp/file1_RcMa", CWD, "/tmp/file2_RcMa", NOREPLACE) = 0---- end(-1) ----
    108: perf trace BTF general tests                                    : FAILED!

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/tests/shell/trace_btf_general.sh | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tests/shell/trace_btf_general.sh
index a25d8744695e..e78e653fc8f1 100755
--- a/tools/perf/tests/shell/trace_btf_general.sh
+++ b/tools/perf/tests/shell/trace_btf_general.sh
@@ -3,7 +3,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 err=0
-set -e
 
 # shellcheck source=lib/probe.sh
 . "$(dirname $0)"/lib/probe.sh
@@ -28,10 +27,10 @@ check_vmlinux() {
 
 trace_test_string() {
   echo "Testing perf trace's string augmentation"
-  if ! perf trace -e renameat* --max-events=1 -- mv ${file1} ${file2} 2>&1 | \
-    grep -q -E "^mv/[0-9]+ renameat(2)?\(.*, \"${file1}\", .*, \"${file2}\", .*\) += +[0-9]+$"
+  output="$(perf trace -e renameat* --max-events=1 -- mv ${file1} ${file2} 2>&1)"
+  if ! echo "$output" | grep -q -E "^mv/[0-9]+ renameat(2)?\(.*, \"${file1}\", .*, \"${file2}\", .*\) += +[0-9]+$"
   then
-    echo "String augmentation test failed"
+    printf "String augmentation test failed, output:\n$output"
     err=1
   fi
 }
@@ -39,20 +38,20 @@ trace_test_string() {
 trace_test_buffer() {
   echo "Testing perf trace's buffer augmentation"
   # echo will insert a newline (\10) at the end of the buffer
-  if ! perf trace -e write --max-events=1 -- echo "${buffer}" 2>&1 | \
-    grep -q -E "^echo/[0-9]+ write\([0-9]+, ${buffer}.*, [0-9]+\) += +[0-9]+$"
+  output="$(perf trace -e write --max-events=1 -- echo "${buffer}" 2>&1)"
+  if ! echo "$output" | grep -q -E "^echo/[0-9]+ write\([0-9]+, ${buffer}.*, [0-9]+\) += +[0-9]+$"
   then
-    echo "Buffer augmentation test failed"
+    printf "Buffer augmentation test failed, output:\n$output"
     err=1
   fi
 }
 
 trace_test_struct_btf() {
   echo "Testing perf trace's struct augmentation"
-  if ! perf trace -e clock_nanosleep --force-btf --max-events=1 -- sleep 1 2>&1 | \
-    grep -q -E "^sleep/[0-9]+ clock_nanosleep\(0, 0, \{1,\}, 0x[0-9a-f]+\) += +[0-9]+$"
+  output="$(perf trace -e clock_nanosleep --force-btf --max-events=1 -- sleep 1 2>&1)"
+  if ! echo "$output" | grep -q -E "^sleep/[0-9]+ clock_nanosleep\(0, 0, \{1,\}, 0x[0-9a-f]+\) += +[0-9]+$"
   then
-    echo "BTF struct augmentation test failed"
+	printf "BTF struct augmentation test failed, output:\n$output"
     err=1
   fi
 }
-- 
2.45.2

