Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA76D14A4C7;
	Fri,  4 Apr 2025 04:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743740218; cv=none; b=GqIUJ+wPDdb7FEVUbCfZcIgIIURM4yzVeeZkoV3S4S0NBRGYpzNHqe5zCwcQh4ESCIO5ymQhf4N0WTywbqVtctJJAGShe/8rdGO/qalulReqzbthUjyglpK36dfQk0VUoppglj6dv7NwKB6N/B/mwS01QxW0M71PWvoXeP+FD6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743740218; c=relaxed/simple;
	bh=y+pQ0N2FyDmDFD1EqNWG0arm7ZC8meGCYxaKT3eCFWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FqihtQBHQ6Y2BhIlxACLGvsJRDVpIV6H6lpiod3PZT/OS7D8bqeaLaLGng0K3MgrUfr5lc2ygNGiUz8tc6Uz1bQP1mBSj2RROEzV1jNDHPkib86iyrS4JZ7xiCZxZepZBS6u78xi5zKlPBLln7MEH3irvqWKnTlh8AWoZYWsiHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XM4PeyfU; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XM4PeyfU"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso1937993b3a.2;
        Thu, 03 Apr 2025 21:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743740216; x=1744345016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m5agAZSfSkx9AY9eawF+jGKK/rmtQCgnrXpeJjF2DZY=;
        b=XM4PeyfUDfXU/BAv+rLpjSZHL4X6HYBLhCqEd5HklNfrWeXXqMcoQP7bq1TewDKtDr
         oX7RvhDkwzfG0i6xuriwWeB4PiBHEiOph3D/yb451JuEiQzSSC67Ru+KZz+2RzKa1XQX
         1TA4RBehLKXI/LpjKh0tycWrOei4GCw2LYxmDq59VSBGvZRlqzu3jTCiZqyte47JEmDF
         m0Y8NI0mhvTGkocLjqzy7M8feDjGF/EKo7/g8cI6Gmcj3YknDuTrvfx9Mk2U6ekv4FQC
         ZfB3xUJXuSLQaC7SEXSEgfdICAZWZtGZWpbtt94PsfcjMYt6LHI01zS1rIItbnMXCxxI
         gitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743740216; x=1744345016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m5agAZSfSkx9AY9eawF+jGKK/rmtQCgnrXpeJjF2DZY=;
        b=vfrg8Y0TiSo2hvzHNRQGysHEwoTcIlCoi2kjjuiCO12AwhCGsZqCXuj/ABCrqh2i+0
         unjPziaB2SA+YnQSlrbZ01mCZ79DSwUyQE4thoW8KKlQ90uhE9OW1bNpzpmOkEB3Y/ky
         hwHIV1y/lPRLJmskHPfDF/C0RzH/uluGdK8A1+ArVp/YUjdy5ZoMub+ZOjxAf4tc/PoP
         wcw5iqidxg3l7UHX26sZ/Hopj+MJc9xVrIOIx7KPAjfFoRdU//0QUdMquYz/kGQLglvJ
         SEAB9ccuiySRAht0QV5VHaQTJFbor89bz0WpALSKRyXNfgpDpjEj/UwGLmAYcTusgYTT
         NMRw==
X-Forwarded-Encrypted: i=1; AJvYcCUZgtu7D92pOHnT1Ooy39s+HfCnUfZYHhFYAPxiIYCjLjxu43Nmovo+fFHo5z4RT2BNUvc8u6BE1uFOaOc=@vger.kernel.org, AJvYcCXc6f0zaYtQL11IP6HQb6ScZmCgPd1JnB0t+FW3HKY/AkqhUWYGvgvtLxprwoJvacl/ynxVsZ+WLb4rnurYJsDkUw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8qiW3AG1RNsziSqGYro8PJNp41xNuKCG2l8PuFcSyDXCmtf/k
	H+zsmeaUb8jcxY8whaHPeR7klkTUZ1U4neR/3179iitpXnlFNGf+
X-Gm-Gg: ASbGncv4sYPt8wVcYiALGRO4CEqmGCsQWL9i3nd1SDSOeIfdIkr3DWyPFL041Nl4q/P
	HAiwflCQeYvaMgc0Ajg+qxalTjMMeW6hkrVmU2U/fJFa0bwkBfYHanrzkZhNOOroMI31rN708RH
	XERv8bP5/DbWreVn+bpJB/J51nbwyYBhCNcHq0mGdYOaiKxQrVanoYVOXgpONnAQRLC1v3Lizcl
	hps7tP9ktaJ85h8DSSCheI6fmvgB2cc2G+QPz6cuGO6+QUukbEQQ1PQ+93N6WX2j+VLEfXzyqh7
	SmGzfVRDhKhe/PpcLytpWiY7EEIGNHB/9dUudNihIUU5H0aMsLHLOOW2cRvCENU6oVeFUNSbf+p
	0RQUP
