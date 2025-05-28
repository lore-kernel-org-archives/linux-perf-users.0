Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5D621C188;
	Wed, 28 May 2025 19:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748459519; cv=none; b=cT4vOmkxINj7iTBglBwRSQZvrXmFfNItQ6ZmxGjUw82FWmW/W8YmvJ8mD7ztVwYD+TWXHYCIQxkEZF/4btRvcByrDssVIe3ttjXjzhnNiNu9Lu/nMi4Wn0obcJJ2gF6ndqjFXSDyuft63UpfjTTu5ABYRMtyO8D9oG8p6Qc6nRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748459519; c=relaxed/simple;
	bh=pYg8TLTjgS0BjbaSB6NlASqTqqK6Bkw6JNseF6OIUqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bY/96FI+G3xcWBbffOd0/exav4KhBCMCF3wS10dto93U81Osl3xUvF//9r6L3K9na4m1kft4+zC615MnL/l3RDK0aJbK/RUZm9Yxm4fffJRMslBvCorywjYLKd93L9oRNSYi7t0BmUFDfQBvJsPDTF/alNZKtul1OrWvQETkLBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwVnAXpU; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwVnAXpU"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23461842024so2226245ad.0;
        Wed, 28 May 2025 12:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748459517; x=1749064317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gg68t38uPzYyo7Ew0hkP+phW30lhRktPX+3plUsKhsk=;
        b=fwVnAXpUJoB1xVxlMauOuuSYc+PRdvRwSmkU45F5zlj0t808U7gTFIuZ4DspusjWlu
         JoJih/QtFQJA54jsnmPoeBiCg1vHAOE9ghYHYGx4nW3wNrScoxYqkXbN5UmsQTYsaftk
         x+VShgP0+8h6PsO3/jW43hsPOvSDhGeHpv6/BTnQ+CkPJvuKBDtJji2qqQhvxbu/dOia
         W0lPI5y+3FaRxI4sy834wnqWxU2Y5rJVlHhfWNLOIE+YTRCLNNZtPBHULRjJ4+LHgPXK
         GIlPiR4ZDZS5VY7adpwYieIpLxAdvmUe8FqO6hrb3T2NaVs2Vb7RxxAtkpnrcKD8Owjk
         qgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748459517; x=1749064317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gg68t38uPzYyo7Ew0hkP+phW30lhRktPX+3plUsKhsk=;
        b=TnsHOwvxADPmI4/f9W4uX5oAypp3DDLSW7X5w7YJ/BcnquE5VyzvvGPdFfkV9j+9t7
         WyKZgV3O7me6UW5ODHF8pYUWOqu1d8PE0iRjfwcJuiRlxpCkYE1zDraQ33G8axUxomuX
         q2HZhTymLzBCC1O6GjedHkEMa5d2MAXbdZJdZaj3vuuEA0uB6tZRzSfQagU+n5R045Zy
         ZkFunl0+m0jGaJv6eYvbh86uAUy4RK07D+PMYNv9iIOCJqWdVPGAXbVWkWM1ork5SQSO
         IGHAxVgVHbzYl4QLNmcbPJFlHWSDOiM2NPrPgwJ61FLWDYIAhCrOjtoeq4Hzc2YIS7QM
         QYGg==
X-Forwarded-Encrypted: i=1; AJvYcCXew3NSxNwaabr8gv+d8DAeOys+j8NTBSAA+kv+5nLTbHcgyDu3uVmbR88MvERmgegvQ/Zo2BVCVGgbOmg=@vger.kernel.org, AJvYcCXjz15P+REZ0BK3ifz7MV7u2gr7Y8ijO/H8M3OFSq1hmCrSA6fi55be1h4FKSN0Vilx6nUOuCYdcKfEKGxjclAMZg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1zLxxpK96aA9E7T1BEWrEEv36bGmfmKz82VFm7d51p/4E+rPR
	65QemHDWEzUPTJbRhB+UXc1KF62jiRJjgVp2fbBsLR6qDfNcUWT0CYtG
X-Gm-Gg: ASbGnctZ46AlhFCHOeV43uZqCtrWuxJMQK2FDwdgYj48NvUVHejpL7nV/FywAyospQK
	h+/y3gmTZLrXbKMDTWIhxxyp0bb6NXXWBVZvCzzrdpmT9W4OCHvRZnM1akE6DZuv7UzhY9mYxez
	8EzrhwEmi02z1Z/QYOl9IbQOR3DPOjPY5t501nOaOuY0C6K0M+WCJr23phu2vRXQMYPl27OL3hW
	WiQHjiaMufrRR68enQH/IGjA0eY1Q9CYPJoF+LcGzeZlPNhD1UuAftHIpxsoG2bg5skQj+ENN3x
	EDFL1fbWYJAq3fLVh9etGGc8Sx7G7Lfw7stU6+MayucPj+Xf+Vebs563+h5w7DrpLJcd4+/9Qrx
	mqPRz+RZSa5I=
X-Google-Smtp-Source: AGHT+IHg54B8ME0h/66c3zO4zLIROfXSjulX5yjdTcUyOVLMBcGQlPD4gqAX6TXV3N/6wrFFeLtpZQ==
X-Received: by 2002:a17:903:2306:b0:234:e655:a62e with SMTP id d9443c01a7336-234e65635c1mr26256165ad.9.1748459517130;
        Wed, 28 May 2025 12:11:57 -0700 (PDT)
Received: from howard.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ac417sm15172215ad.169.2025.05.28.12.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 12:11:56 -0700 (PDT)
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
Subject: [PATCH v3 4/6] perf test trace: Remove set -e for BTF general tests
Date: Wed, 28 May 2025 12:11:46 -0700
Message-ID: <20250528191148.89118-5-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250528191148.89118-1-howardchu95@gmail.com>
References: <20250528191148.89118-1-howardchu95@gmail.com>
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
index a25d8744695e..5fa50d815203 100755
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
+    printf "String augmentation test failed, output:\n$output\n"
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
+    printf "Buffer augmentation test failed, output:\n$output\n"
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
+	printf "BTF struct augmentation test failed, output:\n$output\n"
     err=1
   fi
 }
-- 
2.45.2