X-Google-Smtp-Source: AGHT+IEBFglo8zSnDqo8NPVmUw2iSuO6FsxUTQvbgHpZJGKLGRVHiLEibhujjeh38Hlx0NyPFVaEAg==
X-Received: by 2002:a05:6a00:3ccd:b0:736:55ec:ea94 with SMTP id d2e1a72fcca58-739e4c2ee0fmr2714016b3a.20.1743740215755;
        Thu, 03 Apr 2025 21:16:55 -0700 (PDT)
Received: from howard.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97d1810sm2357431b3a.24.2025.04.03.21.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 21:16:55 -0700 (PDT)
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
Subject: [PATCH v1] perf trace: Fix inconsistent failures in perf trace's tests
Date: Thu,  3 Apr 2025 21:16:52 -0700
Message-ID: <20250404041652.329340-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two failures that frequently occur in perf trace's tests. One
is the failure of 'perf trace BTF general tests'; The other one is the
failure of 'perf trace record and replay', which, when run independently,
always succeeds.

The root cause of the first failure, is that perf trace may give two types
of output, depending on whether the comm of a process can be parsed, for
example:

mv/312705 renameat2(CWD, "/tmp/file1_VJOT", CWD, "/tmp/file2_VJOT", NOREPLACE) = 0
:312774/312774 renameat2(CWD, "/tmp/file1_5YcE", CWD, "/tmp/file2_5YcE", NOREPLACE) = 0

In the test, however, grep is always looking for the comm 'mv', which
sometimes may not be present.

The cause of the second failure is that 'perf trace BTF general tests'
modifies the perf config, and because tests are run concurrently,
subsequent tests use the modified perf config before the BTF general
test can restore the original config. Mark the BTF general tests as
exclusive will solve the failure.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
Fixes: 0255338d6975 ("perf trace: Add tests for BTF general augmentation")
---
 tools/perf/tests/shell/trace_btf_general.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tests/shell/trace_btf_general.sh
index a25d8744695e..4833618a116b 100755
--- a/tools/perf/tests/shell/trace_btf_general.sh
+++ b/tools/perf/tests/shell/trace_btf_general.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf trace BTF general tests
+# perf trace BTF general tests (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 err=0
@@ -29,7 +29,7 @@ check_vmlinux() {
 trace_test_string() {
   echo "Testing perf trace's string augmentation"
   if ! perf trace -e renameat* --max-events=1 -- mv ${file1} ${file2} 2>&1 | \
-    grep -q -E "^mv/[0-9]+ renameat(2)?\(.*, \"${file1}\", .*, \"${file2}\", .*\) += +[0-9]+$"
+    grep -q -E "^.*/[0-9]+ renameat(2)?\(.*, \"${file1}\", .*, \"${file2}\", .*\) += +[0-9]+$"
   then
     echo "String augmentation test failed"
     err=1
@@ -40,7 +40,7 @@ trace_test_buffer() {
   echo "Testing perf trace's buffer augmentation"
   # echo will insert a newline (\10) at the end of the buffer
   if ! perf trace -e write --max-events=1 -- echo "${buffer}" 2>&1 | \
-    grep -q -E "^echo/[0-9]+ write\([0-9]+, ${buffer}.*, [0-9]+\) += +[0-9]+$"
+    grep -q -E "^.*/[0-9]+ write\([0-9]+, ${buffer}.*, [0-9]+\) += +[0-9]+$"
   then
     echo "Buffer augmentation test failed"
     err=1
@@ -50,7 +50,7 @@ trace_test_buffer() {
 trace_test_struct_btf() {
   echo "Testing perf trace's struct augmentation"
   if ! perf trace -e clock_nanosleep --force-btf --max-events=1 -- sleep 1 2>&1 | \
-    grep -q -E "^sleep/[0-9]+ clock_nanosleep\(0, 0, \{1,\}, 0x[0-9a-f]+\) += +[0-9]+$"
+    grep -q -E "^.*/[0-9]+ clock_nanosleep\(0, 0, \{1,\}, 0x[0-9a-f]+\) += +[0-9]+$"
   then
     echo "BTF struct augmentation test failed"
     err=1
-- 
2.45.2

